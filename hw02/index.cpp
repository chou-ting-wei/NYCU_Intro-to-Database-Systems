#include "index.h"

Index::Index(int num_rows, vector<int> key, vector<int> value){
    int cnt = 0;
    while(cnt != num_rows){
        bpt.insert(key[cnt], value[cnt]);
        cnt ++;
    }
}

void Index::key_query(vector<int> query_keys){
    ofstream file ("key_query_out.txt");
    if(file.is_open()){
        for(auto &key : query_keys){ 
            file << bpt.BPTSearch(key) << endl;
        } 
    }
}

void Index::range_query(vector<pii> query_pairs){
    ofstream file("range_query_out.txt");
    if(file.is_open()){
        for(auto &[l, r] : query_pairs){
            file << bpt.range_search(l, r) << endl;
        }
    }
}

void Index::clear_index(){
    bpt.bpt_clear();
}
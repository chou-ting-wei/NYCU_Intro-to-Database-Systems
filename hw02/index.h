#include <iostream>
#include <vector>
#include <fstream>

#define mp make_pair
#define pii pair<int, int>
#define F first
#define S second

#define endl '\n'

using namespace std;

struct Node {
    Node** children;
    Node* parent;
    bool is_leaf;
    size_t deg, size; 
    int* key, *val;

public:
    Node(size_t _deg) {
        this->is_leaf = false;
        this->deg = _deg;
        this->size = 0;

        int* _key = new int[deg - 1];
        int* _val = new int[deg - 1];
        for(int i = 0; i < deg - 1; i ++){
            _key[i] = 0;
            _val[i] = 0;
        }
        this->key = _key;
        this->val = _val;

        Node** _children = new Node*[deg];
        for(int i = 0; i < deg; i ++){
            _children[i] = nullptr;
        }
        this->children = _children;
        this->parent = nullptr;
    }
};

class BPT {
    Node* root;
    size_t deg;

public:
    BPT(size_t _deg) {
        this->root = nullptr;
        this->deg = _deg;
    }
    int BPTSearch(int key){
        Node* node = this->root;
        if(node == nullptr) {
            return -1;
        }
        else{
            Node* tmp = node;

            while(!tmp->is_leaf){ 
                for(int i = 0; i < tmp->size; i ++){ 
                    if(key < tmp->key[i]){ 
                        tmp = tmp->children[i];
                        break;
                    }
                    if(i == (tmp->size) - 1){
                        tmp = tmp->children[i+1];
                        break;
                    }
                }
            }

            for(int i = 0; i < tmp->size; i ++){
                if(tmp->key[i] == key){
                    return tmp->val[i];
                }
            }
            return -1;
        }
    }
    Node* BPTRangeSearch(Node* node, int key){
        if(node == nullptr) { 
            return nullptr;
        }
        else{
            Node* tmp = node; 

            while(!tmp->is_leaf){ 
                for(int i = 0; i < tmp->size; i ++){ 
                    if(key < tmp->key[i]){ 
                        tmp = tmp->children[i];
                        break;
                    }
                    if(i == (tmp->size) - 1){
                        tmp = tmp->children[i+1];
                        break;
                    }
                }
            }
            return tmp;
        }
    }
    int range_search(int start, int end) {
        int cnt = 0;

        Node* start_node = BPTRangeSearch(this->root, start);
        Node* tmp = start_node;
        int tmpit = tmp->key[0];

        int minn = 0;
        while(tmpit <= end){
            if(tmp == nullptr){
                break;
            }
            for(int i = 0; i < tmp->size; i ++){
                tmpit = tmp->key[i];
                if((tmpit >= start) && (tmpit <= end)){
                    if(cnt == 0){
                        minn = tmp->val[i];
                    }
                    else{
                        minn = min(minn, tmp->val[i]);
                    }
                    cnt++;
                }
            }
            tmp = tmp->children[tmp->size];
        }
        if(cnt == 0){
            return -1;
        }
        return minn;
    }

    int find_index(int* arr, int data, int len){
        int index = 0;
        for(int i = 0; i < len; i ++){
            if(data < arr[i]){
                index = i;
                break;
            }
            if(i == len - 1){
                index = len;
                break;
            }
        }
        return index;
    }
    pair<int*, int> key_insert(int* arr, int data, int len){
        int index = 0;
        for(int i = 0; i < len; i++){
            if(data < arr[i]){
                index = i;
                break;
            }
            if(i == len-1){
                index = len;
                break;
            }
        }

        for(int i = len; i > index; i--){
            arr[i] = arr[i-1];
        }

        arr[index] = data;

        return mp(arr, index);
    }
    int* val_insert(int* arr, int data, int index, int len){
        for(int i = len; i > index; i--){
            arr[i] = arr[i-1];
        }

        arr[index] = data;

        return arr;
    }
    Node** child_insert(Node** child_arr, Node*child,int len,int index){
        for(int i = len; i > index; i --){
            child_arr[i] = child_arr[i - 1];
        }
        child_arr[index] = child;
        return child_arr;
    }
    Node* child_key_insert(Node* node, int data, Node* child){
        int key_index=0;
        int child_index=0;
        for(int i = 0; i < node->size; i ++){
            if(data < node->key[i]){
                key_index = i;
                child_index = i+1;
                break;
            }
            if(i == node->size - 1){
                key_index = node->size;
                child_index = node->size + 1;
                break;
            }
        }
        for(int i = node->size; i > key_index; i --){
            node->key[i] = node->key[i - 1];
        }
        for(int i = node->size + 1; i > child_index; i --){
            node->children[i] = node->children[i - 1];
        }

        node->key[key_index] = data;
        node->children[child_index] = child;

        return node;
    }
    void InsertPar(Node* par, Node* child, int data){
        Node* tmp = par;
        if(tmp->size < this->deg - 1){
            tmp = child_key_insert(tmp, data, child);
            tmp->size ++;
        }
        else{
            auto* Newnode = new Node(this->deg);
            Newnode->parent = tmp->parent;

            int* key_copy = new int[tmp->size + 1];
            for(int i = 0; i < tmp->size; i ++){
                key_copy[i] = tmp->key[i];
            }
            key_copy = key_insert(key_copy, data, tmp->size).F;

            auto** child_copy = new Node*[tmp->size + 2];
            for(int i = 0; i < tmp->size + 1; i ++){
                child_copy[i] = tmp->children[i];
            }
            child_copy[tmp->size + 1] = nullptr;
            child_copy = child_insert(child_copy, child, tmp->size + 1, find_index(key_copy, data, tmp->size + 1));

            tmp->size = (this->deg) / 2;
            if((this->deg) % 2 == 0){
                Newnode->size = (this->deg) / 2 - 1;
            }
            else{
                Newnode->size = (this->deg) / 2;
            }

            for(int i = 0; i < tmp->size; i ++){
                tmp->key[i] = key_copy[i];
                tmp->children[i] = child_copy[i];
            }
            tmp->children[tmp->size] = child_copy[tmp->size];

            for(int i = 0; i < Newnode->size; i ++){
                Newnode->key[i] = key_copy[tmp->size + i + 1];
                Newnode->children[i] = child_copy[tmp->size + i + 1];
                Newnode->children[i]->parent = Newnode;
            }
            Newnode->children[Newnode->size] = child_copy[tmp->size + Newnode->size + 1];
            Newnode->children[Newnode->size]->parent = Newnode;

            int parkey = key_copy[this->deg / 2];

            delete[] key_copy;
            delete[] child_copy;

            if(tmp->parent == nullptr){
                auto* Newparent = new Node(this->deg);
                tmp->parent = Newparent;
                Newnode->parent = Newparent;

                Newparent->key[0] = parkey;
                Newparent->size ++;

                Newparent->children[0] = tmp;
                Newparent->children[1] = Newnode;

                this->root = Newparent;
            }
            else{
                InsertPar(tmp->parent, Newnode, parkey);
            }
        }
    }
    void insert(int data, int val) {
        if(this->root == nullptr){
            this->root = new Node(this->deg);
            this->root->is_leaf = true;
            this->root->key[0] = data;
            this->root->val[0] = val;
            this->root->size = 1;
        }
        else{
            Node* tmp = this->root;
            tmp = BPTRangeSearch(tmp, data);

            if(tmp->size < (this->deg - 1)){ 
                pair<int*, int> tmpit = key_insert(tmp->key, data, tmp->size);
                tmp->key = tmpit.F;
                tmp->val = val_insert(tmp->val, val, tmpit.S, tmp->size);
                tmp->size++;

                tmp->children[tmp->size] = tmp->children[tmp->size - 1];
                tmp->children[tmp->size - 1] = nullptr;
            }
            else{
                auto* Newnode = new Node(this->deg);
                Newnode->is_leaf = true;
                Newnode->parent = tmp->parent;

                int* key_copy = new int[tmp->size + 1];
                for(int i = 0; i < tmp->size; i ++){
                    key_copy[i] = tmp->key[i];
                }
                int* val_copy = new int[tmp->size + 1];
                for(int i = 0; i < tmp->size; i ++){
                    val_copy[i] = tmp->val[i];
                }

                pair<int*, int> tmpit = key_insert(key_copy, data, tmp->size);
                key_copy = tmpit.F;
                val_copy = val_insert(val_copy, val, tmpit.S, tmp->size);

                tmp->size = (this->deg) / 2;
                if((this->deg) % 2 == 0){
                    Newnode->size = (this->deg) / 2;
                }
                else{
                    Newnode->size = (this->deg) / 2 + 1;
                }

                for(int i = 0; i < tmp->size; i ++){
                    tmp->key[i] = key_copy[i];
                    tmp->val[i] = val_copy[i];
                }
                for(int i = 0; i < Newnode->size; i ++){
                    Newnode->key[i] = key_copy[tmp->size + i];
                    Newnode->val[i] = val_copy[tmp->size + i];
                }

                tmp->children[tmp->size] = Newnode;
                Newnode->children[Newnode->size] = tmp->children[this->deg - 1];
                tmp->children[this->deg - 1] = nullptr;

                delete[] key_copy;
                delete[] val_copy;

                int parkey = Newnode->key[0];

                if(tmp->parent == nullptr){
                    auto* Newparent = new Node(this->deg);
                    tmp->parent = Newparent;
                    Newnode->parent = Newparent;

                    Newparent->key[0] = parkey;
                    Newparent->size ++;

                    Newparent->children[0] = tmp;
                    Newparent->children[1] = Newnode;

                    this->root = Newparent;
                }
                else{
                    InsertPar(tmp->parent, Newnode, parkey);
                }
            }
        }
    }
    void bpt_clear() {
        clear(this->root);
    }
    void clear(Node* node){
        if(node != nullptr){
            if(!node->is_leaf){
                for(int i = 0; i <= node->size; i ++){
                    clear(node->children[i]);
                }
            }
            delete[] node->key;
            delete[] node->val;
            delete[] node->children;
            delete node;
        }
    }
};

class Index{
    BPT bpt = BPT(15);
    
    public:
        Index(int, vector<int>, vector<int>);
        void key_query(vector<int>);
        void range_query(vector<pii>);
        void clear_index(void);
};


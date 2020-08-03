# ansible-terraform

## 狙い
 - Terraformを用いたクラウドリソース構築
 - Ansibleを用いたEC2の設定変更
 
## 工夫したポイント
 - AnsibleからTerraformを実行することで、インターフェースをAnsibleに一本化。
 - Ansible実行で、クラウドリソースからEC2の設定までの一連の作業を自動化
 
## フォルダ構成
![image](https://user-images.githubusercontent.com/28664816/89120369-c88aca80-d4f0-11ea-9231-bbf6b33429e2.png)
 
## 作成リソース
![04](https://user-images.githubusercontent.com/28664816/89118541-55c62300-d4e1-11ea-9f59-29c440bd6ae6.jpg)

## 利用
- Ansible 2.9.9
- Terraform v0.12.29
- boto 2.49.0

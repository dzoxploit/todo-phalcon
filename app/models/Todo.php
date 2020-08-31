<?php
namespace Application\Models;

class Todo extends \Phalcon\Mvc\Model {

   public $id; 
   public $timestamp; 
   public $message; 

   public function getSource() {
      return 'transaksi';
   }  
   
   public static function find($parameters = null) { 
      return parent::find($parameters);
   }
   
   public static function findFirst($parameters = null) {
      return parent::findFirst($parameters);
   } 
}
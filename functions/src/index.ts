import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const ref = admin.firestore().collection('learning-management/v1/developers/')
const increment = admin.firestore.FieldValue.increment(1);
const decrement = admin.firestore.FieldValue.increment(-1);


exports.incrementNumOfMaterials = functions.region('asia-northeast1').firestore
    .document('learning-management/{v1}/users/{userId}/materials/{materialId}')
    .onCreate((create, context) => {

        ref.doc(context.params.userId).update({ 'numOfMaterials': increment });

        return 0;
    });

exports.decrementNumOfMaterials = functions.region('asia-northeast1').firestore
    .document('learning-management/{v1}/users/{userId}/materials/{materialId}')
    .onDelete((create, context) => {

        ref.doc(context.params.userId).update({ 'numOfMaterials': decrement });

        return 0;
    });

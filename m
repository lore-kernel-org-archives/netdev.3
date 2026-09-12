Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023237C916
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203890; cv=none; b=ZloIJD5hGmdZj9S2lmJDR/c8VWT2vNcvku14MqrPEGgSSDaY5FDS/GKyEGWz0d2gaV95WS1SxZzPj4Cl0F9cqC4WptLlF8EfhnPsFKPccL5wAKW24/+4VO/7ck6JmSqfsBOPQ2e0tbUal0BFhkT2wBjjKGBUR7seHf6pWcHo88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203890; c=relaxed/simple;
	bh=T2GpveXf86xU4PJdOWIIi5lBw5gHgOvqTYsANeAQESM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPOz0CtlseDCamN0l0FR+esBTk3gRqCWQpK/vblQaB791FUKAiHLUi6HS0y2G7GwCBN6PgbSjjkrtR401EUazCBdzLE78THc6HNuGhanqVIeZ2mt/kbUSge+do03rMzydqEvDXNT7fBmnPiVFDtz4g0Rbd8c6JrTLpgzx6f/cXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqbLTT9J; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqbLTT9J"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so8959405ad.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789203888; x=1789808688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i5SaSEoCo9RleDHysc9IxVyTl6w7IzP28iEqT/KO1Rk=;
        b=kqbLTT9JTLyQIoa+DfxYHVB3Jc2De4iPTrYPsf9c0C3rFuVlfoCC5MP1EO/hlV5U3Q
         Gsx9UTTI8fGOT0rMXX0VWCgon5dKgM8g1W0slKMn56QLJCaypjrPZS09okkb6P9AkpnY
         lE1Oa1o9KQNQQz1KfIO1SiWUYlxhAv2MEq6EwU6qDEhRK4OskN7jmm6+l+6dZLCuL7fn
         jk081qsUNRpqCykNU2Tq0e96fLELWoebdBgIkSsSLGgpqrqYB9AIK+hJKP05S8quOzGO
         szQsJ686ubH2H8cLlcItJw12GHe5u9GsbxkWaxg4HRcUggL2Iyrn2uPA7MNJQNihm/t0
         PRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203888; x=1789808688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i5SaSEoCo9RleDHysc9IxVyTl6w7IzP28iEqT/KO1Rk=;
        b=o9vMny4R3QPZrPhxmIg/yA5ERkbQGyv0JMsxVctVPE9QNqfNN//jhDauakA3Ec3k6N
         sHp1SIj/ERGZlC4KFFBgvU28CiOP/U58qecQIyMya4Bc2WkIiUhFG/VyCemZBnSueaUr
         GWTXJI3oM/26QfXWc2sAKIVBq5apFlAANB96W+uKq7picjE6/pEOYQaN3E4tMwY8Rnkh
         AQEnm5GHNgaVZv1kzUsSN4eKbguXPqmCpfT2ZkiYw/0mPwhoZHXUD5jYDg8v9Kx/h6XD
         FQ56TxYZRzIX6vEuhrGEoWhI2ib4GrZ1RxVqkunp/7kaLTOzwkZSa8oVYWXyOhKVYYOI
         e32A==
X-Forwarded-Encrypted: i=1; AKwUvByQ2tyEvsdx2SSKglW5eUZtt/seiSri5A7Uyza/1GzpHS1t5/Z2wq5ZZWDWOUSydMVZKRyOkNY=@vger.kernel.org
X-Gm-Message-State: AFuF++lhwtt2NSTxMrYpBwAw2jkq+U90BgqyazIQdMt82Nnx94MxmMEb
	BzsHHnMo8DRW3j9zPY3c/WbcoJjqc1S6JG3/zIa6XPUWqxbbk/vocodK
X-Gm-Gg: AYBFou38lbx+P0oji2F+TCX0HcqN4SMwxERdw6+L0ehA0J9BF0IOh1ZvW16OAPeAzXG
	osrZ10lpnYXjRP1nuiqZMX8OY5YyLD4L6c7hguIJ16upFo3PyCu8GulRtLInT5QLB1vxX4PO8BM
	LX4WLseV8VB1LWVfbb1jknyOD3Jc2lr8tRzB96SDooy3eRtHOf0fuZvDqekiIcJ5EOEzQj1QEI9
	7dE9ghMyPKPk51+sqXIGB1fsA1bhl1vcbjDJUwwPPVp7mQXBnVR9cih5Ls8JRTNsnkMb+ouvjF2
	oYJm3LecfH5GhGtxIimsd2SVlm37v8eMargaI+lXmWk5yOp7aC1eYpcCnJA3PXXBPbWbQNIvpUL
	moj+V92wdiaEUZEmD4388a5J2T43SlXdOMTELnenA1wXWdehWJdOK81oc9pR8tXZKIqW4GDrgBT
	0TVwE9kzTfQUbw/l1NwgM61mll1HvSaic5UlteFLFqA6O1F+Nu7lAkkvGdY4fVdYQQXFRd3uw=
X-Received: by 2002:a17:90b:5246:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39d9bc67660mr14176109a91.1.1789203888155;
        Sat, 12 Sep 2026 02:04:48 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f7390csm12345338eec.26.2026.09.12.02.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 02:04:47 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-scsi: do not relock event vq mutex on send_evt fallback
Date: Sat, 12 Sep 2026 17:04:20 +0800
Message-Id: <20260912090420.47439-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_send_evt() is called with the event virtqueue mutex held.
If the worker is gone, the fallback currently calls
vhost_scsi_complete_events(), which tries to acquire the same mutex again
and deadlocks the caller.

Split event completion into a helper for callers that already hold the
mutex and a locking wrapper for the event worker. Use the helper on the
fallback path.

Link: https://lore.kernel.org/all/20260905005352.1E5B01F00A3D@smtp.kernel.org/
Fixes: b1b2ce58ed23 ("vhost-scsi: Handle vhost_vq_work_queue failures for events")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Sashiko AI flagged this while reviewing
the vhost-scsi event queue fix.
This is a pre-existing self-deadlock. It was reproduced in a follow-up test.

Trigger: vq->worker == NULL. vhost_vq_work_queue() then returns false,
and a subsequent vhost_scsi_do_plug() call deadlocks. I do not know what
normal condition gets us here; the normal vhost-scsi worker detach/reset
paths do not reach this code. The only reproduction I could come up with
was killing the vhost-scsi worker. This still looks like a low-probability
condition.

 drivers/vhost/scsi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7a1f39a32..7c905e9ad 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -630,19 +630,26 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
 	vhost_scsi_log_write(vq, vq_log, log_num);
 }
 
-static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
+/* Caller must hold the event virtqueue mutex. */
+static void __vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
 {
-	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
 	struct vhost_scsi_evt *evt, *t;
 	struct llist_node *llnode;
 
-	mutex_lock(&vq->mutex);
 	llnode = llist_del_all(&vs->vs_event_list);
 	llist_for_each_entry_safe(evt, t, llnode, list) {
 		if (!drop)
 			vhost_scsi_do_evt_work(vs, evt);
 		vhost_scsi_free_evt(vs, evt);
 	}
+}
+
+static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
+{
+	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
+
+	mutex_lock(&vq->mutex);
+	__vhost_scsi_complete_events(vs, drop);
 	mutex_unlock(&vq->mutex);
 }
 
@@ -1829,7 +1836,7 @@ vhost_scsi_send_evt(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 
 	llist_add(&evt->list, &vs->vs_event_list);
 	if (!vhost_vq_work_queue(vq, &vs->vs_event_work))
-		vhost_scsi_complete_events(vs, true);
+		__vhost_scsi_complete_events(vs, true);
 }
 
 static void vhost_scsi_evt_handle_kick(struct vhost_work *work)

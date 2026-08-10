Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12B3A8722
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367029; cv=none; b=mvLgWnGhNlXOlGhEzB0RRh2Ocwou3kLDEsd7xj681WeGiGe4flgtYinhY9Qk3LRmVl/4B/6QAYw3XxH0viKhmlLOsboT+FRvLfHHajhDIQQ1gbAEDBEybEdXF4TDk+VQ7ttqrkxwDogO55XWWXzqaF3PoCdktJ4tomQQrPHmAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367029; c=relaxed/simple;
	bh=tZDVuI1+nOgrIJX2ah7ULFc1onH4GjdEAhluN48XPCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PkVdZ1Ik6TsAYFeuCJq7N3CsUNmx7SEJs6GnvAzpuCUHLaFG5AB89scXt81WemBnpEE+Lz7k2sxuAe7xVAkXo226FOf3erXTHBdd7TjOa1jkUMfduaQPD3l4+j3rivQ6AZq3AHPNpFgX17O1KxG5IBtC+KXVm+oAyjHdNHGc7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2gW/G3d; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2gW/G3d"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso1551488a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367026; x=1786971826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wjK2un9kfRWHjYtyavLLg8BBXPE1GaOAyEj5MUCthDg=;
        b=S2gW/G3d/vUDyy1qUKvZ42L5Nz0Q7CsHck98ExiI+KWeiTOKp6lpS/ik+MEKQVIalz
         YUERMHPOG+AXnZDJE0a/4OalVCQnoXAWeF/dzpa0ihYz04d9Z3aMi2twcCRqZAmAIKwl
         qMgWpX1nALHqhyGwj0EL9Dcmnd/S6sKf5vVbCtrrrjQbXxyqAqdZibdxJ53OYbQqmG9c
         p14DN/Ky/byj4w8tdjq7+NWfldssjFVEgLlgvMwH0FqFs/mRU1McrqAnJKEjT3gm2cun
         cMuaBeuvK0d48IvXgLXb7r/iWoVlzkDe/TyE+wKKW8uBEfONqoAPF3MWYF6ChsD59X/1
         q/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367026; x=1786971826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wjK2un9kfRWHjYtyavLLg8BBXPE1GaOAyEj5MUCthDg=;
        b=WVhVaWbbH8K99xC9MbSfcvQLbwy4AtT8uGrLeWDDmWim3wToeyA7MhRrC1zds8FKvI
         GUogICNCoIHp482N+m9bylrmwI3jI8sys93eqljgqi/wwZDDyZ+d3Hx+hQhdjoh1JDpR
         eUQApEC9sqbItAv2FtQ4UVfqlP0Occ8gb5T8K4eFlQPywstfvNnB+EPl10gTwt0hbCZV
         k4zC0R7ajjwJ5r9CyTz2EOoN4ZvVomgEiUSkdgJDyzwMJFyeHVLuVoov1kShmbuFbd72
         cAVSJGK5egco6gqJopntd718r5hVnqJOka9NTokHIxb8DlEgAgywS4w0f73cb7XgFBts
         mQ/A==
X-Forwarded-Encrypted: i=1; AHgh+RqOiouxavvqpqTOCcqWbFCtu+LSbYlnSbvHGAgu6tThbzMK+P3SYR3I/HXU5CTpQyfdz65OyaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gszlud0RDNAexB15g/IRxXH4I2oF9wL0LjlK4BSVsioUrLaK
	IAsakJD/eLsBlSekvxtmhsjsHL+Zxtxt1CxbL0+mYZI5H3drFY4PcLUx
X-Gm-Gg: AR+sD1246XsWOzWPU9JFN4wNDHZ2fsUz+n85bXB2BQvnvUt/16sE52n25wpBi7EiOqV
	sCuTp+YlTCYpG2wlCbMfU4ZqZ/GVnRyFJTMfXgAArxJtgcP6P7skMWSIzJevAOmLVSlUYZogxVm
	Vd8GVx/sON6XGmLaIskiZnl0rV0m7eq9m6Kls1tAjyZIu9ewc1VB8Uh+HpqxvCzE12VmLrjOSR6
	J6efl0OL3svnFlaVYEMZm38bS5exiglMWEnxhRSqYiQGahPB9hJTjISWaazmRgDhSVa7HA+WSGJ
	DdkXHDjWY3aXmKObfGx1DY2h6G33wbKpNLhXS/vCNnqX3ESOMmm61uCB2NDX5FuGeYKfP81bM1Y
	V23tZOG6zdzgNiXbgrN9bYiXQMD/cbWW5Oj34Z+NlPZ+EPInOjld2AuwgzFKM8lbQ89sprk00Iq
	DEj6IZ897WDP16e8lha3sUbHxsx09LpjUzOqFaNSaWfH8vf9FGAzK5P2EFIOIVs6h73LxxBwxR5
	w==
X-Received: by 2002:a05:6a20:6f8d:b0:3bf:d487:4b42 with SMTP id adf61e73a8af0-3cc1a435dd8mr2039642637.35.1786367025171;
        Mon, 10 Aug 2026 06:03:45 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebee8d0sm41034378eec.24.2026.08.10.06.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:03:44 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2] vhost: coalesce and retry IOTLB miss messages
Date: Mon, 10 Aug 2026 21:03:36 +0800
Message-Id: <20260810130336.138457-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_iotlb_miss() allocates a message for every translation miss.
Repeated kicks can therefore grow read_list or pending_list without
bound when userspace stops consuming or resolving MISS messages.

Keep one core-generated MISS node per virtqueue and rewrite it when
the queue reports a different IOVA, permission, or message format.
Repeated misses for the same request are coalesced.

A tracked node remains on read_list or pending_list for its whole
lifetime. The read path snapshots the fixed-size message under
iotlb_lock before copying it to userspace. A READING state lets
another kick republish the same node if the userspace copy stalls,
while a per-VQ sequence prevents an old copy from rolling back a
rewritten or recycled node.

Resolve tracked misses only when an UPDATE covers both the IOVA and
requested permission. Clear tracking together with list removal, and
republish outstanding misses when the device IOTLB is replaced while
all VQs are locked. Untracked messages keep the existing
read-to-pending behavior.

This bounds core-generated outstanding MISS nodes by the number of
virtqueues without a global limit or wait list. The normal IOTLB-hit
data path is unchanged.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Changes in v2:
- replace the device-wide limit and wait list with one tracked node per VQ
- keep tracked nodes linked while copying a stack snapshot to userspace
- add a sequence and READING state so stalled copies can be superseded safely
- preserve the original untracked message flow
- handle VHOST_IOTLB_MSG and VHOST_IOTLB_MSG_V2 layouts, including their
  32-bit offsets
- require UPDATE permissions to cover the requested MISS permissions
- republish tracked misses when replacing the device IOTLB

 drivers/vhost/vhost.c | 259 ++++++++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h |   6 +
 2 files changed, 244 insertions(+), 21 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2f2c45d20883..cda5c350d9be 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -34,6 +34,13 @@
 
 #include "vhost.h"
 
+enum vhost_iotlb_miss_state {
+	VHOST_IOTLB_MISS_NONE,
+	VHOST_IOTLB_MISS_READ,
+	VHOST_IOTLB_MISS_READING,
+	VHOST_IOTLB_MISS_PENDING,
+};
+
 static ushort max_mem_regions = 64;
 module_param(max_mem_regions, ushort, 0444);
 MODULE_PARM_DESC(max_mem_regions,
@@ -613,6 +620,9 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->heads = NULL;
 		vq->nheads = NULL;
 		vq->dev = dev;
+		vq->iotlb_miss_state = VHOST_IOTLB_MISS_NONE;
+		vq->iotlb_miss_seq = 0;
+		vq->iotlb_miss_node = NULL;
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
@@ -1177,6 +1187,20 @@ void vhost_dev_stop(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_stop);
 
+static void vhost_untrack_iotlb_miss(struct vhost_msg_node *node)
+{
+	struct vhost_virtqueue *vq = node->vq;
+
+	lockdep_assert_held(&vq->dev->iotlb_lock);
+
+	if (vq->iotlb_miss_node != node)
+		return;
+
+	vq->iotlb_miss_node = NULL;
+	vq->iotlb_miss_state = VHOST_IOTLB_MISS_NONE;
+	vq->iotlb_miss_seq++;
+}
+
 void vhost_clear_msg(struct vhost_dev *dev)
 {
 	struct vhost_msg_node *node, *n;
@@ -1184,12 +1208,14 @@ void vhost_clear_msg(struct vhost_dev *dev)
 	spin_lock(&dev->iotlb_lock);
 
 	list_for_each_entry_safe(node, n, &dev->read_list, node) {
-		list_del(&node->node);
+		list_del_init(&node->node);
+		vhost_untrack_iotlb_miss(node);
 		kfree(node);
 	}
 
 	list_for_each_entry_safe(node, n, &dev->pending_list, node) {
-		list_del(&node->node);
+		list_del_init(&node->node);
+		vhost_untrack_iotlb_miss(node);
 		kfree(node);
 	}
 
@@ -1582,20 +1608,73 @@ static inline int vhost_get_desc(struct vhost_virtqueue *vq,
 	return vhost_copy_from_user(vq, desc, vq->desc + idx, sizeof(*desc));
 }
 
+static struct vhost_iotlb_msg *
+vhost_get_iotlb_msg(struct vhost_msg_node *node)
+{
+	if (node->msg.type == VHOST_IOTLB_MSG_V2)
+		return &node->msg_v2.iotlb;
+
+	return &node->msg.iotlb;
+}
+
+static void vhost_set_iotlb_miss(struct vhost_msg_node *node, bool v2,
+				 u64 iova, int access)
+{
+	struct vhost_iotlb_msg *msg;
+	u32 type = v2 ? VHOST_IOTLB_MSG_V2 : VHOST_IOTLB_MSG;
+
+	if (node->msg.type != type)
+		memset(&node->msg_v2, 0, sizeof(node->msg_v2));
+	node->msg.type = type;
+	msg = vhost_get_iotlb_msg(node);
+
+	msg->type = VHOST_IOTLB_MISS;
+	msg->iova = iova;
+	msg->perm = access;
+}
+
+static bool vhost_iotlb_update_covers(struct vhost_iotlb_msg *update,
+				      struct vhost_iotlb_msg *miss)
+{
+	return miss->type == VHOST_IOTLB_MISS &&
+	       update->iova <= miss->iova &&
+	       miss->iova - update->iova < update->size &&
+	       (update->perm & miss->perm) == miss->perm;
+}
+
 static void vhost_iotlb_notify_vq(struct vhost_dev *d,
 				  struct vhost_iotlb_msg *msg)
 {
 	struct vhost_msg_node *node, *n;
+	int i;
 
 	spin_lock(&d->iotlb_lock);
 
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		node = vq->iotlb_miss_node;
+		if (!node ||
+		    !vhost_iotlb_update_covers(msg,
+					       vhost_get_iotlb_msg(node)))
+			continue;
+
+		list_del_init(&node->node);
+		vhost_untrack_iotlb_miss(node);
+		vhost_poll_queue(&vq->poll);
+		kfree(node);
+	}
+
 	list_for_each_entry_safe(node, n, &d->pending_list, node) {
 		struct vhost_iotlb_msg *vq_msg = &node->msg.iotlb;
+
+		if (node->vq->iotlb_miss_node == node)
+			continue;
 		if (msg->iova <= vq_msg->iova &&
 		    msg->iova + msg->size - 1 >= vq_msg->iova &&
 		    vq_msg->type == VHOST_IOTLB_MISS) {
 			vhost_poll_queue(&node->vq->poll);
-			list_del(&node->node);
+			list_del_init(&node->node);
 			kfree(node);
 		}
 	}
@@ -1752,9 +1831,18 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock)
 {
 	DEFINE_WAIT(wait);
-	struct vhost_msg_node *node;
+	union {
+		struct vhost_msg msg;
+		struct vhost_msg_v2 msg_v2;
+	} snapshot;
+	struct vhost_msg_node *miss_token = NULL;
+	struct vhost_virtqueue *miss_vq = NULL;
+	struct vhost_msg_node *node = NULL;
+	u64 miss_seq = 0;
 	ssize_t ret = 0;
 	unsigned size = sizeof(struct vhost_msg);
+	bool short_buffer = false;
+	bool wake = false;
 
 	if (iov_iter_count(to) < size)
 		return 0;
@@ -1764,8 +1852,36 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			prepare_to_wait(&dev->wait, &wait,
 					TASK_INTERRUPTIBLE);
 
-		node = vhost_dequeue_msg(dev, &dev->read_list);
-		if (node)
+		spin_lock(&dev->iotlb_lock);
+		if (!list_empty(&dev->read_list)) {
+			struct vhost_msg_node *first;
+
+			first = list_first_entry(&dev->read_list,
+						 struct vhost_msg_node, node);
+			if (first->vq->iotlb_miss_node == first) {
+				size = first->msg.type == VHOST_IOTLB_MSG_V2 ?
+				       sizeof(first->msg_v2) : sizeof(first->msg);
+				if (iov_iter_count(to) < size) {
+					short_buffer = true;
+				} else {
+					memcpy(&snapshot.msg_v2, &first->msg_v2,
+					       size);
+					list_move_tail(&first->node,
+						       &dev->pending_list);
+					first->vq->iotlb_miss_state =
+						VHOST_IOTLB_MISS_READING;
+					miss_vq = first->vq;
+					miss_token = first;
+					miss_seq = first->vq->iotlb_miss_seq;
+				}
+			} else {
+				list_del_init(&first->node);
+				node = first;
+			}
+		}
+		spin_unlock(&dev->iotlb_lock);
+
+		if (node || miss_vq || short_buffer)
 			break;
 		if (noblock) {
 			ret = -EAGAIN;
@@ -1786,6 +1902,34 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 	if (!noblock)
 		finish_wait(&dev->wait, &wait);
 
+	if (short_buffer)
+		return 0;
+
+	if (miss_vq) {
+		bool copied = copy_to_iter_full(&snapshot.msg_v2, size, to);
+
+		spin_lock(&dev->iotlb_lock);
+		node = miss_vq->iotlb_miss_node;
+		if (node == miss_token &&
+		    miss_vq->iotlb_miss_seq == miss_seq &&
+		    miss_vq->iotlb_miss_state == VHOST_IOTLB_MISS_READING) {
+			if (copied) {
+				miss_vq->iotlb_miss_state =
+					VHOST_IOTLB_MISS_PENDING;
+			} else {
+				list_move_tail(&node->node, &dev->read_list);
+				miss_vq->iotlb_miss_state = VHOST_IOTLB_MISS_READ;
+				wake = true;
+			}
+		}
+		spin_unlock(&dev->iotlb_lock);
+
+		if (wake)
+			wake_up_interruptible_poll(&dev->wait,
+						   EPOLLIN | EPOLLRDNORM);
+		return copied ? size : -EFAULT;
+	}
+
 	if (node) {
 		struct vhost_iotlb_msg *msg;
 		void *start = &node->msg;
@@ -1816,29 +1960,69 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 }
 EXPORT_SYMBOL_GPL(vhost_chr_read_iter);
 
+static bool vhost_iotlb_miss_coalesce(struct vhost_virtqueue *vq, bool v2,
+				      u64 iova, int access, bool *wake)
+{
+	struct vhost_msg_node *node = vq->iotlb_miss_node;
+	struct vhost_iotlb_msg *msg;
+	u32 type = v2 ? VHOST_IOTLB_MSG_V2 : VHOST_IOTLB_MSG;
+	bool same;
+
+	lockdep_assert_held(&vq->dev->iotlb_lock);
+
+	if (!node)
+		return false;
+
+	msg = vhost_get_iotlb_msg(node);
+	same = node->msg.type == type && msg->type == VHOST_IOTLB_MISS &&
+	       msg->iova == iova && msg->perm == access;
+	if (same && vq->iotlb_miss_state != VHOST_IOTLB_MISS_READING)
+		return true;
+
+	if (!same)
+		vhost_set_iotlb_miss(node, v2, iova, access);
+	vq->iotlb_miss_seq++;
+	if (vq->iotlb_miss_state != VHOST_IOTLB_MISS_READ) {
+		list_move_tail(&node->node, &vq->dev->read_list);
+		vq->iotlb_miss_state = VHOST_IOTLB_MISS_READ;
+		*wake = true;
+	}
+
+	return true;
+}
+
 static int vhost_iotlb_miss(struct vhost_virtqueue *vq, u64 iova, int access)
 {
 	struct vhost_dev *dev = vq->dev;
 	struct vhost_msg_node *node;
-	struct vhost_iotlb_msg *msg;
 	bool v2 = vhost_backend_has_feature(vq, VHOST_BACKEND_F_IOTLB_MSG_V2);
+	bool wake = false;
+
+	lockdep_assert_held(&vq->mutex);
+
+	spin_lock(&dev->iotlb_lock);
+	if (vhost_iotlb_miss_coalesce(vq, v2, iova, access, &wake)) {
+		spin_unlock(&dev->iotlb_lock);
+		if (wake)
+			wake_up_interruptible_poll(&dev->wait,
+						   EPOLLIN | EPOLLRDNORM);
+		return 0;
+	}
+	spin_unlock(&dev->iotlb_lock);
 
 	node = vhost_new_msg(vq, v2 ? VHOST_IOTLB_MSG_V2 : VHOST_IOTLB_MSG);
 	if (!node)
 		return -ENOMEM;
+	vhost_set_iotlb_miss(node, v2, iova, access);
 
-	if (v2) {
-		node->msg_v2.type = VHOST_IOTLB_MSG_V2;
-		msg = &node->msg_v2.iotlb;
-	} else {
-		msg = &node->msg.iotlb;
-	}
-
-	msg->type = VHOST_IOTLB_MISS;
-	msg->iova = iova;
-	msg->perm = access;
+	spin_lock(&dev->iotlb_lock);
+	vq->iotlb_miss_node = node;
+	vq->iotlb_miss_state = VHOST_IOTLB_MISS_READ;
+	vq->iotlb_miss_seq++;
+	list_add_tail(&node->node, &dev->read_list);
+	spin_unlock(&dev->iotlb_lock);
 
-	vhost_enqueue_msg(dev, &dev->read_list, node);
+	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
 
 	return 0;
 }
@@ -2267,27 +2451,59 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
+static bool vhost_retry_iotlb_misses(struct vhost_dev *d)
+{
+	bool wake = false;
+	int i;
+
+	lockdep_assert_held(&d->iotlb_lock);
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+		struct vhost_msg_node *node = vq->iotlb_miss_node;
+
+		if (!node)
+			continue;
+
+		vq->iotlb_miss_seq++;
+		if (vq->iotlb_miss_state != VHOST_IOTLB_MISS_READ)
+			list_move_tail(&node->node, &d->read_list);
+		vq->iotlb_miss_state = VHOST_IOTLB_MISS_READ;
+		wake = true;
+	}
+
+	return wake;
+}
+
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
+	bool wake;
 	int i;
 
 	niotlb = iotlb_alloc();
 	if (!niotlb)
 		return -ENOMEM;
 
+	vhost_dev_lock_vqs(d);
 	oiotlb = d->iotlb;
 	d->iotlb = niotlb;
 
 	for (i = 0; i < d->nvqs; ++i) {
 		struct vhost_virtqueue *vq = d->vqs[i];
 
-		mutex_lock(&vq->mutex);
 		vq->iotlb = niotlb;
 		__vhost_vq_meta_reset(vq);
-		mutex_unlock(&vq->mutex);
 	}
 
+	spin_lock(&d->iotlb_lock);
+	wake = vhost_retry_iotlb_misses(d);
+	spin_unlock(&d->iotlb_lock);
+	vhost_dev_unlock_vqs(d);
+
+	if (wake)
+		wake_up_interruptible_poll(&d->wait,
+					   EPOLLIN | EPOLLRDNORM);
 	vhost_iotlb_free(oiotlb);
 
 	return 0;
@@ -3297,7 +3513,8 @@ struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 	if (!list_empty(head)) {
 		node = list_first_entry(head, struct vhost_msg_node,
 					node);
-		list_del(&node->node);
+		list_del_init(&node->node);
+		vhost_untrack_iotlb_miss(node);
 	}
 	spin_unlock(&dev->iotlb_lock);
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..50fccc85d594 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -29,6 +29,7 @@ struct vhost_work {
 
 struct vhost_worker;
 struct vhost_dev;
+struct vhost_msg_node;
 
 struct vhost_worker_ops {
 	int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
@@ -163,7 +164,12 @@ struct vhost_virtqueue {
 	/* Ring endianness requested by userspace for cross-endian support. */
 	bool user_be;
 #endif
+	/* Protected by dev->iotlb_lock. */
+	u8 iotlb_miss_state;
 	u32 busyloop_timeout;
+	/* Protected by dev->iotlb_lock. */
+	u64 iotlb_miss_seq;
+	struct vhost_msg_node *iotlb_miss_node;
 };
 
 struct vhost_msg_node {
-- 
2.34.1

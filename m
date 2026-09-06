Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BC30B529
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658633; cv=none; b=LGTTrT6TJDlNs6YP1g1siPwu7FLusJf9wBj/ZgOqWwGXZ6Ftn4i26ZASonOHwUgtpwCJ2rZCSvEzAzVczSOdFIrEX9j9u3dc9ORup3WrO9l2VrhX8m6HM5ncaUD7UipiyC5hyrderaVI82mvZp/I3wl2x63sArXIrHKBEBk8RY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658633; c=relaxed/simple;
	bh=rP+fcNJMW4X7h4WG9B5/D8rqNuGlsit+kgG+YTnzdOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f/H+ZVDHHfNpSZcqJDe10xZYcNK1G69T1w87h7IgA6yqGANPIgx2jF2Oz/o1w33xDVTztxKv3zgWWLByAa9h+ljGZOqmW6Cz6YEEWG3348y07UUn60mBp5S/OhzVoQSUUOblYDQInSqCa6EJ9emuQ9CpweOPr0wqV+FPIGlWlzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEE/1ov9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEE/1ov9"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d6efd73032so28912935ad.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788658630; x=1789263430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yak0ewOBoOKK/XyBab2A6/oNF2k2yq5g+Mf0tBmDfSw=;
        b=iEE/1ov9n3AyarEJcaVpTqmfT7iWdhfMPr85o/M9t5YzXKQVIhi8CShRkL8Jo+YBXN
         bsLYXqwCjbcpdKth+2Wqe4v0zqX5E7BA96KMkJeazQ9Xs2qNFueB17QnEABF1rrMDqv9
         4HYAVl9P1vmvr94mk08UIOHUBIfdhRUKRvmT/WvUXMas7Z1ztpN9rFdl69/4PhRdxK0F
         k9jrr9EYn+OQ9oaJ4oG7KMJ+PThqHfoMu49ev431M0d0fs2ocaPv3jYKyTRAfKhJgwiL
         3YczZbzdJWaGeGgzlhKxFVyy3TfIen0CYasMBIKbIO+xWHAoJMyEh+ISRngBfeU3Dapx
         yzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788658630; x=1789263430;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yak0ewOBoOKK/XyBab2A6/oNF2k2yq5g+Mf0tBmDfSw=;
        b=Ii9bSnDrDlmAeKemXbaKpjGDmDwfeG3nCNliWGXC0CmihrytA+XXB6OAOxOG/aZ33+
         i6aZNGwRpmLoJodWN7Yei5hPiIPuhJDsxtXfgCBwhOXoHzFNa4xW5r0Ff/mY9sxwmXmk
         ceJZlWHRZZ0XeZbTaTdD2h7VifQ11t/RieC8aDqcdHsDUi+BMRmcRTTKjOSSlDYUnL95
         zV/Dzt6eVcUlUMNhAD+sqh09I+Tk3soX0Xit6E2NAJZjEUcrFswSIda+3b7x7AhDogm8
         3El2SG2oPtf125JUBQc4B1EAOKbRZcNmAONJiDKDq7Nj2jXQ4+wujSLdUH8KeRIeoN2e
         xSag==
X-Forwarded-Encrypted: i=1; AKwUvBzREPOaK837Sk49qisAkyGvNjPZNwRPYiiWY4+KH8TGu13oJLh3KqIMxWUmf4qv44OFzu//eRU=@vger.kernel.org
X-Gm-Message-State: AFuF++lKLQez7zXA09nuJrS3OY/qUo5X+S9cPQhU0s98JspNIGS+7Fru
	CKrdS+/WOfxFwQcm2JlOw2HHCwMz3opixDsftzDR3TQDAwJu3I8gMVtU
X-Gm-Gg: AYBFou1NRpMYndrCe/+z7gJ4f7KGs97/5XYqZ1Og7LZBd+9ixDAM0SYC6fuaObrggZP
	r0JKRyOXpYGQaFygREhvg5oJt9YBPoezuuBwJkb5BH5JeSQs3dF7DV2hYaQdQOjI5LCBn9wv29/
	noENTv/LSv7NUskxclzstN3Zzfk6kfFucdfTgu46ZJJeZVtNvTsqFZ4kS0FG57C5R+cN+RVuMaH
	38Tib6c3EJ633LwELFIQ/n5l6svQkYwQ9Olwko+xE7Wz2W9n6tNe7KZ6P2Qv+Y7xYnKdJHJLvbN
	Jw/B/99C6kcbNjx52uBNsWlIg8cKdsd2lIaugZQvJYzzEBT6vO3NfdJfYDbX6IYiIFjnqIb9FAL
	KTC2qg5EzBz4McFChDnbwShbJQYAb78gqag9WaociojS1k7DKRkPVedB+Y+M9Ena9UVLm/bNtr0
	eJ6quzRi7Vo0G2mNJsfMaNoyWX4zsxKi5eLJ0u5fzfRuQ8pnSLkB4V5VY9YLJj
X-Received: by 2002:a17:903:2309:b0:2d9:2ff6:246e with SMTP id d9443c01a7336-2dafb1aa19emr190899145ad.23.1788658630134;
        Sat, 05 Sep 2026 18:37:10 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm1204921eec.20.2026.09.05.18.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 18:37:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: stefanha@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] vhost/vsock: batch RX used-ring updates
Date: Sun,  6 Sep 2026 09:36:59 +0800
Message-Id: <20260906013659.517889-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
buffer even though it delays the Guest signal until the worker finishes.
Each call publishes one used entry and updates the used index separately.

Collect the completed buffer heads in the arrays already allocated for the
virtqueue and publish them with vhost_add_used_n().  Bound the batch by the
ring size and array capacity.  Flush when the batch reaches its limit or
before leaving the worker.

Each used entry describes one completed RX buffer and keeps its actual used
length, so set nheads to 1 for every entry.  This patch does not change
negotiated features or compress multiple buffers into one used entry.

This patch is limited to the current skb-based vhost-vsock RX path.

Performance:

The test used vsock_perf with a fresh Guest for each state and 20 paired
runs. The Guest receiver used:

  vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1

The Host sender used:

  vsock_perf --sender 3 --port PORT --bytes 1G \
      --buf-size SEND_BUF --vsk-size 64M

The table reports geometric mean Guest RX throughput.

  SEND_BUF   baseline RX   batching RX   change
             (Gbit/s)       (Gbit/s)
  256 B      0.0795724      0.0831509      +4.497%
  512 B      0.1194885      0.1210297      +1.290%
  4 KiB      0.7208273      0.7242053      +0.469%
  64 KiB     2.1712797      2.1951941      +1.101%

As supplementary data, perf stat measured the vhost worker cycles and
instructions per GiB in 10 paired runs. The patched implementation
reduced cycles by 3.846%, 2.162%, and 4.109%, and instructions by
2.548%, 2.084%, and 4.637% for 256 B, 4 KiB, and 64 KiB, respectively.

An AF_VSOCK request-response latency test with 10 AB/BA pairs showed no
consistent RTT change: -0.102% for 256-byte messages (4/10 pairs lower) and
+3.281% for 4-KiB messages (5/10 pairs lower), using arithmetic mean RTTs.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
Changes in v4:
- Simplify the performance description.
- Add a brief AF_VSOCK RTT measurement.
- Keep the batch limit within the used ring and scratch arrays, without
  duplicating the worker weight limit.
- Flush after adding a used entry when the batch reaches the limit, and
  remove the redundant flush in the empty-queue path.
---
 drivers/vhost/vsock.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..7a13abe73345 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -103,12 +103,35 @@ static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
 	return found;
 }
 
+static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
+				   unsigned int used_count)
+{
+	if (!used_count)
+		return false;
+
+	vhost_add_used_n(vq, vq->heads, vq->nheads, used_count);
+	return true;
+}
+
+static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
+				 unsigned int used_count,
+				 unsigned int head, unsigned int len)
+{
+	struct vring_used_elem *used = &vq->heads[used_count];
+
+	used->id = cpu_to_vhost32(vq, head);
+	used->len = cpu_to_vhost32(vq, len);
+	vq->nheads[used_count] = 1;
+}
+
 static void
 vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			    struct vhost_virtqueue *vq)
 {
 	struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
 	int pkts = 0, total_len = 0;
+	unsigned int used_count = 0;
+	unsigned int used_limit;
 	bool added = false;
 	bool restart_tx = false;
 
@@ -120,6 +143,11 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 	if (!vq_meta_prefetch(vq))
 		goto out;
 
+	/* Keep the batch within the used ring and the scratch arrays. */
+	used_limit = min_t(unsigned int, vq->num, vq->dev->iov_limit);
+	if (unlikely(!used_limit))
+		goto out;
+
 	/* Avoid further vmexits, we're already processing the virtqueue */
 	vhost_disable_notify(&vsock->dev, vq);
 
@@ -150,9 +178,16 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 
 		if (head == vq->num) {
 			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
+
+			/* Flush completed buffers before re-enabling notifications. */
+			if (vhost_vsock_flush_used(vq, used_count)) {
+				added = true;
+				used_count = 0;
+			}
+
 			/* We cannot finish yet if more buffers snuck in while
 			 * re-enabling notify.
 			 */
 			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
 				vhost_disable_notify(&vsock->dev, vq);
 				continue;
@@ -230,8 +265,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		 */
 		virtio_transport_deliver_tap_pkt(skb);
 
-		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
-		added = true;
+		vhost_vsock_add_used(vq, used_count, head,
+				     sizeof(*hdr) + payload_len);
+		used_count++;
+		if (used_count == used_limit) {
+			added |= vhost_vsock_flush_used(vq, used_count);
+			used_count = 0;
+		}
 
 		VIRTIO_VSOCK_SKB_CB(skb)->offset += payload_len;
 		total_len += payload_len;
@@ -264,6 +304,9 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			virtio_transport_consume_skb_sent(skb, true);
 		}
 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
+
+	added |= vhost_vsock_flush_used(vq, used_count);
+
 	if (added)
 		vhost_signal(&vsock->dev, vq);

-- 
2.34.1

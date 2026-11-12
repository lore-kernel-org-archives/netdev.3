Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494917;
	b=DvTnyY9lf9DsdCQqVDaaa/0YwgX7QFKm8s61STHxPFJveY68EGHUgLGuu3PmJmPAroN/
	 6vYjVmG8Ys42l37fKIWIlKL6k6QwPCDJdSMr8WPhTo4XacXdKRPTGbvyxbOPAkvSDjId7
	 iZc3Myg4OD8tLK5ZehsIPpA+VnzJ7V6Me6FUsQ0QFqvYtCVxNrsL+hdMfdug7h6sbtHIH
	 06Y0iDUZ5Of5kfrYiAmbM/0uLWWuyZVfRh7j1EXJp4aQ3uEEoeE8IhA0yDXeGNCXYOqAl
	 0ee2acsHtF9u9jsPWw7x4U+FBbogsYd9v85Oh+EEnK+SeNzxjvvDtqDkHfTnEsHLxVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494917;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LEbCE37sqKI+Yn41UtqAlWWrM20PK8ftsQ5p6Bs7BNQ=;
	b=ARdJZeJy7C/f6sOCIyGRKaEvDwhSaQxcKRzMNjbyxki772AdAWAX5maOKRxFSkIg7F0Q
	 PyOI51XOJ0Sh10fZi4X3JT759kLKkZuS0kaERaEsYJ778Gutw1DKPx8oIaVLvNAR5vOKi
	 5xVH80c7G+Kf9M71B0n+3YB5YO2jQyUzCstiZRLKrctD+eqMxObWeNkutNJ9kkyJ8uUWu
	 ue+0Xwx7ZnHFlGY+OxSl4qJhhWVkE1YDMllZ6JmkkMrJCbwlHG+yIxWN3hIilJi5XdaLK
	 slD4UBaZzUFNjV+xYM9jE+otKdF1WcHk5PG+2rfZkA+/hMOEzrbCf9yuXuw1HBc/JEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=drptJcTo;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sr3hD6aP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BD606A335
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4BD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=drptJcTo;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sr3hD6aP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794494915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LEbCE37sqKI+Yn41UtqAlWWrM20PK8ftsQ5p6Bs7BNQ=;
	b=drptJcTobu9fOdyTCNJBL+e85uPIk8JmMwIqMceMS8OogfR+kEqiAAjWDGRU6DC1mU5E9G
	WYAVmSHoCwA0yYHJkd55p0syGxfoovCuZxJ7XRZAPS2xrbttcMCZ3R464iX7+qDUJEVLAG
	2qJj4eUq0mofZhV+2sl6ZPOLDNGSYDI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-YgzbxPH1NIaFKooJ7q_QAQ-1; Thu, 12 Nov 2026 09:48:33 -0500
X-MC-Unique: YgzbxPH1NIaFKooJ7q_QAQ-1
X-Mimecast-MFC-AGG-ID: YgzbxPH1NIaFKooJ7q_QAQ_1794494913
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-845156f593bso2440389a34.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794494913; x=1795099713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LEbCE37sqKI+Yn41UtqAlWWrM20PK8ftsQ5p6Bs7BNQ=;
        b=sr3hD6aPUwwTfnKOp7msyRob5CZlKZV/mKlWwY/7pZ1tmL22hnKR3oLCqtqpqySj2I
         TyBT1QHKQ6A+lmt++xVCDbVB5sOZo9FF5BhCgXuI3+PbY7Ndnnq+8pbJwSXZLyjiejPM
         b5QtuL5szlT7TXIHDfSjMjHacSX/2LHKu7Fns/eUqvGmcFw5OPOfIisqZL3fiVl1ZvgP
         vH5QjqO8IaugWVKKcH0KHb/cdxucMwgvr6Zx84qpWDl2FbzkdVavxGyd3WimyQwwzI50
         2JF6s5f5HpJx6LZy2NjBNZwgx4fdzdSA/yY13acF2o7uZKDeolXh3NtygyU1q1RXVTgY
         dH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794494913; x=1795099713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEbCE37sqKI+Yn41UtqAlWWrM20PK8ftsQ5p6Bs7BNQ=;
        b=MHxqCFku+FJz54NR1aou3BhiZL83JRxY7CNupS6mjaywC5QPqR8XgIWVNTQ4AExr0R
         0cQ3CZ6h7uAj2gzfUd31vjMu2hfgso2gS8HBDZiyE2lKgsB6FdCG9mcGVV60yM2VMw8x
         whGyLB4/SKx070wTppdUsMX1liOvwuCRmxJJN0fC0Z3tuqe+gwg2S+vfowPjgklXG8cJ
         AtxYgZhkJMui71zEZkODrEbIMqznCjU+HqZpypdRYrT4P0cD8PmM6j3yrD7aOXNmRQXS
         3VkZSMV8XkEmKshN0208KXiKNu4qJf68xcmPGLkIdfr8E6M3EPdoxTW7K/BU6rrjuDPi
         7tDA==
X-Forwarded-Encrypted: i=1; AL+hErGIKAHm+1nyGch7qB1yXFzapfujUvwS3oQjq+UKSxCvobjCKyvhYScEIOiide0s9RAo/qESb9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h3sffO3MYk+jYOQhMZ0WmApZATe3X+PndKvsb/VdkkpBIRilL
	MBFuz/2r/jazvyFbBXvAZ2iIXjV+6nusnIWkfsgmCu2UVQwxY0n2xMRLG8WNn4i4dfPArMHAz4a
	P57si82ydXRbvqTIPeDOGg5noEbI4c4ary7apD7PweG/gM2VfQ9Jm99F+Jg==
X-Gm-Gg: AYBFou0XKGq5YwihJGkfK6u9biuNHEQbLPsTSjDTSRqGp6+RgVjcd1/ni2rrpuk1PWM
	OfUNpdauswPdF8Xx/am3ftD2z9AKlarnTaIZ/PzkVeGZRAq6onIqzUVZ8UwwTkgakLZUo6sDJOK
	p37k/xHtlfLBth0+ePVcDH80XyXJR/JTWrChQG366aTK3iafQgH36Lt3lXouUiEymTpWGEIK61B
	vppqlu+ZBTDBIOVc9k5DPAZ4jZxzRjyThNh7n6rJ1OIvH7z1ZKzO/pb6ySI/v0BAuwnNzMM7VHz
	c/hXqzFXicmTS/i/noypYcqZ6tCdSdvQkI79MB8cjBn5EtAuZziyeBHsyQhB5QOkTCRw2ce6kXV
	YWNasl5erInGifjBav0cigYjieA3gKw+RWqF4GH7GlpwH5h3TBCDS
X-Received: by 2002:a05:6830:91e:b0:821:a094:b26d with SMTP id 46e09a7af769-860f2924233mr7543131a34.13.1794494912674;
        Thu, 12 Nov 2026 06:48:32 -0800 (PST)
X-Received: by 2002:a05:6830:91e:b0:821:a094:b26d with SMTP id 46e09a7af769-860f2924233mr7543101a34.13.1794494912079;
        Thu, 12 Nov 2026 06:48:32 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86286c313d7sm83930a34.15.2026.11.12.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:48:30 -0800 (PST)
Date: Thu, 12 Nov 2026 15:48:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, bobbyeshleman@meta.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] vsock/virtio: fold credit updates into the
 one a socket has queued
Message-ID: <avXOsmt440EdsPZk@sgarzare-redhat>
References: <20261106050244.602625-1-green@linuxhacker.ru>
 <20261106050244.602625-4-green@linuxhacker.ru>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261106050244.602625-4-green@linuxhacker.ru>

On Fri, Nov 06, 2026 at 12:02:44AM -0500, Oleg Drokin wrote:
>A credit update carries no data, so the send credit never limits it,
>and the peer can solicit one at will: with OP_CREDIT_REQUEST, or by
>sending data that a local reader drains (a read that empties the
>receive queue sends one). A peer that posts no rx buffers can therefore
>make the other side queue credit updates without limit, about 1 KiB of
>unaccounted slab each for a 44-byte packet.
>
>Every packet carries fwd_cnt and buf_alloc, so while the socket's newest
>packet in a transport's send queue is a credit update, a new one adds
>nothing but newer counters. Record that packet, and the queue it is in,
>in vsock_sock. When another credit update for the socket is queued to
>the same queue, copy its fwd_cnt and buf_alloc into the queued one,
>under the queue lock, and free it. Queuing any other packet of the
>socket clears the record, and so does removing the recorded packet from
>the queue (dequeue, purge, loopback's splice), under the same lock and
>before the transport reads the header. So the counters are only ever
>written into a packet that has not gone out, and the fwd_cnt the peer
>sees never goes back.
>
>The queue has to be recorded because vhost has one per device, and a
>socket's packets can sit in two of them at once (a guest restarted with

Can you elaborate a bit more this? I didn't get how a packet can sit in 
multiple queues...

>the same CID). The send queues are shared by every connection on a
>device, so looking only at the tail is not enough: a peer with two
>connections can alternate its requests so that the tail is always the
>other connection's update.
>
>A packet that a transport dequeues and puts back at the head (vhost
>with no rx buffer, the guest driver with a full tx virtqueue) is not
>recorded again, as the socket may have queued packets after it. A peer
>can thus make a connection queue at most two credit updates in a send
>queue, plus one per packet the socket itself queues. The folded updates
>are not sent, so vsockmon does not see them.
>
>Counting credit updates in queued_replies instead would not work: most
>of them are sent by local reads, not in answer to the peer, and under
>bidirectional traffic vhost would stop reading the guest's tx queue
>while the guest stops reading its rx queue, each waiting for the other.
>
>With a user-space vhost-vsock "guest" that posts no rx buffers, 20000
>OP_CREDIT_REQUEST made the host queue a credit update for each
>(+18.5 MiB of slab); with this patch it queues two. A guest whose
>device stops reading its tx virtqueue queued one per request (200 for
>200); with this patch, two.
>

Whould be nice to have some performance numbers.
Are we affecting latency/throughput in some way?

>Found by an LLM-assisted security review of vhost-vsock, done while
>porting a project from Xen to KVM, and reproduced as above.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>---
> include/linux/virtio_vsock.h            | 66 ++++++++++++++++++++++++-
> include/net/af_vsock.h                  |  6 +++
> net/vmw_vsock/virtio_transport_common.c |  1 +
> net/vmw_vsock/vsock_loopback.c          |  2 +
> 4 files changed, 74 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index f91704731057..0a5477a0443c 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -99,12 +99,70 @@ virtio_vsock_skb_queue_head(struct sk_buff_head *list, struct sk_buff *skb)
> 	spin_unlock_bh(&list->lock);
> }
>
>+/* Called with list->lock held. Returns true if @skb, a credit update, was
>+ * folded into the socket's newest packet in @list and must be freed.
>+ */
>+static inline bool
>+__virtio_vsock_skb_fold_credit_update(struct sk_buff_head *list,
>+				      struct sk_buff *skb)
>+{
>+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct virtio_vsock_hdr *old_hdr;
>+	struct vsock_sock *vsk;
>+	struct sk_buff *old;
>+
>+	if (!skb->sk)
>+		return false;

When this can happen?

>+	vsk = vsock_sk(skb->sk);
>+
>+	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_CREDIT_UPDATE) {
>+		WRITE_ONCE(vsk->credit_update, NULL);

Why?

>+		return false;
>+	}
>+
>+	old = READ_ONCE(vsk->credit_update);
>+	if (!old || READ_ONCE(vsk->credit_update_queue) != list) {
>+		WRITE_ONCE(vsk->credit_update_queue, list);
>+		WRITE_ONCE(vsk->credit_update, skb);
>+		return false;
>+	}
>+

This code is hard to read without comments that explains why we are 
doing some checks...

>+	old_hdr = virtio_vsock_hdr(old);
>+	if ((s32)(le32_to_cpu(hdr->fwd_cnt) - le32_to_cpu(old_hdr->fwd_cnt)) >= 0) {
>+		old_hdr->fwd_cnt = hdr->fwd_cnt;
>+		old_hdr->buf_alloc = hdr->buf_alloc;
>+	}
>+	return true;
>+}
>+
>+/* Called with the lock held of the queue @skb is being removed from. Every
>+ * removal from a send queue must call it, as the helpers below do.
>+ */
>+static inline void __virtio_vsock_skb_untrack(struct sk_buff *skb)
>+{
>+	struct vsock_sock *vsk;
>+
>+	if (!skb->sk)
>+		return;
>+	vsk = vsock_sk(skb->sk);
>+	if (READ_ONCE(vsk->credit_update) == skb)
>+		WRITE_ONCE(vsk->credit_update, NULL);
>+}
>+
>+/* May free @skb: the caller must not touch it afterwards. */
> static inline void
> virtio_vsock_skb_queue_tail(struct sk_buff_head *list, struct sk_buff *skb)
> {
>+	bool folded;
>+
> 	spin_lock_bh(&list->lock);
>-	__skb_queue_tail(list, skb);
>+	folded = __virtio_vsock_skb_fold_credit_update(list, skb);
>+	if (!folded)
>+		__skb_queue_tail(list, skb);
> 	spin_unlock_bh(&list->lock);
>+
>+	if (folded)
>+		consume_skb(skb);
> }
>
> static inline struct sk_buff *virtio_vsock_skb_dequeue(struct sk_buff_head *list)
>@@ -113,6 +171,8 @@ static inline struct sk_buff *virtio_vsock_skb_dequeue(struct sk_buff_head *list
>
> 	spin_lock_bh(&list->lock);
> 	skb = __skb_dequeue(list);
>+	if (skb)
>+		__virtio_vsock_skb_untrack(skb);
> 	spin_unlock_bh(&list->lock);
>
> 	return skb;
>@@ -120,7 +180,11 @@ static inline struct sk_buff *virtio_vsock_skb_dequeue(struct sk_buff_head *list
>
> static inline void virtio_vsock_skb_queue_purge(struct sk_buff_head *list)
> {
>+	struct sk_buff *skb;
>+
> 	spin_lock_bh(&list->lock);
>+	skb_queue_walk(list, skb)
>+		__virtio_vsock_skb_untrack(skb);
> 	__skb_queue_purge(list);
> 	spin_unlock_bh(&list->lock);
> }
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index e8481f12312e..7ef6f0c8dd55 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -70,6 +70,12 @@ struct vsock_sock {
> 	u64 buffer_max_size;
> 	bool recvmsg_inq;
>
>+	/* virtio: queued credit update to fold into, and its send queue.
>+	 * Here, as connect() may free trans while packets are queued.
>+	 */
>+	struct sk_buff *credit_update;
>+	struct sk_buff_head *credit_update_queue;

I don't really like to start to store transport specific stuff in 
vsock_sock. Did you explore any alternative?

If this can't be remove, we should really explain why in the commit 
message and here, or even better provide a generic API that transport 
can use to store private stuff there.

Thanks,
Stefano

>+
> 	/* Private to transport. */
> 	void *trans;
> };
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 74a8fdf825d5..ba814e1c0344 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1911,6 +1911,7 @@ int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *queue)
> 			continue;
>
> 		__skb_unlink(skb, queue);
>+		__virtio_vsock_skb_untrack(skb);
> 		__skb_queue_tail(&freeme, skb);
>
> 		if (virtio_vsock_skb_reply(skb))
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 8068d1b6e851..bffdc0b1321c 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -131,6 +131,8 @@ static void vsock_loopback_work(struct work_struct *work)
>
> 	spin_lock_bh(&vsock->pkt_queue.lock);
> 	skb_queue_splice_init(&vsock->pkt_queue, &pkts);
>+	skb_queue_walk(&pkts, skb)
>+		__virtio_vsock_skb_untrack(skb);
> 	spin_unlock_bh(&vsock->pkt_queue.lock);
>
> 	while ((skb = __skb_dequeue(&pkts))) {
>-- 
>2.56.0
>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590180;
	b=riYL19JG8t9Ait6qRQammbnQeZ4TBdzGZWiXGaQKYtqOCSoe5d79aFwJJDSU9/BnxwQG
	 u/tJ0BMlGHD7F/d25+Zv/bzEsbFdq39H3CZd2IwgiDYpFErnIXpTrvTFBm0dAaAvp1mnw
	 sFPAiuZS+BjfpbMECuCvxNmsfElrUGwzdpav9zGH5jQxwjzmfbl9H3yoHC8Ixk7v8Ljfe
	 zVlaLlHhXIdxJqrJNEWbNv4NuuHUQ6RGJP38Uq6YHqefXPsoA/3irUyCwJ5Mzh8JDgD2j
	 Ub7FyQV5ozZOCsbM7tveGN/jRF31c5RUsKui/yohwRf+xCQkQUJ/MArDJpyS7WXfrsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590180;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
	b=YCfWIYEnwJBN+XTUOF0Ip9fzUbP9fSDhCpq8EADzdrkn+9zYIlEOLhNG3YHwfSVxGBYA
	 LthuJOn5SP165xKoFBe4au2/kLxkdmHOw1Ps3X30cAtEtQvZsULWx4YsexVk3odr4r4gZ
	 Js6ohuDB0QDTllaK/lnQC4/r+DolPpPawRnfCfLVi8Aog71aqHTwU+0FrtE54gAzxlwWV
	 yDUl7AP82VxmjDK6J3GVrY8RpPLyRGfQylIlrWphkbCqKAh0fgNciymfeaqyc42Xlhdgk
	 3FIkkyDjzlNx7gJMuU13eSi7mx2omdoXePDaciw1j//FivGpC7aK9ZzTkgFdJUFdLng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LyTQZnPS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rcwDqaDt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E0606B802
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 480E0606B802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LyTQZnPS;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rcwDqaDt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
	b=LyTQZnPSyvRwMSnzDCl+ItRyBHz6XOZPbK8rHh2O5F7zfVEI+zTt+jwYGR1D6pRkzNV4R5
	MaM4tT/VaMfMzBItEqKxogMRMC7sVXybV06f6qI92qmL1uWqn5Lhdk0G805XuwYhcyk1SR
	1X5xOIzkpfdhu6WPVmxLNQY5mALs51Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-H0dOe024Pgea0_rgbs3hvA-1; Fri, 13 Nov 2026 12:16:17 -0500
X-MC-Unique: H0dOe024Pgea0_rgbs3hvA-1
X-Mimecast-MFC-AGG-ID: H0dOe024Pgea0_rgbs3hvA_1794590176
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4916bd6e3baso1131045f8f.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794590176; x=1795194976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
        b=rcwDqaDtJ0znulsRrjpmXsSbSF1NNzzsF627bEhOzqyYoSjXvPFREqLrinqe6RMYSr
         syehfFpXFLz5csuYw0BKtxJZ5obbVpSPhyru4RiHuKNVrc7b3Fa+pxfVUTlWFSOKN0kM
         ct87wmBNdqG/a6l+lCJL/C3gEmLPU//IGlBylNHO67QUP8BdPJQ/Il8/uWZE0rn0aonX
         XqyuXAFcStdx6hs9M0XsHOe73wa8dqCWlViP6PP6OWSzCmlOPJtVuV4HFMDxveB1bMHz
         Rs43/oLVFPCYxhM3OOE3OD9BuUFhGh/FlQeqY0GsyfwK7VSM7f8LywgZRrzmremZLX5S
         QmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590176; x=1795194976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
        b=z/7C9ObDvbfyKr8EQ8OCfPJlJNwLfS5E90EJqJvwsxCEIP6b2CGx/2nXpbWsRBqhCJ
         Y4iqG7f9/qGK6SdCEY6ubR4ku4jjuwKg3P0fdZcwvQ0hD6ZNxsuo9cUf5IzRrGC1DDni
         K3T4PRqSQkLS1wcvlUO6NtUu8LpjUT4rUvedhazeSY0u3rQGo1Oicr9IMKH5tgxJJTie
         Zc9jnTx6F4VmRFwU+SlaS8LrTTI8++QO9S27ZEoKm1NRPXXB958QUD7z/EcBUclh/tM3
         u1tz1FJC/ZUjCB4PXR5RQ/2zR/WaVLeLrC0YIc1F0lfiEbhIOWGyU96ApKUzRwOCsARi
         qgdA==
X-Forwarded-Encrypted: i=1; AL+hErEyMg2fIjkmKcieFBCi5sHFi+cXrff5tqbllrTm1SdJb49AFK/frWb4pPEk04Sv2tJsCqI4oqQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K27cOLA/6jPTCGynnOpnR4EHCBDOj+KrTVX0RZcB/fWEBr2/n
	8ymHEHbHPKtBVXw3MO84SeLGQDJsqdu7gAUegh8i9q3APVOpkZ9ei2kaJC/Py7mNNVfAq0Pea9v
	Sgxpa1u+cpMRpENqfdWTvQPw2YzwjHlYFPufA2zBeFKXMgoYoLZ9kMbeOlg==
X-Gm-Gg: AYBFou0yA1PAUegQyPqPnOPGwS1wk156kY+xxs6x18g6CUcpw0LkUusuq4xwaUWK/7S
	ZtMrVpjHsuBRnrqsWt9zCGOeiilNqfQAfdxXOea4uv7/ExjheHiZ1V8aVwvnbkogcB0m/Kz69/P
	EoJxa4K0A96vuihRg+sqVqQHyWK3cdxKVwgDpID1EsA9HNhh1etpG3D1YeL/QIbdeg7znYbwOwX
	Q7df5PWx7A/NcH2fQIbOp2jH6h3jCrk71cyhI8cyeqm+6WfKmE4uc9rPG82KfH+3c2Yq08Cnhra
	8zNtPlLZwZn70QNUTpRzw2lkdaJv5/kKQ5xc8+StSA2dgi7bxo6od+tMq6zea2977Uf3p/4ndZx
	E+IMSu6LDnnhAXs/SfNiYilVGjiUbO4Z+fC4zObjwGtGLCXiIoRhxwN1+BOT8pczDlJLODl7ntn
	l7x2pyNJ1hazQ=
X-Received: by 2002:a05:6000:4907:b0:48e:b62:d133 with SMTP id ffacd0b85a97d-49c6d453058mr7554593f8f.5.1794590176276;
        Fri, 13 Nov 2026 09:16:16 -0800 (PST)
X-Received: by 2002:a05:6000:4907:b0:48e:b62:d133 with SMTP id ffacd0b85a97d-49c6d453058mr7554512f8f.5.1794590175789;
        Fri, 13 Nov 2026 09:16:15 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm5811907f8f.5.2026.11.13.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:16:13 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 18:15:45 +0100
Subject: [PATCH RFC v3 5/8] vhost/vsock: negotiate datagram support with
 guests
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-vsock-dgram-support-v3-5-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=slp@redhat.com;
 h=from:subject:message-id; bh=YKxLSTvJb7wfOxlVHWx31lkfYp2fx1FL4beUkGwefCU=;
 b=kA0DAAoB9GknjS8MAjUByyZiAGr3RcvI3QnmKr/LRFn2Ary4TwcFPckWS7tYNcHGXnxHY4IMx
 YkCMwQAAQoAHRYhBL7V/PdRLYaAkULoovRpJ40vDAI1BQJq90XLAAoJEPRpJ40vDAI1JUsP/RuK
 zWQiElr7d4dJNVClBKs1rzZ0Yj3GcaeAHappnpy6wUu+gmAJFnxM2QFmqVIFxSElR8wNfcYX04t
 V8H+SJ/t0vVBYstyu9Mg7KIrxAWMvfhhIY5LnPwx2ZMfhqsTz+7ACuiDr6pZ2zxB8+CtoC3qu48
 nPzB2yFClOtl59Tbo6kse/qyppGiuKwfwAN8JWzOSeKIpLz7OGpocKl3vzkZ9C+ORgjYAAgvHNq
 teMbYTgAaShLedtIJoHNbCXsC/ZqnKsTuLZAzRnbqpUMdduT7UYOD9I6lvsTzU6b+ahXvZA5eKl
 nnkpvCIm0h1d1BSerC5RQq2JxnsOnW+6RAX/5HK0Pvgw0lXozPmSSKYO7W43WuzPTA+9By5WbSk
 PVaU6jX+oDMLJvH8v+z7hKrdgE6BEP244sZO2UtjODmqipK75ewCBRjhFggUwgPDP29cMMmvd6y
 z4FvZTWeMSYYeuhi6n+zEu3khNX84RSd/MlyCg5toZqRH7WhCC2zvn77ORD4nqPOGQFhFfA+XzX
 4vkl2qZPzHp/B/bz0w/h09prkD8x6/cY0skNUq8DRlnEMu/eXr6jC17IuBrGNW0tg+8u5DsOSiO
 cyAMGfzGZGgiBsCN6erpjNNToul8X5KBhzJ2LaYIVVetDnHyfAJ/4uuhpeA9rGKcWuHyE3YvReY
 rYmJl
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
negotiated value for each guest.  Keep datagrams disabled until the
feature is negotiated.

Use a vhost-specific datagram destination check to look up the guest
in the socket's network namespace and require its negotiated datagram
feature. The common virtio implementation supplies the bind and
message operations; destination validation remains in connect() and
sendmsg(), where the remote CID is available.

Reject guest datagrams on ingress unless the receiving virtqueue
acknowledged the feature. Complete rejected descriptors normally so the
queue can continue processing subsequent traffic.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..7971f6f0b6a2 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -32,7 +32,8 @@
 static const int vhost_vsock_bits[] = {
 	VHOST_FEATURES,
 	VIRTIO_F_ACCESS_PLATFORM,
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 #define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_bits, 0)
@@ -62,6 +63,7 @@ struct vhost_vsock {
 	u32 guest_cid;
 	bool seqpacket_allow;
 	bool ever_started; /* set on first SET_RUNNING(1); never cleared */
+	bool dgram_allow;
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -436,6 +438,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid);
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port);
 
 static bool
 vhost_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
@@ -460,7 +464,7 @@ static struct virtio_transport vhost_transport = {
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -516,6 +520,24 @@ static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 	return seqpacket_allow;
 }
 
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port)
+{
+	struct net *net = sock_net(sk_vsock(vsk));
+	struct vhost_vsock *vsock;
+	bool dgram_allow = false;
+
+	rcu_read_lock();
+	vsock = vhost_vsock_get(cid, net);
+
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 {
 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
@@ -573,10 +595,12 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 
 		hdr = virtio_vsock_hdr(skb);
 
-		/* Only accept correctly addressed packets */
+		/* Check addressing and datagram feature negotiation. */
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
-		    vhost_transport_get_local_cid())
+		    vhost_transport_get_local_cid() &&
+		    (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_DGRAM ||
+		     vhost_has_feature(vq, VIRTIO_VSOCK_F_DGRAM)))
 			virtio_transport_recv_pkt(&vhost_transport, skb,
 						  vsock->net);
 		else
@@ -737,6 +761,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +915,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0


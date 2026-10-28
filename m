Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203573;
	b=Y9uVUUdCndeRyaMqE5B2ydpHqUj8pFPyx2LT1bThyNwDk1byBn0eP5gpK0DelXKizqK6
	 NTGgb1+59EaC7/kJ5CIsux6qljniiJ7SNRFGZfLZdch/RMiRtuFEHkCDkHWxKG5iRK96a
	 293w1JuCQIgzwbhwdPd/CmyG4PQ0pi4ISIPEOdEYlgqJupTMmToXEFM4ISXKsjPco2Wru
	 TrLVQNUnxOr6TxShc8qj/SrxdUTeSnUg4V5EEz/Ls9e0bJzKiyGHd4Ugnfrn+n87rniKQ
	 kszCRz9ToF6Ila+E21zpR0hHwvL4/Y/qWJHkNdMHgx7YUPhhDeRwvS2+C8HDY9PCInw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203573;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
	b=BQthDbh0569DExU3p+2vayqrTkYxR0v2Tk8JZ17r/FxcyWuEtqFvW0Qe5KInN24E99to
	 CIbQKVacWQy66w+j2mSISII1hVzhbUtA5HWU6ZiPiqJ9rc8LBIz8q4XFQMe9X6vvzYk+E
	 U1cFa9LbbuHBKdCDNPVKyLpGQZb+XhUZmS6ZDxRA5Hzl8T0rO9NfGBI3c1n2TMSgF0bmP
	 o6oXW6GPLN35ITH6iHlQGL2//zNq1w7BTni0zqz00an6wIL2d3cPL4PF58i8MzZIoWLeC
	 JqvX6tDy1q7PrACkKB3FeUFIxpWfZ6ae5TGGmkc158+NNI6KswaOp1Vd3VqXpRZTSYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZMnURl+B;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="KA/pfdBg";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8D606AA4D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77A8D606AA4D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZMnURl+B;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KA/pfdBg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
	b=ZMnURl+B6bWOUZTEcb2qTB+f8ik4uhMv+33CQNAqGNv8EaB7u9ixHCKlvF7hgV38LfwK+y
	KOUSKxmxD4jdr0/qHSsJwHeSJb3dwMGW6Oj6KrlPGbqKZTqh8LrNUqauVndBvgbVfEuUvT
	ppuyMtPi/Xe4VIdLnpRKuAQPCRcq3OM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-BDaCqqtJO4qDgyyq5sXX6Q-1; Wed, 28 Oct 2026 12:05:24 -0400
X-MC-Unique: BDaCqqtJO4qDgyyq5sXX6Q-1
X-Mimecast-MFC-AGG-ID: BDaCqqtJO4qDgyyq5sXX6Q_1793203511
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e17d30a79so779800f8f.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203504; x=1793808304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
        b=KA/pfdBgrPaFKhmBB8Ztp62DZUKCSsV8kLkjs8tOMUw6b0okfNqTL+7ibG5o+1ak9J
         MzGqfy8oQ+0rCtpx9McZflckf1/JMrOIbxulre4S08js+KufDtf7vEyub1nNFbUMYzCO
         vpXA7JmpYGfsKps61SzdTbc6fANvyZV2R26Ay3iyzLZyB+EJDUhXGGMGldbiMjaVVmi3
         zX2w9hsMh5NWAzyhcpiZ0Lk92pQzp1q4ChiGwEePhP4G7e27QlHgTJySYt/KvKpoPk93
         WHxdCPPacSy94iSnFJFggqG6p/dTYsXmq+0IkjTDYdxu+0BGN81TZpZb/9boMbShMjX2
         GFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203504; x=1793808304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
        b=TTcbIX87+G+IRJLjBvLUnH7UkN1EPKzsB8FjFBYmcHmC6djw4qeH2NVy+FedMPHHZB
         p3FqeNzp6OIL23ger581KRvb6pBFT7FxYGfUPdtdw1x5QV3wKvQXCdUkBTsCXikjvswI
         8Csy3QbjujoJX60/SFm3Q7OSsqoAQGb+3HUehzShqCQBMGPM5eGMEtLvo03DCXoP9EaE
         gU6vvUmNenSiNnj3y7sFJDBM8XNrkFHIJrgtb+W/aprDp9c/QLuySQp0CM193mgRNWvG
         PpWnKnD9mhUSipLho7JKsvbXSC5oCECV6bw0PYcgj2jI7qmPKkjl6n4NFRW9TAr8ixiC
         Sfig==
X-Forwarded-Encrypted: i=1; AKwUvBwr1IuBRIIcJDiUjxAs9hVYV2JyoBleKlthGJptNTcOTmI9q6ACRMTU4SqsEEbdZkxU5jL0Vo8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiMjKQGj+9hoexAxyZdGs8Juzs2C3CyyDkOHYK0b0kIK0K3nr5
	SZHYgY7oUWgS3o0pnAQ/R6cwoIf9yy0VyLZFhni8nWCwrJUT2GeXFsAOVzxaThhrqmcOBNyoKgg
	05jnebwGbLHPVc6rrIX6vpkG83ZL5cs7esrn8vdlzBsmamqANVPOONl4MEw==
X-Gm-Gg: AYBFou2rQfMBTQtb3KP7A1nU2E2Z+fxiYjDRKHSeILxRAgLNboCgKaaEMPD1qUVTTLO
	JJAkjGj1g2txqoN0XUAHV6bwzn59xkX54XZgNVmiRULCulfRlnrGYYSvj3oY/Jxx1o+pYBGDbMR
	Mlu+KcidcpFfRLBLm26w+fhfBP7yqrqUJC7ZZiRvzn7BgMsA5Ty8Rf2b7IKuK1gQhUJ9Gg65Ch1
	TDh/1rQDHGzkQ4ZBHFa/8PpFlhs2jP0sEFgWfXz9FvDy3lnlp0yLUf0m8V3QmeDqDm7WlyDVpFD
	Nemt+Z1XQ+DQx2LNnciJxw/k/3Yf/SBiZrprfUdBZGOGHp+38i9uOI7ERuBEkagBfTqzeyoJcyF
	8jFuncmnvyU39Ccj5r88Z5QlWN7+CmOsdKYoNRu1OV1uFKFoWlFh1JQ4MTAcRVswIJ7Q+yv7HwP
	0FDB7JDaiCU9w=
X-Received: by 2002:a05:6000:98d:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e5d567ed1mr7017698f8f.7.1793203503994;
        Wed, 28 Oct 2026 09:05:03 -0700 (PDT)
X-Received: by 2002:a05:6000:98d:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e5d567ed1mr7017631f8f.7.1793203503646;
        Wed, 28 Oct 2026 09:05:03 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:05:02 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:34 +0100
Subject: [PATCH RFC 5/8] vhost/vsock: negotiate datagram support with
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
Message-Id: <20261028-vsock-dgram-support-v1-5-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
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
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3464; i=slp@sinrega.org;
 h=from:subject:message-id; bh=S/4WwL5dbPWCiZa0zeuBb6RBsuWeJgQfZUwqCMWgNGg=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0e97Xa4zjSMJH/xL6mXhEFJLr5iP+9ch7tW
 39VyLppJZSJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHgAKCRD0aSeNLwwC
 NRheD/402018X9FBIyAMMgECnQa6yDcTR5QuwyzPlGz5FU3Usm0YdBiY4B7W9pjUCrlUNUDsPBh
 ksIdh4bV9svFPsQ9oCZgZRwfFoY3hSJNnyvTN3tE7MYRPA0uZZpTQACnKw0FrTz2+luenFHGnF/
 ycD0KQ0ejq5Uje3XgSzl9vNFIaNQZjgV1ii62A+qKzTOoLDxcYTHcYKzkpE0O731ZH0P9qRLpME
 OLusu+MT47wAqaWVvGA7v+F7q+NIO65WdytU4jx7KxqIdFFuI5B5zqBReSNOcW0u17DiMcUuWhJ
 87+N4tt2foVeHlcNtLGyi8A//zJuvc0zmEuuVi39QStNZyDYyhF4xq2T168g6Jw79ok+wCfHZFp
 XtXcmIp6Z0Uso6z5/fU7AnJvgCHAaJv4qAj5FB5nkuI/NQwo80oDApKvKRWoyB4B/WkuPwbZWVo
 y6dGBTrEINxRHOqywyEEEvvz6rYZe3WY5naK0fpnr+HNHVfBiO6ias62HtsrGO36MnE2s+sHJC/
 cpYz0guHd7QByD6nTn7TJJJTjUk0Q1+7sFkxIBBTryZ5PxAT/aVB4hmF7eBeQFTBqvY34ccn4cP
 CqzmK8OoKeB1Fshdqvito+Go6gpfCtRrXApVO13D0UFAnSn2qxBp1TzjcJDhAl48UAEETZHxUHB
 fV584fy3LMal/ew==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
negotiated value for each guest.  Keep datagrams disabled until the
feature is negotiated.

Use a vhost-specific datagram destination check to look up the guest
in the socket's network namespace and require its negotiated datagram
feature. The common virtio implementation supplies the bind and
message operations; destination validation remains in connect() and
sendmsg(), where the remote CID is available.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..eb2fbdb721aa 100644
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
@@ -737,6 +759,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +913,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0


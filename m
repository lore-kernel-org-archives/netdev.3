Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092774D9F9C
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068100; cv=none; b=gGuv1xP2OkWGNJyb8OzV+uxcy+bAP22H17r+K1IO307OwJwSoqX4LpjTt5gH0t+MdZ7x72YZE+gPaUm5DdU/TzPvL4Z/p6iBSpPfA7i0v6/tnoSveUdbERyeXV/DuccCLxIEJbdb0QLWdNOtYrPgIfxOYme4geWGbrphsijfJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068100; c=relaxed/simple;
	bh=IwhLYmjLCPlF0e5s5GUMXm2Cd+FkpD1UwImr2LvvCHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHHnEOkVYrdDPsiDD9u2CNgV6zZZ0wUzsR/zO+pQZsVuKlMqvpCVwy2Mn+SO/ywrIFWOgtP2pvfNzqLzubVY+GnmdNlF836j+J0P002H24zYAF+e1RqG/sb2DACcFFo8Y8XJrT1UHUZ8BO1gBbjJxtrk/2/i+HrmqrEpmw6M0dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdwinpGg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CebExM3p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdwinpGg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CebExM3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
	b=cdwinpGgKCUZUoUbV+nV4RUa1XXx8hjDVtGlKZx5qdtEwLuw1ZRV1oPEQbpy8s5z9NU7D3
	Z8sO0a1h+ic6hnv6L8MXfk1IcucnfU9WNxFDoLY9Ls7SCHt6gBOFAO70jajj//n0Pegv8c
	3PfsuwPR67CHx91hdLol0S4nZ8D9H/E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-gMPp5DPZMYmZlSzdPGShpg-1; Thu, 15 Oct 2026 12:41:36 +0000
X-MC-Unique: gMPp5DPZMYmZlSzdPGShpg-1
X-Mimecast-MFC-AGG-ID: gMPp5DPZMYmZlSzdPGShpg_1792068096
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b01a74792so3488205f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792068096; x=1792672896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
        b=CebExM3pO8I5kXxWlvtzDGiUbUEqx+OCE1c8WZJSk5aHyKoaZMVgM/Py+dM9eVlwtB
         GnTW/RJJg5Fk3MAT8S0bT5SgF6jJEYYsPRq1etrQQMQ691TwRG+dC4JafHWNdu65Hv+J
         KvDSqAewuJvpKcEnxEcizGhcCJZsurQSi5chF4I2sC7y8vy/mvBvfwv711CUZreXykQW
         36gRN1cWeCEEjQG+piAa1CY3eGplgEMMA1kmpaEvF0u7GwNOfNZajvewm7q6CuI7t0Eg
         eZAT6adtPAMSU/hz9EpdZpdBlSa1coxFoCZCSC7GNJLLZwCc8J0ADV8iMFkMHrbVtd9S
         IdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068096; x=1792672896;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
        b=PpMuly9zO4ixCIUyz1QwVgGarSpks4oMGO7Vgo68xCMtCYeRMTQeWkv69ArEJFa7Ca
         Ac2k3SxLCsiq1zqZkaHgi6IHRpxHpHgdOkbIC+5GAXdNTKmnB4V+S3kGVKp7HZyNN24I
         UdDPWmYnc5KwaEa7HsbvHsAaFOsfyExdN71nHHrUO9c9u+X82HkEyJhsIHpndOVPiI3p
         8FUMJ/T/L9Crd/qIxpnH3rl7kyHdT/pNDMDuUaiv+LmeuDF+b1oTC3AloeBbVMMkCIb8
         TuW7yxERNvpNGDmwHxB8uxW2XA7ZzICm6pGeYnqMvd89iCwCo5XfKUxVdeAi/sPWuVjx
         TtBA==
X-Forwarded-Encrypted: i=1; AKwUvBzwMOVMF77ZAkIwMt2F1eUvfglWfjEaI+0OKj3+eoiedCgYRQc2nNtkaqiSrvem/a47FeLpOv4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKI1DP86/6jYx87KxOcxNXljleffJRlh12rITG8p6i2HbKnuSCI
	UwALdIlWEm4IfcQwpiT2aiiwRcAaWDZBeE4R+ofkcF1gIFph+8VRn7i8pm0HJ1xBdexgspFbPhK
	z3YMNKktj1LLVxuTaAQ/Aj9pU4sp7LaB2vat1QyUf418hlajIM0hmwTeRyw==
X-Gm-Gg: AYBFou0jHtB5E0NpEiKjX0N+6UffR09D+dz61rGeki2xpBObAsFe6Eb9JeaoPh0OMon
	5TBLVQheJXxWtuTUmKt1Z7BlyPzg31AOXZbttmwcGXTOjJD7MD/fvmx7rmgPVSVSUzKGRWq88v1
	GNftxHdlG3+iZ7Sp7wSWRnotahQjvOjdW5Z2eEaZL09It2sCPZwRrKy0lo5auuaujx646w3GO4d
	ZhLO/uDHvB3AWkVoeN6yAPW2Rccd19tQFR43mVx/3tGnSSgWtPg9mUwBoX0XYoYSM8oUxOQKvNK
	xQfVxzfuodpDFO3zFK3L/5jux4sUGoBV2L1tABvwASneh8eKNpYVWb8EQj0FMIFd1sjDTA==
X-Received: by 2002:a05:6000:468a:b0:48d:c162:571a with SMTP id ffacd0b85a97d-48dc1625761mr21924069f8f.4.1792068095439;
        Thu, 15 Oct 2026 05:41:35 -0700 (PDT)
X-Received: by 2002:a05:6000:468a:b0:48d:c162:571a with SMTP id ffacd0b85a97d-48dc1625761mr21924037f8f.4.1792068094949;
        Thu, 15 Oct 2026 05:41:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48defca4013sm8758247f8f.9.2026.10.15.05.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:27 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net-next v2 3/7] um: vector: trim skbs before verifying the
 header
Message-ID: <d9ac3420f95c5953227d80c71ebc3cd7e3c5fd9c.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

The vector receive path over-allocates the skb and only trims it
to the received length after the transport header is verified.

A follow up patch will complete the packet checksum in software within
virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
checksum would be computed incorrectly over the unreceived tail of the
buffer).

Trim first, so the import sees the packet as it was received.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 8a70b3a62553..1afbef78df72 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -865,6 +865,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 
 	if (skb != NULL) {
 		if (pkt_len > vp->header_size) {
+			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					vp->header_rxbuffer, skb, vp);
@@ -879,7 +880,6 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
@@ -981,6 +981,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
 		if (mmsg_vector->msg_len > vp->header_size) {
+			pskb_trim(skb,
+				mmsg_vector->msg_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					mmsg_vector->msg_hdr.msg_iov->iov_base,
@@ -1005,8 +1007,6 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb,
-				mmsg_vector->msg_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			/*
 			 * We do not need to lock on updating stats here
-- 
MST


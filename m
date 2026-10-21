Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569002;
	b=mwq3mFOp9Ya0Cp08Pd2cipHfE9SvBdwbm1uK2hoqX01jOgCBHhJ7GTx8WoC8UL14PVjN
	 hbZoIe6YuiW9fhI5Djn5GswFn4swO0mn541EZ0+q3n+PQeEReIyiuwJ1JTSGj/DGlZueq
	 FI1RJeb0jJp2+/cteJNutEi0ZA2L9I2p2UZ5EXh+nyX8cs+pczlvIQ9ZLa1dhvJVWGpLP
	 3z4kKPQJm6xDl9fcSiS2a9rwqHbIP5+pZLZTc7Ukx6RT8WTS09cae0TjAYFdc6Cvq0Vut
	 9V5myTXQh8sCn48UqN3v+fEUne0byUl1+4LyIIo8hpd+AVzRLcCYLnrM7WeI5/SfvNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569002;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=;
	b=pm3ZwkEjzk0qKM9xDtQ1IJNH+cGesFWURXjdQuQ6vDKUcgNgytyQsAumTHqXhJLvn17u
	 6BZ2VuzPmAXEAkVvdKdCqDlkZ33jyc/lA2HNMjS/KyQxxryb4ePITVZi/Fwe0rhulnavq
	 A4Xpk6GtI0XF5gQ3f80XzvN8MWCXcrYCaSLSdS5DWnNqY/f92xrIBxyZzbKO8q5RdGPe6
	 LeqcZMpsZ2kI8K9Qjr+1ye8ArtyxMO9Uo6o4mZ7qeEpsqPCRIMHuSguqy+1Qfor684mYs
	 54wcpQ6lbf9prLQU0DzyMP7lBSSjKnTAcZp50sexEOCBOUbE/ViQmIFBgTH+RNJ2BXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BklG6k+g;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BRQoEBNY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA20606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA20606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BklG6k+g;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BRQoEBNY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=;
	b=BklG6k+govS8Ik+bEgRDu5xZFrJNgwLPoeu0umg4KdkPm+osJAxa0l86Ug0tKl10Zi3/CB
	9uG30Iq/yrej8xP7MLSZRSkD5d9iBll3torNCQYWGKY1HePSa5KcICY9pIBsO66SwYiH5L
	Qrxd/DsJ+jULZWVcGm1CWxyMx0ec1yU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-UuOfNiWGM3CqOjCG3MypOw-1; Wed, 21 Oct 2026 07:49:59 +0000
X-MC-Unique: UuOfNiWGM3CqOjCG3MypOw-1
X-Mimecast-MFC-AGG-ID: UuOfNiWGM3CqOjCG3MypOw_1792568998
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1df6c2937so4362285e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792568998; x=1793173798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=;
        b=BRQoEBNYKFpU8aToIoApwGJeaLTpKV1ju9zqRtxOrRTEDQ8lJ5Nj9xh1+N9Csd0J4K
         isq8sjuiYEvbLx/vqtlJphsyYUryg02eo65px7ME9Ki07YToVZb1m25jsv9U1hSbnh0w
         /vcWSvuf9iAyWvJUOIFVpuI76bi81MInhBDYrbigWTEFkMTbftUCLiv3boopFVXwgn4H
         1ftXrVx5KGqpurtAwD6bAaJzWh1AXWOJQUWwzRSS+MgEByRA83gQZYukurYosRMOCeTU
         S7e6cMXloqgWr0eMzzFF5Lt05CGVhMb19Rc+Myr0uJjd00or6yQNBZ1esie3zm+u1Vg3
         j1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792568998; x=1793173798;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=;
        b=Qu+jDWBuoo6Cl2H1jbel4E2lSU9sxJYxqUqGV5r4YrsDQEECMVTL/jwizVHrI7vj0i
         MS2sEiXsZagKUOnIFneUGnE2OIawNwMcGJRimlp+OtjmVBgmLAlRlaROQG/EXovamsvA
         urHLaOBpfEdTffdzAkWwhG5bq6Fylnn9FEwpmbnPTpKHUtBQEMxoF3rwGufDTXZcbift
         hHqWQgY20LQdZGBuq1RBeaoPbGgPzSkwYb7VeqkmJcxy8juy7p1r9rk3uVIGC54ZuYSP
         +QfH3gfCF1B+rzqKAHJG8v219804PGUSvSZOqPlfVKGHJGpaDSlqr4Wx8ocg6I7GN165
         27Gg==
X-Forwarded-Encrypted: i=1; AKwUvByOLWqmND8/zDHaGNL2u2jOIfcMlW6J9f8IvwdPBjgJto5sfz8d2hzIwAM2qZVW4X4mMjVfZg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn6tR4zC5u7zUPSjIfPOYVYiq6aXulGJME6ADzgfMaAuffeEjJ
	CyjL6dyeoRjkRjl+ZN2M0W4rFOVN5pzRjUF2rAs8eu7ytvuuCiaqw6z7DQmju2/qbEZAF8M7ymT
	VbMkRcoyXTe9OpvVNOt3zivUT+p1WqwROi2IfKwQiFQPF+soPrnEqKNi32g==
X-Gm-Gg: AYBFou1u99Ip6BnuYyb3k3SWUFUrQu9Lo6t/ZhGE8K1iaMhm79/iiMcS3x+EchqTDp8
	oj+QVkMwN61vnEe8STRK5+un+9XbbWHfY2o6tJ6siiARNBFdBwWCdC9pZnAjjkG6GvBSMMbGPdQ
	L3VoqZSaQ+VCYa/942GiupkRu3IZGFpvf4hUb71y7cO7pBzYsnVl8vAboLDh6u4abFDbdaJn3G7
	TSnLUUileB5KiiKhK+FThPH0ly5GIQS2fL9f4ELBIK+SBSrvIAHjXiPL/WS3C2nRvgQ7W6C+VQ8
	RqKeyN9m1FhPSZmrCYF6P5dx+rrbt54LHboE8s8wepaFAKh9vXgoALQSb6fOTk7UAB9ZmA==
X-Received: by 2002:a05:600c:3f0d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1fdd29c19mr24760685e9.14.1792568998296;
        Wed, 21 Oct 2026 00:49:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1fdd29c19mr24759945e9.14.1792568997732;
        Wed, 21 Oct 2026 00:49:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1060f3sm34363505e9.1.2026.10.21.00.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:49:49 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:49:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net v4 2/7] um: vector: trim skbs before verifying the header
Message-ID: <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

The vector receive path over-allocates the skb and only trims it
to the received length after the transport header is verified.

A follow up patch will complete the packet checksum in software within
virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
checksum would be computed incorrectly over the unreceived tail of the
buffer).

Trim first, so the import sees the packet as it was received.

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


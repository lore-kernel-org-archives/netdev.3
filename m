Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF94EA386
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411432; cv=none; b=Lowa63c7x9urWudL7+JtXmBDlv6/OK2JxpbbpV8MaTg7G4taGhzMPw01HnNR59lEqQNg2tLjTg1APOjROBVuwhEEOYaiVNS15wSU0MIxFo3hC/J6n3G0l0IICRLzg8VXRwaEjVh190yowt5VHBH1sgCTWihMHeY9HUCPOB+alt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411432; c=relaxed/simple;
	bh=IwhLYmjLCPlF0e5s5GUMXm2Cd+FkpD1UwImr2LvvCHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCRvvhcCuC8aZoHkv9qm7Omsc8FgDvG+T2Ek8DJePG/FoAL1Ibp9wavDANmBrA0aFIRabY2FO8kGJ+nl1k8/51yytgAw3q9hKCX76khx7YicUrMM5X5+5EMLrpL/cn6iAEmVo4TqcNPBUNLcOGgaoX/EgaBLFjYgeBH4e35xqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0pfRk4X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8OaNTUh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0pfRk4X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8OaNTUh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
	b=e0pfRk4X6Tw/rbE1QUoK8brl5AVPxoEEUKXR4VDq38XeyQCtc+HA7ny8+ebzEDrHOI4SSi
	WRkcA7Gk7QdBSzX5kqsxcfSc4PzRT6kZIko6k2HqcBKr6WB+s3XqHIjTJIYAfsIqQYK2LA
	HJYVFEsJBXJ5nhIPgTEtnLc4HaMjS6o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-kPkP2h47O9OQVB37-F8EAw-1; Mon, 19 Oct 2026 12:03:24 +0000
X-MC-Unique: kPkP2h47O9OQVB37-F8EAw-1
X-Mimecast-MFC-AGG-ID: kPkP2h47O9OQVB37-F8EAw_1792411398
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1544201f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792411398; x=1793016198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
        b=U8OaNTUhKf5Z4zXpPcdwxTf6lgqn/XByNHZaoc98ktaok+udXPDKF7jgtJp20eaCXh
         kCRDA7iZ9zFtlBkXXXFz2fjVkuKSRkEckmLYusBV0/lJmu6QDgO/YpspqvsA8GU4M6JT
         WlY4hHOxpD9DEb+eWDgJgjOpWbUndzZ5QHX9KlIdOpisdg+50Un0D0cD/9R9L1M9DPGl
         /L8lFoRIx3phMGrQ2O6Bw4ialq1eFoNrhpiMFYCwVM/AJKmTvEeqvkKk5DXSBi+SqKOk
         28BHIRnr2aAHKJlalDUE5RMhBXfTdS/or6b8okCKycLeVtJnwby7UMi165HUBcfEdAp4
         YDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411398; x=1793016198;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
        b=nssRMSF0VAqXxGfnDg84jPx3Pi/yblCXLVfl8K6nKtW4tEj/ukzclnnNxjqLWxMQm4
         MWo2wRdBEjLfQeIu5sGjagE6LYvPRKORoc44/wqRwqov1Cwp8eGMeaIt4D9FaDtpBQze
         Wai9YaflTPRG0P5jdwnkkQ4cB4fiUJjRECpIvubQ9hB8GeWJm4yQv+S8HGvuJuQngSTM
         +SA0w+iN04NIyioeJih9mIV/zQIkUOoKrngh6WBg2LnPPhu9itkbLAkC3+5LCBRUv3hK
         fHWENePj5DgsndQy346oXW3bAehjWijo64RTmxGulWZ5ePFSAamomLjW1Fegip3dTMqI
         6yEw==
X-Forwarded-Encrypted: i=1; AKwUvBzZDkNotHW92mlFr3IVcyVsBxDfEQURUfqE405hXBoWyUBhIN506lea1brYQFLMZH4as1/8sW0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjFrK6hDIxjxsVFQyG/zJFM+HN/KwE2d7TZS8ssCmVPRBZNtfa
	UrcUqpjsWeMfOuxX0skrLG4tujF1nxCMG8rNAdjNXxIiHu/jQzAQqt4A33T+3flZ/9TAA8Y40kf
	Xn0z5rhqhwgm9+SF20B+exCSUxEPv8t/xCr9MJklKAH4JMSCqI7dTj/DT8A==
X-Gm-Gg: AYBFou2tHvvmt+ObsDZ5GamCH6rEIprik9FLPXXy317aThgDvR93l2hC1i5btbgem8U
	xf1PKpTHKApUn1jvcwjYq9NyJQtoaMEZpm4c2YqNNmaM6/CS2+BHREGFmW98EwC7QwszjRGXtXG
	Nf0RYqe37xR4QVYaYzS9N7uUAOGj+kaS0ifkYlGbcbxomiLBEGOcURF+s0P4IPnjlvWzcLYHh96
	jiTQ3oFVGI8UuJFBv9q+dPxNlQ2S6+GcowfSvvfqUH/6s1YqfBC3OgvI9tXJ1NHwDAdA32VECrL
	+4hJYiUaTRhIAQlvMKlcw8DjQ03W0Kiw9AV/EtyV9nidoouZSxc96z/+55DIjeY7r8hSLA==
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id ffacd0b85a97d-48dfaea3908mr25611945f8f.31.1792411395962;
        Mon, 19 Oct 2026 05:03:15 -0700 (PDT)
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id ffacd0b85a97d-48dfaea3908mr25611747f8f.31.1792411394009;
        Mon, 19 Oct 2026 05:03:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4feb6bsm24515964f8f.41.2026.10.19.05.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:13 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:10 -0400
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
Subject: [PATCH net v3 3/8] um: vector: trim skbs before verifying the header
Message-ID: <372d22237412a8dee2f848660e76162f05c566cd.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
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


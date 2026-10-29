Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300027;
	b=x/BjN7a0kJiZnITXi6yTLvx+vlgw4h1ycyL7NEDR+AK6d8bLtlWxQ31vsjT2BbBxM4+f
	 Bf2Epf8Kc5raShIRtyqrLzRC+HoEdLYi4a3iK+Du8MjySYfQXix+U4D6Jc14P9tvkHsLX
	 KU+ndx8bCrIT9SVaFRkYTxd65fIjdgQzjFWkGBKXgt5R26jNXLKH/GIdnufih9gcVcDlA
	 WN0dh85y9gw0lE+lF/Cw211hsN5MuM5Aml+Acf7COq97wWdOY22pY6EAS3gA2Nykro090
	 vquj52Zd5TI0qh3dQcRyvpneQGk9hvWmYVK6z7mTqO4ltCIduFxW4jqY/9avRm+3ypg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300027;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=;
	b=Fcks5PVDiK5taLLekrE/tq7PcNK7qdIrKlshmJnJN+KUj7frgO133LvTh4IwubSTDjZS
	 sFMZtTiw5BhSNbcjFf8PAWR3eGSuNsgFalsznYb4S+k8rI3hC3j92/f+LwxkJ+BxT5hU6
	 F8hdwafFh+skmZybTvyLn8ezR4jcpczwSHpA+McIi3WJf0W7RgCqZkm1NclukiwR9LAEy
	 QMRSnSo0whTv9vaNgatvETvnDEb4vmJSDcoCXY7QJbDCT8fPzVgn4mcf0n9Q5NU3tLyuW
	 5SMb1axqB2WZzLawDuPGKNUNUpoMZuoCHgUwqucFIADrHlBOn/SwxK9X3Nee1Wr2hdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MKRwHKHQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CQhtA8ce;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C0606A33A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 105C0606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MKRwHKHQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CQhtA8ce
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793300026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=;
	b=MKRwHKHQRka4QZ+QBLjWWS8MzVuhUKYdn78IsXMOGNxHEvsRjLi5XLLGCTxgiqJFP/3xsU
	qzrVbroiEbu3R7PZFU6mlplJoW8TQjydfHGnJGUzcUDOyy5RYRNlSagcjMyGjtQcXhDnTA
	qE3do1/+0/Q+mAuhTu7sacyydqPA7vY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-2l4s3xv8PmWhgcuCbBcmYg-1; Thu, 29 Oct 2026 14:53:32 -0400
X-MC-Unique: 2l4s3xv8PmWhgcuCbBcmYg-1
X-Mimecast-MFC-AGG-ID: 2l4s3xv8PmWhgcuCbBcmYg_1793300012
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so21202815e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793300012; x=1793904812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=;
        b=CQhtA8cenj9DFWldAvta+VRsknvyPr/fUKTX3B51t+uGSTSg78q5Ad69qyTHPvlvrF
         g7mhixHKbKK5jn+dCFRXWWGT/i4A67q6t92OFD9k3maCA9FBGucvjcfQYs/nPASU+Psw
         8g3ebobr4ShBlv7Gm7cBZdAtRbHILArFgH1Fgb/FgJ1jMOdDSfH294B+ekTn1P17Abtn
         YxI3key2ULpmZp32Yi4wrw1C6I8/ocUEKku+2RocVktmMXfCY1l/9fZ1xIX8kZ/4jJno
         uJ1OSEqFyvaOY8zy7wqUT7ke0TcNIF5agYdOgL7tlrdTG6OcJwVYY3/bnamBI22pwm5j
         icFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300012; x=1793904812;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=;
        b=q6fkaWk1bUxjHGXWz5mS04I3KwKdmjrz6n/FLb2GmR8xhJywQneULSdtpuujnK3DbE
         QF26YEg6N2aqR7MxjYOJ3fehk3HMwN4Qf7JSidXGnlatlndgxbBNQcZJsmre8hjAWfQw
         1QENSAa5HWVGoZc9ntrqMUwBhMh5gNCdYIy2uvR9B6B2JyUAyJu9r6vKPkWYH61Lg4jm
         Pufua63WFU3WGSqvUxnQjbcHe8OxMMHAvS7hxUrYHXbwl3VNYPBO+whZffLOAvG7+gtu
         jHMB2fpVjWUWVK32Iu2eOr/KwrpZE9SQOcJKhYgzadpeMGTFZi3hOvAniu8/ulia7XnJ
         SNzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVrM1GM5kQAEY9SRNJjaZ7n+SiscTc+8oEz6f92sRAGGGLKLo0RqWvC4QOWmYUgEW3DX6uenw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX6PkHqcrE2MyF/HauwtGBMNeA28f+Z0wR6cn2cPml+9JehhoH
	bbrod4bxjkf2kObpXASdx+kRqz858U8f/j7uH7mNTEuP8fpVB1VHzCDQiS0fV/gI34X4IJWA3ZH
	b6pWjSJ4zQhTGd00ekvA2qLer617uy6ZVlXJQ+C42YVsjVoC73GVupcEsIQ==
X-Gm-Gg: AYBFou250HrHyCaaMzwBLSNSzLryGXq8yit0acRXdpG5MTCLrXQAj+nKoVG4KtpE3ip
	n1g38z863zOdSkwxU/RKgO6mfi0ISs2O3Vm4R27/KrB3GTbGdQ06hxESj/6go7LYL7kCXzI8ASP
	0UlsG8ilJvYkyNpdnDPTiFk9QaKUw9it58Pz07ZpDyz4MQIaWleKYqywaA1JtmHS8Ftdu/N5m5b
	chEvNwqlw+v9aDqrJtz1uCNurEw/CntTey+vGq55wvfoEfS+rN7dEkf6dURTN+VKNErWuTrPpl7
	EeqYAo2YdIC2PhXDe0CVG7R/AOwvfU9AvfsnphSHxFuMijoP3hVLU0fJRAvHyucaI6YzKyCY667
	EKKIKDVO1cKR3qHkjS99EIaqvN0Pk1faN9sZVI9Avx+ws
X-Received: by 2002:a05:600c:1909:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4a9675dc5cfmr142984465e9.28.1793300011479;
        Thu, 29 Oct 2026 11:53:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1909:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4a9675dc5cfmr142984155e9.28.1793300011057;
        Thu, 29 Oct 2026 11:53:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b289f7sm4241265e9.5.2026.10.29.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:53:22 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:53:19 -0400
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
	Willem de Bruijn <willemb@google.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH RFC v7 2/5] um: vector: trim skbs before verifying the header
Message-ID: <d5a36cae5997d36ae6b4bb192a251194e61a8a2f.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
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
In-Reply-To: <cover.1793276116.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

The vector receive path over-allocates the skb and only trims it
to the received length after the transport header is verified.

A follow up patch will complete the packet checksum in software within
virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
checksum would be computed incorrectly over the unreceived tail of the
buffer).

Trim first, so the import sees the packet as it was received.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index e902e78c5ff6..828bd61995b8 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -873,6 +873,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 
 	if (skb != NULL) {
 		if (pkt_len > vp->header_size) {
+			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					vp->header_rxbuffer, skb, vp);
@@ -887,7 +888,6 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
@@ -989,6 +989,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
 		if (mmsg_vector->msg_len > vp->header_size) {
+			pskb_trim(skb,
+				mmsg_vector->msg_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					mmsg_vector->msg_hdr.msg_iov->iov_base,
@@ -1013,8 +1015,6 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
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


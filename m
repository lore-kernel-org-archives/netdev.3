Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673899;
	b=TAocEcDsjhl5AvXpsNMR1fEm6yyZVVVklpFgBtt3VGcnNNYyttgTBJRVCiJT394KQzb6
	 GuRgQtjFTJaCFyJFgdnVxiI77ptTfavrKufbOoFKkzI/itxqQgQMHXjjPclJ5WKefdFPg
	 03boNQThLeFfPWgrbLRfc6Pc4yZjsRqqSBRZwL8W8LlcCm0NyCDoEbCzhAMR4oNF7yNcI
	 MUvtJ9sjmui7AxLbcX0d6+Oz8P3wxuzYWPZgRQeopu1azv8ZE27qqJUAGmleRFmbEG1Ya
	 FeGcwBDM+DfvkS74BLtL8fTcFppV2KmHlZcZ9spKaFEG8g850jfEZG7T3OpjjKOtsBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673899;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=K+HWIyeQ+QAmzkK0XPtrKhmy34l+YYsQjqRjQJm14V61djcerNsDRIpiDmZmWP2qtOI5
	 DJEKGFAZ3rZojS+//pTAKnCDVLhJsUDLKeUQO7lXkGYaPobLNcSF/3/mrevuM2r64aGQP
	 +zYFjSpB2JyF0W6Xb8fT/+rdsWHd8GqYp9A1dx68qYru7zIe+13+eXgFZlWACXj5uPJ2I
	 CA7rjCbgXvx9t6Pd8rFQea2I/cvqSoYVspyjfunRDglEVfqmErfA135MXEzXalZtp/ff6
	 JeUaEyvhEIYR8izYP0dhhuSR+/xL7nFfXhZ5wyQMnAaLPuhrPAvYdxkjPJcsLiT+Atw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jRDsSkl3;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="CpA/aEBe";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698760A2607
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8698760A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jRDsSkl3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CpA/aEBe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=jRDsSkl3fEDSq51XXgV2/7tzf55ovASvfjehudhYBIpD0za3eINgoHogkWcaMV4rCQmCoo
	e79ba1LOi0EPlVzaL7LQuEaPjBc1r9G6VSoyIUxsb2OhUxI4G4HgedQmMEC5aWP5eYTo2k
	i2g7UGG3WK4edkw6lkjuu7l9cms2vwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-cqGAsskzMsme_Bven6ahhg-1; Thu, 22 Oct 2026 12:58:16 +0000
X-MC-Unique: cqGAsskzMsme_Bven6ahhg-1
X-Mimecast-MFC-AGG-ID: cqGAsskzMsme_Bven6ahhg_1792673895
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e29c25101so845503f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792673895; x=1793278695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
        b=CpA/aEBev7BYffQAPajvyPLTW0UGQ3vBusDGDYBiyLvc88qpQvljhXgsbl+aALoQCC
         iHxc+rBUY0/vyxcNyCCtoH8UwnbcgWPwkfF3IKHoOdHoaewE72wqTHQ5xxO4BXHSWu8C
         XnJUoA+0PsFi1gPyvUe6kg0zdKpIebm3GCGBW/rZB2ytjK6xyGwG+W84P3GWvdWKzSkx
         K5vxkNEYX4evXOHgJEC27JwnhFME0cuOUQGSu/ea96UHNAJmXOmBY6mMivs1SPBruAOt
         szB54GuJ8oEEAQqUATKPHJog25MrE5DdAwIe5WQMh3zp+TbWvGIud3IcAjJegu1BZ677
         LpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673895; x=1793278695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
        b=v0ZoYT9rlmd3ky7yO4TA8OaqL5yDUDi2YF9ycaQ0R8yjPsoXZ+AydrwhAZzLYFeLSR
         3URBbaCMwcLYg5T0rxDs+BVo3fyisLf2ob4D4zIU2Fn4bInIg5ClkCVLbCp/mSOk6Cf5
         p8gCNxaXFvqhvG8IIX4IjbL7kHvCCeFvfvvEAycKmjYgNF911zWLx3TyKYhoqbPB7pou
         rKQ16RQ3X7suGl5a1Kow/UIagUZ4DMK4R/gb6RqylHFMscrCzpvVh0MhRJ6BY8dtQPFY
         68qP7huNUgIws3jBA2ClQ/mN8m5cgOoxA4xx6SrmxsxfUI5RcmLSMlKxfFYeMggDDCx6
         y5YQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7DrRr2/ruWyYlnytUecTm26XgsI2lEdeKi7HU05a8eLZy7cLljawUt/OFmZAsbDarjXbbrjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzicEGDT7VLHRyNLn3g/Kg/+Ve9nfL46BpX0LolfbLEKl1oNls
	CYGMsAHLVnPtFOk2ZpGCM5WvTlyrTu14Nf6qz2E3FoK4+sqLDrPzqXurF7jLevvvwfS9sgc2xdB
	HudRBc5Td3eHQzXoPzbOVXBOnMqmJ6Ut+8x9ltWtbakuxJZRgoT8rVdXPpg==
X-Gm-Gg: AYBFou2wom5oK3ZA93LKyK8lQY4ZPYk/JIpo4WmBNaIaefNDNcs4Xqy5ygwZRQHdeui
	FRB3O46JDbQULJG4G5Y3QeFaH1+mP1shXCNML73vFJl8ckRaqscpak5HZy5Qc8vrxX3D85P2f+K
	BpUTZw1vTBjPgYq38ZFBcfNhMcGrC/ZoZrhWv6gZhCT/2Z5PLto42Zez1fnoB0MXON88XkXXIUW
	vkjZ/75/yG0EXNFASK17EGpjxw4fSI7Ggn4Od88R3dJV3HlAp+ezX64hlrznhTRV4yg+en7Pmnq
	9Hv0cpT7liQ/H7EeBYNk4Dqz/Z8QysZ+JAPxcZnSO2CWxGG4eMNidiz8pdLaL9RC6Ds=
X-Received: by 2002:a05:6000:2289:b0:48e:932:af01 with SMTP id ffacd0b85a97d-48e264b569dmr9840328f8f.31.1792673894886;
        Thu, 22 Oct 2026 05:58:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2289:b0:48e:932:af01 with SMTP id ffacd0b85a97d-48e264b569dmr9840264f8f.31.1792673894174;
        Thu, 22 Oct 2026 05:58:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583ffa8sm12500019f8f.51.2026.10.22.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:58:04 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:58:02 -0400
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
Subject: [PATCH net v5 2/7] um: vector: trim skbs before verifying the header
Message-ID: <1b2a0697662501fd4fe896a7dc2bba2d97885101.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
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
In-Reply-To: <cover.v5.git.mst@redhat.com>
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


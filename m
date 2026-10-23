Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768182;
	b=qxWQXXRQpYkssGO3x5xV9HIOXkbwP++qpizsCeUTuAnk4St7opqixYDrmCWOYHt7MaWP
	 /8H52NK/DC+F4uwSvtvI+nwPcLU7TcmxeuS8AqNC8DDC1LwPVWj0gVX1ZfIdnmoQvN3er
	 Z2hnZoe+Rhxp5VpuxGVCutF+UuhMl5ICIBwnuqc5wh4+jLRs2x9+EEVgPsGQVtPgwluJw
	 qb3atrwU3ySS/VQIa/G05uLTDUGxr2kQOE2CIXdYbmgziwQZkVWXSp0vg8V1ZbPVkOMlM
	 O4y3WUknEl/Hb5P/ZcJFQvgQsFfjctNWyIKhjLPDfHdPCCqVklDa/w45Ek62FkCf+Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768182;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=LZydxy9wffSvJroGeIgfXfH1HsTsub3XfS92OHhZOBzhJT0iy/se8n5MGkOF1f2RRWQS
	 obAUre6VvBJqf5uiLKua6I03+vnnEJlt1o2qg95qWg8DwkXaSKl0p6Ao2za653FtdxemL
	 BUQq9LC4JAtF8xfCrXEzI/Xnx35IHzZtrXl4LYcFAOb3MHOIsH7AW9SD6Ua3OAwg2NP62
	 Rp14FHJqIJus2ZIMtb03jCgYeEhjq3c5yZbu1QMwMLk1FfOWZ1414LWtUI4BKP0+O1exx
	 dfYrdJEicXidro/P1NVEICljZon7UhyBeaYrMVD6crEd4fJtBa+9zn3gE+OfvnG9b8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="PLV/HGc/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ftPMqzyS;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF9A60A2602
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF9A60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PLV/HGc/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ftPMqzyS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=PLV/HGc/y0rLo7xsMH3w65aZtwNrlZK4QBbeq49ry9pLeASFAaPuprCgZOf66aKiVXSdLb
	riy/jtRtWxXIETXk2OeyiCmjuyql6DvES9Pt8FkxaQ35DOSPRByU9v2pXuA0ZUO7jraFsA
	MUREaohp9blCWC0GwteBzXyDgYJZbRo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-7HmzxlhFNSKdanyAVV0nWQ-1; Fri, 23 Oct 2026 11:09:36 -0400
X-MC-Unique: 7HmzxlhFNSKdanyAVV0nWQ-1
X-Mimecast-MFC-AGG-ID: 7HmzxlhFNSKdanyAVV0nWQ_1792768175
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af5a07314so629839f8f.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792768175; x=1793372975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
        b=ftPMqzySDw4nPGyHuzAqxupTAz9ssGKvfIFE4OADodvZ8rkYVkQZ9KqZ7feG+jVScP
         iscr83gUJk6/D3POTfpJBksURLfGHrnLNJpiuEtXGL7iFymEuRu5PeOABJGF7U+oLqQ3
         EpB81FHtumPOrb622NZdBhESBEZClZZj1Cs/gaKPyewE+m5H7ZNMMbVe1H4oLs1/Ejda
         lB1yWJgu4IhF1590b/R20RKif9Qk/Z0MCij0N0wffSsNeB1U3Edn5CGa5v6grw55lbJW
         M7lexB+h4OAlRHcKfRvAfap/SVoZ3gZMCrwUDuyVt6KP3+HusixUsk82hYmnTRvh/wBe
         X4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768175; x=1793372975;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
        b=BX1cKKC8BO/GsUAE5yfMmmlC+vBa3ho3YekvPITgBNktFBOwhFU1lhAv06eVwzC74w
         aJDWPrSqV8JP6E12L7DCpYALhy8mKRlL7nBZK1v43iZyP9mLzx/BITR6USSVocP+v/RR
         IhDcRX7JrlV0rGLkzd/4WEqr7K6maGludv8P6v3pIDZa8EnJsY+/fKIzDE2wSRN/1c5m
         ux9q1AzFOKLrZWF/lWo5QrUoVe5DYXR8v54C/ZlJXAIgzaAO9/lfJIY9PJHomTBAfJSp
         qy0sA7eECbqG9b0OnHjtqYD2Ec/8qw2RQaijig0/kvV7dIt0aFW7U4nQnhpzwmysDr1L
         Jn5g==
X-Forwarded-Encrypted: i=1; AKwUvBwuIVS9eRwDaYI7R2lJoLAHkluIcBLW2tB+MeUZFGCFtiXJOv12yYG+tT9K/MhJ1GKYi7NPmPk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIppdODLvD7QkBJd1JCL7DtUuP0zunh7DTB6kxCakTsQ8Q77B8q
	WqzpLgQhVt+xAjkfZi/AITUsXPhz6QsRyIakers3uQcdiySKdIC5hsLpA9Pv486kZXlSNeC9BWw
	VxvjXlQQ+kNRPjNSStS6vWFOeOl+tHTZDIKT45HeM7x8gc6S6Q8zUueDh5g==
X-Gm-Gg: AYBFou2mWZE8LW1XSzjVhnkDlgyF+JtbLhikXnYdU2ehUq14NTq6a3RoOlqfRvGmcRr
	lx+0dPnJHyhIhvGTUSE76zCPJNgD7yqpTbmzCd4n/Tv3shaKE+hpUEg73yMuSjZKvXEeyNgQWrm
	B9rxqebJ1RX4fZ3jOB1KDyG6wY26Var1yYtahScO2v8IHyqR82Lk/2sn+u29JNvgUy3AB0cdiB0
	03B81gZhx/EZZ+z4SlzZCGEFBTi8EbFZUuPXovG8EEm5sxVV/+/k+WQmD/MChmA405U2wl47P8E
	jCOrYrLl/pY8gs75upAFustp9weiajPmEwjJdQ8X13Z2+lDnpS5quSXj05PDL59lYei56z8=
X-Received: by 2002:a05:6000:4024:b0:488:79d6:a4a6 with SMTP id ffacd0b85a97d-48e38594e74mr3887740f8f.8.1792768175092;
        Fri, 23 Oct 2026 08:09:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4024:b0:488:79d6:a4a6 with SMTP id ffacd0b85a97d-48e38594e74mr3887682f8f.8.1792768174508;
        Fri, 23 Oct 2026 08:09:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d400365sm339853f8f.25.2026.10.23.08.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:26 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:22 -0400
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
Subject: [PATCH net v6 2/5] um: vector: trim skbs before verifying the header
Message-ID: <dbbe73d2ce720e333aa8fa7c58b7bd01994a4216.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
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
In-Reply-To: <cover.1792768096.git.mst@redhat.com>
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


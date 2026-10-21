Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569026;
	b=F91t5+lwUOdK98pwAmZ+GvkfEUENrFsNl3nPkpXRcT+VBaDHHpjj/fNzyE0ykJCmpSEQ
	 PMVxkRpuHQwXi/aSW3R2VtCNKBHobUQzHOY44WSR3O3zySIAA+zGzdf2gBA2EYcZSusEX
	 s0pznQfG9uUpWLzwq0Js+rjHDuSF/dzOR5/tvbuF11NmUU7I84IDNPn/JTETLjnMihNjR
	 oT0nU1t617M/YH9h+M28ttCT8kH0v01+xJTXLPc3jp8kA5oyn7TfnWYkOEZD1smwy6GPW
	 628D29EqCFL5A9zHrHtydeziz3Cbic0a7HddrLeQxES8K5cEUOtYMzettVby6w5ydjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569026;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Mailer:X-Mutt-Fcc;
	bh=i70Xk4AYsgpu4E10zOgBKBV1usiM0hwOau4g7tIhYPk=;
	b=LUms0t6LCl3ZcpN9eePGn8nDJ3/Uzb0he0VFkKWxxV09j9q4kW2SxeLLceqcKVGDylxA
	 hzb2Qn+F8dTX8Z3sX5l3oa1EqZ2N5KyjBos/DoTqeXDivxUgkQ9tnjPZcMdTZgtRgPKUD
	 95bdB4ViNMmOAw5gSR6Tq0Tyhvn2Bgb6sHpkHLCRF7OPj434nRvUKEhPRVdP+VJqD5lgs
	 aTNoRdANIL3Fd0pzhQVPAbEnwPR/Ndd55QLGGDXWtTRqK0O1zbJtYCsqx6flUvkKx6QQB
	 UX2VGQITaU2IEjlq9laDgQFP2UcE18fBiCZnQg+vho2lkVqKoqL1hEOjOHxh8cZHzVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g2YqDLeX;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OwmTbtll;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EE606A329
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 947EE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g2YqDLeX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OwmTbtll
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i70Xk4AYsgpu4E10zOgBKBV1usiM0hwOau4g7tIhYPk=;
	b=g2YqDLeXpmQQdSXJDheHKpWJiFjjdvh3mTWTlh7D4cA7rKruh6qYAYc0i7hWDK59bax9w4
	bzvr8hmAbIZLxMC/G1h8Mx7onlQUuFpFFw70S4J6fki/M1KaXlCHpMBZp6k9RoULQyT++R
	Nk4svhtNyOLo+Fnyd7jwKGVULNLAfqk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-G5S2R_9WMC-Ab0f3x17lSg-1; Wed, 21 Oct 2026 07:50:22 +0000
X-MC-Unique: G5S2R_9WMC-Ab0f3x17lSg-1
X-Mimecast-MFC-AGG-ID: G5S2R_9WMC-Ab0f3x17lSg_1792569021
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dfa054f26so310815f8f.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792569021; x=1793173821; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i70Xk4AYsgpu4E10zOgBKBV1usiM0hwOau4g7tIhYPk=;
        b=OwmTbtlllALC4EGOj+jn7SATPNy0SC/RIcjriGac0BMCNm3TBx9FbKBeah8fJLNRnj
         JXk2tHPtFvkh+mfPQoofmf5YlOGqYQvyswEo20hHzgrjo5cLWNwuyYy5o7blhOYaaEeT
         SA2F/G/eUMB1MpJ6PRHlTT6E4Cu1RrOIsttfjpV14JYv8GIfz+TULF2sNIBgbI+ttW64
         ZTenb5HZOUwidUSlRPV1bdGKw/mua0mvgEY+RvVzNt+iJuo/05GPb9MoOaC12Eeazdji
         gMxp1ChBOHOQEqmIdzERlzgpIY9hyLRSEwO0slz7bgq5ka1j52S3kLElkAEncME5WJO3
         P6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569021; x=1793173821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i70Xk4AYsgpu4E10zOgBKBV1usiM0hwOau4g7tIhYPk=;
        b=OyLqkCmSj/E0/J65Bb7bUiqyHF6+arqfCaoFto3f66/LeyVAJN5GLfF2YmosgIeCXD
         NMBeKtE0WOH55sd/DYn4JwITJvJqAZ1Jd19rA4pG8DErfQ1Kz8Nfrvpdp20Q3dg9OdJO
         VVovuLE5Q8Nlp1wDnL6YEkODginr7iDw3A/uhv3nDtw5sdsKhkHSA2GxPJwq9YIq9qbG
         ZUdMziV+BBauiQSmpoPUggDndpB/B5S9hPpDmQ2o72zrPq+/T5vfyxJCROFyGbctYsOr
         eo3lx3iuoYkkNdEwdNYZWrrGEJVZeciPN/142/+yPMsxB0F82XcJbxh7ns7TnsUsBkeI
         SAHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsH0Hc6EHUNgtHD/4xCZG+KhuxQEEVqU/lOOCQZkuV+7iWC9P0kNmxWMK9JU3zrJSe/VMkGMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3riFIeD/WmLocYjRxbOnQ884Igz4/8K3CwJulk+N2xt0cjoRa
	sBqOfIqe5vwOf9C8GHg1/ls6AGHCS9q+N7gZnszHXeIYqQ8a0RfV5Qvkb4DeymioSUXmsIoXxDe
	TRzp0yGqFtLowrwSuGJFfZ16kzN88YVysZOckjPJOa/2hIDpZNjQoOVq/hw==
X-Gm-Gg: AYBFou1tYlnnSsK8KLx47Bfqw4kUHYRxM8VXbPqKe/77CwDGs/B55MlH/m2nYsQw/4t
	SWTO3GgDk8BvMEhU/zL3es3g8N9hiCqseEnDRjR+/KWo6Dqi+qpUGEml4aOjFopgeqA9k6if5bj
	e9AGaU2y16cVVkazCjRXkORQkF+bm5w2d5SItSWpST8wT8bLCfY4AXu7InSn3jL2R7v9cvFBRb2
	iL4pVBx3V0vR2OuuGTjUubVg6AKUtG1FjVkmxjjLH5NeNhWG+t9r5l78r9o73gTbWgZsJNGgEoB
	H/r8HFdSeIgNuNLBfsKqtIetGtztaTh6zAqaEEvFjAJyKT8PGemktkHsk1RnYFrLtVsnfA==
X-Received: by 2002:a05:6000:4555:b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-48e264a3c51mr1444638f8f.10.1792569020405;
        Wed, 21 Oct 2026 00:50:20 -0700 (PDT)
X-Received: by 2002:a05:6000:4555:b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-48e264a3c51mr1444601f8f.10.1792569019847;
        Wed, 21 Oct 2026 00:50:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm4032101f8f.40.2026.10.21.00.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:50:17 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:50:15 -0400
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
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net v4 7/7] virtio_net: cleanup protocol calculation
Message-ID: <07a96514a8ec131b50c91d18a7df5f0d41a488b3.1792565282.git.mst@redhat.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

A trivial cleanup removing a duplicated code line.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/virtio_net.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 724ab8659501..13f76bc505f0 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -609,8 +609,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-			    htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -630,7 +630,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
 	 * set CHECKSUM_PARTIAL.
 	 */
-	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
 						 inner_proto))
 		return 0;
-- 
MST


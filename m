Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679873;
	b=IqJyD0Y1VNbstLb/ARJ+/XfnY6rskjfjSrAYeZ9kNZZV+CMSWTz9b/+Klsl9R4R6p5sn
	 RmCe075PtaP4oYq7doxbZmHuw7zmH26jWfSyBw2rk4Nha/V/AmDF5Iugs0jxIAwI889lw
	 NWdqufdFeJdc1/BBBSEAhAsHZnzUrgImObit8WGIolRF0lgC4um4smE/L1A37f5DEpzd7
	 9ymb7C2KtAuMcwhPAtKXPH68LheMo8Qvi0tDNfrQ0VdZOifA4jZ5eiBXYkam04L4oOmk5
	 1hwzTceudOy4GP7ZqEl6f7GKvnewr0MbEA0/KEHxGRTzVV0DvnT5kws9QdA+UOX+TcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wIEEgL0wnyCgnfYBD3fqLb39KxnaLSOeClNdZ/a2t8c=;
	b=1glZ/sR7dJLAYtTyLbrU30/sOJiM5j5TZN4RbsBCCTGgxUpIRkfZSZom/Cm8FHl0aK3V
	 xsHNMZf5nCeKxBLsFcWV2QqmpvEDJIte0iIdzNQBYPbC9i1n6OglEzWkNRq2el8hwxv5n
	 prD+etXiDdh89EisYcM19t6KNJnkjf4ZWowhD1m7qTP2tPBpmk5EHy9no3b7ORfTjWdBb
	 N3gM/gW65Q9ITMR+FvZjCUM9BUSEM9QSiz0Oj+Ga7uEMTmt4ihvG+8bmx35n/Dv+kweiZ
	 xrUS5YPQ30Z9X9ZzwfPvBwAn4M6+9DRGBjvAtpvR9N7YO7lv/bL6tvSWeZe4tkVi/Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NrW1wSYV;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F089606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F089606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NrW1wSYV
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so1758518e0c.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679871; x=1793284671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wIEEgL0wnyCgnfYBD3fqLb39KxnaLSOeClNdZ/a2t8c=;
        b=NrW1wSYVo/0BMy9ljHMzd7PivQSvRKB2TKTrRz/sIMlc+eMjlIYqpDmmn2Avr0192H
         tPwYeLcRhn9wTn6nPjpgMh3TYJnEIr8mCnTh6DO66V3uSusns2tV7B4QXQvLAC8KIyLC
         MsrvNL9u8HuVdfNVZkhvTXRNvnQszt4jmxZe6YqzmlkCdnZHTfUhsXR3+85lXzbsnTCW
         wMpfZUWyp6c/qeAhcALEV/Lf7/r4AEy4jk9PaK2QZsT6kECQ4kjik1uip8Z75fLtEKHc
         XloGcdQ4qkddT4uH1xxzERe5glU+Z2HsoM1jfijpHfTWukAcyyhqhTl+rMDePAAwOgVf
         O6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679871; x=1793284671;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIEEgL0wnyCgnfYBD3fqLb39KxnaLSOeClNdZ/a2t8c=;
        b=w6/q+O7uY2A+PY7FatywqBgf888CdXLYF+9BqrtwOFoEmfcA8buf1AOyxjqcXTNgqi
         72ypMe1DCCjoje+bNMuoHTx2EJPnJO+ECnNmEFtpaZRHinHyxh7TOWQ6M5eHFM14Fv2d
         w2Yga76hrV6mNJDJYBrOgJ112Cmo4h5lYLAwrNrF+GJ4Wtws102aDD6QLAnHZpFvKDkj
         3IYWgMpasl0TeVfbQuUaUHK3A750fnJ/4Q/cPX7anlW+koT/uLTLISmJiHs+kkFmq6PC
         O2X3fO6g8+JHUxcgNbVHJ0NDH4xzVtUKbHtYeByF6xLWkkKIt6mW3bcmwapTHORbGeCB
         d8tQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5WbFU/liXyPpWNl2QUf8/h+bMLyE9v/CA1Wc7Q5RwZNC/XY+UnP2aONxN1JQMg3czKBaBO8o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyak00UNd9r0ag0aOXA2JD4v5Gr5/TB+sgK935DkZ4fh4gDZsU
	RwpkVb+XaOMLigfn5q9ube/bpc5N2lzGzS1OVbAyjJQMvnrBy9RG2GYW
X-Gm-Gg: AYBFou0VLj7yLGIxKLON7JX8HZVUMELekTSpk63pSWQVhfsnhnsLzh3XtAQB+9qZuXr
	+gHBaVZu1yCPvyrBGjy/njuMOf6VHIAbyhajTZKoWJ67gC+KXcxMqlYCf9ONtYkUIIX0p/2Ccko
	6nRUlbLoFphZAz/k/C97TRm3Dbxz2O81q4wbdz59p1ewNv+CNMthUBcX7barHSw3zI7MXa86UlR
	RuLCdrB3WSULP1uYC7wdR2GlawSowbTQTonuUkqbfSDGqROdnAcTRKnlqYUXni7qIfBTQoE+Yzk
	6R/0m6qBI0lBtjC6Zs8mgjAlMXeiMTDBhiYZPryVF14wcPFCgLvQ1J7xkDFpv5/5XqOp8aFDK4I
	kLF+kHxEO6USeykGO8IYf4u61WC70qBn1ERBzDrWKH/tew+2eP6G0w4mD10LLg5b70cszZqi4I0
	v3nahk28sb1fTugOGx6CObWgOcdTncDkSuruHPuCjEZQUh6Svd8SfOBVNf3NA6OBOlcE1yJlbtR
	mwC7zlRtHw4K0PchVIPorh5vSzCUssbcB6nExiL1BBTVXDXS7vE8H6opS1elC5EfIILglKjVAMs
	DeWfx1ltVnZO19n++M3HOf+pDaGLrk2N4HqAxvny6yY6sTIaGpxo6CfL+rWB+k360OMXM+1fWHX
	QYN3N0wop5sLnfMDBtwY=
X-Received: by 2002:a05:6122:2984:b0:5d0:1207:b693 with SMTP id 71dfb90a1353d-5eaebc25d1bmr2672346e0c.1.1792679871554;
        Thu, 22 Oct 2026 07:37:51 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97be251sm6978325e0c.8.2026.10.22.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:37:51 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:37:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Simon Horman <horms@kernel.org>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.27710620cf132@gmail.com>
In-Reply-To: <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
Subject: Re: [PATCH net v5 1/7] net: account for ingress-resolved virtio net
 hdr state
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> The following patch will add ingress resolution of uncommon virtio net
> hdr checksum metadata (software checksum completion at ingress) which
> adds performance overhead to the packet processing.
> 
> We should make it visible, so a hypothetical workload relying on
> uncommon metadata can be distinguished from none at all. This way issues
> in the parsing will be reported and not quietly pay the host-CPU
> checksum overhead instead of offload.
> 
> Flip every call to virtio_net_hdr_to_skb to test for negative errno
> only.  The um vector raw transport even ignored the return value
> altogether: rejected packets went on into the stack with their
> metadata unvalidated, so check it there as well.
> 
> Have tun count these events per device as rx_csum_sw, exposed via
> ethtool -S.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

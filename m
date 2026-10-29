Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300019;
	b=JTlXtG7u+1fIhKMacxHtW0xZ2a+Xnvra4EkK//71tj014NEAM3MFlWZGFLGClp0WyB2E
	 cAQOoLDK4a0J4SW/tAxkKa1THovF4hHUNLKjFeGCcc5GT7F9wJb6G5KMCnHm+UlAMGph/
	 yva/3nPPbPZQ7pne6nUJVg5yVBiLOsEPm0A4TOmH5Fx0enLvFEiaAiwhvxFkVvcGOkKI4
	 UGjGPe7anonEn4kX6z8wkhGSKMgrKdtdtUf+Rkk7ZQk3tik3ffBisMsf06QGWQZz858jD
	 RxtBa/gwC9TMxCeqEC5ldcOUZfb2bx0uC62L+1jl3a981XSxpotQYj3XQPakTYIscFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300019;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=4yuCvTwP/PbTH6yKatxg+oiUsOHY1sDQfy80ONsRCoFDNi9lLrCqDsIoPjKK3mf7xA4l
	 bwlRdTiBjRZSzuGaXNe3AR8U8HwHpktqEcZFZduQcoiT3xiHYUr1BjZwRYBxXftcBB47m
	 fe7TnD+lzFVsjhtwL18H4n8W5hYVz1BIiYKTPZERNEQA7yBkJjmxnqxErjbBJKtXvSB4j
	 3l4Sstb+ACQOd2/od+y8aS7by6+q/TpNuUa+eiXiQ6grBdWJcetPNG8gEZlLzqWop/f9Z
	 LMGaVhlcWGkBeNVaXAdISdANrta/eAuyxMmum7Kwqy/VWjQsXO80IIVj8SqzaBYIuzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CO3r6yuz;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tkMw10wp;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9F606A322
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EB9F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CO3r6yuz;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tkMw10wp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793300017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=CO3r6yuzlv+e08TjKgtaxur04jZs7uZNq8t5ZjYw//6DW6cdr7dw+/SMJ0XyLvZCsIyw3u
	q335Kh02+azPuvZYVbqx7hqK0L11xEMWvUjtouDD5PcPjVsIUqox340neCvctzQwUYQkYY
	EZ9q2PtQq/7yoFib5UtCVS43qHbyqLY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-0zhee5ypNsGiyB4eDhDmfQ-1; Thu, 29 Oct 2026 14:53:36 -0400
X-MC-Unique: 0zhee5ypNsGiyB4eDhDmfQ-1
X-Mimecast-MFC-AGG-ID: 0zhee5ypNsGiyB4eDhDmfQ_1793300015
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e00f3929bso649544f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793300015; x=1793904815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=tkMw10wpVbPgHYRYFq8YSQPkCgiZCFUOTbvcM+YXZ2yU99ZJ9zvJ6s3+vEybsGNBId
         a8B/t9IugEOEqAnwZsE6XH7DoSUQ9nI6v3GPJNCmyqlnN8ZZCQdUyTprKED89ZmTLSlE
         ps+Eob/Rew5pQMSbv8AeMEsgwGcFu8ylf5h10dlJsjIRR4vXLOh4TPFh7qluEla/YyXq
         /M2b1sC+4c5M0u2UnFuML4mVuc+cP1FDX2R6S+QInsajPFv9EgoBssmQrCmsEbdVv+dh
         0i4Hq4DLX6+D56ByIi3od3ifoxK875HpH2ys7UOU8uBTpkiMCWgL1RurDsfAJmiY7kxY
         1KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300015; x=1793904815;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=HObaO31PBGW+WlMCGN62b89WG1xee//Cd6ZUTyKxCCj7EhxM6M3XFnExGhxEhY+2+3
         CZQ92Eep+q8CrKLOSNg+fXfBMTKh6Km3sZ4bjCEk82CcY+wTjmxFAV0UnG0kiAQubX+j
         Vnp2SHXb6Hgpc98SJc+1BEhihd7Zh3+PTMGj7uFhh2viA6TJkbMY8EikOIKgo4wRdZHw
         BDYFZa81RHRmCMvMJ5K1ydT5VWpG1VsGOoiDF7QuBdAzOGVwWc+VAMEoWNV/K1K2M7J3
         Gkj/GFxBhFU1gvyWIffYmFX/ijQLvWJ3C0tiTnHF5ZdMS4GR9yt+LKUFG+VS+7Jag2PI
         Y/CQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxMHqGwgIFm0excjmnoVlBxaYTcd525ycnZYmygE+uGM6BR2nNjBzwEESSrCjYV3Z2v4fwYVM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYxx2e0VcXz7TdLxDTcRx1H74FB1EQtqyZBYIt8G0BQnXYRhLa
	atFiTXLsQDy1u2n72y0n8cH2XXR7AfCKBrq/8GEGKmt5Ju3Dxyg0rVprgyuYppCg0zDQcvtS7jD
	4xyjW1vkfVW4zKXBbCEIOT2DxS90VnkhGRpnKCBmd4Z7v/D+tzN5FVZzOHQ==
X-Gm-Gg: AYBFou1mZgDfIM9yDeWe1t+/orHXkB1I3LsRxK3gUGpZLp3+/lYpQ3KW//j1fsEka5D
	H8usVlBGjbVY6lAwtmXzIh0cbUdoFst1HSH2OrQF1tXJxQwtGaPTgWjzWaaTq6n1F4MJxSD+4Xz
	hRxKIK7lGbW3n7k+AY4/ekkgGUYk9Ixq8dd7cqbKfA8xQ73Yumq7taujpksN6kqVYjPs87koMuu
	fQ9Yjd03FtqFSNAS/txkGmE4eSB0e4ZtnLAQ3SN1L6YitZ8Dq0/1CSyl7KL3Yr2Xfxf/m3XjNJB
	/tS8coa9fUjaUNIc6EJIAIeiekHyMvPj0oN0gA484qoFeTSeY0SWSfmt1x3ZciEhdb63N3Oje4Y
	/HI4NB65GfZgoMxMPMMVfERSwc+qPCKiLUW7i3j5UaQco
X-Received: by 2002:a05:600c:a301:b0:4a3:5d64:e063 with SMTP id 5b1f17b1804b1-4aa8a7ac897mr77300145e9.9.1793300014632;
        Thu, 29 Oct 2026 11:53:34 -0700 (PDT)
X-Received: by 2002:a05:600c:a301:b0:4a3:5d64:e063 with SMTP id 5b1f17b1804b1-4aa8a7ac897mr77299645e9.9.1793300014037;
        Thu, 29 Oct 2026 11:53:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb75bd4sm222321f8f.10.2026.10.29.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:53:33 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:53:31 -0400
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
Subject: [PATCH RFC v7 3/5] virtio_net: parse tunnel csum_start little-endian
Message-ID: <0817358e459a9056af2055a8e2f466c4807ac83b.1793276116.git.mst@redhat.com>
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

All tunnel related virtio features are > 32, so none of this
functionality can be enabled on legacy mixed-endian device.

Accordingly, all tunnel header fields, csum_start included, are
little-endian.

The nested virtio net header import parses csum_start that way, but the
inner transport offset is parsed with the endianness specified by the
interface.

If tun is misconfigured to legacy big-endian mode while the tunnel
features are enabled, the two parses of this field disagree, and the
value stored in skb->inner_transport_header - which is only
bounds-checked from below - can point past the end of the packet, where
GSO segmentation later dereferences it.

To fix, parse the field little-endian in both places.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..013c6c7e2dea 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	inner_l3min = virtio_l3min(inner_isv6);
 	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
 
-	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
+	inner_th = __virtio16_to_cpu(true, hdr->csum_start);
 	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
 	outer_th = le16_to_cpu(vhdr->outer_th_offset);
 	if (outer_th < outer_l3min ||
-- 
MST


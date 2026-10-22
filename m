Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685393;
	b=VB7Lgwt9p7b1vbIt6YfXWvhaTSpMoaRvbFfavMNVFjotP7Pz88gdf2t289ZG49NyClQg
	 q2CQA+eb694xjizdNJ9987PZTPrmdAUpynUYg07/Rou4gCGWQom+QZoxFVGzsU7EOTbTa
	 WXbpY3gMLpgTWYqKqPMpTWLqRY4MgghNJ3z/NvtX3yjOax74Ef/9c1WlSknqFH1y9HcwY
	 yRUHtHcOt0iMdI6MDdO1MDOPhOHmD5mItUmfgai4C0LpX1n+kv7nqFBPCrwA+vMQ1PN24
	 ijz7elAtr5EGJXPjP+QERBgIUKM2WWvuQW9kc5FgtOJLPsgRFqp+0v6KX9qHno6t0kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=H8x7/XkTJsQWhqAAmf5sC1iGmFvt1Btlq5a0jfg+eY8=;
	b=2qIsF7pKp9PAG8d8pnYYWbCIc4FRXUqq6X6qgEiTRh9WnIIj8kRRXAuHg6400j2dyifD
	 kPrNJS86vDzqDHrudV0bQ+jfTaLehgEXWUB3UIbsSSfwoQ+K1sWB2UT+BecxnBIb+CkV4
	 WbMROH7NpiAJjMR0htDkHPIUJjvTcXOT0XZEJu5e7/y+4K6WDWrGOVdrcXa8Il1Zcg8MR
	 0+nf8GKMjzWmxHonPWHefARNpV+Y3zSe7DHKBd5uzZBLMYUhZRZP0R0+ICh+nkzAZqUp/
	 Nj4CC3AhFZProwT9ATOaPX3NpmNyfu+zbAiDuy5/68Kyq4WLnWh2k4uu42CkOEUC0Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m5mkMEEZ;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFE606A335
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0EFE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m5mkMEEZ
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so2774629c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685392; x=1793290192; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H8x7/XkTJsQWhqAAmf5sC1iGmFvt1Btlq5a0jfg+eY8=;
        b=m5mkMEEZqLfTwUHaBmsLpdZ5y13wEUKcNOAJT0yJhxPbtO7IRodtkkgYINFD6KxvDe
         +gDL5iG8u7N13qDm8ZdvGkMaHn2JuqpqOecdWFqcBPIrs/RN84DfnUECVHgeeJdYMUJA
         5YoEoajUAeZYFyIwBgdLrMdvvS9b3kx0CjInjRdXHK9o7KRaBADTPk6V7HJ5V8CcJ6HR
         88Ge0qKaysxr1UBbQUEq4n/DfiIqw8P6qH8XjmVSt2v1fBcXgQP1gE3DXe1t+VwjhMzl
         0/7QgkxVtwlY9slfz+3e3e0LLTIyhXFdgmwjvviVaEiszQ3M+zkBbkPgyJBKQ18x5lue
         ULow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685392; x=1793290192;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H8x7/XkTJsQWhqAAmf5sC1iGmFvt1Btlq5a0jfg+eY8=;
        b=sGjrtqMLYuiknKkXINS9vSFKRbVXXavjK0+YNuuV70ve9oxjx5yaWOouYnI0lH/H2c
         W29sYsZO5cDvYMJqv7fvJwNeQkxieK7IiKCRjNcxXM5GHywsREsQJKCrBCjjWLFHbYi3
         TweHHQYFOhaRiWe8SRmEMu/9fxjm6EXQ7//8MnHV2HfmzNUUc0xQr/nMxJPFM1uHGuXX
         XxIKAtwWAsT1so4BAzKcCriBy+QzqbjR8mFzrom2acm/ocnhmGdYf3pUh0lTbxsY2CZ3
         dcEwap8/KYFaoTLC4Cr65CLGl8ZrcBBosTGIqTEDsasy6RqU3XkWu1FeFCr4QqsVTT1B
         J9Cg==
X-Forwarded-Encrypted: i=1; AKwUvBwqc7XAsVbkLIZRAS8Bb5sgBWMGjhZbzSWjKRLEUzbwAZY5qrAU+xtjRGTAOAD62VIJ4aP+KhU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeduc5Qpp8sCFxcl5dcia3EGA+ba0sSF6O6g+PMP0raUbnxak3
	Vl2vGW1U36/GJ+9+wG0lyhX/FkNap+kjIOJQ7CXApsJTHVkrUoxyBp6S
X-Gm-Gg: AYBFou23rJo1+SRX8nGkaG1nMv16Gl+tmPBsigvO94QPIb2HO8WOGfEJjLEAs5Kev/f
	9C8WzIcSgzdEgMJoJUEqEP3YrjMl39Fr4/Wz1YFvrDtyFfrFjuOtsFI6XwRepXMkeksPw1BrudA
	MFnjybhzafQNWX04vjJ4ErvKTcXVIQU3qlcufgkHW4Jb86qhr7Hg8Ag8bJXh1ZBsGc/UYslYbY5
	XNHqH+OvvkEmLbcChfg5ZjiDX9RGtZ+LbZS9wePxr5jF3u3149h/dfDYo2Z2vLzmkYRw6z+NDUD
	r99Lk5TQTTThQl1h62VBOIEy9vdN/3703GN9GFvlgc0PLAqTWpl6W/eGtdyQR4gAu5/+M9VYrK5
	myhKnhfBwYS3lZluC/Po6JDge0bT9G75rsNJjnIkDaU2R9ipb1oLSbLasNmkuEHWLwP1AKCmAqq
	Kv2K172l4hwXxZrfGX5swcH79io7INiflTkfEKaT1MXm4CNrOJrNZ0UCDuqvrjoyDaRexMH2AY6
	PeW+vNDLuFQS58FeHu4ZFA9USqCLiBe/dX3ds1GlDnkLciLQ0r7zkIL9hXcM8R+q80EhfcRgU+Y
	/jO9
X-Received: by 2002:a05:7022:b88c:b0:138:148:6a28 with SMTP id a92af1059eb24-1933bf18b4cmr3304575c88.18.1792685391652;
        Thu, 22 Oct 2026 09:09:51 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm14594124c88.23.2026.10.22.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:09:51 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject:
 [PATCH net] net: virtio_net: decode tunnel csum_start as little-endian
Date: Thu, 22 Oct 2026 08:26:48 -0700
Message-ID: <179268538303.70821.1734486381476363942@gmail.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

virtio_net_hdr_tnl_to_skb() decodes hdr->csum_start with the caller's
little_endian argument when it validates the inner header offsets, but
then calls __virtio_net_hdr_to_skb() with little_endian hard-coded to
true.  The other tunnel offsets are always decoded as little-endian as
well.

tun passes tun_vnet_is_little_endian(), which is false when the device
uses big-endian legacy headers: by default on big-endian hosts, and
after TUNSETVNETBE on little-endian hosts with CONFIG_TUN_VNET_CROSS_LE.
The validation and the parser then disagree on csum_start.  For
example, the bytes 14 00 decode as 5120 for the validation and as 20
for the parser, so an inner_nh_offset beyond the data pulled into the
linear area passes the check, and the USO branch reads iphdr->version
out of bounds:

  BUG: KASAN: slab-out-of-bounds in tun_vnet_hdr_tnl_to_skb+0x74b/0x830
  Read of size 1 at addr ffff88807999d044 by task kvd-program/9399
  Call Trace:
   tun_vnet_hdr_tnl_to_skb+0x74b/0x830
   tun_get_user+0x1827/0x3d00
   tun_chr_write_iter+0x113/0x200
   vfs_write+0x5c9/0xb30

Decode csum_start as little-endian, matching the parser.  Callers that
pass little_endian == true are unaffected.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 include/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..ddc6341747e5 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	inner_l3min = virtio_l3min(inner_isv6);
 	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
 
-	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
+	inner_th = le16_to_cpu(hdr->csum_start);
 	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
 	outer_th = le16_to_cpu(vhdr->outer_th_offset);
 	if (outer_th < outer_l3min ||

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1


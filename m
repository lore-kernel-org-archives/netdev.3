Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569006;
	b=sL4ol/odpADJZcgOe8wbZRslSXPSvX5XAAe7T95laGVIf8d4bIOhGwetYEQPR+e1F2mf
	 gIQJe5LVFSU+9/9q9B9rcCYafGwBaMZQm37edaXL74U3RjuuQbQX5phiR/mh2aJJAV6Oo
	 uLjABw35D/xxuC1iwEfqE8/wGP7D1cTKcqfdxbM1JwPDQdjXZyhtqgFjIcrwLBB8/wnWN
	 G1d3FBuuy2Z6jWDO+BRUM/bAvBZciKf4G4o3ENdOXsrhcfYSADRhSlX6rc4+7tIAXU4eX
	 ecPYp3e9hZOus7GZor5zWLbX/LSRXLfwebs0b2dSLrEEF0AmO4nLqjbHMKaF5vYWrLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569006;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=GyrwRyOMsPypNl+uRv7Sg7IplZt06wb/exiwFiFAS8S04tmrsQtCwdiKVFb0ZvOE/Ra+
	 7novs9D55xVFPXibS5YTFTeuZgzt7lHmhdi6jONV1ja1ZigfT8tpFkKRqLLMMS/6sVJKc
	 9bcPq8FW2obS/7ol0/BsCSPOciLDaRjMn3h8ZTdQyDbvHX2br8HOHvN9FgMq0siRLkaGV
	 fMr4ajASFrj7FrQm8cKZJW4e0rYz9/7VRaddhBUnMaVB3+u91+wj72JxzLdPqzCH4QYaR
	 bL1VTX9TXATbTIxkDWEVekHbnrMCMNdTTKKis+Iwt6b/nHZE0rKH05dkzoj0foGZ8Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BeNOOFX7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pG9wsWgs;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D8606A31F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A25D8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BeNOOFX7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pG9wsWgs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=BeNOOFX7zY0CcblKh6fdU18JKp+yzx5ECQRwEKnV4FzUWRVwwh5etOFjJgLVg2wu1BrgBp
	2ssZEBQyacWBusYTZczQhwX04Zm1Dc475RC1mSYYUYL3CIxw41oKoN5JlTfm7Sl6+l3ctm
	yQXOiBsB9cBXAc0TQ0jSPZkOAZRqB4E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-QkmpzU7mMBqPGzGVEnSufw-1; Wed, 21 Oct 2026 03:50:03 -0400
X-MC-Unique: QkmpzU7mMBqPGzGVEnSufw-1
X-Mimecast-MFC-AGG-ID: QkmpzU7mMBqPGzGVEnSufw_1792569002
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a16faefac0so2207545e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792569002; x=1793173802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=pG9wsWgsOOyDxU+Prd75YNi5z9L+VKeAjS0l7E9ioSIaYWNWpq8IvzsFc3+oTUbCA+
         /hQ9lbBFfMDvvYvS5okDmqz/aY62OiNzJMX2uzfa8ifWYR0En9Qr38RGQkqOqCaMFcXQ
         mRtRTbkRrB7Oi50GF8eZ5Qc1mucnufP1AjzqcknLCvYKJIRWtd7X26niNpwvDd0FDQvk
         m8PSU3J5PT6AVPTM0FII9lvzWRyd5WvIJ7E4mMqFC+jxk/38bHrzh1lQmm6bFSrd3TfL
         PXt+0mE4JbL2++HIRngn0t4P5X5JHjGKE1UT3j1xPNU83cZyqvck6ssKwOjfHuXhvhiE
         eKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569002; x=1793173802;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=fBz15Is1gUw4bGmKgbjoZVbbV8b6os8+ftSWUhELvBJNo5RYJTetsHa3mYi+KJAL0M
         fo6FFrG3AX724IyyVSmQ+fbovS/qq616W/pXcfEch0cOovBZiGVu8a4VIi1CLA9Fpk3T
         qkCh1c97jj8nc6Wa+SjJbhW9VQR9hP5b/E524NuI0iaaC01e0G1BE8hEKg7ksFSd7jfp
         u4F6FVuOeedMM2yRmCfo5VkOU1UvBx6gweQ7Pgi5u68vE2zVfrX+ssgpn59d4M4HljC/
         Q1iMLa2VBvkbJWeMnUtvHRNZtCEKL41Mnb1IMxWF2DbXa3g+r5+nzfmeC7yG1SsVmxjL
         2M1Q==
X-Forwarded-Encrypted: i=1; AKwUvByeUqtVHJ67iuit2v6sWWb18nRAI6npu7E4WFT3bo5gqTO3PeUiMxwFKRiozxIzoL/LIHRnX6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGJqubDgXt8XhsZmNHG3pYOz5MoCGGbrjJ2sogs7l0tuUPsM8N
	2GxYE/HHSW9Q0jh6krVRE6ao4dMUdpO3rSMV0b0P0U8MbZLbVIvwAnNExXovcKGyk65xQhK7Cr5
	za7PIOf2njD5LkM3LLD6vxmlrC9hCI6U3WU16BJllC5Nfh82dza6QiIqNbA==
X-Gm-Gg: AYBFou1SEQjHE0GMyFf84X1bPFTCwJB3k7ndVltP2j+fsKX5KthLaJiUrhEHiPeMQIA
	W2NACH0KqwH45juib665OgkewQ+vKvQn+OS3QhfMfSBcdf/Wfwkc1N3vBWLCEDS80XI5y7Bh1vd
	FAlHPogpwo2tVaSXlhgsfdYDVcUuPzExAvem1wfol7e2osWINSghOKWHfs+9Wzsg7zm19gn/hmg
	Q4vL7jTk7tZ+/D3mmgNgLpavbi0MEjZDH8aly2MtVCDMbukWrp/28Cx4CsR9bI2J0XSiFx0ig+2
	qoDy8HubQ8XgSo3FGHj70tgoX09FIkDW2JNU5jF5EaAiDi0PxoFnZUBFxvUYv8VWrocQVw==
X-Received: by 2002:a05:6000:400e:b0:48e:b62:d134 with SMTP id ffacd0b85a97d-48e2642cde6mr2376551f8f.6.1792569001842;
        Wed, 21 Oct 2026 00:50:01 -0700 (PDT)
X-Received: by 2002:a05:6000:400e:b0:48e:b62:d134 with SMTP id ffacd0b85a97d-48e2642cde6mr2376500f8f.6.1792569001336;
        Wed, 21 Oct 2026 00:50:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e54sm3949620f8f.27.2026.10.21.00.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:50:00 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:49:57 -0400
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
Subject: [PATCH net v4 3/7] virtio_net: parse tunnel csum_start little-endian
Message-ID: <421e7ebb8173ab919c2b90b945aaed462145583d.1792565282.git.mst@redhat.com>
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


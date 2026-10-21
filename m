Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598935;
	b=xpwKiZds7bc18NhrVKcDbmD7k6yfoYQUb7djp9SHhi6g6pb+vJ8jBF9eB3Dh/MNJu08u
	 EQS4r6PRI9u63bi++NKWgw1+a+RktLOyBz8CoYAzU/JeHDlrVhnmfyCZRK4f7YT5sQQrz
	 OoB0LhFGim7cqFQDf8mpshEOEn9WBZWAjwutJN8Ncg5IsTNrp3NiEi97GOLkprO6iBrVT
	 iVzOXfRjdjWFclXhdTGcBBPdubvYreQeljEL7reep4QWOqO3URZQLA50lWT4FeiI86rqk
	 3XuPVzpPqbYceyeYt33a5eX7ADfZ5bqIrmNewb8jUCuQATgKK8MgE49Uw4Klgdcef3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xlUjPkBFZR5E69M180zZ7SvybteIZBcwvq7YyxzDeRI=;
	b=sa6aQqqxZsaraM4mRaahYyk/iAALnVZ30KXojOrj/6jwx5Kf+SHYEvqN/Ggdo/RpjSaa
	 6g8pEL2O7Li/zpvzuvz1cQIh0TVN0F4Gap+NmxViWjIcU8APCf+q+zonYg8/etttL/SNz
	 fIIz1hK2dE9bpFCwrT7U/+nVU9CtW1Y/ls+OW2LM4U01wuXFHLoGsJliQOTnRWjsEpV6K
	 LiZwStwu2yn9W6tq9m/PE/wF+JYEbozEtVyFuK3NBse/RhI+XBp2VLktsz8IeHsmjPAkY
	 u1v5os7BgDFgj0tAl2HBz5Hc/KoPA79rvuMNIkQ6dujrIa9uJttA9EE6FB6uSjEgp9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HmkvCJ0v;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD68606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BD68606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HmkvCJ0v
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so51012241.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598934; x=1793203734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xlUjPkBFZR5E69M180zZ7SvybteIZBcwvq7YyxzDeRI=;
        b=HmkvCJ0vaUoa3UQ9+bVmx9GYBeGHPBtlOLf0CTWX9WnMkwRafYNyOSLx/EqFn7xC0z
         FeBLtVw9Bz3lADjseMfn9oWHJIVBJFAk99ataSjSPJQ4In6UetErxE16KChScPekSOyw
         MjpI/XW4ARjyQ8uPN8cvX8u8hYvhwIw4umZj2dxBiVOtWqSaa9fwYG3a201xAy+AR3CY
         3AVX/nMuip49a0S77opD1Ad+JdBVu/RlOSXBN/Vb0/zuJ8lHgUed1jUyiMv492+qc6lw
         5BvuP1Yi5jTt7Y3apvAZncY2fEhGdxDTG0tcV24vI3so6jisVt42aq9HO4FLaNKopDfA
         kgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598934; x=1793203734;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlUjPkBFZR5E69M180zZ7SvybteIZBcwvq7YyxzDeRI=;
        b=i9Y+54duJHLL90nlWLjKMfAwK46rh5rAvPQR499Gf690A5eo0NxgzWnXcescHPR1I4
         IJcNza3k46I28WYNL4QmX1BjsydFm6yjlF4Wm96KrBE0rxQlnCBRUnuYLcLF653Z9vPA
         UMu9lvpu9+TMtokVj7GykOQvYVT9ti0omIO8YsGg6C8QcFeGFYiWOxUU93kXMoDHIvm7
         mRdbHM3vckm/QO/7FBJ8Px76lHGiQcj+dgD6bls9mVwLB9PdHVK1nZk8gSp6V0/VYFtR
         phTqQ0r8JRq8oa0EsAQzwFpjdh+jdOXi9DS1Z7qsHvAd8s1ru2RuGyIpDJjmaLURStjC
         +SnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDWu3RQ14jtQ7WijrySveubx5MoOnpQUUGqEHgyBe1eMYz/SGBp47/RwIdLUC8a1Ujfnwgbvk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK7Fhxxh7drqBS2O6I5hctvCeRc1vw8jLl4fVDJjRKwRLVvgmk
	9nNjTmX0wU1Oy7/03TqF/mySLG+6Zs7hDY5zglA/6VBJNFte9wM6hMbz
X-Gm-Gg: AYBFou3ij27YcW4LFJKKvbczXgKY1jRfuweWoxCdU7dYf56KUsi2YPIKDYDv2BMG87o
	WuJluoGjOLyv+gYTxk0BGhQ77TIvRgU8PoRGQFGDkHcM52V/exulQSLJyDqzoB2PUmM1QM3ZZHt
	m9MBPJb3Z7F4PkfFUr/tRRWYGV2F6pqhRZcHDYXa23G+g7xeG0EL7rUQVYO3ufp0y7tu6OvQ73B
	bde3aZSd/kItbRTSoNYNboJ/yWHwtwv+RcXok1QT/l6gEKzr9o4dvhKCeEC9GQQolwcRVH2W2yF
	F46W+t3wM3veKs5pL0ECuXtqIMABOIjp+I0WW2JbASSUvKmR3Xc4xMR/HsOhoLbqr4G4skqjiv9
	rA4tif+mtKHIXkSU7s3Sjq8Qsi0cZFblqYxyqHBSabkGTsvYiYFhZ6A/RkWGM8kqEBsVmD1+rR/
	QCEFsFUqDidR8MMSaMzRiecsRE50IUNtaN9m+LZ5thpoV/ZlqDbquswgf58sk5ZBfkzf5jnlXLE
	+uzg6wURsikcdd+li4W/JhhvPOp6yhv7cKt5mVXnrRDr0Qt5SJsFsxVvUJ6p5Sw55LKSqLKStYN
	D5s9qYAQOgi+Bh9XMGHshIqbUi6Ug9HFpBrvbwgiqpQTnG6upVfpJ8PTWzZ8BTrBlSOItvCd2j3
	w8xyq6Ihs6WFwxCvX5HA=
X-Received: by 2002:a05:6102:21cd:b0:7ca:9674:a58f with SMTP id ada2fe7eead31-7cc7bcdf51amr1136476137.32.1792598934205;
        Wed, 21 Oct 2026 09:08:54 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d0e0ba56sm3638029241.1.2026.10.21.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:08:52 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:08:52 -0400
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
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.186235776c7fc@gmail.com>
In-Reply-To: <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
Subject: Re: [PATCH net v4 2/7] um: vector: trim skbs before verifying the
 header
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
> The vector receive path over-allocates the skb and only trims it
> to the received length after the transport header is verified.
> 
> A follow up patch will complete the packet checksum in software within
> virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
> checksum would be computed incorrectly over the unreceived tail of the
> buffer).
> 
> Trim first, so the import sees the packet as it was received.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

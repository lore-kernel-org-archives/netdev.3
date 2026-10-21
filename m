Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599249;
	b=kBgYDPBHjrc3YKPHl9KophM3b2eYfOCMDoXCJx1Zgk5NCtFrffMFtje+5KjGdD/+S8Bv
	 peH2ITDCXN1hCasZYqPuZ6K4wrFFF0RoEXQtYksi0O2IHvq6e9J48rbbgDuvHvKEVBP08
	 BiJdCdT71z4aob2ECm+D3GDTSuytAg/UfR6oYCHb/h2pn7+4SiATfGZIxT/43V7Nr7LH5
	 7mLpF9CFFzANbCRGNqtwrPiS0mzmrLcUfC3Ko5UR5pd/ZPikOvKqrThESwL60H7v+e2k7
	 qgczuNhEwyBFLqQQBI/snp6fqMsJIpE4l4ATZShChN95wegemm0/AE4cvpmi6MrFAQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q0CCx5zBhN0UXD1LzII8NwADZSGCTEpTQppyCBNHFl0=;
	b=PoQaeoCrb9TXnURjpP0bUouDEjEikrDaX92Ic6aUpDv5sUez4U19ORjZbqnTdsQWtlsy
	 B5OuViomjzRQxoFa+GDEWHNYiVPgiTuia/8LKuDor1YrZj+339ICTnQGotjw4+3Igb5t+
	 +9tNlcAKIaV0BNmUho6ycPa7owaSkuA6qygagsyaEU9AqQmRFKc+uqw/ckBRxxBYXpIlF
	 6CkEIGRMBYO0nVRRdUSrLN7erjInFR6LckPXw5/CKoqAyW6xjEuIfEug/sQQpvny+ZajU
	 mBCVt2w3NNdBjLHWG6eoMeoyCAVx7jUNU/KFEXJRJ0hBPqsxvcyFCzix+M5kyG17yWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eF9pnWtd;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392F606A579
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B392F606A579
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eF9pnWtd
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-988c7371716so336613241.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792599248; x=1793204048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q0CCx5zBhN0UXD1LzII8NwADZSGCTEpTQppyCBNHFl0=;
        b=eF9pnWtdEq3WSD4Ywhg2iwjsDFp5Vh0YqyOff8MBi0QVXDi4dFI46ucw4bYE0op/+c
         1F/qQIca2RcWZT4iN16zIt1jWr6ZFYOiPx9NN5cIkrrEyw+E/XH0M9oCJYdMW6cmJZcB
         HapzSaCJ6Opkp8aU4ZEUL2hO9e8FoaEavrrEuUBWKJdraCE/iHTQLPc64bikh1s7kOOi
         qkO1DWMjcGiIWvUep0Dd4+Ne6jedd6II++fSimRre7snR1dbjRqDlVKEcXELVQAlVMzZ
         bQZuTLez0kGOo5H4kRJL7y2JPFlYSN1ImhpT7FJeSe53zlqDA7XbhzQw8/s4+WdLqc/T
         ST9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599248; x=1793204048;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0CCx5zBhN0UXD1LzII8NwADZSGCTEpTQppyCBNHFl0=;
        b=p3Iq5fwnWQfCijRlJ22mii0mB3cGv5ndnJ7VjjrUWfRLrpwai8eChgKq9Es643KnIZ
         rjFfmP62G/M80kSG6BZZnT22WK0odG317m3dFT8zJbEzA4wSgYCGaHTVWBl7d8eDi2rX
         2nqr36mgoCaNUdIg6vfQoDM48ARc0FeRPdh1DpoT4rGBVAJyNrKIEecJ+iFa4a5m+oss
         OfxYnjAuvvJkay9YuMtBhCieBRudQSfjX8c15qd9x9fA2WOIoin9JAyw5aZy1/uVrDY+
         dEjrGh5aY1/8UeS1Ig/RLNcDotGP8HdStA4ffWmtS/i0wvk3pqw14oLwBYQ7Kkq5Dj8C
         fSOQ==
X-Forwarded-Encrypted: i=1; AKwUvByjaDmq7RfeljA2GS0Hu7YJ6fOnP9DT3U7ZT9HKASnRQkoVo+J2+fWSeWDHbKkPdYkrGMOBSsE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKv994JD3MflvvZkPny9TK6BuX1W9e8WC5HAib1bx1igkTvVSUl
	y1sTlplM7UPrMzMNDb7lmvIPB2Y5yHPh7hu7sFEMnlR9vY0JjoRTtxnt
X-Gm-Gg: AYBFou2vsDE9mJPKKzv+T2ZoY+BlkaJw9X9Xf3glDpzJOFVy0DD6DTyE4RhiFEeUWW+
	+avHhLhA8+isGKp0vrkDCte1j705PA1ST7tQz6xcBNRMS+T02dlJxOiguUyIiIQCaJg7nC/dIEA
	+DTHVL6vdG77O6d8Tz6RqzhoO/ZpatzLy0G4JlCRfuDZjCvIW1dP4hwUDpIWwWfZLN4bnS8hIUm
	vh6+XsLe1i5yNpFST4muRyhyy63dxhbhF55UgrfE3Vv0if0D+fXKfDV0hdOWlKfMZKNwKujUxIs
	K8Rb8ij0TDtxuA3H5zcycQ5BWc1QiEhrn4YlGuFJgWK4/H9al0+AIaXhhhGtDNtlLoivV0QLTVN
	JhLnTuLaTEgovsMWoet3uvykNa06K9k3rarLPWBa5KtAlUzQr3tTW8PFVlOju+Shb6wx3PsIFnj
	IEgv8q16u5PfMyIEIkNugpQMTd1fl5Dja8EoHGdSpBvzM7CbXxCFlISQCbGaWueeNvjBLOzP1+c
	4lcJtJlrTJTcozXYsf9HqwohXYYBFao1c/UdSlfmThfpLile3f9PhHqr5p1RZ6l6Xbh2iOltCjq
	lEvsxbi2n91GrQE3CKf2gn0OA4yTAngSznmM68sbHEQzGRLxZuFKSKzQVpCRtVezbqpXOx4gv3k
	0BnE0HQZocP/g/DA2+PwR
X-Received: by 2002:a05:6102:3fa8:b0:7c3:9a14:cfdb with SMTP id ada2fe7eead31-7cc926820ccmr912621137.17.1792599247553;
        Wed, 21 Oct 2026 09:14:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc92327896sm3196621137.4.2026.10.21.09.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:14:07 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:14:06 -0400
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
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.311d7bcc5fba0@gmail.com>
In-Reply-To: <595385b672b5411849d1defc78b68b25a908a77a.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <595385b672b5411849d1defc78b68b25a908a77a.1792565282.git.mst@redhat.com>
Subject: Re: [PATCH net v4 5/7] net: add a sysctl to opt out of virtio net hdr
 checksum validation
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
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> The ingress validation as implemented by the previous
> patch is stricter than what it replaced: GSO
> packets whose checksum metadata matches no transport header are
> dropped, and non-GSO ones get their checksum completed in place.
> Such packets used to pass with the metadata unvalidated,
> and with no overhead.
> =

> I judge that this should not affect any deployments, but there is still=

> some risk that it does.  In case a deployment depends on them anyway,
> provide a per-netns switch to get the old behavior back:
> =

> echo 0 > /proc/sys/net/core/virtio_net_hdr_validate
> =

> The default is validating.
> =

> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

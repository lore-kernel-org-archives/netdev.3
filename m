Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538025;
	b=miIgoRWV+nc6tYCBxgwl5M3UVhvqzNOTlJocxKP84FqKyAqYWYs/DeG6FjhE+d2Ye7iK
	 MsPtabaVy7OorELmUk5CyY6No61k4iLWBx9PoQBAtJzXyvttUgqDfzy+kRRfsK4X+Z93X
	 14bUUg2FM66cz1qfYW456jOU/HhzhPPvoCVRstdwgPJthrQCLrSoBi0H4WmtKUNZTTv4n
	 vC9N2+XHzKOn1XVkaaPKTyO12u/80BaAgvB/rQEms4l/A5wGCGym725n+N8qaMcfjm+qU
	 35s5cBiPy3TnQwAKPU9Cq/rBtWMGhfW8ITSFQjmtpKiWMfJrk7wsVQUj105na4qcZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rJ15NYGDexAwiy4HWGRqahFWgTYhKLwbhvNqgPq1/FI=;
	b=aonhOr8MMT0YDj2NGj9SFoqZ2fQwm3x0rca6brgXbflPzFZRKoTYHSmOUL+MTPUIRrVm
	 yUWUcpSo5yHtpDTcLeaC2SwIxgBkY3eGZPRfNHhtAi4n2hBpgif/KBmuUOwdWkapvi0Ba
	 6l5wBBHCZyL6PA++jY0B9wVELlsB/SupeSirC8ul5cs1TVz+3XrmBVltVGYWLiOlvPpsT
	 vC5m2hVaI6HZdGnldcTzoZFalyyeN1l1lLporl2+HZbkQvxFKQ9RBfrWe3NGLW5qTq+qc
	 iqcKZih3OqouwSWOn4Vgpfz/SQPj5sHT56AqpBD/Z3c76pakmQ6i0P5VgFMgxrvGZhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ccTkz4he;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED2606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0ED2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ccTkz4he
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9902a746546so100583241.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792538024; x=1793142824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rJ15NYGDexAwiy4HWGRqahFWgTYhKLwbhvNqgPq1/FI=;
        b=ccTkz4he0AFx8q8gX2Y4zERCLVWLeXCKRJcETB4Q4zQmAWIdlDYdokfGMTpUmv9ifb
         lYUZ+G2LBtMNKJegq49JC9MGtwhO8WubETfYqguFaYXh6ThI+T5JHcxfmLYGgv4mNoal
         xzd8btA+WJoJCJs+Sma+SY4qraTuXyxvVe6qwdJGyo9iq3u03yWfe1R3s7BYdv4Xmctf
         56I3WbcJP60v2ZVnFlnsDyqC6Wu6yFZV0TiN4bRPyIi1XL4Ucl0cqX/mP3up8iZG3H8D
         dDmM5+BR8TU7Km7T8Vr1IgSp8FnnB8AhgWssfKKUgFoVwAdJ6Cws1MvBq6hRjWn9E/XQ
         w3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538024; x=1793142824;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJ15NYGDexAwiy4HWGRqahFWgTYhKLwbhvNqgPq1/FI=;
        b=nmWJxuqm6gjFQ6FeJXi7xTeg4GBPHrFkU7tONE0dz35fTufEVNfImA6GskyghBiwox
         UxmnsNlCZUeKhx7deimk+eILiQFxV6ca8bZcjc0G/NJi/Uu4gWt7PHtF+mLyAOM0R1t0
         2P/f4XDSkyJJeA0low6rb3nWvtzyi+7kF57mxEyIr08PdmcZjXm6o7tCKAnGbBiSBICT
         xHaFvEIIRyh9dH/Ces396HSpOdeMj6yBKCcSSyNQ0et500e4Lq6LyEP3S/SCndK4aWa2
         RoABxuuCfTe8FfGAimEgEAH0i671HN2qvdnRDdjttMUtJCWG6jKsjObsVVPps4DLari/
         /jHg==
X-Forwarded-Encrypted: i=1; AKwUvByngQHuRH8F4acpoiQhPzaC4SsjQ4N3PmZsaatZ8HDahNQAdKDBUiyLbgP5KSu+0WQWpdNYsvs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLp0K4G9vCdMrVil9rSEfPjfW7s/MsAIMlRtmWI1r9Az0ve4n2d
	dw414sPxZbGc/KyDo9ZJknixQothpDwcjnbIRMYnkL5q9DEaKLXcBrXO
X-Gm-Gg: AYBFou1PYMy6nV0z/MQYoOMe4z0a1RMnpteN4rvqoGhKEQxQA6bqcfEp6UQsNSOQ9uJ
	uYl6/Qsc/81ATq+Kr3/47JFGNVBFwreWsIjF8HMXyQaDWUpuKV6dMfHBhiKEKwMEdZhGtzNQ4kz
	RFhNudERh98PNUrhBIbxEPvUvW1RrIScxkdgbkekP6n24fFLiJFCoCGZxW1uauoNSptH+2VCrT1
	fuRJ6lxKNyvU7F/+SlfDuSf1AiN0btWc3sh3AFTVu9siadO44U1hwZS8ZVhWZu99V4kcGGBon3H
	cS8bU5qESttrZ0oL6GCj9G5AZP8DeHaTAyPuMsxysN5nrTHgNFIVoknGdQpv8KzDAgCk7mIU5cZ
	S5gyp0GfZLndN4ufY5m1oTfFTi7N6iLWIP4/VrEOs2pUxyUmqI/JLQpCB1rDvxTOyzJAFGsywxz
	ognWTDNks1d3f0kZHVwQajoKW6BRxbDTdZ5ftUqtsySRsYUN6VUP2ht+upBmiUMfXjY9NDx0fcV
	Bey4NpXpdsc/qRRXf9LS8fvm6+xbVespO0pYSzZN/1LwCFwbC6UfyjGySIoKcFoKexqNpiV58C/
	CosyYiCdpsbop2rzn75zPJqb97VwIp0EJ3vRXQ==
X-Received: by 2002:a05:6102:291f:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7cc926d26a9mr190460137.6.1792538023910;
        Tue, 20 Oct 2026 16:13:43 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc9236f63csm803396137.5.2026.10.20.16.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:13:43 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:13:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
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
Message-ID: <willemdebruijn.kernel.34b42ddc625c5@gmail.com>
In-Reply-To: <20261020165610-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020165610-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net hdr
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
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > > +/*
> > > + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> > > + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> > 
> > it appears that they take the mutex_lock below
> 
> Some of them? But
> virtio_net_hdr_csum_check_disabled doesn't, that's the point, right?
> 
Yes, but the statement is then too absolute:
_some_ (or most) readers don't use a lock.


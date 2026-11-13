Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794547076;
	b=Kiqb4JEZAZdaswPeW2oOqeEPUEgT+7Rfj0DEviveeDWUYpSk0hVAdg+aXxsOJ2+QqzF7
	 fkaV3HNNAhhBk56kFxXfOm68AX2PnPuwUJFg1cq9JarlB0OqTITTJrUeJTvMAX800V0Zx
	 C+VSoPz2IUXi5zKC9kOeW4RgZK10IuxeV+5yQm9YUfFYq/ea0sryKObRhf2a1XCDuzvZs
	 u6ItVTtO1I/9JycIIhinHZnJq1qf2TRVRD/hGql3Xy91qTqEyubyrGw1Gpd9d5MMfYaO5
	 zDObkoVVKoATm3XRTMsdT5PPrsgG4Nyoh6lmLeZTk4uJP0t1oBjQ/KQkbqqa1CuW8/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f+W0yRPPh5LN5Rei1H2okk7m72K0RoxQKNaAvZ54EI4=;
	b=Pe9e8jC7cqZVDkCFK708/peFMIiHfOYQgFZCpdcH7dHhGkjoxXxlpGxXRGS4AyzG0uhi
	 aIKvz2bhk0PMaVjPrrNq6GF58BKzVoQFW8WxSVv8f1t+APIpouvvliqHtwN55wHvbV/pK
	 8shFsgPm2U4p2qlqWO4rnSE7toCFUNHAFUKgywIb5UB6pPSErvWDpotgTw9Zc/KTzav2p
	 Jrh3XbyatlFjTT+bF1wVW+Ydio6vTBAkxqAADFpxNS4eyYNY7TZpQvlBcweartBTh//Kr
	 pNzOKfkYqbJnUZ93EEiICLKAGxQ+6FiC4hRhlRlltyTK+8q+heZsFVtVTcku7eyfAug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XkcAxtUC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25E606A321
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E25E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XkcAxtUC
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso4526a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 21:17:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794547074; cv=none;
        d=google.com; s=arc-20260327;
        b=RomPaQSBbsqcHNkHxf1FbQmgyFi4hPC6YI+unsOfdw4TDZRJ1EPIDp0RP//rkzWT5Y
         aU8zrVwOJGokbMU3P6x+77+SyJ1YSZCZPgzRkRewYCF1kujtjg247JpGVnmRIfwaW42r
         xJURsJuzE95l5YlZ4fe96OAXJmydasqqBod5vQSl0DzQZEWBkFcC0Ig5loLrRmxLonNQ
         +f+L+tOx/guHeEm/AXNfUfMRnLpK3g/wVTTNVYIiRV6S/jw53BgKA4NSBFJiQpf9NzPQ
         mMtwuIuOovMJhq9cCrQ99Ssnc3vUgKCN7BVhcIiJD2ZgJ5a1Wmb2AUyCrjqqlU0rLkWq
         NExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f+W0yRPPh5LN5Rei1H2okk7m72K0RoxQKNaAvZ54EI4=;
        fh=QktPzhnKDTlZml9epLxgwDHdesGMC5v+fa/hx9q5YIQ=;
        b=I/m6N8w+hHikCpOCCiGL65HvXY67Mx091OVwWU7si/UlDdl1l2OrZaQpRqEClCNxPz
         ofG9yakabhUUO4U0WBU3FLAYlRcCTvX8bSqPBWs/4Gd6w05NRw5ZCOUTm/YeilwMrkii
         0Wdxv6mNIFuZPvdYrN8JTjlRMMMkv8VNuNrFKrDqyEu0ndEtBSKKpX9eiUBAuJ17ct0m
         Nbh/qXi0mteBfd6rR8Ts4oWHFi36q6h90ZcJrOh+l8wTvVK1YBQ4yveWrQgheeMZI4cw
         Opt0afqK8sUq5gVdLYs3NQJW+dT0ctAocbTDle5j7rrj2DjXXs+997E/w6tmxSsOyJOF
         8Xag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794547074; x=1795151874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+W0yRPPh5LN5Rei1H2okk7m72K0RoxQKNaAvZ54EI4=;
        b=XkcAxtUCanemul+RicaP/aozebWZdnRnipw0ipFQorOt0CF/BrSpgOa8erBdCdQ4N4
         VLN7NIrJsbUZs5/qRbv6PVx8HdejsexGCcXBvZF9JMwInu54ZTGyLTXV4CP5Khnt6ZmY
         KtwFVLwvIbCaIc+i4hJo68hl9fk2E5AG+n1NWywpxM5HEwL/Sh5PnG2wSuHDKvMPj93c
         eS9Wdn4dxDybUNs84KncdG8MxZzbqIualdyZuYd1d9+Jv3B6t3kVQ5SHpDpkkDeOs8Hr
         TJbLqq+E4fLdgNwbW0RukXF0HL4RUXNqvH0YKSicntzdAKQfXtwzBHxp8r6Xg1qJ7l/Y
         8paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547074; x=1795151874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+W0yRPPh5LN5Rei1H2okk7m72K0RoxQKNaAvZ54EI4=;
        b=KLCk+I3+M2Jl0KO7nZeFylzSmP+e6XcTwnd5xYJOtpClD7a5ywdgUlcT4u1GHkK06d
         6zYufvIbl3FH7fYRdEt/NKPsVVtMByI10mBKxNuLxW17ASre1Y2Gy1sSc9eyaA2/XvCO
         1J/pXxyhw0zaaBEP46qbsiQ1I5nXDR8qAtfgcYzA4o8zYFOhOnRRFLcDWJxsvJQVwUqo
         5Iwc7r2hQ9RrZ5UyJDj4Vd5kUzmVdFyXbUO5VxFQraoRtICCYMXD6OkEdpvQv0WesVbf
         R4RWK7CsLd1Sokeb3UOBO1Qt/6CwCYNTU/KigBe+zYAY+DnQC/2mp8h4RgJusifoSD1T
         d+yA==
X-Forwarded-Encrypted: i=1; AL+hErEPaN7gTKdC6b9JgqYWkQ9GCFYwEx9gPdZWDY88fmatD88svB+0hb8X0av34Z/7Np7aZofduW4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UIVtRA5Wgp5uOuZ05V7GgYRsQ8lUOtRx5lwEiv3YGKTlMkpWy
	E3zAIrmrRMcC9pv80i3wXBrDyEzO1amgGvcKcHcYjn/2Qf1jbI+EQEBnaa0j5I8u5l3mc3/itaU
	AOoGub9y7P0Mxu1YOXbD33kon0xCbhy6Y7vtg4yZr
X-Gm-Gg: AYBFou3PfTHDAMwqF/o6mf24vLYu/KkkEaKTKcCWGMTIgVrgAPqYNiCqClANHC7Tius
	+QpI3JrpCwZD2y5LJatCCMvxXIsN1KgcQpoibO1+J+GWrMmnfh2mUCP2aTsDUoAQDU7c7JJG7Fw
	5rBTE8Ljr5yzi4hn9UwzGWojJLom0qPBcnpDD0JROsLuph7nxchCAj50JoUR/Mw6/DsQel8yNcF
	cu+oJeT4UFvEWi6hHT2272xws1J/NmQOKyBy3IwSgP4pC4C6WPQ+OPo6gFbPJkCe9yXaKQmg2Y0
	R5nO+xZO572w+7lHnuSv5yM8ckRVuK4Izh1o3v0B6VFjzZokKhKdrT/qOhIPGiVP+NmwSiEQTo4
	9EpGrLuY5+MEl5TQn75L1zRS/7nEKjV+5/HU=
X-Received: by 2002:a05:6402:160d:b0:6b5:70c1:650c with SMTP id
 4fb4d7f45d1cf-6b7c34c6eb8mr48079a12.4.1794547073617; Thu, 12 Nov 2026
 21:17:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-2-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-2-bjorn@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Nov 2026 21:17:41 -0800
X-Gm-Features: AclHuK-EmG-vcwSjI4xi1-iRc2SNUCp5kahvZ3vW1cJ6PmqMOttCBZ_NEdrFdlY
Message-ID: <CAHS8izPnmy4W6f3dWp2NCkmNYxtP8jKm5rxjvPbQc8VdFm0Wng@mail.gmail.com>
Subject: Re: [PATCH net-next v1 01/11] net: Get skb fragment addresses through netmem
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> skb_frag_address() goes through struct page, so a net_iov never has an
> address. Only unreadable memory should lack one: XDP and BPF read
> fragments through this helper, and AF_XDP UMEM will back readable
> net_iovs. netmem_address() also returns NULL, not a bogus pointer, for
> an unmapped highmem page.
>
> Generic code needs the size of a net_iov to find its address, so keep
> it in struct net_iov_area instead of the devmem binding.
>
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Are the changes for niov_shift some kind of rebase error? I don't see
how they're related. Otherwise changes LGTM.

--=20
Thanks,
Mina

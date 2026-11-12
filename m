Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794462026;
	b=q+qmmJaQ46FJtTqBF1fB9oPO3NJ7nHjmbajHzqR4AP/yex1YGNYR//UKQ1IS3hSfb7Hw
	 Hm//CSQ4nlYlA84xLR41VSlh4QmTAteDpAB60yQNPPwr/EMzVW9NXgxRNFMk2PEno2hsI
	 aULCYGvD94e33CkbOmX/OnItoZ0/uHs0tQKth1pO44t3430JxMvFh16Uo+YrpLUzTyA4a
	 dI2POKgc87XITN4wQxgRB87j7lWDpVozHvAFqYp7+L8UK66wCkLBxb1mggeFoebUZAwyC
	 KVOLdNGqM6muzSatyNGhiJfr5dYoom5OX5HPIN0AKUubEMVUaAPotW7cEHVG3w0G5Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=38irPCmvvGjLk5lYC3qAN0yOb0IGyp2qLG+JcM/wS5Y=;
	b=OfAb6MTiWhPgdWC8Cert1VpwoyWQ5YvbMJKOoUXSu6PM4/qxMGcCIAAriI0baLpzJu7O
	 UEOp39KmpON1lZf25yvmw/exsPYJAg0Wd8DVfpOclVwwYYraH3dsz0QWst+Y2Fl//8cCI
	 xj8R/AJeln5DoMSPJKJqWuwuLvRf306RjixSeLHSavTqOSM9NZyR9XXRqTyAPs8YL32Jn
	 T3HMU49OSmCFB8UxCbZV+NyUQyfGTMKfbuqlNYYblp70l4/kV7Blsr9uoIbZg7h/HXyVf
	 UBNZci0+zSicD1F8W6j7zMqwxxFqPrHBN8ESfyVPbFUOCfrhH31zB3cR/nqeKPkDtRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wiSP1H30;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D196606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D196606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wiSP1H30
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c5066da8aa1so203884166b.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 21:40:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794462024; cv=none;
        d=google.com; s=arc-20260327;
        b=DxGqy33szmhu9fngjNExuKQtYcUoGNwjZn1SUN8ERW8pedEr5V9lfuNcFHQt3jbv9P
         bqZp+zYYb2uhrD0ebirvp+bkeC7iWJkMw/jOTNGSeSGUuq6Ao3MghDsUgUdwo1BuyrkX
         GfxFLL5tpUwrM4WOOUfciHJRhe81HxlhyGZ2reAD9bhNHnu+Fe67zH8d47lg8fjdWVKG
         ThchY4NCmTK0qvbEuakQ9hgv9W3unJTcIn5LzqSpO91BxQ/3LKK1z/uiegUKRKWk4km3
         xtKKU6HhjzG3GFZBH7jlChVjIHwogob5jcFgX6L9JVYYroWGIu6m1NIUk5vkhYiotLzV
         VEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=38irPCmvvGjLk5lYC3qAN0yOb0IGyp2qLG+JcM/wS5Y=;
        fh=/fJa8FPU7bT9r7FoOY38aSBsp9Gca69uQlkDiF0/6ko=;
        b=g6NEn0IDqWbiMjDddO7Oae4jih+JLQY10synQ97Ji8mC/QcOEFFWI1lavgJc9mK0JB
         zliD7k7p4b46KDQxxkteArNl0x5aZnA8RFpN4MdzlRA3aS+vwhgchijzRzWiVFyMdUIP
         0DN+2/FMdBPpZKvTCEvj8MTLXAQWP7VIyJTFG3CphXwHQL6f5FWiP36y+AIt9IjNhZrk
         l6r0lRYiLE7JOL7vnVSyXaKnMbvSk8HAyNfkgVN2wxmf0xnGHNMP0v3u7ioQAgWCrb2H
         LLCJ41Ymjuq0e2ay3q898GGLjGT0tLXZh57EVr9wvlwgNp3P/WTS5YUWXG2ob3n5qN5z
         e21A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794462024; x=1795066824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=38irPCmvvGjLk5lYC3qAN0yOb0IGyp2qLG+JcM/wS5Y=;
        b=wiSP1H30N+pOIX4JU+YFc0ypLRbulh+k2VON+jINPs6ok6uM9BfppBiClRcl1rZy6a
         4h22HDJvucxbsKi8xg7w4aPL/OiUx/GARig6JPKqOgXqDVQIe4z4twpQ+yZj1VVdmW8o
         wcP0+8vYIWDqWpjcvyyuIw9ygAe372THc5FAKB2UnviV9l3okyX6Ep7aVdHDLkYOqnKK
         btf2rPI1DUOoc0qfG9FvIYCbkm6yzLboj7tlViqvCspKiSpmhwQlLVkw9WjtDh6c7Af7
         64yY/YAbTPU5KtyRVFv748eYXt9VROS3PwHKefwFoHEG3HLQUVi0DFFbUL7B0UQsYvI1
         AhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794462024; x=1795066824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=38irPCmvvGjLk5lYC3qAN0yOb0IGyp2qLG+JcM/wS5Y=;
        b=z1KERZMUIvn+PIUUOul4CO2X2bT9xoWfNTmQzOd5+Yu1LMwujYfOJJOrrS690WZOs5
         zIWi4ucbmlJTLCpab9XEQSxHkOvOvSoCK+62i/yNTdKMx7xUICMNa7N2JXwT7V+jZrDW
         l2b5Hbj2WwfPwPqhFJDz6GWfyF7ZNPkawHKtt2RhO017IrXbgTjN9aD0Dmlz+1Uzf30M
         F+JhEl9tNvFFG2kbRTVxPgoGJe/En5Bufo9OPstc1wH1kiaAx+NndnMqmiQq8kZ5KA2K
         F80tv0LvBuYkINkJHB8B6FXpacHFcHVGItoFxIkGjzJjdFPvl8xWi8jnA9mrndvDZrhb
         SuUw==
X-Forwarded-Encrypted: i=1; AL+hErEb2oY+IzmSUutlT7veKYoPwyT663f183cu+WsAx9kN0q5VvSsqYA4jHDf38NFCi3KmPpMRFzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+v1hsCFMDVGX4gFFWEmAETNGU17CKxfe9cG3O4pRvIkB+IlSIA
	7Dch+00uEHTneY845Dux8kUaprRi9wIuOYCtAIvhiBs4Fe7T0Ee3bzrLX+eE8heac1tOtXl3EiU
	/ZWJsDIcacE8xhOD1iNI1Vm0XWtORWgXQfsLm
X-Gm-Gg: AYBFou0y5u3yKB8aJndug9cHK1z88ohDfdcF1CQub3FEtdB/KOlFsUVK6hqp+Ck1AgA
	l1fozrMkeZ8uursBXPWqg3HSC+1SI2MZscWdkE3bR7Rd4JKAdW4A7VMXM2xQMejPn+35st7sT8C
	nG6LlNlnGTrK4woEMfz9Lb//7E9tbO+WLWZNyc9xfUS1ApmcRiCYAM+hL0p7Lhrif2ebWLr3TR0
	HDsIaneafYu0dX8pWhfCSjSGFIzzfQIt0b7P2xaXqBZIPAR94MT8E56kUFdqrWFxPfx4OelJY+6
	8xyUEgSjm2cWsTjyXicBQZS54kYftKrnGntp6S2Mlkk8XjyEWZgrYO2XvhbBW8TfszEE1DwVz2t
	OdsrHN9qmC8fVnclRPtaA3mZom6+rU2iV8dVyVSXhSt+N8th/EyLHtafkWIHnWvlcafui
X-Received: by 2002:a17:907:3e1e:b0:c40:f89f:d91d with SMTP id
 a640c23a62f3a-c5066c9b92dmr321953966b.28.1794462023595; Wed, 11 Nov 2026
 21:40:23 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110114623.2659197-1-yasuakitorimaru@gmail.com> <179431155869.488859.10143317051771395220@kernel.org>
In-Reply-To: <179431155869.488859.10143317051771395220@kernel.org>
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Date: Thu, 12 Nov 2026 14:40:11 +0900
X-Gm-Features: AclHuK_FTK64i6rz-dgQu9pXZ051Du56rXiAeB66ytOoSbASfD_csh6txxR6a1w
Message-ID: <CAA2s7u4sfe8J2EXtmEtPmcV4N61B32Zn1E82EMaN7VpVtG-njA@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: account XFRMA_MARK in xfrm_sa_len()
To: netdev-bot+sinfo@kernel.org
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. Here is the information the series is missing.

Discovered by manual code inspection: xfrm_notify_sa() sizes its message
with xfrm_sa_len(), while copy_to_user_state_extra() appends XFRMA_MARK
whenever the state carries a mark, and xfrm_sa_len() does not count that
attribute.  The issue was not triggered on a running system.  There is no
syzbot report and nothing was observed on a machine in real use.

It was then confirmed by instrumenting xfrm_notify_sa() on an x86-64 KASAN
build under qemu: adding a marked state raised the accounted length by
exactly 12 bytes (348 -> 360), matching
nla_total_size(sizeof(struct xfrm_mark)).  The shortfall itself was not
reproduced as -EMSGSIZE, because the skb allocation has slack and
km_state_notify() discards the return value; the commit message states
this.

On testing: the change only alters the computed length, so it was tested by
building and booting the patched kernel with the same instrumentation, wher=
e
the accounted length includes the mark.  No selftest covers xfrm_sa_len(),
and this is core networking code, so no hardware was involved.

Yasuaki Torimaru

2026=E5=B9=B411=E6=9C=8810=E6=97=A5(=E7=81=AB) 20:52 <netdev-bot+sinfo@kern=
el.org>:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

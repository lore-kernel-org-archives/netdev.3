Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792881815;
	b=z5E56hK0Etxera7kOOcHmBO/dRHya1HDTdzCRw5WpZpkwVWG+T6LxsbfvS/n7gf//dRG
	 YWpU5TBRAhOJzz3fjF/r/C7eR04hEzVuU/dluwhsy2IMxHHI1hJGiqZUEaQMrI0THDA7D
	 GR0bXh9tKJu+uw9zwwmMTDX0ONgtaXHzA8IaxlYVN+kPzd6iBXJv0/MoubwqF6OZVK9I7
	 lqyPJ4IahX5WkLuV01fJcMAexYiVaPCTLRjngl0HhPLHzv9uTxLwxWeDLyQmJhYAKokwb
	 cB4JtAcELdp8Mted7/ri2UVx15QoUOfYfjW9/22HlK6iO6CIxHgXRTXMXSKvawNalqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792881815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=5KfFYI85BavTvUDPaheV69ALCcpMe7MtH87hWt6t3yw=;
	b=tmKa8HC2txySvWyskGbx0sHzoQ8b7YJCDQhW5JRBbosustnGXi4Wp3gUIg4H2gG4mDg2
	 kpYDvhFPba59PXVp2X3Em/uRNGfR/Wp81FAkRdzHbzRYNl54eNho9bnBK1GX81za3TqTH
	 4Pp7dpwPR+oQ/ToR/MO1vy50uaJ6C7JmQz4NV0+gX/fJVFbA6VHzrQNXiKh0RsOkjEbAH
	 6HTcQuP/Y0My3l1yL25rtdjv581BjDUyLyGouGkkC3uQYAueGjAuNxwk0F9ODZps46JEl
	 W7KM8cz/tfh0sBO+0Iu4DUTGSAxd7Q+uJ8RBdfDB3QCzdKA0+jIeRTWa90czMDxDs0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T9JvkXLL;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD7606A31D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 22:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BAD7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T9JvkXLL
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eae12762c9so862041e0c.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792881814; x=1793486614; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5KfFYI85BavTvUDPaheV69ALCcpMe7MtH87hWt6t3yw=;
        b=T9JvkXLLfwUgIoUNaci7cw2KYglkZcT5YBvnT0Zbyuz2OMtCuD0xivLopvrHrvU8Xa
         mioNu99NvBHuN67pUdte/vqe+UKZVkJ8uQQltpBoJ9s37C8rjy0LYGnr2GHRJTkaUQqf
         4MOGbcS7E0odqFnO0W8jsQxQygVA3ib6qVZY+BBPh7kE/KqmmPKcGY0fLW6buXcCjpeA
         zDgPK9+AZ9sVUeg58XBilDKpKOBK08hSpM4VjDiR0SFaIRiF/SJ1NIMaNQf7L4FbsJ4y
         XTQjsURzpaHTOcly7nbeTg/Qw4SesAmkhAMd1Hs/NnWTJrtEuPjEgixl+vJlF5n9q6aP
         t9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792881814; x=1793486614;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5KfFYI85BavTvUDPaheV69ALCcpMe7MtH87hWt6t3yw=;
        b=BbUjrShztkr9y18E7zeMKhuWS8F/+hrZGFKUgBgVme9bMO86mRCfgvbPMDNHg8yX4j
         tVps2224/2STMjc4SA107qg8kwlfmr003nSmzLq/msfVobdkie2V0ShBpyew4yPuDmLS
         zCgA7mYaMb+4mYAnDpPIq2EHtxP7M+CxxwRzDfaEcSca++bsJT7MhTCvfXEHg6FGVzrx
         Xuj+9AX4cNnj3q47LT0mCeoexVDV1SRtrQwZKYPnkG9zQ47uIiV7hbUhuwrbU9tt9nqq
         iJeUGYTDA0Q50FqZwuhV254P7qDS8gaDOEhEZIOoRSsU9ML00JM/9Y/RS7iS/cZ5PPdu
         xVuQ==
X-Forwarded-Encrypted: i=1; AKwUvByLU/AJALCkGtvzO/kMQ5Jr21xsklcSME8SjdoIf11AdKzU9SU1Jzs1PhFiuzz2wo9aQ3GuUBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeJjotomjalLRpxJ4+ByDeZZ7Wjj7D4zF86M4YV0ZUxpTOcw1E
	lrvfylaCdJydLzZdK2AnXZiJRxVVgEnmF/bIXdw8z3FE64Wj6hyyQ5xb
X-Gm-Gg: AYBFou0qd3RD+4u8bsghxTJIXSmaqznenLBdkwN1c/Aqy3p9k9YN74MjLsH4vOud76T
	v4WwxUUa64EL41HWWAxTj7zyTn8mqLup8zG3sBcJEyFvCfO08R3X07RAjexdp0VoU0bkLineJFR
	S9cB2fzvRkET84SghMYZkqdVJSDwtEAfXnuxerXEjkjTPSCykMrPpWZDfZAADgiEBRGRBTja4n4
	AcU5WgCnKBOCwh/Xqgfb2Zl15iAphib5+W9kbMhiuCdZKtKccCKWDkKiFS8Yi/IROXzZG+qvtQn
	eQz9/gizLMqHNBwiMaTHV1+cEemg+OlpQGxHDukm6tWIL5Hn5jaO+Ur/fHm2sDcJ3CFgxDuapLh
	TRtHlarMZVzbtNokYz0++RzIGVKJeRUYu4mgI9Fja9JVYMsi1yfdxcxg89fojVngpuqtybm0+mF
	OcPfFMwxWaJz1Wb80qMM054vrbcwyBHJNIjjK2QwDRCuIqOXUhloRs+EFu76ftG/Ob3es70Ip6A
	edhebgBM4WbwUWCcUdDxn1RNdM2VpEdG9E4nCtZJHVTc8NPTzVZfGI8iC7nvxD6e6eAIXpJhYHV
	QRKvFVIlwFSzwiijucuqsxmmWjFKRgob4kNqdI94yvStErwPyCQ=
X-Received: by 2002:a05:6122:3b83:b0:5d6:7f46:b8dc with SMTP id 71dfb90a1353d-5ec23338ccemr918466e0c.21.1792881814119;
        Sat, 24 Oct 2026 15:43:34 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2804:7f0:b101:277b:c08d:c9f9:7c08:79c4])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec233f4d28sm3503879e0c.3.2026.10.24.15.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:43:33 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
 Weiming Shi <bestswngs@gmail.com>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH nf] netfilter: nft_set_pipapo: skip transaction elements during GC
Date: Sat, 24 Oct 2026 19:43:28 -0300
Message-ID: <179288180870.24716.7833838593165388250@gmail.com>
In-Reply-To: <at0vzdlVTF8XAzHj@strlen.de>
References: <179287943591.17355.17353179557993329094@gmail.com>
 <at0vzdlVTF8XAzHj@strlen.de>
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

Florian Westphal <fw@strlen.de> wrote:
> Please ask your LLM to explain how a newly added element can be both
> new and expired at the same time, then fix that.

Hi Florian,

Fair question, it confused me too at first, so I went and traced it.

The catch is that the expiration isn't stamped at activation, it's
stamped when the element is allocated. nft_set_elem_init() does:

	nft_set_ext_timeout(ext)->expiration = get_jiffies_64() + expiration;

and that happens back in the parse phase (nft_add_set_elem), while we're
still going through the batch. The element only goes active later, in
nf_tables_commit(), which is also where the gc tstamp is taken
(nft_net->tstamp = get_jiffies_64()).

So the expiration is really parse_time + timeout, and the commit-time gc
scan checks it against commit_time. If you add a big batch of elements
with a short timeout, they get parsed one by one and the commit only
happens at the very end, so the ones parsed early in the batch have
already gone past their timeout by the time we reach the commit tstamp.
They're expired and still new (not activated yet). That's the "both at
once" part.

I confirmed it on an unpatched 7.3-rc6 + KASAN: add 20000 elements with
"timeout 10ms" to an interval+timeout pipapo set (the parse alone takes
~6s) and the set ends up basically empty. pipapo_gc_scan() collected the
new, not-yet-activated elements during the same commit that added them.
With no nft_set_elem_active() check they get deactivated, dropped and
queued for the sync gc free, and then nft_setelem_activate() ->
nft_pipapo_activate() -> nft_clear() still runs on them.

It's the same thing you already fixed for rbtree in 86b6471e690c, the
pipapo scan just never got the active() guard. One difference: on rbtree
a non-expired new interval-end can also get pulled in through the
interval pairing; pipapo has no pairing, so here it's specifically the
expired-at-commit new element.

Full disclosure: I didn't manage to trip the actual UAF splat. The free
goes through call_rcu (nft_trans_gc_queue_sync_done), so the activate
races the grace period just like the rbtree case, but the precondition
(gc picking up the not-yet-active elements) reproduces every time.

If it'd help, I can respin v2 with the parse-time vs commit-time
expiration written out in the commit message, just let me know.

Thanks for taking a look,
Joas

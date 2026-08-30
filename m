Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5016F288
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788125023; cv=none; b=qHqSfjrVvg1W6U4+gfxofwYp34qyzVLFmtZs9xgGLeLtE/QON1RBO3Gd+SGcHTDKJmlFta/f/PCco9H3POuXzTIFBWJ8qhoV/qSUYdwys/rWGQEF+61+YCaAha1JQxvwbSazA65RXqS3GeATKkX5Z/SQFuyzJqWlqfV2+4J3F8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788125023; c=relaxed/simple;
	bh=z80zwOu6Ke5xbX/WIpC7ydpBQyxap0CzwRASCSFZXeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onQcfncp2RNYZZzNzMKZOvwITi4pYsISWQk/qy/+L44hLggrIhi/nMNATCTOFn11nXCpBAfWZD6QlMpvwx7KslGS/p4/A7nPftQKgEwHZiRyHNS6mCGmYZv0k9C3LsNziqZnGH1W+kLaAqMyd2onLqBCbmlvp+W0Knx5bMY6AcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV71Jksb; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV71Jksb"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66dee7a0c09so1907950d50.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788125020; x=1788729820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xB6zD2XkdGWJYXzC9PNgmlj5s5cpg0akpGOuCpOesws=;
        b=gV71Jksb6ISer+cmCzJiI6Er+Vr4yI062DQ2bqA60j4Nh5n4TDUrWT5i9UCqr0qK0n
         r+4XQBuY0EBdFMtI/tJcCXy/2S++07jCBuPNeAxLmPgRN3tXLiMZGK8y3XpQ+t/wWxTO
         9RPcjnlyTWGV6iu4y7QxbJz6hYuzl5t9to4PnQo+V5tpAaJwAFiN9ANxTmdDNXvNyQzQ
         KFe+6DtjL9nGZtKgbRSkqYX1//5eOAf3hvd3hFTbK+RdWQNIo6Ric5AIdwblpgmWNF2m
         TQ4b8vPjboJc9HMRu26e54zId6Qtl2r+WuPdylqJsKSKrWIcTqetGnRAxBlppxqB9MEC
         6BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788125020; x=1788729820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xB6zD2XkdGWJYXzC9PNgmlj5s5cpg0akpGOuCpOesws=;
        b=FOAjJElK1xyy4IXyxVq6jM6dPAs8XSYuoRs466ofqpZb0bpZ9iDbeBRgYL01tXElM6
         3OdqBXmlWXxLw9e7jhRr6nvx7zjc0ElwSfI5gKAd+wTtqJfEgpEpyFqJuK6kjp1iFjWJ
         GbzrWV2fE3KQqivRxwx3Our1N6d3Yd/BFgiVxPUFnADZKUlhK/DkN8rQEqptILx3PY5L
         7bFBXqd4+ynkg3Y6dLxja3cSX87sDpLu7/fmssacECL9Vb8YiKQj5tXrEuujJ/CPjPe6
         pgN/6BuInLku0gZTEVVK7wz9jDaxv1wRNfoGdW2k7AWACciEbbTvwaC+LRTFrr536Yrq
         YeBA==
X-Forwarded-Encrypted: i=1; AKwUvBzQSCv2+sELa9TAZjW4qFXtoqDv41yHg7S/LtDYKICjkJRk/KRHo7vFqpp0EL/rBTUjKvf7Vm8=@vger.kernel.org
X-Gm-Message-State: AFuF++nbwqr9f5GMVMIF766pYr2tGFftN9++ejI5osVlgeQIKbl4nbQ3
	XSDpaeup+eyI7Quvt1aEZW9pUPJUkAnbowX3PHnQZJhbjYjpvl7mb8KP
X-Gm-Gg: AYBFou3vYrwpu9Ef/b2k5NLQ2E8p3Jiw9cwBFdlbC2Ai5jQEvj/JGsUwh4J9wGWuAl+
	Y+AnbWUrQ/jU7XtS30rivNDnNs6V9hkQ6e7ru+gUPIsdzBYN1X8TA8mCOxmDEvUInpJFUViRhCB
	fSkqQe6yS+MaG8xn0Hg4VULdWR01AoS2NpyW1erlFe2wfoQR/8y8DAfcbyeqi0ei1YMa0BQsOTv
	GbQpjA7wTgPdISQmS++N0QjwcAD5uq9DdEsFUaotzJSnI1J3MMvSoYAw5tM/ldMW3lIOk304mgi
	7sRtUIC1GrtfDQEzN16PeINnyfHzI0NYbaIUC703SmD95dOnIpeELvHuQ0oGO8yzBT0zkKEYF1B
	xhV8sV7H8CiLxrJpj7Z6b6H+BhvLwhzStPY6/mnD7Gt0hmyAEaw4hAUx4WkdN7OmrhwLuyxQ9CL
	JYr+L94mJK5aAtMV9B9CTgBD+n+9rBpRfbQQdvgWh9+SYOqQNO0y4AFgwFdrz6sAVkjrAxFm0Dw
	wK7vavsu84V8TnO+g6UdchNnZWoTTZ4A3FPBR8FCGUvt9R6y4haGTOh2i2bWxkb96QOnOXFvQJx
	nD0gEKCghw==
X-Received: by 2002:a05:690e:11c7:b0:66e:6405:87f5 with SMTP id 956f58d0204a3-66e64059079mr1910991d50.5.1788125020463;
        Sun, 30 Aug 2026 14:23:40 -0700 (PDT)
Received: from intrepid.netbird.selfhosted ([177.161.242.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed15430sm4401062d50.15.2026.08.30.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 14:23:39 -0700 (PDT)
From: Fabricio Gava <fabriciogava@gmail.com>
To: Bruno Xavier <bfxavier@gmail.com>
Cc: Florian Schauer <florian@schauer.to>,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	lorenzo@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] net: skbuff: keep the page_pool fragment offset aligned in skb_pp_cow_data()
Date: Sun, 30 Aug 2026 18:23:27 -0300
Message-ID: <20260830212331.546227-1-fabriciogava@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827122926.31123-1-bfxavier@gmail.com>
References: <20260827122926.31123-1-bfxavier@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 02:29:17PM +0200, Bruno Xavier wrote:
>     The alternative is to have the page_pool frag allocator guarantee a
>     minimum alignment itself:
> [...]
>     That covers every caller of page_pool_dev_alloc*() instead of just
>     this one, but it changes a generic allocator and would carry a 2021
>     Fixes tag, so I kept the fix in the caller. Happy to send that version
>     instead if you prefer it.

That version has already been sent, by Florian Schauer, the day before
this patch -- "page_pool: keep frag_offset aligned for odd-sized requests",
now at v2:

https://lore.kernel.org/netdev/20260828060822.2628276-1-florian@schauer.to/

It is the same change you sketch, already at its second revision: the v2
changelog credits Eric Dumazet for __alignof__(struct skb_shared_info) in
place of sizeof(long).  Neither thread references the other and both are
still in state "new", so I am replying to both to connect them.

One thing that may bear on the choice between the two: skb_pp_cow_data() is
not the only user of the per-cpu system_page_pool that requests a raw
length.
xdp_copy_frags_from_zc() does the same, net/core/xdp.c:700-705:

	const skb_frag_t *frag = &xinfo->frags[i];
	u32 len = skb_frag_size(frag);
	u32 offset, truesize = len;
	struct page *page;

	page = page_pool_dev_alloc(pp, &offset, &truesize);

Its caller xdp_build_skb_from_zc() takes pp from this_cpu_read(
system_page_pool.pool) at xdp.c:753, and then feeds
page_pool_dev_alloc_va() at xdp.c:754 into napi_build_skb() at xdp.c:758 --
so that path both leaves odd frag_offsets behind and consumes the head
allocations that follow them, on the very pool your patch is protecting.
With the fix in the caller, that door stays open.

I also measured the call-site attribution here.  Over ~75 s of that
workload and some 8.6 million fragment requests reaching
page_pool_alloc_frag_netmem(), the probe saw none originating outside
skb_pp_cow_data() -- but that machine drives neither the zero-copy path nor
a page_pool-backed NIC driver, so no other producer was exercised.  So the
measurement says your patch would be sufficient for that workload.  It does
not show that no other producer exists, and xdp_copy_frags_from_zc() draws
from the same per-cpu pool your patch protects.

One more thing about the scope your Fixes: tag implies.  skb_pp_cow_data()
is also used by veth, at drivers/net/veth.c:762, so the fragment loop is
reachable outside the generic-XDP path that e6d5dbdd20aa added.  That does
not make the tag wrong for where the code came from, but the blast radius
is wider than "xdp running in generic mode" reads.

For what it is worth, I hit exactly your symptom independently, on
different hardware: Fedora 44 with kernels 7.1.8 / 7.1.9 / 7.1.10 on an
i5-13420H, NetBird attaching a generic XDP program to lo, eight panics at
skb_clone+0x159 -- six from raw_v4_input(), two from ipv6_raw_deliver().
Measurements of the three links in the chain are in my reply on Florian's
v2 thread rather than repeated here.

Thanks,
Fabricio Gava

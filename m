Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823006;
	b=aCOLcMiH/Hz9DACymVZuOxyxGssVFLa6UkxmDlI70OGCgSrmbbE7eHP8zpbpnnESF5tn
	 nacdxRpr7XSDeE/IifplYo05cp44YHvlWM4UbpxTBI7/nOdDbfc6wjcqaBnoO0QZFAtkM
	 YLCGXbz/qsan5LTA1qMxE8eor4ut7wohaCQXeizY3LH3xtI4t/4gymp81GOGQh3T7wkIs
	 pCKQMzs7vpg0x2w1lhJ3AB1DTbkEB+Yr3l9VXzwAI1OsF8ekxE2ztf4amfiacc6SESmTm
	 mYuWyUK9hDmIIA/6j+0qPh02Y2bs9xQc2si3SQqqQVxJTweIWdeIyUiPbDu7c8OO67Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pbB/h7OcDLTENZAMlqrgPHDqleGuLS+XSh/+4bmYjVo=;
	b=ubCHbLRpiqZx0MlAG1PoDWK96OF+3BC+ff3oLSlCmy1jfTHAdPPRx0oRuZIY11YP8XDZ
	 ckFXSaLqMhGvNQmM3RZJynhKdDXAqbsvIyuYdp2o1fONBBzMtrNBFdQUJRTiwwzPhcA1H
	 zOv/z/Op8QcKfMBMF/CttSw92lEr3/qW29PPAyt5eQcjdbrR+kWim52msg8Hmofm+LjM0
	 EqJZhWPguvLjIJpylaoF3EagQWyax+Jgy6bxcF1wP9+S0YprONn8qlzV+rN1ShAF2d5HU
	 LeNKFZYr939plWATaDzmri8190Snk4z6uIKfqG5aZgtGDLNzYscX1lYhWZWFzInxC0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAmB6tB5;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAD607E70B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54AAD607E70B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAmB6tB5
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10183465e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793823005; x=1794427805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbB/h7OcDLTENZAMlqrgPHDqleGuLS+XSh/+4bmYjVo=;
        b=pAmB6tB5L5Q0sXbpgw5MAvTI4uEVXOApuJPbfWOIyoio0S+Pk3ev+Xx+LtSaVDmZTb
         UtFs6xBq+HXY5ygUQ+qI7ayP+uN7rCJtM8Qo9UVtZesPJVPeKvFlcvws5jR2/iHFxv8Y
         veQ4oIX5N8YmBuVrhiXgkHYskpbffM0MwfPIRXC7NJyGDG5PAu/N2qWJVRrIBA6aDEf6
         liZndmGbC429jfE5e+Md/TpWVIyFUGja7Frb7Z1IKMKT4ruePVenI36Bw6OzDbXmKqlY
         AfTex7dzu322hFIm/ozi7mn3h55E6OP8ewbasszG/05oRQBr6/fSrgczdbozEEt+dWBj
         iLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823005; x=1794427805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbB/h7OcDLTENZAMlqrgPHDqleGuLS+XSh/+4bmYjVo=;
        b=n+tzm5IsfcCnDqQlCKjrZyUJK+hESVvR1lrKNl93M7Wf89t50AsCxe/h64bahxc233
         P6FZWUL6aXt8Fo2bsmO66jLqXoqLnK1Ha5jcbO+izlSH80zqMdh4mxmqsQ9J/z1wX99Z
         rc9E4U/BlRFy40ihbV4jgXhdxtnceRHHfajvR3N1W/KXqn5EKfdYMTmJHlxAFwwc5Nfq
         CISnddlwIIhtLXMrWdxZMG1RoMKgQV5csDgF2llv8EbF5zcW5WEKjVaNj3roz+wefZRY
         lyqJqiu3cYBJY61K+vY2bjVcOm95sj9+komhS2U2cwMLKgQxSLF+tXYYSio43pXnvnHz
         LbHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdgnFG/qw/LlMjkR6PG/ybmpOsaZyLlozHJ5s9WhI1axtV6hwIbnB1jXbzbXk2OmPcq6bn6wI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lGfpXLMG17q/v9r4+pJAYL4yeLhDP8yCiBej/9Bo5RMzShj6u
	QNDEvLDjmf6b3AesPD09BO9rJ1dT2JpPMAz7GYwFpimFFPWsOACBdaVh
X-Gm-Gg: AYBFou1c1ggq2LIfjC59php4qb3lUEJGNvqePCSxyzU6f0ukRWPo8AdAGcbzVl6ntT/
	HJYpUHskO8veO+s46nE138J6cDDqyCsQy9u9X76TbNNX3hJo+wziKgMKBlNq5GYdSkARK+Lkw8d
	l/nC6dbPIlTbX6Y6oPTnN8YV0rDWlljqKU9JjG7yoPq9ECKPSKiqapKO10ms9IEmPr+MzQLy+t1
	ShrELL6VMtxlt//wURYh12wM4yD1XrdGJ36xMjDHbc+BkFt6cZ68aK5XOTVEe/++Ig8SOuqbMcE
	MAvCiwy61L9wvre3YyLJxpdU1VDzhJ7d1kvbcqdy7VNNgtqzdlBqamIE1dAaX+6Xon0H7gxOvi/
	bZMm2Je68rYKbQbk+SR7YfeA+RueMuLNjMVAdGlTp1h3KRK1VhHXE8lOM47unNRuVOM7g93K9Re
	ka77BA4SxN7fo11iit09OvatjM2lQL6qpgC36HwEaj1Y1I5UZwNhmzRVCLa9HGJlGhHoWaBJzoA
	IgjeiH7f9LrxaBL+K2j9kWdMYN3dvD+BgbuxR3w8tFywMOlNXNrui81mcwLucQ13SSNavnJyC8d
	uJi2FoX+P23t0+r5qE1QQyRUzjFXA6pDrKL1NSpjQ4b368zznk8RSSG1CK3nDkZmUzwmzpA2Qfs
	4rya/mjuZ2YxjkNn18iLvWpovglsuyL0Co8HaBALuQsnl4rI=
X-Received: by 2002:a05:600c:6216:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4ac1737c533mr377961885e9.9.1793823004484;
        Wed, 04 Nov 2026 12:10:04 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56eb4da1esm15954045e9.6.2026.11.04.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:10:03 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Hu <weh@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Muhammad Falak R Wani <falakreyaz@gmail.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>
Subject: Re: [PATCH net] net: mana: fix XDP_REDIRECT of pre-allocated RX buffers
Date: Wed,  4 Nov 2026 20:10:02 +0000
Message-ID: <20261104201002.2215474-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <autbwKmZPPWEj0Dq@boxer>
References: <20261102064324.806414-1-orgads@gmail.com> <autbwKmZPPWEj0Dq@boxer>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 05:22:24PM +0100, Maciej Fijalkowski wrote:
> On Mon, Nov 02, 2026 at 06:43:24AM +0000, Orgad Shaneh wrote:
[...]
> > -	act = mana_run_xdp(ndev, rxq, &xdp, buf_va, pkt_len);
> > +	act = mana_run_xdp(ndev, rxq, &xdp, buf_va, from_pool, pkt_len);
>
> I wonder if it wouldn't be better to work with rxoob objects which seem to
> carry the from_pool setting?

Thanks for the review.

The rxoob no longer describes this buffer when XDP runs.
mana_process_one_rx_pkt() calls mana_refill_rx_oob() before
mana_rx_skb(), and the refill puts the new buffer into the same rxoob:

	*old_buf = rxoob->buf_va;
	*old_fp = rxoob->from_pool;

	rxoob->buf_va = va;
	...
	rxoob->from_pool = from_pool;

So by the time mana_run_xdp() runs, rxoob->from_pool is the flag of the
replacement buffer. The flag of the received buffer survives only as
old_fp, which is what mana_rx_skb() already gets as its from_pool
argument and uses to free the buffer on PASS/TX/DROP. The patch passes
that same value one call further down, to mana_run_xdp().

The two can differ. Refills come from the page pool (or from
xdp_save_va, which only holds non-pool buffers), so on the first pass
over a ring of pre-allocated buffers XDP gets a buffer with
from_pool == false while its rxoob already says true. That first pass
is exactly where the bug shows.

Using the rxoob would mean moving the refill after XDP, which changes
what happens when a refill fails: today the packet is dropped and its
buffer stays in the ring. I preferred not to touch that in a fix.

If you would rather mana_run_xdp() take something other than a bool,
I can pass the xdp_rxq_info to use instead, chosen in mana_rx_skb().

Orgad

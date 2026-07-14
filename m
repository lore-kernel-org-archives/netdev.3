Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73E1DA0E1
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783988702; cv=none; b=jb4QP5USdudWyZJD4IWnEmD595Hxz+GKqUINvIwUDvAflLxhHSgN9XOPvcED1uc78VKwwZBnGO8QDoy/8b2u/vDdDF+ceqAuKjg3LqTo7VWtiRSiMFJJVCeigttCUkN72UfBj3UAy0Vsv9NLZnFDB13ssIHs/9kWY+EwyvfOh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783988702; c=relaxed/simple;
	bh=/JhaswwRXUrVnZuSr9qRcn7rppTZCxzhNmG02h5b/IU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaqoJpliETCgXpEs3g4AnB2CkT7NabszNQUh588nud1zYmB8ivWwlL4f10rM56rDkZEMnYh6iiLn2NGRvyiVPDOt2Bmd+A/caACh2xTiTPtLVgognjEJiLEE9wCBS4Bb6s0dDBx0dWyiJZDobYjpe1bhEYhxHz31nE8kgdfYimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=c127.dev; spf=fail smtp.mailfrom=c127.dev; dkim=pass (2048-bit key) header.d=c127-dev.20251104.gappssmtp.com header.i=@c127-dev.20251104.gappssmtp.com header.b=wWMnRsvi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=c127-dev.20251104.gappssmtp.com header.i=@c127-dev.20251104.gappssmtp.com header.b="wWMnRsvi"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e4fd65b2bso34567285a.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=c127-dev.20251104.gappssmtp.com; s=20251104; t=1783988700; x=1784593500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/JhaswwRXUrVnZuSr9qRcn7rppTZCxzhNmG02h5b/IU=;
        b=wWMnRsviOxJD6y6GSIAWaDYgH0lbX3Ihp0jKOC65q5hLEXJorAencb/Ie8hYxFwRGR
         dO6Sa9yB1A+LvVijqX1pXnVzjeqHVmeyHC6fIuuj77Wq3QbweBry2RRntOai4Q70Xdg/
         wQ3eo1RppRwznu+1TM9V6SuOCnohJyLiE65spTpqRA5CUmK+YtxS3Azj1Vvvk21vCq73
         kyUBllDoA4lqlHJdPzX2m9myxUCeC3Xgv/5WdxjbPMX46G90Nj7qmhLmHdUhw9q7/7Gh
         AExTFKZvjNirlYCSaI4uten1ZVMKLbUqUg7P/ws1EeKZP5JipdSrSz2YwP0MlQ/eLgid
         2ZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783988700; x=1784593500;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/JhaswwRXUrVnZuSr9qRcn7rppTZCxzhNmG02h5b/IU=;
        b=MetSKL1zCtwWUGnYLfY8lR4n6N2PYcfQp8zOmq+wNPncn3sOQgGm4wJbXuS3jQp4is
         +90ANUDWm6OuC3HxX5PFYQWnpYufQhonvsKtlAhb0Ryc1qSZNWdQ0rERoV4vbii+1iEQ
         QnSsSeHLJKT/wNfryMel9sWf94BshgDjZmuWdbyVcIjNUlyE5cFFqL1PIm1UEqAZh1NF
         2VXo4N7BOMzUu7WQXGSnmfoJYSCYVBhoXDBFchmP6IE4CI3O6Ewhr+y+ZDRiOVmLhQVg
         T2lUcS+42eN/nzGTFEAiK50HAex8g+M+NyKIUPuMzkz+uPFz1ZqSoxqCAmyqQkVG8yNb
         w91Q==
X-Forwarded-Encrypted: i=1; AHgh+RpT65t8u6p8CoJ55vrQ23Kx4fWQKKl3IgXVN8wJHIcwJNjZ9ojcLnOJnf/b6rQiIsQ3JNsDczg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4L+R5/T5R52euRf2H9Tkq9phj545fmyRrA3xlnleBoD9C8O38
	ILQD4O88qyylzcOpKnOu1yEOlEsyj4MmQVM3npbcs2qbj/PMdcs9po8mcUtkpl3w68JG
X-Gm-Gg: AfdE7ck4bnHnrSDPB5sGKxwM8h/7J/bbA47Ugb3dpTvIfJ/ht7Iwx7b8eJEMprO76Yg
	w9jUbaL2t1hgvXv3lTegxZOfebzBXQ4smeFupcjpJAoL+Be+hdkxeZakpIlm+HwzwAaQrighs90
	pYPMcRz3k++9bE/RlCYwxvhxb103PKqMFzl/xYtmENksWxR1nVdqKx6hU72Y4Rdhbm3xv9SzJNX
	OqDxO/fhFA+Apk8WV37qS+KzWkYA2UbDtLQrvIDqFOd01Z957tRtJZr4oJYm59S7zrTiijkNexJ
	YJYbihFdN9dCI7vO4W+0Fb5lx0Clg/EEyjQrDhsWoJY+YFwL1VQZm8znWG7AupaL3O8DtEaqZ2C
	OET6zbQldt8sHnLYRxQBuVnxwePnhw0UODQgvw4R636rG6oij/9Nu9ibcv1+jtGhvKZU6owan+B
	itIykTY1nxdaUg+SIOlX1P03ejN6B5MDXFA/yBjcM0L8wyfA==
X-Received: by 2002:a05:620a:3949:b0:915:6c63:b9eb with SMTP id af79cd13be357-92ef2c1fc16mr1148399685a.47.1783988699839;
        Mon, 13 Jul 2026 17:24:59 -0700 (PDT)
Received: from localhost (ec2-3-88-202-199.compute-1.amazonaws.com. [3.88.202.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d30f38sm1210162085a.34.2026.07.13.17.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:24:59 -0700 (PDT)
Date: Tue, 14 Jul 2026 00:24:59 +0000
Message-ID: <03309c370652c5ca36cf9972756efa5c@c127.dev>
From: Johan Alvarado <contact@c127.dev>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com, kuncy7@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/2] net: dsa: realtek: rtl8365mb: add HSGMII support for RTL8367S
In-Reply-To: <7b164d90-b57f-4746-8b7f-b5bb7fd7fe51@yahoo.com>
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev> <20260711-rtl8367s-sgmii-v6-2-88f7944ddca7@c127.dev> <7b164d90-b57f-4746-8b7f-b5bb7fd7fe51@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Mieczyslaw,

On 7/12/2026 8:05 PM, Mieczyslaw Nalewaj wrote:

[...]

> As discussed earlier in the thread: the rate limiter helper, as well
> as pcs_config()/RTL8365MB_SDS_BYPASS_LINE_RATE_MASK, currently assume
> the SerDes is always muxed to external interface 1 / port 6
> (RTL8365MB_SDS_EXT_INTERFACE_ID / _PORT). That's true for every chip
> currently in rtl8365mb_chip_infos[] (RTL8367S and RTL8367SB both have
> their SGMII/HSGMII-capable extint at { 6, 1, ... }), so nothing is
> broken today.
>
> I still think it's worth guarding against this ahead of time though.
> It isn't an architectural constant of the family, just something that
> happens to hold for the two chips currently in the table, and there's
> no guarantee a future chip won't mux its SerDes to a different port
> or extint id.

I see it the other way around: for the family this driver covers,
the port 6 muxing is architectural. Every entry in
rtl8365mb_chip_infos[] is chip id 0x6367, and on this silicon the
SerDes mux is a pair of bits in SDS_MISC that select SGMII or HSGMII
specifically for MAC8 - that is what the
RTL8365MB_SDS_MISC_MAC8_SEL_* names in the driver reflect. Neither
the register set nor the vendor driver offers a way to route the
SerDes anywhere else on this chip id. A chip that muxes its SerDes
to a different interface would not be a new table entry; it would be
different silicon with a different SerDes datapath.

Your draft illustrates this, I think: it makes the
DIGITAL_INTERFACE_SELECT write follow mb->sds_id, but the SerDes mux
write in pcs_config() still sets the MAC8_SEL bits unconditionally,
because there is nothing else it could set. On the hypothetical
future chip, the generalized path would program the interface mode
for the cached id while still muxing the SerDes to MAC8 - as broken
as before, only harder to see, because the code now looks as if it
handled the case.

The bypass mask has the same problem on a different axis. As came up
in the v4 review, the bit layout of the line rate bypass register is
not a function of the port number across the wider RTL8367 family;
the BIT(port - 5) relationship in RTL8365MB_BYPASS_LINE_RATE_MASK()
is the layout of this chip id specifically. The same goes for the
SerDes tuning tables, the chip option probe and the rate limiter
register addresses: all of them are tied to this silicon, not
derivable from the extint table. Caching the extint port and id
would generalize the two easiest parameters and leave every hard one
behind.

> Since rtl8365mb_sds_probe_option() already walks
> chip_info->extints[] looking for the SGMII/HSGMII-capable one, I'd
> like to have it cache the discovered port and id (mb->sds_port /
> mb->sds_id) instead of relying on the fixed
> RTL8365MB_SDS_EXT_INTERFACE_ID/_PORT. pcs_config() and the bypass
> line-rate mask would then use the cached values, and
> rtl8365mb_sds_raise_rate_limits() would check mb->sds_port == 6 and
> warn+skip instead of assuming, since only the port 6 register
> addresses are known/verified so far.

The warn+skip in particular I think would be actively harmful:
skipping the write means that hypothetical chip ships with the
reset-default ~1.048 Gbps cap - the exact problem this patch exists
to fix, reduced to a one-line boot warning. The MR85X report showed
how easy that cap is to miss; it took multi-client throughput
testing to even notice it. I would rather keep the assumption a
hard, greppable constant next to a comment stating it, so that
whoever adds such a chip trips over it while writing the chip_info
entry and brings the SerDes path up against real hardware - which
they will have to do anyway, for the mux, the tuning tables, the
option probe and the limiter addresses alike.

So I would prefer to keep the series as is. If a chip with the
SerDes on another interface ever appears, its submitter will have a
datasheet or vendor code in hand and can parametrize exactly what
that silicon needs, with values that can be verified. Doing it now
would generalize the two parameters we can test and guess at the
rest.

Best regards,
Johan


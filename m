Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44E282F1E
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172376; cv=none; b=FGx8snr1nA2V/6u83N+XCzd4ItDqxHwnl4MqMLqh6CyWzfMqh1XYYwXrzEXHQ9h/6wZk1QWqyE9GUP9fkTMKfTy1ehfwzowpAwXw4/6OhE6x+MmanPDlUmouycXBcepf2UF2dTWk/nM+YZhGXvFLnOcjXxoIwbeUlbvMyImTl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172376; c=relaxed/simple;
	bh=jyLmSLhSq4w8mYax0r97CS4BX3pLU4DQ57ciOPhVbNc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LTsRiRqYscl4QiYuy5wX8E3V5kRU1bcJ0RR/BKyk9XO7sVHi2Bd65e+U8REqTgj8Z856/U5s2ObYLm8LCogPOVYp9PJwpKots+RhR4vzu1F5gjO5kQhdS/ucCzur2J8kgWerj98IjjYcvEi047k32SjLP0ZBV1uQEoRyrzX1wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev; spf=pass smtp.mailfrom=well-founded.dev; dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b=OW6XnJ73; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b="OW6XnJ73"
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 9F58E17B03FFA
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788171855;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=3a/1tLM258+XX6sFATstRDA/BXsqthctD9Jmbcf7QLk=;
	b=OW6XnJ73rMHhix5m/I8qylskUIhn+n7eSE+Ef+6jHLS9yNU7JFjmZ2yGTlvJHoKj
	smfnlH1jlkwXeE8bnVuAQagSCarq9EcmKGvk3lmXDELY4MXnTOFLufZiqCOh7lPjmQC
	npY1alQOXViJavLNAqaN8+3kQoXBbM7RcCAkpl3OgKeLyIshWudNGnmXFoU3IKvWkZQ
	4URHP1QhmECB1/yTI0JLGYiD9ALvLARlRBrLtL6lW+KKR0SzC/yPujH+WWA59g5sBLE
	BAcVgVx91ll8px6Gfn4B7KvQ06RXNeAvumld+rMB6kNJoUKh6oEaGL+61lXxMXIb8+D
	MSSEXJbNYA==
Date: Mon, 31 Aug 2026 12:24:15 +0200 (CEST)
From: Ramses <ramses@well-founded.dev>
To: "Jason A. Donenfeld" <jason@zx2c4.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
	Wireguard <wireguard@lists.zx2c4.com>,
	Netdev <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <P0MLDmd--F-9@well-founded.dev>
In-Reply-To: <apT0H7qIwFW-JCLn@zx2c4.com>
References: <20260827-wg-tstamp-v1-1-4acfebb855ef@well-founded.dev> <apT0H7qIwFW-JCLn@zx2c4.com>
Subject: Re: [PATCH net] wireguard: queueing: preserve tstamp_type in
 wg_reset_packet()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 0163e381fa67fa966160938ffa017803050e57578bb1735d37cd25d20463a96a9bb3a550250bbc5eaa94bfdfd8cf3defcf1aa43859ae980630826bb8230f264e7f:TurnOnPrivacy!:tutamail

Aug 31, 2026, 05:25 by Jason@zx2c4.com:

> Hi Ramses,
>
> On Thu, Aug 27, 2026 at 01:52:56PM +0200, Ramses de Norre via B4 Relay wrote:
>
>> From: Ramses de Norre <ramses@well-founded.dev>
>>
>> Sending traffic through a wireguard tunnel on a host using the fq
>> qdisc fills the log with:
>>
>>  fq: likely mono tstamp with tstamp_type 0
>>
>> An skb carries a timestamp in skb->tstamp and, separately, a
>> skb->tstamp_type field recording which clock that timestamp came from.
>> The two have to agree.
>>
>> When wireguard encapsulates a packet it calls wg_reset_packet(), which
>> clears the fields that must not leak from the inner packet into the
>> tunnel packet. It does so in two steps:
>>
>>  skb_scrub_packet(skb, true);
>>  memset(&skb->headers, 0, sizeof(skb->headers));
>>
>> skb_scrub_packet() deliberately keeps skb->tstamp when it holds a
>> monotonic timestamp: that value is the time the packet is scheduled to
>> be sent, and the qdisc still needs it. The memset then zeroes
>> skb->tstamp_type, because that field sits inside the headers group
>> while skb->tstamp does not. The packet therefore leaves wireguard
>> carrying a monotonic timestamp labelled as a realtime one.
>>
>> Nothing noticed until commit c4f796c4f16b ("net_sched: sch_fq: convert
>> skb->tstamp if not monotonic"): fq used to assume every timestamp was
>> monotonic. It now consults tstamp_type, spots the mismatch, warns, and
>> falls back to treating the value as monotonic. Pacing still ends up
>> correct, so the log spam is the actual problem.
>>
>> Save tstamp_type before the memset and restore it when encapsulating,
>> next to the hash fields that are already carried over this way. When
>> decapsulating it stays zeroed, which is right: an incoming packet's
>> timestamp is a realtime receive timestamp.
>>
>> Fixes: de799101519a ("net: Add skb_clear_tstamp() to keep the mono delivery_time")
>> Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
>>
>
> Thanks for this. I've queued this up in the wireguard tree.
>
> One thing I'm wondering is whether your Fixes: line is correct. Would
> c4f796c4f16b be a better candidate than de799101519a? Or maybe even
> 4d25ca2d6801 is best?
>
> Jason
>
Hi Jason

I think you are right, but I think d98d58a00261 is actually the commit that introduced the issue then (but no warnings were logged yet at that point).
The patch doesn't apply cleanly to that version though, I think it only applies starting from 6.11 because of a rename, so we can't backport all the way back. It's probably fine though, since the warnings weren't being logged yet at that point.
Do you want me to send an updated patch, or will you just fix this up in your tree?

Thanks,
Ramses


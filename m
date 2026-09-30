Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B392353A71;
	Wed, 30 Sep 2026 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779929; cv=none; b=sX0ZETDYXN+IHlSGesU5vJQjnHrqdR9cvScXfG+rM4381C1a+/P4Q83ZRQk0UmxH1QFEk/ZD2Ywa+yzmRowdJ052sm2TNIzKXt32SjIYvMzxRw3419On+/kbtpnuaM9wPmNUUsA5k/EeQHv6IBwuYRxObi5gPspK4bG/YiyKIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779929; c=relaxed/simple;
	bh=2k+1T713G/lo3AecUiGwAguTRxmiJbv6A3HqYg/BYyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2+Ne/j3La2vSYR1gfTkUCwH9Uuug06tfKaFN56nAyltHC5Y0i6XqgaKGPuygu4S4ShJ5XpeICO51qjAEzJO+B8EBRTb2cQY61XIUVocqDMoNOYZ6YmlSqYMqUCqDbV/e4oHbKCQP7DQKV57u03D/n++lL2cyqYbVzWYkFV3gDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mpXO5k2/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVPh+dGv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mpXO5k2/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVPh+dGv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 47F80EC023A;
	Wed, 30 Sep 2026 10:51:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 10:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790779911; x=
	1790866311; bh=2SMhclN4SsvLh8DRE8O3j/Qx7xSxfZGZWF/BaAO3JAE=; b=m
	pXO5k2/jplRiGKILBeiAvJHZYXHJDIzBnmrDVqPISaSELNaY1IYV+cntxYAqtIV/
	w9KApPwtTXWAIf1TtiSUVxANBmsRQ4nVhZ5B35MCD8uFpD51PhHG3dZ/cYqKhiZy
	bixbL+4SDIrjSMAS5dQTGflZAefZGHrjIEXqVhfZa2y/OTQ7ZIOLJilNQl3jesH8
	14cvumjLm9x9/heBcoBf6KpBaRW86wiRhJ6Y8TsoRmEXLpd9wTGI7SA50GlnSB06
	ycX89HIbEI/agYuLafYJmV7oLGoB1a3BSnyc2GIHqgPUvNax9ZS1bH6/JQ65+rLT
	gxAcu5srs6JyGB5r+iZZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790779911; x=1790866311; bh=2SMhclN4SsvLh8DRE8O3j/Qx7xSxfZGZWF/
	BaAO3JAE=; b=GVPh+dGvaHjc6U8e7xgX+09MBFN/CYJBvL43D6LsVO4ZRR2NKgM
	ZP4anqcygKOpfLA53rZSa5okcIOIbnmoFzV3w0T/Q1cLlh9B4WqvGy4ukL423KDr
	6d1bhNYxFH3w32hIHhHEqzkcnjDhzwX7OFmWprPL0UGMgg725G5z20Uqgt0pNwUJ
	8Lh8NA7bxdZS8hk4Pir8W86VTqgoYCYmVUamXpXPzWBp/IoTftyzV1EqBFNBFeCF
	/QTsBDb6FHqxm58Kg9KAFs2Q/CFRbhtq45/NPlO8mNmCWMGoYOYKidifpxdvhOOl
	KG0bKPYWKLp7uQvLz91CPQj2yG1eLINS93A==
X-ME-Sender: <xms:BiK9ak1oTWlBt_yTbbqQVRViL1KaKuIiVKB0Tv9tnEWbGgXBsZmxaQ>
    <xme:BiK9atUcH7FU4IdnLtwcLka1UiXk7qdh5s0WoCZI63NgXVio1_PnxXa-m4SX7g9GQ
    yDsmuEgIvIWnp2LP-bqwdsSgHTAvTWG77yHNPA24AntrmzayZnLHCbT>
X-ME-Received: <xmr:BiK9amPo0J_qLAC3R3wGXFc-iOJfxn3PMuGyRmpQOsQV2gZe1P_IgIQAyAtK>
X-ME-Proxy-Cause: dmFkZTFf90x33wHz855Fbg7ZkA0/ErnGBLxFOh8jwxSTEZBKWwzCkElkD74iLvqbtGZmMQ
    v3ArqbldBOseW61ljOdAZLjJOygVul8FbdZh+qlPcw6hGpnifR7a8C7dRvR+rfI6liQf/j
    peWlmbiWYXwiVAwipdrsf8dcnmnlQY/jD7R4HYFaX+xgBHlb1OcLoGTHosjqTk3XVXnJOZ
    h7QUf7Q+YgeHOXhaKiwQykex6o0gr9C8m2tVVhYo2YIca7SStWt1FPOn1nzDhVKeOXEAHh
    bmsnXx6TBscrC3I2T/uMby1pHeL5S7gH3OEWd/x8IJoHwW0HuzOT9axapD1SgPv5LXRMlX
    poB5b96/d+GPfOoCCZAB7fVDjqFl8I33PKMChNQ8VdGXyOA1FQh2Po1ooT9JQ2uYldUwK/
    vxIywx1cVgLTHeQrwGc+M60lyKqWZVoyBU+l9Y/aO0s/yzi5fhtCpyA0ZHJiqVyh2I0b6g
    +HS6O30dSujHjwwmZJhsa8ijO5758Qg9XKN9Ik0GbWBkewS6o3VqU8/8bIWHy2LwfAXr/d
    8I5tMbDzcRad7e6LsQuld5rkD3rgQAiUZY1uv+1i2FcvzqgD1hBTWNi/OZpefcPRgwXM34
    2TZeYuK/nscUopBDlxSVG1GStLeJjOEzYZ9Bxeg9v83CjPqBXIoXyWwPleqQ
X-ME-Proxy: <xmx:BiK9ag235MihPGrAuB3JrVaZScayU4hMMQcexK1bPoiulcFdDsZBuA>
    <xmx:BiK9aqS5ntvhs7K7t-PHb18w0GBpxVqpfIrnuTBOyK0aQXz4czNoyg>
    <xmx:BiK9arnNvzUzMmwrrW4NlX_NgJ_GD2Ggx5r_-Ix_fCYBh6HPDrJ1Bg>
    <xmx:BiK9ajMHXBJ5ivvVybJQNXBtP8rTHKsKqMpyo3Uqmpghs2zAxvW77Q>
    <xmx:ByK9aqVLuebMqbUPXd-ZVsbsN3scCxj-JknyrQPtNW_Iye6M0Axk8q7j>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 10:51:50 -0400 (EDT)
Date: Wed, 30 Sep 2026 16:51:48 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: Qingfang Deng <qingfang.deng@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Dave Watson <davejwatson@fb.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: skip empty data records in tls_sw_splice_read()
Message-ID: <ar0iBIUzHhZijRem@krikkit>
References: <20260930052636.166007-1-qingfang.deng@linux.dev>
 <arzStIrdizPp_vbI@krikkit>
 <465aa0d9-b1b2-4c85-9cbf-e6ed296b7b12@linux.dev>
 <arzawlad0OQ9pnBQ@krikkit>
 <415fb6f4-7ecd-4d04-a3c2-56c186a5628b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <415fb6f4-7ecd-4d04-a3c2-56c186a5628b@app.fastmail.com>

2026-09-30, 06:45:23 -0700, Chuck Lever wrote:
> 
> 
> On Wed, Sep 30, 2026, at 2:47 AM, Sabrina Dubroca wrote:
> > 2026-09-30, 17:24:18 +0800, Qingfang Deng wrote:
> >> On 2026/9/30 17:13, Sabrina Dubroca wrote:
> >> > 2026-09-30, 13:26:36 +0800, Qingfang Deng wrote:
> >> > > tls_sw_splice_read() returns 0 after receiving an empty application
> >> > > record. This looks like EOF for splice(), even though the connection
> >> > > remains open and more data may be available.
> >> > > 
> >> > > Consume empty application records and retry the receive path instead,
> >> > > following the approach used in tls_sw_read_sock() since commit
> >> > > 3be28e2c9cd0 ("net/tls: Consume empty data records in tls_sw_read_sock()").
> >> > This is similar to what Chuck proposed in July:
> >> > https://lore.kernel.org/all/20260726-tls-follow-on-v1-2-99bf4cc1c729@kernel.org
> >> > 
> >> > but Chuck's patch had some extra bits (handling of the "released" flag
> >> > and of signal_pending).
> >> > 
> >> > His series also had a selftest which should be included too
> >> > https://lore.kernel.org/all/20260726-tls-follow-on-v1-6-99bf4cc1c729@kernel.org/
> >> 
> >> Thanks for the information. I prefer his series.
> >
> > Let's see if he has the time/interest to continue work on this (since
> > he didn't send a v2, I'm guessing not).
> >
> > Chuck, do you want to pick up that TLS fixes series again, or would
> > you rather let Qingfang finish off the "splice vs empty record"
> > patch+selftest based on what you had sent?
> 
> History: I stopped working on that since Jakub seemed to think the
> fixes were not worth the trouble, and my objective is to get kTLS
> and its kernel consumers in shape to support KeyUpdate.

I /think/ he meant that some patches in that series were ready to go
in and worthy of being merged quickly, while others were less urgent
and less ready, and could be finished later on (but not necessarily
that the issues shouldn't be fixed at all).

But I guess we could just ask him.

> If you think cleaning up and reposting an old series would be
> received well, I can take it up again. (And forgive me, but can
> you send along a lore URL so I'm sure I'm working on the correct
> one?)

The link was in my previous email:
https://lore.kernel.org/all/20260726-tls-follow-on-v1-2-99bf4cc1c729@kernel.org

-- 
Sabrina

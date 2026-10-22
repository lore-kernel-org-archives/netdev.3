Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704034;
	b=AggfJk1Yl3VdVSQpKMm3lUl8sMiLaL4Nivr6wpALtaDtt63/p8Zx7pUNogbbZx/G9yaD
	 K1rci9/GqUTrQluml6saZ+wT4PjIQBTNKklOfDPZdK+ORq/GnnhZmN4/RjWMCF8TBJigx
	 FCw9W7oSmWdLsGrZxIrkLEZNSTsscI4IZNhQkb3Rm8hS+uX3rTjgwWhnse2k4WLCEPrXQ
	 S3d5mCAWQWZZVa2cQdKj6vddVqicZHvg/QinKBeC/Qs4szg3Tv+jmFoo7rxz2+D2wgFlE
	 nA9Dn2xyD5kap9pJ5ksqP97kzwxxYjKebQ5l8Lz6NYmhQT34cRni9/qCVIoqEgv2sMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704034;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RmERtXTPVBf/bnIMERGkoDkyTulnf+WFY9nfWAMIalA=;
	b=22TVYQZTlscj8L1QaXhLoXxaaI/2yZbtDuCPXgXkAv5uTtJzNtle9GaiIFzupTHvU5Gz
	 8Q4ymnyNGFTzsTQP4rKoqIG0n1gp99l76znendIe+wZK9QmUbONH2FnsxQBdczftP2c9M
	 0XayqewCA+um1XiXubHt4qFI4NAZ4BN5pnpcu2IrSTTYfDI5bmUyDTgaiHIiH7grmNweJ
	 zJ10g3I9Wd+I2H/TQvt1xZ1k322AVyH69No1T0rmOnDjuK0+/eJLY5W9KEQWsv+8C6NRT
	 uODrbVi6gvHSruTEvjA8XOC02wR2ChPVjmUD2sKHrlzTNwCXJnUa7xOQBZopzNExnBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=nn91opKh;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67D606A31A;
	Thu, 22 Oct 2026 21:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E67D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=nn91opKh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RmERtXTPVBf/bnIMERGkoDkyTulnf+WFY9nfWAMIalA=; b=nn91opKh1d4g2TM2Z31maWvuLj
	ggmMblIi1H2gyydd2qZPeZUxZvOKFLJ0DKd4E49dpHdeZJfAxozlfrVwmp6MzVZrmtTTICc+zOE0b
	XUrkoOU9WCVnzcR1NWN6cg3xYHOtRIdx1MibX5nBjLN1jWLi78xzbMI/1FCBczk3ujFfKlx6MlpIC
	xT36t4KJVb5/jIY6NcqRvFVkn91iUF/V/EEw5a72JUH0D/8fmiwg38p6tdvS5AfnYKLp3TeYjRHlG
	D9LfDRRFG8aZiI/IVUj7vYTBmxvP7ZYQnqFqJg1LFXift2oibaqgbB5yqRPuGttAS7zNgkKeDiREm
	SnmfXNDQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK0D4-000000081iC-3lF5;
	Thu, 22 Oct 2026 21:20:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 275B6300720; Thu, 22 Oct 2026 23:20:25 +0200 (CEST)
Date: Thu, 22 Oct 2026 23:20:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Willy Tarreau <w@1wt.eu>
Cc: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"security@kernel.org" <security@kernel.org>,
	"maintainer:NETWORKING [GENERAL" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"open list:NETWORKING [GENERAL" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: ZDI-CAN-33367: New Vulnerability Report
Message-ID: <20261022212025.GV2823843@noisy.programming.kicks-ass.net>
References: <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
 <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
 <willemdebruijn.kernel.178cac71d218b@gmail.com>
 <20261022160251.GW2009045@noisy.programming.kicks-ass.net>
 <BYAPR01MB383065E105701C81A3D0472D80652@BYAPR01MB3830.prod.exchangelabs.com>
 <atplVXLEE_mNqhek@1wt.eu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atplVXLEE_mNqhek@1wt.eu>

On Thu, Oct 22, 2026 at 09:34:45PM +0200, Willy Tarreau wrote:
> > We will have some discussions internally, but in the meantime, we will send the cases to you as we always have.
> > If you don't want to do anything with it, that's fine too. We will release the findings at rejection, or 120 days.
> > Whichever comes first.
> 
> The main problem we're having is that it's not possible to have anyone on
> your side nor the reporter test a patch. But I won't rehash this, it's not
> new, but *this* is what makes your reports way more painful to deal with
> than many other ones. You (unvoluntarily it seems) act as an insulation
> layer between reporters and develoeprs and that really doesn't help.

This; Willy is far more eloquent than I am, but the zdi reports have
been very painful. And as said; this has been raised a fair number of
times.

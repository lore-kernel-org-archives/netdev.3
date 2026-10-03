Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4892F87B
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791008573; cv=none; b=nrByoJdaXdAIYKWWuypMXbodH39RJmcLzBf8k8t8ADcrydj2d4+jYm2D6ORbV9g5UI3JmL+EP/mLjK7UXonOD+dXTfcNjoby7l2yTN9enudjS0jBgqAMTF4Wjf2tbP14SPFpehJO2XgM6SX0joJHz8bh8GZ5NNCviyXAuoLPbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791008573; c=relaxed/simple;
	bh=wvGB9H9HwGdd/hOr3ef0lxT4b8C0HfnFPPf2T5k80VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFHn6UTq9G9uQg55uPoogf1R8Sb7SVM/xqy0w+EQ/f1XMUxOFG6MMo3fjvg9PqxhezwEF4HxYD/7BgEgzOlUdZB0mc2HhIpQydGnzM8KNCvEAA9GUqKul/upc9iMe8rzdzAJIR/82LR1yVcVISprXBKKzQzyjitro+azTC5eGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.96)
	(envelope-from <laforge@gnumonks.org>)
	id 1xCslM-007iar-2o;
	Sat, 03 Oct 2026 07:58:24 +0200
Received: from laforge by localhost.localdomain with local (Exim 4.100.1)
	(envelope-from <laforge@gnumonks.org>)
	id 1xCsl4-00000000Ix4-0UjQ;
	Sat, 03 Oct 2026 13:58:06 +0800
Date: Sat, 3 Oct 2026 13:58:06 +0800
From: Harald Welte <laforge@gnumonks.org>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org
Subject: Re: [RFC] gtp: add 5G PDU Session Container (QFI) support?
Message-ID: <asCZbsGo90ROQIS6@nataraja>
References: <20261002134002.3529706-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002134002.3529706-1-anilkaushikwireless@gmail.com>

Hi Anil,

On Fri, Oct 02, 2026 at 01:40:02PM +0000, Anil Kaushik wrote:
> 1) Is this something you'd welcome in mainline gtp.c?  I'm aware a lot of
>    5G user-plane work lives in out-of-tree datapaths (gtp5g, the eBPF
>    eUPF), so I don't want to add datapath complexity you'd rather not
>    carry here.

I think the big question is about the use case.  Do you yourself have a use case
for this? Which userspace programs (ideally open source ones) will be using your
proposed mechanism? For the existing GTPv0/v1 code we have a couple of different
FOSS applications (osmo-ggsn and ergw) as well as know of a number of proprietary
applications using it.

So I'm wondering if this proposed enhancement is "just for the sake of completeness",
or if you have any application (or will contribute patches to existing applications) so
they will make use of this feature.

> 2) If yes: on RX, once the QFI has been parsed out of the PSC, what would
>    you like the driver to do with it?  The options I see are:
>      - stash it in skb->mark, so tc/nftables can classify uplink traffic
>        by QoS flow;
>      - attach it as skb metadata (tc_skb_ext / metadata_dst); or
>      - just validate it and otherwise ignore it.
>    The shape of the RX patch depends on this, so I'd rather ask than
>    guess.

I would say skb->mark would make sense to me.

Regards,
	Harald

p.s.: Answers might be slow, I'm just about to go on a motorbike tour in remote
mountainous areas with limited connectivity and/or time for e-mails

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

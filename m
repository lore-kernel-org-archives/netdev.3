Received: from mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299983F4DCF
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130751; cv=none; b=ufelKmF1DaSkraOr39kvBq/+oqf5z2VjUQmJ/OIy5/uyFltTHKcVuETHM+3kLt07f+j1iGc6c0drQ1JXJDEwG3NexwXmJaQCwULmMPd/DEifELUnPxkEi5s9m/dE67T+CZasjjpD53SwS1PRu1QCKMhIMt8wttReUmdyPOlP7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130751; c=relaxed/simple;
	bh=NdUNPhshaWvgqEYu6L3ZD9J575dA2LGJGdqZpqbDAG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGoMnqNxt0giR7Dq1UvAugVPxYzrvwya0THW6UG6i9Xtpeoh2Za6F/2oZOteyDudv9shTeHM1vs/agwg50dDY+gnjsg/kzIgJOfMj3LFP2cmYXcOLEOWRatom2NvEoNrqtxhTObTHpX4UkYz2oh2UO5jqd6bwzjcEsM0kVMDUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/T4mJ8Y; arc=none smtp.client-ip=91.218.175.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/T4mJ8Y"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NdUNPhshaWvgqEYu6L3ZD9J575dA2LGJGdqZpqbDAG4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787130745; v=1; x=1787735545;
 b=P/T4mJ8YNeX0Xdx7woohC7jO65fg7TWBrDgt2kVkLd4lDP2BfNLtAq+B2/hSaCAhEooymeyF
 s0KHUvRP6NtRF7RsQFDyRsFumb7WtTDp/jSU3iji1ARqlvOknKyDkJ1mubjmV8vm1mdY4j3+Xv0
 UbLHx36w5vrVeGKSrzS6YknM=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.242)
	by smtp.migadu.com with ESMTPS id a4de34c0170b9fc7;
	Wed, 19 Aug 2026 09:12:15 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 17:12:08 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>, Jay Vosburgh <jv@jvosburgh.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiale Yao <yaojiale02@163.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
Message-ID: <aoVzaHfKWG-_OJOY@fedora>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net>
 <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net>

Hi Oliver,
On Tue, Aug 18, 2026 at 03:25:36PM +0200, Oliver Hartkopp wrote:
> Hi Hangbin,
> > Hi Oliver,
> > 
> > Sashiko gives some feed back[1], would you please check it?
> > 
> > [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260815153938.187073-1-socketcan%40hartkopp.net
> > 
> 
> Unfortunately the AI bot review did not create a proper answer, so that I
> would be able to answer in-line.

Thanks for your reply.

> 
> Sashiko says:
> 
> "Is this test too broad for plain Ethernet slaves?
> netdev_has_ml_priv() only looks at dev->ml_priv, not at dev->ml_priv_type,
> so it matches any driver that stashes a private pointer there, including
> ARPHRD_ETHER NICs that were never involved in the CAN crash."
> 
> and later also points out potential problems that could arise with tun.
> 
> Today only the CAN subsystem properly sets dev->ml_priv_type. Other users
> simply grab dev->ml_priv for their needs (inkognito).

Yes

> 
> To me the question is whether bonding/teaming and now also tunneling code
> takes care about the mid-layer private pointer dev->ml_priv?!?

AFAIK, no.

> 
> The fact that the issues have been found by syzbot for CAN devices might be
> through to the fact that the virtual CAN interface (vcan) can be created by
> netlink commands and can be easily used in test setups.
> 
> So what would happen, if the same tests with bonding/teaming/tunneling would
> be done with real hardware drivers as the mentioned "direct ml_priv writers
> still in tree at this revision:
> 
>   drivers/s390/net/qeth_core_main.c:qeth_alloc_netdev()
>       dev->ml_priv = card;
>   drivers/net/ethernet/chelsio/cxgb/cxgb2.c:init_one()
>       netdev->ml_priv = adapter;
>   drivers/net/wan/hdlc_fr.c:fr_add_pvc()
>       dev->ml_priv = pvc;
> 
> plus drivers/net/ethernet/i825xx/82596.c, drivers/s390/net/ctcm_main.c,
> the libertas main.c/mesh.c paths and
> drivers/net/wireless/microchip/wilc1000/netdev.c."
> 
> ??

I'm not worry about cxgb2 or 82596, which are too old. But s390 qeth is
still actively maintained (Cc the maintainers). Can we block them directly?

> 
> If bonding/teaming/tunneling might accidentally overwrite dev->ml_priv we
> have to block all those devices. No matter if it is CAN or whatever ethernet
> device.

How would bonding modify dev->ml_priv?

> 
> And this it what this patch aims for.
> 
> So either the users were lucky so far or they never used
> bonding/teaming/tunneling on these devices? I don't know.
> 
> But it definitely looks like we should make a safe move to block all ml_priv
> using devices.
> 
> Most of the referenced drivers are 20+ years old! Only
> drivers/net/wireless/microchip/wilc1000/netdev.c is about 11 years old and
> moved from staging into mainline in 2020. The use of ml_priv is a left-over
> from the former out out tree development. The wilc1000 drivers does not use
> the existing infrastructure in the correct way. In all cases this wifi
> driver and all the ancient ethernet drivers should (and can) be implemented
> without using the ml_priv pointer today.
> 
> When there are (unlikely) real users of those (ancient) drivers together
> with bonding/teaming/tunneling those drivers should be changed in a way that
> they do not need dev->ml_priv anymore.

No need to fix the ancient driver at present.

Thanks
Hangbin

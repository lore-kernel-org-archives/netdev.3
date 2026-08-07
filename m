Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6311430DECB;
	Fri,  7 Aug 2026 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111922; cv=none; b=t8OphnRvxkjaMjJZ8jTx5CMUIKgCLN8qYcf3emW2QPmc0O41ZDbE2w9IrLXk4S9jLbiaVTECUDavSyu0gKmyJtH/GKlAWgRpwC26CJsRPdfz0fSUCR3OZ+5kJfNeBoNIT5yfR0tO4ApHb7Kj3iMYDzwwqS7Xlw0NMiSWKEHE7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111922; c=relaxed/simple;
	bh=VI513X1okECF2t2PaaZjuaDfrShinccLnB67B6uFNns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqP8MsHKDpwmysbs9mFmvEZRCiUz2Qlusy5BQSl4p+5lp2e6riNTEsDSbbi1ry/ua1dJmHmreVLV4QtcAy4MHabkxUYD2oArz1vLR4WDvwfw15U4GteJvfl4QG2S04FTVCtPYaPXBcQnKwYe750E0xAq97iK37qM8ItIxjyiiLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ofxbCPa6; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ofxbCPa6"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 225D360191;
	Fri,  7 Aug 2026 16:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1786111913;
	bh=t+q59PlsJJCf4B3uYnLYfge7G8iRmbd0xIIll3+jF0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofxbCPa6834Rh8eCt6dL7gRcLOpDzazTzK+nOuJEgufEfq815qM8uV1Ojzup6pXuR
	 Kq98PZIS+EldkMbJxbGZWSI1eS/WB1dt8164s42bJZze4ZXsFUuRAqxYfmzfDnbLi/
	 nEMZErSbqWg6zIHJOYHbQIIxKZyjEuMF2jrvYCj9abWvYbN/vxQ3ypxgt6bMsX3WJm
	 UPnL+Hxykc73EK66UqBIMWAQgaCphRk7LWznD0KbpLunhSA9iIo38cIyOcCWATmNlp
	 xYki6JMuYisw3KTxsHuZxlGGQW5mKfgJpCfDxO9gvbhPMAoC65A0qZf1HVPWZLI86s
	 iYvHCikqDhdaQ==
Date: Fri, 7 Aug 2026 16:11:50 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Simon Horman <horms@kernel.org>
Cc: Qing Ming <a0yami@mailbox.org>, Harald Welte <laforge@gnumonks.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] gtp: serialize PDP deletion with link teardown
Message-ID: <anXnptmH5Vk70e44@chamomile>
References: <20260806023226.5537-1-a0yami@mailbox.org>
 <20260807131335.GL51943@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807131335.GL51943@horms.kernel.org>

Hi Simon,

On Fri, Aug 07, 2026 at 02:13:35PM +0100, Simon Horman wrote:
> On Thu, Aug 06, 2026 at 10:32:26AM +0800, Qing Ming wrote:
> > PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
> > network device is being unregistered. The latter is serialized by RTNL,
> > but the generic-netlink delete path only holds RCU.
> > 
> > Running both paths concurrently can therefore make both paths delete the
> > same PDP context. On a KASAN-enabled kernel, a reproducer racing DELPDP
> > against RTM_DELLINK triggered:
> > 
> >   Oops: general protection fault, probably for non-canonical address
> >   KASAN: maybe wild-memory-access in range 
> >          [0xdead000000000120-0xdead000000000127]
> >   RIP: gtp_genl_del_pdp+0x1c1/0x420 [gtp]
> >   RBP: dead000000000122
> > 
> > The second deletion dereferenced the poisoned hlist pprev pointer.
> > 
> > Take RTNL around the DELPDP lookup and deletion so that PDP creation,
> > generic-netlink deletion and link teardown use the same serialization
> > domain.
> > 
> > Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> > Signed-off-by: Qing Ming <a0yami@mailbox.org>
> 
> Hi,
> 
> I think it would be good to mention how this problem was found,
> and to what extent it has been tested.

I know what it is going on, I can take care of this, thanks!

> You may also want to consider adding an Assisted-by tag as appropriate.

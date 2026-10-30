Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378888;
	b=V58NXtJx+oEL0Vd6SleuqcUWEfQt6ygJehV332en66CL4Wa3hq/QeamXvxi0BqJNT7KE
	 ckmLHkcoJL+7dMiOUT6Rm2jSJVBDK6IZFOrPEa6zpju3G2LzHMWGeCWU0U6g3oFGp6XS8
	 uHiRtmRuHUljYtocdFK/9yHfZSyzASRW9oGBRNMpNdP/Z1PxX5lzSFX1lB7Vfu+8Ak6ob
	 efprF+MCFPlQB8MNSDJqRUEnvyNK5ozM89lNPg6HzgOok7eMRuqnp39XF5POCNd4KRR1i
	 oicxROOvih5vhvcnv96jjky8n0Azr1XXPqnUemi/wjQJOTTDiqzQxZE2lUMOyfETWIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378888;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=1PWjnarbXn2HA0JXVn8uhcAwVn54VxjKuus/kKGu7w4=;
	b=PzwQ9TiTMypePSBPrO8j0/5bRHC1zkuBSNKhVd2wEk+Xuj49vafRkGWxM0Cnc+Hs0FoC
	 pM9yEF5Jrcupy9VV+8iAYydY2jOUinvnl5yFiUg/g4XlR7s6EYYHtNLk79bxMdqNLeKv+
	 oyx4y2PDD8nO0bg6zOvLgHm2zXDELu4/gNAMB9uDTFCdRi1mzINvAFITOefaF60Cbfvfq
	 /VVby0K2TSXt1OYoz+MFnphN7dbbIcTLpGJoMVfmvtoIdP9CKNqWuy6w7BPEoJ6BLhtZx
	 jmHRkMpzU8eSIRjkjYeVUctJJewi+xWFFmc6CjjzspKBphKGfgLo1A7u4gZVHOvKWvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Ue21snLp;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74C606A31C;
	Fri, 30 Oct 2026 16:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B74C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Ue21snLp
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D0654B0;
	Fri, 30 Oct 2026 17:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793378745;
	bh=nNfRFz9RHsWzb2VPMSn/bmoPqJSmb2mjhetIfPVXziw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ue21snLpAimaE/sWZ7TLy5tNuEQxYK2fRPPz/vMxP71GPQMqdjCX7QZHLcQyIsBMh
	 BVfV2soGwprlk0oHyQcGa+tA4rtD5foGjJhj8cWwch+LP6ePzi43VS82bkyn5vdIt2
	 QtLGCe6JFUxhxiNgrpvIAl7TC60ysrLp7k56CRbc=
Date: Fri, 30 Oct 2026 18:47:58 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: try to force agents to disclose info
 for fixes
Message-ID: <20261030164758.GD2673734@killaraus.ideasonboard.com>
References: <20261029153459.2257998-1-kuba@kernel.org>
 <9A74CA14-D4C0-4252-A3E7-256F9626B513@tipi-net.de>
 <CAMuHMdVJVxpX6OLVpE9K9CDY5q61A2rFGf7FpUjs7xpFwReEzA@mail.gmail.com>
 <20261030093418.2fbf0999@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030093418.2fbf0999@kernel.org>

On Fri, Oct 30, 2026 at 09:34:18AM -0700, Jakub Kicinski wrote:
> On Fri, 30 Oct 2026 11:58:17 +0100 Geert Uytterhoeven wrote:
> > > >+Coding agents must refuse to write the commit message unless they know
> > > >+what discovery method to include.  
> > >
> > > Maybe make it more explicit, as the sinfo bot will ask it anyway:
> > >
> > > ... and whether it was reproduced or tested?  
> 
> That's already in the existing text?
> 
> > Which is true for anyone, not limited to bots...
> > 
> > Do we really need "different" guidelines for humans and bots?
> 
> Looks like at least a half of the commit messages today are
> bot-written. With the existing guidance the bots don't add
> the requested info by default (presumably since they don't
> know the information). If this patch doesn't help we may
> need to add our requirement to coding-agents guide.
> They seem to be reading that one fairly reliably.

Is there no way this can be tested without being merged upstream ?
Tweaking documentation in semi-random ways in the hope that some of the
changes will have an impact doesn't seem to be a good process,
especially if it's to work around defect of tools.

And unless I missed something, I thought there was a general consensus
that documentation should be written in a way that doesn't reference
agents specifically, as the same behaviour is expected for all
submissions regardless of how they're generated. Has that changed ?

-- 
Regards,

Laurent Pinchart

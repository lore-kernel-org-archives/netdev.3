Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEF486E43;
	Fri,  4 Sep 2026 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525034; cv=none; b=JSZXmnN1gmiKujkSPORqYdmcn3k752uz1/WsZWSE1oipiVC7KBln4JbsOGbHKPq7VRSdq28KjEPTqXC1JCNlK461lBS6oyRpX0jQus3NmoQED9V2WES8i514x9nIyd4l6d+5KBT+gzL/eKrdU4ErupkUwS8QCjBprWcJ7KyWOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525034; c=relaxed/simple;
	bh=Ftvi78d/TOyUxq02juunRhd/tg4Kdt7sUmX5AhoObsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB5H3EqVkCSyNnCdbP0cLOB9XiHlQ7FE9Y+0GRClQSIjkaC4MdrvUErnY1eTa4le8nc6oItd9utkoxF/0OJPyRzRwOwqejwdcyTwbBV2KlpTjT+SzRQNYEyu/ZpxEAO/IPaWz6coS6YypyOSvgVtplyBlt6/uaeKUJGfBYEq5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx5ZD8fm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx5ZD8fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D000A1F00A3D;
	Fri,  4 Sep 2026 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788525032;
	bh=W3fzxYTB1fVI64LoCquVTflEJEBt81oZvvYr8HpEXdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mx5ZD8fmt1QKRZeaqDIlWZodb32XQUSGNHvACAYII2HSsLsSQcvG5aLJp5eyjMhov
	 YJMqB3uB0fGCr46zEHga6l2BKUJBs+d0callvP6UizuBl2Dx5K69azeB6YxnavFqRy
	 s85a6ULcNkaBTltSBTCWgxnJtx8DZExofLAeung875HwbadAoE+vsAOsrstjCyjCGf
	 orBbp0K3CgaTGpbcx8vyT3xYLcqcjEDm6y+RQSsMzLcFEECMe4z0fuIE3WiBg6t3cK
	 tSChf2cSOvoDWkmFKINebefm1AXoN+UJYGdW5+Z+yW8a/JmwQBoQCxc5kotUtSItRl
	 xEvRfI7UW2x2Q==
Date: Fri, 4 Sep 2026 13:30:28 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev-bot+sashiko@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sgoutham@marvell.com, hkelam@marvell.com
Subject: Re: [PATCH net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <20260904123028.GN396647@horms.kernel.org>
References: <20260901045857.2779326-1-rkannoth@marvell.com>
 <178850876430.4131868.17635457333077226877@kernel.org>
 <apqI44Y5ooLOPeij@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apqI44Y5ooLOPeij@rkannoth-OptiPlex-7090>

On Fri, Sep 04, 2026 at 02:31:23PM +0530, Ratheesh Kannoth wrote:
> On 2026-09-04 at 13:29:24, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> >
> > Critical: 0 · High: 0 · Medium: 1 · Low: 0
> >
> > - [Medium] otx2_get_link_ksettings()
> >   (drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:1235)…
> >
> > --
> >
> > octeontx2-pf: report port connector type in ethtool link ksettings
> 
> > Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901045857.2779326-1-rkannoth%40marvell.com
> 
> i think, below sole issue can be ignored.

I'm assuming this is because the firmware always returns valid ethtool values.
If so, it might be worth spelling that out in the commit message.
But I'm not going to get hung up on that.

Reviewed-by: Simon Horman <horms@kernel.org>

> 
> +---+----------+--------+----------------------+---------------------------------------------------+
> | # | Severity | Status | Location             | Issue                                             |
> +===+==========+========+======================+===================================================+
> | 1 | Medium   | New    | otx2_get_link_ksettin| Raw rsp->fwdata.port (u64 firmware field) is      |
> |   |          |        | s()                  | assigned directly to cmd->base.port (__u8 ethtool |
> |   |          |        | drivers/net/ethernet/| PORT_* field) with no translation, bounds check, o|
> |   |          |        | arvell/octeontx2/nic/| validity gate.                                    |
> |   |          |        | tx2_ethtool.c:1235   |                                                   |
> +---+----------+--------+----------------------+---------------------------------------------------+

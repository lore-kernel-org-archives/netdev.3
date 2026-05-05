Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C924279E5;
	Tue,  5 May 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983962; cv=none; b=rO4zL6ff7ayt5nYhtyvsGjlvNmum1MxjFw35nJctIjjhwwIc1KsXFcwyHomVbFeVjAWWSFPMSkieSBf6A0bFmXFDF6LT87jF1X0dhFrzTVgdHqByi4gDQ1P80BwsXTE8EBTwgYOa3POqd0YewtZ0pskZPtuSgk91x8sV1WghR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983962; c=relaxed/simple;
	bh=7pes9zcae3vHCzfAZbpF/EN+rB9zXqSMqbpOsbzN3DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAEU4Yb4ne7FctZIWRzpplzZgkv7nnRPXJnfN1BJ56xINS98Hh14BeAepe2sZZ7i5kw2xQP3x3uIMkR68nLHxDlO04VW3D6JFUYtVOoII/3ejF0id9IpchxCPK/2b/bLBhE0dSgB35P7XxIEhmxY1nnA+ZQX7eKuT0J/PYbJSfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Br3aQ9Pw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Br3aQ9Pw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hIB2dxpZNwtrASQt6f6Gb1CL4EQKfsUI6wu1CgrVONk=; b=Br3aQ9PwpTk+97oMPh/Zt84Ag3
	uCOTo4FUyYBBAwiPME4tH4ztV9nTzgtbBJxVRDOt2EUwvHfdP91v/c2mxrl5Ads2+9Vmun2cg9g4G
	ALoafzsy1qTaKMzv2yzyDH0ujvstSoPD09/2mihu+WyH0oz23u9QXuKPK8c8ZgH0aEJU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKEqS-001SJn-4K; Tue, 05 May 2026 14:25:48 +0200
Date: Tue, 5 May 2026 14:25:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net v2] net: rtsn: fix mdio_node leak in rtsn_mdio_alloc()
Message-ID: <2ebef338-26cd-4116-bbcb-f9015507f8da@lunn.ch>
References: <20260504200356.3529873-1-shitalkumar.gandhi@cambiumnetworks.com>
 <20260505085840.352206-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505085840.352206-1-shitalkumar.gandhi@cambiumnetworks.com>

On Tue, May 05, 2026 at 02:28:40PM +0530, Shitalkumar Gandhi wrote:
> of_get_child_by_name() takes a reference. The rtsn_reset() and
> rtsn_change_mode() failure paths jump to out_free_bus and leak
> mdio_node.
> 
> Add out_put_node to drop it before falling through.
> 
> Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethernet-TSN")
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Changes in v2:
> - Restore blank line between `return 0;` and `out_put_node:` label (Geert)
> - Add Reviewed-by: Geert Uytterhoeven

Please always create a new thread for a new version of the
patch. Without that, the CI system just sees a comment to an existing
patch, and does not run. So this patch has not been through usual
testing, and will be ignored.

	Andrew

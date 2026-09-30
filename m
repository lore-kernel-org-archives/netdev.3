Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991F331EA4;
	Wed, 30 Sep 2026 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773057; cv=none; b=AF2CvJqwACMJ5cprMVzV1HyHQfY9veCGBgQOVIGTd1PSyTZmzu0+Nqo1yaLtSC90kcUG06V8I3Vbc93/ybvknszCw4DWGDZo6QgH9R42WQhRitxX5vl7ht3oQioN5iaeVnJ68p0z1jMcPvJKABiqtPXASFppVmukqesT3h2dSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773057; c=relaxed/simple;
	bh=g2d+X8MBvHxOrnMCmgmAgXF81xe6ZYraPINRlVjSE/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8rDDpcF0cnWk47bkr2wRwXNbhcEvZoDkcZ+zyHgIyoARjjhQV2b0OP4g5kTBSE1aSAR61p20+DruAXAfh7vwDXnHc0cCRfDyM4zBoWf9loVxWqbKo4xdAX3JUCLUIohZlTjisci/o10EfgaqoqwXgHOE4zgCwB/RrzKnr0BjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VnzVJWLZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VnzVJWLZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y59Absx07H4EZ/nQKHispdNoG53upukBkzFkCKkGA2Q=; b=VnzVJWLZ/Rnno0pCk4lbV/8+ey
	vMc/4hbp/byS9OTIgoxzyXVrxR/jvcxeIYbRCdNBlogryIBkeNOnPFrbQTPkz/r9D8GMRcqpKhTmT
	AfQl6r7yIzzaGtSULdhRWRdtSkTIzxat3MVIV5WU1FaWnRN8bX9lvpWWi+lckwJZUQD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBts4-0089rC-R7; Wed, 30 Sep 2026 14:57:16 +0200
Date: Wed, 30 Sep 2026 14:57:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Meghana Malladi <m-malladi@ti.com>
Cc: elfring@users.sourceforge.net, haokexin@gmail.com,
	vadim.fedorenko@linux.dev, jacob.e.keller@intel.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix switch mode for offload
 and non-offload cases
Message-ID: <a2517fd1-3e22-4483-839d-4aa5d9f5f995@lunn.ch>
References: <20260930124356.3083743-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930124356.3083743-1-m-malladi@ti.com>

On Wed, Sep 30, 2026 at 06:13:56PM +0530, Meghana Malladi wrote:
> Non-offloaded switch mode is failing to forward packets. Following fixes
> ensure smooth operation of switch mode in both offload and non-offload cases:
> 
> - Fix NULL dereference in icssg_enable_fw_offload() when second emac
>   slot is uninitialized during first port open
> - Set port_vlan on both emacs when bridge is formed; previously only
>   the second port was set, causing TX stalls in switch offload mode
> - Track UC/MC flooding state and restore it after firmware restart in
>   non-offload bridge mode; restart cleared IFF_PROMISC-driven flooding,
>   breaking unicast forwarding across bridge ports
> - Defer emac_adjust_link() to after prueth_emac_start() so R30 FORWARD
>   commands don't time out with PRU not running, leaving stale R30 values
>   that caused prueth_emac_restart() to fail in non-offload bridge mode

A bullet point list in the commit message suggests there should be a
patch series of patches, not one patch. You want small, obviously
correct patches with good commit messages.


    Andrew

---
pw-bot: cr

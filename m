Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C634752F;
	Wed, 19 Aug 2026 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144470; cv=none; b=mQFwc+yCxuhaE7wacQI0WUnHQIkdzT8AzbFUb/2zPMp+v/Lsvi469a+Ze4JLymazeBy69KzHX3zlUpWsLV6Htdq6ZHG2WnG15/J+pmzM9HCZ7CyVCMlgwqXX8dHFdPkTOWP1cRKKC1euWAUGNL8vBk+o6NPZ8SeJkJ0NBVaSwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144470; c=relaxed/simple;
	bh=5bzMf5JWfgzCfh4o8eDdr6USS8kzG3yNrjQJmBgcoYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twHANRR52ntsjdIAbMpEyg1Kipuhwm+Bs3+t3bBP7Xt6TtKN2+zRhbqcngB10vYyg+9FsoPCCjJbx+thhNgdekl+NB9yI969Ri3U5YJqOXvxjMMkXqvL9VA5iQP76wuof3oub0VYmFGAqawPtPr+CEw7Im75nQN3iE+qHsh56UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vu3WOyQU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vu3WOyQU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QEQ6PFGmDuvNbRNEG1Jwr41i80JcF+EHelcxz8o/Zb8=; b=vu3WOyQU7YUhsljdFnzei6HB5w
	n7hV67n4vh5NX/UGabUFSAjaqJId3yk8ptmnpBrJL2BDH1nZTlN5TLt64tztiL+LHq6D9Ih1KV+Ij
	WMXLUd579bZ6gUFDIv16pbuj7yQMraa9KC2gU8p+mmvmIb18kstP9LCu2rzBvpm7C4rY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwfu6-000bod-Rh; Wed, 19 Aug 2026 15:00:26 +0200
Date: Wed, 19 Aug 2026 15:00:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: platform: fix of_node leak when breaking RX
 queue loop
Message-ID: <6ca6be2d-548d-4110-9964-567bb8788e62@lunn.ch>
References: <20260819073258.467604-1-gonglinkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819073258.467604-1-gonglinkai@kylinos.cn>

On Wed, Aug 19, 2026 at 03:32:58PM +0800, Linkai Gong wrote:
> for_each_child_of_node() on the RX queues breaks once enough queues are
> parsed, which leaves the current child referenced. The TX loop then
> overwrites q_node, so that reference is never dropped.
> 
> of_node_put() the child before breaking. The TX loop already drops its
> last reference via the of_node_put(q_node) at the out label.
> 
> Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index dc5f951a311d..66a048ecadb0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -170,8 +170,11 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
>  
>  	/* Processing individual RX queue config */
>  	for_each_child_of_node(rx_node, q_node) {
> -		if (queue >= plat->rx_queues_to_use)
> +		if (queue >= plat->rx_queues_to_use) {
> +			of_node_put(q_node);
> +			q_node = NULL;
>  			break;
> +		}

Why not for_each_child_of_node_scoped()?

Also, does this bother anybody? I think this should be for net-next.

And while we are looking at this, what about:

https://elixir.bootlin.com/linux/v7.2/source/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c#L232

    Andrew

---
pw-bot: cr

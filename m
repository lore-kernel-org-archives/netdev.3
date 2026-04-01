Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9822364EB8;
	Wed,  1 Apr 2026 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012370; cv=none; b=gyNV6dUItcu7MQW7BmUM6st8lQljUFW47XljdpZeA3C9HL27a59HVEl4+Lh2F0X5KPp10EuXdtrlKU6f1dPtiSUsoEpWFsmu4ODoOeoMgLRmtltLh/3t353eIX1yGHds1rkb4a68sPo2MM0cKV8PTBK5yFZs5HJ8XEI2lh1C5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012370; c=relaxed/simple;
	bh=BGtOrxnlk6f59RvxLQ1mRseOThrers00WBWsCD6tbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJ57ymuy8Bo2YQ+MBoMu9zvwWYzN+FoQvoQwDzBI0uRXk9+i9oQyAMOoO/+Fsf+mALQO7VN2q+H2Viw/pnMAwjrEVIWD6YXlkzOaQusJPnxEwaNsHQ57nhnQFDPyxIjODIGgN5X3E9EaBefee6QL0zoTL6ZiBXuzHwF9pc3Ikx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejXd3Alk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejXd3Alk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C17BC19423;
	Wed,  1 Apr 2026 02:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775012369;
	bh=BGtOrxnlk6f59RvxLQ1mRseOThrers00WBWsCD6tbDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ejXd3AlkjyQFOWvztrRgWHqY/UPe86R9tWibU5sjEoiuQCymqVwOnESxxYPVptFqD
	 ThXvk7uvuC4ujZ0GITitI/+iZWCpcj++s7cmpooq2Ss+Q4ZKYK6Kxdx69dKKcNVhe/
	 YjqFAUrkyChYsqYNhFsR+7P91nxQu00+ckDA0jtk2v69WC5JfCHMWi5oiD8w06SrzM
	 aMvJvsiZ7xO6FkPyefRv5Qa18RhJJrTcaU/Aiz/ZbhcGgShtNyqOZBGOebd91MZxlT
	 BlNVA9JbFLP2PkK7jnIbn0j3rjHu0lBiKS4KfKpTSjESBJBpgc2SOV5nDMRq6NqEtB
	 9AEbFlhiX6mhA==
Date: Tue, 31 Mar 2026 19:59:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [RESEND PATCH net v3 2/2] net: stmmac: Prevent indefinite RX
 stall on buffer exhaustion
Message-ID: <20260331195927.3353cc6d@kernel.org>
In-Reply-To: <20260328192503.520689-3-CFSworks@gmail.com>
References: <20260328192503.520689-1-CFSworks@gmail.com>
	<20260328192503.520689-3-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Mar 2026 12:25:03 -0700 Sam Edwards wrote:
> @@ -5870,6 +5871,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  	priv->xstats.rx_dropped += rx_dropped;
>  	priv->xstats.rx_errors += rx_errors;
>  
> +	/* If stmmac_rx_refill() failed, keep trying until it doesn't. */
> +	if (unlikely(stmmac_rx_dirty(priv, queue) > 0))
> +		return budget;

If the system is OOMing having ksoftirq busy looping indefinitely is
not going to be very helpful. 1) only react if the fill level is below
some critical threshold, 2) try to add some delay (timer)? before the
retry
-- 
pw-bot: cr

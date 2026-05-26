Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9338BF61;
	Tue, 26 May 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810577; cv=none; b=GiY+XfSQqH0ZjwhmtakdDCQoIQOlP4sggJZKGp0AvV3vISXdYlc5uVOIO49M0dK4QALI6Q/P4kci6izzRVXEukvAWsAMv84ovWnK3zIwPhvkoqWNpzNAD4nkrTu3oS2TC4BhWbIx1vJFGlXf+f9gnEFoigVedLVuIbxvQMI6kT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810577; c=relaxed/simple;
	bh=bSz/62TfAqq/8gzYrk8R+TYG1iLmauSpvyJibARX5uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asgKkN7SMA+7qEEk/Xg8PIRhX9lCkkq7BsDXZSV4DBsScGSqo9rWDsaglAElQrV/aLK8r3qRBjjQsJ97J0/8iJI8BxpxjfhMkFO+aeBpe6ZGyu+/vDooH3PyGNmTu0zeHVGUfyYAVxPI7drdCjv/dKPK0nRZd78PatrTFDfEpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zJxgAVbC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zJxgAVbC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0gWncl3uxE+EJguZ8+TDtEb7FKZBeKXbaT+exSDCCSs=; b=zJxgAVbCiWSgUDS9eapMPwB/EJ
	Tvg7hkwts0A/FJiFOa5zaWhilHXL/Y+o2+uVplFVhKuAuSNbpgaFfPu+onjLpkwVfzz4rQmdO64UJ
	0Ui2Ta8T6HkpdpTtj0Ms3mpZGlViz7/oeP+/iK05+vWe53nPxa4ro3BgFPravptX5CAg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRu1z-004bYx-2E; Tue, 26 May 2026 17:49:23 +0200
Date: Tue, 26 May 2026 17:49:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: cedric.jehasse@luminex.be
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <4d270516-a8ae-4bed-b316-c28a321c304e@lunn.ch>
References: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>
 <20260526-net-next-mv88e6xxx-cbs-v2-2-13eb49c29b83@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-net-next-mv88e6xxx-cbs-v2-2-13eb49c29b83@luminex.be>

> +static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
> +				  struct tc_cbs_qopt_offload *cbs)
> +{
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	const struct mv88e6xxx_ops *ops = chip->info->ops;
> +	const struct mv88e6xxx_avb_ops *avb_ops;
> +	const struct mv88e6xxx_qav_info *qav;

Reverse Christmas tree. Longest first please.

> +	int rate_reg;
> +	int hilimit_reg;
> +	u8 queue_bit;
> +	u16 rate = 0;
> +	u16 hi_limit;
> +	int err;
> +
> +	avb_ops = ops->avb_ops;
> +	qav = chip->info->qav;

You might be able to move this into the variable declarations? But not
always, depending on reverse Christmas.

> +	if (!qav || !avb_ops || !avb_ops->port_qav_write ||
> +	    !ops->port_set_scheduling_mode)
> +		return -EOPNOTSUPP;
> +
> +	if (!dsa_is_user_port(ds, port))
> +		return -EOPNOTSUPP;
> +
> +	if (cbs->queue < 0 || cbs->queue >= chip->info->num_tx_queues)
> +		return -EINVAL;
> +
> +	if (!(qav->queue_mask & BIT(cbs->queue)))
> +		return -EOPNOTSUPP;
> +
> +	queue_bit = BIT(cbs->queue);
> +	rate_reg = cbs->queue * 2;
> +	hilimit_reg = rate_reg + 1;
> +
> +	if (cbs->enable) {
> +		if (cbs->idleslope <= 0 ||
> +		    cbs->idleslope > qav->max_rate ||
> +		    cbs->sendslope >= 0 || cbs->hicredit <= 0 ||
> +		    cbs->hicredit > qav->hi_limit_mask)
> +			return -ERANGE;
> +
> +		rate = DIV_ROUND_UP(cbs->idleslope, qav->rate_unit);

In the commit message, you mentioned 20Mbps, for a 1G link. Does the
link speed actually matter? I don't see it here.

	Andrew

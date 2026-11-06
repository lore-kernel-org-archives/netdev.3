Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971442;
	b=X9QFeF5+TvgqbRRxJKVX1kPtWPqO0Nr6cxAfMhcbD157OsiTLlWxtb91fw480UmLti69
	 Bh38AzvNzajAX9y/RK3g+xTK0mXzbwM1BtlUFm1kpJfx7Md8Qt066Dxuv17yYB5PUknGK
	 4327V+71P83IUU4G/yzT7FMnRpWLpyaE8QOiE7+CQg+1XQFzXktMB1H7vHeQc3qNv4w/g
	 aUPi/w8kYf3JoFLD9B8ePng7k9WjB9M96vsTwB2/IJ8aLpMpR506q5O2Jy7O2yaxjR8Q2
	 z3wHajsbNas7zrkPVI/55e/U2+GVmDcPP0OkyAu9oaWEmUQklxu+d1OOzvH8ehe9OPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971442;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=gP2F5F0yVTafi/WuKh7TU6wzhgxztJFok9GrzFpcGDI=;
	b=LYVJCqm8xXW+9SUC9n0mr0H1BqByArakABIxprLtOAtPMxcDjH9vMcEX/5DxOD6310XG
	 6o+3cYUVayMPCu4bK/UyuWYRdd2srp9nloZKEaXGIYSBrVv/Hi02sPowlzkDa0Qkp0eaY
	 bmaJwyj6LbbIBv39eINCvJ3v0RMxIKXAbOmVMExtdIw8Jrniov+PdM1OUPqMzt+s/kAxx
	 ax6DYLbktWxAIHPgO9AD1bw6cQiZSgB2rzLCMkk8Ne7/jPu8iV89CdB8hvt3ChaQJktlv
	 8sGdS8S63LHtEHXeO+H71f6Ppf5J3xYut7kOqMpD0/6K8JmAPIn9iQT41gQLmGaL1jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uwCBwtBX;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D531606A32E;
	Fri,  6 Nov 2026 13:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D531606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uwCBwtBX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gP2F5F0yVTafi/WuKh7TU6wzhgxztJFok9GrzFpcGDI=; b=uwCBwtBX+LvDjFOYVznRLqSRkd
	jdqyKDSuyhLvXHoO0LOUjSiYoEOdGG8AKluiwh1PnWBbt1QyZvI3QBPKVtj149jf50NbYMHV/1tak
	TNZHyCbIbW8/ZqQLprjpSiZN8sFd3K9Rr+Mz59reZzn1/Tu5MBkjllTehdiIfgUvBCGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPJv8-00Elyf-4t; Fri, 06 Nov 2026 14:23:54 +0100
Date: Fri, 6 Nov 2026 14:23:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: store the port ageing time before
 programming it
Message-ID: <719eb448-580a-413a-be49-253243533518@lunn.ch>
References: <20261104-ksz-stp-ageing-v1-0-2c2bc7217dea@pengutronix.de>
 <20261104-ksz-stp-ageing-v1-2-2c2bc7217dea@pengutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-ksz-stp-ageing-v1-2-2c2bc7217dea@pengutronix.de>

On Wed, Nov 04, 2026 at 12:48:29PM +0100, Oleksij Rempel wrote:
> dsa_switch_fastest_ageing_time() takes the minimum of the cached
> dp->ageing_time of all ports, but dsa_port_ageing_time() updates the
> cached value only after the notifier. Raising the ageing time programs
> the old, shorter value again, so after an STP topology change the switch
> stays at 2 x forward_delay.
> 
> Store the new value before the notifier and restore it on error. This
> affects all DSA drivers with .set_ageing_time: sja1105, which reloads
> its static config on a change, will reload again when the bridge
> restores the ageing time.
> 
> Reported in an automated review of the lan9645x bridge series (Link:
> below).
> 
> Tested on a KSZ9893.
> 
> Link: https://lore.kernel.org/netdev/179180428624.434549.14425623884223795761@kernel.org/
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  net/dsa/port.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 1f5536c0dffc2311db24015697e0c8f5c014ac74..3195d8b7c69c5e0fbc4007421218c2ff1db0ce47 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -876,18 +876,22 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock)
>  {
>  	unsigned long ageing_jiffies = clock_t_to_jiffies(ageing_clock);
>  	unsigned int ageing_time = jiffies_to_msecs(ageing_jiffies);
> +	unsigned int old_ageing_time = dp->ageing_time;
>  	struct dsa_notifier_ageing_time_info info;
>  	int err;
>  
>  	info.ageing_time = ageing_time;
>  
> +	/* dsa_switch_fastest_ageing_time() takes the minimum over the cached
> +	 * values of all ports, so update this port's value first.
> +	 */
> +	dp->ageing_time = ageing_time;
> +
>  	err = dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);

This appears to make the info.ageing_time parameter pointless?

Either remove it, or pass the port it is to be applied to, so the
correct switch wide ageing time can be calculated?

	Andrew

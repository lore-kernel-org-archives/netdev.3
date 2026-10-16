Received: from mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2FA34FF62
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117580; cv=none; b=MyaHxlyo0zuokc70JJZb+zhLDZmlzaNfC14wfeNO2OuuN/u2XSzNbMvOumZLMTEYqsHpeXN4B0tADIy1kzkvgIqAyY2mFhq2PgrsYgNjKAd1H3hsJfN8bM9JwMJUftd0h3+aFNOq0hEJSq4blT9OvunJ8DcFrB6mVYYON1Jpwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117580; c=relaxed/simple;
	bh=p/8kBvsSS2k2S8EzdgP+KsHevE7KMt9XbZgOH2zKfJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Arsa/VTmvA6FwvsmWt6AyLW+dk/8DOaOw7JMEFY4K5SLpRDFRaNHieb5f1bX4GNhuDiwRGMPbCIphlINxzrFJ45vwHlLqi3+m7YyX8IoN0UlcB+MGDNf1cY4sSFyerYrPD6m/6MwYtZvhjJKsZJetPznrTtbsLJqIpkilyUJqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uelk6toA; arc=none smtp.client-ip=95.215.58.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uelk6toA"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p/8kBvsSS2k2S8EzdgP+KsHevE7KMt9XbZgOH2zKfJM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792117576; v=1; x=1792722376;
 b=uelk6toAHW2/lenjl+EAC7YlptYFW7tAi4kj2rwb13mFR6oKHiBUgA0j5OHDTTJXotdtUNQv
 se76NugxQTfKr0CPxZla+nNmzBJ5u4SZb/BGzjOb3vCK2/aA3hs91L8YttDELUmRw+KrRFX/FwL
 fx5YYq0zZbUmvLbFOncr79/o=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 474495bdc47a0253;
	Fri, 16 Oct 2026 02:26:16 +0000
X-Mizu-Trace-ID: 474495bdc47a0253
X-Migadu-Flow: FLOW_OUT
Date: Fri, 16 Oct 2026 10:26:05 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH net v4] team: reject CAN, IEEE 802.15.4 and 6LoWPAN
 devices in team_port_add
Message-ID: <atGLPSTSfWiR90c8@fedora>
References: <20261014143309.284388-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014143309.284388-1-socketcan@hartkopp.net>

On Wed, Oct 14, 2026 at 04:33:09PM +0200, Oliver Hartkopp wrote:
> From: Jiale Yao <yaojiale02@163.com>
> 
> When the first port has a non-Ethernet type, team_setup_by_port()
> copies port_dev->type to the team device while netdev_priv() of the
> team device still holds a struct team. Several L2 stacks identify their
> devices by dev->type alone and then access type specific data that the
> team driver never sets up:
> 
> - CAN protocols rely on the CAN mid-layer private data (ml_priv)
> - IEEE 802.15.4 code dereferences ieee802154_ptr and the mlme ops in
>   ml_priv
> - the 6LoWPAN netdev notifier writes through lowpan_dev(dev) on
>   NETDEV_DOWN and reads it on NETDEV_UP/NETDEV_CHANGE
> 
> Enslaving such a device (e.g. vxcan, wpan0, lowpan0) therefore leads to
> NULL pointer dereferences or to writes into struct team.
> 
> Reject ARPHRD_CAN, ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR and
> ARPHRD_6LOWPAN devices in team_port_add(). The bonding driver has
> rejected CAN devices since commit 8ba68464e478 ("bonding: refuse to
> enslave CAN devices").
> 
> Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Assisted-by: Claude:deepseek-v4-pro
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
> v4: [Hartkopp] also reject ARPHRD_6LOWPAN as reported by Sashiko AI
>     review, reworded commit message (bonding only rejects CAN)
> v3: [Hartkopp] fixed indention and compilation as reported by kernel test robot
> ---
>  drivers/net/team/team_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1223,10 +1223,21 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  		netdev_err(dev, "Device %s is loopback device. Loopback devices can't be added as a team port\n",
>  			   portname);
>  		return -EINVAL;
>  	}
> 
> +	if (port_dev->type == ARPHRD_CAN ||
> +	    port_dev->type == ARPHRD_IEEE802154 ||
> +	    port_dev->type == ARPHRD_IEEE802154_MONITOR ||
> +	    port_dev->type == ARPHRD_6LOWPAN) {
> +		NL_SET_ERR_MSG(extack,
> +			       "CAN, IEEE 802.15.4 and 6LoWPAN devices can't be added as a team port");
> +		netdev_err(dev, "Device %s is CAN, IEEE 802.15.4 or 6LoWPAN. These device types can't be added as a team port\n",
> +			   portname);
> +		return -EINVAL;
> +	}
> +
>  	if (netif_is_team_port(port_dev)) {
>  		NL_SET_ERR_MSG(extack, "Device is already a port of a team device");
>  		netdev_err(dev, "Device %s is already a port "
>  				"of a team device\n", portname);
>  		return -EBUSY;
> --
> 2.53.0
> 

Thanks for the followup.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

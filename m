Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8493043DE
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196259; cv=none; b=T+1hduc8+1ffdTpPtIQbHOyZ/Xz/2hP3NmUOH60FYFEmBwLwlzYM/TSjA5jOxY0gAe/jtss3hm7y1ise3f7xKAjRgJD43eM6FMFsCAnZ/G9KX0PvedW+w0EOgt35/Z/B6ZqALgHR6TEIx8A534r/sdqh/UNTLC/GA3CEzPYTxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196259; c=relaxed/simple;
	bh=j6hlkS0rM4QGBcUgq3GXLQa+ydoVye/q5qMSO+LGhJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgDOmKKJX2BnLR5dYCSJ30xyFq08rQF6Im4+fkHaHKVcumA9ZhEqP269DWTdZPGA4c2r6Q6YIIiPSpXWPe17mGx0Q+xPyicREyfP2TVGxQjtm7Xy+sTLFSHVs42l792BGyIAnuT7V033OjW90CUgxxhlcP0A51iphd954A66x44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=brbMIexj; arc=none smtp.client-ip=95.215.58.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="brbMIexj"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j6hlkS0rM4QGBcUgq3GXLQa+ydoVye/q5qMSO+LGhJY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787196254; v=1; x=1787801054;
 b=brbMIexjOhzqiRld+zA2ruAim9airVU0mRXzV3p9QAkAz8vw6s87yqhhcWAsnEUX/MON88Xm
 KHQVgMvHmv1hHWAsFKbvMOTV3+XLzOnHmMYpVxBV69CZ9EEjENTPpO7YSqnucOPakgSGOPT9yfE
 z75nr5DpmQ1jY0bENduMRWxs=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.240)
	by smtp.migadu.com with ESMTPS id 34bdee19e91da8de;
	Thu, 20 Aug 2026 03:24:14 +0000
X-Mizu-Trace-ID: 34bdee19e91da8de
X-Migadu-Flow: FLOW_OUT
Date: Thu, 20 Aug 2026 11:23:59 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jiale Yao <yaojiale02@163.com>, Jiri Pirko <jiri@resnulli.us>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
Message-ID: <aoZzT1WoDGHpyvps@fedora>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net>
 <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net>
 <aoVzaHfKWG-_OJOY@fedora>
 <15ea29f5-7154-4bf9-baff-88f4b6477722@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ea29f5-7154-4bf9-baff-88f4b6477722@hartkopp.net>

On Wed, Aug 19, 2026 at 08:15:42PM +0200, Oliver Hartkopp wrote:
> Hi Hangbin, all,
> 
> thanks for your feedback!
> 
> In fact checking for dev->ml_priv != NULL seems to be too hard and would
> likely create some breaking setups.
> 
> I have sent a patch on the Linux-CAN ML that makes the CAN subsystem robust
> against alien ARPHRD_CAN interfaces that might be created by TUN/TAP via
> TUNSETLINK ioctl:
> 
> https://lore.kernel.org/linux-can/20260819160822.8256-1-socketcan@hartkopp.net/
> 
> The other question remains how to make bonding/team keep the fingers away
> from incompatible net devices.
> 
> The current black listing approach from Jiale Yao (using a unified helper as
> suggested by Jiri Pirko) seems to be the best way to go now:
> 
> https://lore.kernel.org/netdev/20260728151240.89434-1-yaojiale02@163.com/
> 
> +		if (port_dev->type == ARPHRD_CAN ||
> +		    port_dev->type == ARPHRD_IEEE802154 ||
> +		    port_dev->type == ARPHRD_IEEE802154_MONITOR) {
> +			NL_SET_ERR_MSG(extack,
> +				       "CAN and IEEE 802.15.4 devices can't be added as a team port");
> +			netdev_err(dev, "Device %s is CAN or IEEE 802.15.4. These device types
> can't be added as a team port\n",
> +				   portname);
> +			return -EINVAL;
> +		}
> +	}
> +

This looks good to me to avoid making the checking to wide.

> 
> There might be other dev->types (e.g. ARPHRD_ARCNET) or a future white list
> approach this unified helper could support. For either team and bonding!
> 
> @Jiale Yao: What would be a good name for such helper in
> include/linux/if_arp.h ?
> 
> dev_is_not_ether_compatible(const struct net_device *dev)
> dev_is_ether_compatible(const struct net_device *dev)
> dev_has_special_l2_proto(const struct net_device *dev)
> dev_has_l2_proto(const struct net_device *dev)
> dev_is_pure_packet_bus(const struct net_device *dev)
> 
> or something like this?

I'm not good at naming. Leave it to you.

Thanks for your works!

Hangbin

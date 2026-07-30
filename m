Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827A3C3F41;
	Thu, 30 Jul 2026 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445741; cv=none; b=KsqeTbyzguZnBwfyZ1ljUfgC0TgyYQBMxMqt4o+usyS2lT53vTjHBJLfFnWOBCps6AUK95jqcLUq6xNKpUVi1IysYbqL2aWSIReBwpopQe8akjfQadvHhxks8mkMrpLz7iRZ7ktIdSFod84dRaD8tsbfhRCGzDmMBbfTKpqD53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445741; c=relaxed/simple;
	bh=hu72HLHkW0QtrtmQfhhETdCsyEPFR+dcUSO1zyJPp4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTmveV8WmCX2LSIpgxuSoMSrnqjBEjq41mgsEFOGARD78wSpsJIMQhQnsAEPovOYh7qkNxNoU2GnIwaUDMoLGlyDJCkyNvIxr3SNd5tyKUMOifYSt6cZhF2pML0c7j2yn5yEs1u0oge19YNEZpgjwMWdXdWMf4eEiO7CsMGuq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K6Bi9LeK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K6Bi9LeK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NlWYhV/LV0zZ377ecxym7XP7Hw0qOnAffPB8uprMTIQ=; b=K6Bi9LeK6xA7As8pmEJ8Wjb32r
	xOXKT4ulFzvFzaGBnl14M1JuGdlpO+MbhfWXqAUSoaO1d+LexiyTqr+AmOmQe2Varshn1o4FRHee8
	4o5OFgN1qcly8gHteMvJhDEqj4/ekdLSptOWZ7kOvFDLRW66CBXwH4v/rqWxcl/8a8Gc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpXzX-00F3ys-NJ; Thu, 30 Jul 2026 23:08:35 +0200
Date: Thu, 30 Jul 2026 23:08:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/5] net: dsa: wire flash_update devlink
 callback to drivers
Message-ID: <a35bf784-a5c5-4a6b-be43-4d7a2e0dc663@lunn.ch>
References: <cover.1784945329.git.daniel@makrotopia.org>
 <f1a39d3d955be3da51b333959ecfe626b8d6dfc6.1784945329.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a39d3d955be3da51b333959ecfe626b8d6dfc6.1784945329.git.daniel@makrotopia.org>

On Sat, Jul 25, 2026 at 03:15:35AM +0100, Daniel Golle wrote:
> Add a devlink_flash_update callback to dsa_switch_ops so that DSA
> drivers can support devlink dev flash without open-coding the devlink
> plumbing. Unlike the other trampolines in net/dsa/devlink.c, the
> flash_update op is only installed for switches whose driver implements
> the callback: the devlink core rejects flash requests up front when the
> op is absent, before fetching the firmware file from userspace, and an
> unconditionally present trampoline would defeat that early check and
> let unsupported requests block on request_firmware() only to fail with
> -EOPNOTSUPP afterwards.

> +/* The devlink core rejects flash requests up front when the flash_update
> + * op is absent, before fetching the firmware file from userspace. Only
> + * install the op for switches whose driver implements it, so that
> + * unsupported requests keep failing early.
> + */
> +#define DSA_DEVLINK_OPS							\
> +	.info_get			= dsa_devlink_info_get,		\
> +	.sb_pool_get			= dsa_devlink_sb_pool_get,	\
> +	.sb_pool_set			= dsa_devlink_sb_pool_set,	\
> +	.sb_port_pool_get		= dsa_devlink_sb_port_pool_get,	\
> +	.sb_port_pool_set		= dsa_devlink_sb_port_pool_set,	\
> +	.sb_tc_pool_bind_get		= dsa_devlink_sb_tc_pool_bind_get, \
> +	.sb_tc_pool_bind_set		= dsa_devlink_sb_tc_pool_bind_set, \
> +	.sb_occ_snapshot		= dsa_devlink_sb_occ_snapshot,	\
> +	.sb_occ_max_clear		= dsa_devlink_sb_occ_max_clear,	\
> +	.sb_occ_port_pool_get		= dsa_devlink_sb_occ_port_pool_get, \
>  	.sb_occ_tc_port_bind_get	= dsa_devlink_sb_occ_tc_port_bind_get,
> +
> +static const struct devlink_ops dsa_devlink_ops = {
> +	DSA_DEVLINK_OPS
> +};

Is this going to scale? How many different permutations are there?

Firmware upgrade is an infrequent operation, so do we actually care
about a request_firmware() which might turn out to be pointless? I
personally would prefer to avoid the scalability issue and just return
-EOPNOTSUPP.

	Andrew

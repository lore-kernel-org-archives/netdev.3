Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074273;
	b=aaw2JA0son/gjaAlbs73uJ8k4xL3bzPuopZV8Az2WLw37zt7sG1zSKmkojsZq6jzo8US
	 nTG+OoD1qiot66C37r6DbrFAdkh9xhWQohiLAEBo5MtSQmO4L6W/1BRvFkcvO6HSIsc2T
	 HIg39ehDzaYKT0vkOmoiMXgMT7KqwN7ZxAJg6mwxnnYkS+7OlrjTYg5G6D6lxw429cIRZ
	 CQowY8W9guTmFd13b96b07WDSQfadOT1KuLtDsSd9oAKYELQWe3UiZe9VytRlLzNkoXu3
	 V58c5OJ8XnUO0QJNPAjgujHXlASkaVPV7Raj19HM/TLXaK7xQL+LUriOiVmMzXk7t5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074273;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=jZbkHHYtwIbgU4wy/4KVFGSe2PVc8UG7tdfmC7f5SfE=;
	b=pKA1jjhK50lUFgdiIWKarmuFToT8e1HfAirUHaZC+1Mt2csQy/rXS5UC5g9gD9ziwkXR
	 HAewpDJA2txlgfpeLjGVLJ0kHMqK26K86klY/tF1GqPh+3sHYzxBc22/C/aYw+WFWmSNK
	 LhZv5zeEtQDLYgk5S8lxVUmIJfLVGjOIirOVHkNA88/EH3m8FvCkWS9cq8svFrt/iQ6oz
	 h+16hPrYapKKBfQQbXOho61sZxncqGjNPbdAcZoRon7JS/HzTRCLs9f4TMw5M2VybTjJi
	 6DOn2ZpnjOE9kluPSXM0jPrZScTCgt5CuDzkyETUQ9y058bUNoxaqp1QKDuxqI/yN/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ibONHJDp;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6413606A32C;
	Sat,  7 Nov 2026 17:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6413606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ibONHJDp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jZbkHHYtwIbgU4wy/4KVFGSe2PVc8UG7tdfmC7f5SfE=; b=ibONHJDpu+L/WZgSrOL3LszIp0
	RRIJ0nBhxH6r6eY6ZJG39oH3frNHO7hpb4hBKvNyc9M2RSDWUenzZdKK835lcj1InI9VTjaPoVAo8
	Y3pCNgYkDQBFXuTXA6ogEp0Kcv8oUBgwMoGz4rPJf+sagqeitOVioOJIb0Mjcvq3hrVE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPkfh-00EzJ8-BZ; Sat, 07 Nov 2026 18:57:45 +0100
Date: Sat, 7 Nov 2026 18:57:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next 2/5] net: rnpgbe: Report link settings through
 ethtool
Message-ID: <228e8fd8-4f1d-40d7-aca6-fc8a304b9906@lunn.ch>
References: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
 <BB3F0BAB3B9947AF+20261106112522.43965-1-dong100@mucse.com>
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
In-Reply-To: <BB3F0BAB3B9947AF+20261106112522.43965-1-dong100@mucse.com>

> These devices support autonegotiation only on TP ports. Configure TP
> ports with autonegotiation enabled and fibre and backplane ports with
> fixed 1 Gb/s full duplex.
>  int rnpgbe_setup_default_link(struct mucse_hw *hw)
>  {
> -	return mucse_mbx_set_link(hw, RNPGBE_DEFAULT_ADV, true, 0, 0,
> -				  ETH_TP_MDI_AUTO);
> +	u32 advertising = hw->link_config.supported & RNPGBE_DEFAULT_ADV;
> +	bool autoneg = hw->link_config.status & MUCSE_LINK_TP;
> +	u8 duplex = DUPLEX_UNKNOWN;
> +	u32 speed = SPEED_UNKNOWN;
> +	int err;
> +
> +	if (!autoneg) {
> +		advertising &= RNPGBE_FW_ADV_1000_FULL;
> +		speed = SPEED_1000;
> +		duplex = DUPLEX_FULL;
> +	}
> +
> +	err = mucse_mbx_set_link(hw, advertising, autoneg,
> +				 autoneg ? 0 : speed, autoneg ? 0 : duplex,
> +				 ETH_TP_MDI_AUTO);

This looks odd. If autoneg is off, you expect user space to indicate
how the MAC should be configured. 10, 100, 1G, full or half.

> +static int rnpgbe_get_link_ksettings(struct net_device *netdev,
> +				     struct ethtool_link_ksettings *cmd)
> +{
> +	struct mucse *mucse = netdev_priv(netdev);
> +	struct mucse_hw *hw = &mucse->hw;
> +	u32 supported, advertising;
> +	unsigned long flags;
> +	u16 status;
> +	int mode;
> +
> +	status = hw->link_config.status;
> +	supported = hw->link_config.supported;
> +	advertising = hw->link_config.advertising;
> +	ethtool_link_ksettings_zero_link_mode(cmd, supported);
> +	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
> +	ethtool_link_ksettings_zero_link_mode(cmd, lp_advertising);

Do you have access to the LP advertisement value? It is useful for debugging.

> +	} else {
> +		if (status & MUCSE_LINK_BACKPLANE) {
> +			mode = ETHTOOL_LINK_MODE_1000baseKX_Full_BIT;
> +			ethtool_link_ksettings_add_link_mode(cmd, supported,
> +							     Backplane);
> +			ethtool_link_ksettings_add_link_mode(cmd, advertising,
> +							     Backplane);

Does it actually advertise Backplane?


> +			cmd->base.port = PORT_NONE;
> +		} else {
> +			mode = ETHTOOL_LINK_MODE_1000baseX_Full_BIT;
> +			ethtool_link_ksettings_add_link_mode(cmd, supported,
> +							     FIBRE);
> +			ethtool_link_ksettings_add_link_mode(cmd, advertising,
> +							     FIBRE);

Again, does it advertise fibre? What happens if the LP wants to do TP?

You probably want to look at phylib, it figure out the correct way to
to implement ksetting set/get.


    Andrew

---
pw-bot: cr

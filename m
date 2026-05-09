Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06B2F8E8D;
	Sat,  9 May 2026 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291179; cv=none; b=A3437LIZgS99MdWtd13qG0+8XmgrcIyzqtbF1C45RbFirhGIyfQrKB6ziCETbGmPjwBYyWfL1OEOm5rVTlBO7VcGNqZAlSfXYpciEK6t9tVmZCi/MN4+idXjP6AJXkbPI2z/ZReCpiSAw55TkxojZr626BLDhp1y/Ysh2KH2sAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291179; c=relaxed/simple;
	bh=iGaG0hbnBggkXGo2+ZH9xqq0NqNOcHcRTvyvOIt57KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9NsqpD9HTGYemPrjt4IAeVBDsPyUX7Eqhq3gqV947VTKRFMSnawo/Qma+YtNeROaRk5mwUR0VLCZ/Wtm69HJXofHyshyApIxY+oA++/GxMosa0ySIsWEUVbrbJgK3bqmIw7A/fVwvdInDycnJjYxKoeH9xoAzAzdYpJerM/Jj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxwZ31Gn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxwZ31Gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62948C2BCB0;
	Sat,  9 May 2026 01:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291179;
	bh=iGaG0hbnBggkXGo2+ZH9xqq0NqNOcHcRTvyvOIt57KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxwZ31Gn80QTNO5KvQSyIowUIEW715f7W3UyjCiV5yE7p+CyiOwdQ2GpW0wJrI0/h
	 rxQg/D7TbOHiEbNOC6Qu0H3d/ZDacNYxEJgSIjR0QXya9BOdMq1WfUaI/53GVaxZLi
	 UWHJFIo2FBZ04wDNf54HPaN+sWVHWomdt0i+RVpoq6dQueC0+O7Yz+IITB0f1HGM4j
	 7RWqR1ptf0Y5T5oH2G9fDS9JVxt7mkZT8Kv6CxrXWoObvvrp51M8Jnb1KRg/LXU5/I
	 7o4mPYK5b9pObYWUenYIsPRdMgoU6kQmiKU5yMQ6XagTCItgM5c8AOlCpJ6xw+OLBv
	 Siq0QgLHUUYEw==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 10/10] net: airoha: Support multiple LAN/WAN interfaces for hw MAC address configuration
Date: Fri,  8 May 2026 18:46:17 -0700
Message-ID: <20260509014617.3558185-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-10-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-10-af613b61ae02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: airoha: Support multiple LAN/WAN interfaces for hw MAC address configuration

This patch extends airoha_set_macaddr() to derive REG_FE_MAC_LMIN and
REG_FE_MAC_LMAX by iterating over all sibling LAN/WAN net_devices, and
rejects addresses whose upper 3 bytes do not match the already-registered
peers. airoha_dev_set_macaddr() is also changed to split eth_mac_addr()
into eth_prepare_mac_addr_change() and eth_commit_mac_addr_change() around
the hardware programming step.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 8617dd4f7932..fbfefd0ec355 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -71,20 +71,67 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
>  	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
>  }
>  
> -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
> +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
>  {
>  	struct airoha_eth *eth = dev->eth;
> -	u32 val, reg;
> +	u8 ref_addr[ETH_ALEN] = {};
> +	u32 reg, val, lmin, lmax;
> +	int i;
> +
> +	lmin = (addr[3] << 16) | (addr[4] << 8) | addr[5];
> +	lmax = lmin;
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		struct airoha_gdm_port *port = eth->ports[i];
> +		int j;
> +
> +		if (!port)
> +			continue;
> +
> +		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *iter_dev;
> +			struct net_device *netdev;
> +
> +			iter_dev = port->devs[j];
> +			if (!iter_dev || iter_dev == dev)
> +				continue;
> +
> +			if (airoha_is_lan_gdm_dev(iter_dev) !=
> +			    airoha_is_lan_gdm_dev(dev))
> +				continue;
> +
> +			netdev = iter_dev->dev;
> +			if (netdev->reg_state != NETREG_REGISTERED)
> +				continue;
> +
> +			ether_addr_copy(ref_addr, netdev->dev_addr);
> +			val = (netdev->dev_addr[3] << 16) |
> +			      (netdev->dev_addr[4] << 8) | netdev->dev_addr[5];
> +			if (val < lmin)
> +				lmin = val;
> +			if (val > lmax)
> +				lmax = val;
> +		}
> +	}
> +
> +	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
> +		/* According to the HW design, hw mac address MS bits
> +		 * must be the same for each net_device with the same
> +		 * LAN/WAN configuration.
> +		 */
> +		return -EINVAL;
> +	}

[Medium]
The NETREG_REGISTERED filter here means the check only sees peers that
have already completed register_netdev(). airoha_dev_init() is invoked
as ndo_init from register_netdev() before dev->reg_state transitions
to NETREG_REGISTERED, so the constraint is only enforced across
already-registered siblings.

When the device tree does not supply a mac-address property,
airoha_alloc_gdm_device() falls back to eth_hw_addr_random() and each
sibling gets an independently generated random MAC. With two or more
LAN (or two or more WAN) net_devices going through this fallback, the
second and later siblings' upper 3 bytes will almost always differ
from the first, so airoha_set_macaddr() returns -EINVAL:

	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3))
		return -EINVAL;

airoha_dev_init() now propagates that error, which fails
register_netdev() and airoha_register_gdm_devices(), aborting probe.

Before this patch the same configuration still came up (with the single
REG_FE_{LAN,WAN}_MAC_H being last-writer-wins). Should the random
fallback path derive sibling MACs from a shared base, or should the
upper-3-bytes constraint only be enforced for user-triggered
ndo_set_mac_address rather than for init-time programming?

>  
>  	reg = airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H : REG_FE_WAN_MAC_H;
>  	val = (addr[0] << 16) | (addr[1] << 8) | addr[2];
>  	airoha_fe_wr(eth, reg, val);
>  
> -	val = (addr[3] << 16) | (addr[4] << 8) | addr[5];
> -	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
> -	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
> +	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), lmin);
> +	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), lmax);
>  
>  	airoha_ppe_init_upd_mem(dev);
> +
> +	return 0;
>  }
>  
>  static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
> @@ -1792,13 +1839,18 @@ static int airoha_dev_stop(struct net_device *netdev)
>  static int airoha_dev_set_macaddr(struct net_device *netdev, void *p)
>  {
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +	struct sockaddr *addr = p;
>  	int err;
>  
> -	err = eth_mac_addr(netdev, p);
> +	err = eth_prepare_mac_addr_change(netdev, p);
>  	if (err)
>  		return err;
>  
> -	airoha_set_macaddr(dev, netdev->dev_addr);
> +	err = airoha_set_macaddr(dev, addr->sa_data);
> +	if (err)
> +		return err;
> +
> +	eth_commit_mac_addr_change(netdev, p);
>  
>  	return 0;
>  }

[High]
After this reordering, does airoha_ppe_init_upd_mem() end up
programming the PPE update memory with the old MAC rather than the new
one?

eth_prepare_mac_addr_change() only validates the sockaddr and does not
touch netdev->dev_addr; the actual write to netdev->dev_addr happens in
eth_commit_mac_addr_change() via eth_hw_addr_set():

net/ethernet/eth.c:eth_prepare_mac_addr_change() {
	if (!(dev->priv_flags & IFF_LIVE_ADDR_CHANGE) && netif_running(dev))
		return -EBUSY;
	if (!is_valid_ether_addr(addr->sa_data))
		return -EADDRNOTAVAIL;
	return 0;
}

net/ethernet/eth.c:eth_commit_mac_addr_change() {
	eth_hw_addr_set(dev, addr->sa_data);
}

airoha_set_macaddr() is invoked between those two, so when it reaches
airoha_ppe_init_upd_mem(dev) the commit has not yet run. That helper
reads netdev->dev_addr directly rather than using the addr argument:

drivers/net/ethernet/airoha/airoha_ppe.c:airoha_ppe_init_upd_mem() {
	const u8 *addr = netdev->dev_addr;
	...
	val = (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];
	airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
	...
	val = (addr[0] << 8) | addr[1];
	airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
	...
}

So the FE registers REG_FE_{LAN,WAN}_MAC_H / REG_FE_MAC_LMIN /
REG_FE_MAC_LMAX are written from the new addr parameter, but the PPE
REG_UPDMEM_DATA/REG_UPDMEM_CTRL entries are written from the still-old
netdev->dev_addr.

Previously eth_mac_addr() (prepare + commit combined) ran first, so
netdev->dev_addr was the new MAC by the time airoha_set_macaddr() and
airoha_ppe_init_upd_mem() ran, keeping the two blocks in sync.

Would it be cleaner to either pass addr through to
airoha_ppe_init_upd_mem(), or invoke eth_commit_mac_addr_change() before
airoha_set_macaddr() (with a rollback path if the hardware programming
fails)?

> @@ -1903,6 +1955,7 @@ static int airoha_dev_init(struct net_device *netdev)
[ ... ]

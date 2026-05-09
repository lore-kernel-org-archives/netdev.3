Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0831917CD;
	Sat,  9 May 2026 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291177; cv=none; b=eAhzNs5CJqeZDMYWyBYyehwQoHia3xz+FIaG+J8emgPAFwtIG5zZENP7m3Gsy/T/+P2cbFrFOYJp8vQth5qyUuYpCclTkWCNR6GTTrpzRtP/WYVwb6Yi1Gnr1e6uP/iSMw9SAWbyrM2XFIHtAtm4LeZWXvrUcF03XN+pmtr1o8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291177; c=relaxed/simple;
	bh=EVpS+D5l4uaBpd3aqAD7zLlOvMu0NW0P58tfE3k9TC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEEgBHE3G94BgKXNE9JYUuSx67GzSHqID+0ZYEqYqQHTXEsT4IwxqVGTysz7qFJ/GC3ihXulD9Gu8DpFdcAGIMuGrDbeTkovml1g/QPjnf9pQpD0bbBsEXzKnqu1DhxRUJPjxY1l926i/Ew0/entuLO4S5l9FIjBC0CEk0hFg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJJgXfPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJJgXfPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675A2C2BCB0;
	Sat,  9 May 2026 01:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291177;
	bh=EVpS+D5l4uaBpd3aqAD7zLlOvMu0NW0P58tfE3k9TC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJJgXfPJj55SCswGnSWPnjWDEr8+pn30ZDMP3Zxhd5XSiJTKaYib/X+RO8gHn2poL
	 FYyIutfbLp9CqWG/OindW3AREvrTwqB5chULip5ialgic8e7TAZnrr5qLPnNDyu5XJ
	 bEAn54yfHbPtEgwtipGig2WoW7KfbuKdtJseQgxCYIcXO7I5vQleG/b45kg1WCl5sj
	 TWg+0NbxfTAh6MN2MI0VPKUFuHw5BiG8OYfavv3/f635iLkASAGSNAJPUHCnXLZWxk
	 /L1bMdlR7KU9Wf50G7hG+d2wQt3UlcXwOPZeEJo3cSNxdPR3AD4GhGU+TjV6qqr6Rv
	 CtqMSI5vTbArw==
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
Subject: Re: [PATCH net-next v4 09/10] net: airoha: Introduce WAN device flag
Date: Fri,  8 May 2026 18:46:15 -0700
Message-ID: <20260509014615.3558164-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-9-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-9-af613b61ae02@kernel.org>
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
net: airoha: Introduce WAN device flag

This commit replaces the port->id == 1 LAN/WAN test with a per-dev
PRIV_FLAG_WAN bit that is set during airoha_dev_init() based on the
port id and the presence of other WAN devices. It also extracts the
QDMA selection/PPE cpu port programming into a new helper and reworks
the GDM2 loopback path to key off the new flag.

A few questions about the new policy and error paths.

[Medium]
The commit message says:

    Introduce WAN flag to specify if a given device is used to
    transmit/receive WAN or LAN traffic. [...] Please note it is possible
    to specify multiple LAN devices but just a single WAN one.

Under the old helper (port->id == 1), GDM2/GDM3/GDM4 were all treated as
WAN. Under the new logic, when GDM2 (eth->ports[1]) is present, the
GDM3/GDM4 case breaks out of the switch without setting PRIV_FLAG_WAN, so
GDM3 and GDM4 are now classified as LAN. That flips the MAC register
(REG_FE_WAN_MAC_H -> REG_FE_LAN_MAC_H in airoha_set_macaddr()), the QDMA
binding (qdma[1] -> qdma[0] in airoha_dev_set_qdma()), and the PPE cpu
port (CDM2 -> CDM1). Is that role change intentional, and could the
commit message call it out so bisecting a board that relied on the old
GDM3/GDM4=WAN semantics is easier?

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 1c4927c1aeb0..8617dd4f7932 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1863,36 +1863,77 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
>  	return 0;
>  }
>  
> -static int airoha_dev_init(struct net_device *netdev)
> +static struct airoha_gdm_dev *
> +airoha_get_wan_gdm_dev(struct airoha_eth *eth)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		struct airoha_gdm_port *port = eth->ports[i];
> +		int j;
> +
> +		if (!port)
> +			continue;
> +
> +		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *dev = port->devs[j];
> +
> +			if (dev && !airoha_is_lan_gdm_dev(dev))
> +				return dev;
> +		}
> +	}
> +
> +	return NULL;
> +}

[High]
airoha_register_gdm_devices() invokes airoha_dev_init() for each dev in
port->devs[] sequentially. On EN7581 GDM3 supports two devs (nbq 4/5 for
PCIE0/PCIE1 in airoha_alloc_gdm_device()). When both devs are registered,
devs[0] sets PRIV_FLAG_WAN and then devs[1] sees the first via
airoha_get_wan_gdm_dev() and falls through to LAN. Is that the intended
result for two devs on the same physical GDM3/GDM4 port?

The two devs then diverge:

  airoha_dev_set_qdma()
    dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];

so devs[1] binds to qdma[0] while devs[0] is on qdma[1];

  airoha_set_macaddr()
    reg = airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H
                                     : REG_FE_WAN_MAC_H;

so devs[1] writes into the LAN MAC range that belongs to GDM1; and in
airoha_ppe_foe_entry_prepare() pse_port becomes port->id instead of 2
(GDM2 loopback) only for devs[1]. Is there an assumption that sibling
devs on the same port must share the WAN/LAN classification?

> +
> +static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
>  {
> -	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> -	struct airoha_gdm_port *port = dev->port;
>  	struct airoha_eth *eth = dev->eth;
>  	int i;
>  
>  	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
>  	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
>  	dev->dev->irq = dev->qdma->irq_banks[0].irq;
> -	airoha_set_macaddr(dev, netdev->dev_addr);
> +
> +	for (i = 0; i < eth->soc->num_ppe; i++)
> +		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
> +}
> +
> +static int airoha_dev_init(struct net_device *netdev)
> +{
> +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +	struct airoha_gdm_port *port = dev->port;
>  
>  	switch (port->id) {
>  	case AIROHA_GDM3_IDX:
> -	case AIROHA_GDM4_IDX:
> -		/* If GDM2 is active we can't enable loopback */
> -		if (!eth->ports[1]) {
> -			int err;
> +	case AIROHA_GDM4_IDX: {
> +		struct airoha_eth *eth = dev->eth;
>  
> -			err = airoha_set_gdm2_loopback(dev);
> -			if (err)
> -				return err;
> -		}
> +		if (eth->ports[1] || airoha_get_wan_gdm_dev(eth))
> +			break;

[Medium]
Is the eth->ports[1] check equivalent to asking whether a GDM2 dev
actually exists? airoha_alloc_gdm_port() assigns eth->ports[p] before
iterating the "airoha,eth-port" child nodes, so with all GDM2 child nodes
marked status="disabled" and GDM3 or GDM4 enabled, eth->ports[1] is
non-NULL but port->devs[] is empty. In that case this branch still breaks
out of the switch and the uplink GDM3/GDM4 dev ends up LAN. Would checking
for an actual dev under eth->ports[1] be safer than checking the port
pointer alone?

[Medium, Low]
The policy that "just a single WAN one" is allowed is enforced by silently
breaking here when airoha_get_wan_gdm_dev() returns non-NULL. Would a
netdev_warn() or -EINVAL help an administrator notice that a second WAN
candidate was demoted to LAN? Also, with both GDM3 and GDM4 enabled and
GDM2 absent, the winner of PRIV_FLAG_WAN depends on eth->ports[] iteration
order and the port/dev allocation order; is there a deterministic,
documented way to choose which dev becomes WAN (DT property, for example)?

> +		fallthrough;
> +	}
> +	case AIROHA_GDM2_IDX:
> +		/* GDM2 is always used as wan */
> +		dev->flags |= PRIV_FLAG_WAN;
>  		break;
>  	default:
>  		break;
>  	}
>  
> -	for (i = 0; i < eth->soc->num_ppe; i++)
> -		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
> +	airoha_dev_set_qdma(dev);
> +	airoha_set_macaddr(dev, netdev->dev_addr);
> +
> +	if (!airoha_is_lan_gdm_dev(dev) &&
> +	    (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)) {
> +		int err;
> +
> +		err = airoha_set_gdm2_loopback(dev);
> +		if (err) {
> +			dev->flags &= ~PRIV_FLAG_WAN;
> +			return err;
> +		}
> +	}

[Medium]
On the error path, is clearing PRIV_FLAG_WAN sufficient? By the time
airoha_set_gdm2_loopback() returns a failure, airoha_dev_set_qdma() has
already pointed dev->qdma at &eth->qdma[1] and set dev->dev->irq to the
WAN IRQ, airoha_set_macaddr() has written into REG_FE_WAN_MAC_H,
airoha_ppe_set_cpu_port() has programmed CDM2 as the PPE cpu port, and
airoha_set_gdm2_loopback() itself may have already programmed
REG_GDM_FWD_CFG(GDM2), REG_GDM_TXCHN_EN/RXCHN_EN, REG_GDM_LPBK_CFG,
REG_GDM_LEN_CFG, REG_FE_VIP_PORT_EN and REG_FE_IFC_PORT_EN before the
get_sport() branch failed.

After clearing the flag airoha_is_lan_gdm_dev(dev) reports LAN but
dev->qdma and the hardware registers above still describe the WAN setup.
Would it be cleaner to either unwind those steps or drop the flag clear?

>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index 3a313ac439e7..5715b03e630b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -540,12 +540,17 @@ struct airoha_qdma {
>  	u64 fwd_tx_packets;
>  };
>  
> +enum airoha_priv_flags {
> +	PRIV_FLAG_WAN = BIT(0),
> +};

[Low]
This isn't a bug, but PRIV_FLAG_WAN and the u32 flags field below overlap
conceptually with struct net_device::priv_flags and the IFF_* namespace.
Would a driver-prefixed name such as AIROHA_DEV_F_WAN make the
driver-local scope obvious to future readers?

> +
>  struct airoha_gdm_dev {
>  	struct airoha_gdm_port *port;
>  	struct airoha_qdma *qdma;
>  	struct airoha_eth *eth;
>  	struct net_device *dev;
>  
> +	u32 flags;
>  	int nbq;
>  };

[ ... ]

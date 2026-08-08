Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12C3B2FD4;
	Sat,  8 Aug 2026 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218501; cv=none; b=kgJV3oc0ERd6QzZd421BHhfTxSkyRbtYA6DWsQxs4HxMWHzL+rVRKieIDb3WPqhRREpCJEkXgmS91F7XA0fZFbV6UQNWEfAd8e9G06abVztwNXXG3Tl9g8iwsIp1O5M82UJmBNVw/1Dj46ipFh6Wj/bySpX+rbyiNESr01YCZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218501; c=relaxed/simple;
	bh=z/3iBkvT0+HMIIgLNzbNFzPqXqwkDUmYJ3q4Vgi8jIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYJ3XCiz3YZ3czX3YXL/wtn4+RaEXDNB9lclna8d4ZBdmJGctboMft6zXXSqNeHVN7bGH5WngPI/Vjvm7VCzK2/VxzbPBwjcdEK/zf0fCo+Ckv/+Wl2zp8ibXyMrPkuxmfLLHYoDU9/Z8GkStj6wUr0lTpN6OGb5FcQOPyxzxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOLig0RI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOLig0RI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F701F000E9;
	Sat,  8 Aug 2026 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218500;
	bh=MGD6E8SCA+Po+3uOFW/2mkaHZhiiytiha/CMS5Pt8Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HOLig0RIfD/3dc2MOEjBu//CqUJYkrk/4i0JBMwYAmYhEhO+EpFAeknHOZ1kVXJiF
	 lS84tik6ybyp3hvetalR6G5jabz+IUI0DE1zR3ZYDrHZHfuKb0YjfqEBc3NywC/zAi
	 fbv/JJVNViEpOVtr+V2QaIJ74ZkrIs+JbTaaRIyTH+S1rucAYbm/1V/8MsYdGR7Gh2
	 lYUaBy5ZlnCftgBs4gsNp456Xz2vEzghQi3BePRkhJ+uyCUj9S6C0w7jNn16PAUJUV
	 3si7G6BjaNKWobV7QY2pMc7getpfNkC6rdtzQiVQT4a02CXOU2UhOnL8NtxPNhDMf3
	 WabSueRTZTBhA==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 03/20] net: xilinx: tsn: add endpoint MAC driver skeleton
Date: Sat,  8 Aug 2026 12:48:18 -0700
Message-ID: <20260808194819.132574-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-4-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-4-nagadheeraj.rottela@amd.com>
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
net: xilinx: tsn: add endpoint MAC driver skeleton

This adds a platform driver for the AMD/Xilinx TSN endpoint MAC
("xlnx,tsn-ep-mac"), registering a netdev named "ep" with minimal netdev
and ethtool ops.  There is no data path yet: ndo_open only starts the
queues and ndo_start_xmit drops frames.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> new file mode 100644
> index 000000000000..9b556edf5423
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> +static const struct net_device_ops ep_netdev_ops = {
> +	.ndo_open		= ep_open,
> +	.ndo_stop		= ep_stop,
> +	.ndo_start_xmit		= ep_start_xmit,
> +	.ndo_validate_addr	= eth_validate_addr,
> +	.ndo_set_mac_address	= eth_mac_addr,
> +};

[ ... ]

> +static int xlnx_tsn_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct net_device *ndev;
> +	struct xlnx_tsn_ep *ep;
> +	u8 mac_addr[ETH_ALEN];
> +	int ret;
> +
> +	ndev = alloc_netdev(sizeof(*ep), "ep", NET_NAME_UNKNOWN, ether_setup);
> +	if (!ndev)
> +		return -ENOMEM;

[Severity: Medium]
Can a second TSN IP instance ever probe successfully with this fixed name?
"ep" carries no "%d", so the name is not auto-uniquified and
register_netdev() ends up returning -EEXIST:

net/core/dev.c:dev_prep_valid_name() {
	...
	if (netdev_name_in_use(net, want_name))
		return -dup_errno;
	...
}

reached from register_netdev() -> dev_get_valid_name(), which passes
dup_errno = EEXIST.

The binding added earlier in the series places the ep-mac@ child under the
soft-IP wrapper node and puts no singleton restriction on the wrapper:

Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml:
patternProperties:
  "^ep-mac@":
    type: object

So an FPGA design with two "xlnx,tsn-endpoint-ethernet-mac-3.0" instances is
a valid device tree, and the second xlnx_tsn_ep_probe() would fail at
register_netdev(), free the netdev, and leave that IP's DSA switch without
its conduit.  The same collision happens if any unrelated interface already
holds the very generic global name "ep", for example after a udev rename.
Would something like "ep%d" be preferable here?

Also, since the name is chosen deterministically by the driver rather than
being of unknown origin, should this be NET_NAME_PREDICTABLE instead of
NET_NAME_UNKNOWN?  include/uapi/linux/netdevice.h describes
NET_NAME_UNKNOWN as "unknown origin (not exposed to userspace)", so as
written sysfs name_assign_type hides the provenance from udev.

This still reads the same way at the end of the series, where the call
becomes alloc_netdev_mqs(sizeof(*ep), "ep", NET_NAME_UNKNOWN, ether_setup,
num_tx, num_rx), so no later patch changes it.

> +
> +	SET_NETDEV_DEV(ndev, dev);
> +	ndev->netdev_ops = &ep_netdev_ops;
> +	ndev->ethtool_ops = &ep_ethtool_ops;
> +	ndev->features = NETIF_F_SG;
> +
> +	ep = netdev_priv(ndev);
> +	ep->ndev = ndev;
> +	ep->dev = dev;
> +
> +	ep->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ep->regs)) {
> +		ret = PTR_ERR(ep->regs);
> +		goto err_free_ndev;
> +	}
> +
> +	ret = of_get_mac_address(dev->of_node, mac_addr);
> +	if (ret == -EPROBE_DEFER) {
> +		goto err_free_ndev;
> +	} else if (!ret && is_valid_ether_addr(mac_addr)) {
> +		eth_hw_addr_set(ndev, mac_addr);
> +	} else {
> +		eth_hw_addr_random(ndev);
> +		dev_info(dev, "no valid MAC in DT, using random address %pM\n",
> +			 ndev->dev_addr);
> +	}

[Severity: Low]
Is ep->regs meant to be used by this patch?  Grepping
drivers/net/ethernet/xilinx/tsn/ at the end of the series, ep->regs is only
ever assigned and error-checked in xlnx_tsn_ep_probe() and never
dereferenced by any read or write, so the mapped window is dead state.
Would it be better to map it in the patch that first programs it?

Related question about the address handling: the station address is only
ever set in software here (eth_hw_addr_set(), or eth_hw_addr_random() when
the DT has no valid address), and ndo_set_mac_address is the generic
eth_mac_addr(), which just updates ndev->dev_addr.  If the endpoint MAC
holds its own unicast address or filter words in that window, does the
address advertised to userspace end up permanently diverging from what the
bitstream or bootloader left in the hardware, and does a later

	ip link set ep address ...

ever reach the device?

There is some counter-evidence that no hardware filtering is intended at
all: the driver implements neither ndo_set_rx_mode nor any promiscuity
handling, while DSA adds user-port addresses to the conduit via
dev_uc_add() in net/dsa/user.c and net/dsa/port.c.  If that is the design,
could the commit message say so, and could the unused register mapping be
dropped for now?

Cross-instance finding from sashiko-gemini (e8e82d52a83540aba64fbedc360b0969d77529c63fbeb8f2b749e3809191d7cb):
[Severity: Medium]
Dropped packets are freed using `dev_kfree_skb()`, which aliases to `consume_skb()` and incorrectly signals successful transmission to tracepoints.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE43B2FC7;
	Sat,  8 Aug 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218516; cv=none; b=YpztzLZFF68b3cLYW0tGHd58EaDdUEIMZZF1RdvNdmsvon7Pqozu2pX5ePbMTx5eh1Hohx5oVr8p1kIvQ3ZyiyRhkSEPKxWMQ1P5J1+L2w+yFEcnifH8c5NWpliIMRinpDFODOylYwyWbRsMtFgx0sLpCTETM/jDJHdc44NJCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218516; c=relaxed/simple;
	bh=O7D6thFxDkWFUwJ9dMT4svKDYpoVsSLgFSNjruU/rOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELWfRJETNLK0OSs3Q8DxSVVDHv/40MlmKQqhlr3y5pTPlSdfs4WZsG2qRgtVRpeDtfB9GWeiYZQ1QxS+7TLHcbQwBuCK/hdQfZzTeOa3AiSRAwZGH0GphQVB5eoh1CXIFhTur78/df9b0LoFDv+h36jYrqa1MwvU2/jZgZEkEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvN8/UAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvN8/UAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AE31F00ACF;
	Sat,  8 Aug 2026 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218511;
	bh=eJUc/lZ2agerNn9vcqL2GeFVY6ObRp54aelO+Fhqb0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvN8/UACnQ0pgXHD5yjaoAcQ4leK0pKYSHliQxjVXNC6n1z0NuTomcgb71uvth2iu
	 amwYFYlU+PkgdrHjUgq2iIlcXWDZGyyEsowFGv7Zv0Zn7Jy1APxPTq/L44wpLE9HQv
	 jsbXL6UcfaWg82jLB/3u3LTv/KANYa/wa9/u/okyxExOILA/aYkHjOepM9Kx3zXOeT
	 KQCiB8S18XTG2ro2Eit496DzEFOnAeLfTTz+mZr9SAWP358vNru4yFIWYVJ+HJqaF5
	 OQRDrHhzwR6rCEKA08sysIMotwHFLmzOGGG3c/XLTHtf40Vw0yroGpX0ZTKEfQdh+F
	 GSlzyyHzqeGAg==
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
Subject: Re: [PATCH 13/20] net: dsa: xilinx: wire up phylink for the switch ports
Date: Sat,  8 Aug 2026 12:48:30 -0700
Message-ID: <20260808194830.133171-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-14-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-14-nagadheeraj.rottela@amd.com>
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
net: dsa: xilinx: wire up phylink for the switch ports

This wires up the MAC-side phylink ops for the three switch ports:
phylink_get_caps advertises RGMII variants, SGMII and GMII plus MAC_100FD
and MAC_1000FD on the two external user ports and PHY_INTERFACE_MODE_INTERNAL
with MAC_1000FD on the CPU port, while mac_link_up/mac_link_down program the
speed-config field and the TX_EN / RX_EN bits.

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
> index 542b74514ed3..86aba2e8b6e9 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.c
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.c

[ ... ]

> @@ -324,6 +325,105 @@ static void xlnx_tsn_port_stp_state_set(struct dsa_switch *ds, int port,
>  	xlnx_tsn_set_port_state(sw, port, hw_state);
>  }
>  
> +static void xlnx_tsn_phylink_get_caps(struct dsa_switch *ds, int port,
> +				      struct phylink_config *config)
> +{
> +	if (port == XLNX_TSN_CPU_PORT) {
> +		config->mac_capabilities = MAC_1000FD;
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		return;
> +	}
> +
> +	/* The MAC's speed-config field only encodes 100 / 1000.
> +	 * Half-duplex and 10 Mbps are not supported.
> +	 */
> +	config->mac_capabilities = MAC_100FD | MAC_1000FD;
> +	phy_interface_set_rgmii(config->supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_SGMII, config->supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_GMII, config->supported_interfaces);
> +}

[Severity: Low]
Should the set of interface modes advertised here match the DT binding
added earlier in this series?

xlnx_tsn_phylink_get_caps() advertises six modes for ports 1 and 2:
phy_interface_set_rgmii() sets PHY_INTERFACE_MODE_RGMII, RGMII_ID,
RGMII_RXID and RGMII_TXID, and SGMII and GMII are set explicitly.

Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
allows a narrower set for the same ports:

              phy-mode:
                enum:
                  - gmii
                  - rgmii
                  - rgmii-id

and the top-level description repeats the narrower claim:

  It also supports GMII/RGMII interfaces for connection
  to an external PHY, enabling full-duplex operation at 100 Mb/s and
  1 Gb/s speeds.

If the MACs really can do SGMII and the rgmii-rxid / rgmii-txid delay
variants, does a board synthesised that way fail dtbs_check because the
schema rejects the phy-mode value the driver supports?

If instead the binding is the accurate description, does this advertise
interface modes the hardware does not implement?

> +static void xlnx_tsn_mac_config(struct phylink_config *config,
> +				unsigned int mode,
> +				const struct phylink_link_state *state)
> +{
> +	/* Interface mode (RGMII / SGMII / GMII) is fixed at IP synthesis
> +	 * time. There is no runtime register to program it here.
> +	 */
> +}

Since mac_config is empty and has no error path, phylink would resolve the
link for any of the advertised modes, so a mismatch would show up as a
silently dead port rather than a probe or configuration failure. Would it
make sense to either extend the binding enum or drop the extra
supported_interfaces bits so the two agree?

Both files are still in this state at the end of the series, so this does
not appear to be resolved by a later patch.

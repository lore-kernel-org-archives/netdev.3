Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60542526AAD;
	Thu, 17 Sep 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651354; cv=none; b=TtTzkF5M4bF25qX6bVRu9v9ow6sfB8ebyScHC08pXhHNc3Wvc5/hElndgXDoMKqvmdVYBGpKawuMHLSRIKQ983zT5N3itrGTYHvXpnWcduP0Z9mQ8rzxQaWr2ZB2a8pPNYR27kozxOwG4s6XVOG1FM0R0lCN3OmLGBMnPrxzE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651354; c=relaxed/simple;
	bh=LQgDA3heOZ20C2j9rCef3b/Z41fGDDwOOujjVe75TQY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ww+5J9/2wFUnsljYzQj8IVTCAIsDcBuRFRTg7ioY3vcLf98OzcURgk8HNr2L69AVTTWcUXE4egBJa0pxyD58rffAQUM31B8sQdg0blmiUU9poRFRF27blJ6l7EP3OVKgUVBIZrgH9tQ9CJ6mm9og/Yve7w+mmGA/wzDgMWWT92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di8PNBkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di8PNBkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7821F00893;
	Thu, 17 Sep 2026 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651351;
	bh=9NL2vF5pdtXEIhMT5sd0hpxabEUa6jV0HUdyuzuZxkM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=di8PNBkAvBHBFQCM+rh/ZgU6G1sGuhl95aPSN3LmPtgwBb6P/7yfdagPUmJflIWjX
	 jD56gAMCRORMFVwDwBqEU3KwegTgNdo4nkHaRr2CCh1XS5y/vm73ep0iKyWItsGSSU
	 2ltXyc+Pyv//JTz9bvrKPRk1W39CdFZiULzIZvJsEHR8EbDdvACNyDjH7I+etClSjA
	 pLAZIbKVsqp3P0+b//k5r9xc94fhRu1SjJQwSh/51a3fBoPMQiQKpPRBTEv0J40eKH
	 NYrCsYlXYtbUHnrStcgLtwGMPz08a24vQr4acbMXMuO8RHeMRVQj2Bi5g2fzDlqG0t
	 jXYsx8Vpdeusw==
Subject: Re: [PATCH net-next v15 4/4] net: dsa: ks8995: Delete surplus driver
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 17 Sep 2026 13:22:30 +0000
Message-ID: <178965135045.22033.10731767071063010304@kernel.org>
In-Reply-To: <20260916-ks8995-to-ksz8-v15-4-8825ff5fd4be@kernel.org>
References: <20260916-ks8995-to-ksz8-v15-4-8825ff5fd4be@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Commit message claims the two in-tree boards "continue to be
  supported by the replacement driver without regressions", but the…

--

net: dsa: ks8995: Delete surplus driver

This removes drivers/net/dsa/ks8995.c and its Makefile entry, leaving
NET_DSA_KS8995 behind in Kconfig as a transitional stub that selects the
Microchip KSZ SPI driver instead.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index e3d88f41fecf7..fe8cd5338fda5 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -112,11 +112,13 @@ config NET_DSA_RZN1_A5PSW
>  config NET_DSA_KS8995
>  	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
>  	depends on SPI
> -	depends on NET_DSA_MICROCHIP_KSZ_SPI = n
> -	select NET_DSA_TAG_NONE
> +	select NET_DSA_MICROCHIP_KSZ_COMMON
> +	select NET_DSA_MICROCHIP_KSZ_SPI

[Severity: Medium]
The commit message says the two in-tree boards "both use KS8995XA hardware
and continue to be supported by the replacement driver without regressions".
Is that description accurate with respect to tagging and port isolation?

The deleted driver used no switch tag and did not program the switch at all:

drivers/net/dsa/ks8995.c:
	static enum
	dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds, ...)
	{
		/* This switch actually uses the 6 byte KS8995 protocol */
		return DSA_TAG_PROTO_NONE;
	}

	static int ks8995_setup(struct dsa_switch *ds)
	{
		return 0;
	}

The replacement path for the same "micrel,ks8995" compatible reports a
different protocol and enables special tagging:

drivers/net/dsa/microchip/ksz8.c:ksz8995xa_get_tag_protocol()
	return DSA_TAG_PROTO_KS8995;

drivers/net/dsa/microchip/ksz8.c:ksz8_setup()
	if (ksz_is_ksz8995xa(dev))
		ksz_cfg(dev, REG_SW_CTRL_9, SW_SPECIAL_TAG, true);

ksz8_port_setup() also programs per-port tag insert/remove and restricts
standalone user ports to the upstream port via ksz8_cfg_port_member() with
member = BIT(dsa_upstream_port(ds, port)).

So on intel-ixp42x-linksys-wrv54g.dts and
intel-ixp42x-actiontec-mi424wr.dtsi, frames on the CPU MII link now carry
the switch tag, and user ports are isolated until a bridge is created, so
LAN-to-LAN hardware forwarding no longer happens by default.

Until this patch users could stay on the old behaviour because the two
symbols were mutually exclusive:

	depends on NET_DSA_MICROCHIP_KSZ_SPI = n

Removing that line makes the switch to the new tagging and port semantics
unavoidable. Could the commit message describe this behaviour change rather
than stating there are no regressions, given it also notes that the MA and E
variants were never verified with the replacement driver?

> +	select NET_DSA_MICROCHIP_KSZ_SPI
>  	help
> -	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
> -	  switches, managed over SPI.
> +	  This is a transitional option for users who had NET_DSA_KS8995
> +	  enabled. It automatically enables the new NET_DSA_MICROCHIP_KSZ_SPI
> +	  driver which supersedes it. This option will be removed in a future
> +	  kernel release.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ks8995-to-ksz8-v15-0-8825ff5fd4be%40kernel.org

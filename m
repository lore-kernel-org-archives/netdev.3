Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71838759C;
	Sat, 26 Sep 2026 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431623; cv=none; b=XSlAWT40Htx+3S+YjKQjqn41zyzhBrJ5f+qu0RYyV/3Fhog+27p5birssAbMumZ6oo3RQi4W838/r/ya7vNwsvBthWZGLRYglB/mALMTi9OM5GdMGAiusmax6DCnbWhyq3Tekq/C4z+H0LLLZvM+uOCeEeeNDszOGnsGIj4OHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431623; c=relaxed/simple;
	bh=ZGU/rJ293u2ZMYyBBxQPLyt2bBEUGW4wXCjoTuRkNnc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BvK7/YuzYMKhxsMFfAbjyOX++XkLm/D3RXZ+KWPpjeex84m6+Lz5yew5BOQjB6oufw0/F4oHtq59rPnzsP/QC/3iYZNYqzqgx4ejQtBdbxBr24r5Pmc1iOzf/CHSspIVMwaNZprallj0kJM6Upbg9LejZoHu6qRg84+IwheKlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpMGSoWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpMGSoWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9E71F000FF;
	Sat, 26 Sep 2026 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431621;
	bh=eVCGTQLN6HPS8MK6pZrD0g0NKPJ0VZomA/xRahikd58=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cpMGSoWPyCjQ6HvOhi6LHLVgpfEizzfMFCNgj2lT55Z3wsJxNs1fWiT2tNnU8Wubd
	 TojgZ2Xj49NXAeclQwLmHdb0uecsDQWlXra1jl6QUjzs7INufbfTn5T8Yq9kMt2k8A
	 E9Mv88yWvfMiL+2sWwMOM4CEPBSfdsf5gLEorFlEpRNFD7Quy3SBMwHFK1woil9Qzy
	 Kqxo/YQgUFLVemzK8rlqEx1vjydq54NL7I4xpAaV8OpODljqey2EraX2wg3sUHzytS
	 Ds5ce8+DiKfuE6T2+emS9ogK0SWgt+1X9IUOZbRHH4qMwK5Ig7cTR+HZyDZgf/ixmT
	 88z3z+a7IbEQg==
Subject: Re: [PATCH net-next] net: lan969x: correct RGMII port mapping index
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Date: Sat, 26 Sep 2026 14:06:59 +0000
Message-ID: <179043161980.2160803.10954047128891020505@kernel.org>
In-Reply-To: <20260922125112.2111256-1-robert.marko@sartura.hr>
References: <20260922125112.2111256-1-robert.marko@sartura.hr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: lan969x: the patch does not achieve its stated purpose —
  the new DEVRGMII instance index it returns is never paired with…

--

net: lan969x: correct RGMII port mapping index

This adds an RGMII case to lan969x_port_dev_mapping() so that ports 28 and
29 return DEVRGMII instance indices 0 and 1 instead of the physical port
number. The helper is installed as sparx5_ops::get_port_dev_index and is
read through sparx5_port_dev_index().

> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> index f3a9c71bea36a..bf5320c7a6ca8 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> @@ -142,6 +142,15 @@ static u32 lan969x_get_dev_mode_bit(struct sparx5 *sparx5, int port)
>  
>  static u32 lan969x_port_dev_mapping(struct sparx5 *sparx5, int port)
>  {
> +	if (lan969x_port_is_rgmii(port)) {
> +		switch (port) {
> +		case 28:
> +			return 0;
> +		case 29:
> +			return 1;
> +		}
> +	}
> +

[Severity: High]

Can this new index ever reach DEVRGMII register space?  The value returned
by lan969x_port_dev_mapping() is only read through sparx5_port_dev_index()
and is always combined with a target coming from sparx5_to_high_dev() or
sparx5_to_pcs_dev(), and neither of those has an RGMII case:

drivers/net/ethernet/microchip/sparx5/sparx5_port.h:
static inline u32 sparx5_to_high_dev(struct sparx5 *sparx5, int port)
{
	const struct sparx5_ops *ops = sparx5->data->ops;

	if (ops->is_port_5g(port))
		return TARGET_DEV5G;
	if (ops->is_port_10g(port))
		return TARGET_DEV10G;
	return TARGET_DEV25G;
}

So for lan969x ports 28 and 29 the target stays TARGET_DEV25G (or
TARGET_PCS25G_BR), never TARGET_DEVRGMII.

The base then comes from an unchecked array index:

drivers/net/ethernet/microchip/sparx5/sparx5_main.h:spx5_inst_get() {
	return sparx5->regs[id + tinst];
}

With the new index that is regs[TARGET_DEV25G + 0] and
regs[TARGET_DEV25G + 1].  The lan969x iomap in lan969x_main_iomap[] has no
TARGET_DEV25G or TARGET_PCS25G_BR entries at all, so both slots are NULL.
Before the patch, index 28 resolved to regs[TARGET_DEV25G + 28], which
lands on a mapped (though unrelated) DEV2G5 base.

Does that mean the commit message claim

    So, check if requested port index is an RGMII port and return the correct
    DEVRGMII index.

is not reflected in any code path, since no consumer pairs this index with
TARGET_DEVRGMII?

The real DEVRGMII and HSIO_WRAP accesses compute the instance locally and do
not use this helper:

drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c:
#define RGMII_PORT_IDX(port) ((port)->portno - LAN969X_RGMII_PORT_START_IDX)

used by lan969x_rgmii_port_device_config(), lan969x_rgmii_tx_clk_config(),
lan969x_rgmii_delay_config() and lan969x_rgmii_gpio_config().  Should the
two sources of the same index be folded into one helper instead?

There is also a latent NULL __iomem base introduced here.  In
sparx5_port_init() the devinst and pcsinst pointers are computed for RGMII
ports too:

	devinst = spx5_inst_get(sparx5, devhigh, pix);
	pcsinst = spx5_inst_get(sparx5, pcs, pix);
	...
	if (ops->is_port_rgmii(port->portno))
		return 0; /* RGMII device - nothing more to configure */

They are now NULL rather than a mapped base, and only the is_port_rgmii()
early return keeps them from being dereferenced.  The other consumers of the
pair are gated by unrelated conditions today: sparx5_port_max_tags_set()
runs only after that early return, sparx5_port_disable() and
sparx5_port_pcs_high_set() are reached via sparx5_pcs_config() where
sparx5_phylink_mac_select_pcs() returns NULL for RGMII interface modes, and
the ethtool device stat paths are gated by
sparx5_is_baser(port->conf.portmode).  Would it be safer to also teach the
target selection side about RGMII, for instance returning TARGET_DEVRGMII
for is_port_rgmii() ports, so the index and the target stay consistent?

If this is intended as preparatory work for a later change, could the commit
message say so and name the dependent patch?  A Fixes: tag also seems to be
missing for the addressing bug the changelog describes.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922125112.2111256-1-robert.marko%40sartura.hr

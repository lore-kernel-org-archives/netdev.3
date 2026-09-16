Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2D3ED3CA;
	Wed, 16 Sep 2026 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541256; cv=none; b=kW1iPs57xlNRQgku0SBGONo0sdBSyllLzIuaDISN8l5YDx/M+vlLle2NyjWOFPSLSf/8fkUpEyTmb+/jQsDBV0EHBdOrrsCt5noWubyocTMdjLmb7k6c5X3wE5Jvt3hNGVzsYuhJlrMX8oJDgCZr/g6YzWWuEiI8c6fDqJo4680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541256; c=relaxed/simple;
	bh=+LREsftP8Pn0iBjd6J3nl8ZXdWRX5BhzN+cJZ4p56z0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3YbxMrd1bHQlc20fdtKtZ8ewm9Mgl3YvYDTfP95FYhM09yR5kbVRNrUOah+8uWQg4LM9LbbX6E9ivOBo0Q/k/q0R9Me5sdmMSP+ELgLxMkFjV+3TyypR+JOkxH/ImG3aCPBn6xoDxCSDfm9EPE6GHkbq/5zb/gubBJllpFJIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJCw0D2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJCw0D2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACB11F00899;
	Wed, 16 Sep 2026 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541250;
	bh=4Oh3PHhVnchBfV4NSQn7pdgBtr4KUMSitZHBRMniOJo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JJCw0D2NH+3R6rM6Tr0wSAP3bJEnAowceIX5sU3GVeeby2o+JMl0w6I5X6MFwE7hA
	 5LDqV1D/UrWi44qnfG2pxbj+0LwbywkiATAqy1Ut5WM8vDdPIfhcLcCzz8mNqXG1+u
	 ioc+KMaJgwbCzM+kt65ja+dLqRbd5Q2S3fm4q3ycfmzSuj8Neg3MSGFBDNw8QX9Jkw
	 6AetqrQx1yZ6r3mTW47aMocmo2wUJpc0kbFZc34D730GPnzw57bPk0xhYC3KuMPKGD
	 IJFLrDyPq0PWGM1JDtt2f05//KsRnhfnR+LZ8hWs2Ogjuka7PpbxSf49+jlUTofR/d
	 55jVAZvqA9gDQ==
Subject: Re: [PATCH net-next v11 07/15] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:29 +0000
Message-ID: <178954124982.22033.7198652363508490714@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-7-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-7-5ea7a925ba6d@birger-koblitz.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 5

- [Low] Commit message of "ax88179_178a: Add EEE configuration support
  for AX88179A MACs" ends in a truncated/garbled sentence describing…
- [Low] Concern (validated as resolved later in the series): registering
  .mac_enable_tx_lpi/.mac_disable_tx_lpi makes phylink_create() set…
- [Low] Concern (validated as resolved later in the series):
  ax88179a_ethtool_ops has no .get_eee/.set_eee entries at this commit,…
- [Low] Concern (validated as not a defect): the LPI ops are added
  unconditionally to the single ax88179a_phylink_mac_ops table shared by…
- [Low] Concern (validated as speculative/non-actionable):
  AX_GPHY_EEE_CTRL is written only from the two new phylink LPI…

--

ax88179_178a: Add EEE configuration support for AX88179A MACs

This adds two phylink LPI callbacks, ax88179a_mac_enable_tx_lpi() and
ax88179a_mac_disable_tx_lpi(), which toggle the AX_GPHY_EEE_CTRL register,
and registers them in ax88179a_phylink_mac_ops.  The AX88179A has no LPI
timer registers, so the timer argument is ignored.

A few questions below, all minor.

>     The AX88179A uses a simple HW configuration for EEE
>     via a single EEE configuration register without LPI timer support
>     Add support for this EEE enable/disable register and replace the EEE.

[Severity: Low]
The last sentence looks truncated: "Add support for this EEE
enable/disable register and replace the EEE."

What is being replaced here?  The diff is purely additive: it adds
ax88179a_mac_disable_tx_lpi(), ax88179a_mac_enable_tx_lpi() and two
members of ax88179a_phylink_mac_ops, and deletes nothing.  The legacy
get_eee/set_eee and ax88179_enable_eee() code in ax88179_178a.c is left
untouched.

Could the sentence be completed so the changelog matches the change?

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 21ca71cba52ca..80cabe3557cde 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -384,10 +384,27 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
>  	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
>  }
>  
> +static void ax88179a_mac_disable_tx_lpi(struct phylink_config *config)
> +{
> +	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
> +
> +	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);
> +}

[Severity: Low]
AX_GPHY_EEE_CTRL is only ever written from these two new callbacks, so it is
never forced to a known value during ax88179a_bind()/ax88179a_reset().  If the
chip powers up with EEE enabled, does the hardware state match phylink's
bookkeeping until the first link up/down transition?

Would an explicit disable write in the reset path be worth adding?

On the ignored return value here: the phylink prototype is
void (*mac_disable_tx_lpi)(struct phylink_config *), so there is no way to
propagate a failed USB control transfer, and the resume path does re-resolve
the link (ax88179a_resume() -> ax88179a_reset() -> phylink_resume(), which
either calls phylink_start() or phylink_link_down() plus
phylink_mac_initial_config() and phylink_enable_and_run_resolve()), so the
register state is re-established on a link cycle.  Mentioning it only for
completeness.

> +
> +static int ax88179a_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
> +{
> +	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
> +
> +	/* AX88179A does not provide LPI timer registers */
> +	return ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, true, 0, NULL);
> +}
> +
>  static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
>  	.mac_config = ax88179a_mac_config,
>  	.mac_link_down = ax88179a_mac_link_down,
>  	.mac_link_up = ax88179a_mac_link_up,
> +	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
> +	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,

[Severity: Low]
Registering both LPI ops makes phylink_create() set
pl->mac_supports_eee_ops = true, but ax88179a_phylink_setup() does not
populate phylink_config.lpi_interfaces at this commit, so phylink_create()
leaves mac_supports_eee false:

drivers/net/phy/phylink.c:phylink_create() {
	pl->mac_supports_eee = pl->mac_supports_eee_ops &&
			       pl->config->lpi_capabilities &&
			       !phy_interface_empty(pl->config->lpi_interfaces);
}

In that state phylink_bringup_phy() takes the branch that calls
phy_disable_eee(phy), phylink_ethtool_get_eee()/set_eee() return
-EOPNOTSUPP, and the two new callbacks are never invoked, since
phylink_link_up() gates on mac_supports_eee and phylink_activate_lpi()
additionally tests config->lpi_interfaces.

This is resolved by the following patch in the series, "ax88179_178a: Add EEE
configuration support for AX88179A PHYs", which adds the memcpy of
supported_interfaces into lpi_interfaces before phylink_create(), so it only
affects the intermediate state.  Would it be worth folding the
lpi_interfaces assignment into this patch so bisection points do not have EEE
forced off?

[Severity: Low]
Related to the above: at this commit ax88179a_ethtool_ops has no .get_eee or
.set_eee entries, and ax88179a_phylink_setup() sets
phylink_config.eee_enabled_default = false, so nothing can set
pl->eee_cfg.eee_enabled and ax88179a_mac_enable_tx_lpi() cannot be reached
from userspace.

The ethtool wrappers ax88179a_get_eee()/ax88179a_set_eee() arrive in the next
patch of the series, so this too is limited to the intermediate state.

[Severity: Low]
The ops are added unconditionally to the single mac_ops table shared by
AX88179A, AX88279 and AX88772D, while ax88179a_phylink_setup() sets
lpi_capabilities only for !is_ax88772d.

For AX88772D that combination looks intentional and is handled by phylink:
phylink_bringup_phy() documents ops present with empty lpi_capabilities as
"MAC supports phylink EEE, but wants EEE always disabled", and no
AX_GPHY_EEE_CTRL write happens for that chip.

Is the AX_GPHY_EEE_CTRL encoding the same on AX88279, or does that part need
a chip_version guard?

>  };
>  
>  static int ax88179a_phylink_setup(struct usbnet *dev)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de

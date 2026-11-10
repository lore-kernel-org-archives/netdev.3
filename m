Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274715;
	b=g0vDgNKau8lP2l/BFOpSI+eyeZuDXn7T5zu8IVD6rf9hYGTbR2haNzbS5K1rNSuVbLpY
	 peum1Pwg2yCxItc5RUiAFQSoGzGOM+iMOUw/ZTwFJj58gvGw1jnBOPszX6pmI770suXwl
	 4QwG7y5HuSosvJJSsptIlyc+6qanXMSpASoz9yl170qCy2mCx6qwtCBY+Omx+aYKytngj
	 54mXzDZnuc0UgSnl4VYp8CanMjPeV+eH+9gI+XekbXqbXDziMX5iVPQQoqh27IAP3vgPm
	 TN92y3xY4EQ1NevLOhwKI8W2O5ILMPy+TraFRDsBnQxtBxv9SzdVsF09hu5u/+Ota8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274715;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0bYZ/zOlq+OiPPFtzwsws4ROrxwK9LWmpXGJUjz7tLE=;
	b=qpnP0SLJDfMdET46naAS4/vmDOnAG1BQPEVWE9z4K1W0c6qa6gjAjoSWHJoYyzUKU3XA
	 f8tE8zwh0VF36+EIeJ1Rwy/Nm92P/uIb2oKpO3uu/rgaDbC4H6CsnPMd6OzLlEDvKBAtN
	 dqQXcMpW5Ph+YjfQC/+pDEPw8O6+8akRvmQMP1wkLWzad3SYM/bmUcgRxJNARB6HY3ij9
	 xDhZrXIXyiX1LwI6ahABt/8eBQAdeKZzGY9+taX1ilBa8r2+a0i0pvdiq4RxRcY5t5f3f
	 IXd0zE8Ix1C7ZIhI4d89ixBoi4eIYogdoD4i4KznXMvZWFA68ChkX07gC0z64MLrreA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hmk3FgkE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4360A3801;
	Tue, 10 Nov 2026 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hmk3FgkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6956B1F008A3;
	Tue, 10 Nov 2026 01:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274715;
	bh=0bYZ/zOlq+OiPPFtzwsws4ROrxwK9LWmpXGJUjz7tLE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hmk3FgkEcL1lKKJ1m1XhaZy/2R9kESJuQ2EwhfK2LhoJ1xhGuXaLQB+4gOdfuJznu
	 E5SDn7Nm8DYCNDVV79gIP4eiBFXDoc6RLDFfToCbuTxae21n7Vv50+BJS9+RQO/sAe
	 6qcu+kW6i7ePkiMa5QvDe/UNBoE7FGHqCaQthS6P1LKtKhBZYfOjDadGze+Prl/6kO
	 LrIFV8oHc4PAQiiFez+U/w00UXaVDqx27b5oGSgPXnpxRNofCYMTjTcHZg5Vze0ogN
	 4r1b76IVTXTKtf0z5nHw9I1afP15jU+uzgcd66snZJBo6IoDZCnm7uv1NaLw5WMq/8
	 czDGXf5r0vbcA==
Subject: Re: [PATCH net-next v20 05/13] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:34 +0000
Message-ID: <179427471400.994134.4547536241742867057@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-5-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-5-37b5a1189983@birger-koblitz.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Baseline decision: false positive, because the next patch in the
  series fixes it.
- [Low] Baseline decision: false positive, because the next patch in the
  series fixes it.

--

ax88179_178a: Add EEE configuration support for AX88179A MACs

This commit adds mac_enable_tx_lpi and mac_disable_tx_lpi phylink callbacks
for the AX88179A. They toggle the single AX_GPHY_EEE_CTRL register through
ax88179_write_cmd(). The hardware has no LPI timer registers.

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 1aa8479422517..62619fd68c408 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c

[ ... ]

>  static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
>  	.mac_config = ax88179a_mac_config,
>  	.mac_link_down = ax88179a_mac_link_down,
>  	.mac_link_up = ax88179a_mac_link_up,
> +	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
> +	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,
>  };

[Severity: Low]
With both LPI ops present, phylink_create() sets pl->mac_supports_eee_ops
to true. At this commit, ax88179a_phylink_setup() sets lpi_capabilities but
does not fill phylink_config.lpi_interfaces:

    if (!data->is_ax88772d) {
        data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
        data->phylink_config.eee_enabled_default = false;
    }

phylink_create() requires a non-empty lpi_interfaces:

    pl->mac_supports_eee = pl->mac_supports_eee_ops &&
                           pl->config->lpi_capabilities &&
                           !phy_interface_empty(pl->config->lpi_interfaces);

So mac_supports_eee comes out false. Does phylink_bringup_phy() then take
this branch for every AX88179A/AX88279 device?

    } else if (pl->mac_supports_eee_ops) {
        /* MAC supports phylink EEE, but wants EEE always disabled. */
        phy_disable_eee(phy);

ax88179a_mac_enable_tx_lpi() also looks unreachable here.
phylink_link_up() does not call phylink_activate_lpi() when
mac_supports_eee is false, and phylink_activate_lpi() returns early in any
case:

    if (!test_bit(pl->cur_interface, pl->config->lpi_interfaces)) {

phylink_ethtool_get_eee() and phylink_ethtool_set_eee() would return
-EOPNOTSUPP in this state as well.

The next patch in the series, "ax88179_178a: Add EEE configuration support
for AX88179A PHYs", copies supported_interfaces into lpi_interfaces before
phylink_create(), so this gap only exists at this one commit. The default
behaviour seen by users is unchanged, because the driver already defaults
to EEE off with eee_enabled_default = false.

Would it make sense to fill lpi_interfaces in this patch, so the new
callbacks can be reached at this commit?

[Severity: Low]
At this commit ax88179a_ethtool_ops has no .get_eee or .set_eee entries:

    static const struct ethtool_ops ax88179a_ethtool_ops = {
        ...
        .set_eeprom             = ax88179_set_eeprom,
        .nway_reset             = phy_ethtool_nway_reset,
        ...
    };

So ethtool --set-eee on an AX88179A returns -EOPNOTSUPP. Userspace has no
way to enable EEE through the new mac_enable_tx_lpi/mac_disable_tx_lpi
callbacks. EEE stays off, which matches eee_enabled_default = false.

The next patch, "ax88179_178a: Add EEE configuration support for AX88179A
PHYs", adds ax88179a_get_eee() and ax88179a_set_eee(). These wrap
phylink_ethtool_get_eee() and phylink_ethtool_set_eee() and are wired into
ax88179a_ethtool_ops.

Is splitting the MAC side and the ethtool side across these two patches
intended?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de

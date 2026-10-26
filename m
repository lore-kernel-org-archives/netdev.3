Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058446;
	b=M/HJuOAF+Ax/ycKK72DT75g9vbZDzSFFSkLiFcygjs2CT2/R2pEYKyErjrEi6VrLbyGv
	 CjRVB93NfDTzfiNd0+ui345q6RIQWqJzsqtdXYl/5A+GllICfEnO08d80NbDjuMo3/7sp
	 XfzakM5o5Va39Q/sVyOO0grMCcxFxlf1+BqUPAGUtg17xeqRS+C1sRcURt+2bCskksXZc
	 gmkCldXBSVPOiyLNHmx6sGzTPyEaPHRWmZ1+7ybicCuy2Vph7TTlHqOUBoiTgcM3oJ97O
	 0aA0Zvy/9uYj7SCuCL/zeafZyA79+/q+yMBwEm+PhLt7YsouhQjpefrFgZ+CTqL4IDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058446;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=r0eA03fdm/ulrgEITtCEML1V17mWf2+AdSWODinmnFI=;
	b=B8qiINcw5/7qIQ9+yqz2C4LIyWPOvJaxq2QFZzqNUuNSVeMUp9ySuKy2Rx7Ir7PXc3oX
	 7uk9lvPFZA+dzX5KMbQxgm0KLx1CHqEwboio2O0vwjlqWDk9m2ZsZ3ypGFcwrbEWYsVI2
	 bS2lyGKMXpNeFyfAQRPzbp1jJXVT7rage9WF92O2VR+7Hhlo70UNr4BcJdE1tlxUCodD7
	 wSrfXd2BUP9xQ7Cv/hmEqqXFh2X1H3ZTllhrj6wF4CRDqRJTs7CWLY2MXFSz9xK1r7A3z
	 3YLFmTOaefWI/TzvTCIeSydxFvYQszkShCp7eDSnmO+DI/fEjRzqmYE0WbE0HhEtNKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VnmJ/2GE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9321606A328;
	Mon, 26 Oct 2026 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnmJ/2GE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DC21F031E4;
	Mon, 26 Oct 2026 23:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058442;
	bh=r0eA03fdm/ulrgEITtCEML1V17mWf2+AdSWODinmnFI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VnmJ/2GEdCoiPW0eIcpYLBtcscXX1HG6m1v27rVueB697nGM13AaBFUccOVJATOuE
	 ZroWTDwUw0iwAFjkkvo+8Q5SiYpvY2cYaOpXgBbNe2/pdcV8zaeK2UjiW228fi0hxQ
	 qv2qaMwxycaFAmS99arH9+O0iEAitie8t3C1zzTf7/tvZMq6GEQQScclEqLUHfCG7p
	 JIfz4DDx8wRip0Keb+ZZykYad2jYib7trhRlrpij6iZGzkfBfH/NMfLgrpN1rTjyER
	 q3IBwT3yghiyS5j/P9yhb2mpi2VsAVdrFK9Yt6J8aXOuqCTbFOtbXl+OUqUDeHAz7A
	 aRsq0njDrBWEA==
Subject:
 Re: [PATCH net 5/6 RESEND] net: dsa: b53: report link state through the PCS
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:47:21 +0000
Message-ID: <179305844139.3134.6974876926759672110@kernel.org>
In-Reply-To: <20261022225656.1387306-6-florian.fainelli@broadcom.com>
References: <20261022225656.1387306-6-florian.fainelli@broadcom.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] b53_srab_port_thread()
  (drivers/net/dsa/b53/b53_srab.c:371-380) now calls…
- [Low] In b53_serdes_link_change()
  (drivers/net/dsa/b53/b53_serdes.c:317-330), if the…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  b53_srab_request_grant() (drivers/net/dsa/b53/b53_srab.c:91-112) has a…

--

net: dsa: b53: report link state through the PCS

This commit changes b53_serdes_get_state() to decode the Clause 22 BMSR
and LPA registers with phylink_mii_c22_pcs_decode_state(). The SRAB
port interrupt now notifies phylink through phylink_pcs_change(), using
the SerDes digital status LINK_STATUS bit instead of the MAC link status.
The patch also removes b53_port_event() and turns on PCS polling.

> diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
> index fc20e211e67e1..c7f3e131f2def 100644
> --- a/drivers/net/dsa/b53/b53_serdes.c
> +++ b/drivers/net/dsa/b53/b53_serdes.c
> @@ -291,50 +291,44 @@ static void b53_serdes_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
>  static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>  				 struct phylink_link_state *state)
>  {

[ ... ]

>  	bmsr = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMSR),
>  			       SERDES_MII_BLK);
> -	if (bmsr < 0) {
> -		state->link = false;
> -		b53_serdes_error(dev, lane, bmsr);
> -		return;
> -	}
> +	if (bmsr < 0)
> +		goto error;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
The SRAB accessors behind b53_serdes_read() have a mismatched timeout
check in b53_srab_request_grant() in drivers/net/dsa/b53/b53_srab.c:

	for (i = 0; i < 20; i++) {
		ctrls = readl(regs + B53_SRAB_CTRLS);
		if (ctrls & B53_SRAB_CTRLS_RCAGNT)
			break;
		usleep_range(10, 100);
	}
	if (WARN_ON(i == 5))
		return -EIO;

If the grant never arrives, the loop exits with i == 20 and the function
returns 0. The register access then goes ahead without the RCA grant.

If the grant arrives on the sixth poll (i == 5), the function warns and
returns -EIO for an access that should have succeeded.
b53_serdes_get_state() then reports that error as link down.

Should this check be i == 20?

[ ... ]

> +void b53_serdes_link_change(struct b53_device *dev, int port)
> +{
> +	u8 lane = b53_serdes_map_lane(dev, port);
> +	int dig;
>  

[ ... ]

> +	if (lane >= B53_N_PCS || !dev->pcs[lane].dev)
> +		return;
> +
> +	/* Use the live PCS status, not latched BMSR or MAC override status. */
> +	dig = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_STATUS,
> +			      SERDES_DIGITAL_BLK);
> +	b53_serdes_error(dev, lane, dig);
> +	phylink_pcs_change(&dev->pcs[lane].pcs, dig >= 0 && (dig & LINK_STATUS));

[Severity: Medium]
Can this force a fixed-link SerDes port down?

b53_srab_port_thread() calls b53_serdes_link_change() for every port
whose mux mode is SGMII. Nothing on this path checks the phylink AN
mode. b53_serdes_phylink_mac_select_pcs() returns the PCS for SGMII and
1000BASE-X in every mode, so pcs->phylink is also set for fixed-link
ports.

When the SerDes has no sync, for example because the peer is not up
yet, this is the call chain:

b53_srab_port_thread()
  b53_serdes_link_change()
    phylink_pcs_change(pcs, false)
      phylink_link_changed()
        pl->link_failed = true;

phylink_resolve() checks link_failed before the fixed-link branch:

	} else if (pl->link_failed) {
		link_state = pl->link_config;
		link_state.link = false;
		retrigger = true;
	} else if (pl->act_link_an_mode == MLO_AN_FIXED) {

As a result, b53_phylink_mac_link_down() calls
b53_force_link(dev, port, false). The retriggered resolve then takes
the MLO_AN_FIXED path, and b53_phylink_mac_link_up() calls
b53_force_link(dev, port, true).

Before this patch, b53_port_event() read B53_LINK_STAT. That register
follows the forced override, so a fixed link always reported up=true
and this interrupt never took it down.

The commit message says MAC link status "can be overridden by
mac_link_up/down()". Does the link_state_pN interrupt also fire when
those override bits change? If so, each forced toggle would raise
another interrupt that reports SerDes down again. The forced MAC link
and the carrier would then keep flapping until the SerDes gets sync. I
can't confirm that hardware behaviour from the code.

Would it make sense to call phylink_pcs_change() only when the PCS
provides the link state (in-band), or to keep the previous MAC-status
notification for the other modes? The commit message also doesn't
mention this change in fixed-link behaviour.

[Severity: Low]
What happens here when the B53_SERDES_DIGITAL_STATUS read fails?

b53_serdes_read() can return a negative errno, for example -EIO from
b53_srab_request_grant() or a b53_srab_op() timeout. In that case the
expression evaluates to false and phylink_pcs_change(pcs, false) is
called. phylink_link_changed() then sets pl->link_failed. As a result,
phylink_resolve() forces a link down/up cycle while the real link state
is unknown.

The phylink_pcs_change() kernel-doc says:

  If in doubt about the link state at interrupt time, then pass true if
  pcs_get_state() returns the latched link-down state, otherwise pass
  false.

b53_serdes_get_state() now reads MII_BMSR, which latches link-down.
Should the error case pass true, so that a transient access failure in
the IRQ thread doesn't cause a link flap?

>  }
> +EXPORT_SYMBOL(b53_serdes_link_change);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022225656.1387306-1-florian.fainelli%40broadcom.com

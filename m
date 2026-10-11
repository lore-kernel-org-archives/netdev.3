Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2F1463B9C;
	Sun, 11 Oct 2026 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748292; cv=none; b=R5W13HvgtzE6UgQMfw+f2DMBSGLFYicS1BZ3F32zNGR3JoTYsmts4k6yLGwnBwtqwaVvF+nUXoWpQK+f4YjwbuubKwuWSyAoVvRvATPskPrzh7jBBGmf/wsLaAB/DfUsgaEOHzdKEPOxMXeF0aJltZ1lOsieSkZN3EnGC8qXrXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748292; c=relaxed/simple;
	bh=4se4uHMC97QgGHXvxbMlmjwpHcbloYW4bCGbOKMnW+E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjCvfR0kLAowc3xMVrz3f7ngfLbH+Y5BrzUwYhgxcBSeMQpLYIuGNkcnbB686FvEWXN/WlchC2suIvLMIentCRJw+ieCgRLbT+DneQCr3tfeZne6L68ervNBGVnOipgBcHMqoU5RpT2axUnqyWc1KETtuAzysSqTxr5zJ7TrHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrqRE28R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrqRE28R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFC41F0089B;
	Sun, 11 Oct 2026 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748291;
	bh=/p/JZkpPRUTdvbzpofph+CHY3QC8tVZqhJXJcQRPyAg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZrqRE28RmGfpcLvZ97bAIv2q5/Cf4sbVKOPgks2D/ZxSZ4YdR+31LwQLP7DAluXQ4
	 ValFeplE42H2PNSo1LDjKnxpwRvAU7ALxQcamMwEWbtMhcvS+6uPWWAmeXvLfzKsWS
	 yqXdxER7mhMSN+vx6nHNJ/VwpqCFQc8H7a+1cehjt7jx0OF8Oihp/PC3wH1XVl/sXb
	 RuknVkhtNDnzcOxxPWhcRhovbeX1rK/N47wwOk8EOyUAKjJ/N6oOVmMoJBe5p2HDee
	 mvrCNSu9XSlWsjLtqmcMT52fC75oQQArEAGGDmZjIczqMpSx+1IM5xFPkeEpdBn5Cs
	 G2m1mDzQDrnWw==
Subject: Re: [PATCH net-next v3 9/9] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 19:51:30 +0000
Message-ID: <179174829036.434549.5346764045610555935@kernel.org>
In-Reply-To: <8d3a9cc7-17cb-46b5-ac78-c7b4055989a7@yahoo.com>
References: <8d3a9cc7-17cb-46b5-ac78-c7b4055989a7@yahoo.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On family D, rtl8365mb_pcs_get_state() replaces the configured
  speed and duplex with fixed values.
- [Low] The comment above RTL8365MB_SDS_EXT_INTERFACE_ID
  (drivers/net/dsa/realtek/rtl8365mb_main.c:347-350) says "The embedded…

--

net: dsa: realtek: rtl8365mb: add support for RTL8367S-VB

This patch adds the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the
chip table as the first family D chip. On this chip the SGMII/HSGMII
SerDes is on external interface 0 (port 6) and RGMII is on external
interface 1 (port 7). The patch also caps priv->num_ports at 8 for
family D and updates the comment on the learn limit.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 5d804099f131a..c6045607ade06 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -874,6 +881,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
>  		.jam_table = rtl8365mb_init_jam_8365mb_vc,
>  		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
>  	},
> +	{
> +		.name = "RTL8367S-VB",
> +		.chip_id = 0x6642,
> +		.chip_ver = 0x0010,
> +		.family = RTL8365MB_FAMILY_D,
> +		.extints = {
> +			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },

[Severity: Medium]
This entry lets port 6 run SGMII on a family D chip. That makes the
family D branch of rtl8365mb_pcs_get_state() reachable for the first
time.

Does that branch discard the forced speed and duplex that phylink has
already filled in?

drivers/net/dsa/realtek/rtl8365mb_main.c:rtl8365mb_pcs_get_state() {
    ...
	if (is_d) {
		state->duplex = DUPLEX_FULL;
		state->speed = state->interface == PHY_INTERFACE_MODE_2500BASEX ?
				SPEED_2500 : SPEED_1000;
		return;
	}
    ...
}

rtl8365mb_phylink_get_caps() advertises MAC_10 | MAC_100 | MAC_1000FD
for this port, so phylink accepts a forced 10/100 setting.

Take port 6 as a PHY-less SGMII user port with
managed = "in-band-status", and run:

  ethtool -s <port> autoneg off speed 100 duplex full

phylink_ethtool_ksettings_set() stores link_config.speed = 100.
phylink_pcs_neg_mode() then picks PHYLINK_PCS_NEG_OUTBAND, and the mode
stays MLO_AN_INBAND because there is no phydev.

After that:

phylink_resolve()
  phylink_mac_pcs_get_state()
    state->speed = pl->link_config.speed;    /* 100 */
    rtl8365mb_pcs_get_state()
      state->speed = SPEED_1000;
  phylink_link_up()
    rtl8365mb_phylink_mac_link_up()          /* 1000/full */
      rtl8365mb_ext_config_forcemode()

Would the MAC then be forced to 1000 Mbps while the configured speed is
100? Would ethtool get_link_ksettings also report 1000/full?

The family C branch avoids this by reading the forced values back from
SDS_MISC. When in-band autoneg is disabled, could the family D branch
keep the speed and duplex that phylink passed in?

[Severity: Low]
This isn't a bug, but this entry makes the comment above
RTL8365MB_SDS_EXT_INTERFACE_ID inaccurate:

/* The embedded SerDes can only be muxed to external interface 1 (MAC8),
 * which is port 6.
 */
#define RTL8365MB_SDS_EXT_INTERFACE_ID		1

On RTL8367S-VB the SerDes is on external interface 0, and external
interface 1 is the port 7 RGMII interface.

rtl8365mb_pcs_config() still does:

	const int id = RTL8365MB_SDS_EXT_INTERFACE_ID;

This only works today because every use of id is in the !is_d branch.

Could this comment be updated for family D, as was done for the
LEARN_LIMIT comment?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/e84d76ee-03df-49b0-8c9a-b289dfae8728%40yahoo.com

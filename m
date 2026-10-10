Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96503793A9;
	Sat, 10 Oct 2026 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609257; cv=none; b=Bpz3d3XO2BEmS31UzIVvAEGfI9HvG3elX+5n5qECqkElNJkHySrwT8bXn6hsQkrOzF7YzVVwKNvRoQYy1kY1lRZP1CvFGWX5bBj6ol5+YsV4FoGyjLh5Z2kbuAp7lz8p8Ghy7wbEQjA7Yoxj/f7V1GPBr6q+Ds6l1SKZNr9tL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609257; c=relaxed/simple;
	bh=PDkjBawJpyQjm/Cl61ap3lIuw2hEe9BcNlvy4Syg0qw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7wnyzWbPk8nDSJUKB3Afve/xk4ct6lyTODb8haQxcOYRdeYdMy124lUp4hBytd9KB/vUSU98Vagij6NFuZYtl59ZFvDh+A4NRs2aaQydzZfSLeAFcOr+UQtmsAIRK6GpqSy3xQaXXfgum+0SN1JsE+2QPIC8VSsFjinmwWEJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4uqUNiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4uqUNiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8134B1F00893;
	Sat, 10 Oct 2026 05:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791609256;
	bh=hd03o8pGxqvvOsfLe9hcoypAAVGEnRhxTdJxKvz5dxU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V4uqUNiNQ+IciQHJFT2Ihclpdn41S1TAV6crnsT/dJagXargSF+WfF1yng0egjdjQ
	 FLZKtKm0hgrsq+e9YVG7RBUYHu/9rpKpqIdQLoiWg4xNRQgHpoBXl7naY309Vv0X7T
	 IQ6g6pQZ5iojatXLgyQJr+Pl2NK4Rsvlh9NFflxa7v3r/TzhlF6Qj/9+Zswq5/VEFN
	 ZCuixeedb5casxAjdrrRN0UP8eMmPjmOol0hqyb01M/a0BggjMn8bOtoMkDLxpWkW5
	 hlVnCN+o7rb09YtMhnuj9QFZmZHFZpacav5XMq8MwKuRd1hsmOKyfwRcc+KTqgJbQT
	 rVNdH7YIUZ9HA==
Subject: Re: [PATCH net-next v2 2/8] net: dsa: realtek: rtl8365mb: set speed
 for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 05:14:15 +0000
Message-ID: <179160925505.434549.8008768293460524931@kernel.org>
In-Reply-To: <05f792d4-ed17-47b5-abb5-70813ce628cc@yahoo.com>
References: <05f792d4-ed17-47b5-abb5-70813ce628cc@yahoo.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, the family D 2.5G MAC force encoding
  (RTL8365MB_D_PORT_SPEED_2500M, split across FORCE_SPEED bits[1:0] and…

--

net: dsa: realtek: rtl8365mb: set speed for family D

This patch makes rtl8365mb_ext_config_forcemode() use the family D
2500M speed code (5). The code is split across FORCE_SPEED bits[1:0] and
a new FORCE_SPEED2 field. On family D the value goes to a per-port force
register at 0x12c0 + port, with an enable register at 0x12c8 + port.
Family C keeps programming 1000M for 2.5G.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 80fc551992195..b1ea8b06a1a18 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1661,23 +1676,31 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,

[ ... ]

> +	is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
>  	if (link) {
>  		/* Force the link up with the desired configuration */
>  		r_link = 1;
>  		r_rx_pause = rx_pause ? 1 : 0;
>  		r_tx_pause = tx_pause ? 1 : 0;
>  
> -		/* The speed field has no value for 2.5 Gbps: the rate is
> -		 * determined by the HSGMII SerDes configuration, and the
> -		 * vendor driver programs the 1 Gbps value here.
> -		 */
> -		if (speed == SPEED_2500 || speed == SPEED_1000) {
> +		if (speed == SPEED_2500) {
> +			if (is_d) {
> +				r_speed = RTL8365MB_D_PORT_SPEED_2500M;

[Severity: Medium]
At this point in the series, does the family D 2500M MAC force match
what the PCS side programs for the same link?

At this commit the PCS path still only handles family C.
rtl8365mb_pcs_config() uses the hardcoded ext id, the family C jam
tables and the MAC8 mux:

	const int id = RTL8365MB_SDS_EXT_INTERFACE_ID;
	...
	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
		sds_jam = rtl8365mb_sds_jam_hsgmii;
		sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_hsgmii);
		mode = RTL8365MB_EXT_PORT_MODE_HSGMII;

rtl8365mb_pcs_link_up() also still writes the family C value (1000M for
2.5G) into SDS_MISC:

	if (speed == SPEED_2500 || speed == SPEED_1000) {
		r_speed = RTL8365MB_PORT_SPEED_1000M;

The RTL8367S-VB chip_info entry puts the SerDes on port 6 with ext id 0:

	{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },

RTL8365MB_SDS_EXT_INTERFACE_ID is 1.

If sds_supported is set on an RTL8367S-VB, rtl8365mb_phylink_get_caps()
advertises 2500BASEX. mac_select_pcs() then returns &mb->pcs, so the
family C pcs_config() and pcs_link_up() run. Meanwhile
rtl8365mb_ext_config_forcemode() writes RTL8365MB_D_PORT_SPEED_2500M.

Would a 2500BASE-X link on family D come up at this commit?

A later patch in the series, "net: dsa: realtek: rtl8365mb: add family
D SDS13 PCS support", appears to fix this. It adds an is_d path to
rtl8365mb_pcs_config(), and rtl8365mb_pcs_link_up() returns early on
family D. The family C PCS handling on family D was added by "net: dsa:
realtek: rtl8365mb: detect RTL8367S-VB", not by this patch.

Could the series be reordered, or 2500BASEX held back for family D until
the PCS support lands, so this in-between state can't be reached?

> +			} else {
> +				/* The speed field has no value for 2.5 Gbps: the rate is
> +				 * determined by the HSGMII SerDes configuration, and the
> +				 * vendor driver programs the 1 Gbps value here.
> +				 */
> +				r_speed = RTL8365MB_PORT_SPEED_1000M;
> +			}
> +		} else if (speed == SPEED_1000) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/28382f3f-03c1-4606-9b11-86f118abeafe%40yahoo.com

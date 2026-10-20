Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460492;
	b=wdiR8UkvZcWbE/6Q0sa5IIkGtqA0WUFKLIN6WXn8W1yIQoiWY13pGTJYW4647Q7y74ez
	 LTPqPU12uTYDvMWT/IUxATTWM/HB/l9rpq/OjSKbXeF01JiWFXSr+9n9pH5RvLvGTSpzX
	 OxECSS8z/Pdva2aAf3EP7RAGQWWpwLSKx901XlnbPl5q+b05qIX3o41OgiHGVxt2uQ6hl
	 FO2U2T6Mzzf/nCDoQt8omhDlIwAkaGaJr3xtTFzqVWz1hlxD6oRq2pKHjDmYwv/HrpDi4
	 liFskIQu7rQW+iWWQeZTro+w0dMlez4yppI7+X4QXVADuyl5EU5/0+wV4b2Ot7wBWoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460492;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aDnrN/rnO8GTJvw/uGicHbUYV95/hlCAICtPYU2nHKk=;
	b=RZAPYybVX1BUTCSortI6fjOV6EF2DIL6nDqnMoRWnizry0jQTnBQs6++cGU4Ndq1/3t/
	 i2zLKAV1rtEbhNSyO/HXMJDVVnpIgj9Q6wrQ/3mi+gSu8XYAYophw8UKndfxLZ/xMv0rP
	 hKn1y5SaczaZN64s8eNd6GLRrOuN1KYMFI1P/lGNPGFyNb/skKIe+5Q3mWQbDoYQczkMm
	 tHqKHtnlUVTkwTt2U3vVql5SLe7v3aFNXnOMAvzXnBfhFR/fTCm/lL2uKnsIYyBliOtlL
	 i2x+mWsP1RliK3Oie3eAQZID1oEH7W2B8akoLjdB5Rda/EvdFEnj1wJnpn53Z0q3xPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEGECTr6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372B606A328;
	Tue, 20 Oct 2026 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEGECTr6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DF01F000C7;
	Tue, 20 Oct 2026 01:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460491;
	bh=aDnrN/rnO8GTJvw/uGicHbUYV95/hlCAICtPYU2nHKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OEGECTr6MHjApaNaS5+l2ymKg3u8HTBL/7GV3C5c5WJoQ8MW7IsR0A2qF4yZGzorC
	 dcK2MbWcgiTqwiZXIxc7HCCn47o/YGI+bvhRKoRgrU1TyJbODxLwZkp4uivelC9TvX
	 PIU0j4E0VOPC5RhEiFdCPTWwlvQVGe2wocxgB5UZ/9KmxYFYWOZMn9KfyNvUx758JN
	 MuWCjWiAAzBYtv+tf1opGvqVyzjvNx5tWyA2mFq9BHxZp/j4yHYqgujNuqM/j1YEJL
	 vUzs7/lj17u4rKMi3rjBdQGhfSLDK+t6h68T54F6H+CPwKMuj99U1bF70Um4foADHH
	 rHUW5sx9y+Yng==
Subject: Re: [PATCH net-next v6 8/9] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 01:41:30 +0000
Message-ID: <179246049030.3135.13023954288671040078@kernel.org>
In-Reply-To: <c43a5bf1-0cf9-4c68-b905-e9b615e2c9b2@yahoo.com>
References: <c43a5bf1-0cf9-4c68-b905-e9b615e2c9b2@yahoo.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rtl8365mb_conduit_state_change() never looks at its `conduit`
  argument.

--

net: dsa: realtek: rtl8365mb: re-latch the family D SerDes

On family D chips, this adds a delayed work item that repeatedly parks
and restores SDS_MISC. That drives the DISABLE -> HSGMII edge the SerDes
receiver needs in order to latch, and the work keeps checking the link
after that. Episodes start from ->conduit_state_change(), or from
pcs_config() when the conduit is already up, and stop when the conduit
goes down.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index a8e9220b217fd..a1155a75356da 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1670,8 +1774,184 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,

[ ... ]

> +	/* The re-latch edge has only been observed with HSGMII, so the work is
> +	 * only armed for 2500base-x. It starts once the conduit is up.
> +	 */
> +	if (is_d) {
> +		WRITE_ONCE(mb->sds_relatch_armed,
> +			   interface == PHY_INTERFACE_MODE_2500BASEX);
> +		/* With the conduit already up no conduit_state_change() will
> +		 * follow, so start the episode here.
> +		 */
> +		if (READ_ONCE(mb->sds_relatch_armed) &&
> +		    READ_ONCE(mb->sds_conduit_up))
> +			rtl8365mb_sds_relatch_start(mb);
> +	}
> +
> +	return 0;
> +}
> +
> +static void rtl8365mb_conduit_state_change(struct dsa_switch *ds,
> +					   const struct net_device *conduit,
> +					   bool operational)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct rtl8365mb *mb = priv->chip_data;
> +
> +	if (rtl8365mb_get_family(priv) != RTL8365MB_FAMILY_D)
> +		return;
> +
> +	guard(mutex)(&mb->sds_cfg_lock);
> +
> +	WRITE_ONCE(mb->sds_conduit_up, operational);
> +	cancel_delayed_work_sync(&mb->sds_relatch);
> +	if (operational && READ_ONCE(mb->sds_relatch_armed))
> +		rtl8365mb_sds_relatch_start(mb);
> +}

[Severity: Medium]
Should rtl8365mb_conduit_state_change() check which conduit the event is
for? It never uses the conduit argument. As a result, every conduit in
the tree overwrites the single sds_conduit_up flag, and each one cancels
or restarts the one SerDes work item.

dsa_switch_conduit_state_change() in net/dsa/switch.c passes on every
conduit's state without filtering:

    ds->ops->conduit_state_change(ds, info->conduit, info->operational);

rtl8365mb_setup() also accepts more than one CPU port:

    dsa_switch_for_each_cpu_port(dp, ds) {
        /* Use the first CPU port as trap_port */
        if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
            cpu->trap_port = dp->index;

The RTL8367S-VB, added later in the series, allows port 6 (EXT0, SerDes)
and port 7 (EXT1, RGMII) to both be CPU ports. Suppose the RGMII conduit
goes down while the SerDes conduit stays up. Would that cancel the
SerDes work and leave sds_conduit_up false? A SerDes that has not
latched yet, or that loses its link later, would then stay in the "link
up, no frames" state.

A later pcs_config() would not restart the work either, because it reads
the cached flag.

The reverse case looks affected too. If the RGMII conduit comes up while
the SerDes conduit is down, park/restore episodes would start against a
far end that is not running.

rtl8365mb_pcs_config() above raises a related question.
rtl8365mb_phylink_mac_select_pcs() returns the shared PCS for any port
in a SerDes mode:

    if (rtl8365mb_interface_is_serdes(interface))
        return &mb->pcs;

rtl8365mb_pcs_config() then sets sds_relatch_armed for any 2500base-x
user, with no dsa_port_is_cpu() check. Suppose port 6 is a 2500base-x
user port (SFP or 2.5G PHY). Could any CPU conduit coming up start an
episode on it?

If so, whenever that user link is down (after a cable pull, for
example), SDS_MISC would be parked for 20 ms every 1 s for 15 tries,
then every 10 s. The "did not latch" and "link lost outside a
reconfiguration" warnings would be logged each time.

Other implementers of this op filter on the conduit. For example,
qca8k_conduit_change() does:

    struct dsa_port *dp = conduit->dsa_ptr;
    ...
    if (dp->index != 0)
        return;

Would a similar check here, limited to the CPU port that owns the
SerDes, avoid both cases?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/5a4715dd-89e0-4868-9ffb-c8fb73b18d04%40yahoo.com

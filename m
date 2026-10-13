Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47B3A4F59;
	Tue, 13 Oct 2026 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853716; cv=none; b=jxSs3przVgueAamkwZzXCWZ3haEcg1s0RjdFRvB0etDVpTMCh+UCq9gJVVP1MUA7RHCP6ytserQ1CndA3d3k3VWUDZsqAiUFbSEToMjiHiyEfKzhkp6/bkj/FY8NS/5z0HD10jqfbfPXAOYtr+rBt7gPyigQu/jNve83OaQsUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853716; c=relaxed/simple;
	bh=GDjIBo5VBEU0oIHwP+zFo2x5pJTv902vPemu6Z3wNtE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQzZZ106EU4RJt59xwk11rsGmE7TbM0+Xk8tG38jfYV2B1345LprnRIQ1Klo6K1sHDozzh+UIKHGBZao6YdXo2V0wJWiQVAMdBwuEbLkOW+W9ySAb5eobzrMIogKsfDvj7ItjYyO522ARJEmtiag/A1td9PSA9tOYXb8TCcyEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjDJezbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjDJezbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552EB1F008A1;
	Tue, 13 Oct 2026 01:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791853715;
	bh=6W46Qv+h2+xyLIieHbcVBjmbwx96syXyne5aI/2OzfM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gjDJezbWwb1BklCgaf036MJqGgWf+fxXjl0cTyX8QIxUTFhm5wvc7sSTE+ohiTX0G
	 PrF/VUiXreyemylaWcgBR3w1VdvmcX4WxX5FUg6s64xVjrjYTtpyaPIwnaEJzyGt07
	 FbEn7GHwMM/1OFPLjDll4jM+FUslSgx9X3QQTKuhy98PgPUBoKIBrY59BkncMXYus+
	 w1N6VDtBQbs0VCyNY82L0ogos3U5Ei6DWfAUiKipCY7sF/J9KnCWqeCV5PRQ/gS+b9
	 LhDQFPkjhrq/o+M0V0p3FCnU0pwgPnhQzF97f6nw70h8zXL5UFgFWmIymhGjaFXW7z
	 ptlH7j9RPKeEA==
Subject: Re: [PATCH net-next v4 8/9] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 01:08:33 +0000
Message-ID: <179185371389.434549.2909566722698284726@kernel.org>
In-Reply-To: <98dbdca5-77c0-4027-aacc-4f97de5f3bb7@yahoo.com>
References: <98dbdca5-77c0-4027-aacc-4f97de5f3bb7@yahoo.com>
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

- [Medium] rtl8365mb_sds_relatch_work() relies on a lockless `if
  (!dev_get_drvdata(priv->dev)) return;` check at entry (line 1812), not…
- [Low] The comment on RTL8365MB_D_SDS_RESTORE_TRIES (lines 315-318) says
  a failed restore write "is retried this many times" (3).

--

net: dsa: realtek: rtl8365mb: re-latch the family D SerDes

On family D switches, this patch adds a delayed work item that keeps
re-driving the DISABLE -> HSGMII edge in SDS_MISC until the SerDes
receiver latches, then health-checks the link every 10 s. pcs_config()
starts the work for 2500base-x. pcs_config(), pcs_disable(), teardown()
and a devres action cancel it. A new sds_lock serializes the SDS_INDACS
indirect access sequences.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index d23e80f1d745d..bef95f91eea50 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -299,6 +300,28 @@
>  #define   RTL8365MB_SDS_MISC_SGMII_SPD_MASK		GENMASK(8, 7)
>  #define   RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK	BIT(6)
>  

[ ... ]

> +/* The SerDes stays parked until the restore write succeeds, so a failed
> + * write is retried this many times before giving up until the next run.
> + */
> +#define RTL8365MB_D_SDS_RESTORE_TRIES		3

[Severity: Low]
This isn't a bug, but does this comment match how the macro is used?
rtl8365mb_sds_relatch_restore() uses it as the total number of writes,
counting the first one:

	for (i = 0; i < RTL8365MB_D_SDS_RESTORE_TRIES; i++) {
		ret = regmap_update_bits(...);
		if (!ret)
			return 0;
		usleep_range(1000, 2000);
	}

So a failed first write gets two retries, not three. The loop also sleeps
1-2 ms after the last failed write before it gives up.

[ ... ]

> @@ -1669,8 +1725,192 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,

[ ... ]

> +static void rtl8365mb_sds_relatch_work(struct work_struct *work)
> +{
> +	struct rtl8365mb *mb = container_of(to_delayed_work(work),
> +					    struct rtl8365mb, sds_relatch);
> +	struct realtek_priv *priv = mb->priv;

[ ... ]

> +	/* rtl83xx_shutdown() clears the driver data and nothing stops the PCS
> +	 * then: do not touch the hardware or rearm after that.
> +	 */
> +	if (!dev_get_drvdata(priv->dev))
> +		return;

[Severity: Medium]
Is this check enough to keep the work away from the hardware after
shutdown?

rtl83xx_shutdown() clears the driver data with a plain store and never
cancels sds_relatch:

drivers/net/dsa/realtek/rtl83xx.c:rtl83xx_shutdown() {
	dsa_switch_shutdown(ds);

	dev_set_drvdata(priv->dev, NULL);
}

dsa_switch_shutdown() does not tear down the CPU port's phylink, so neither
rtl8365mb_pcs_disable() nor rtl8365mb_teardown() runs on this path.

Suppose a run passes the dev_get_drvdata() test just before the store. It
then reads SDS_MISC, runs the SDS_INDACS sequence under sds_lock, parks
SDS_MISC, sleeps 20 ms in usleep_range(), restores, and calls
schedule_delayed_work() again. All of that can happen after
rtl83xx_shutdown() has returned, while device_shutdown() moves on to the
parent MDIO/SMI bus device.

Closing the conduit in dsa_switch_shutdown() drops the trunk, so the work
is likely to take the park path at about that moment. If the reboot or
kexec lands in the middle of a park, could the SerDes stay in DISABLE
mode?

The commit message says:

  rtl83xx_shutdown() clears the driver data and nothing stops the PCS
  then, so the work does nothing once the driver data is gone

That seems true only for runs that start after the store. Would a
cancel_delayed_work_sync() of sds_relatch on the shutdown path be more
reliable than this lockless drvdata check?

[ ... ]

> +	usleep_range(20000, 21000);
> +
> +	if (rtl8365mb_sds_relatch_restore(mb)) {

[ ... ]

> +rearm:
> +	schedule_delayed_work(&mb->sds_relatch, delay);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/38872e6f-1264-4a93-9f81-8212173e909d%40yahoo.com

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18263E1203;
	Sat, 10 Oct 2026 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609275; cv=none; b=o+xa45FkV9DxE0IRmYbJKtWWWvQp8NfGgiFJXWOe7BQ4uClxjAGDkXkX7cm/rC7TzwCywzrxoOwULQXaF7BsPFPvLqmlLeFauy+hc89FrQ9RZfKiONKirikE24uy38mx/V+Yo2kDKP6NWRgtfxBa3h2UbE5knjOLVxhFJRkTUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609275; c=relaxed/simple;
	bh=pN9t2PDFcay+swSFhK9WSQCtKQZomMLgkPsruGN8dOI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HnNMY/JPb+Wdhmqb1h9q6s8ZUeoPABUHF1420Zv4mLw00XkE39j1JDMsiQkSHSQA9++BKGdio7zCEJoKrOv9m2C2WC+NCMtx/B+9EDfapHuvNXPwJg76zQxSK2IB6fDuMh4Lw16x3TD7j+NogBtPVhvv2LK2pdWyjJ9aOjjmK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YANM/1Pz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YANM/1Pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A33F1F00893;
	Sat, 10 Oct 2026 05:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791609262;
	bh=XEDncQJ2vAr3ongMM47iV3oJ8k6OD6imbwFP96rj22w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YANM/1PzHrnW16XezCJ2MHl86pwCoKbBeCMGdUE8ltYm1ff3d81uQS8VDOk2pM/ci
	 JEOxSv2p/1pHB3b2MZjNH0+vy5DXV08DplE9v2ZFjAjJ/vI4omzJ6HZsYF9qRcQM5H
	 hgHSfP+UCaC+wnDWP3TMFdDbyrSfS+3I9L2Z/lYBd63plCFFEYX7j0Xi8kN4NsKZE6
	 BTgy6JXNRSP6zeM461Al6iR0N9wV9/V98LqRgwEZo8eKKdPkgNjKo6Z2Skp3VMQ8RB
	 7JEZRQq4Jn9201x4vtP43LWRkpkfXmjVY4r4B4o4QZ/T+RhAWr1LlqTS/HeUFcMRpj
	 oGtgjd8cyGiRw==
Subject: Re: [PATCH net-next v2 8/8] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 05:14:20 +0000
Message-ID: <179160926094.434549.13782287411357981619@kernel.org>
In-Reply-To: <af4b65e2-0fd0-4bb7-b34b-d64ec0f91955@yahoo.com>
References: <af4b65e2-0fd0-4bb7-b34b-d64ec0f91955@yahoo.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Nothing ties the lifetime or scope of the family D sds_relatch
  work to phylink.
- [Medium] The shutdown path never cancels sds_relatch.
- [Low] Two statements in the commit message do not match the code.
- [Low] Series ordering: the family D SerDes PCS support added by the
  previous commit in this series ('net: dsa: realtek: rtl8365mb: add…
- [Low] If the park write in rtl8365mb_sds_relatch_work() succeeds but
  the restore write fails, the SDS_MISC mode field is left at DISABLE…

--

net: dsa: realtek: rtl8365mb: re-latch the family D SerDes

This patch adds a delayed work for family D chips. The work drives
DISABLE -> mode edges on SDS_MISC until the SerDes receiver latches, then
re-checks the link every 10 seconds, re-arming itself each time. It also
adds an sds_lock mutex around the SDS_INDACS indirect access window and the
SDS_MISC accesses, and cancels the work in pcs_config() and teardown().

> The family D receiver latches on the DISABLE -> HSGMII edge in SDS_MISC
> rather than on the value, and it will not latch until the MAC at the
> other end of the trunk has brought its own half of the link up. If it
> does not latch, the trunk reports 2.5Gbps/Full on both sides but moves
> no frames: the CPU MAC transmits, the switch CPU port counts no octets,
> and there are no CRC, alignment or FIFO errors.

[Severity: Low]
Does this mean the previous patch in the series ("net: dsa: realtek:
rtl8365mb: add family D SDS13 PCS support") leaves a family D 2500base-x
CPU trunk that reports link up but passes no frames?

Family D support is new in this series, so this is not a regression of
existing behaviour. However, a bisect that lands between the two commits
would get a non-working CPU port on family D boards.

Could the two be folded together, or could the dependency at least be
mentioned in the commit message?

[ ... ]

> Each attempt (park for 20 ms, then restore the target mode) is
> performed by a short work: sleeping is not permitted in the PCS ops,
> and the work also serializes against pcs_config() re-runs, which
> cancel it.

[ ... ]

> The work now accesses the shared SDS_INDACS ADR/CMD/DATA window and
> SDS_MISC concurrently with the PCS and MAC link_up paths and
> pcs_get_state(), so those accesses are serialized by a new sds_lock.

[Severity: Low]
Are these two statements accurate?

PCS ops run in sleepable process context under phylink's state_mutex.
rtl8365mb_pcs_config() already sleeps in its regmap I/O and in the
regmap_read_poll_timeout() in rtl8365mb_sds_read(). This patch also adds
cancel_delayed_work_sync() and mutex_lock() calls to pcs_config(). The
real reason for the work item looks like the need to keep retrying for
seconds after pcs_config() returns.

On family D, rtl8365mb_pcs_link_up() returns before it touches SDS_MISC:

	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
		return;

The SDS_MISC update in rtl8365mb_phylink_mac_link_up() is guarded by:

	if (rtl8365mb_interface_is_serdes(interface) &&
	    rtl8365mb_get_family(priv) != RTL8365MB_FAMILY_D) {

The SDS_MISC read in rtl8365mb_pcs_get_state() comes after the is_d early
return. All three accesses therefore run only on family C, where the work
is never initialised.

Only the SDS_INDACS window and the pcs_config() SDS_MISC update are shared
with the work. Could the commit message say that instead?

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 4cad90f5c0181..eb71c89945c16 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1669,8 +1722,140 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	val &= ~RTL8365MB_SDS_NWAY_EN_MASK;
>  	val |= RTL8365MB_SDS_NWAY_RESTART_MASK;
>  
> -	return rtl8365mb_sds_write(priv, sds_index,
> -				   RTL8365MB_SDS_REG_NWAY, val);
> +	ret = rtl8365mb_sds_write(priv, sds_index,
> +				  RTL8365MB_SDS_REG_NWAY, val);
> +	if (ret)
> +		return ret;
> +
> +	if (is_d) {
> +		/* Start a new re-latch episode and kick off the first attempt;
> +		 * see rtl8365mb_sds_relatch_work() for why this cannot wait
> +		 * for phylink to ask again.
> +		 */
> +		WRITE_ONCE(mb->sds_relatch_count, 1);
> +		schedule_delayed_work(&mb->sds_relatch, 0);
> +	}

[Severity: Medium]
Is the lifetime of this work tied to phylink in any way?

The work is scheduled for every family D SerDes pcs_config(), whatever the
interface (SGMII or 2500base-x) and neg_mode.
rtl8365mb_phylink_mac_config() accepts both MLO_AN_PHY and MLO_AN_FIXED.
Once started, the work re-arms itself on every exit through the rearm
label.

Only the next pcs_config() or rtl8365mb_teardown() cancels it.
rtl8365mb_pcs_ops has no .pcs_disable, so the phylink_pcs_disable() call
in phylink_stop() (and in phylink_major_config() when the PCS changes) has
no effect here. rtl8365mb_phylink_mac_link_down() only cancels
p->mib_work.

As an example, take a family D SerDes port wired as a user port to an
SGMII PHY, and set the port down. Would the work then keep reading the SDS
link status and log "SerDes link lost outside a reconfiguration"? It would
then park SDS_MISC for 20 ms every second for 15 seconds, log "SerDes did
not latch", and park every 10 seconds for as long as the port stays down.

The comment above rtl8365mb_sds_relatch_work() refers to "this fixed-link
port", and the work itself says "nothing re-runs pcs_config() for a
fixed-link port". Nothing in the code checks for a fixed link, though. The
commit message also only justifies the DISABLE -> mode edge for HSGMII on
a fixed-link CPU trunk.

Is the same behaviour correct for SGMII and for PHY-mode ports? Should the
work also be stopped from a .pcs_disable callback or from the link-down
path?

[ ... ]

> +	mutex_lock(&mb->sds_lock);
> +	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
> +				 RTL8365MB_D_SDS_MISC_CFG_MASK, park);
> +	mutex_unlock(&mb->sds_lock);
> +	if (ret) {
> +		dev_err_ratelimited(priv->dev,
> +				    "failed to park SDS_MISC: %pe\n",
> +				    ERR_PTR(ret));
> +		goto rearm;
> +	}
> +
> +	usleep_range(20000, 21000);
> +
> +	mutex_lock(&mb->sds_lock);
> +	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
> +				 RTL8365MB_D_SDS_MISC_CFG_MASK,
> +				 READ_ONCE(mb->sds_misc_target_val));
> +	mutex_unlock(&mb->sds_lock);
> +	if (ret) {
> +		dev_err_ratelimited(priv->dev,
> +				    "failed to restore SDS_MISC: %pe\n",
> +				    ERR_PTR(ret));
> +		goto rearm;
> +	}

[Severity: Low]
If the park write succeeds but this restore write fails, is the SDS_MISC
mode field left at DISABLE with nothing recording that?

The next run reads the link status bit and sees 0, because the SerDes is
disabled. It treats that as the far end not being up yet. If the failure
happened on the last in-budget attempt, the next run is the report-only
pass:

	} else if (attempts == RTL8365MB_D_SDS_RELATCH_MAX_TRIES + 1) {
		WRITE_ONCE(mb->sds_relatch_count, attempts + 1);
		dev_warn(priv->dev,
			 "SerDes did not latch after %u re-latch attempts; ...
		delay = RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL;
		goto rearm;
	}

That pass does not write SDS_MISC. The SerDes would then stay disabled for
about 11 seconds, and the log message would blame the far end.

If rtl8365mb_teardown() cancels the work in this window, nothing restores
the target mode at all.

Would it make sense to retry the restore here, or re-arm with a short
delay?

[ ... ]

> @@ -3514,6 +3709,10 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>  static void rtl8365mb_teardown(struct dsa_switch *ds)
>  {
>  	struct realtek_priv *priv = ds->priv;
> +	struct rtl8365mb *mb = priv->chip_data;
> +
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
> +		cancel_delayed_work_sync(&mb->sds_relatch);
>  
>  	rtl8365mb_stats_teardown(priv);
>  	rtl8365mb_irq_teardown(priv);

[Severity: Medium]
Is this the only place the work gets cancelled at end of life?

Once pcs_config() has run, the work always re-arms itself. The .shutdown
path never reaches rtl8365mb_teardown():

realtek_{mdio,smi}_shutdown()
  rtl83xx_shutdown()
    dsa_switch_shutdown(ds);
    dev_set_drvdata(priv->dev, NULL);

dsa_switch_shutdown() only closes the conduits and unlinks the uppers. It
does not call ds->ops->teardown. Because drvdata has been cleared, a later
realtek_mdio_remove() returns early:

	if (!priv)
		return;

The rtl83xx_shutdown() kernel-doc says this can happen if the parent bus
implements its own .shutdown() as .remove(). In that case devres frees
priv while sds_relatch is still armed. mb is freed with it, because
rtl83xx_probe() allocates chip_data in the same devm_kzalloc() block, and
sds_lock is devm_mutex_init()'d.

Can the next run of rtl8365mb_sds_relatch_work() then dereference the
freed mb->priv, mb->sds_lock and priv->map?

Even without an unbind, the work keeps issuing SDS reads and SDS_MISC
park/restore writes over MDIO/SMI after the switch has been shut down for
reboot.

The CPU port mib_work already has the same gap at shutdown. This patch
adds a second work that re-arms itself indefinitely and also writes
hardware state.

Should the shutdown path cancel sds_relatch as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/28382f3f-03c1-4606-9b11-86f118abeafe%40yahoo.com

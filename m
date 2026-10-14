Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1203347505;
	Wed, 14 Oct 2026 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968209; cv=none; b=CFhg+TD+Bk2tl2BW7K1uP6Id4V8ieZdkET3G8oZSpdZE/GUilZgIViyXnVfSt9oEWuvoABYPzYa2o+jWKfqACKVJOL4As2QeF3sYJ5WZsB1YtDTu9VQjlaDx4p1i7rBRpNloRWL1zEhfFIqCtvXRUmIOhXFqOhSHOwTXV2PMD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968209; c=relaxed/simple;
	bh=LBSNmn5VzcC+iiVyp54xgShuPUu1Fxla9UHRTvutsTU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqMP7wdewr+QJ61TqAhaVkbSDIkkN4GuwYl4T31m/AtEhoIY83CrrNjoZZ7IajNRFzILCIH+kyTfNZoGUyeBKAHTD6mNTxp5KgSH+gzD3TnQVWWWKY89LXV8H1s4+KVt9lSr1s32fvxyylwKINV5yhxKqfXEIbnspxqFrnu1tSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGzYIXwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGzYIXwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37811F000FF;
	Wed, 14 Oct 2026 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968207;
	bh=KPiabNci/24EDrKNj5eeZxk3isds/cz8glHFZ7wRBTE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MGzYIXwjuQQAv/IHLuVIZFRXPjAUqufJy42WePxz5jwRKm1/pSFQTVRcGLcq6zOEC
	 6dEOU1DndDzfRr9EWmEOTyjhIzNfJ+PsyF7hQrDCmU+ubqGzG8Y3/6ZalrVB988JnO
	 OIroZWITP+qmuCmQYpkToG/WgWXPUj41MhbW6esrtqQBdb9njZh6sI2mc2qqD7Gqxg
	 B3DU83kHMWS+YATNo5WutKvFEjpPjNRFxp4uvWrqDaHC9OSmN0pXcuc4RRfyCf5WYT
	 OPkw6FptwBzsc+Q3ytELI5Ny6X3hT/4zE6WeS/2vC9s240Qtpsr7M5DgWJKzVvKT6A
	 4PxgqLC4jWyVA==
Subject: Re: [PATCH net-next v5 8/9] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 08:56:46 +0000
Message-ID: <179196820621.434549.550722901550345028@kernel.org>
In-Reply-To: <dafd0519-0659-4898-8a6e-7121b5c4bf78@yahoo.com>
References: <dafd0519-0659-4898-8a6e-7121b5c4bf78@yahoo.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message (and the comment above
  rtl8365mb_sds_relatch_work()) gives two reasons for the blind design.
- [Low] At this commit no rtl8365mb_chip_infos entry uses
  RTL8365MB_FAMILY_D.
- [Low] The comment in rtl8365mb_sds_reboot_notify() says:
  "cancel_delayed_work_sync() waits for a running pass, so the SerDes is…
- [Low] The concern is that rtl8365mb_sds_reboot_notify(), pcs_disable()
  and teardown() use cancel_delayed_work_sync() instead of…

--

net: dsa: realtek: rtl8365mb: re-latch the family D SerDes

This adds a delayed work item for family D chips. The work parks SDS_MISC
and then restores the HSGMII mode, so the SerDes receiver sees a DISABLE ->
mode edge after the far-end MAC has come up. Each episode starts from
pcs_config() and drives up to 15 edges about 1 s apart, then falls back to
a 10 s health check, with a new sds_lock serializing the SDS_INDACS window.

> The two ends can be seconds apart, e.g. on an IPQ5018 board:
>
>   5.27  rtl8365mb: configuring for fixed/2500base-x   <- pcs_config()
>   7.72  ipq5018-gmac-dwmac eth0: configuring for fixed/2500base-x
>   8.02  ipq5018-gmac-dwmac eth0: Link is Up - 2.5Gbps/Full
>   8.56  SerDes latches

[Severity: Low]
This isn't a bug, but at this commit no entry in rtl8365mb_chip_infos[]
uses RTL8365MB_FAMILY_D. All entries have chip_id 0x6367. None of the
re-latch code can run until the later "add support for RTL8367S-VB" patch
adds the 0x6642 entry.

The sibling patches in the series ("set RGMII mode for family D", "set and
get vlan 4k for family D", "add family D SDS13 PCS support") each say that
the family D paths are unreachable until the last patch.

This commit message describes a live failure with board logs. Could it
include the same note?

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 6c51f4805b595..238a3fa765e97 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1683,8 +1742,187 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
> +	/* The re-latch edge has only been observed with HSGMII, so the work is
> +	 * only started for 2500base-x. Start a new episode and kick off the
> +	 * first attempt; see rtl8365mb_sds_relatch_work() for why this cannot
> +	 * wait for phylink to ask again.
> +	 */
> +	if (is_d && interface == PHY_INTERFACE_MODE_2500BASEX) {
> +		WRITE_ONCE(mb->sds_relatch_count, 1);
> +		schedule_delayed_work(&mb->sds_relatch, 0);
> +	}

[Severity: Medium]
Should the re-latch episode start from pcs_config()? The design rests on
two statements in the commit message:

  There is no local signal that predicts when the far-end MAC will
  bring up its half of the link [...]
  Nothing external re-checks this later.

For the CPU trunk, struct dsa_switch_ops already has a hook for this:

include/net/dsa.h:
	void	(*conduit_state_change)(struct dsa_switch *ds,
					const struct net_device *conduit,
					bool operational);

dsa_tree_conduit_admin_state_change() and
dsa_tree_conduit_oper_state_change() call this hook when the conduit
becomes admin-up and netif_oper_up(). That is the "8.02 eth0: Link is Up"
line in the log above.

The budget is counted from pcs_config() at switch setup. What happens if
userspace, or the first user port open, brings the conduit up more than
about 15 s after probe?

All 15 fast edges would go to a far end that is not up yet. The
MAX_TRIES + 1 run in rtl8365mb_sds_relatch_work() would then print
"SerDes did not latch after 15 re-latch attempts". After that, an edge is
driven only once per RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL.

When the conduit does come up, could the CPU port report 2.5Gbps/Full and
still pass no frames for up to 10 s? That does not fit the comment above
RTL8365MB_D_SDS_RELATCH_INTERVAL, which says the budget is "generous
enough to outlast a slow conduit".

Conduit admin-down has a similar problem if the far-end MAC drops its
SerDes. The !attempts branch would print "SerDes link lost outside a
reconfiguration" and run another 15 parks. It would then warn again and
park every 10 s until the conduit comes back.

The CPU port's phylink is not stopped on conduit down, so
rtl8365mb_pcs_disable() does not cancel the work in that case.

Could the episode be started from conduit_state_change() instead? That
would avoid the misleading warnings and the delay of up to 10 s before
recovery.

[ ... ]

> @@ -3580,6 +3831,21 @@ static int rtl8365mb_get_chip_id_and_ver(struct regmap *map, u32 *id, u32 *ver)
>  	return 0;
>  }
>  
> +static int rtl8365mb_sds_reboot_notify(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct rtl8365mb *mb = container_of(nb, struct rtl8365mb,
> +					    sds_reboot_nb);
> +
> +	/* Runs before device_shutdown() on reboot, halt, power off and kexec.
> +	 * cancel_delayed_work_sync() waits for a running pass, so the SerDes
> +	 * is not left parked and the bus is not touched while it is shut down.
> +	 */

[Severity: Low]
Does "the SerDes is not left parked" still hold when the restore fails?

In rtl8365mb_sds_relatch_work(), the lane is parked first. If
rtl8365mb_sds_relatch_restore() then fails all
RTL8365MB_D_SDS_RESTORE_TRIES writes, the lane stays in DISABLE, and only
the next run can put it back:

	if (rtl8365mb_sds_relatch_restore(mb)) {
		...
		delay = RTL8365MB_D_SDS_RELATCH_INTERVAL;
		goto rearm;
	}
	...
rearm:
	schedule_delayed_work(&mb->sds_relatch, delay);

cancel_delayed_work_sync() goes through __cancel_work_sync(), which calls
__cancel_work(work, cflags | WORK_CANCEL_DISABLE). The work is disabled
during the cancel, so the running pass's schedule_delayed_work() is
dropped. No later run restores the mode.

The same is true for the cancels in pcs_disable(), teardown() and the
devres action.

This takes three regmap failures in a row, and the next probe or
pcs_config() rewrites SDS_MISC. Would it be enough to just correct the
comment?

> +	cancel_delayed_work_sync(&mb->sds_relatch);

[Severity: Low]
This isn't a bug, but would disable_delayed_work_sync() be more robust in
the reboot notifier?

After the notifier runs, cancel_delayed_work_sync() does not stop
rtl8365mb_pcs_config() from calling schedule_delayed_work() again.

I couldn't find a concrete path where that happens for the fixed-link CPU
port. For a user port on the SerDes, dsa_switch_shutdown() closes the user
ports first. phylink_stop() then calls rtl8365mb_pcs_disable() again before
the parent bus shuts down. So this would only be hardening.

> +
> +	return NOTIFY_DONE;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4%40yahoo.com

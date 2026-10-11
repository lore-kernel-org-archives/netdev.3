Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800946A5EE;
	Sun, 11 Oct 2026 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748291; cv=none; b=iIg22ZKYqEUEDvdjhVzJZLLu5rs8uuYDYB6F+Ol9b3nf9z+PfabNLRWoKFbygUJMkR20c6wLBkr6JDnUW6RGA1l5LEPyDycb5MhvwkVWRF6FNdXjYCRaeCAfllDuVeHogXX5RSDmpe00VMzfnINEiNKc3x54WM73wUPChTxhGvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748291; c=relaxed/simple;
	bh=LWGFFLMzH4Tq1IvVlyZYgPCu6rZTl5Iwao5LYb1K3LM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fywRowTplE8w2jSmvNPzlHWuvk3k0QVyx6W0+WnzGDZyiSGnACU8xrQZ9OqwGBm7kkRV46/kWmSsBP2zVg+D8+sWxhiVDgBGJTfk8lyVCOHYEqLe7zZsOL8YprVJdfTn7o+w5afdAMEMK2s8+jWrtiIQK1Z6y5dyphSI1NCUZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6WJgTfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6WJgTfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1CB1F0089C;
	Sun, 11 Oct 2026 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748290;
	bh=LSzBBRhwJ2EDIMclyQ5S4WmZQ6fXpN2gz8ECmGPSNPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F6WJgTfPyQBLmI5ERgEIFAFu212E4ovKOF62IDSuyN6hxovdYxUVz9Og5EddjENJs
	 DDN+Qt68pPe80puwzeT1wb/6V60YBbHu82hYt14Mfcwg1C01l107/ajGcQLETBuBP/
	 MVsIse0+usOH5eB+epWFagO3dh70zzW7Us0aJ0A4k/UUqw/Cz94kWXFBEfyw2COBHN
	 nMKjuve4W+PeZLTgKZuXk2aLK1aK2XXSuDXnBGK9LO5Ou7VPV9xzNzvEr6exsGYnZt
	 4UeqJmY7DYmxPlyeQbyA74YEaQ4+gIPYyJicefryDzdPf9Zd7h7FGHY6fLpdU99yCU
	 0FMsnoKZXOlOw==
Subject: Re: [PATCH net-next v3 8/9] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 19:51:29 +0000
Message-ID: <179174828906.434549.1964597270204409308@kernel.org>
In-Reply-To: <2a637a34-6d4f-4a07-88b5-04475ebbba2e@yahoo.com>
References: <2a637a34-6d4f-4a07-88b5-04475ebbba2e@yahoo.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The re-latch work can leave the family D SerDes parked
  (SDS_MISC mode field = RTL8365MB_D_PORT_SDS_MODE_DISABLE) for about 11…
- [Medium] The family D re-latch work rearms itself forever and is not
  stopped on system shutdown or reboot.

--

net: dsa: realtek: rtl8365mb: re-latch the family D SerDes

This commit adds a self-rearming delayed work for family D chips. The
work parks SDS_MISC in DISABLE mode and then restores it, which drives a
DISABLE -> HSGMII edge until the SerDes receiver latches. After that it
checks the link every 10 s.

It also adds sds_lock to serialize the SDS_INDACS indirect access
sequences. The work is cancelled from pcs_config(), pcs_disable(),
teardown() and a devres action.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 0d3a2a385a204..5d804099f131a 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1658,8 +1714,155 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,

[ ... ]

> +static void rtl8365mb_sds_relatch_work(struct work_struct *work)
> +{

[ ... ]

> +	ret = rtl8365mb_sds_read(priv, RTL8365MB_D_SDS_EXT0_INDEX,
> +				 RTL8365MB_SDS_REG_LINK_STATUS, &status);
> +	if (ret) {
> +		dev_err_ratelimited(priv->dev,
> +				    "failed to read SerDes link status: %pe\n",
> +				    ERR_PTR(ret));
> +		goto rearm;
> +	}

[ ... ]

> +	attempts = READ_ONCE(mb->sds_relatch_count);
> +	if (!attempts) {
> +		dev_warn(priv->dev,
> +			 "SerDes link lost outside a reconfiguration; re-latching\n");
> +		attempts = 1;
> +	} else if (attempts == RTL8365MB_D_SDS_RELATCH_MAX_TRIES + 1) {
> +		/* This run only checked whether the last in-budget edge
> +		 * took. The first out-of-budget edge comes one healthcheck
> +		 * interval from now, not on this pass.
> +		 */
> +		WRITE_ONCE(mb->sds_relatch_count, attempts + 1);
> +		dev_warn(priv->dev,
> +			 "SerDes did not latch after %u re-latch attempts; still retrying every %d s\n",
> +			 RTL8365MB_D_SDS_RELATCH_MAX_TRIES,
> +			 RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL / HZ);
> +		delay = RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL;
> +		goto rearm;
> +	}
> +
> +	if (attempts <= RTL8365MB_D_SDS_RELATCH_MAX_TRIES)
> +		WRITE_ONCE(mb->sds_relatch_count, attempts + 1);

[ ... ]

> +	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
> +				 RTL8365MB_D_SDS_MISC_CFG_MASK, park);
> +	if (ret) {
> +		dev_err_ratelimited(priv->dev,
> +				    "failed to park SDS_MISC: %pe\n",
> +				    ERR_PTR(ret));
> +		goto rearm;
> +	}
> +
> +	usleep_range(20000, 21000);
> +
> +	for (i = 0; i < RTL8365MB_D_SDS_RESTORE_TRIES; i++) {
> +		ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
> +					 RTL8365MB_D_SDS_MISC_CFG_MASK,
> +					 READ_ONCE(mb->sds_misc_target_val));
> +		if (!ret)
> +			break;
> +		usleep_range(1000, 2000);
> +	}
> +	if (ret) {
> +		dev_err_ratelimited(priv->dev,
> +				    "failed to restore SDS_MISC: %pe\n",
> +				    ERR_PTR(ret));
> +		/* The SerDes is left parked: come back soon rather than
> +		 * at the (possibly 10 s) pace chosen above.
> +		 */
> +		delay = RTL8365MB_D_SDS_RELATCH_INTERVAL;
> +		goto rearm;
> +	}

[Severity: Medium]
Can the SerDes stay parked for about 11 s here, instead of the ~1 s this
branch asks for? Consider the case where all RTL8365MB_D_SDS_RESTORE_TRIES
restore writes fail on the last in-budget attempt (attempts == 15):

attempt 15:
  WRITE_ONCE(mb->sds_relatch_count, 16)
  park write succeeds
  all three restore regmap_update_bits() calls fail
  delay = RTL8365MB_D_SDS_RELATCH_INTERVAL; goto rearm

next run, 1 s later:
  link bit is clear, because the lane is still in MODE_DISABLE
  attempts == RTL8365MB_D_SDS_RELATCH_MAX_TRIES + 1
    sds_relatch_count = 17
    "SerDes did not latch after 15 re-latch attempts"
    delay = RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL; goto rearm

The report-only pass never writes sds_misc_target_val back to SDS_MISC.
The mode is restored only on the run after that, 10 s later. The CPU
trunk stays in DISABLE mode for that whole window, and the warning
describes an edge that was never completed.

There is a related gap in the link status read failure path above. If an
earlier run left the lane parked and rtl8365mb_sds_read() then fails, the
work jumps straight to rearm. It does not try the direct SDS_MISC
restore, even though that restore does not go through SDS_INDACS.

Could the work record that a restore is still outstanding, and retry the
restore first on the next run, before the link check and the report-only
branch?

> +
> +	dev_dbg(priv->dev, "SerDes re-latch edge driven (attempt %u)\n",
> +		attempts);
> +
> +	/* This edge may not have taken either; the next run checks. */
> +rearm:
> +	schedule_delayed_work(&mb->sds_relatch, delay);
> +}

[Severity: Medium]
Every path in rtl8365mb_sds_relatch_work() ends here, so the work rearms
until something cancels it. What stops it on reboot or kexec?

The .shutdown path goes through rtl83xx_shutdown():

drivers/net/dsa/realtek/rtl83xx.c:rtl83xx_shutdown() {
	struct dsa_switch *ds = &priv->ds;

	dsa_switch_shutdown(ds);

	dev_set_drvdata(priv->dev, NULL);
}

Clearing drvdata stops realtek_{smi,mdio}_remove() from running. That
means neither rtl8365mb_teardown() nor the rtl8365mb_sds_relatch_cancel()
devres action runs.

dsa_switch_shutdown() closes the conduits and unlinks the user netdevs.
It does not stop the CPU port's phylink, so rtl8365mb_pcs_disable() is
not called either.

After shutdown, couldn't the work keep issuing SDS_INDACS reads and
SDS_MISC park/restore writes over MDIO/SMI? That would happen while the
parent bus controller is shutting down, and it could leave the SerDes
parked for a kexec'd kernel. Every reboot of a family D board would hit
this once the RTL8367S-VB support later in the series is applied.

The commit message says the cancellations are there:

    so that it never outlives the PCS or the driver data.

Should the work also be cancelled on the shutdown path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/e84d76ee-03df-49b0-8c9a-b289dfae8728%40yahoo.com

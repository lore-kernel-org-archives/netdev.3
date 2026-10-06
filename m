Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99856379993;
	Tue,  6 Oct 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294208; cv=none; b=MBHv9WFQNE3BezV0wEeAGT+M4DB8Uem3sq/MEhElnbr1BaTfZk9iA7MDTIghDE5q/EOG4crRUHyLCaDj2ZYGrO9nUO9zuWWAx4QPgOgGSFbWsFu6gfsdS3vUqZn4fSS0Vk3sx8CMaWTj5C0qVmDg2daju2ZA8uAgcsob4wiMzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294208; c=relaxed/simple;
	bh=bxhCmUtuP2znEB3DfJeUXBMtkcnBZ/7H0150E8PemBc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bKo7OW9ndQ8sZSdeZzUndx5gx80ZApmaQ+SYplw/kYFDNqtFGbPXII0mOqikL1yEE5P6UcWJ0tIe9f8HwUoMYJyYBElpXKp4SfuF9IshCtqnjEmlr88lbLZOpQlcQUoZ4fscfwb98fU1/9vqd/EyQhlR5A/qLs8NEfbfZNQPomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeDPcBh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeDPcBh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603311F000FF;
	Tue,  6 Oct 2026 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791294207;
	bh=cYJrRs4VKwbkJF1Q6VKMuLhIAKjhpZO7YZGJq30E2rw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AeDPcBh0BBowrsQUskYEh5bbN83gPxtq4JxCMJMS/Li5SddfEQ5uUxPhSWAFRu68W
	 4/5nU7u1Nrc9D5fMhDzWnSVVo/g0VMCAYNJLVHxOVprFuBbXUM4As3RAp5UpDMwi5o
	 hl1zOO4tLU2GYP8TPxbs9skfLUFg2vR9qwyvJQtiJygYQDd1j0XY6xL3yndvicXotY
	 76GxSFqAKdgYo2XtaZZiX2BduidNfz9Q0byUz+vw+QfqccdrDQaec55MZNaCdsKqEQ
	 fW3rTxu9PHT75DhUIxqhLBYnmsEPAE5ch85QLIFfrx/SwxtIhNXFo6vVT7+oFN3ZfJ
	 C/tiPodh7mj+Q==
Subject: Re: [PATCH net-next v1 7/8] net: dsa: realtek: rtl8365mb: offload DCB
 apptrust
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: linusw@kernel.org, luizluca@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, alvin.sipraga@analog.com,
 netdev@vger.kernel.org, horms@kernel.org
Date: Tue, 06 Oct 2026 13:43:25 +0000
Message-ID: <179129420591.434549.1307051695175527426@kernel.org>
In-Reply-To: <20261002115850.962676-8-o.rempel@pengutronix.de>
References: <20261002115850.962676-8-o.rempel@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] At this commit, rtl8365mb_port_set_apptrust() accepts
  IEEE_8021QAZ_APP_SEL_DSCP (listed in rtl8365mb_apptrust_map[]).
- [Low] If a register access fails partway through
  rtl8365mb_port_set_apptrust(), the switch-wide trusted decision table…

--

net: dsa: realtek: rtl8365mb: offload DCB apptrust

This commit wires up port_get_apptrust/port_set_apptrust for rtl8365mb.
It programs a second, switch-wide "trusted" priority-decision table with
PCP and/or DSCP weights and steers ports to it with a per-port select
bit. Precedence is fixed to PCP > DSCP, and a request that conflicts
with the selectors another port already uses is refused with -EBUSY.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_dcb.c b/drivers/net/dsa/realtek/rtl8365mb_dcb.c
> index f48e95ef3947a..4afcae6e85a1e 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_dcb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_dcb.c

[ ... ]

> @@ -84,6 +88,24 @@ static_assert(RTL8365MB_NUM_IPMS == IEEE8021Q_TT_MAX);
>  #define RTL8365MB_QOS_WEIGHT_UNTRUSTED			0
>  #define RTL8365MB_QOS_WEIGHT_PORT			1
>  
> +/* apptrust selectors this driver supports, in descending precedence. Each
> + * entry binds a dcbnl selector to the priority-decision source it enables, so
> + * this ordered table is the one place the fixed precedence lives.
> + */
> +static const struct rtl8365mb_apptrust_map {
> +	u8 sel;		/* dcbnl apptrust selector */
> +	u8 src;		/* priority-decision source it enables */
> +} rtl8365mb_apptrust_map[] = {
> +	{ DCB_APP_SEL_PCP,	     RTL8365MB_QOS_PRIDEC_1Q },
> +	{ IEEE_8021QAZ_APP_SEL_DSCP, RTL8365MB_QOS_PRIDEC_DSCP },
> +};

[Severity: Low]
Is DSCP trust usable yet at this point in the series?

rtl8365mb_port_set_apptrust() accepts IEEE_8021QAZ_APP_SEL_DSCP. It
writes a DSCP weight of 2 into the trusted table, which outranks the
port default weight of 1.

However, rtl8365mb_dcb_init() only programs the queue map, the PCP
remap and the decision weights. The DSCP-to-internal-priority table
keeps whatever the chip reset or the bootloader left there.
rtl8365mb_switch_ops also has no port_get/add/del_dscp_prio ops yet.

After "dcb apptrust set dev swpN order dscp", wouldn't IP traffic on
that port be classified by a DSCP table that was never programmed, and
that dcbnl has no way to change?

The next patch in the series, "net: dsa: realtek: rtl8365mb: offload
DCB DSCP-to-priority", seems to fix this. It adds
rtl8365mb_qos_setup_dscp() to rtl8365mb_dcb_init(), which seeds all 64
entries from ietf_dscp_to_ieee8021q_tt(). It also adds the dscp_prio
ops and sets ds->dscp_prio_mapping_is_global. So the problem only shows
up when a bisect stops exactly at this commit.

Could the patches be reordered, or could DSCP be left out of
rtl8365mb_apptrust_map[] until the DSCP map is programmed?

[ ... ]

> @@ -285,3 +323,158 @@ int rtl8365mb_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)

[ ... ]

> +int rtl8365mb_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
> +				int nsel)
> +{

[ ... ]

> +	/* The trusted table is a single switch-wide resource. If another port
> +	 * already uses it, this request must trust the same selectors.
> +	 */
> +	if (idx & ~BIT(port)) {

[ ... ]

> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(rtl8365mb_apptrust_map); i++) {
> +		u8 weight = trust[i] ? rtl8365mb_apptrust_weight(i) :
> +				       RTL8365MB_QOS_WEIGHT_UNTRUSTED;
> +
> +		ret = rtl8365mb_qos_set_pridec(priv,
> +					       RTL8365MB_QOS_PRIDEC_TABLE_TRUSTED,
> +					       rtl8365mb_apptrust_map[i].src,
> +					       weight);
> +		if (ret)
> +			return ret;
> +	}

[Severity: Low]
What happens to a port that is already on the trusted table if the
second register write in this loop fails?

Say port P is the only user of the trusted table. The idx & ~BIT(port)
check is then skipped, and the table is rewritten in place while P's
bit in RTL8365MB_QOS_PRIDEC_IDX_REG is still set.

The loop does two separate read-modify-writes on the same register:

  1Q weight   (source 3) -> bits 15:8 of 0x0886
  DSCP weight (source 2) -> bits 7:0  of 0x0886

Suppose the 1Q write succeeds and the DSCP write fails, for example
with -ETIMEDOUT from realtek_smi_wait_for_ack(). The function then
returns without restoring the old 1Q weight. Neither
dsa_user_dcbnl_set_apptrust() nor dcbnl_ieee_set() rolls this back.

The port would then end up in a state that is neither the old profile
nor the new one:

  DSCP-only -> PCP-only: the port trusts both PCP and DSCP
  PCP-only -> DSCP-only: the port is on the trusted table but trusts
                         neither

Both weights live in the same register. Could they be written with a
single combined-mask update, so a failure can't leave the table half
written?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002115850.962676-1-o.rempel%40pengutronix.de

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB473793DF;
	Mon, 17 Aug 2026 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989265; cv=none; b=hS15TLiTUw7MutY/r+b3AeRYWLXFurm0hjhWo30NJi+W8S0CTf5UPUEYdL1IePeK95kbzeoHwOz8BtlUkPHozZ7SPVpEr2w9urdMVDtWLceJ/oRqwvaGp/xBVE43aY94tMVeJ6nnFcJLLot5w2CvKEeA2u99OHNZ5WDF4feyarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989265; c=relaxed/simple;
	bh=hCxnRZcvemz8jeNrAt8KI+38t+H0ef9Ct23hEZ9wJ/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO658sxQbaEsIweaPAHDychnFxdJ+szOEjpoHc8Bm6W0iKbjBWc0Q6TJ+LErg1LdN5CehOdqrXRUm1lar5f0/5Ro7BHCKKyPMWJd1HvgSMJJ8rB7iSgxWQXl9H1GQZGh7WN0JyKtDAOwteFLMYRQs4QbRk0jmuAtP5Ru6/DDwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKuBvs/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKuBvs/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C606B1F000E9;
	Mon, 17 Aug 2026 17:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786989263;
	bh=Fiegswlt0lf1A2Uqv4sKFUFP/e1WujPdUbSheyWHu30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKuBvs/3QFUwobA6Xo97adzRswo/BHL6JXsVx9G01pEeE1suhtISekuCntun+vzwC
	 Ji+11BPu9HQ5QCc1EZm59mNQWvYSQUK7T4PJQ71bC+aHdB2TAOxLJ94Q0EY2IMWX4K
	 50uYJ8m+2mW5Ms3S7+eXbCs+DK5vsmnQtV1rVnkVNi0psoOj3yJS4tD/bsHFNk83cI
	 YdAyKDn5V3Nb3+7QCDyzwMCz07lk3r+MCCuhNJL4RkAFVA3ItjVFxoOmy4vKWl8889
	 TdenyE07KB9bDk+M+nJwa1fQVwlA1earY05qjyRZZMjUV27z/Ypy+jKqMannl3WG1l
	 adlqqAZZq/MzQ==
From: Jakub Kicinski <kuba@kernel.org>
To: cedric.jehasse@luminex.be
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukeh@padl.com,
	kabel@kernel.org,
	cedric.jehasse@gmail.com
Subject: Re: [PATCH net-next v8 3/3] net: dsa: mv88e6xxx: add support for credit based shaper
Date: Mon, 17 Aug 2026 10:45:56 -0700
Message-ID: <20260817174556.3460676-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-net-next-mv88e6xxx-cbs-v8-3-10d0baab2905@luminex.be>
References: <20260811-net-next-mv88e6xxx-cbs-v8-3-10d0baab2905@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: mv88e6xxx: add support for credit based shaper

This adds TC_SETUP_QDISC_CBS offload to mv88e6xxx by programming the Qav
rate and HiLimit registers in the AVB block, with the per-chip differences
described by a new mv88e6xxx_qav_info. The 6352 and 6390 style egress
scheduling mode is switched when the first CBS queue on a port is enabled.

> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 47e531f24e5f..a567ee9b6ce0 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c

[ ... ]

> @@ -5654,6 +5660,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
>  	.port_set_ether_type = mv88e6393x_port_set_ether_type,
>  	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
>  	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
> +	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
>  	.port_pause_limit = mv88e6390_port_pause_limit,
>  	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
>  	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,

[Severity: Low]
The commit message says:

    Support is added for the 6341, 6352, 6390 and 6393 families.

mv88e6xxx_setup_tc_cbs() gates the whole feature on chip->info->qav, and
the patch sets .qav on six product entries only: MV88E6240, MV88E6341,
MV88E6352, MV88E6390, MV88E6390X and MV88E6393X.

Other members of exactly those families still return -EOPNOTSUPP:
MV88E6141 (FAMILY_6341), MV88E6172 and MV88E6176 (FAMILY_6352),
MV88E6190, MV88E6190X, MV88E6191 and MV88E6290 (FAMILY_6390), and
MV88E6191X, MV88E6193X and MV88E6361 (FAMILY_6393). Should the commit
message name the individual chips instead of the families?

The mv88e6393x_ops table above is also shared by MV88E6191X, MV88E6193X
and MV88E6361, which do have mv88e6390_avb_ops but no .qav entry, so the
ops table now advertises .port_set_scheduling_mode for chips the info
table refuses. Is that combination intentional?

Related to this, mv88e6165_avb_ops in global2_avb.c gains:

    .port_qav_write		= mv88e6352_g2_avb_port_qav_write,

Its only users are mv88e6161_ops and mv88e6165_ops, and neither gets
.port_set_scheduling_mode, nor does any FAMILY_6165 chip entry get .qav.
Is that callback reachable from anywhere?

[ ... ]

> @@ -7210,6 +7244,112 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
>  	return err_sync ? : err_pvt;
>  }
>  
> +static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
> +				  struct tc_cbs_qopt_offload *cbs)
> +{
> +	const struct mv88e6xxx_avb_ops *avb_ops;
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	const struct mv88e6xxx_qav_info *qav;
> +	const struct mv88e6xxx_ops *ops;
> +	int hilimit_reg;
> +	int rate_reg;
> +	u8 queue_bit;
> +	u32 rate = 0;
> +	u16 hilimit;
> +	int err;
> +
> +	ops = chip->info->ops;
> +	avb_ops = ops->avb_ops;
> +	qav = chip->info->qav;
> +
> +	if (!qav || !avb_ops || !avb_ops->port_qav_write ||
> +	    !ops->port_set_scheduling_mode)
> +		return -EOPNOTSUPP;
> +
> +	if (!dsa_is_user_port(ds, port))
> +		return -EOPNOTSUPP;
> +
> +	if (!(qav->queue_mask & BIT(cbs->queue))) {
> +		NL_SET_ERR_MSG_MOD(cbs->extack, "CBS not supported on queue");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	queue_bit = BIT(cbs->queue);
> +	rate_reg = MV88E6XXX_PORT_QAV_CFG_RATE(cbs->queue);
> +	hilimit_reg = MV88E6XXX_PORT_QAV_CFG_HILIMIT(cbs->queue);
> +
> +	if (cbs->enable) {
> +		if (cbs->hicredit <= 0 ||
> +		    cbs->hicredit > qav->hilimit_mask) {
> +			NL_SET_ERR_MSG_MOD(cbs->extack,
> +					   "hicredit out of range");
> +			return -ERANGE;
> +		}
> +
> +		rate = DIV_ROUND_UP(cbs->idleslope, qav->rate_unit);
> +		if (rate > qav->rate_mask) {
> +			NL_SET_ERR_MSG_MOD(cbs->extack,
> +					   "idleslope out of range");
> +			return -ERANGE;
> +		}
> +		/* avoid using zero rate */
> +		rate = max_t(u16, rate, 1);
> +	}

[Severity: Medium]
Can a negative idleslope reach the hardware here? cbs_change() and
cbs_enable_offload() in net/sched/sch_cbs.c copy the raw s32 tc_cbs_qopt
fields into struct tc_cbs_qopt_offload without any sign or range check, so
cbs->idleslope can be negative.

DIV_ROUND_UP expands to ((x) + (d) - 1) / (d) evaluated in int, so with
rate_unit == 64 and idleslope == -10:

    rate = (-10 + 63) / 64;	/* 0 */
    ...
    rate = max_t(u16, rate, 1);	/* 1 */

The rate > qav->rate_mask test passes and a shaper of one unit
(32 or 64 kbit/s) is programmed instead of an error being returned. For a
larger negative magnitude, say -1000, the quotient is -14, which as u32
exceeds rate_mask and -ERANGE is returned, so the same class of invalid
input is accepted or rejected depending only on magnitude.

For idleslope close to INT_MAX, does the addition inside DIV_ROUND_UP
overflow signed int before the bound check runs?

On the other side, cbs->hicredit <= 0 rejects hicredit == 0, which the
software cbs qdisc accepts. Is rejecting it with -ERANGE here intended?

> +
> +	mv88e6xxx_reg_lock(chip);
> +
> +	if (!cbs->enable) {
> +		err = mv88e6xxx_port_qav_write(chip, port, rate_reg, 0);
> +		if (err)
> +			goto unlock;
> +
> +		if (!(chip->ports[port].cbs_active_queues & ~queue_bit)) {
> +			err = mv88e6xxx_port_set_scheduling_mode(chip, port, 0);
> +			if (err)
> +				goto unlock;
> +		}
> +		chip->ports[port].cbs_active_queues &= ~queue_bit;
> +		goto unlock;
> +	}

[Severity: Medium]
Can this leave chip->ports[port].cbs_active_queues permanently stale? The
queue's shaper has already been disabled by the rate_reg write, but if
mv88e6xxx_port_set_scheduling_mode() fails (for example an MDIO error or
an mv88e6xxx_g2_avb_wait() timeout), the goto unlock happens before:

    chip->ports[port].cbs_active_queues &= ~queue_bit;

so the bit stays set. sch_cbs does not retry: cbs_disable_offload() only
does pr_warn("Couldn't disable CBS offload for queue %d\n", ...) and
cbs_change() then clears q->offload. Nothing else in the driver clears
cbs_active_queues.

Every later decision for that port is then wrong: an enable sees
cbs_active_queues != 0 and skips the scheduling mode programming, and a
disable of another queue sees !(active & ~queue_bit) as false and never
restores the port scheduling mode.

Is the enable-path rollback below complete for the same reason?

    if (err) {
        mv88e6xxx_port_qav_write(chip, port, rate_reg, 0);
        goto unlock;
    }

The HiLimit register stays programmed, the return value of the rollback
write is discarded, and the scheduling mode is not put back. In
mv88e6390_port_set_scheduling_mode() the register write happens before
the completion poll:

    err = mv88e6xxx_port_write(chip, port, MV88E6390_PORT_QUEUE_CTL, reg);
    if (err)
        return err;

    return mv88e6xxx_port_wait_bit(chip, port, MV88E6390_PORT_QUEUE_CTL,
                                   __bf_shf(MV88E6390_PORT_QUEUE_CTL_UPDATE)
                                   , 0);

so an error return does not mean the hardware mode is unchanged. Since
cbs_enable_offload() does not set q->offload on a negative return, will
any later call ever restore mode 0 on that port?

Also, on reconfiguration the HiLimit write happens before the Rate write,
so a failing rate write leaves an already active queue running its old
rate with the newly requested HiLimit while the operation is reported as
failed. Is that ordering deliberate?

As a side note, polling MV88E6390_PORT_QUEUE_CTL bit 15 is the only
UPDATE bit poll of its kind in this driver; MV88E6390_PORT_IEEE_PRIO_MAP_TABLE
and MV88E6393X_PORT_POLICY_MGMT_CTL are written without any wait. Does the
datasheet describe that bit as self-clearing on read?

> +
> +	hilimit = cbs->hicredit & qav->hilimit_mask;
> +	err = mv88e6xxx_port_qav_write(chip, port, hilimit_reg, hilimit);
> +	if (err)
> +		goto unlock;
> +
> +	err = mv88e6xxx_port_qav_write(chip, port, rate_reg, rate);
> +	if (err)
> +		goto unlock;
> +
> +	if (!chip->ports[port].cbs_active_queues) {
> +		u8 sched_mode = chip->info->num_tx_queues - 1;
> +
> +		err = mv88e6xxx_port_set_scheduling_mode(chip, port,
> +							 sched_mode);
> +		if (err) {
> +			mv88e6xxx_port_qav_write(chip, port, rate_reg, 0);
> +			goto unlock;
> +		}
> +	}
> +	chip->ports[port].cbs_active_queues |= queue_bit;

[Severity: Medium]
Enabling CBS on one queue reprograms the port wide egress scheduling mode
here. mv88e6xxx_port_set_scheduling_mode() writes
MV88E6XXX_PORT_EGRESS_RATE_CTL2 bits 13:12 on the 6352 and 6341 style
chips, or the Port Queue Control SCHEDULE pointer on the 6390 style
chips, both of which affect arbitration for every traffic class on that
port, including queues with no cbs qdisc.

The previous content of that field is never read back or cached; the patch
adds only a write callback (.port_qav_write) and no read helper, so the
disable path restores a hard coded 0:

    err = mv88e6xxx_port_set_scheduling_mode(chip, port, 0);

Whatever the reset default, bootloader or EEPROM had programmed there is
lost until the switch is re-probed. Should the pre-CBS value be saved in
struct mv88e6xxx_port and restored instead?

The commit message says:

    Note: only idleslope and hicredit can be programmed in the switch
    registers, other parameters won't affect settings.

which reads as if the change is confined to the CBS queue's own shaper.
Could it mention the port wide scheduling mode change as well?

One more thing about the disable path condition:

    if (!(chip->ports[port].cbs_active_queues & ~queue_bit)) {

this is also true when cbs_active_queues == 0, so a teardown for a port
that was never configured would force the port wide field to 0. Today
cbs_disable_offload() returns early when !q->offload, so it is not
reachable through sch_cbs, but should the code still require the queue bit
to be set before touching the port scheduling mode?

> +
> +unlock:
> +	mv88e6xxx_reg_unlock(chip);
> +
> +	return err;
> +}

[ ... ]
-- 
pw-bot: cr

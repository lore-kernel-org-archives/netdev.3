Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774134CDDF7;
	Wed, 30 Sep 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772100; cv=none; b=srrNnC17b11viYNH/ve/QSYSnStvEzaycQgr8kfKx0Oe66qhhNpujpc70WOdIun2zErQbnaC2foQSMtqL6oTQDoyg4cnPChlgU8r8WZYI4nB0TaKET9SBEEwejdrF4FveP6zh6wxMCHlgvNAl4PLZMYcPe+w4yYBi9/d14aFQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772100; c=relaxed/simple;
	bh=k+lehJlgZXDm5nvJBuPudtL1MPJkRKdBLWcRikTh4vc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICMXQZr9gXXEaydPD/wsZIiibspRjzTblncY1AGSAXb6FDTJZOC8pd6KGEQlCr8YavQOeWejZ3c8fMr/d46dvv2UwZY6daitiNInqBNNaMWsGmjP1C5oAcZs+UtFuJkRGStq4m5e6KaiqLA9BnJXAP4gvpAgkAQi9i4LwT97rvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm8ZpEZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm8ZpEZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC201F00893;
	Wed, 30 Sep 2026 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790772086;
	bh=G1aZhAHLF777IHLvmfY+59k0+hTqKq0+JtRJe/439FU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gm8ZpEZgMfl7E1NyAp/L5E9RjFVkPfjrZZ/yJlVmC9p0IM2fCIdkChSsdKaN/NiYN
	 /1PjLo9uCr4Y+hLtPYS2uI9j9ulEY9ewA2pxW0G32ADA+CHPrZ9M7ZryOcZaYyvtnL
	 h77Lv7tIn/Ia8CdO28mlINH33ehBzB3uFG4V7pVc8w+mE9EC0N0EHufDGV3Zhk8LtG
	 9N4miAZ5CTFirpO/7OjfToyHI70TuSzpgVfs3CUuF3I8xbYnmARGK6o0whf6TBEke+
	 oHm39sfkb6cHOWws9Td1KE7qSvQyx0Bf8gEXDue6YQIY8/PLEPtufnRgcS0GihF1f1
	 XxCxqThFMEfew==
Subject:
 Re: [PATCH net] fsl/fman: validate the port id in fman_set_port_params()
From: netdev-bot+sashiko@kernel.org
To: geoffreyhe2@gmail.com
Cc: madalin.bucur@nxp.com, sean.anderson@linux.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 12:41:25 +0000
Message-ID: <179077208577.434549.16592553336504519866@kernel.org>
In-Reply-To: <20260926053957.1628730-1-geoffreyhe2@gmail.com>
References: <20260926053957.1628730-1-geoffreyhe2@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves the bug class it claims to close reachable.
- [Medium] The new comment and the commit message say the check rejects
  port ids "that do not map to a MAC", but it does not.

Pre-existing issues:
- [Medium] Failure paths in fman_set_port_params() leave shared FMan
  resources committed to a port that never comes up.
- [Low] fman_port_probe() truncates the uint32 cell-index to u8 (`port_id
  = (u8)val;`, fman_port.c:1792) before any validation.
- [Low] When fman_port_init() fails, including through the new -EINVAL
  port-id rejection, it returns without freeing port->cfg.

--

fsl/fman: validate the port id in fman_set_port_params()

This patch adds a check at the top of fman_set_port_params(). The check
rejects a port id of 0, a port id at or above FMAN_LIODN_TBL, and a port
id whose mapped MAC index is at or above MAX_NUM_OF_MACS. The mac_id
calculation now happens before the spinlock is taken, so the check runs
before any state or register is changed.

> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index 46cc28895e565..e25050189b1f3 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -2103,6 +2103,18 @@ int fman_set_port_params(struct fman *fman,
>  	unsigned long flags;
>  	u8 port_id = port_params->port_id, mac_id;
>  
> +	/*
> +	 * port_id comes from the device tree: reject ids outside the LIODN
> +	 * table and ids that do not map to a MAC.
> +	 */
> +	mac_id = hw_port_id_to_sw_port_id(fman->state->rev_info.major, port_id);
> +	if (port_id == 0 || port_id >= FMAN_LIODN_TBL ||
> +	    mac_id >= MAX_NUM_OF_MACS) {

[Severity: High]
For TX ports, does this check run too late to stop the out-of-bounds
read that the commit message describes?

For every TX port, fman_port_probe() calls fman_get_qman_channel_id()
with the truncated cell-index. This happens before
fman_port_init()->fman_set_port_params() is reached:

drivers/net/ethernet/freescale/fman/fman_port.c:fman_port_probe() {
    ...
	port_id = (u8)val;
    ...
	if (port_type == FMAN_PORT_TYPE_TX) {
		u32 qman_channel_id;

		qman_channel_id = fman_get_qman_channel_id(fman, port_id);
    ...
}

On FMan rev >= 6, fman_get_qman_channel_id() walks a 14-entry table.
The loop limit is num_of_qman_channels, not the size of the table:

drivers/net/ethernet/freescale/fman/fman.c:fman_get_qman_channel_id() {
	if (fman->state->rev_info.major >= 6) {
		static const u32 port_ids[] = {
			0x30, 0x31, 0x28, 0x29, 0x2a, 0x2b,
			0x2c, 0x2d, 0x2, 0x3, 0x4, 0x5, 0x7, 0x7
		};

		for (i = 0; i < fman->state->num_of_qman_channels; i++) {
			if (port_ids[i] == port_id)
				break;
		}
    ...
}

read_dts_node() takes num_of_qman_channels from fsl,qman-channel-range
without checking it. The in-tree FMan v3 dtsi files set it to 0x10.

So a TX cell-index that is not in the table reads port_ids[14] and
port_ids[15], past the end of the array. The 0x3f example from the
commit message is one such id. Probe then fails before this new check
is reached. The stray rodata values are also compared against port_id,
so an invalid id could match one of them.

The commit message also says:

  fman_port_probe() truncates the property to a u8 and does not
  otherwise check it

Is that accurate for TX ports? The lookup above already allow-lists
them. Every id in those tables maps to mac_id <= 9, so the new check
never fires for TX. The only new protection seems to be for RX ports
with id 0 or id >= 0x12.

Would it close the remaining path to validate the raw cell-index in
fman_port_probe() and bound the fman_get_qman_channel_id() loop by
ARRAY_SIZE(port_ids)?

[Severity: Medium]
The comment says this rejects "ids that do not map to a MAC". Does it
catch ids 0x01-0x07?

hw_port_id_to_sw_port_id() returns 0 for every id below BASE_RX_PORTID:

	if (hw_port_id >= BASE_TX_PORTID)
		sw_port_id = hw_port_id - BASE_TX_PORTID;
	else if (hw_port_id >= BASE_RX_PORTID)
		sw_port_id = hw_port_id - BASE_RX_PORTID;
	else
		sw_port_id = 0;

Ids 0x01-0x07 are the Offline/Host range, for example fman0_oh_0x1 in
qoriq-fman-0.dtsi. They have no MAC, but they get mac_id 0 and pass the
mac_id >= MAX_NUM_OF_MACS test.

fman_port_probe() takes the port type only from the compatible string.
An fsl,fman-v[23]-port-rx node with cell-index 1-7 gets no id check at
all. A TX node with 0x2-0x7 (or 0x1 on v2) passes the
fman_get_qman_channel_id() lookup, because those O/H ids are in the
table.

Such a port then reaches this code later in the function:

	fman->state->port_mfl[mac_id] = port_params->max_frame_length;

This overwrites port_mfl[0], the slot for the real MAC 0.
fman_set_mac_max_frame() compares against that slot later.

For RX/TX ports, should port_id < BASE_RX_PORTID be rejected
explicitly here? Or should the helper return a distinct invalid value?

[Severity: Low]
This is a pre-existing issue that this patch did not introduce, and the
commit message already mentions it. fman_port_probe() does
port_id = (u8)val before any validation, so this check only sees the
truncated value.

A cell-index such as 0x108 or 0x128 is accepted and programs the
BMI/LIODN registers of port 0x08 or 0x28. The binding in
fsl,fman-port.yaml defines cell-index as a uint32 that selects one of
63 port pages.

The aliased id is always in range, so there is no out-of-bounds access.
Would it be better to check the raw value in fman_port_probe()?

> +		dev_err(fman->dev, "%s: invalid port id %u\n", __func__,
> +			port_id);
> +		return -EINVAL;
> +	}

[Severity: Low]
This isn't a bug introduced by this patch, but this new -EINVAL return
is one more way to reach an existing leak in fman_port_init():

drivers/net/ethernet/freescale/fman/fman_port.c:fman_port_init() {
    ...
	err = fman_set_port_params(port->fm, &params);
	if (err)
		return err;
    ...
	kfree(port->cfg);
	port->cfg = NULL;

	return 0;
}

fman_port_config() allocates port->cfg, and only the success path
above frees it. Does every error return in fman_port_init() leak
port->cfg? A later fman_port_config() call would also overwrite
port->cfg without freeing the old one.

[ ... ]

> @@ -2170,8 +2182,6 @@ int fman_set_port_params(struct fman *fman,
>  	if (fman->state->rev_info.major < 6)
>  		set_port_order_restoration(fman->fpm_regs, port_id);
>  
> -	mac_id = hw_port_id_to_sw_port_id(fman->state->rev_info.major, port_id);
> -
>  	if (port_params->max_frame_length >= fman->state->mac_mfl[mac_id]) {
>  		fman->state->port_mfl[mac_id] = port_params->max_frame_length;
>  	} else {

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. The new
port-id check runs before any state is changed, so it avoids the
problem.

When this max_frame_length check fails, or when set_size_of_fifo() or
set_num_of_open_dmas() fail, return_err only drops the spinlock.

Depending on where it fails, set_num_of_tasks() has already done:

	fman->state->accumulated_num_of_tasks += tasks;

and set_size_of_fifo() may already have done:

	fman->state->accumulated_fifo_size += fifo;

The TX path has also raised accumulated_num_of_deq_tnums and may have
rewritten fmqm_gc. By the time of the max_frame_length check, fmbm_pp,
the LIODN registers and the order restoration register are programmed
as well.

Nothing in fman.c ever decrements the accumulated_* counters. Can a
port that fails here leave the task, FIFO and DMA budgets charged, so
that later ports are refused with -EAGAIN?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926053957.1628730-1-geoffreyhe2%40gmail.com

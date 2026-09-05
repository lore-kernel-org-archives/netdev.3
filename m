Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10E39C63E
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640652; cv=none; b=dYJPOgfUwk+PsrxRy1aQWsepaacWR/RR1HowyuOvLFUyro1N6fU+VFMFuKuosbLjV25JcwCnuu0xND2NdPXBe8HsMMqXfh4Iwp4lz8eD+sLhSTL9FABoPK40Ua77buvCSFc9iVtIW6QS/d3/cd1kj5LUXXNS1c7tEHvjhznUPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640652; c=relaxed/simple;
	bh=w/JVOV3rYqUUq3uffTwW0ibZgudrnRthrweXHBOhuew=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKblR2yAfJcTML8tMy6m4Gxi+SSClyjuV0DVAY11GJgqTTj2IfRa7LM3wS+x9x1KQZivYyrV/9Zh/bc4nPFvIwbOkfoq3fi9GU5YGXXaattBVqV1J0rNCaVC9pvVnUNwgU2pJ1ySMDfFkkTkYhCrZnNADnzyqWG/3u98P61jLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InsbID0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InsbID0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC501F00A3E;
	Sat,  5 Sep 2026 20:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640651;
	bh=dnnTrXct/y+VpHhMyYDBtQM5tL7KSeqbYp65IlVI5U0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=InsbID0iXqoYDfG+We65sLF64YSnYeo6xzWT+MfGy8qAndzTZSi+SO4njeKKFPYsZ
	 c+xeJgQe9OM4lSdVp/FcAsMp79VZUAre79Vf5N778ef33Ot8gy4vsa/9jkMjjJUoby
	 Ph+K3gtJhLsG0fo5AUL2zlDW7ImgRFTBxL3aSAPu1gAU6U7ve/a1bdsYc8LurT0+Ot
	 ASR4/1hGO9/5MxEzylCiSPRRBpOIo29pe71EONGTPwslZbprGuhx1I34cpJBPOYDeQ
	 1527FbgainAdx/L+GwggIX4Uz5xSBkgZhMCkA/EW5kW5x5qAHhMrLRHe3QQ8v+au3A
	 6YtC9ePCrTazA==
Subject: Re: [net PATCH 3/4] fbnic: Handle FW mailbox completions flagged with
 an error
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com,
 horms@kernel.org
Date: Sat, 05 Sep 2026 20:37:30 +0000
Message-ID: <178864065018.219967.9864055112772296384@kernel.org>
In-Reply-To:
 <178838832539.11136.10707141286493607929.stgit@ahduyck-xeon-server.home.arpa>
References:
 <178838832539.11136.10707141286493607929.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 2

- [High] The Rx half of the new FW_ERR handling has no consumer.
- [Medium] fbnic_mbx_process_tx_msgs() detects that the FW completed a Tx
  mailbox request with FBNIC_IPC_MBX_DESC_FW_ERR — i.e. the request was…
- [Medium] In fbnic_mbx_poll_tx_ready() the new retry test 'if
  (tx_mbx->resp_error != resp_error) goto send_cap_req;'…
- [Low] Both new FW_ERR branches emit an unratelimited dev_warn() on a
  path whose trigger bit is entirely device/firmware controlled:…
- [Low] The new debugfs output formats the unsigned counter with a signed
  conversion: struct fbnic_fw_mbx declares 'u64 resp_error'…

--

fbnic: Handle FW mailbox completions flagged with an error

This adds a FBNIC_IPC_MBX_DESC_FW_ERR definition and checks it on both
mailboxes, counting occurrences in a new fbnic_fw_mbx.resp_error field that
is also printed in debugfs.  The Rx path drops the page instead of parsing
it, and fbnic_mbx_poll_tx_ready() re-issues the capabilities request when
the Tx counter advances.

A few questions below.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
> index 3c4563c8f403..4581fd8c8edf 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
> @@ -539,8 +539,8 @@ static void fbnic_dbg_fw_mbx_display(struct seq_file *s,
>  	/* Generate header */
>  	seq_puts(s, mbx_idx == FBNIC_IPC_MBX_RX_IDX ? "Rx\n" : "Tx\n");
>  
> -	seq_printf(s, "Rdy: %d Head: %d Tail: %d\n",
> -		   mbx->ready, mbx->head, mbx->tail);
> +	seq_printf(s, "Rdy: %d Head: %d Tail: %d resp_error: %lld\n",
> +		   mbx->ready, mbx->head, mbx->tail, mbx->resp_error);

[Severity: Low]
Should this be %llu?  resp_error is declared as u64 in struct fbnic_fw_mbx,
and Documentation/core-api/printk-formats.rst asks for %llu for u64 and
%lld for s64.  The kernel does not build with -Wformat-signedness, so the
mismatch is not diagnosed at compile time, and values above S64_MAX would
be shown as negative here.

[ ... ]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index ace6685df039..8f4a195bb8ed 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -291,6 +291,12 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
>  		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
>  			break;
>  
> +		if (desc & FBNIC_IPC_MBX_DESC_FW_ERR) {
> +			tx_mbx->resp_error++;
> +			dev_warn(fbd->dev,
> +				 "FW completed a Tx mailbox request with an error\n");
> +		}
> +
>  		fbnic_mbx_unmap_and_free_msg(fbd, FBNIC_IPC_MBX_TX_IDX, head);

[Severity: Medium]
This is the only place that learns the request was not processed, so should
it also fail the completion registered for that request?

Requests sent through fbnic_mbx_map_req_w_cmpl() install a struct
fbnic_fw_completion in fbd->cmpl_data[] via fbnic_mbx_set_cmpl_slot().
Completions are only signalled from the Rx TLV parsers through
fbnic_fw_get_cmpl_by_type(), or on teardown by __fbnic_fw_evict_cmpl():

static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_data)
{
	cmpl_data->result = -EPIPE;
	complete(&cmpl_data->done);
}

If the FW completes the Tx descriptor with FW_ERR, no response will ever
arrive, but the slot stays registered.  Does the waiter then sleep out its
full timeout?  fbnic_mbx_wait_for_cmpl() waits FBNIC_MBX_RX_TO_SEC * HZ for
the devlink flash/coredump paths, the ethtool module EEPROM read and the
mailbox self test, and fbnic_mac_get_sensor_asic() has its own 10 s
wait_for_completion_timeout().

There is a second effect during that window, in fbnic_mbx_set_cmpl_slot():

		else if (fbd->cmpl_data[i]->msg_type == cmpl_data->msg_type)
			return -EEXIST;

so every further request of the same type is rejected until the stale
waiter times out, and the caller reports a timeout rather than the error the
FW already told us about.  Since __fbnic_fw_evict_cmpl() already exists,
could this branch use it for the slot belonging to the failed descriptor
instead of only special-casing the polling capabilities request?

[Severity: Low]
Would dev_warn_ratelimited() or dev_warn_once() be better here and in the
new Rx branch below?  The trigger bit is firmware controlled, and
fbnic_mbx_poll() runs from fbnic_fw_msix_intr() once per firmware
interrupt, walking up to FBNIC_IPC_MBX_DESC_LEN descriptors each time, with
Rx slots recycled at the end of every iteration.  A firmware that sets
FW_ERR on every completion produces one line per descriptor per interrupt.
The new retry loop also polls every 20 ms for up to 10 s, so the benign
case can already print hundreds of identical lines per probe or resume.
The resp_error counters exported in debugfs keep the observability either
way.

> @@ -1672,6 +1678,13 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
>  		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
>  			break;
>  
> +		if (desc & FBNIC_IPC_MBX_DESC_FW_ERR) {
> +			rx_mbx->resp_error++;
> +			dev_warn(fbd->dev,
> +				 "FW reported an error on an Rx mailbox message; dropping\n");
> +			goto next_page;
> +		}
> +

[Severity: High]
Does anything consume rx_mbx->resp_error?  Grepping the tree, the only
reader is the debugfs line added by this patch; fbnic_mbx_poll_tx_ready()
snapshots and compares tx_mbx->resp_error only.

So what happens when the FW flags FW_ERR on the Rx descriptor carrying the
HOST_CAP_RESP?  The message is dropped without fbnic_tlv_msg_parse(), so
fbnic_fw_parse_cap_resp() never runs and fbd->fw_cap.running.mgmt.version
stays at 1.  The polling loop then spins until:

		if (!time_is_after_jiffies(timeout)) {
			err = -ETIMEDOUT;
			continue;
		}

and falls out to 'goto clean_mbx', which disables the mailbox.  That error
propagates through __fbnic_fw_enable_mbx() and fbnic_fw_request_mbx() and
aborts probe or __fbnic_pm_resume() on an otherwise healthy ring, which is
the failure mode the commit message describes as being fixed:

    "If the capabilities request from fbnic_mbx_poll_tx_ready() completed
    with FW_ERR no response was parsed and the poll spun until it timed out
    even though the ring was healthy."

Also, before this patch that descriptor was at least parsed.  Should the
retry in fbnic_mbx_poll_tx_ready() be driven by the Rx counter as well, so
an Rx-side FW_ERR re-issues the request instead of ending in -ETIMEDOUT?

>  		dma_sync_single_for_cpu(fbd->dev, rx_mbx->buf_info[head].addr,
>  					FBNIC_RX_PAGE_SIZE, DMA_FROM_DEVICE);
>  
> @@ -1740,6 +1753,7 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
>  {
>  	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
>  	unsigned long timeout = jiffies + 10 * HZ + 1;
> +	u64 resp_error;
>  	int err, i;
>  
>  	do {
> @@ -1770,6 +1784,8 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
>  	 * mgmt.version once we get the actual version from the firmware
>  	 * in the capabilities request message.
>  	 */
> +send_cap_req:
> +	resp_error = tx_mbx->resp_error;
>  	err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
>  	if (err)
>  		goto clean_mbx;
> @@ -1788,8 +1804,17 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
>  		fbnic_mbx_poll(fbd);
>  
>  		/* set err, but wait till mgmt.version check to report it */
> -		if (!time_is_after_jiffies(timeout))
> +		if (!time_is_after_jiffies(timeout)) {
>  			err = -ETIMEDOUT;
> +			continue;
> +		}
> +
> +		/* If the FW completed our capabilities request with an error
> +		 * (FW_ERR) it produced no response; the ring is not wedged, so
> +		 * re-issue the request instead of timing out.
> +		 */
> +		if (tx_mbx->resp_error != resp_error)
> +			goto send_cap_req;

[Severity: Medium]
Can this goto throw away a capability response that was just parsed?

The test sits at the end of the loop body, so it runs before the for
condition re-evaluates mgmt.version, and fbnic_mbx_poll() does both halves
in one call:

fbnic_mbx_poll()
    fbnic_mbx_process_tx_msgs()   /* bumps tx_mbx->resp_error */
    fbnic_mbx_process_rx_msgs()   /* parses cap resp, sets mgmt.version */

If both happen in the same poll, the goto re-enters the for statement whose
init clause runs unconditionally:

	for (fbd->fw_cap.running.mgmt.version = 1;
	     fbd->fw_cap.running.mgmt.version < MIN_FW_VER_CODE;) {

which resets the version that was just parsed and sends a redundant
HOST_CAP_REQ.

Note tx_mbx->resp_error advances for any Tx descriptor completed with
FW_ERR, not just the capabilities request, so is the trigger too broad?
fbnic_mbx_init_desc_ring() sets tx_mbx->ready = true before this loop, so
fbnic_mbx_map_msg() no longer returns -ENODEV, and this function also runs
at runtime from __fbnic_pm_resume() while hwmon and devlink stay registered
(fbnic_pm_suspend() does not unregister hwmon).  A concurrent sysfs sensor
read can queue a TSENE request that the FW completes with FW_ERR in the
same poll that delivers the capabilities response.  Should the retry be
keyed to the specific request rather than a mailbox-wide counter?

>  	}
>  
>  	return 0;

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> index d84723e4cfa3..5f9969247e30 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> @@ -13,6 +13,7 @@ struct fbnic_tlv_msg;
>  
>  struct fbnic_fw_mbx {
>  	u8 ready, head, tail;
> +	u64 resp_error;
>  	struct {
>  		struct fbnic_tlv_msg	*msg;
>  		dma_addr_t		addr;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/178838795612.11136.15512516427273655916.stgit%40ahduyck-xeon-server.home.arpa

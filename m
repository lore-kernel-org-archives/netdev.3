Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9874DF4D5;
	Mon, 19 Oct 2026 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410195; cv=none; b=jRLIwuIYdFi+6cIEiG3nsTQiJsSpyvLYsKBz+SlssO2QXQ6L7I3aZRdC5wwCS104su4lyrRjqzgo6IsGboGHSyjYL7IsHz4WQr+AI2klo+UuPGENmIp6WSaP5NU8QWb/phvgIeUYOk5TSdxCIoew/+V0a5IB7u91RDPYVU2+LyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410195; c=relaxed/simple;
	bh=/Xbu+ycz2JjYMtJDkwxaSg+xLpAP5LBjiPV0yI3yJVE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCQOh0utlWO/ceulH6JKmqCqjO4V4dBpV0YmFy6kbEJUGo4z/4Elcyn3nF13r88JUDeILegwgcRtk5xjoYdjp9Uo47jpq5QNpt50RlxC6ud00+5ErKfOkjbbQMlrHWAhd3rHMSB1ZXi97UuHQA997yjmvCGO7Pko8y4Dlvd7WwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diAD5lSV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diAD5lSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADDF1F000C6;
	Mon, 19 Oct 2026 11:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792410189;
	bh=kqCPPaXx7ihLfSRFIOsYKJ20fbN5TYqL3C2TVzoMXAo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=diAD5lSVSad4DeZsb/2DHTQwgqolsTsEdWLFFbDNHG1vdAd/PTM7hSGt8E7Ss6paf
	 Qp3WBVN21nUK1OS6jq4ZpBPv3Md1mqhld8dtxGQ3+/LsV4xTnV8zdumMKKWozBl0JB
	 Hmyh+giMCgOymElJB8HrVGPtvf1kt4DGTXM0CaksuzHjGSq3v0ykLyfdrcj+SvjYKp
	 7M1JcUBoiAGRlKhXQeNCFmZoO83SlmmCLq8vkgDwsNDDcrqEe3XvKU2Cvf72G+Zqm3
	 NukwerFhYV9ajfdpZHQjET9lLTjISTg1nq1pGOqVrbmGLyfXREXrowy0o/ltfv/fT8
	 /NHCdCH7tYOEw==
Subject: Re: [PATCH v4 net 6/8] net: enetc: pad short XDP frames in software
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, ioana.ciornei@nxp.com, zefir.kurtisi@westermo.com,
 zefir.kurtisi@gmail.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 11:43:08 +0000
Message-ID: <179241018821.3135.3963057243622029038@kernel.org>
In-Reply-To: <20261015105536.1692348-7-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-7-vladimir.oltean@nxp.com>
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

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new XDP pad BD in enetc_xdp_tx() is only partly initialised.
- [Medium] In enetc_xdp_tx()
  (drivers/net/ethernet/freescale/enetc/enetc.c), the new early `return…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the XDP_TX
  path in enetc_clean_rx_ring_xdp() ignores changes the BPF program…

--

net: enetc: pad short XDP frames in software

When an XDP frame is shorter than ETH_ZLEN, enetc_xdp_tx() now appends a
BD that points to the shared tx_pad zero buffer. The F flag, is_eof and
xdp_frame move onto that pad BD. Frames whose head buffer is shorter than
ENETC_MIN_BUFF_SIZE are dropped, because both callers treat a false return
as a drop.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 89b47accbac84..d456b9b488acf 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1750,8 +1750,11 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
>  {
>  	struct enetc_tx_swbd *tmp_tx_swbd = xdp_tx_arr;
>  	int i, k, frm_len = tmp_tx_swbd->len;
> +	struct enetc_tx_swbd *last_swbd;
> +	int pad_len;
>  
> -	if (unlikely(enetc_bd_unused(tx_ring) < ENETC_TXBDS_NEEDED(num_tx_swbd)))
> +	/* Hardware does not support a first buffer size of less than 16 bytes */
> +	if (unlikely(xdp_tx_arr[0].len < ENETC_MIN_BUFF_SIZE))
>  		return false;

[Severity: Medium]
Before this patch, enetc_xdp_tx() returned false only when the TX ring
was full. With this check it can also return false because of what is in
the frame.

enetc_xdp_xmit() still treats every false return as a full ring and stops
processing the bulk:

drivers/net/ethernet/freescale/enetc/enetc.c:enetc_xdp_xmit() {
    ...
		if (unlikely(!enetc_xdp_tx(tx_ring, xdp_redirect_arr,
					   xdp_tx_bd_cnt))) {
			for (i = 0; i < xdp_tx_bd_cnt; i++)
				enetc_unmap_tx_buff(tx_ring,
						    &xdp_redirect_arr[i]);
			break;
		}
    ...
}

Then bq_xmit_all() in kernel/bpf/devmap.c frees every frame from the
returned count onward:

	for (i = sent; unlikely(i < to_send); i++)
		xdp_return_frame_rx_napi(bq->q[i]);

Take a redirected frame with a 14 or 15 byte head. One example is a
14-byte AF_PACKET frame sent on a veth peer and redirected through a
devmap. Another is a frame trimmed to ETH_HLEN with bpf_xdp_adjust_tail().

In that case, are the valid frames after it in the same ndo_xdp_xmit()
bulk dropped and counted in xdp_tx_drops too, even though the ring has
room?

The commit message says:

    Both callers already treat a false return code from enetc_xdp_tx() as
    a drop.

It doesn't mention that the rest of the bulk is dropped as well, and the
later patches in the series don't change this.

Could enetc_xdp_xmit() check the head length before the DMA mapping, and
drop only that frame instead of breaking out of the loop?

>  	while (unlikely(!tmp_tx_swbd->is_eof)) {
> @@ -1759,15 +1762,24 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
>  		frm_len += tmp_tx_swbd->len;
>  	}
>  
> +	/* Pad frames below ETH_ZLEN so the mEMAC does not pad them. */
> +	pad_len = max_t(int, ETH_ZLEN - frm_len, 0);

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. On the
XDP_TX path, frm_len is built from lengths that leave out any changes the
BPF program made. enetc_clean_rx_ring_xdp() fills xdp_tx_arr through
enetc_rx_swbd_to_xdp_tx_swbd():

	tx_swbd->dma = rx_swbd->dma;
	...
	tx_swbd->page_offset = rx_swbd->page_offset;
	tx_swbd->len = rx_swbd->len;

rx_swbd->len is set in enetc_map_rx_buff_to_xdp() and
enetc_add_rx_buff_to_xdp() before bpf_prog_run_xdp() runs. The driver
never reads back xdp_buff.data/data_end or any frag sizes the program
changed.

If a program calls bpf_xdp_adjust_head() or bpf_xdp_adjust_tail() and
returns XDP_TX, does it still send the original byte range and length?

The commit message mentions this ("once the driver honours
bpf_xdp_adjust_tail() and bpf_xdp_adjust_head() for XDP_TX"), and no patch
in the series fixes it. The padding added here uses the same stale
lengths, which do match what is actually sent.

> +
> +	if (unlikely(enetc_bd_unused(tx_ring) <
> +		     ENETC_TXBDS_NEEDED(num_tx_swbd + !!pad_len)))
> +		return false;
> +
>  	i = tx_ring->next_to_use;

[ ... ]

> @@ -1776,6 +1788,22 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
>  		enetc_bdr_idx_inc(tx_ring, &i);
>  	}
>  
> +	/* The pad BD becomes the last one, so it takes over the xdp_frame
> +	 * (if any) from the last data BD. The pad BD has no DMA mapping of
> +	 * its own, and it is not an XDP_TX buffer to be recycled.
> +	 */
> +	if (unlikely(pad_len)) {
> +		struct enetc_tx_swbd *pad_swbd = &tx_ring->tx_swbd[i];
> +
> +		enetc_map_tx_pad(tx_ring, i, pad_len);
> +		pad_swbd->is_xdp_redirect = last_swbd->is_xdp_redirect;
> +		pad_swbd->xdp_frame = last_swbd->xdp_frame;

[Severity: High]
Is pad_swbd fully initialized here? enetc_map_tx_pad() sets only these
swbd fields:

	tx_swbd->len = pad_len;
	tx_swbd->is_eof = 1;
	tx_swbd->do_twostep_tstamp = false;
	tx_swbd->check_wb = false;

This block then adds is_xdp_redirect and xdp_frame. The other fields
(is_xdp_tx, page, page_offset, dma, is_dma_page, dir and qbv_en) keep
whatever the slot held before. The data BDs are fine, because
enetc_xdp_map_tx_buff() memcpy()s the whole swbd.

enetc_clean_tx_ring() normally memsets each slot it cleans, but slots can
be left stale. enetc_stop() doesn't clean BDs that have already completed.
After that, enetc_free_tx_frame() only does:

	if (tx_swbd->dma)
		enetc_unmap_tx_buff(tx_ring, tx_swbd);

That clears dma but leaves is_xdp_tx and page set.

Now suppose enetc_reconfigure_xdp_cb() fails, for example when
netif_set_real_num_tx_queues() returns -ENOMEM on XDP detach.
enetc_reconfigure() then restarts the same tx_swbd arrays without
scrubbing them:

out_restart:
	enetc_setup_bdrs(priv, extended);
	enetc_start(priv->ndev);

enetc_setup_txbdr() reloads next_to_clean and next_to_use from the
hardware, so these uncleaned slots end up in the free part of the ring.

Later, a short XDP frame may put its pad BD in one of those slots. At
completion, enetc_clean_tx_ring() would then run:

		if (tx_swbd->is_xdp_tx)
			enetc_recycle_xdp_tx_buff(tx_ring, tx_swbd);

on the pad BD. Couldn't this put the stale page back into the RX ring
with dma == 0, or unmap and free a page that was already freed? Either
way, xdp_tx_in_flight would be decremented for a BD that never
incremented it.

The later patch "fix leak of pending XDP_TX frames when going down"
seems to make this worse. It frees the page but still leaves is_xdp_tx
and page set.

Would it help to clear the pad swbd fully, for example with a memset
before enetc_map_tx_pad(), or by clearing is_xdp_tx, page, is_dma_page
and dma explicitly?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015105536.1692348-1-vladimir.oltean%40nxp.com

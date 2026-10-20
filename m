Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792468640;
	b=AfvkXKLt5gQoCjQ3ylZi+VjvfuUV3JmZqdikDlbdsENKQ+kxzK81j02XtwwSENO2TAAz
	 4jtNLw5U1PK5aXDtsmrj/8sfRxiJ/VcoMiMJU2mEBbD0EuyapV3KaR4kf7GSEgYJftMsF
	 +MsxQMDIFyw1gTdQYlTCFpTMND5DymlCJhoVcaMhAiOVTGAknh95gleKA1PV6PqLwVDHo
	 NBQubcNlhXQVCn+LLnjQOwtoNS79aMjW6rJY0eHyeohggGVEl619jUCSBlVbwIVY7M4qB
	 0kr740we/pG2pRzMv/nuD5RoPShwRsVqkFejKWAvOMTVrVEbTm6ffJCzdFk8QcBeLdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468640;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/W8Ed4jSRre2wfHFR+X/2tT/ft4pZKYlenk33nsLqiM=;
	b=QUrUj9jkEDdEMmBa78olBX+YRe8kGnHNw/6ycIOHPeMVf9Tk4h6JI2tSiqJ1tdlNgo8x
	 bvFuC0NsVv7AKLlhQMjJBDScnSLTJIEQ8jsG9jQhdZLbYA1bRJUmIloDPke7kOK5hErHq
	 EbjpeB1bHrVTAyyZ0L4RmvRL/5m5jhnoJlb1RU0/P2af1p0vuzu58aiUyYg5qykw1K/yy
	 lOV7LKjuwPBujEa+yAj9+YDDOvD1anxEOx7N17pczfXDFlzSJHIR87pEfhYON4cRbgy1b
	 vBHXBTJFDUC+3MlVHhrgYFn9bb++x6aWCRMaiDy5jDbB9Zqkc/maJH00hPNEJr7OqMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WamV38WX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C1606A319;
	Tue, 20 Oct 2026 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WamV38WX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446E11F000C4;
	Tue, 20 Oct 2026 03:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792468639;
	bh=/W8Ed4jSRre2wfHFR+X/2tT/ft4pZKYlenk33nsLqiM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WamV38WXMlJZhfZjfN9lZxgi+2MEM8+GM6sy+7SWg78m7EJPaYgG8zmH52wEDfDgy
	 HndhMq2G3A3iNuQha/7Ia7V6NoiH8R66/v5pa8cixxy2iEUt8KZm5qEfU/v9USZ/KI
	 n4SVj7wNxO0ALrsl1BBrsp/4T7e85CFTkTW3LjRgDlqyQbXboX8ADiMIS8kQIwAIWw
	 CgQTPfK2W8YKqQXCBl1+lg0zJxqI5o/nsbm5S3FwAefEmniCY1k0t7a0iAhyCp6zzp
	 s6jGt24Kpe/ixPLTSQOFBG4SlBdHLUQIKsZbJ4F2oOV6TTVqXC+vN24WJI/qZCHntV
	 m/dXQYMcJjP8A==
Subject:
 Re: [PATCH net-next] net: ti: icssg-prueth: Fix dma_unmap_single() direction
From: netdev-bot+sashiko@kernel.org
To: fourier.thomas@gmail.com
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 elfring@users.sourceforge.net, jacob.e.keller@intel.com,
 vadim.fedorenko@linux.dev, haokexin@gmail.com, diogo.ivo@siemens.com,
 jan.kiszka@siemens.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:57:17 +0000
Message-ID: <179246863774.3135.8755286961796234504@kernel.org>
In-Reply-To: <20261016125534.36024-2-fourier.thomas@gmail.com>
References: <20261016125534.36024-2-fourier.thomas@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 3 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds the very map/unmap direction mismatch it claims
  to fix.
- [High] The direction is not the real bug in prueth_process_rx_mgm().
- [High] net: cacheline corruption due to DMA_BIDIRECTIONAL on unaligned
  inline array
- [Medium] The commit message's premise is wrong.
- [Medium] The Fixes tag points at the wrong commit.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  prueth_process_rx_mgm() refills the wrong ring.

--

net: ti: icssg-prueth: Fix dma_unmap_single() direction

This patch changes the DMA direction to DMA_BIDIRECTIONAL in two places:
the mapping of the firmware command buffer in emac_send_command_sr1(),
and the RX management buffer unmap in prueth_process_rx_mgm(). The commit
message says the TX map and the RX unmap use mismatched directions.

> In emac_send_command_sr1(), the command data is mapped with direction
> DMA_TO_DEVICE. However, in prueth_process_rx_mgm(), dma_unmap_single()
> is called with direction DMA_FROM_DEVICE. It seems like the buffer is
> written to by the CPU before mapping the buffer; and, after mapping the
> buffer, the device writes to the buffer.

[Severity: Medium]
Are these the same buffer? emac_send_command_sr1() maps emac->cmd_data
on tx_chn->dma_dev. That mapping is released by prueth_xmit_free() when
the TX completes:

drivers/net/ethernet/ti/icssg/icssg_common.c:prueth_xmit_free() {
    ...
	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);

	dma_unmap_single(tx_chn->dma_dev, buf_dma, buf_dma_len,
			 DMA_TO_DEVICE);
    ...
}

So before this patch the command buffer was both mapped and unmapped
with DMA_TO_DEVICE.

prueth_process_rx_mgm() handles a different buffer. It is a page_pool
page that arrived on emac->rx_mgm_chn, attached by
prueth_dma_rx_push_mapped() as page_pool_get_dma_addr(page) +
PRUETH_HEADROOM.

The firmware reply is also read from that RX page, not from cmd_data:

prueth_rx_mgm_rsp_thread() {
    ...
	rsp = le32_to_cpu(*(__le32 *)page_address(page)) & 0xffff0000;
    ...
}

Does anything make the device write to emac->cmd_data, or read cmd_data
back after the DMA? If not, could the commit message be reworded to
describe the problem that actually exists?

> Fixes: e654b85a693e ("net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms")

[Severity: Medium]
Is this the right commit for the Fixes tag? At e654b85a693e both pairs
seem to match. cmd_data was mapped and unmapped with DMA_TO_DEVICE. The
RX management buffer was an skb, mapped DMA_FROM_DEVICE in
prueth_dma_rx_push() and unmapped DMA_FROM_DEVICE in
prueth_process_rx_mgm().

The RX side only went wrong with 46eeb90f03e0 ("net: ti: icssg-prueth:
Use page_pool API for RX buffer allocation"). That commit moved RX to
page_pool pages but kept the old dma_unmap_single().

Stable trees that have e654b85a693e but not 46eeb90f03e0 would end up
with a FROM_DEVICE map paired with a BIDIRECTIONAL unmap on the skb path.
They would also get a new mismatch on the TX command path.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index b8115ca47082f..6f4a3f64ad39f 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -98,7 +98,7 @@ static int emac_send_command_sr1(struct prueth_emac *emac, u32 cmd)
>  	tx_chn = &emac->tx_chns[emac->tx_ch_num - 1];
>  
>  	/* Map the linear buffer */
> -	buf_dma = dma_map_single(tx_chn->dma_dev, data, pkt_len, DMA_TO_DEVICE);
> +	buf_dma = dma_map_single(tx_chn->dma_dev, data, pkt_len, DMA_BIDIRECTIONAL);

[Severity: High]
There's a second problem with mapping cmd_data DMA_BIDIRECTIONAL.
emac->cmd_data is a 16 byte array embedded in struct prueth_emac with
no alignment or padding of its own:

	u8 cmd_seq;
	/* shutdown related */
	__le32 cmd_data[4];
	struct completion cmd_complete;
	/* Mutex to serialize access to firmware command interface */
	struct mutex cmd_lock;

So it shares a cacheline with cmd_seq, cmd_complete and likely part of
cmd_lock.

Documentation/core-api/dma-api.rst asks for regions mapped with
dma_map_single() to start and end on cacheline boundaries, so that
nothing else shares those lines. With DMA_TO_DEVICE this was harmless
in practice, because the CPU side never has to invalidate anything.
dma-debug skips its overlapping cacheline tracking for DMA_TO_DEVICE
mappings for exactly that reason.

DMA_BIDIRECTIONAL tells the architecture the device may write the
buffer. On a non-coherent system the CPU sync on unmap then invalidates
the lines covering cmd_data, and those lines also hold cmd_complete.

reinit_completion() writes cmd_complete after the map.
prueth_rx_mgm_rsp_thread() calls complete() on it from the mgm IRQ
thread while the buffer may still be mapped. Can the invalidate throw
away those updates and lose the wakeup?

Today only the descriptor allocation failure path above unmaps with
DMA_BIDIRECTIONAL. Every command would, though, if prueth_xmit_free()
were converted to match.

If the firmware really does write into this buffer, cmd_data would need
its own cacheline aligned allocation. If it doesn't, wouldn't keeping
DMA_TO_DEVICE avoid the problem altogether?

[Severity: High]
Doesn't this add a map/unmap direction mismatch? Only the unmap on the
descriptor allocation failure path below was converted. Every other
release of this mapping still goes through prueth_xmit_free(), which
hardcodes DMA_TO_DEVICE:

emac_send_command_sr1()
  k3_udma_glue_push_tx_chn()
  ... TX completion ...
emac_tx_complete_packets()
  default:    /* PRUETH_SWDATA_CMD */
    prueth_xmit_free()
      dma_unmap_single(..., DMA_TO_DEVICE)

The same is true of the free_desc path in this function when
k3_udma_glue_push_tx_chn() fails, and of TX channel teardown.

With CONFIG_DMA_API_DEBUG, would check_unmap() now report "device driver
frees DMA memory with different direction" on every successful firmware
command?

The device only reads cmd_data. With an IOMMU, though, BIDIRECTIONAL also
lets the device write to the page that holds it. That page is inside
netdev_priv(), next to cmd_complete, cmd_lock and the napi/hrtimer state.

Should the TX hunks be dropped?

>  	if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
>  		netdev_err(emac->ndev, "cmd %x: failed to map cmd buffer\n", cmd);
>  		ret = -EINVAL;

[ ... ]

> @@ -303,7 +303,7 @@ static struct page *prueth_process_rx_mgm(struct prueth_emac *emac,
>  	page = swdata->data.page;
>  	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
>  
> -	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
> +	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_BIDIRECTIONAL);

[Severity: High]
Should this be a dma_unmap_single() at all? The page comes from a page
pool that prueth_create_page_pool() sets up with:

	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
	...
	pp_params.dma_dir = DMA_BIDIRECTIONAL;

That means the pool owns a mapping of the whole page.
prueth_dma_rx_push_mapped() gives the device an offset into that mapping:

	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;

Here the address is read back with cppi5_hdesc_get_obuf(). It is never
converted with k3_udma_glue_rx_cppi5_to_dma_addr(), and it is unmapped
with a partial length. So it does not match any mapping the driver
created.

After the unmap, the page is either recycled with
page_pool_recycle_direct(), or, if allocation fails, pushed straight back
to hardware as new_page = page. In both cases the pool still treats the
page as mapped.

With an IOMMU, which the commit message mentions, can this free the IOVA
of a page the pool is still using? The next DMA into that page would then
fault or land on a reused IOVA, and page_pool_destroy() would unmap it a
second time.

DMA-API debug would also flag this as "device driver tries to free DMA
memory it has not allocated", whatever the direction.

emac_rx_packet() handles the same kind of buffer by calling
page_pool_dma_sync_for_cpu() instead of unmapping. Would a similar CPU
sync be the right replacement for the unmap here?

>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>  
>  	new_page = page_pool_dev_alloc_pages(rx_chn->pg_pool);

[Severity: High]
This isn't a bug introduced by this patch, but a little further down in
prueth_process_rx_mgm() the replacement buffer goes to the data channel
instead of the management channel:

	/* queue another DMA */
	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
					PRUETH_MAX_PKT_SIZE);
	if (WARN_ON(ret < 0))
		page_pool_recycle_direct(rx_chn->pg_pool, new_page);

The descriptor was just returned to rx_mgm_chn's desc_pool. The refill,
however, allocates from rx_chns.desc_pool and posts on the data RX
channel, using a page from the mgm page pool.

emac_ndo_open() fills the mgm ring only once, with
PRUETH_MAX_RX_MGM_DESC_SR1 (8) descriptors. After 8 management packets
(command responses or TX timestamps), does the firmware run out of mgm
buffers? If so, emac_send_command_sr1() would time out on every command,
and the skbs held in emac->tx_ts_skb[] would never complete.

All data descriptors are posted at open, so this push will usually fail
in k3_cppi_desc_pool_alloc() and hit the WARN_ON() on most management
packets. When it does succeed, emac_rx_packet() or prueth_rx_cleanup()
later recycles the mgm-pool page into the data pool.

Before 46eeb90f03e0 this call pushed to &emac->rx_mgm_chn. Should it do
so here as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016125534.36024-2-fourier.thomas%40gmail.com

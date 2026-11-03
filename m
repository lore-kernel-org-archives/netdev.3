Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694060;
	b=y5mcxPZkUxPn3utHox93eVCJ2xsABPzRWm7heD6ioGmo/uUqEFQMPwYn7xBGZQNCe83Y
	 jGjoeoUXb0knUkKMSD9Y/sCH3jbZlddLv9s4VYz2hDb5dmul6OCpu/nkndCvujzh4Syxx
	 P21tCCFICPz8FhucFVxGbmng6Pm7R7md5syWfAm70TwqgJ986/oZsUdnIp5wrHi6uDH1v
	 l3PZjcDlZylm4dYk/nWZIFz7AGM/1KvDMwn69hSgg49i7D/ZZ+LJuo+EOz/2+wro5Bk/L
	 uPDCWnH8YKBrgNk393kjbFsWkngayHLghJjVrKjCSbikPAn60jxDcjo+LLVA872nkqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694060;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Aa6+g5OWSxH4lWPH9eU9u8zxr2I/nnHbobAbPenwIPY=;
	b=wQQyVQUhXpYTowuG1XvpLLakrcVDfSLVXTgDkKWpmacYHFcPtdzwpqTY7eOzFKKOWwIU
	 z7VAvpYMg5hMF75UxdGliKl/ttpKlQy7HCHequqvTQsCikmOKdJPNAN/BSAyI+P+Vl5Ji
	 4YtEJ6Q4lg2k4Ls7/QlIRiiJ/pBDhhg0b7R67/0ClDme9gfQoZ+B7eiQkJ8VzNZxradVy
	 LAtkgTxcK3He1DDbYWbWlB/MJiMVWQta2w26Ef/AgRHGLD3qJREeiLpDLxyKggxWfwNgD
	 G2/193at6K5N7HqYCNDbDhI77qq6ysjpZqhZkmSu+SrolTpryaYoAcf7DSDhp41OjSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GunfXMZn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32728606A324;
	Tue,  3 Nov 2026 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GunfXMZn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A201F000C1;
	Tue,  3 Nov 2026 08:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694059;
	bh=Aa6+g5OWSxH4lWPH9eU9u8zxr2I/nnHbobAbPenwIPY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GunfXMZnebgMC9X7jf24JtJ2f6M1jRiXKUpWHGXBqe/dPCq1w3StQqPcjsVlWbS+r
	 Xw9Q4bbKKgyIiytFoPHW7Y6uJ36claf1kTOUPUdZnPTEjy1vVyeUlxcuxptVGNkC9I
	 LUKr2SpfTWiUgBwZqozX+oyUbOQN5dwSEBMJ37ps2HISYE+Kx1Y+VGY3TQzt3ssawG
	 tFPxXHSEoJZK4/u3kmMhSbfAPZCkXSr9Xi+CFM/5oHycbYd3hnuFyM7DYcI7HsWhs4
	 jLhs2tbBr/6r5mrLlq1JNmHdh8FicZU7FlIcyBbSa+AkCY7uNBYP9Q5LNtSbMP0Di5
	 Ub/hR33zgx63A==
Subject: Re: [PATCH] net: wwan: iosm: fix potential skb leak in MUX DL decode
From: netdev-bot+sashiko@kernel.org
To: fangxy@xiaopeng.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, johannes@sipsolutions.net,
 m.chetan.kumar@intel.com, zhugl3@xiaopeng.com
Date: Tue, 03 Nov 2026 08:20:58 +0000
Message-ID: <179369405864.488856.5590338519083448566@kernel.org>
In-Reply-To: <20261102081920.50288-1-fangxy@xiaopeng.com>
References: <20261102081920.50288-1-fangxy@xiaopeng.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message claims to fix a 'potential skb leak' in
  ipc_mux_dl_decode()…

Pre-existing issues:
- [High] ipc_mux_dl_acb_decode()
  (drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:518-545) follows a chain…
- [Medium] ipc_mux_dl_decode() reads a 4-byte signature at line 702
  without checking skb->len >= 4.
- [Medium] On the MUX (IPC_CTYPE_WWAN) downlink path, the CPU parses the
  receive buffer and hands skb_clone()s of it to the network stack while…

--

net: wwan: iosm: fix potential skb leak in MUX DL decode

This patch adds an ipc_pcie_kfree_skb() call to the early return in
ipc_mux_dl_decode() that is taken when skb->data is NULL. The intent is to
release both the DMA mapping and the skb. It carries a Fixes: tag for
commit 3670970dd8c6.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> index 0bbd41263cc2f..61700688eac96 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -693,8 +693,10 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
>  {
>  	u32 signature;
>  
> -	if (!skb->data)
> +	if (!skb->data) {
> +		ipc_pcie_kfree_skb(ipc_mux->pcie, skb);
>  		return;
> +	}

[Severity: Medium]
Can skb->data actually be NULL here? The commit message says:

  However, the early return when skb->data is NULL
  bypasses the skb cleanup.

The only caller is ipc_imem_dl_skb_process(), which already returns early
when skb is NULL.

DL ring skbs come only from
ipc_protocol_dl_td_prepare()->ipc_pcie_alloc_skb()->
ipc_pcie_alloc_local_skb()->__netdev_alloc_skb(). When the allocation
succeeds, skb->data points at the head buffer. When it fails, NULL is
returned and caught before anything is put on the ring:

drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c:ipc_protocol_dl_td_prepare() {
    ...
	skb = ipc_pcie_alloc_skb(ipc_protocol->pcie, pipe->buf_size, GFP_ATOMIC,
				 &mapping, DMA_FROM_DEVICE,
				 IPC_MEM_DL_ETH_OFFSET);
	if (!skb)
		return false;
    ...
}

ipc_pcie_alloc_skb() also passes skb->data to ipc_pcie_addr_map() and
frees the skb if the mapping fails. Nothing between there and the decoder
(skb_reserve(), skb_put()) can set skb->data to NULL.

If that is right, the new ipc_pcie_kfree_skb() call is dead code and no
reachable leak gets fixed. Should this be described as hardening and sent
without the Fixes: tag? Or should the impossible check simply be removed,
so stable does not pick it up as a leak fix?

Separately, ipc_imem_dl_skb_process() has two branches that drop the skb
without freeing it: the IPC_CTYPE_WWAN case when if_id is not
IPC_MEM_MUX_IP_CH_IF_ID, and the default case. Both also look unreachable
with the current single WWAN channel (if_id 0).

>  
>  	/* Decode the MUX header type. */
>  	signature = le32_to_cpup((__le32 *)skb->data);

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Is
skb->len checked anywhere before the signature and the headers after it
are parsed?

skb->len comes from the device-written p_td->scs in
ipc_protocol_dl_td_process(). It is only bounded by pipe->buf_size, so it
can be 0.

None of the decoders compare skb->len with their header sizes:
ipc_mux_dl_cmd_decode() (struct mux_lite_cmdh), ipc_mux_dl_adgh_decode()
(struct mux_adgh) and ipc_mux_dl_acb_decode(). ipc_mux_dl_fcth_decode()
gets only skb->data, so it cannot check the length at all. With a short
transfer, these decoders read stale or uninitialized bytes that lie inside
the buf_size allocation but beyond the received data.

In ipc_mux_dl_adgh_decode(), the u32 subtraction can underflow when the
device-supplied length is smaller than packet_offset:

	adgh_len = le16_to_cpu(adgh->length);

	/* Pass the packet to the netif layer */
	rc = ipc_mux_net_receive(ipc_mux, if_id, wwan, packet_offset,
				 adgh->service_class, skb,
				 adgh_len - packet_offset);

ipc_mux_net_receive() ignores a failed skb_pull(), and skb_trim() with a
huge length does nothing. A wrongly framed clone then reaches
ipc_wwan_receive().

[Severity: High]
This is also a pre-existing issue that this patch did not introduce.
ipc_mux_dl_decode() dispatches IOSM_AGGR_MUX_SIG_ACBH blocks to
ipc_mux_dl_acb_decode(), which walks the command chain using indices
written by the modem:

drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:ipc_mux_dl_acb_decode() {
    ...
	next_cmd_index = le32_to_cpu(acbh->first_cmd_index);
	next_cmd_index = array_index_nospec(next_cmd_index,
					    sizeof(struct mux_cmdh));

	while (next_cmd_index != 0) {
		cmdh = (struct mux_cmdh *)&block[next_cmd_index];
		next_cmd_index = le32_to_cpu(cmdh->next_cmd_index);
    ...
}

Only the first index is clamped. Is each later next_cmd_index used as an
offset into skb->data without any check against skb->len? That would let
the device make the kernel read struct mux_cmdh fields up to 4 GiB past
skb->data, which page-faults in the DL tasklet path.

The loop also has no forward-progress check, unlike the adth loop in
mux_dl_adb_decode(). A command whose next_cmd_index points back to itself
(for example first_cmd_index = 16 with the u32 at offset 24 also set to
16) looks like it would spin forever. On each pass it could call
ipc_mux_dl_acb_send_cmds() again.

The out-of-bounds write through link_status_resp.response in
ipc_mux_dl_acbcmd_decode() does not look reachable.
ipc_mux_dl_cmds_decode_process() returns -EINVAL for
IOSM_AGGR_MUX_CMD_LINK_STATUS_REPORT_RESP, so the concern is limited to
the out-of-bounds read and the endless loop.

[Severity: Medium]
This is another pre-existing issue that this patch did not introduce. Is
the CPU reading this DMA_FROM_DEVICE buffer while it is still mapped?

In ipc_imem_dl_skb_process(), only the CTRL case unmaps before using the
buffer:

	case IPC_CTYPE_CTRL:
		...
		ipc_pcie_addr_unmap(ipc_imem->pcie, IPC_CB(skb)->len,
				    IPC_CB(skb)->mapping,
				    IPC_CB(skb)->direction);
	...
	case IPC_CTYPE_WWAN:
		if (pipe->channel->if_id == IPC_MEM_MUX_IP_CH_IF_ID)
			ipc_mux_dl_decode(ipc_imem->mux, skb);

On the WWAN path, ipc_mux_dl_decode() reads the signature and runs the
ADB/ADGH/FCTH/ACB/CMD decoders. ipc_mux_net_receive() then hands
skb_clone()s to ipc_wwan_receive(). The unmap only happens in the final
ipc_pcie_kfree_skb() call. There is no dma_sync_single_for_cpu() anywhere
in drivers/net/wwan/iosm/.

With SWIOTLB bouncing, or on platforms without cache-coherent DMA, the
decoder and the network stack would see stale data. The unmap would then
copy the device data into a buffer that clones already in the stack may
still be reading. The dead-code exit added by this patch follows the same
late-unmap pattern.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102081920.50288-1-fangxy%40xiaopeng.com

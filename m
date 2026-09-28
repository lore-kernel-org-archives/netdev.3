Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77DE3DB620;
	Mon, 28 Sep 2026 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602622; cv=none; b=hP+mUDRKJvEVzab7Boc2ozFr2GXkOmtjVp016AC/BBDI/ydlTQ2tRKlY2N+rB4HstJYAYcSi3xQaM+g9U0deWgTkHCjUaMGD0XWsYioZjOd7PRRMhMLp1mCNu9eRJw/M2nOAQXKWx/MHaU7kVljDlrCBNqGbCBdA09i0KbsK6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602622; c=relaxed/simple;
	bh=uCJMNYRb0dJ23inpUSyXpDCAf6+VNJdEgZrUczNCgSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liLE1157X718862ohXsliWf3lmug+1R7fbzpG0AvluiJhTN3adUFtXGzJB6wVb6ywzSpWB3pJx/zd/nUndEmn7UvOg+WNZ80Qc7imFBCVwwlEFKTnbLnwBjYS5Bay+i/0kGl0jEjHEzkulNlWPvJTwm9SvKIR8spwcWplHaWE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyI8Owps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyI8Owps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769AE1F000FF;
	Mon, 28 Sep 2026 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790602620;
	bh=o/h3Dk4bf2evwqsJUapzbYALe6zUA6ekei+vUYpPNBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fyI8OwpsALSIH6r/7hxbSH8k9OaHdqLXD13rEcdHhjU1LCvKZHDOHavjUG9yDFUEV
	 +G4NpbENoKXxi7usBHp+XTYh2MKdTTk4TyNlnvJzemf4p+4lERynVAHY0wQ35wzVIe
	 sAss3PzUofyBM/JjpCpzMP36Il96vFEBfLCQGLvwnPiWg3x8k/1+me6FT8bNIHzj6I
	 xplERgfMxifsJt5+7zybiH+P0kHDOOWwE4MVh0sCzPPiRO8kqtJ4tQ9KvpeNJNb62t
	 GElWukl2jDALOQMMYeT/qePI+qc7RbnwxikHDVk+J1Yq1IT7RhPYykrOFUAE96IL7j
	 8J2e5RKyyEPnQ==
Date: Mon, 28 Sep 2026 14:36:54 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: florian.fainelli@broadcom.com, netdev@vger.kernel.org,
	opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, zakkemble@gmail.com,
	ryotkkr98@gmail.com, linux-kernel@vger.kernel.org, nb@tipi-net.de
Subject: Re: [PATCH net 3/6] net: bcmasp: validate minimum RX packet size in
 bcmasp_rx_poll()
Message-ID: <20260928133654.GS13925@horms.kernel.org>
References: <20260922221630.3864427-4-florian.fainelli@broadcom.com>
 <179027136939.2160803.15243672598361037469@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179027136939.2160803.15243672598361037469@kernel.org>

On Thu, Sep 24, 2026 at 05:36:09PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 (2) · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new minimum-size check in bcmasp_rx_poll()
>   (bcmasp_intf.c:526) is `len < 2 + (intf->crc_fwd ?
> - [Medium] The commit message overstates the impact.
> - [Low] The new runt/invalid-length drop branch in bcmasp_rx_poll()
>   (lines 526-530) increments `stats->rx_dropped`.
> 
> Pre-existing issues:
> - [Medium] bcmasp_rx_poll() never checks desc->size or
>   DESC_ADDR(desc->buf) against an upper limit.
> - [Medium] One `struct u64_stats_sync` (`intf->stats64.syncp`) is written
>   by several contexts that are not mutually exclusive: - `rx_napi`…
> 
> --
> 
> net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
> 
> This patch adds a lower bound check on desc->size in bcmasp_rx_poll().
> Descriptors smaller than the 2-byte alignment pad plus the optional FCS
> are counted in rx_dropped and skipped before an skb is built.
> 
> > If the hardware reports a descriptor size smaller than the pad and CRC
> > lengths (e.g. runt or corrupted frames), len -= 2 or len - ETH_FCS_LEN
> > underflows u32 len, leading to out-of-bounds trimming and memory
> > corruption.
> 
> [Severity: Medium]
> Is "out-of-bounds trimming and memory corruption" accurate here? Both
> helpers used by bcmasp_rx_poll() appear to guard against the underflowed
> values:
> 
> include/linux/skbuff.h:skb_pull_inline() {
> 	return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);
> }
> 
> net/core/skbuff.c:skb_trim() {
> 	if (skb->len > len)
> 		__skb_trim(skb, len);
> }
> 
> If desc->size is below 2, skb_pull() returns NULL and pulls nothing. If
> len - ETH_FCS_LEN wraps to a value near 4G, skb_trim() does nothing.
> 
> Before this patch, the visible effects seem to be two:
> 
>   - a 0-3 byte skb reaches eth_type_trans() and GRO
>   - the wrapped len is added to rx_bytes, about 4 GiB per frame:
> 
> 	u64_stats_add(&stats->rx_bytes, len);
> 
> Neither of these is an out-of-bounds write.
> 
> The driver also never sets UMC_CMD_RUNT_FILTER_DIS, so the UniMAC runt
> filter should stay enabled. That leaves misbehaving or corrupted
> descriptors as the only way to reach this path.
> 
> This carries a Fixes: tag, so it will go to stable. Could the commit
> message describe the actual impact, and say whether such descriptors have
> been seen on real hardware?

Hi Florian,

While tightening up the wording of the patch description might be nice
I'm more concerned about the point made in the last paragraph.

And I think that if this is more hardening than fixing a bug
that can manifest then it would be best sent via net-next
without a Fixes tag or CCing stable.

> 
> > diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> > index 9ad5a982542f5..2ad8a7eac8888 100644
> > --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> > +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> > @@ -523,6 +523,12 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
> >  					DMA_FROM_DEVICE);
> >  
> >  		len = desc->size;
> > +		if (unlikely(len < 2 + (intf->crc_fwd ? ETH_FCS_LEN : 0))) {
> 
> [Severity: High]
> Should this threshold also include ETH_HLEN?
> 
> With crc_fwd set, any desc->size from 6 to 19 passes this check. With
> crc_fwd clear, the range is 2 to 15. After the pad pull and the FCS trim,
> the skb holds 0-13 bytes. With desc->size == 6 and crc_fwd set,
> skb->len == 0.
> 
> That skb still goes to eth_type_trans(), and eth_skb_pull_mac() ignores
> the failed pull:
> 
> include/linux/etherdevice.h:eth_skb_pull_mac() {
> 	struct ethhdr *eth = (struct ethhdr *)skb->data;
> 
> 	skb_pull_inline(skb, ETH_HLEN);
> 	return eth;
> }
> 
> eth_skb_pkt_type() then reads h_dest, and eth_type_trans() reads
> h_proto, from bytes past skb->len. The memcpy() never wrote those bytes.
> They are stale page_pool page contents, or the stripped CRC, and they
> decide skb->pkt_type and skb->protocol.
> 
> The frame is then passed to napi_gro_receive(). If a packet socket
> receives it, eth_header_parse() copies h_source into sll_addr. Can that
> leak 6 stale bytes to userspace?
> 
> Sizes just above the new limit still reach this path for the runt or
> corrupted descriptors the commit message describes. bcmasp_xmit() already
> uses ETH_ZLEN + ETH_FCS_LEN as the minimum frame size.
> 
> Would 2 + ETH_HLEN + (crc_fwd ? ETH_FCS_LEN : 0), or a bound based on
> ETH_ZLEN, be more appropriate here?

This does seem to be a legitimate concern.

> 
> > +			u64_stats_update_begin(&stats->syncp);
> > +			u64_stats_inc(&stats->rx_dropped);
> 
> [Severity: Low]
> Is rx_dropped the right counter for a length error? The page_pool and
> napi_build_skb() allocation failures also use it, and
> bcmasp_get_stats64() exports it directly:
> 
> 	stats->rx_dropped = u64_stats_read(&lstats->rx_dropped);
> 	stats->rx_crc_errors = u64_stats_read(&lstats->rx_crc_errs);
> 	stats->rx_frame_errors = u64_stats_read(&lstats->rx_sym_errs);
> 	stats->rx_errors = stats->rx_crc_errors + stats->rx_frame_errors;
> 
> include/uapi/linux/if_link.h describes the two counters differently:
> 
>   - rx_dropped: "e.g. due to lack of resources or unsupported protocol"
>   - rx_length_errors: "Number of packets dropped due to invalid length",
>     which is also counted in rx_errors
> 
> As written, ip -s link can't tell these drops apart from allocation
> failures, and they never show up in rx_errors or rx_length_errors.
> 
> > +			u64_stats_update_end(&stats->syncp);
> 

Likewise, the analysis above does seem to be correct.

> [Severity: Medium]
> This is a pre-existing issue, but intf->stats64.syncp seems to have
> several writers that are not mutually exclusive:

I'm skipping over the issues that are flagged pre-existing.
I'd appreciate it if you could look over them.
And likewise for the AI-generated review for the remaining
patches of this patch-set.

...

-- 
pw-bot: changes-requested

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807B4483BE;
	Sat, 10 Oct 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624552; cv=none; b=NT8QTyh2g2qWKLc3OH9ZE5C1NZM56+yK6RC6IwxxJtrqWMfLQtsv4cA9jnnTDuteKi4cHcE8VrEwtm10fvnSic8jBAumusYuybavONAr8zbFa9OnbW9Nuki6M5V9e6BaV0TRkbD+vgxq4RYRESkc+N5TfvTYDPI1QMZNm08F4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624552; c=relaxed/simple;
	bh=f6BcGLxJAjuuMPddk/VDWYsmHGfoKBDijywqmEVd24Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1pcgDLVdsN8RsW7bkWhEK63L89ejCfBQQio9EBv2Yalzixf4Z1rN5EPcDoSAm3qC1MT5JCWwxLwmOU/tdFr7jKwvuV+qdbg9nkp+n2oaej3UNLR4wi0w3s6qwGtnNU6zKFjCBzwXeYY/x5rVOj23TWjs4fD1kWozIsRsWuFbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0vuLXpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0vuLXpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7558A1F000FF;
	Sat, 10 Oct 2026 09:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791624550;
	bh=n2qqZSITy4GSIujj1HBd4NeLLdojjsZKl4gMgOUIia0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M0vuLXpXvzr/cISjTOAA0qgPP+XbcR1S5CUwRD9LNqait47APFWjRIjSzHJz9RhHn
	 PPzZLNgNRecrezFd57Sln8wai6WUZ7QJDoxUR1yg7W+9htRp67GMgWoOUa5iIDihRx
	 ZA7VDi7TEtWj4q7IrJFa3sEgKRpijUsL1mVDXpiMMrS3ojm7goDhRcmF7BKYJ2A/3a
	 JwtvNnV03RO8sR4JUx2AS92YwsHnKIFrre88uzLIA2noNdZDg/+V70DEGusSI3Ke1G
	 2w9NPNMHQ91uXWYrgRyvwcj6lCB8zvmAxju4wEXQQsLGQO24kWxZ15ybjgZsNrv9WO
	 6SzTL2B0mX2ng==
Subject: Re: [PATCH net-next v3 6/8] net: qualcomm: rmnet: Work around
 coalescing hardware quirks
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 sean.tranchetti@oss.qualcomm.com
Date: Sat, 10 Oct 2026 09:29:08 +0000
Message-ID: <179162454895.434549.10020078592538784381@kernel.org>
In-Reply-To:
 <20261009084351.317632-7-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20261009084351.317632-7-subash.a.kasiviswanathan@oss.qualcomm.com>
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

- [Low] This patch fixes a checksum-trust defect added by the previous
  patch in the same series, "net: qualcomm: rmnet: Add DL packet…
- [Low] Several comments in
  drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c no longer match…

--

net: qualcomm: rmnet: Work around coalescing hardware quirks

On some hardware the frame-level CSUM_VALID flag can't be trusted for a
MAPv5 coalescing frame that holds one NLO with one packet. This applies
when the frame was closed by a TCP FIN/PSH or by the packet count, byte
count or time limit. This patch forces those frames to CHECKSUM_NONE. It
also derives the NLO count from the contiguous num_packets prefix rather
than the num_nlos field in the coalescing header.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 5ffb811d7ef1a..e8adb40067175 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c

[ ... ]

> @@ -959,6 +1020,12 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
>  		return 0;
>  	}
>  
> +	if (rmnet_map_v5_csum_fixup(coal_hdr) && !coal_meta.zero_csum) {
> +		coal_skb->ip_summed = CHECKSUM_NONE;
> +		__skb_queue_tail(list, coal_skb);
> +		return 0;
> +	}
> +
>  	if (rmnet_map_coal_gro_fast_path(coal_skb, coal_hdr, &coal_meta, list,
>  					 num_nlos, gro))
>  		return 0;

[Severity: Low]
This workaround fixes behaviour added by the previous patch in this
series, "net: qualcomm: rmnet: Add DL packet coalescing support". Would it
be better to fold the quirk handling into that patch?

At that commit, rmnet_map_coal_gro_fast_path() trusts the frame-level
CSUM_VALID flag and never checks close_info:

rmnet_map_coal_gro_fast_path() {
	if (!gro || num_nlos != 1 ||
	    !(coal_hdr->coal_info & MAPV5_COALINFO_CSUM_VALID_FLAG))
		return false;
	...
	coal_skb->ip_summed = CHECKSUM_UNNECESSARY;
	...
}

Assume RXCSUM and GRO_HW are both enabled, and a frame with one NLO and
one packet was closed by FIN/PSH or by the HW packet, byte or time limit.
That frame goes through this path:

rmnet_map_process_next_hdr_packet()
  -> rmnet_map_segment_coal_skb()
    -> rmnet_map_coal_gro_fast_path()

There it is marked CHECKSUM_UNNECESSARY even if its checksum is wrong. The
commit message of that patch also says "A single-packet frame is passed
with CHECKSUM_UNNECESSARY when both features are enabled".

This can only happen with the new opt-in RMNET_FLAGS_INGRESS_COALESCE
flag, and the problem is gone by the end of the series. Even so, a bisect
that stops on the coalescing patch, or a backport that takes only that
patch, would accept corrupted payloads on the affected hardware. Both
patches are in the same unmerged series, so a Fixes: tag isn't the right
tool here.

[ ... ]

> @@ -1005,17 +1073,18 @@ static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
>  		return -EINVAL;
>  
>  	coal_hdr = (struct rmnet_map_v5_coal_header *)(skb->data + sizeof(*maph));
> -	num_nlos = u8_get_bits(coal_hdr->coal_info, MAPV5_COALINFO_NUM_NLOS_FMASK);
> -
> -	if (num_nlos == 0 || num_nlos > RMNET_MAP_V5_MAX_NLOS)
> +	nlos = rmnet_map_v5_get_num_nlos(coal_hdr);
> +	if (nlos < 0)
>  		return -EINVAL;
>  
> +	*num_nlos = nlos;
> +
>  	for (i = 0; i < RMNET_MAP_V5_MAX_NLOS; i++) {
>  		u8 err = coal_hdr->nl_pairs[i].csum_error_bitmap;
>  		u8 pkt = coal_hdr->nl_pairs[i].num_packets;
>  
>  		mask |= ((u64)err) << (8 * i);

[Severity: Low]
After this change, several comments in rmnet_map_data.c no longer match
the code. They are still there at the end of the series.

The "Checks performed" list above rmnet_map_data_check_coal_header() still
says:

 *  - num_nlos is in [1, RMNET_MAP_V5_MAX_NLOS].

This function no longer reads or range-checks the NUM_NLOS field in the
header, so a value of 0 or 7 there is now accepted. The only check left is
that the derived prefix count is non-zero.

The new comment on rmnet_map_v5_get_num_nlos() says:

 * The first empty NLO marks the end of the prefix. Entries after it are not
 * processed.

The commit message also says "stop processing at the first empty entry".
But this loop still ORs csum_error_bitmap from all RMNET_MAP_V5_MAX_NLOS
slots into nlo_err_mask. The comment on this function requires that
"regardless of how many NLOs are actually in use". The documentation
added in this series also says bitmap bytes after the active prefix must
not be ignored.

The comment above rmnet_map_segment_coal_skb() also still says:

 * NLOs with checksum errors are dropped. __rmnet_map_ingress_handler will

The new rmnet_map_v5_csum_fixup() branch queues the whole coal_skb with
CHECKSUM_NONE. It returns before rmnet_map_coal_segment_loop(), so
packets flagged in csum_error_bitmap are delivered rather than dropped.
The commit message notes this.

Could these comments be updated to match the new behaviour?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009084351.317632-1-subash.a.kasiviswanathan%40oss.qualcomm.com

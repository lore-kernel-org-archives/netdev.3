Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13283D75A0;
	Sat, 10 Oct 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624547; cv=none; b=k6cigEkJMIY/mPTPy6oWRgCBtIvLP9EGJEa8e1jfQhrSEWh184rzUZqrGALLiiUtIqs2a/dDfDUAdMIsU/xTMNxkklmR3wFkBbcJ+nMRRVxDNVCoHsIhL/1S5V+tKBz92jBKDnM7l374nPBcJFLNPb0tJTdLSxAhkDtv/7aES6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624547; c=relaxed/simple;
	bh=3fJoRItXBNa3FPdA/FB6BM9+wvR2Ov35mBcVTtYgyJU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YFEICqlbt9hS7XmFWOnlPzyQEDFr8IXROE8AFm+UzxCkj72BwRAzBnj4HGXKY0b5QAy/KezQQYI0MSraydVy8VTiCTLMRanotIveTbSGGAyEB7DhiglaEQ8P4tNRnxrTwfm9IKU+ccuNC/yVjGpkmE53cxU/PWILdIDbFuy/y3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPFYEmmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPFYEmmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9542B1F00893;
	Sat, 10 Oct 2026 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791624545;
	bh=61DPnrI7LCkJRX+9zCPhILQOVQP9MTGG/p/5S1DBh2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QPFYEmmVVfOnHMigFJgbnpfTjBF9nQl1+suJBmrpCUmBs8OumOCelq6F4kazveqto
	 yLbj2SOb+tr4b+hp5UxTA9oqdWMAteha46yPmP+Lffi5f3ocz/8go5plQhAKTt7I2u
	 wwnh0B9EZt9/r6xwF/MYcvQILvBiVxvngFHEuuOf1ttkgyPa+cel3t6tXExN4nub4l
	 9jE89kSx/ROmipGoyKGGyIlI6BvBzcNli2M3MEVDvMlG8ORt2hVegcj+x8KeTh1FG+
	 tcdEr+pIvwX8OaiRWcvmsAq02M8ZD3OPV6vQGi4TONquDUdllzoL8DueaK1t93ZUdh
	 Lzi0KfojbpVAw==
Subject:
 Re: [PATCH net-next v3 2/8] uapi: if_link: Add RMNET_FLAGS_INGRESS_COALESCE
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 sean.tranchetti@oss.qualcomm.com
Date: Sat, 10 Oct 2026 09:29:04 +0000
Message-ID: <179162454411.434549.2276284843112941011@kernel.org>
In-Reply-To:
 <20261009084351.317632-3-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20261009084351.317632-3-subash.a.kasiviswanathan@oss.qualcomm.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] rmnet_vnd_headroom() in
  drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c adds sizeof(struct…
- [Low] Not a valid finding (baseline decision false).

--

uapi: if_link: Add RMNET_FLAGS_INGRESS_COALESCE

This patch adds bit 6 to the rmnet data format flags, named
RMNET_FLAGS_INGRESS_COALESCE. The bit lets rmnet be configured to process
ingress packets in the MAPv5 coalescing header format. Later patches in
the series add the kernel support for it.

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 245b362045253..349fcddc6622f 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -2022,6 +2022,7 @@ enum {
>  #define RMNET_FLAGS_EGRESS_MAP_CKSUMV4            (1U << 3)
>  #define RMNET_FLAGS_INGRESS_MAP_CKSUMV5           (1U << 4)
>  #define RMNET_FLAGS_EGRESS_MAP_CKSUMV5            (1U << 5)
> +#define RMNET_FLAGS_INGRESS_COALESCE              (1U << 6)

[Severity: Low]
At this commit nothing under drivers/net/ethernet/qualcomm/rmnet reads the
new bit:

- rmnet_newlink() and rmnet_changelink() accept it and store it in
  port->data_format.
- rmnet_fill_info() reports it back to user space.
- The ingress path ignores it.
- Nothing ties it to RMNET_FLAGS_INGRESS_MAP_CKSUMV5.

A later patch in the series, "net: qualcomm: rmnet: Add DL packet
coalescing support", closes this gap. It reads the flag in
__rmnet_map_ingress_handler(), rmnet_map_validate_packet_len() and
rmnet_map_process_next_hdr_packet(). It also makes
rmnet_config_data_format_valid() reject COALESCE unless
INGRESS_MAP_CKSUMV5 is set.

Before this patch, bit 6 was already accepted silently like any other bit.
The define on its own changes no kernel behaviour.

Is it intended for the uAPI bit to land before its implementation? Or
would it be simpler to fold the define into the patch that adds the users?

I also have a question about the previous patch in this range, commit
5a64ed6e084a ("net: qualcomm: rmnet: Update MTU handling during format
changes"):

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> index 5f921cddf82b4..d23f74b0aa471 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> @@ -66,27 +66,25 @@ static netdev_tx_t rmnet_vnd_start_xmit(struct sk_buff *skb,
>  	return NETDEV_TX_OK;
>  }
>  
> -static int rmnet_vnd_headroom(struct rmnet_port *port)
> +static int rmnet_vnd_headroom(u32 data_format)
>  {
>  	u32 headroom;
>  
>  	headroom = sizeof(struct rmnet_map_header);
>  
> -	if (port->data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4)
> +	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4)
>  		headroom += sizeof(struct rmnet_map_ul_csum_header);
>  
>  	return headroom;
>  }

[Severity: High]
Should rmnet_vnd_headroom() also count RMNET_FLAGS_EGRESS_MAP_CKSUMV5?

For that format, rmnet_map_egress_handler() adds a 4 byte struct
rmnet_map_v5_csum_header on top of the MAP header:

	} else if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5) {
		additional_header_len = sizeof(struct rmnet_map_v5_csum_header);
		csum_type = RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
	}

That makes the overhead on the wire 8 bytes. rmnet_vnd_headroom() returns
only sizeof(struct rmnet_map_header), which is 4 bytes.

The CKSUMV4-only check was there before this series. However, this patch
now uses it to resize endpoints whenever a newlink or changelink asks for
a format that needs a smaller MTU.

With EGRESS_MAP_CKSUMV5 enabled, rmnet_vnd_newlink() and
rmnet_vnd_update_dev_mtu() leave endpoints at real_dev->mtu - 4. A
full-size egress packet then becomes a MAP frame of real_dev->mtu + 4
bytes on the real device.

If the real device or modem enforces its MTU, could it drop these frames?

"Restrict supported MAP checksum configurations" comes later in the
series. After it, a MAPv5 device (which coalescing requires) can only use
no checksum or CKSUMV5 on egress, so the common MAPv5 setup hits this.
rmnet_vnd_headroom() is still unchanged at the tip of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009084351.317632-1-subash.a.kasiviswanathan%40oss.qualcomm.com

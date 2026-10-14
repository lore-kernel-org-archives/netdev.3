Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E8339390;
	Wed, 14 Oct 2026 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791943169; cv=none; b=sPqOViCVm/Tsp72jmD+ypndUtxlKIfnJKE0W+Tv5TrSYUJFm+RE0SmYhkzxG0iqFpPZjlCBlRm1SEAin9krtE7kx4zOu7uIyTmIwxOBEPip/eLysjE43OJlWYVJ6QoofG1CLR1L805NA1oCQVd+CwI6sjIOH06abDNgOhUsnG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791943169; c=relaxed/simple;
	bh=AiyJ52OcM0Sj3vrdZiJjZWowZoMOMnIdUKZNhJ/LdOA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kRGcWMnf5lG3vOOZXirQXiDYc6OWqz4Tyi0G0qFpdzVEuEnO4WHZ+YGL+uT9ERkoLUvT+gmcbIZYlgCcQ8WhlIn2I7DvF+I2BJF4h5osEi4evMpPqNEPXA9qMWXIK36qPYX38V8ZvbzUoSE4MwuzcUxr0LUNyI660xIrEOmwvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEioXL4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEioXL4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88AB1F000FF;
	Wed, 14 Oct 2026 01:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791943167;
	bh=W9jgADhTaora2pFmH7Slulmp35Le8z67tqRVe+nJL4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YEioXL4s3wZ1UJiLXshJIvO/pxAwL4jc9GCiq/n8bJvM4o+lVp/txmPG51SRpxICo
	 J2huAKADri165GlhREnmitfHJ3LGPEFvwwdF/4GLztWLTly0ZiPezUh7BxKd1BjoHZ
	 gkEtUsvzjS+x00zkEMukNHV2X27GMxO8wAvI3NdTJnQR4QyZBPDgc0pXlIWpa7PqY/
	 h5zQEBySQxm3LJCfFZ8+2bWkY48SEPc+FHCPQANWn539UmJl2Ai1jVRimj27qiZMZK
	 i7KyYLD+DHmOxWMVp4zQU8JQkTI2EllVL6uyjTiDMh1l6qWzixstryN6CdAs2denxs
	 RVzGY/7wpkkNQ==
Subject: Re: [PATCH net-next v14 4/5] net: dsa: tag_yt922x: add support for
 Motorcomm YT922x tags
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Wed, 14 Oct 2026 01:59:26 +0000
Message-ID: <179194316648.434549.16755403758005812605@kernel.org>
In-Reply-To: <20261013011122.1889766-5-kyle.switch@motor-comm.com>
References: <20261013011122.1889766-5-kyle.switch@motor-comm.com>
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

- [Low] The tag-layout comment in net/dsa/tag_yt922x.c does not match
  what yt922x_tag_xmit() writes.
- [Low] Concern: yt922x_tag_rcv() never calls
  dsa_default_offload_fwd_mark(), so the software bridge might forward…

--

net: dsa: tag_yt922x: add support for Motorcomm YT922x tags

This adds a new DSA tag driver for Motorcomm YT922x switches. YT922x uses
the same ETH_P_YT921X EtherType and 8-byte tag length as YT921x, but the
tag layout is different. The patch also adds a co-maintainer to the
Motorcomm DSA MAINTAINERS entry.

> diff --git a/net/dsa/tag_yt922x.c b/net/dsa/tag_yt922x.c
> new file mode 100644
> index 0000000000000..b6146a9af98b3
> --- /dev/null
> +++ b/net/dsa/tag_yt922x.c
> @@ -0,0 +1,122 @@

[ ... ]

> +/*
> + * To define the from cpu tag format 8 bytes.
> + *
> + * To-CPU (RX) tag format, 8 bytes:
> + *
> + *   tag[0]: TPID (default: 0x9988)
> + *   tag[1]: VID lookup
> + *   tag[2]: bit 5:2  - RX source port
> + *
> + * From-CPU (TX) tag format, 8 bytes:
> + *
> + *   tag[0]: TPID (default: 0x9988)
> + *   tag[1]: bit 8:0 - Dst port mask
> + *   tag[2]: bit 15  - Dst port 0
> + *
> + */

[ ... ]

> +	tag[0] = htons(ETH_P_YT921X);
> +	ports = dsa_xmit_port_mask(skb, netdev);
> +	/*To fill in the case where the port index is not 0 */
> +	ctrl = YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORCE_DST |
> +	       YT922X_TAG_PORTS(ports >> 1);
> +	tag[1] = htons(ctrl);

[Severity: Low]
This isn't a bug, but does the tag layout comment match what
yt922x_tag_xmit() writes? The commit message says:

    The new driver documents both the to-CPU and from-CPU tag layouts.

The from-CPU part of the comment describes tag[1] bits 8:0 as the
destination port mask. yt922x_tag_xmit() puts ports >> 1 into that field,
though, so bit 0 there is port 1, not port 0.

tag[1] also always carries YT922X_TAG_FORCE_DST (bit 9), YT922X_TAG_PRIO_M
(bits 12:10) and YT922X_TAG_PRIO_EN (bit 13), and tag[3] is written as 0.
The comment doesn't mention any of these.

Separately, the comment block opens with "To define the from cpu tag format
8 bytes." right above the To-CPU (RX) description. Is that line a leftover?

[ ... ]

> +	/* Remove tag and update checksum */
> +	skb_pull_rcsum(skb, YT922X_TAG_LEN);
> +	dsa_strip_etype_header(skb, YT922X_TAG_LEN);
> +
> +	return skb;
> +}

[Severity: Low]
Should yt922x_tag_rcv() call dsa_default_offload_fwd_mark() before it
returns? tag_yt921x.c and most of the other tag drivers do.

As far as I can tell, leaving it out has no effect with the switch driver
later in the series. yt922x_dsa_switch_ops has no .port_bridge_join, so
dp->bridge stays NULL and the bridge falls back to software bridging. In
that case the helper would set the mark to 0 anyway:

net/dsa/tag.h:dsa_default_offload_fwd_mark() {
    ...
	skb->offload_fwd_mark = !!(dp->bridge);
}

The port isolation and trap-to-CPU setup in the switch driver also stop the
hardware from forwarding between user ports.

If bridge offload is added later, would the software bridge forward frames
again that the switch has already forwarded, unless the mark is set here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013011122.1889766-1-kyle.switch%40motor-comm.com

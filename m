Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BB3AF664
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338705; cv=none; b=A490dkRMyTNBLwE8ByZacjng7ThipOiAPhoRpTFVrSZfEWnIjrP2W4u2gBZOS0fmzHq8dk6kiKhOWuX7X/Dz8LmU7oCl01pc/9JTHCQuh1CT+g5lu2UF8UV21kMjgGAi3RbhsQ/Bnz6aLch/9XuPZOQMVH4gDwCL+uAEpigkJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338705; c=relaxed/simple;
	bh=hCH1ilAJXykfj9wyewD+OBQUdkfcsObGt76xhFZT/Do=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q57jAb8IrrnAmY2o5Zs2pTleqjh8v3ooAU6tnLyQaY1bHnDqF6hPUlZ56NieMzvZBM8b1j4we7BNWVtuhpQvARG/Zcr+6K8VyjMWTNj+buadNUmslkAQZfVb/p6bY+x5RJad0iZlTWY+6uGLyyzYkD8giFoAq5rKRH+NliZm0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQbEgz5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQbEgz5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575DD1F000C5;
	Sun, 18 Oct 2026 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792338701;
	bh=62k0NWfEI4ZcNTKqzdabdskkNTfNI6c69tsOJjVCmQo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VQbEgz5qE68lDYxodJwadxnsKvcBtjnJZZuiBdZVM6KL3ivZshUNeyPs/jpYsVsro
	 IM0Z9DGUaie9nDGsF9lFAG/vHluLSE7zH/XhtnvgpKKZ2Zc8fBQZfQLZ12z/TyJNBG
	 QSqqmf3nzRS/dcrReqw88qDM3yeFqqTojWpflCw6a0UrG2oTj0z59FBUrOl8QniGC1
	 IERRxK9FVldxQ5z1d/whA7ODaEmxLOETvvt8NeZt+CCPmcsR8Kld61Uh3oAM/+yLh6
	 cXyZw5F9qn2NPC/T/4oaQTGxG+9sw1d6tAYCLYTNt8TBrSsvzqiNImC40e2mJ7yRxV
	 f0cUeuBZPaM/Q==
Subject:
 Re: [PATCH net-next v9 3/8] hsr: Add a magic header for sending PTP packets
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com, pabeni@redhat.com,
 praneeth@ti.com, pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
 vigneshr@ti.com, willemdebruijn.kernel@gmail.com, daniel.machon@microchip.com,
 edumazet@kernel.org
Date: Sun, 18 Oct 2026 15:51:39 +0000
Message-ID: <179233869990.3135.8968590846653304827@kernel.org>
In-Reply-To: <20261014-hsr_ptp-v9-3-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-3-2d20a2a0f816@linutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/hsr: OOB read due to mac_header vs skb->data mismatch
- [Low] At this commit, hsr_forward_skb() (net/hsr/hsr_forward.c:774)
  takes the new tx_port and has_hsr_header arguments but ignores them.
- [Low] The new UAPI struct hsr_inline_header
  (include/uapi/linux/hsr_ptp.h) cannot be safely extended later.

--

hsr: Add a magic header for sending PTP packets

This commit adds a UAPI struct hsr_inline_header. Userspace must prepend
it to ETH_P_1588 frames sent through the HSR master device, and it
carries the requested tx port and whether an HSR header is already
present. hsr_dev_xmit() checks the magic and the port, strips the inline
header, passes both values to hsr_forward_skb() and drops PTP frames that
lack the header.

> diff --git a/include/uapi/linux/hsr_ptp.h b/include/uapi/linux/hsr_ptp.h
> new file mode 100644
> index 0000000000000..a0b104a3df569
> --- /dev/null
> +++ b/include/uapi/linux/hsr_ptp.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef __UAPI_HSR_PTP_H
> +#define __UAPI_HSR_PTP_H
> +
> +#include <linux/types.h>
> +
> +#define HSR_INLINE_HDR  0xaf485352
> +#define HSR_INLINE_HDR_PORT_A	1
> +#define HSR_INLINE_HDR_PORT_B	2
> +
> +struct hsr_inline_header {
> +	__u8 tx_port;
> +	__u8 hsr_hdr;
> +	__u8 __pad0[4];
> +	__be32 magic;
> +	__u8 __pad1[2];
> +	__be16 eth_type;
> +} __attribute__ ((packed));

[ ... ]

> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 59df647d2fd45..72347477f4f21 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -223,24 +223,66 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,

[ ... ]

> +	skb->dev = master->dev;
> +	if (skb->protocol == htons(ETH_P_1588)) {

[ ... ]

> +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> +		if (hsr_opt->magic != htonl(HSR_INLINE_HDR))
> +			goto drop;
> +
> +		has_header = hsr_opt->hsr_hdr;
> +		tx_port = hsr_opt->tx_port;
> +		if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> +			goto drop;

[Severity: High]
Can hsr_dev_xmit() rely on skb_mac_header() here?

The pskb_may_pull() just above only guarantees that
sizeof(struct hsr_inline_header) bytes are linear starting at
skb->data. The skb_pull() further down also strips the inline header
from skb->data. The magic, tx_port and hsr_hdr fields, however, are
read through skb_mac_header(), which assumes the caller left
mac_header pointing at skb->data.

That holds for frames that come through __dev_queue_xmit(), since it
calls skb_reset_mac_header() before invoking the driver. But
ndo_start_xmit() can also be reached via __dev_direct_xmit(), which
does no such reset. AF_XDP generic TX goes xsk_build_skb() ->
__dev_direct_xmit() -> netdev_start_xmit() without ever setting the MAC
header, so mac_header is still ~0U when we get here.

skb_mac_header() then returns skb->head + 0xffff. The hsr_opt->magic
load reads far outside the buffer, which can oops the machine.

Before this patch hsr_dev_xmit() did not depend on the incoming
mac_header at all, because it called skb_reset_mac_header() first. Even
when mac_header is valid but not equal to skb->data, the bytes that get
validated are not the bytes that skb_pull() removes.

Would reading the inline header from skb->data be enough here? So would
resetting the MAC header before the ETH_P_1588 check. Either way, the
check, the parse and the pull would all refer to the same bytes.

[Severity: Low]
struct hsr_inline_header becomes permanent ABI with this patch. Will it be
possible to extend it later?

hsr_dev_xmit() accepts any value in __pad0[] and __pad1[]. Once senders
can put anything there, those bytes cannot be given a meaning later.
Could non-zero reserved bytes be rejected now?

hsr_hdr is similar. It has no defined values, and any non-zero byte
counts as true:

    has_header = hsr_opt->hsr_hdr;

eth_type is never checked at all.

The tx_port check uses the internal enum hsr_port_type instead of the
exported HSR_INLINE_HDR_PORT_A and HSR_INLINE_HDR_PORT_B. The values match
today (HSR_PT_SLAVE_A is 1 and HSR_PT_SLAVE_B is 2), but nothing ties
them together at build time.

If enum hsr_port_type in include/linux/if_hsr.h is ever reordered, would
the ABI change silently? Comparing against the UAPI constants and mapping
them explicitly, or adding a BUILD_BUG_ON(), would prevent that.

A smaller point: include/linux/if_hsr.h includes the new header as:

    #include <uapi/linux/hsr_ptp.h>

instead of the usual <linux/hsr_ptp.h>.

[ ... ]

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 6cc1812be15ad..14d793f00344f 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -771,7 +771,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  }
>  
>  /* Must be called holding rcu read lock (because of the port parameter) */
> -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
> +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> +		     enum hsr_port_type tx_port, bool has_hsr_header)
>  {
>  	struct hsr_frame_info frame;
>  

[Severity: Low]
At this commit, hsr_forward_skb() accepts tx_port and has_hsr_header but
does not use them. It still calls:

    if (fill_frame_info(&frame, skb, port) < 0)

and struct hsr_frame_info has no fields to hold them yet.

hsr_dev_xmit(), on the other hand, already drops ETH_P_1588 frames that
lack the inline header. So a bisect that stops here sees PTP frames with
the header still sent on both slaves with normal tagging, while PTP
frames without it are dropped.

The commit message says the values "will be used later". A later patch
in the series, "hsr: Use the port and header information in
hsr_forward_skb()", passes them to fill_frame_info() and uses them in
hsr_forward_do().

Could the two patches be squashed, so the new header only takes effect
once the kernel actually uses it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014-hsr_ptp-v9-0-2d20a2a0f816%40linutronix.de

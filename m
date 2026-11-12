Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524052;
	b=0Z8KEL6kswLlDaMR+QQAZwGJBSBjydUYVYmM6MW8cFJRjfZHeaTq+FWPrY7fABdG2bzt
	 nwLNUUwBEh87vL7lJqiN7WDhY6VWENK/QNRe1OT0Af+n93JAtTBiej4yPbWfuZeLDpK98
	 Iec0PKfAjXRpvQEaobh9n6WB53KaBiZaedmKQSoUFietvUQI/woZHDK4O4zNphuoKg0iE
	 kz9b+Wd4ydEgz5sCfgQr5+ieV+OGyaJW7yKMKisuveJRxATTZkNo/i08RVO0ylydL3qHG
	 0EIOvctL6Jt7bnTZfuFsqmgh+d1MIN6F2cRvkAV2SojxxyEEk/jzRMYJAbPrQXOii2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2wjhjRNZOp7PMeN4F2iNS1O6O7llQkNfYV2dZj3kzsM=;
	b=dz2dx8vqQGOTJ+jjZepw9e7+tGgGiaOZgTEnb6Z2AlZyESakoPxSoWI68j1j2Ht6BQVE
	 EjKjPaa5gdvjGwhLAFfcD+XlY+Ri8sm5IktGzfyKwM2HbvD7e8LqFOXAfTZXosacEIRuW
	 fgCnapsqjt6/w7jopO61H6HrqrrNJyViBXVJfUkIqGpkLz4+/VBL5mN1ORKP7l857+E6E
	 aQcN8Hj+e2MxmrVuif8tI7X8A9LNTNu+DDx2AD2hJd2SLKDXOBye/cyYUMmOeqZJAiy75
	 fqi76OIb0ljBxFK0edvTcG0iUNLqzSq10aVE+hYq/YEADvAMo+FwQ6GabJy6Q//zhSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IS/+0Ldi";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDE606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3FDE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IS/+0Ldi
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso329263f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794524050; x=1795128850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2wjhjRNZOp7PMeN4F2iNS1O6O7llQkNfYV2dZj3kzsM=;
        b=IS/+0LdiiK722TlsNkiXhyJxTkocp9F6WcKobL25aaIl3aVw5eHu5hV9tmiyuyOrji
         XborcmmEOpFGldpePSt1zscW6amHuBgOS6YRUTeD+0Al8YiNmkK8DmLVMzMokcv6Idk2
         TP5nT+O46J/AhYC2rPioiK/kI3cZx1F+ornx6g2gQ3S6/hhSMXX3KxPdXEfZ9w5WpIuC
         1Si3JUHalgPGMTZPBn2behzqBH3QoK1FqCpqgdtGZYehLAP4X+Cq/VxamOT2GPPttOsU
         BPhRlFXa/BaM3AwZMbXdp8JHEx/AatZbxafshTEGJVJ5olMLMiXNs1USjMh04tUCt4oD
         GlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524050; x=1795128850;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wjhjRNZOp7PMeN4F2iNS1O6O7llQkNfYV2dZj3kzsM=;
        b=lqx+91BF2mT6ztABxYEQYfBulcW+MQqkvKwH/8ZmwwFctFX1sODoUBZINqUNx8ukrg
         AOvSZkX/LPk+85IXeJZ1fUDhA8kT8HQlsQBA4kyCPQ+qAt6sXZ9NftUyYa+0zLcxY8kF
         r+M3YinRMV3p/PqI8ppkq4MaVR9SN8dkIRzrVUoEJK9Sotd9dLK+utS5ux3Vmpe48bck
         jLnupbm1FNfBgpst0eBiM+1i5xWxDq9fFM0NoCL6kla7WmIYJK7pk5WDNMZB49D4HoXQ
         dvap58IyEDYwnE/fmCajI3Xs/wQ8SbTM5X7FOqY+lK7/KpkkjS7scbFICmxsU4l1JjQ8
         5LvQ==
X-Forwarded-Encrypted: i=1; AL+hErH7gHLkDp1IESLoaO32cwPNOkLps2WSRepcd1Ft12t5zNoVTznUtIiPGmmAW/QBLL/I2S/HL4Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Hax6BC4JIPLQ1hiJCmjQkHxDmqDX6Q6i1B3DNL+U7Qwi7/XCy
	TYZIJIkdO2iPvULoS+t0oxqrk2D49zUHCoCILyzMiL+/2AxlSf+pisk2ks2vV6Pt
X-Gm-Gg: AYBFou21RbqPrSY3Uk58t5gTHYJOQPkflMlffmS+tq7ALgxwaTzk5w/Lda0AXqMDkz5
	035kRuOhHg07zqNtuTuNyYuWgecMKUoImGHO6X1MgqIYExzfjd980x4VBMDZuhMhJuI76tFX/cG
	R8U8S599Ux2R9i+xosgGUTRSzwSNywv+Ag3/+Te4/mmT//ll6pkcG074rVt2gwpL1DXbm7VyG4+
	AVEPJUVp/hGKXriClXh3/ZFK7CB5xm2VnmuTng6ClKF+HwaJ7zGZ/hYhwS1kx5NHPDSBw/zYKtL
	6j0W1DKcoqb43ePl61W7cTog12BRUrGayhq0ndHyG8fnUwcnKnUL19p6h7CNX96GPsGcRiHkQyN
	AyWMztKCuC17yT7OrVvva+HRF3bVFMG9PeE0yNbtwHhMMg4pRT1X7qQSDLcKWwkxae0C+/+otIF
	rFGxRr1HSVZF0JPryffIqb5/3sfq7W5Cy10WRSC9N5NmalEZVYTbLs5hdXeoQrqBFOCMUJgTEPC
	gf6B8ZToShVjcd11EqSoq60xkjBYnxyBiFCKp3lBBqxTh2Rxui4eJy7rIybjZDxMKQ4zcgpVS+0
	jJQA6uHwqN6Qzpu1qD0gTa6jQFd1QMVw7eLksyCk0oNW5osRZ+CUhtYHRpRbeE6y8A==
X-Received: by 2002:a05:6000:4911:b0:48e:4e00:b72f with SMTP id ffacd0b85a97d-49c71784fe5mr1685727f8f.32.1794524050328;
        Thu, 12 Nov 2026 14:54:10 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60021375sm1514575f8f.29.2026.11.12.14.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:54:10 -0800 (PST)
Date: Thu, 12 Nov 2026 22:54:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Jiri Benc
 <jbenc@redhat.com>
Subject: Re: [PATCH net 1/2] nsh: limit recursion in nsh_gso_segment()
Message-ID: <20261112225408.2d55959e@pumpkin>
In-Reply-To: <20261112102001.3744643-2-edumazet@kernel.org>
References: <20261112102001.3744643-1-edumazet@kernel.org>
	<20261112102001.3744643-2-edumazet@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 11:20:00 +0100
Eric Dumazet <edumazet@kernel.org> wrote:

> nsh_gso_segment() calls skb_mac_gso_segment() for the inner packet,
> which calls nsh_gso_segment() again when the next protocol is NSH,
> either directly or behind an inner Ethernet header (ETH_P_TEB).
> 
> Nothing limits the depth: a GSO packet made of stacked 8-byte NSH
> headers recurses once per header, and a 64KB packet can hold about
> 8000 of them, overflowing the kernel stack.
> 
> Such a packet can be injected with a packet socket using
> PACKET_VNET_HDR, or with tun/tap or virtio_net, as nothing checks
> that a GSO packet with VIRTIO_NET_HDR_F_NEEDS_CSUM carries the
> protocol it claims. It is then segmented in software if the output
> device does not support the GSO type:
> 
> BUG: TASK stack guard page was hit at ffffcad5c0ab3ff8 (stack is ffffcad5c0ab4000..ffffcad5c0ab8000)
> Oops: stack guard page: 0000 [#1] SMP NOPTI
> CPU: 3 UID: 0 PID: 337 Comm: nsh_gso Tainted: G            E       7.4.0-rc1+ #118 PREEMPT(lazy)
> RIP: 0010:lock_acquire (kernel/locking/lockdep.c:5902)
> Call Trace:
>  <TASK>
>  skb_mac_gso_segment (include/linux/rcupdate.h:309 include/linux/rcupdate.h:849 net/core/gso.c:50)
>  nsh_gso_segment (net/nsh/nsh.c:110) nsh
>  skb_mac_gso_segment (net/core/gso.c:53)
>  nsh_gso_segment (net/nsh/nsh.c:110) nsh
>  [...]
>  skb_mac_gso_segment (net/core/gso.c:53)
>  __skb_gso_segment (net/core/gso.c:129)
>  validate_xmit_skb (net/core/dev.c:4238)
>  __dev_queue_xmit (net/core/dev.c:5087)
>  packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
>  __sys_sendto (net/socket.c:800 net/socket.c:818 net/socket.c:2283)
>  __x64_sys_sendto (net/socket.c:2290 net/socket.c:2286 net/socket.c:2286)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
> Use gso_recursion_inc_test(), added in commit 006c8b834aed ("net: gso:
> limit recursive IP-in-IP segmentation"), with the same limit as IPv4
> and IPv6. The counter is shared with them: a packet with four NSH
> headers in front of an IPv4 header is still segmented, one more NSH
> header and it is dropped.

Might it make sense to get the amount of space left on the kernel
stack and compare to some architecture defined limit rather than
hardcoding a count?

In particular sparc64 is much more likely to run out of stack (even with
its massive stack size) than anything else.

David 

> 
> The NSH -> ETH_P_TEB -> NSH route is covered as well, as each round
> goes through nsh_gso_segment().
> 
> Fixes: c411ed854584 ("nsh: add GSO support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179443691180.2199510.148246238688217560@kernel.org/
> Cc: Jiri Benc <jbenc@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  include/net/gso.h | 2 +-
>  net/nsh/nsh.c     | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/gso.h b/include/net/gso.h
> index fe3260b381d4..119fc4c170e1 100644
> --- a/include/net/gso.h
> +++ b/include/net/gso.h
> @@ -19,7 +19,7 @@ struct skb_gso_cb {
>  	int	encap_level;
>  	__wsum	csum;
>  	__u16	csum_start;
> -	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
> +	/* Number of IPv4/IPv6/NSH GSO handler entries for this packet. */
>  	u8	recursion_counter;
>  	/* Max MSS segs per output skb, 0 = no limit */
>  	u8	max_segs;
> diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
> index bfb7758063f3..dd4de50fc38c 100644
> --- a/net/nsh/nsh.c
> +++ b/net/nsh/nsh.c
> @@ -9,6 +9,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
>  #include <net/gso.h>
> +#include <net/ip_tunnels.h>
>  #include <net/nsh.h>
>  #include <net/tun_proto.h>
>  
> @@ -84,6 +85,12 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
>  
>  	skb_reset_network_header(skb);
>  
> +	/* NSH can carry NSH (directly, or in an inner Ethernet frame):
> +	 * limit the recursion, as IPv4 and IPv6 do.
> +	 */
> +	if (unlikely(gso_recursion_inc_test(skb, IP_TUNNEL_RECURSION_LIMIT)))
> +		goto out;
> +
>  	outer_proto = skb->protocol;
>  	outer_hlen = skb_mac_header_len(skb);
>  	mac_len = skb->mac_len;


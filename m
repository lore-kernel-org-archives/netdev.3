Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579621;
	b=wAAmNoTpUKdeROK2OBrnCQoE0K/aLuXTvj7Wh9tyKt8aqNf7KLDoAhZVNtUMNvnf+7cr
	 JuigXcB7vc3k93b4PA8RSxmvPLYKzPANqh628aruK4Xt0DPK4zD+gll5NNKBaVupqjCA8
	 UboDUZJCUcmjeX+BjolP8b0z1g1MPkHinyXdv0yAQPAS0tjY+4lY4WmBss43mhA/BrMAB
	 swOd7GWNp5/s+0ClkoU5PJpnzz2RMt7o1GSE8D8YTId5ONqavw8629KVr4lea5KjxjZ+B
	 6HLGQymTOKh0P6H4hJLun2E5HSOQf+H8KuQqj36nsn6tlB46n3JpJwL5jShaGx1dusQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1XGp+CMXGHG/pi4uNlO7x2x1Sm+2mnO/G8onrrvTQjY=;
	b=3j2qNLCqcgDec+zapV205ZVElq0D9Mo5IiLRMzWwckS8Zs2GfDo4bIjbYqNCb2h9U4fU
	 YO5q5SJilK+MjjrELjEA+dPlJKOsAxWZciyTyNv2Xr0nd25hWt9eVECRPLjwZEyOnCsi7
	 Vd4hlEkN0J1uGiqePLjhO0lwP88upoLKVTrOSF2reLyagTxuWnsVsbX1D27uq6iQ28GWq
	 6GRrdFxqURag3IrTb9xh9XN58BlN35fGlnyZETqrki1gD5qipUNrmbsk+mDHjpVoZKeyM
	 Ebrzn8UGpt9MaPrb+/04kc0/jsZb3sVfN7i2vAWWPgANo9ROMRrEl8+GiOBQR5Ic9bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=JyEbpi8C;
	arc=none smtp.remote-ip=74.125.228.135
Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B7606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 506B7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=JyEbpi8C
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c505c42e4ecso58367266b.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 06:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1794579618; x=1795184418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1XGp+CMXGHG/pi4uNlO7x2x1Sm+2mnO/G8onrrvTQjY=;
        b=JyEbpi8CfOLUucQMMLXmwEo/6hJ8WdxOtOzP/yAknVS9nodM1YKqB+12gkWL/3rUgF
         8mku4p028Tfzw3L5pkS2ZcXWe5dDbZrtFNCkThBQ4IinjKx/q4KYOqjzvBietyY/OJ+J
         cUOEJAhiOrRg2EUecM8KBjJI/t7/OLsNOvUDvIm7vIAnp9pxp7UL+BoQSZgEHGwCOYqw
         QAWtxwYUJz2ZZXsrGDN6nuSxq1F4wv4wKd4Fd28xwzTQjR7EY4GKi3ZhcZ3DKp0JyvJo
         5UwXvogUyDKCkF6YZreK56p1HepTpAfengXBaWTg9VAWTnvoBbp3Qo5M2DE25+4zrohD
         m9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794579618; x=1795184418;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XGp+CMXGHG/pi4uNlO7x2x1Sm+2mnO/G8onrrvTQjY=;
        b=wm9QlYyWh4ksIoEtob0LFd0ubVMfLmpoaNb2GQHfPrRHk770kG6B1nOIINVXq1zZwh
         xScZBMw3COnraZDW+sBMM0F5bDKViofGuTka//KzKKp06NFRycH/v7vynu4QIALYm8/m
         5QgV3ZF2S0W5998Rf5v08FJHdNE6A8eoe1mfmjyjR/iPvwAyQ0j0gLPrvZ2xitordx/d
         vhXG9GcUIZ9XnQJiLbH0xrUeBbP94tM0OAyVrI7AaXfFkeQMfPQmBiZ60MzY4uLZZaCI
         AGO6ov2d5+m5Rd3WVM3muh+mP31IfbLFq93USeA/z7A9FzGxbYurqyvvzOiXmmKvDz4H
         EXqQ==
X-Forwarded-Encrypted: i=1; AL+hErH/NeFqrW2iNkIL90Z7lKQIvODcdaEiQbJQfBVWKNUgeJubS3PPc0FrBO/MG751CpQbKCBtHIA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ui+18IDkKarn7FxN3Yx+Du9T6daPbsppDRso+UfEZt6+gTcpM
	cT1AyqDfBtfTZwFcaNvP3sBKBgZH/np37iF9EVt/bQn41QyJjeBCHDCgsodjqf/dF8w=
X-Gm-Gg: AYBFou3UoRvLu6CT5uv56LfY6741wHK496+Bw2MnwuTT9Fo9cv8Ti0sNywULbUjIe/z
	1gpMY35/MX1fyGuqMltS7+BV0GbF2ZoJc684cdGOFy4kuin5roC3MHeiOl/c9H7DZCP2Hdm3z5q
	/9sy2AE0T8Gvsa3vjIxDXwCrDL6MbpfsluJoUBMWvlVNrsfMoPdgxcPIrgA2yrvdxuVjVD88qT4
	bfoPmX3krDVlWRIyvXbDfGUDWBgAc9NirRh/uxMaTc+II1Aa/wzGBiOkWkYhy6DC/KuSJ71kgCe
	0g5d8Kv3REw7qBfKEsjmJTn3xXQQmdOGo0Thtc4jE/xm9p8gLm/3U3iYhOw7j4bSQVspJW+Wnog
	Ft/ESh4E19qQBg81bpfSdTiHRwvraDeWjwRb6bjAGdKEwatm+Xv7xBeFaxhiUGxG8PaISHa5R3n
	e0FyacMgt7jj82p2bX7KOk3mE2C2pMlI5+lN460/jDujyaSK0Yi+JmBz0A6uq2eMQiuPrtPfLk/
	oVGQEicg3ia+8fEoVxut9ObaXBWCCBMLgJ6Fq4HO9xw0TnIFjXlkNLWmsE9vPTHJRSSZPd6Xr29
	KYEa9OS8g/NNN25FRwXhH76yB8Gm+gh6L6lM5xEjclGBO1oYj8yt1pMdcQI=
X-Received: by 2002:a17:907:3da7:b0:c2a:b1cc:158d with SMTP id a640c23a62f3a-c5096396869mr263379266b.32.1794579618240;
        Fri, 13 Nov 2026 06:20:18 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b5b078sm104083166b.56.2026.11.13.06.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 06:20:17 -0800 (PST)
Message-ID: <ae6f0971-d308-4c05-acc8-a1b16b29fa29@blackwall.org>
Date: Fri, 13 Nov 2026 16:20:15 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next v4 0/5] net: devmem: size TX net_iovs from the
 dmabuf layout
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, edumazet@kernel.org, horms@kernel.org,
 shuah@kernel.org, almasrymina@google.com, sdf@fomichev.me,
 leitao@debian.org, dtatulea@nvidia.com, asml.silence@gmail.com,
 bobbyeshleman@meta.com, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261111224740.2744522-1-sdf@fomichev.me>
Content-Language: en-US, bg
In-Reply-To: <20261111224740.2744522-1-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2026 00:47, Stanislav Fomichev wrote:
> TX bindings use PAGE_SIZE net_iovs, so a frag covers at most a page.
> A 64KB skb needs 16 frags, and MAX_SKB_FRAGS caps devmem skbs at about
> 68KB, which makes BIG TCP ineffective for devmem TX.
> 
> This series picks the TX net_iov size from the dmabuf sg table instead:
> the largest power of 2, up to 2MB, which aligns every DMA segment. With
> a 2MB hugepage-backed udmabuf a BIG TCP skb takes a few frags. There's
> no UAPI change since TX addresses are dmabuf offsets.
> 
> This doesn't make skbs larger. TCP still sizes them with size_goal.
> Only the frags get larger, and a single frag can now cover the whole
> skb.
> 
> An skb stays under 64KB unless BIG TCP is enabled. With BIG TCP,
> MSG_ZEROCOPY from huge pages can already create frags of 64KB or
> more. So drivers already have to handle them:
> - mlx5 has a 31-bit length per data segment
> - gve splits frags into 16KB descriptors
> - fbnic doesn't enable BIG TCP
> - bnxt has a 16-bit BD length. It is broken for such page frags today
>    and will be fixed separately.
> 
> Tested on two mlx5 400Gb/s hosts with kperf (udmabuf, 32KB RX
> net_iovs, 2MB hugepage-backed TX buffer), series backported to a 7.1
> kernel on the sender only. 1 flow, MTU 4200, receiver tcp_rmem capped
> at 16MB so it doesn't drop, median of 5 x 60s runs:
> 
>                                before    after
>    frags per skb (sender)       16-17      1-2
>    throughput (Gb/s)            208.6    211.2
>    sender sendmsg CPU (sys)     40.8%    19.5%   (-52%)
> 
> The receiver's CPU is the bottleneck, so the gain is CPU, not
> throughput. More of the transmit runs from the ACK path, so the
> sender's softirq grows (52% -> 59%), but sys + sirq still drops by 16%.
> 
> kperf output (sender side) of runs near the median, before:
> 
>    client: == Source <sender>
>    client:   Tx213.826 Gbps (1603901849600 bytes in 60007723 usec)
>    client:   Rx  0.000 Gbps (0 bytes in 60007723 usec)
>    client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
>    client:             0     0 633      2    0 15556608 7657
>    client:   net CPU 49: usr: 0.01% sys: 0.10% idle:44.13% iow: 0.00% irq: 3.21% sirq:52.53%
>    client:   app CPU 50: usr: 0.05% sys:41.55% idle:53.88% iow: 0.00% irq: 1.40% sirq: 3.10%
> 
> after:
> 
>    client: == Source <sender>
>    client:   Tx211.242 Gbps (1584440279040 bytes in 60004741 usec)
>    client:   Rx  0.000 Gbps (0 bytes in 60004741 usec)
>    client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
>    client:             0     0 556      3    0 15499264 7650
>    client:   net CPU 13: usr: 0.01% sys: 0.08% idle:37.75% iow: 0.00% irq: 3.87% sirq:58.26%
>    client:   app CPU 14: usr: 0.06% sys:19.48% idle:77.23% iow: 0.00% irq: 1.19% sirq: 2.02%
> 
> The bnxt patch was tested on two 50Gb/s bnxt hosts with
> CONFIG_MAX_SKB_FRAGS=45. With the default of 17 its check compiles
> out. ncdevmem sending 1KB chunks builds skbs with up to 45 frags. The
> stack segments them and the data arrives intact.
> 
> Patches:
> - 1: bnxt: segment GSO skbs with too many frags in the stack
> - 2-3: devmem TX prep (truesize, niov_shift in the TX lookup)
> - 4: pick the TX net_iov size from the sg table
> - 5: selftest for TX from a hugepage-backed dmabuf
> 
> v4:
> - drop the per-device frag size limit and the bnxt, fbnic and mlx5
>    patches. Drivers already have to handle large page frags (Jakub).
> 
> v3: https://lore.kernel.org/netdev/20261105222058.944293-1-sdf@fomichev.me/
> - default the netmem TX frag size limit to PAGE_SIZE, opt in bnxt,
>    fbnic and mlx5 (Mina)
> 
> v2: https://lore.kernel.org/netdev/20261103235152.1904727-1-sdf@fomichev.me/
> - reword the TX truesize commit message (Mina)
> - explain why the TX net_iov size ignores the device limit (Mina)
> - use 1 flow results in the cover letter (Mina)
> 
> v1: https://lore.kernel.org/netdev/20261102191438.1059771-1-sdf@fomichev.me/
> 
> Stanislav Fomichev (5):
>    bnxt_en: let the stack segment GSO skbs with too many frags
>    net: devmem: charge the frag length to TX skb truesize
>    net: devmem: use niov_shift in net_devmem_get_niov_at()
>    net: devmem: size TX net_iovs from the dmabuf sg table
>    selftests: drv-net: devmem: TX from a hugepage-backed dmabuf
> 
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 +++
>   net/core/datagram.c                           |  2 +-
>   net/core/devmem.c                             | 36 +++++++++++++---
>   net/core/netdev-genl.c                        |  2 +-
>   .../selftests/drivers/net/hw/devmem.py        | 10 ++++-
>   .../selftests/drivers/net/hw/devmem_lib.py    | 43 +++++++++++++++++--
>   .../selftests/drivers/net/hw/ncdevmem.c       |  8 +++-
>   .../selftests/drivers/net/hw/nk_devmem.py     | 11 ++++-
>   8 files changed, 101 insertions(+), 16 deletions(-)
> 

Nice, I also tested it with netkit and TXed a 2MB net_iov size.
For the set:

Tested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks,
  Nik


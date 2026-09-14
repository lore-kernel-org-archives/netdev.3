Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4539B4A5;
	Mon, 14 Sep 2026 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428955; cv=none; b=rRP//TYQB/V60uunex+VExghP0IcHC6UHvtI+3A/RSypOfcGWGTnq3tq8Q4BnVRSeNyEAv/lDpckmsNat4HDpwtMDU9rbVPch1m82wVKWfYxuWCZMvk5DAYqcnMwtq7otR7qnmwMEMP9y7UYhyn3QNw5qs7jqmAY9ZLaPO/XODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428955; c=relaxed/simple;
	bh=e5se2PCCXCuuQ0N24X/vEeKchXbPoFoVqhHUfm7Gzgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLMlrjjTCjOLkTNWe7vWlQfMHLbAOTDWvuwLwGP2JVmqqDuZtGvEV2MxKs4txNqYkzxVRfSxD8e3trumtl99+w0H0HhPxe/uDw6Gwt1H0X+Q5+hZ/VakdE+OYPNiT8KLg479kvZq0UIX4UWIlPGj1MJ9kdm3RamJxprVvKyvU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DAchMDFE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DAchMDFE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hV5S8eWWU67ONbMdimBKBA99jBaB6zXI/hRE2BYResY=; b=DAchMDFE+AqYzU+0lt+cwmQFG/
	xt+UdTYXZeJmP/j/GrhBYKPlK0C8Pt3NLUJvq+SL06LhjYWXZusHc9MZbCXcJAv58trdtmZEg8Mi0
	43nToNpVZcXnpCB3V44iUAOtB5cZpyhFFtOw8pElkTFLp8jcSXzLSOGJGNIzCQdKr65o07frIh0bs
	v1w7F1UaeKu1xeFxFR+OwsovdKt3sAUcvzObxFfrvVNJ3rL621BcbFwtTF7l+KAo8ZcedR8d6iYkU
	u2bROOmz4oTsAMquLR01RvQi9xsJ9d6lF0Mc/UpzmERGmax5NgBwo3T5VbwDDf7CmaY94gw0IbXW4
	IS+oiE2g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6GD9-00000004rt7-0Qst;
	Mon, 14 Sep 2026 23:35:43 +0000
Message-ID: <0b3aa22e-8939-489c-a3dd-c7f9552714d7@infradead.org>
Date: Mon, 14 Sep 2026 16:35:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 00/15] Begin upstreaming Homa transport
 protocol
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, skhan@linuxfoundation.org, bagasdotme@gmail.com,
 linux-doc@vger.kernel.org, corbet@lwn.net
References: <20260914230517.1190-1-ouster@cs.stanford.edu>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260914230517.1190-1-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/14/26 4:05 PM, John Ousterhout wrote:
> This patch series begins the process of upstreaming the Homa transport
> protocol. Homa is an alternative to TCP for use in datacenter
> environments. It provides 10-100x reductions in tail latency for short
> messages relative to TCP. Its benefits are greatest for mixed workloads
> containing both short and long messages running under high network loads.
> Homa is not API-compatible with TCP: it is connectionless and message-
> oriented (but still reliable and flow-controlled). Homa's new API not
> only contributes to its performance gains, but it also eliminates the
> massive amount of connection state required by TCP for highly connected
> datacenter workloads (Homa uses ~ 1 socket per application, whereas
> TCP requires a separate socket for each peer).
> 

[snip]

> John Ousterhout (15):
>   net: homa: define user-visible API for Homa
>   net: homa: create homa_wire.h
>   net: homa: create homa_impl.h
>   net: homa: create homa_pool.h and homa_pool.c
>   net: homa: create homa_tx_pool.h and homa_tx_pool.c
>   net: homa: create homa_peer.h and homa_peer.c
>   net: homa: create homa_sock.h and homa_sock.c
>   net: homa: create homa_interest.h and homa_interest.c
>   net: homa: create homa_rpc.h and homa_rpc.c
>   net: homa: create homa_outgoing.c
>   net: homa: create homa_utils.c
>   net: homa: create homa_incoming.c
>   net: homa: create homa_timer.c
>   net: homa: create homa_plumbing.c
>   net: homa: create Makefile and Kconfig
> 
>  .../userspace-api/ioctl/ioctl-number.rst      |    1 +
>  MAINTAINERS                                   |    7 +
>  include/uapi/linux/homa.h                     |  290 ++++
>  net/Kconfig                                   |    1 +
>  net/Makefile                                  |    1 +
>  net/homa/Kconfig                              |   20 +
>  net/homa/Makefile                             |   16 +
>  net/homa/homa_impl.h                          |  593 ++++++++
>  net/homa/homa_incoming.c                      |  886 +++++++++++
>  net/homa/homa_interest.c                      |  192 +++
>  net/homa/homa_interest.h                      |   92 ++
>  net/homa/homa_outgoing.c                      |  537 +++++++
>  net/homa/homa_peer.c                          |  669 +++++++++
>  net/homa/homa_peer.h                          |  457 ++++++
>  net/homa/homa_plumbing.c                      | 1302 +++++++++++++++++
>  net/homa/homa_pool.c                          |  553 +++++++
>  net/homa/homa_pool.h                          |  184 +++
>  net/homa/homa_rpc.c                           |  735 ++++++++++
>  net/homa/homa_rpc.h                           |  545 +++++++
>  net/homa/homa_sock.c                          |  544 +++++++
>  net/homa/homa_sock.h                          |  513 +++++++
>  net/homa/homa_timer.c                         |  136 ++
>  net/homa/homa_tx_pool.c                       |  527 +++++++
>  net/homa/homa_tx_pool.h                       |  139 ++
>  net/homa/homa_utils.c                         |  119 ++
>  net/homa/homa_wire.h                          |  346 +++++
>  26 files changed, 9405 insertions(+)
>  create mode 100644 include/uapi/linux/homa.h
>  create mode 100644 net/homa/Kconfig
>  create mode 100644 net/homa/Makefile
>  create mode 100644 net/homa/homa_impl.h
>  create mode 100644 net/homa/homa_incoming.c
>  create mode 100644 net/homa/homa_interest.c
>  create mode 100644 net/homa/homa_interest.h
>  create mode 100644 net/homa/homa_outgoing.c
>  create mode 100644 net/homa/homa_peer.c
>  create mode 100644 net/homa/homa_peer.h
>  create mode 100644 net/homa/homa_plumbing.c
>  create mode 100644 net/homa/homa_pool.c
>  create mode 100644 net/homa/homa_pool.h
>  create mode 100644 net/homa/homa_rpc.c
>  create mode 100644 net/homa/homa_rpc.h
>  create mode 100644 net/homa/homa_sock.c
>  create mode 100644 net/homa/homa_sock.h
>  create mode 100644 net/homa/homa_timer.c
>  create mode 100644 net/homa/homa_tx_pool.c
>  create mode 100644 net/homa/homa_tx_pool.h
>  create mode 100644 net/homa/homa_utils.c
>  create mode 100644 net/homa/homa_wire.h
> 
> --
> 2.43.0

In a (mostly) x86_64 defconfig, where CONFIG_MEMCG is not set:

../net/homa/homa_rpc.c: In function ‘homa_rpc_alloc_server’:
../net/homa/homa_rpc.c:133:22: error: ‘struct sock’ has no member named ‘sk_memcg’
  133 |         if (hsk->sock.sk_memcg) {
      |                      ^
../net/homa/homa_rpc.c:134:68: error: ‘struct sock’ has no member named ‘sk_memcg’
  134 |                 struct mem_cgroup *old = set_active_memcg(hsk->sock.sk_memcg);
      | 


-- 
~Randy


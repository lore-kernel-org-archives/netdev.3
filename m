Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582325;
	b=xSg/oq/N00oKQSb9f/pGqzqm9umPvA9tKhx/Htk1JN1KaMN18ljjptFfpSEwNh3Jao7d
	 cxqcrt6Up1QVCS1XCRzbBmhmOTUOJMz6a3HXV4mw//4q5YnOJZWnCMJIb3Bj3WfTDZLkU
	 4KhgVPzi8nE2oKt7zA7RAhWYKikzX/srPvkRCTPDnDExD4g1dVBNQhAFLt8PfsvCooErH
	 sxzN43v0jCof0Wycz8gR5rHnAjfmajnNY9zg9Ku7yCQfCaqGwXPN+Zi1GDbekJ00O+emQ
	 eJcPjdoFgWa41fij9tRXUpe9TT7crOLz4ehywxGluNKwXbxq6Y+gtkAHzpyCU6/C/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2f1raRIoZgSJe6BtpPmhaeQkzdM/j6PifCUQ++I8vXg=;
	b=YKiQaL/NdTE3VoXEIxbTii0dOCttTMyRuh/V9JtZpofPUjetTur95gCk+kHuxB6sR1eX
	 LVfSyhm1WuDVqWbintrBfkZLNMw7c6TeBLmnHKhPmwa6v/bIKgzRmrPrwPoIScNS0nsn2
	 oNgl5zdHKK8nfqzBKxNxrIGFmw1r55xZrS2VusuxIEV0jKBpp9xeD3GESAqvcCpeG9ZEo
	 ZwjZu+bN1LjDRGOQm3BawPjAsRco0FzNa0IquW6krtVnUjb/dujji7/D7kfw2jG6wZ5gi
	 j0lbsqtc6vHiXZdE7Wr7CUn1NOhue3lxuNzg+tL8vInFQDWOgUVGkd59Z8cxtUIZlZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=Ei8IKGYG;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CF606A337
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 214CF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=Ei8IKGYG
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1bc97805eso1629415e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1794582323; x=1795187123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2f1raRIoZgSJe6BtpPmhaeQkzdM/j6PifCUQ++I8vXg=;
        b=Ei8IKGYGWcoK9QjdydTkF10zRLaQaeDMieIwakCp07qmLfmRMJubdTmAdITirTvE/x
         sesGzVdNpsP4C2xv5GXRBRFnAHcgd79luhnyIjLRRNFYK8Bosx1mQQY9QJXbvzHCj/Kq
         HGB66t3mnI4EHar23n0b/SseeEDbmwMJTEsU08p+E8PnlsdhcTpGV03x+uj5yHyGH7n+
         7n6VGeu1FzBDBSUs/emInh2G6sQSZ40ha4zstUM20fPa0FM//hZPoeQXkpUG5znz57Tm
         eIOtZ7VZHV3vhd4nTWvCf3weC9zx09UgrvrDwJYkrZdNODKujXzHxr+sjJJzvHHwm8P+
         0VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582323; x=1795187123;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2f1raRIoZgSJe6BtpPmhaeQkzdM/j6PifCUQ++I8vXg=;
        b=jcLh6Q4dO1G6imrFBUTtFUlaWPndetnwjvLNStD2uFyKDg5hpO9lePqp3bBCrakHUp
         j8Rm+O36pmYnaoRxMFTrRxewcGbX1QosmbKQ0u3FTb5p9qsor1Sp/WbATWDnPcwny4/p
         zIhxlEu8pX+T2/CXB67hVKl8MUhnBV4Y/0m4FUKHsqkvf0gRsHpkDBSC0UXCnf0RCJZH
         4BAyjE/DCksmucWMS/RzwV5KcxlG2H2gcaEhoHq2tahAi9Z98geuYDiWqNkaZ3Zm5Mmx
         hVludXfULXYhkSrdUN94g2PHhP9KUTTET6fp2+hhCFaJhCKgYcAgxyQdDArPtuvjuyP0
         hMmg==
X-Forwarded-Encrypted: i=1; AL+hErGj4S16cRxg0Peq7DrbFKev3axFyslELo18i5U0gUSzlIJ+evrEFh+foXGt0nNmEnbfxXO/nGI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GzK6yKqXmACjBOsNvTkCbZzXv/ip/aDCrL3/RNbFMnv1J6wXk
	nWYSQULpm7W7pLZFwD4od5OyMbyZC/f8lEmSgN/zo8izGNI+iyPaWvFQxiwttr4DZD4S2Gpkd3u
	Sqkf5li4=
X-Gm-Gg: AYBFou1s0WSMVq82DQiIUHNUT7em1PFGfYH1uO67UX46UHgpzKz/0acgCiD0y2hqYLE
	EfgBK5wt6BcRSlfRbUbNLvGteiToVtGTUL1OrqQkikt86HNvhLspTLmOlQ71GA842CKDPQNxjJO
	4XL1A9PDhgjHKBT4lhoawoA0wDGDbrOJIvka+WMRehAag9NxYJLSjjzg+5KAp7GWrGEF+GBVd3v
	AR/6kzP0WO6wGLOq3UkZp6qh2K4EBo7KsUWTRV+8o2+YtSt4TvPJRJuTDhpPU0R746eR+T8F7C0
	8YCGGDXuh7MGuoxJwowmigFXNgSJPimvZHoyupSWa19fzfktIZWyJiCnbzuUXzA+dyr5VCDL8wy
	Ed+3perdHFLbknWT+z0Aa5NG6A/gNcK/IJ7FwhLlMfoW/3MHvJ/d+Z+U8oeaRjxNdKTxOmGRuM/
	VLNqIStooFnD2/MsKgO8EoLqHg2Mr/xLLi4SlnoNba0jZk37gJdUcPtRwOTBgTJv+kdjGXa2aYJ
	KfkpWor6S7nksSIOmZLUu3h3w4wd6DjOOZcrSGqz0zI+io4ALD+NN8QR90QXvFRnswvuDYMOyid
	mSRapjPtK2xaouClJ5XnbcaM4PdGwOv09GtTIZGzR1URIreVUUuigFcbtRjxLFlEX5qAHjdD3Fe
	skN2KsF8qCr9ZHONAIq1/WruZevM=
X-Received: by 2002:a05:600d:644d:20b0:4b2:3c81:103 with SMTP id 5b1f17b1804b1-4bb55a3cf01mr47914805e9.2.1794582323429;
        Fri, 13 Nov 2026 07:05:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55a0ffcdsm65496515e9.0.2026.11.13.07.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:05:23 -0800 (PST)
Message-ID: <72d0afdb-c2c6-458f-9363-d16c32220a6a@6wind.com>
Date: Fri, 13 Nov 2026 16:05:22 +0100
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
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v3] vxlan: reset the remote's dst cache when snooping
 moves a MAC
To: Zhefu Peng <ilskdw@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 mschiffer@universe-factory.net
References: <20261111180001.2475-1-ilskdw@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261111180001.2475-1-ilskdw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/11/2026 à 19:00, Zhefu Peng a écrit :
> vxlan_snoop() handles a known MAC that now arrives from another remote
> by rewriting the remote's IP address in place. It leaves the remote's
> dst_cache alone, so the next packet to that MAC is routed with the dst
> cached for the previous remote. When the two remotes have different
> next hops, the packet leaves the wrong way. For example, if the
> previous remote was on-link and the new one is behind a router, the
> device resolves the new remote's address on the local link, the
> neighbour stays incomplete, and traffic to the MAC is blackholed until
> the cached route is invalidated, such as by "ip route flush cache".
> 
> The same branch also leaves remote_ifindex unchanged, although the
> early return compares it and vxlan_xmit_one() uses it as the output
> interface. When a MAC moves between an IPv6 link-local and another
> address, the remote keeps the previous interface, and every later
> packet from that remote enters the migration branch again.
> 
> vxlan_fdb_replace(), which makes the same change through netlink,
> already resets the cache, updates remote_ifindex and clears offloaded.
> Do the same when snooping.
> 
> Reproduced with network namespaces: a learning VXLAN device has one
> peer VTEP on-link and another behind a router, and an inner MAC moves
> from the first peer to the second. Without this patch, pings to the MAC
> fail after the move until the route cache is flushed: in 10 of 10 runs
> with one CPU, and in 5 of 6 runs with two CPUs, where it depends on
> whether the sending CPU holds the stale entry. With the patch, they
> succeed in all 16 runs. In a second setup over IPv6, the MAC moves from
> a peer with a global address to a peer with a link-local one. Without
> this patch, the move and every later packet from the new peer each send
> an RTM_NEWNEIGH notification, 33 in each run. With the patch, only the
> move sends one.
Maybe a selftest could be added to check this scenario?

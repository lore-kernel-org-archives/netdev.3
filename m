Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B453B05A2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879247; cv=none; b=hpFPpw7yONx2ez1VOdL9X+bGZVgqwHAyQB+KkxlmyRyLhuPwPx5HlggryBJbRQ1Y7aG12jyqMYDSF3arJVL5lwePhQCQvubzuuMhi89Q1O2G74gnrvZ2LC38LNtvi0zpO1ucAilXV8e7wONpArD20IF/qwYA+ViK5bbQhT1U+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879247; c=relaxed/simple;
	bh=kIJgnr/8fmPQEMfTYzL5uGySgGwig8u7nUKJCpef/Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iu/m3Xm7ayg76dtbO09v9oed7AVXyQP9JWHcHsNHllLHQlfeumhY198SpC+C3fOdkk7A8H20L6XL6OIfkuufySk9XTuFauYTb9E0yvGZcGTbKQWw01P7edYcA+/gTS47373Flw97vDgTvGL5Gkrdb4koS64LbIMx8tGfxIVdqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD/Q0JS1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD/Q0JS1"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-887fb6c0ad1so640328b3a.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879245; x=1792484045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAUohNgu9SSrZDroQ9BQ1lUYsCyK2OM4/OMeA6X2nw8=;
        b=LD/Q0JS1KfAH9ozBu8mmRbkdFBOPqXFmyhukUxecCJP/bfjVeDdpmNmMH13KgBeVte
         +qee5k7IMopgj4vo9keawScXOWIww6fYUmM/HjTZNl6pG0MWu8AVzJg1FBqreEKdp50b
         3r6yZczIKNFjs176qaRLUOVkBN+IeSW9GyR8a7a5ie3byMG2IFhHLdC7ZouiviX8a2qB
         hREDri3o8ab90o+cfkfCBQ8iIK1MOIsEtVaSLn/CH0v2To7PUEsexYkQTYJj/NA0FyrT
         Ro3uIQ/nnpw324mWVJgbjwDS+DE+qwvOyKTr9ezc2u6wKZVgXAU+ypDZV0eMREq/Z1Vo
         EXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879245; x=1792484045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oAUohNgu9SSrZDroQ9BQ1lUYsCyK2OM4/OMeA6X2nw8=;
        b=FiubB5m8HQG2dBkjFzZ4BIGL2ekit+bvzpP4tIXYEp0nAqPlq0n6oi3y5OCvX9sZft
         IcSndC7GhUdw+xVwvU8ipX9xkj0QhOsrtUivU7h9vI77IWPetzkFq3cEL3Kwl+8+vIDG
         GM3fkQLhdaGEzUKzfSLfoSTs4rgHn1r3+p5syRyRtszSUrDAQbpgyzbPlwSupRmCIrns
         PLt1hSggPKxmdnFGHkQkPylGp/d5wf/0mSGiXlmmEm24vCcJluqvTuy62yF8+5c559hT
         TWJUWXwqHZfOOBkLuY1+Gf+70oqqySntasKZIVsRItE7dZqEbyaswc1dXlKYI1pPl+vk
         X2Cg==
X-Forwarded-Encrypted: i=1; AKwUvBwM/SgU1JnHudCWr0x0GY9OupUWomj08dqDvpLbze8gAR/Kv/p6a/ECBsjvz2tAyn65CfWxEL0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOEQHAZ06o7NZu44ASYc6YeTB1emqjZTnb/wCYz8UyCfQ715RF
	0mh8meXqm7i6r7TRVu7EyRc4HaGeW1zJqX0ELWs6kibbi+52HpcveFcc
X-Gm-Gg: AYBFou0wFuVA8rfT8vLVIVB6J+9dwfkL2zmUZy8LsCGTG98HcKe57jFMirfjCFUtpas
	PKYuJYowxZnuwydV2nMXj5rrTmmND76avqhOm/9fG7s0LfPZnF2V6xPO9/ZSPvVZB3P30IUqc7e
	78pPrkaCjoMbThe4ys7LFjGoCzBVs9FzAPa9Js8gEss9vUUVghfy3OBsvPN8XxprZULttZOK7lY
	oiYjI/0Qt8f3NUOykWGk+Q4P2zJm85335JkRMg5kk/62F/T7WG4pFc0nROUwWWHK6rDhZXZ1e7K
	0ZQXORzjR/UnyA3ZDnQuvjpnriVHA7ZN7izAcXDdmN/5H/AZkNkAKMci5ZrwEbbzCBXUvl51+vH
	xgld9BN6HNWerNWcKAz991aTfVt0RBJKw+/ccRUjIPC3hLAvZIGg3ikdQyDSA/ptnei9CsIrvOd
	0UyPtk5pqoEgw3zSkC3OFJXMxboqNZ2gn00eINYraM44879ueWuW74oPZf3I7VMITs6PcG+WK7j
	RyW8drcbhK7hOJ6RIIlra2piKdEdbRd8W0DMrovmLSHmy6971uP0cTRht7c34GJ8w==
X-Received: by 2002:a05:6a00:4185:b0:890:a3ed:8a49 with SMTP id d2e1a72fcca58-897c7cd481emr10083173b3a.51.1791879244700;
        Tue, 13 Oct 2026 01:14:04 -0700 (PDT)
Received: from [192.168.99.4] (i114-183-29-19.s41.a013.ap.plala.or.jp. [114.183.29.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-896c469d2a8sm4606502b3a.52.2026.10.13.01.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:14:04 -0700 (PDT)
Message-ID: <65a3e29a-24e0-47b3-a189-903b1a33c336@gmail.com>
Date: Tue, 13 Oct 2026 17:14:00 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] veth: clear rx queue hint in veth_xmit
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org
References: <20261009040412.14571-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <20261009040412.14571-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/10/09 13:04, Jiayuan Chen wrote:
> With more tx queues on one end of a veth pair than rx queues on the
> other, and RPS or generic XDP enabled on the receiving end, we get:
> 
>      veth1 received packet on queue 2, but number of RX queues is 2
>      WARNING: net/core/dev.c:5212 at get_rps_cpu+0x560/0x1360
>      Call Trace:
>       <TASK>
>       netif_rx_internal+0x1af/0x4c0
>       __netif_rx+0x99/0x350
>       veth_xmit+0x713/0xca0
>       dev_hard_start_xmit+0x166/0x5f0
>       __dev_queue_xmit+0x1797/0x42d0
>       ip_finish_output2+0xa34/0x1f40
>       __ip_finish_output+0x510/0x7e0
>       ip_finish_output+0x2f/0x320
>       ip_output+0x17a/0x3f0
>       ip_send_skb+0x1bc/0x220
>       ......
> 
> Easy to hit with "ethtool -L veth0 tx 4", "ethtool -L veth1 rx 2",
> rps_cpus set on veth1 and a few flows sent over the pair [1].
> 
> veth_xmit() uses skb->queue_mapping to pick the peer rq, but never
> clears it before veth_forward_skb(), so the rx side still sees the tx
> queue index. Everything on the rx side that goes through
> skb_get_rx_queue(), like get_rps_cpu() and netif_get_rxqueue() for
> generic XDP, takes it as a recorded rx queue and warns once it is out
> of range.
> 
> Clear it before handing the skb to the peer:
> 
> - It is the tx queue index of this device, it says nothing about the
>    rx queue of the peer.
> 
> - The two sides don't even agree on the encoding. The tx side stores
>    the index as is, the rx side stores index + 1 so that 0 can mean
>    "not recorded". So tx queue k is read back as rx queue k - 1, and
>    tx queue 0 as "not recorded".
> 
> - Commit 710ad98c363a ("veth: Do not record rx queue hint in
>    veth_xmit") already decided that veth should not pass any queue
>    hint to the peer. There is no tx->rx queue mapping to preserve, so
>    nothing is lost by clearing it.
> 
> On NETDEV_TX_BUSY the skb goes back to the qdisc, which looks up the
> txq from skb->queue_mapping to decide when to retry, so restore it
> there, next to the existing __skb_push().
> 
> [1]: https://lore.kernel.org/netdev/156834bb-8e40-496e-9443-9d515fa18eab@linux.dev/
> 
> Fixes: 710ad98c363a ("veth: Do not record rx queue hint in veth_xmit")

I guess the splat can happen before this commit.
I'm not very sure but probably it has been possible since after 76ff5cc91935
(with ip link add numtxqueues & numrxqueues, instead of ethtool -L)

> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

I agree with the patch itself.

Reviewed-by: Toshiaki Makita <toshiaki.makita1@gmail.com>


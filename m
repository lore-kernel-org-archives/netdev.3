Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261499;
	b=duVK7TzrNPQW5i1KeJVLt2p9zjP+b7JbAlJuG7pw2ePws+4nvgWq70n91MbeEodXR0WY
	 bj/3J0rNXTBhwNg7aaG7Mgr0e1ZQkGHNRWBnrLP8JQNuD4/UvJ2yUQRi2UaxUljHkGcsW
	 YfA8gBYq/7rrq3wgcQ5wxNX6B2Dg0cvjIeVvFh7mCN2rX6f8NauNvVQkF4WAcBTTOjhUY
	 G8TFW0xzjeFP/V+ZZn3gw4SJkjp1ZEXWv0Wgg76EhKDtXFYr9kiLTc6eF+RPNlhR2sTvc
	 MgHOAYUd/8JfX/oH/vDJ7fEfH4PwnBOG/c1Vaup0FcQ31U6sTim3SDE60sn62n06BjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=q03BRgBOcQNLCRjgQwIL6L5lX3ohT8w/lgFYZ6hcCWg=;
	b=DRTNUeSPvUjc10IIS0pux43vd+SMflcYpmoae1GmwIeasIR5APhGexF0XvhvWYDgWENu
	 Gdv4qlgwnnyMsjSwbqJFR8i3uq3NQikUk8II1xrli7/hionXKP4IQ/EarrVvQBDMrofbk
	 OnpYHRc5oConkopP1+RMd9I2+vAvF8kSe5/AdcihbjKgX/CF10MlI3NpRiivWX3h8Cn8f
	 XWVc3P3igxXHwrWHfA+HetCcIiXOr5EDYja0HuG+kweHXuRRq8SDK3nwcrU1T3Ut0ofh3
	 I4vP/cZHyZz4hAloDRr7gQ1hwqgaKVqdV5z2crbMcfw28GNSZfLfJoU9GmkXGodvY5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYO9x1Mb;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9162606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9162606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYO9x1Mb
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso2028134a12.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794261497; x=1794866297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q03BRgBOcQNLCRjgQwIL6L5lX3ohT8w/lgFYZ6hcCWg=;
        b=zYO9x1MbNwJ+vVirkbtAQ6GaGoIyfE3bXBdqwm8xZu7VLwvhFj56va0o++rdqRLDXj
         cX66Kt9oSCJSpPoic6oQcGqR90HFFOxD/LZDxfImAPBjX8+96UIQvHzxHYTcIYq3pSn8
         LeGbjCvPRg0P96wlmQyrNk2DlMCC6cpXszeBXUmTCJyxQFuWMC4L2xIu2LZqJqepnUCz
         fUSxPTQaKY9zrJpgs/A4ddA4wfQQfo8q4VgRxWqnISyokRQ7EooIkZaVRF1dd3pY47B+
         aRuCilGOQNLoZlBPm/N6cn25j/fuxjlXwPF+ma6WsWRx+ocCE6JRIri+aWgVv/urFg9C
         e33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794261497; x=1794866297;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q03BRgBOcQNLCRjgQwIL6L5lX3ohT8w/lgFYZ6hcCWg=;
        b=Qbyfr8OqqZN1wca9o+LkSPgzASOwA9Ukqute5ZbyWcCuU4jTlgmR5Ty8CFhXzqhGAl
         ccb5OFFxu/2RLf6dHUOO7lk/f4/h7GE+RPU7KGfwMs3Jds2xy5JkfrVe3K6vaOrZ9WSq
         mGt4tuL/NBsNK8oX0DQtxt4zQUORZHfAnDJQgAhF9WecsUTwgfMa3sR5H/lisnfh5qCH
         oOAUV/EudfvSHcDjfUEbBpy6/eO7OJ/NvyzwSibc8yzf90e9gZLwfTkFeJkRW/dK6zKk
         urDZzeJDHyCoeFvLIzhIjbO/SddpNRWyXcRnGy2ZROrbz3WBmg4bxfdAKfkj4FgnE0Ss
         PPyA==
X-Forwarded-Encrypted: i=1; AL+hErHwd4AxKCArWMjvusrWLRQpAq4AJo5FieSrVoe9x0MmsWh3lHP4nhl3+iv2yq5OfmTo+JckZ2E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Zck5lt2BaxJlju3VEhNLGQCB9C60DhNwwHiHTiUsyMEOIeQV6
	EYkXeZAPWsalcFt7E8tGimEJlW9p0ZhpGTbQCYohOIqeKdGnytjCyCL8
X-Gm-Gg: AYBFou0vVL6BbIm03FjGE31pF+ZCyuwIZ8FjLlk2Lbf2VJskPFoId1iPH7XzAwSbGPP
	qFpwXpr1Y24UvBPHfRqtLiULc1g0HePzf0fd1W1BR9QHfBypsyfg4k8oF9z/wE4TLs6YELqObZt
	xjQ2iAhKOv1JdkAeBu8etp3aCijXBxMOwk14+BhqxeVOmJWQSnN24lnHumm8GUfTkHq9WkF7K+2
	tCnTcMG35SEKGIETBtCA5AJmxnKzWTq1kS13N79dIbwAh5OG7Rvvig012B3tPSYiDnMYlTUCNnP
	S47yhRdA50cdgho644Tnxi/eVHQ6Hv5b5oDIE8uAOe5oagVIHRNCkka3UeALeHbU1s8J5OGAiim
	nbWiGXQCJEQthjmo175VWaMSD9dmNHQBG0B+ifXlzpJbJVU1s+anLYD+g7BSopJu8HNKd3+SYfs
	uAsum63mYn7gf/74yubref0s3Ewxw92nIHE4pT0OshXBS9tmgfc3BUn0QreBVolSYelJlddG+vr
	yLtuQNNj4gseoAPATHGVZAr27F4uOFrKUy20/NzPW9KfVtoelYXyyYX0Oc6tPxCfcMxxcDmsPja
	vNVi0wRKCv2eSHhqj/XNZW4b9PSnUfKvD9r3FeWd18QoukRzeJKorkAn4WpTGUNGkmAMZHrRR5U
	ApSqwMw==
X-Received: by 2002:a17:907:1905:b0:c45:b99:f282 with SMTP id a640c23a62f3a-c50491c3b10mr53885866b.7.1794261497276;
        Mon, 09 Nov 2026 13:58:17 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:b7ed:a37a:5b51:f302? ([2a02:a03f:a75e:9a00:b7ed:a37a:5b51:f302])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a685f99sm20298666b.82.2026.11.09.13.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 13:58:17 -0800 (PST)
Message-ID: <1c0bd741-0e5d-428e-ac89-3907d62c4eb9@gmail.com>
Date: Mon, 9 Nov 2026 22:58:14 +0100
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
Subject: Re: [PATCH net-next] net: lwtunnel: use GFP_KERNEL in build_state
 paths
To: Max Boone <mboone@akamai.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Donald Sharp <sharpd@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Debabrata Banerjee <dbanerje@akamai.com>, Nick Hudson <nhudson@akamai.com>
References: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 12:40, Max Boone wrote:
> Since 3d25eabbbf67 ("ip_tunnel: Add dst_cache support in lwtunnel_state
> of ip tunnel"), build_state runs outside RCU and all its callers can
> sleep, but paths still use GFP_ATOMIC.
> 
> For dst caches, that limits allocation to populated percpu pages. A
> large burst of SRv6 nexthops outruns the refill worker and will fail
> with -ENOMEM despite there being free memory:
> 
>    percpu: allocation failed, size=40 align=8 atomic=1, atomic alloc
> failed, no space left
> 
> Batching 20000 RTM_NEWNEXTHOP under QEMU gave 10-109 failures per run
> before, none after.
> 
> This commit converts the allocations reached through ops->build_state()
> and are called after the rcu_read_unlock():
> 
>    - ila_build_state(), ioam6_build_state(), rpl_build_state(),
>      seg6_build_state(): build_state ops
>    - bpf_parse_prog(): only called from bpf_build_state()
>    - lwtunnel_state_alloc(): only called from build_state ops (also
>      affects mpls, ip/ip6 tunnel, xfrmi and seg6_local)
> 
> Signed-off-by: Max Boone <mboone@akamai.com>
> Reviewed-by: Debabrata Banerjee <dbanerje@akamai.com>
> Reviewed-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137982989B0
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659758; cv=none; b=nyIA9Gb8rRp/HzbelAeIfI/QswuRo49Lzju+1FysuehYCcFlBK9cE3ErbD2EXN8w7GPV174KSGohZKbPk9abzdPCoW/uMcn90JqS6EwmYKMmueYqZqxs8nRYtowOZTwxcUwsnSGJR+foj1j9DZCJLke1Bt6+4yM93oG1ZKrW6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659758; c=relaxed/simple;
	bh=nTJXNnfk8n4fecxfr1CWT+9dekZ91IAUUDBN1nebJ3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWqUxCRv6XKxeB69usgoj/pMX+uxx/3bcFtE2/KYcoxxso6d3i51z14iuZwo1+9LdXSLAx3vvsOiVpCzQYlwbY7xHrd2diMLIy+Y7EEjjiEZk3fLnUTyTqIkb7xrpUXcBsqLSXH2TKD9oi9mnfRQrndVKHNHyIdvMrf+hsn3Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iAhuakqL; arc=none smtp.client-ip=91.218.175.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iAhuakqL"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nTJXNnfk8n4fecxfr1CWT+9dekZ91IAUUDBN1nebJ3Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787659754; v=1; x=1788264554;
 b=iAhuakqLF1i07IGwHukukOihWF6LgWVZflfYR4Xp8JWO2FZrNDNy86YARC5tf5Ti1VsXaAhL
 JcLxj/dOxcRlsCWbxTrT2MK0yY06x9xSbvnYERY8rc8b0N5cXunKIa01nPXeS+wOXRN5yRGRvG8
 IBmFKSMikxhJszF5yUvkp5C4=
X-Envelope-To: netdev@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id cc42f5ebf4c362e2;
	Tue, 25 Aug 2026 12:09:14 +0000
X-Mizu-Trace-ID: cc42f5ebf4c362e2
X-Migadu-Flow: FLOW_OUT
Message-ID: <35d8c92f-9543-4c53-820f-38d564d318f0@linux.dev>
Date: Tue, 25 Aug 2026 20:09:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv4: icmp: reject RTN_UNREACHABLE input routes in
 icmp_route_lookup
To: Dong Chenchen <dongchenchen2@huawei.com>, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, zhangchangzhong@huawei.com
References: <20260825094523.1461020-1-dongchenchen2@huawei.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260825094523.1461020-1-dongchenchen2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/26 5:45 PM, Dong Chenchen wrote:
> When the forward output route cannot be used in icmp_route_lookup(),
> it enters the "reverse path" and calls ip_route_input() on fl4_dec.daddr,
> the original packet's source address.
>
> ip_route_input() only returns an error for truly invalid packets. For
> unreachable addresses it will succeed and return an input route whose
> dst.output is set to ip_rt_bug(). The existing check only rejects
> RTN_LOCAL routes, so the RTN_UNREACHABLE route types can still be returned
> and later used for output, syzkaller triggering a WARN_ON_ONCE()
> in ip_rt_bug() as bellow:
>
>   ------------[ cut here ]------------
>   WARNING: net/ipv4/route.c:1273 at ip_rt_bug+0x14/0x20
>   RIP: 0010:ip_rt_bug+0x14/0x20
>   Call Trace:
>    ip_push_pending_frames+0xfa/0x100
>    __icmp_send+0x905/0xf10
>    ip_options_compile+0xc0/0xd0
>    ip_rcv_finish_core+0x321/0xae0
>    ip_rcv+0x1de/0x260
>    __netif_receive_skb_one_core+0x11a/0x130
>    netif_receive_skb+0x7b/0x260
>    tun_get_user+0x11bf/0x1c10
>   ------------[ cut here ]------------
>
> Reject input route that is RTN_UNREACHABLE to fix it.
>
> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095376;
	b=Shu+TQBLUNErGRIqPHWkWge6sszKyvApB2/3AkzZUDLkS+5GmcB2N+YjP/EGuPlL4eTr
	 Z6yrrhPPmfk5cBnXBEAHm/uiFQyZhYEUUU1X7UXG0fGlsNWONIoLSagjax3/SB36lM6Kk
	 lTUc1/D8CIfB9f4Oh9IHY5DYpr0cGeRSFgu/fSyPPqfya6O+dmjLwGDxd4cE/oiGFQ/yO
	 PFruWIg6GeSwIKz9X8jRJOLYJ4jTobefGtkqBBnldGzKX8WrlM54/6S1xsRkAoes4rqaU
	 1o2hOvoWIZw2EN5hbMgicMeZKshDyj49kex5DoeK0P9grlxs3bxG8bj2+ZaGywEPqpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q9lVN24nJh91Od/QYZ2Ns5Zk2L2QYYH7vXm1pHzeCnk=;
	b=4uXLQR26P4XlANwURAD209BkmXqAo3KxQyrdlIZU+z5pe09UL9FG/kaakt+rtLyQoPuF
	 qtN309NUo8aFxByeClNOSoW3f/A18I7YRXsgQ2kI/vY/q5oyMuDnOz9zHoMFTAngL0Utj
	 20eJNAeKN4INcjK2KjcsLHaQ0xO94hVFs7S7G2v35kSlns+IsZQOADzPv2xFtxqAlwM6n
	 3K6VnKZ0rT8xctJtk4zR92aBcdyhjbeO+3AU4A9OSD3V8JDeFjIlbJmG7CyH5w3tjk90z
	 3i5J4eouydHmPaAQazkpSB6t39NnAYek7nMXAxyyLEQbWDN/RVwjNcIQh234N2/nCdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Bbh1mXA2;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45256606A31F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45256606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Bbh1mXA2
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso40076475e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793095373; x=1793700173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9lVN24nJh91Od/QYZ2Ns5Zk2L2QYYH7vXm1pHzeCnk=;
        b=Bbh1mXA2WsFPVuJBbfUZV9bB7+bP6XSc/Zjx4X7wCLe/AlkqhIj/niiwtxWf97e47H
         /UCs0gaj9mKsC3CCgKWF5EAQMBjgOQpxhO41zg0fzYM3joC1/cvk/JIs+YrEritqR4hg
         DWfrrUB13zd4SsZMx+Q9r+YdiU5YpivcnfOkREx9HLJvTRffeBj52+6YU0hPu/FPzyIx
         CNNDEh/c6D2l+NNWOeC7XL6dj6tq9a48cd3Xk6m15lRmQSv4giuVZlQCu69ASrksuEpo
         jG6MVrRJf8LPsUcz0tlYDtmfjkuc30TZHyfrDFBN0SbR1MwUcKclPqwYurZyrguJsQAB
         KJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793095373; x=1793700173;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9lVN24nJh91Od/QYZ2Ns5Zk2L2QYYH7vXm1pHzeCnk=;
        b=sQPdZCEIBr5zrdXgNOV1Cwd4mQM4vsxcuf9qgVdPBGv2ucfwJDtJTtNdHi3570/55v
         xstORMIc5/1hrtThXdfX/4ausiNEZ2rAoeElneAiXbynJ7DkpuB1R1uUU3gPCbcBImfZ
         lgyQts/VDo/eoGXf91HuMsiRQ8XQSkme0XbA267DEAY49kPEILHmFO+i2GKM/Q2noCes
         uLOXemXFHfCkrPigAsQWSaEMQ2g9yn3nm7bO++ec8XBUZrrNCx1fiUQo9JdUv0ejnQfF
         CLPAoX3YhrK6KQalhMUBfJLt8OQ9+3K5z8bxCIq5puXszJ5cGVdN6dKwlfVMXMtpcFT6
         WPdw==
X-Forwarded-Encrypted: i=1; AKwUvBxULARbizm0Ed9ORRMuPXqC45tWrAMSGrJZx7P9EKlD3eSnCmFlxffekTISYUcbgGZtl7GJg1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWDqQiAX509TrJkV5RiOwc7hvXBbCXw6lvK+rTYu32O4p3nZde
	9OzEEqwOX03aEcBWQ2PIg6xcpPvIkkkmYBSdP2TlfqLz16lLIpN3Epg02rfVqyXJP7w=
X-Gm-Gg: AYBFou3NVN6HxH1kvZfGsoxhO2YNcnBGlIsk/e23qSLxLXfhU0KlWFZNi6FPWTBNm8j
	h+4+Il8WlnOYLmLZvlOmndBxhdFvfsIY8aG6SLKOkbtsgTklayQCXnCot5saUds7vTtifhDVbEI
	YMGuNMdeTE/WJgVcaLGneEPOFLiN9c/xTnjZWq51JmEUsTsaYBiFc7CAKxCDBRAkOEFqXlr82ZU
	zkGB0OnAB+2cKuv9U2oxEpiBsdS+fyJIje+LSW2f/EOsE1Sbkq5EpPy5gki/sItBIpaGk1GsmWO
	KWHIIenOzaem5WLYciPwxiIOpyq+BE4UdTn7i6mhWey041PX4B5ScYzBQQLyyIvRJnmkfti8vhh
	wrRqJ7FTlNcVd4lQiVCy7I+9wNJ14kaa3GiHcIuGwRmau1OWm8wjXXX234XDS2TcQdooluh79cY
	8jbt6bNtPBjaqPlLgVcLPmPw1CRi2I0xmdYR8e3pg6x9zCCLE/BEXbVubFlv6+lpmD+ubA3618l
	c/APzBG9oMgccBvwqkHoOWUf+bMO+kSqzDrSmFVhJT5wCvc+bTlI86n+eIFRqK2RzSF0nPWh6K+
	KoS7rInsFRTqxcrJve3cOx6/al68s1Q=
X-Received: by 2002:a05:600d:82c5:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4a7ca0f7e06mr41589645e9.22.1793095372108;
        Tue, 27 Oct 2026 03:02:52 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa0bcsm318071495e9.4.2026.10.27.03.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 03:02:51 -0700 (PDT)
Message-ID: <2774953b-daa3-4f24-8515-906b691bf5c1@blackwall.org>
Date: Tue, 27 Oct 2026 12:02:50 +0200
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
Subject: Re: [PATCH net] net: bridge: netlink: do not clear the vlan info dump
 error
Content-Language: en-US, bg
To: Linkui Xiao <xiaolinkui@126.com>, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261027085200.1501599-1-xiaolinkui@126.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261027085200.1501599-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2026 10:52, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> br_fill_ifinfo() assigns the result of br_fill_vlan_tunnel_info() over
> the result of br_fill_ifvlaninfo() or br_fill_ifvlaninfo_compressed()
> instead of only running the second helper when the first one succeeded.
> 
> When the vlan information no longer fits in the skb but the port has no
> vlan mapped to a tunnel dst, br_fill_vlan_tunnel_info() walks the vlan
> list and returns 0 without touching the skb. The -EMSGSIZE is lost,
> br_fill_ifinfo() completes a message whose IFLA_AF_SPEC is truncated,
> and the dump carries on to the next interface instead of stopping, so
> userspace silently sees an incomplete vlan list.
> 
> Only fill the tunnel information when the vlan information was filled
> successfully.
> 
> This was flagged as a pre-existing issue in the Sashiko review of the
> net-next series, which noted that the VLAN fill result is overwritten
> before it is tested (see the Link tag below).
> 
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Link: https://lore.kernel.org/bridge/ed1de95e-e112-4076-93f0-6f7668e657ad@blackwall.org/T/#u#5
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>   net/bridge/br_netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index b2cd4e39326d..8ed86bf71a00 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -540,7 +540,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   		else
>   			err = br_fill_ifvlaninfo(skb, vg);
>   
> -		if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
> +		if (!err && port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
>   			err = br_fill_vlan_tunnel_info(skb, vg);
>   		rcu_read_unlock();
>   		if (err)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

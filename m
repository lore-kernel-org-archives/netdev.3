Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AECB38AC92
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423519; cv=none; b=u3cNxGeJ1seYF1m4V7KdQfVz1JG+Wjj90BoiXqjaeWWfXb/hS12SOuXDthFJ2VNhHAsvF3MYsTRlB4NDDmb4/rBJXaqJU3Hvh3wwBOA8Cj2k+FG/5u4FNaYsDEkPPMAllYTT5NNeOGJ0sCWLnVVHz9aKMDJKAds32lH8XcMlbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423519; c=relaxed/simple;
	bh=fGzXgGVJ1yH1x22xMbWeTVfnc0IaeKtJvd1acoZfu+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmgXX4XEJSRjPtFifhgadP6PZEiwqQyhz5mxUR9dO53sIvZ9Hw8p0Rtd1nFBz9UKSkInE6RDCV0eD0ssd03tO7zOMJcxEDieqOiDY/HOU4B1/t7Z6i5xPl2aevKYAUHdrJQl/B1XnupD82RIwQ+agebsGPeLD9lK891ZOBVG9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=IZOz8KSr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="IZOz8KSr"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so22819915e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788423516; x=1789028316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lLr6FjTfplPOzkh2nNUhY7Doe5zJQct4JgL4Ivb8AHM=;
        b=IZOz8KSrtdGkb1HxhOPe1RjE+6ONRvEIjf10dcpncNV4/5/J6CwZ2CdC2z52XctVUb
         wUwGn31tYQdreUXeK2bPyD3F2wPie0VwHK+8IKVrUGws4Tqva6C8TEyge60UeXgdMyen
         ZAvQHun4Zx9dTu49reDeLVZZJYRwAGMvQwxq6Sfn3FhUusqothp7lQIUNoRFpLxKBlgB
         /b/nF62EKohgikCKrUvjs0a/3py9AahHGRsJEFNyKqrHB2VU9ZoTEq5mtN0Nt/qHCX21
         NmVLqnU3my+QTbIVxb5BK7n+noOVP4VjECLUcdCozvTAKx0sYmln0zXcKH71MQ9XLeiK
         TE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423516; x=1789028316;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLr6FjTfplPOzkh2nNUhY7Doe5zJQct4JgL4Ivb8AHM=;
        b=CYVM1vbYbjMWcOIWitooQ6Yim7Wru+JsjuMYpLGn1qfMIHMUjeIgA3niWdglMUlt0b
         XhRT+S50oe8zT3ZJrlh8s1ISlzByDKljlTZ4SOidrEzeh5VJuLvvSbQ/HfPAo0mdeFxi
         NDHPUPfSmghxVi9Lm2oa/YuL3bjpK7A5eVlhIvXX07OolDzE/GQf1DsNWqFjGUgg3phl
         m7/mrq0xbytLAfMKeXmcTRBqMwO+b/vT5yWdNcNqqeFDjawCEnkrlK0N0NzNMa33mG9Q
         zd84FwmZygcU7AIzJwz0WagYhvBHiRJz8vR4M0nYKrAYzu7WBxXlsn9/r8WW09SRcMIV
         rTlw==
X-Gm-Message-State: AFuF++ka/mGtAdUBL2EGOPFT8PnSBASM7aUJi32752a6NgfC4aKhoskV
	Hwv6WSBdwpd+DJV0fd4nBiaGt+3HSDxMNqhQcIwg63L6fTZOkfHad1iWd5xjv1Ml7Uk=
X-Gm-Gg: AYBFou1ZWY1MUIKleKh+uzGU4fLgGpmnBpICwYz6PZj3IxUBglX9MCiE98Ap03OwX6b
	U6oN96svDdppYq9IYP/AbVfjFT7az7AVhF05Q54QfGjsJTaohK6uLp8Yrj85slHoJyVmYYv/lqv
	RHOFvC0/V9y6fXurDG+GLSZzWkRRJgFKv8ZY4kPfm0/we6ckMUu7lcu4P1P+rv9rDLVdLKMz33z
	u4GMYBymI4oepfH6xDTrX+asBkXVF/4rtEmWLFo6YlMqnrXvp2d1gqFybmJRd93rjljgX3QWZz/
	FwwxHXHvMIizTFnRc/7ffU6p6a3TRFAJmTY1uWC6mlUXZN30UOTo5KGcM569wDercS4Yh9uKdRU
	ZDh1p9LOiJIa9XqkZ9nuMaQmoFJG0U93rvNjxQltAJDAm1LkYER+N+RNsvaqY/Zx9TamkQ8Ze95
	1XpDiHH8d9D8Xim1wGG43OH8erQfN2gAvNsaXIAlv5UTCmdatBQsMr9N4mXyW5jYooXZ2shpiSC
	+mQZl1PPthKZpd0dw4PnSaM2gQbUw==
X-Received: by 2002:a05:600c:530e:b0:49c:d618:e341 with SMTP id 5b1f17b1804b1-49ce584bb4amr205480405e9.14.1788423515473;
        Thu, 03 Sep 2026 01:18:35 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6158e9sm51543115e9.12.2026.09.03.01.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:18:35 -0700 (PDT)
Message-ID: <30c405c0-d17b-4107-a4f4-d2595c661892@blackwall.org>
Date: Thu, 3 Sep 2026 11:18:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bonding: fix slave_cnt leak on XDP error paths
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jussi Maki <joamaki@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2026 11:10, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
> already incremented. If XDP setup subsequently fails, the error paths
> jump directly to err_sysfs_del, bypassing the slave_cnt decrement.
> 
> This causes slave_cnt to drift upward on each failed enslaving attempt,
> which would lead to unbalanced traffic distribution with round-robin
> mode.
> 
> Fix it by moving the slave_cnt increasement after XDP setup.
> 
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
> Changes in v2:
> - move the slave_cnt increasement after XDP setup (Nikolay Aleksandrov)
> - balance-xor mode is not affected, not mention it (Nikolay Aleksandrov)
> - Link to v1: https://lore.kernel.org/r/20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn
> ---
>   drivers/net/bonding/bond_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 947d92a669b6..f3290aee50d1 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2284,7 +2284,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>   		}
>   	}
>   
> -	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
>   	netdev_compute_master_upper_features(bond->dev, true);
>   	bond_set_carrier(bond);
>   
> @@ -2339,6 +2338,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>   
>   	bond_xdp_set_features(bond_dev);
>   
> +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> +
>   	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
>   		   bond_is_active_slave(new_slave) ? "an active" : "a backup",
>   		   new_slave->link != BOND_LINK_DOWN ? "an up" : "a down");
> 
> ---
> base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
> change-id: 20260807-bond_slave_cnt-88e78c5f0ab9
> 
> Best regards,

Thanks, looks good to me. One minor nit if there's another version - mention
also the WRITE_ONCE() in the commit message or better yet do it in a separate
commit that properly annotates slave_cnt everywhere.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

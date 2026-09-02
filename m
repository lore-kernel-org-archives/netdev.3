Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C228386572
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334308; cv=none; b=jR668atTI4Zzr2R1kbnYDWeNOrg2fGDggu50sxgC3ClqP0/rfYeeA94KipNRMjKsL2igMjWI9Rg3aDSFlYHS3lwnwDdAPhDAwj1gQl9m+D18oe7rsckcPOdb1QFUNhfUrvLuNS/sTDfvoDe+exHCKpz5dMxUIe0fdrE7DN+C8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334308; c=relaxed/simple;
	bh=9U7SFbOWxiBjZFiG74OiemBYU+Y1rr027ZcAM1kmflM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwxj4WufZhuGTbRh6fd216MOw4/EM22EB1tALEohWI5hDq6XNNTRvXfT1HSv7bBGFw3qxDwIObitcxBWDlyItKLnfoP8rZSxKZXGoiv3OSqsowrT300pyGg4VjkUySnJzR8cXEhaUkTJujCYXP5Z3XYYwEnqCCJuAiW3yFBlxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=l6L6BbD8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="l6L6BbD8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so7797705e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788334304; x=1788939104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e8c4SkCGLeuEZ9G0EExuH6ysXn5V6G5CGFTzY2i788M=;
        b=l6L6BbD8wgO5O9+LF/aDfHLEGVq41SggIr6mlywtJA4hy13WZmGtR4drLqQ4NBfTfs
         KgzBQA60F76thk4iCbZr6SRTAj7xRZnkt+x5451IGcCVkcJDbqYYwBqJ6NJrteR8SPz1
         BzxU4nV47ot3raFP32qQOTQHB/p9sI4WzKQFWrLTAe/RSgyhcSRYtLPepZkUiLOjyZXR
         nKhInaAw+4YohTQQShFHw8n7yomYvFVPtqXudlX56zyKpGN3uSMLvjUAFvnKBp16tPf3
         7c0XgCoLlg+djaKT7ic8dkHQmit2Yelw2UPrawTv0l0Ruj4n+xnDlqBymPfIGKPhGfYE
         r0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334304; x=1788939104;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8c4SkCGLeuEZ9G0EExuH6ysXn5V6G5CGFTzY2i788M=;
        b=go0lPMooGFyA/jEhI494X1gWasx4wQrstZKobzBMsYfmazGiconfMDKy5qwuiFLwif
         u46Z07y9n36E7QuxrMZJQKcDAXBNzrPIYh8qpjuw5Xm8scrygTC4+weD/BD2EiavPhDy
         HIgGjt0rkP8stgLnim5+5mH+hq5kQfxTCRrfu3eNtqXQ6sLSOTeBl14EPNwng4vQadUf
         iG9moTcXgkv4HQWusNDkV3twQYPunp2KwvJ7x6VQCsbbGZ7Gzpzoc1z0yDnOu2FnspP6
         OuholcS0eyVfpOAQWG05khR5lesgwwUVMJDK/LyAZChiccFdhe5mOAyzYSQ5UmooqUe9
         Zw6g==
X-Gm-Message-State: AFuF++lF2r0tfiC+IH30BZKc/Ogox7jIeJ/k/6XK7NQnJzmb9glc3PMu
	02yWs6AlQ9vXmYaT0Rw8CzLHWszs0M2D1DgW7plGRXmFr0XcHLCDBOPKL0mj9dC7YBE=
X-Gm-Gg: AR+sD13oxLILtUyNNU1IYhEeSZj45yYR7vZjQoVMOg94LJoHZDeyNiXhlVbU8a0llGn
	cpo8eZsbcwxkk63LwXs8Wh/NYtIj4tCyt3CAhoOUAyfxPzah0xcrPH50LbKVsNhoI23dNCkjOat
	1VVBJVEPCYXW1Hw1fgGrybQy+ufd00GY/pYz0ypQNpfw47HbHBE2zuXGBZVjk2I+y1sdt+ugr7D
	zsrPKDnai1OrNQd+RByjTBdFz6nWTLvLfkztcCrNZtIMzqWuob5C9A/u8eVYBVSFoBmJ9FMR3EE
	OI3Pp7F1rFleE4NbyFdHeVOKBdeHXm/ghFu9ocBAiAGWgN4OlznHlYdeeewsXZVv+4xjEVKzNL8
	jquH33EbK0ETfEkM4stbxpkHVkoetPs2151tsM4IgXAUr9v/BOj+H+b8eHoRwerpVH0q/YE0fmW
	VqFofUN/IuER422QLoMdLiTEmnurfiq5d7jV/AjpvvVyey7/G71fw0H5wthkdNQYPT1fPlO4CMY
	2+Tg/+cdZcaECzCLvY=
X-Received: by 2002:a05:600c:6992:b0:49a:a101:4157 with SMTP id 5b1f17b1804b1-49ce58034admr51656425e9.7.1788334303651;
        Wed, 02 Sep 2026 00:31:43 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce3e04csm121393645e9.10.2026.09.02.00.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 00:31:43 -0700 (PDT)
Message-ID: <a85105b2-a576-4702-a9fb-3d17ddf4d2a7@blackwall.org>
Date: Wed, 2 Sep 2026 10:31:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: fix slave_cnt leak on XDP error paths
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jussi Maki <joamaki@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2026 08:21, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
> already incremented. If XDP setup subsequently fails, the error paths
> jump directly to err_sysfs_del, bypassing the slave_cnt decrement.
> 
> This causes slave_cnt to drift upward on each failed enslaving attempt,
> which would lead to unbalanced traffic distribution with round-robin and
> balance-xor mode.

I don't think it affects balance-xor, it's using usable_slaves->count which is
incremented only for actual usable slaves

> 
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>   drivers/net/bonding/bond_main.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 947d92a669b6..0305a017e327 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2305,7 +2305,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>   			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
>   				     "Slave does not support XDP");
>   			res = -EOPNOTSUPP;
> -			goto err_sysfs_del;
> +			goto err_slave_cnt;
>   		}
>   	} else if (bond->xdp_prog) {
>   		struct netdev_bpf xdp = {
> @@ -2319,14 +2319,14 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>   			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
>   				     "Slave has XDP program loaded, please unload before enslaving");
>   			res = -EOPNOTSUPP;
> -			goto err_sysfs_del;
> +			goto err_slave_cnt;
>   		}
>   
>   		res = dev_xdp_propagate(slave_dev, &xdp);
>   		if (res < 0) {
>   			/* ndo_bpf() sets extack error message */
>   			slave_dbg(bond_dev, slave_dev, "Error %d calling ndo_bpf\n", res);
> -			goto err_sysfs_del;
> +			goto err_slave_cnt;
>   		}
>   		if (bond->xdp_prog)
>   			bpf_prog_inc(bond->xdp_prog);
> @@ -2348,6 +2348,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>   	return 0;
>   
>   /* Undo stages on error */
> +err_slave_cnt:
> +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
> +
>   err_sysfs_del:
>   	bond_sysfs_slave_del(new_slave);
>   
> 
> ---
> base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
> change-id: 20260807-bond_slave_cnt-88e78c5f0ab9
> 
> Best regards,

I think we can just move the slave count inc after XDP setup when we can't fail anymore?
I don't see anything using it before the slave array update.

Cheers,
  Nik


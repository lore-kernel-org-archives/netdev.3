Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D738838B
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414138; cv=none; b=Lk0I1Ox/U96viczH8pVpRw3NrcW+WOThXwv3chREQU7oaUsMEX5V10ZhqXQv+aPb5iqRLEjFfZb2mLrwTa9UNSYxzbIjg+0bqh451Kd7d0sDxLzvZLp1T1kJjzKBBvBHfpwTbMf553635NIV6+WaviRtY1VfWQrftQrIQ9lAzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414138; c=relaxed/simple;
	bh=5OtJlbo1g405q1D1BITxmn/8MyRCpCH3TkKVn6gDP+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbbvExoLvdKordKfMaJ5yDMFfE+sz/O0/fEXFmEyPg1qUQQ7p8f9VCmz8AiUkXKCZtMxPlqNTzoCrwXKmZtaRQWWE3QGMgNiMjSutXYzdbl+1VZv4mKpMxVSom7WP2+fsycC1WhDsmIi/I+ZYCn3HIXv60qQKVxvQRFPRyUcH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AgHhkf/+; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AgHhkf/+"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2db858d60e0so32737415ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789414137; x=1790018937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9YxMJU2uyU0a0FLYWALkWE9MV7WU7H3DtorqV6/NVsg=;
        b=akzejuaOrWKOWNPCtXOwYqSj4Vb+RgiwPyINXdGFz+FU/1hVD1AFqYcKSqKMgE2E1Y
         RFVkYMbs3ZKebA0T5wg/dqBEwEjMH+EVt0/sauMKfWvU6bMT9yXQPMgLtqjELsr/NqW8
         QcQEjzh/MsOxKv6S30UGHplA/XMEfw5hw3vZiJsRALLVwaDpxuhwCita+PAXWQw5mwiA
         C8P1gF2u08NUNNnVA6JIZasa86sCKrIOfd/rojInv8IibbRqyABOfpeTllf7uYMPRQqX
         jcSIqKPmnC7/rW+tyrE/nXsPe+FIFb+KIoH6unEPbybY72fcGVPHIE/B1L6qtnLp7uCX
         x3Ww==
X-Forwarded-Encrypted: i=1; AKwUvBx8p2sHSEJ6ITh2QBsFDwtBjEgirlo/IxE3kIgxQ7Q9gQJ1iugxSd8ypxLk7R34+89wmIN3AeY=@vger.kernel.org
X-Gm-Message-State: AFuF++kOpVlo3PTntunhBPjb7IkUQViMqI59WM0HMI3grn0T4W5AggSB
	/PSh3nWYRM/PZIMde29SWaUPTbsKWkQZL1D5A0yN6adJk4VU1r60kiLCJ4u1Zq8+XWKe+jDfkTw
	FF3RrZ6UDvZq3hESxKUX1m0Gv0ZmcTe3dU0VOxrq9VY+VkRbt5ujGcf0jNoo68NnHVUK7XC64nN
	YsjQ8YRnY8by0rbdYgSvW5WVt3Q3Lm45vhc5+7uo66XnKHYDPZ9GH8mDPIDbu2LLy2aEJSFiVKv
	JVMYOAGFg==
X-Gm-Gg: AYBFou1gFvjE7V2m+hf/48vFd5XOHXvLLszkJQSZJOZQ7ljQ4PncNs35E0cMV3W8Rx1
	IBv5vmszUE73JPvI01Ccb3/KvCivXyi20WjjdPqTFnHxzQ0mQENyFTqk33yNae6Omo4vOx7j+AO
	Mc8aByFdqjDdzjpauZb09kl5FMQSUpgAyKD8/Ex755V/zNL3+rOZ53Bx9qILQdQDkikn9roNg5M
	BjNnksLMuSQOauE47dxS/4rRaR5rjSialQjGhiymN7My5P4WH3hN3aAy/i2+3Vsaba4W0gfMupq
	gLlYWq2hQEGNHytwHrCQl4Tvu3SlHlCTjucEDiZpuSuS+rqOnsH3X717AMQpstK0OjjUp0o3TJE
	O0WhEadHFPPNbozU4+JeYtLMs492a7W1zWMF8hxz5KKL79WcOH2P+hK4oSuaEtPHvx3mOSzTk0x
	dx5h/3rzzKYVg7c3YyJ4Mp0yiHWfaBOASTlZlQ
X-Received: by 2002:a17:90b:17d0:b0:39d:c3bb:98e7 with SMTP id 98e67ed59e1d1-39debfa60f6mr7809333a91.6.1789414136781;
        Mon, 14 Sep 2026 12:28:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39dfde2b96asm246520a91.4.2026.09.14.12.28.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2026 12:28:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4c1fc9ceaso2994663a12.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789414135; x=1790018935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9YxMJU2uyU0a0FLYWALkWE9MV7WU7H3DtorqV6/NVsg=;
        b=AgHhkf/+1ACEf5iQfuxP5grJtDB7FYBC++zuoGrF1SUFEyW/zCINhDNLO73g1JsuEA
         Q21nXSK8lY2RNI/ZOnWRUUrZ45lVMwQy8OMx117RPm9Zj/L2EXLHLkateJrNVeGmcwAF
         e84rbE6wBfJsIr/cNL1udKTwdxNGdqRmBvD20=
X-Forwarded-Encrypted: i=1; AKwUvBw7w0J8RXvVKS3fugqqM/E8PrGACSKifQ8DiJzAN5nH4BKJn5zybe5fa6vNq7wSArxsVd8Ze3I=@vger.kernel.org
X-Received: by 2002:a05:6a20:7492:b0:3d3:adbf:7777 with SMTP id adf61e73a8af0-3db40575ec4mr8180445637.19.1789414134951;
        Mon, 14 Sep 2026 12:28:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:7492:b0:3d3:adbf:7777 with SMTP id adf61e73a8af0-3db40575ec4mr8180371637.19.1789414134382;
        Mon, 14 Sep 2026 12:28:54 -0700 (PDT)
Received: from [10.14.5.171] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed79absm31155602eec.17.2026.09.14.12.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 12:28:53 -0700 (PDT)
Message-ID: <059e9e23-418b-4779-b959-06336f9b18d1@broadcom.com>
Date: Mon, 14 Sep 2026 12:28:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: restore the hardware filters on open
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <20260913190052.939955-1-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260913190052.939955-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/13/26 12:00 PM, Nicolai Buchwitz wrote:
> bcmgenet_hfb_init() runs INIT_LIST_HEAD() on priv->rxnfc_list, which drops
> every rule off the list, and bcmgenet_open() calls it on each ifup. Every
> rule the user configured is silently lost:
> 
>    # ethtool -N eth0 flow-type ether dst $MAC action 0
>    Added rule with ID 0
>    # ethtool -n eth0 | grep -c Filter:
>    1
>    # ip link set eth0 down && ip link set eth0 up
>    # ethtool -n eth0 | grep -c Filter:
>    0
> 
> Initialise the lists once at probe and restore the rules on open, as
> bcmgenet_resume() already does.
> 
> Fixes: 3e370952287c ("net: bcmgenet: add support for ethtool rxnfc flows")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>


Reviewed-by: Justin Chen <justin.chen@broadcom.com>

Thanks,
Justin

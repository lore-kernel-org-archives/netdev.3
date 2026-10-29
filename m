Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295432;
	b=O+5VhVLbhIWyj2ah7fLkCGdMZqsMStfGqISVE4zl8wFzB0GhdmHVsJeU8VdAXChUhxfp
	 wDcF/TA1DgsVKp4pI+b/7BeghnVXM0BL+eT+RVF8oUcFFJiI+TdwHKiU1gpoO1MP0Sbro
	 r3FTQSBkVx8gDyoPk7cFuuME5tNY4H0R9ydXcsXbhByJ7m8p8Csm1kqRVwY4kTegBGCIt
	 XOspG/RUiFFYnD/ZJfoUVy7ukPrqRU276iYvhIxublBy5PkAIkS4MrKwUoxwgPUhJH8q3
	 6a7JkkJ1axNw6QJDEteFVoAv8IeK0nNlN0izoeuOeHjTGaKeNA0zHj9n4vnVTIye2Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1R93MDTU0XytCmvnwXdPrrSy/zaN5hGMCigbTQ62llo=;
	b=D5q96WqQ4bDO73YnjUV6LnqnK0ihkzfo3V3vAax+CF59w6Ue0iKbiyTTGUbX2dPiBVC0
	 YNzUnFSZB2rhQdLu+N6kRhzAubulPxM1dFKkVCcWw35E9tBWAhOMnPt3h7VU0G015eU2F
	 bub32rrI117CCpRFstEBhKtCMocW8YfGvND05nFdFHZUrvprw/W7npQksS/zKE+fDCWzP
	 Vb9fDe54B0qk6kn84sTkZ54fBmDIyJTdX6ABjPs887bChxoxhqeHprti+ezBWXmTiI0Wz
	 6Z5lUgzEvmOpS26uwqmLDQhvXwUA0TAQRzIkLOnqbRrK+S7TRTELAGkXKMkn/P0X4VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aV7bCt7R;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506D606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4506D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aV7bCt7R
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1846bc43c28so2794388c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295431; x=1793900231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1R93MDTU0XytCmvnwXdPrrSy/zaN5hGMCigbTQ62llo=;
        b=aV7bCt7RqRyTS/LfOOaXqrwODQp6BkyKXTEOC0hRoZ/qCfN8ZfD01J8OdU6aoOMGl/
         Cq+qRgwk5YP9yc9DONncGQxJbl+M8iLdwzqDtAlcIJ7nmDLCF75JfvpczLu//T5Pyzx6
         m+fURzOXw6BngapSpIbdo38MlYlx/PeYss9bB2tR6iIVWb3Sj+GlaFBLiFDxT/3zKKpJ
         M7G4bZP6kDGwHpl0FtNF0LQzZ5j2DLqRLhA5j7oLHePionsZW/39pztCzazzQHCOC28m
         fh5cCVfKnJJzaUrfJ/u5X1SSj8hnA0mVRpAtbPKP1yLzYCrO4Cd31ZnW31Fe8OiZrf9E
         2H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295431; x=1793900231;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1R93MDTU0XytCmvnwXdPrrSy/zaN5hGMCigbTQ62llo=;
        b=ti3XFL/nu3a8Gb/c8rgTwHLKfMAshPuOwHo8TYJlKWyzikxiDzZfZSbAdYpDAV/Wcy
         jrqgANqSOIH/A+fFQro2oLjglwFaIn+MRW2EZQfKZWUQmOBv4zGv+jQ2DujEr7mfbTcB
         700ykOB0bf7cnSIpHe2zKdLzpspo5zBeparJk4AU6sJVErE+o3W6Jz+Fr00yxPMxOect
         0fLs6WtRui3BeT9djS2zcMIRxabXiGP7tlpk75HkP6b7eMUnMlIA8LOYZnlkXgm/78Dt
         MjH9zG8qvq7BghUoDmjbrbVeChJnsT44xeJ/k3xM2XBElYrkB493nCgYlarKrJrsmGXD
         QbrA==
X-Gm-Message-State: AFq9FYKu4dxQ1U0cPkCWuHmwmxrMjJcv1g4u7Kgx07m2irmrYn3OGipp
	TOktYyc2cNzCtOUdVr8LT5L5LQrOF0nu5K8tHIoTxgsh5x5VdSiamhti
X-Gm-Gg: AYBFou07OUK18kkAndUpchkRJbsjBHiy7qWlAv/jY3jknX3K3qGhKDbTQ3YtUVUtYJE
	i+r9yzf8sLX/6DSgpN6a13cJIccBhM3nFEHK+0OgrQjmCfRRoLhnDuWsRABVS6pCcRtv1uER78M
	4kGNK1TYF1O2FtZkOeg3deUPelPMT5iuS/znvHybGL0dAj5wtasMNorXMoqPmB3D5/raQqxwd22
	YbRJd4p6N6KAaRgQG8EwkWo3RcnZrY65+Oi2yJFgJPVpqOUN2myO/KMN/lQnof8FNlCrDvkedL5
	U9Paqt4Qx5rX/424W+lgEL3rRPIpLLvn4OHU3+699ru23NrhqHWN94xZS/6XmJNLXLsTbpL0SNh
	50mKCcVeKigym900TDbclDUOCzvc7W6pky3qW8etZPTWWJVLUcKE0FjRtBnzHzWe4v7jvdHJ8bY
	2xA6/Dp/bq/3HiXAG911rEZCmvPUHyD305KiiC/wmyHIZm6SB/YAVhpqf4P8F96LmEGojZfIHLg
	/Nvp6CvSxCz/Kc8yThia0AvmMlP5rEjsn4rID6vBYhYXPgD4cXd9HZVfmD5ToG078Ftj7UnBJjq
	beH/3b5+YuBWwD1YY77MZThCHhmDKJHy07RG3cENNcd9INI5pofkRqtt
X-Received: by 2002:a05:7022:6989:b0:199:e38c:29a0 with SMTP id a92af1059eb24-1a6cf071fcdmr10788012c88.31.1793295431303;
        Thu, 29 Oct 2026 10:37:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm166684c88.7.2026.10.29.10.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:37:09 -0700 (PDT)
Message-ID: <209a7881-d76d-4449-98e6-c3b4f1efafdd@gmail.com>
Date: Thu, 29 Oct 2026 10:37:06 -0700
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
Subject: Re: [PATCH net 08/11] net: au1000: restore receive filtering after
 MAC initialization
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, shaojijie@huawei.com,
 horms@kernel.org, runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org,
 jeff@garzik.org, danny.kukawka@bisect.de, mugunthanvnm@ti.com,
 sebastian.hesselbarth@gmail.com, linux-kernel@vger.kernel.org,
 manuel.lauss@gmail.com
References: <20261027223140.3774570-9-f.fainelli@gmail.com>
 <179329051912.3134.7644702434785244368@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <179329051912.3134.7644702434785244368@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/26 09:15, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] In au1000_init() (drivers/net/ethernet/amd/au1000_eth.c), the
>    control register is written with MAC_RX_ENABLE | MAC_TX_ENABLE and no…
> 
> --
> 
> net: au1000: restore receive filtering after MAC initialization
> 
> This patch reapplies the current netdev receive mode at the end of
> au1000_init(). Promiscuous and multicast settings are then kept after a
> watchdog reset. It also takes aup->lock around the control register
> read-modify-write in au1000_multicast_list().
> 
>> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
>> index f8976e324f0e7..6b817d18329b2 100644
>> --- a/drivers/net/ethernet/amd/au1000_eth.c
>> +++ b/drivers/net/ethernet/amd/au1000_eth.c
> 
> [ ... ]
> 
>> @@ -742,6 +744,9 @@ static int au1000_init(struct net_device *dev)
>>   	wmb(); /* drain writebuffer */
>>   
>>   	spin_unlock_irqrestore(&aup->lock, flags);
>> +	netif_addr_lock_bh(dev);
>> +	au1000_multicast_list(dev);
>> +	netif_addr_unlock_bh(dev);
> 
> [Severity: Low]
> Is there a short window here where the receiver runs without the
> requested filter?
> 
> A little earlier, au1000_init() enables RX and TX with none of the filter
> bits set:
> 
> 	if (!dev->phydev || dev->phydev->link)
> 		control |= MAC_RX_ENABLE | MAC_TX_ENABLE;
> 
> 	writel(control, &aup->mac->control);
> 
> Then aup->lock is dropped. Only after that does au1000_multicast_list()
> program multi_hash_high/low and set MAC_HASH_MODE, MAC_PROMISCUOUS or
> MAC_PASS_ALL_MULTI, using a second read-modify-write.
> 
> This can happen on the au1000_tx_timeout()->au1000_reset_mac()->au1000_init()
> path when the link is up, or on open when there is no PHY. In between the
> two writes, frames for joined multicast groups, or non-local frames in
> promiscuous mode, could be dropped.
> 
> The window is small next to the reset delays that come before it. On open
> it is also shorter than before, since __dev_open() calls dev_set_rx_mode()
> only after ndo_open. The window is still there at the end of the series in
> "net: au1000: keep the MAC stopped until the PHY link is ready" when there
> is no PHY or the link is up.
> 
> Would it be worth computing the filter bits and adding them to control
> before the single writel()? Then enabling RX and programming the filter
> would happen in one step.

Agreed. I’ll share the receive-mode programming logic with 
initialization, program the hash registers before enabling RX, and 
include the filter bits in the same control-register write as RX_ENABLE.

pw-bot: cr
-- 
Florian

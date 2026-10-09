Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB964F55BC
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570997; cv=none; b=KBpcWR//U56lAb/ZSPC4PF5dHDRXMQ7U9Y0qmwib6PtoZIAURE7C+RK0kCuFA9on65G499PBQwjgvCryHmBmUO7S+zdp/7VdHaxFcajPcSYfspB/by7euonC0OMlobiiH2O3E3DaqaPsTUmVT8G65CRYZliE/z5W73vy/zxGJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570997; c=relaxed/simple;
	bh=Di5fW5pmuMQ0JNPAdAV3VOZrDfjlCYpI+PifW2Vfsls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CF23vqDjqLhSUEEgGHO2WSPq+df92YCU3SmiSI2/A1VFX0gC6A4ZEbnusSuxY6crsH7GVVbseFNaoTomIg+kXSNLs9kHGQqSyCm7qO4y1p6lBspExJCTwdY3K9Az3M6CDrL5BSi/doAKXpkHl12v36jRu8LCRmS0LgN0XD/Ps+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SFcv5Lae; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SFcv5Lae"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so3290703a91.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570992; x=1792175792;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OKGJknNN32NOHQQ/BHcC2WEmlpewEle5M8KqTBEYtlw=;
        b=hhQexLn9zhuEA3oc2m9+Ho/LG+3Nqiuk2UP5lZn5uZRZU00pYAzED8QUf3yAGTl0cS
         Gpn8g3fgXRS6hiPQ2rDtMvzgE5zPUP1Eynh9HduN9mZ/rz8SJYPAmgOzqB6QyCk97S/R
         maz9/AovdJYJd1c/zuunP0kw8uUHY9/iG9I1aypi7GFy3HoBcIflNBaco4gZds9ods2A
         mmwj4YVVhrLV9vbJHknGs+jQHHd1ps9VsLNz273b0hmV5nBvpWeEmc0AnA5JM4A2Tv41
         DMzbtEpe4LYv8Tyiet7tAGY+1oYXVjVPtjgLG2gEtTevWRYfOmU+wO7+ADBES09il1eA
         AR+A==
X-Forwarded-Encrypted: i=1; AKwUvBzreQCw+8EZlv5kClW4uB8v+v1JO1NvMUQStMhbEPKA/ps3n0nkeB7BIvTm8x0wGGfoBlNS6rI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHomD+jZFD3tetFdcv7WtR4yPSVxhOwZPCUNFqt7aBcusEwwcE
	KuJ2hrdrHNRFMRMJ9BuYQq24lUvVptKokWIFdGzT0kec14+LX/kBftJs+QQn6mpsQ9VxNHUOnL9
	KZqw+7Iu1S0f3xtylpbgh4DZ878di8kLRYVtsV02yAp4vme+VQNim4+ekNbNq1TZJ6bauVaoL3u
	eKfBEM7ITwy8Ne2VqbyxQxsk2PW48BQCY0tg8IZwc8tDYo/7G+mWzkULmCxF34t6o27HM2JPhY/
	0bVcBS7OQ==
X-Gm-Gg: AYBFou1JJPwAqxn/VlFi260tfE9ybQVxfrJ1c3UCTGd/x3ReW6DIa+QX3l73g6UZTnR
	MaDF38SxTxwxih9ZOhZ/9+XtN3/xOdPYktorhu0sBM6S37l8yteMlYub6mpwrjvhLGQ+AJsuHgx
	Vi27uO50/LFGPBDBu07fWFC9HWdJgDBOnSpyt8m7BCGVihhK9TVYkq3WGVf9M/8Y3GjVhvB/42y
	kB/kKlas8V9duUH4It7UfY+9dQn4o+ZIsF1NJjW3uXofn8DQdxRlLGLNTzYJJWwXmnUzmVNuGVa
	BwNZcv2HAHzU38h8FE+lDbxumfZrYRkOLsoNzl+F7DfU3riokVzBdLFGOogcavFwGeu61WY/rsm
	kL0nCA2vAgJkXlcbZNu7588X4kezhmRdQur7xTFsHtKkC5X4XkZXgadRAkAyyqA+ARzqpxj2XwY
	8jhs2AYinBFp0TMmAGQ0BMGQ+0GMYasukCbeuV
X-Received: by 2002:a17:90b:2ccb:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3ab3ac63ba3mr2375188a91.33.1791570992420;
        Fri, 09 Oct 2026 11:36:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab370e7fe4sm1526432a91.1.2026.10.09.11.36.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:36:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a470ead068so6122287a91.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791570991; x=1792175791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKGJknNN32NOHQQ/BHcC2WEmlpewEle5M8KqTBEYtlw=;
        b=SFcv5LaeV+km1UY73dXJkmR1ZjWueoh/+ZdtFRQyfHuts2Gg9WFO2sgOWg5P8VQc9p
         nJup7w1uj8aaB6VPSmAZ05ouHbFHxjRADP5bDut0XyaMfEQIJrBX+hqQoyvW/owHmRdy
         cNwyGeDp2GbdqVVeLHDOV5R14teAVD1Gjbq18=
X-Forwarded-Encrypted: i=1; AKwUvBwMkopjDZNwpP8DOqer6LYezipka2dl0jD/3FoaXEozTiJPwRscjRyVmsKhql0rQ0I9ryh2BrQ=@vger.kernel.org
X-Received: by 2002:a17:90b:3c08:b0:3a4:d338:4156 with SMTP id 98e67ed59e1d1-3ab3ae6ae4amr2194064a91.52.1791570990902;
        Fri, 09 Oct 2026 11:36:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3c08:b0:3a4:d338:4156 with SMTP id 98e67ed59e1d1-3ab3ae6ae4amr2194051a91.52.1791570990443;
        Fri, 09 Oct 2026 11:36:30 -0700 (PDT)
Received: from [10.14.5.199] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3386ba90sm3142707a91.1.2026.10.09.11.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:36:30 -0700 (PDT)
Message-ID: <eb4b6a59-2cca-43fc-910c-2a067d165d7d@broadcom.com>
Date: Fri, 9 Oct 2026 11:36:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/6] net: bcmasp: validate minimum RX packet size
 in bcmasp_rx_poll()
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
 <20261008210621.1374785-4-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261008210621.1374785-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/8/26 2:06 PM, Florian Fainelli wrote:
> In bcmasp_rx_poll(), the driver removes a 2-byte alignment pad and
> optionally strips the ETH_FCS_LEN CRC from received packets before
> passing them to eth_type_trans().
> 
> If the hardware reports a descriptor size smaller than the sum of the
> 2-byte pad, the Ethernet header (ETH_HLEN), and optional CRC
> (ETH_FCS_LEN), subtracting the pad and CRC lengths underflows u32 len.
> This adds ~4 GiB to rx_bytes statistics, while the undersized frame
> reaches eth_type_trans(), which reads past skb->len into stale buffer
> data.
> 
> Check that desc->size is at least (2 + ETH_HLEN + (crc_fwd ? ETH_FCS_LEN
> : 0)) before proceeding to process the descriptor.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>

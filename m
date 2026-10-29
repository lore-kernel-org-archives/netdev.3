Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295219;
	b=FjcSqoULNf8WwCWbMmOHW5+uhwQ9djE2smjiP0J0RmUyadWmXD45Bv13V41BwDF6A9Dx
	 /I54l+GNLiQSAAUotdwecxp4ncl9LdFNQed7XVQONCcp1tUc4iyhxSLzSG15QHdlmqkqt
	 V40UOsdgWijVoBvJxJWcOXngTnJX7XKSn+ZMwcucNiT+zTpqxFshMgYQcEqe/K3UGBSUV
	 QdK8hU+J6AZ+DZn7yhRLSsV2Y9nkU/anOIxK8mXx6Pb4yo75WWEL8YaHaxQ0kmvKKkVJw
	 cwoZpmdaGljpfDqqnPMOVYDCYSQhA/lWIKu9XEIVs3E6XTj9SKZ1o0BaWorK1BZUOFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uuZVr2dDD8L7r8hiDqf/9pAQVEjMjpBKtDSDj+H9kVI=;
	b=Txc2iFBzKLztMKwUGLyoA5wcLiZxM7EoeDmES8IXWrWaScJhx5zRE1j4WPBMcfNlaHyI
	 vPHO9HHZi6tgkY1UajrH6z/ePdmZGEwGwQINjpWpx+MN5qZpbhctSn5UM7L7Dxs9VUfOe
	 n5u0amLVyQxfdOHOjJSSa6HNUGkNQ+JwQWfta4Kh+hlW54ycsdVRPG3lu8Yv3unC8Vxc4
	 F4rmoTDh7PWuA0tRgd04lon+J1WsO73LtCoGK3ODPZ4F5/wKWrx3PCXrAjY9zsPN3Ko83
	 YCGH8dcWaOTrk6NIDfcyTuN/s69BtxRSOOcQrl33O94fxzbhSi50q+TEWEa904MtoVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="K9Lg2hR/";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567C606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9567C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K9Lg2hR/
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e985106c0cso21811965ad.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295218; x=1793900018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uuZVr2dDD8L7r8hiDqf/9pAQVEjMjpBKtDSDj+H9kVI=;
        b=K9Lg2hR/BcJ3lcLhlIPYRwiKpVggLgPBY7jwOhmSKQBwZ8ZUmwigu084YPVxYiPJ39
         W14DEurU0hHITVNzc0ooaUCuTFlJ/A4cB7VLjfO2t8tUk6tawb9Jr61kbcJkJHcG9EYW
         /++a6lcYtlnEhP+e4ChCLdocYZhEpThs6tXBfATq9gZbfH2CVqNrchEzkByYr1tuUEjw
         /EB21+Ztw6Uw4LBCfhivfX0/cQeanJUVc89i5c9EA4L9jQlU3n+Y2ZF8yhxrC5u+fVYj
         gIGWJNkW+UB0pnvXA7lsERKUBGue+2tL6T5YvsI5BPd0PNEA51o/RqYWZIGGmYiVYpt5
         5Jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295218; x=1793900018;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uuZVr2dDD8L7r8hiDqf/9pAQVEjMjpBKtDSDj+H9kVI=;
        b=KwVrSQ/fxKPfh8buXIBrpSXP8LXUOmpqCSbA38E7ut6iUeOVGbVVVRU/HWBKQk6au8
         uNHsgRKc8yKKYpfGJ23VNTOhyS9N1zn5ok+V+S+CcUk/VlRLVkrYiljejahcJ/ZJ1Gjf
         nu0MHWO5qjgSCrggMOmiykv1muV7/wKHQutTaAM5SK7G/OpRyR3VSRf5B/iStKjolc/N
         bUJHiMePg8uKWup3gCn211M5YL6OijVE4OBmChFsDDltLOtV5NWgg4AnwLt9BFzmxwc4
         LV58m07dszaQzYLEzBx69IZeZlXNNsGlUFCtkSkpj1cMFgtFnnjhyF2BN5JI6monSOdw
         4Q6g==
X-Gm-Message-State: AFq9FYLFftdZYWHxYlhq6vkajh/YJ5gOZSKV5TRbnjUwFOqzN412pfSK
	BU177WEmFjhYthbE8craAzAW56iqQH77qXnQUCSIGubFFRn8sWF6+fJ7
X-Gm-Gg: AYBFou11Sx7Fk2+eG6wG6xcUuCUWcJm2dvCLaNhlNrLmJWbv+6a1v+c3BewpCZfll9x
	bc2X+IO96Y4VIGVeake3yxvThvw61I7xLDcw9j0epEiUDDtwm7yCscws3GEoNS02FyPQzDhzCkw
	KnBDF2ZdXVZnrlmC9tsCmuAAtrYgbFRf8A4AFeLWRs5lJ331Wq4EhKpOxaA1n8gGmrufyIcWRwc
	fEKfE4i/xamoxMu+vBk0JljyPFG17A3VI2QZmnlsPKA25GDKr6uqz5S/HOAWjg3W/qOrneC46fy
	QNcaWksrrGPrHrUZmds1qwfvYVwMmimCv7Kiq4arCDWLX7IxYX3KDjKCvjD7AuC8Yh5LI0Fw7t9
	5r8J1zxY4EUmKi2ASNpyvGJHWZ5NKiumB3IgmqNQqcoVrEgtsnJeq0bCQ2mrrJ98Rozb9lT87d3
	LUOXXkJl0m1sKKbCZ/O5zibc3M/QXF6N89gFmMwaYK0LgaBZh2XKnUPwlhQVoUTesqL4VY/pchm
	o3FS/YtFfRT+DaLhBMYP5pBuFQVxgCHmJlRq1an9e/BQLw7h+58Hzoy00sgaP3zNhrdJ+b6qxHK
	wA1Q4lSHKOdQuuRMTW28SL+33TQgp0ACzdGK+AnPBpeuKJb7+95TejzQ
X-Received: by 2002:a17:903:37c7:b0:2e8:b5b2:a9f9 with SMTP id d9443c01a7336-2eb364e9f75mr553035ad.37.1793295217825;
        Thu, 29 Oct 2026 10:33:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3630396asm295325ad.35.2026.10.29.10.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:33:36 -0700 (PDT)
Message-ID: <b3a52e91-170e-464d-b1fa-a545f6abe5a2@gmail.com>
Date: Thu, 29 Oct 2026 10:33:32 -0700
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
Subject: Re: [PATCH net 06/11] net: au1000: assign a valid MAC address without
 platform data
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, shaojijie@huawei.com,
 horms@kernel.org, runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org,
 jeff@garzik.org, danny.kukawka@bisect.de, mugunthanvnm@ti.com,
 sebastian.hesselbarth@gmail.com, linux-kernel@vger.kernel.org,
 manuel.lauss@gmail.com
References: <20261027223140.3774570-7-f.fainelli@gmail.com>
 <179329051563.3134.3476237104312720828@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <179329051563.3134.3476237104312720828@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/26 09:15, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The code change is correct, but the commit message overstates its
>    impact.
> 
> --
> 
> net: au1000: assign a valid MAC address without platform data
> 
> This commit adds a call to eth_hw_addr_random() in the no-platform-data
> branch of au1000_probe(). Without it, dev_addr stays all zeroes and
> eth_validate_addr() refuses to open the device.
> 
>> The supported no-platform-data path leaves dev_addr as all zeroes. The
>> device can register but eth_validate_addr() prevents it from opening.
> 
> [ ... ]
> 
>> Fixes: 7718f2c27dbd ("au1000_eth: use eth_hw_addr_random() instead of random_ether_addr()")
> 
> [Severity: Low]
> The code change itself looks fine. Is "supported" the right word for this
> path, though, and does a Fixes: tag fit here?
> 
> As far as I can tell, no in-tree configuration reaches the !pd branch in
> au1000_probe(). The only "au1000-eth" platform devices in the tree are in
> arch/mips/alchemy/common/platform.c, and both set platform data
> statically:
> 
> au1xxx_eth0_device:
> 	.platform_data          = &au1xxx_eth0_platform_data,
> 
> au1xxx_eth1_device:
> 	.platform_data          = &au1xxx_eth1_platform_data,
> 
> board-mtx1.c only copies replacement pdata into those static structs
> through au1xxx_override_eth_cfg(). au1000_eth_driver has no
> of_match_table either, so device tree can't create an instance without
> pdata.
> 
> On in-tree boards, a missing or invalid PROM MAC leaves pd->mac zeroed.
> That case already takes the existing else branch:
> 
> 		if (is_valid_ether_addr(pd->mac)) {
> 			eth_hw_addr_set(dev, pd->mac);
> 		} else {
> 			/* Set a random MAC since no valid provided by platform_data. */
> 			eth_hw_addr_random(dev);
> 		}
> 
> So it looks like only out-of-tree board code that registers the device
> without platform data can hit the zero MAC failure.
> 
> Could the commit message describe this as a latent fix for users without
> pdata? Without in-tree users, would net-next without the Fixes: tag be a
> better fit than a stable backport?
> 

Agreed that “supported” overstates the in-tree impact. I’ll describe 
this as a latent regression in the no-platform-data fallback.

I’ll retain the Fixes tag because that commit removed the unconditional 
random-address initialization, introducing this behavior.
-- 
Florian

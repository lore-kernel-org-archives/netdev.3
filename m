Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505357;
	b=rmTsL1JHx6eoehZf6TXJNXJjmc/a8P7JFePb2wG9ikKQBNbvJxVomMayxUhrL54cD9ZQ
	 RO+v7/25phpoEksOplFOIKNnlEHYRJjX+YB30lMXV1rvMX6g+1kBDeCEHusuCUP5gvwcy
	 9vZG+vy7SGMKKPHg+Rr/EBnbwsaVCVCLiJvU2piVG6NhC0T2DE3/MZ3lbKLfOXBke1lB7
	 LhArLJfclAEpfwVQ3wH300qh/IuvC/MNPd/V2WfWtDUlD6HM/Es3OpeKQAyXfw8Y91T1p
	 /TAfoBluEM6I8J/G5PwQS0R3O9vYrGejKjH7BqgDLUrrNf35/S9MAvISAtwp17RvjGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=u1NEdh1mEZe2kKVcz0g0eDrtNWhvrCkFo+Hf8BDUgg8=;
	b=nCC15ncYhg6oLQx/R2XLhckQtPqhzA/MLrCAxHDQVPMO8gCYxePbCULXTIbKUpSH59/6
	 wqSzlmZvzDmyDDZaQL10VoyO3Oa8j95RZ4CtvFVpRZ8sbQI2HA/XoD212YBpQVM5baxR1
	 y/dhDyeshiizC+H1vEzei+3So8XpNKErJpVuxyIsnI8tPM58qMJyGyGjUjKeua55p4EHX
	 PgfIwBdr/Egd70czT1vrFF4YtTUCdKAlkxtbHfBSdFr0dQhrV11Lgb5vvRI84IoOqlt67
	 MKUuUUlcNKe9ArqAvg6SEbeDLph+QAxoJWh2JC/mN4cIqIE3UCPXYZU/4Q0YctVSdlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KmPebONr;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA48606A88E
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FA48606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KmPebONr
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso44951a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794505355; x=1795110155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u1NEdh1mEZe2kKVcz0g0eDrtNWhvrCkFo+Hf8BDUgg8=;
        b=KmPebONrlKWW6witqDSPIGv9QobVTxveqKT9knC9PSB1Vx9RGei3Nt5h4qW2mwz6b+
         k0EoVuIC5KCdgcZykUUvbhHtluzKrG1Q6Yiija/1ZZmZikFkYTVCSq2OUYT1LP7w5DUd
         NiYryhxihRSuJC00l9IINTq3ZZ4AcqPYnUQHChqtZ3PDpXsxrc290TgLltMeLxOygAjH
         8yLATWSJdvG6z1fuVEaVEzDaUs8REGxiXhq2RXCEJXACcoM2QIchoit2Y6CBh01xnZA2
         HxYPSOIXn1UENgYjE59GsJCJvMMvFybqlxt+fXHCqT5bMRu1Yvnq8CE0CyXMyp0JDxTx
         PYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505355; x=1795110155;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u1NEdh1mEZe2kKVcz0g0eDrtNWhvrCkFo+Hf8BDUgg8=;
        b=Oo0AqTibFCF2q2nJ028Oqpm46bZ3lTy1S7apUOcGfRxZ3Wd+hMdMTgbbB91MD9uJ5F
         CIMSwDS9MyYEouXzQ0/Jde7BSF9+NInYHGD1/oqb/mbA0gJe0YL2m8Ny3loru5XgtYcG
         lbMqmXFwHltSHi3ZhOA5JLFocD3mCVTsAqGqkYeeTP8ugLUap7etOcXO2KRYkTEjW1H2
         ChkXBGQSn4nJyaSHgtsD9CDGL2ycdEDobyo+vfpevBlR3pQ8PjhfCQ85kCLhjBIFehoY
         5R6GcoWHTC9p9jSeqTa4G2TJeKbPz/gc85eZhh5InSdCPcXCjpDoiIQenlOMc2re9Nki
         OgPA==
X-Forwarded-Encrypted: i=1; AL+hErHB3nbPqnxi2CLh2REzcXvjpbATMyi4wUlJg5E7JWjxG+N5I46pgGHo1zH3akadNblYA1uthR8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gXd+eMhQzYjnVsJGPqSW44FzMaHFRoEunsPjs6jdYje8nTx69
	xDQA/bOqdH5IXzjYfYdw2FX1eKTaITkbUvV7sYVlrbpzCcxgnzUGH9JG
X-Gm-Gg: AYBFou2BOzWosanPeHaPJil403NNXNm5/eF1ZaYxogS0Vmrkg3qUkqbF9P8fl+hDBlI
	HFIs1U5wcY5++DVZLhI3itL7kaUfW3m679zslOPwSQQTwkb2JDp3SQriNwnrYlo2FymWUhnO3kD
	zI4aw7S9hfTurmRG3BdBLYsD+f0n1CljdP0IVSiNoN6FroyVV92gls1mw+0EfvhJMUj1LvTq7+H
	rcGl/JNsHqkHnaIOnxx5fDcSWp9uZcJqP3DZrEU1PJt2/CsSVcBaYTq8ipn+FbDLUdAzbh0BKI6
	IZP+ykCP6W2LtpynpS7BzAVZOi5/a1tc357YwgodRvQBmYujQc++g/yfrJokAJf9Lo8N5dyUNVc
	lGCJCc6EqN6gYGi+wy8AoTONtWqyDyMApIHes/PsC7cvAv2R47omr4JR8OtYuivej087bNA5Kdr
	0iFdFVTRC7S0a2YV30Vp39VPqW9sjnIxd+ec4uRs+uB8lfiLATlg4dyVvwGqUIC5CQByyCpK/98
	CMg89pvh31SjkuUqKQvYJfd2yWlinKhlrswgawAp5NGMPevooZA4hKdj6W4ZgU4i8QyNCbBAref
	U4KsauNorPeWiBIGoOXCx+ivIUMExeBV6ZazWcZaob4oJtJZ6WiHCjcPdisoX78FLANhc90hBlj
	34g==
X-Received: by 2002:a17:90b:3c46:b0:3a0:b312:1fbe with SMTP id 98e67ed59e1d1-3b182efb282mr5707612a91.23.1794505355301;
        Thu, 12 Nov 2026 09:42:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b12esm37630625ad.21.2026.11.12.09.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:42:33 -0800 (PST)
Message-ID: <bc45c1e8-6904-47f7-9c96-512e024c9d71@gmail.com>
Date: Thu, 12 Nov 2026 09:42:32 -0800
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
Subject: Re: [PATCH net] vlan: prevent cross-netns MII register writes
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, n05ec@lzu.edu.cn,
 ylong030@ucr.edu, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261106124639.12584-1-dennylin0707@gmail.com>
 <20261112075624.23c04230@kernel.org>
 <706b09ea-49cc-4801-a24b-b22d2ea7d257@lunn.ch>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <706b09ea-49cc-4801-a24b-b22d2ea7d257@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 08:15, Andrew Lunn wrote:
> On Thu, Nov 12, 2026 at 07:56:24AM -0800, Jakub Kicinski wrote:
>> On Fri,  6 Nov 2026 12:46:39 +0000 Hungyu Lin wrote:
>>> vlan_dev_ioctl() forwards SIOCSMIIREG to the underlying real
>>> device without checking whether the VLAN device and real device
>>> belong to the same network namespace.
>>>
>>> A VLAN device can be moved into another network namespace while
>>> its real device remains in the host namespace. This allows a
>>> process with the required privileges in the VLAN device's
>>> namespace to modify PHY registers on the host's real device.
>>>
>>> Reject SIOCSMIIREG when the two devices belong to different
>>> network namespaces. Preserve MII reads across namespaces and
>>> allow MII writes when both devices belong to the same namespace.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
>>
>>> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
>>> index bca0a3693636..0d0904103302 100644
>>> --- a/net/8021q/vlan_dev.c
>>> +++ b/net/8021q/vlan_dev.c
>>> @@ -416,9 +416,12 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>>>   	ifrr.ifr_ifru = ifr->ifr_ifru;
>>>   
>>>   	switch (cmd) {
>>> +	case SIOCSMIIREG:
>>> +		if (!net_eq(dev_net(dev), dev_net(real_dev)))
>>> +			break;
>>> +		fallthrough;
>>>   	case SIOCGMIIPHY:
>>>   	case SIOCGMIIREG:
>>> -	case SIOCSMIIREG:
>>>   		err = dev_eth_ioctl(real_dev, &ifrr, cmd);
>>>   		break;
>>>   	}
>>
>> Andrew, Florian, any idea if we could delete this completely?
>> Why would anyone want to run MII/PHY commands on a VLAN?
> 
> It does seem questionable.

Agreed, it does not quite make sense to me to forward these ioctl() 
calls. Looks like this predates the import of Linux-2.6.12-rc2 into git, 
need to do some more history digging to find out why this was done.

> 
> Hungyu, do any other virtual devices forward these ioctl calls to the
> physical device below? I assume they have the same problem. So we need
> a fix for them all.
> 
> 	 Andrew


-- 
Florian

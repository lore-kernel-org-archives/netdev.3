Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC22502D59
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570982; cv=none; b=LAAJWMWcCfWqBXD6yoNaQvyRMrWIS6qksoG9W/uvTOa5hq7MYACaKzvLx2qhmhqkwJCuKsbohMJWlEGelTboYXUXlOMO5y+AdVCkjGRR+t63/RazKewxRcF3TcjT15+0MDNHGWt2atHymDvhKpYuUg3LDYZirZcJmhnNVp692tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570982; c=relaxed/simple;
	bh=gffTSitD+ngEJ9p3QPBtK6JYSHa8kp6UkeCpTo27d3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMPES+ilCbz/XKa+Mo77lyfV7vmp7e9x2iQ0Q+TKMt0Fb2rwXstdibS/1/F9CF/KgnL0+5co5bt/8V1SyYAnsWuCrtpsbhCWwsgr3VQ1dmhRWHrVB6qrJjspVF3BJ5NWub5f99dZ8iGab0X1pklc3hQSAlJhpDltgP1JC0J72VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XEwVbhOK; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XEwVbhOK"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6776efd4ff1so4450908d50.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570977; x=1792175777;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ib7mPYYGhon+XIy+PaInZeTMy4DED8QwKQU6HZL6lNs=;
        b=2iFvydtwjPkUqPhKEoPG1wWadNzzgZkwJkuBBtLcsY/E1oUic7z6H2iLA/fOWizLZH
         pXUZ7Cf+sLe7fc5/Fbz/cxc91DiCOmEqmbj1XUd4driPBmIi7pzvQ1DeWB18p8qGGdrB
         gAQqwR4+1rLigXsQXQEMaNuPMj6VHdeR37QKZ4pXe+q/d8EbvEVsL56QKWhrnRb1jGhv
         e6JwCs2XGNJPFoNCbPAjG4hWpOmOGFCMKNn2AXCwjhgUvHXZtN0j4rSYAt1KSYOUWrAJ
         5jPNWviT3zYxa27Llv5BAn8JgiWNs4EPdMqsir96VYWiU3xNcS23OBTr4D5xwtvydegi
         twcA==
X-Forwarded-Encrypted: i=1; AKwUvBz4X6eEaoqzWVrkCVFAI/W1s8KTDHC8PfOuJIReHHiIc1s79YklVHrt6uQEWf3bwK4nRcM6ZC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyerdmKESdOwDY0ev+q5ADoQDe4dak/0lCuMeKwPykA0iZXqkm
	aOOjmr3qJpiP3E9DXsU0od2Y9HoOqjke5s3s0e3Nkx4nINwCEWX8Jo0rRTgD8EQe38aGhkExYAo
	bFomVtfFF4LIJWagB3XwaEOgkw7vlDzl5DP0kHFATWL/QHO9RgBWTAMSnVH/+3Qu20L/OkipcvB
	75Ng5m1NaHhpBFUxQE1ySQeEI/lP6CLDV7PJVtCDP027Yi4B3EaG9xp+hZFdm+6EmvDfqqq9RdH
	/K3NKhsjw==
X-Gm-Gg: AYBFou2BQJ4fL+Z5xbnWIn6wAcU1zqG7OGoKlJBUd/VxQu0vKv50t99+f8KkdnYeY+1
	YvgivPm3ivs3Dlq/q2/T3ftUiFNU72zFbcUpQivfod8b14/Q0hOjXnBktbbJ1AEPuVV0hrrRYIm
	RiRdx36g1c6+EDoPn/RfDfpKcosFgg4708KrwazgEYglZRVQM2bXOErwXxMMLmzglv+/cNtOXdC
	kIGKNQXQrfaqMkzYG+voxbcjxzHG3D1fGYdhC5w4uy7yuMRUam3exEauXUNAaV4eYxRsKuJJjNT
	Lo5I214MXNM+VRQWQMXCsK/6S7R+SypoOigHSug3gNSoseYCurELmPGfVDqpIcjkhZ3aJQfghji
	g/plATteKrIPm8nB7gJeDP45KgxLAplgaZViLK5a5NAcBB6B1TXJJDOua+r9iERcth8LGFo6MAU
	NF/GBKk9fSWdcbFHpFgwvpoxSysnI9OkuS75t8
X-Received: by 2002:a05:690e:1381:b0:677:d419:3a54 with SMTP id 956f58d0204a3-6793694e66bmr963915d50.28.1791570977495;
        Fri, 09 Oct 2026 11:36:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-679356e72fbsm120826d50.43.2026.10.09.11.36.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:36:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8881a7875e5so8499b3a.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791570976; x=1792175776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ib7mPYYGhon+XIy+PaInZeTMy4DED8QwKQU6HZL6lNs=;
        b=XEwVbhOKSdXOGnZHxH38VhdaN5IyzpuBRKMJy5bErkEqsNM2VNpQs7MeUsbEQ09zqA
         7xoYlJSOW56agcCfLmbwX+f/BwGW21haqFA+cx/9w0d6qkDDNvG54PwV0WS2Ryfx1DT/
         7pmEFDE9D0qH5WniR6qmteMxT2e7M1ADx2FEQ=
X-Forwarded-Encrypted: i=1; AKwUvBza95yEGah324+vy5SYEquu/1+KFC725msi4ViWWp+ifDTiFRAqq+QErorfGfQsbeTjJ+88fMI=@vger.kernel.org
X-Received: by 2002:a05:6a00:3399:b0:887:3fca:8330 with SMTP id d2e1a72fcca58-897c72f7b92mr2229452b3a.46.1791570976257;
        Fri, 09 Oct 2026 11:36:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:3399:b0:887:3fca:8330 with SMTP id d2e1a72fcca58-897c72f7b92mr2229426b3a.46.1791570975813;
        Fri, 09 Oct 2026 11:36:15 -0700 (PDT)
Received: from [10.14.5.199] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c310738dsm1570613b3a.16.2026.10.09.11.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:36:15 -0700 (PDT)
Message-ID: <5e5da857-c83a-4b33-b671-069b84b5b33b@broadcom.com>
Date: Fri, 9 Oct 2026 11:36:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/6] net: bcmasp: unmap previous DMA mappings on TX
 map failure
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
 <20261008210621.1374785-3-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261008210621.1374785-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/8/26 2:06 PM, Florian Fainelli wrote:
> When mapping an skb with fragments for transmission in bcmasp_xmit(),
> if mapping fails on fragment i > 0, the error handler calls
> bcmasp_clean_txcb() for previous iterations j < i. However,
> bcmasp_clean_txcb() only zeroes the control block fields without
> unmapping the DMA buffers, leaking the DMA mappings allocated for the
> head and earlier fragments.
> 
> Call dma_unmap_single() before calling bcmasp_clean_txcb() in the error
> cleanup loop.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Assisted-by: LLM
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>

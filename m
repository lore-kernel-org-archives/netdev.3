Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2653F68B
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080117; cv=none; b=Yu0Y4B9VoDBzp9WCrUEvCJ8yeUAO6qkuI0UTL878rRnTlhw4+b2EXOkDF3UiQ16gSEsg9Mai7L2/XZb4onNfD4ApXuGJlj2nuwnwqzXKuAp+Nlf7kZ7/vAfiJrXhOUQj3WoqiRTwH5i377X6KvA1rkH+q9f3ltxoxE3ur9daMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080117; c=relaxed/simple;
	bh=JE8rTmi+yV9lC8I8Q8izF99dyKvC7oYaJcG+z1U7BXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgRpQDKaRIdEkgwbqzhkH9v7prVDRp4k3vZr3cHENjnT9Nu0FmvyGDQHJ7fzWyg87jP+/W6V1sXdTqBKwFuMgZrc2W2AUBxXT7/Jo3bbJ8ekURXmYa/QNLOB2iJEpm/3Agva+7USDMVLDkXSxawywwmrd6u5u7FW5W8Njmfvw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=CrxBlAkl; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="CrxBlAkl"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91b89c6caffso14773386d6.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792080106; x=1792684906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NALvi08ArpEQSQ23rf9GeRnMp+xRrLbipmmnb3o1ZPA=;
        b=CrxBlAklAz/i+mewrnF88ATKZ1qirKsY0mt/ROgawZjbqQZrGAOw0yY6dRMgYEzBOB
         WGkTXUY8wHzHE4EHlbIhqoLGBLjGwJx5ouYtr77AT0965ZP5vcOXG0kA2bk4V4a1Ll5g
         kt5XHTAKFgmWHGVvl4m66+SqfX/3aoicIZdUimYWmI7WQaUHx+Hbl0AQkVGDTCymCq0H
         RXGh9LmV5sfmUAl1G5e1te/WLgsaYTDF3fOx6/e+HCqgNh5oU0duep2XpOXaIYSHUjR+
         FmcOMBGjBGk31iRGRL6U3/WIH/K1y+w4oTcNVAtFqnuMk+Eb/hEIPDvBmb/rlchqvBMx
         2nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080106; x=1792684906;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NALvi08ArpEQSQ23rf9GeRnMp+xRrLbipmmnb3o1ZPA=;
        b=ZPRRBM8ACvMzJcHDLNoOoDsGEBNMgfQqUcIsXfXejTmutVzhWx+/QIyit0Cy296PU3
         r2h1RB1gawYzYE2QzeP9wEJQ9q5549wh+YEbtYj+LsG9aUcvMJ0HD6/GZ4x768Ao6cPa
         HkJR+pt0gLw15uKfFmIBtIBwC+0gZNENfxniZGkZgLlS6NXTxXaVEPiw+5h/u9d4fuFh
         rw0CSPQOeJxTbm6WdizKWsuY5JRVOUTadXTxRQhQBAzQ6xaX0Mg6GaCT9MdL8w97rT/s
         eceRtTh23G65MtroTrtZU3ar2FBMCoi2+AmvVe5MzSwzAEHHCFh6Q2C2kyyorJWLmg/2
         cldw==
X-Forwarded-Encrypted: i=1; AKwUvBzhsWS7fElq4R6NV89BuoFDmPGdHrDHjynciaQmyMKMkQeje9qRAMK5WkQVgwzgxpKcAB1BDZo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvcwCp7GyB8oCJMRlP08yfkC6yKVnbdGM9hP98eNJstnXb5VDK
	Gys2Spt0J1ELH6Lwk2a1WY8ls66vTrdTzZlZx3Gk4PbYX9L3Xv1SmBycRkZ626n3BVE=
X-Gm-Gg: AYBFou1waEe0lo3yUaUzVlq/1hqVYr51OSpdSvgOWme20TobQTdwqJ+0nebqVErIVJF
	uXzhXQ7cWF5K9d7VmIfrn8AV0fC8iXiuYXRvKxmZ7U/lbYcgmWMbapKp58w3pngGREo5ZYCzgTa
	lNrqiLEodDUyZGD0Y/l5DaDmYYp9y9QiYeqtaIgAtG+sXtDfWt2j/vTQBXeSHKYZoxmmufSvcmb
	jTXHk0Rfaty7An2mSbIMprvYkPzWK24UGs5J1YuanEMLLZs0gX1x4gwBP5GIrSrQ/+dSCWPN8tU
	GTxvgyuFsCGeoCtmZG6IjQ2ri6EjnMGPDnuRtwN4PDDU+QIYd6BCo6sVhYpoUZWjraHvDtItNgQ
	vr74+QjnZ3RqyVifN9ekdrXsnIAce3u26W+yCOrjsVzzMtaOC4bqysfLXO9+rxajEPhUJNt4XCn
	rbfiFDTZoS3gOd5pTKjG9XCtXXW37I1/YA7mOKMgtxj3oQBVQ/xsuZGq7YvEXFNVup/bY/AoA=
X-Received: by 2002:a05:6214:4586:b0:917:aa89:4168 with SMTP id 6a1803df08f44-91b5579949bmr310643976d6.40.1792080105628;
        Thu, 15 Oct 2026 09:01:45 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b383dasm85388086d6.8.2026.10.15.09.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 09:01:45 -0700 (PDT)
Message-ID: <4fc165eb-b57d-41f8-b7b9-c9fe433d866c@riscstar.com>
Date: Thu, 15 Oct 2026 11:01:43 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: Add regulator
 management
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Daniel Thompson <daniel@riscstar.com>, ansuelsmth@gmail.com,
 donggeunyoo.kernel@gmail.com, mohd.anwar@oss.qualcomm.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015143849.483339-1-elder@riscstar.com>
 <20261015143849.483339-3-elder@riscstar.com> <atDz2hJ6xpA3p5y7@lore-desk>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <atDz2hJ6xpA3p5y7@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/26 10:40 AM, Lorenzo Bianconi wrote:
>> +	if (count)
>> +		fsleep(phydev->mdio.reset_assert_delay);
> nit: should we check reset_assert_delay field is actually set?

Are you saying there should be an alternative delay used
if it is not set?  Do you have a suggestion for what to
use in that case?

					-Alex

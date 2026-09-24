Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24756395DA9
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217194; cv=none; b=XoCgkAGZ9g4j8+RWnabSqjUK3nv3ejW8uWR7rATB4dwh5dUJsBpVsPM8B+9T4Pg9FQeUJ/Ha3AteX2A1qJ1hiXVtDUfyKAC4Zom+qsANCHAEqJ3Wsyo69kUparPV3JaBY8WvugXNeF7fZSblLjrBfGbHJtToHJpl4L6nJoNITS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217194; c=relaxed/simple;
	bh=0jewx94Aol1IKcOojWLEYdfUZw5SFvsaq76oQocjly4=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H8+QuWAhdWhOz2ey/KQjsZR1iUBF1fl0TPshDFtbkTSi7Ut50B4U9ksd+z2yL2Gwq1zrPm6Zxh+oO9/bKAkw7vnsq/IBRrWejh80ugguHd+R8BL3dVWHI79YJ6D5umqcgnDvp1yJUT2QjY5JO1TfLB31w96WWJfbK8XVflbn4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEPM2v4H; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEPM2v4H"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so762266a12.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 19:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790217192; x=1790821992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z/L1hXpzWJJQOqyHxMdxo06cE7DFt8m14lGkwmdYDss=;
        b=pEPM2v4HmYnCBdcjLhRfQthAUgIznDDSAb/yJkPUGOfEQjiFnEDwh8JEiXlb61EipG
         PGRLTSSYptj3quZrjdgtm54YnpmuMi+dxy3IPrQeStvlGoKMqYPWs7e9fNLRJqA51Pmi
         toE9TVa3Xy40yuFhjq80dI+kM3x6B6r8mAc80Wx/1lAIPgWlvB8Cw3amxz1si0NBl1Hs
         Jis2/P9TuAC5bAUa/89PWkNXHcN88hTwc+cTe0S7k5XYofc4GTKy8hCdD6OVKHdTM0A+
         21uMyWPvENaZFaCH84M+GoAzVmqV2b0UiCAfpMDx0M5gxt2NHp6Z+DpwSeqtQLLCG5iy
         nqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790217192; x=1790821992;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/L1hXpzWJJQOqyHxMdxo06cE7DFt8m14lGkwmdYDss=;
        b=obUfKd4JnnWPE+HuzmiJJyv1l/UHXmqAD/MzKm6cHTNdivMIYSymYCfcQKcvja8nJE
         SGxsbnFkaY/Ocfg1I721E++Hq4tfvUySlzNs/767CdjHfk8dHZOX6TK7PIz4AAr8ueCm
         xcxel5wQHbpr1S1okxs+TPAdS92B7OjA9VjDdUkHji8NkyuJJG4mb7xlI4dokKbeNEvj
         0keq1OScUxzbIV3D/lIT7f+9pgpuzSvhkMK2veXe7fwHOk4G9PoeffDtDwDKmI/ZKNJM
         JTLWlZtcR6OiBs5dY7qOBDb5kjxCpZ/4/PfUW+Oz5j8zqbs8G5PxETyuGo6QwUdkbKmB
         CWiA==
X-Forwarded-Encrypted: i=1; AKwUvByp7hyxgoCIgnzdaY1OF8vbwu/11mk/sJ3fRIKX/JmT4FdH0tBFdzME8X/OBzYjGZqHpzt6AzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lXLJS0G60ooUmAB6tEiwC78eRyUHblJyBFx3ptTfFLGLZJdHsX
	EeNnAxWZs7papKD2gNrcAeSnvWcaJh23mwpmoJff8SOE0daePaKYChJSgaVyhZKF
X-Gm-Gg: AYBFou1bXHFp/fPak4EmUVcoAbyJxlk4366hAsKXnhMnyKJFeUEzJsc4nABDBHq2oIj
	L89+/8lJJsLtFdSLpqqoA9/LbreFDMRdVKR83ePibdgzqKMOfoRjFPhRogjUbbUfs2xapEDwVtw
	8HD6lfHjtzHdSwd6yKgHVkQzcbbERZdkGsAlU4utGtrZsBk9nteeGYXNQZJP1zyhON7MojgsjVr
	H1UzfzdYMxDcmQbnMkMM47R1UgF8NrFCsvN+lybnvZAabcKkANXqMXdUazA8UyUokQUyon8lOJJ
	spnMqzIdJpfHIf1OpilVns6COeyMd6k1ofpDNDNWSAE6L4SsIdqs5FQt2dDQgRHKvcaiiMpM6YK
	3o/Uxv7plwYisLTkP8ZmysUD9jRRlGCC+jueZvSOI/Ao9a1a5cyWMeisjoMtCK40cybQMO/b6cC
	95tDDgj1DVhoO6qRch29BZ14oqvgtBoI7A4mF6N8S8Syt4pus+aZJwysYN0XrD1v6hIDtKDzbtT
	+H+pWhIAbA4kwMoWa/kYc51D1h2w90B4w5zxMxU
X-Received: by 2002:a05:6300:68c1:20b0:3de:1526:4602 with SMTP id adf61e73a8af0-3de15264efamr5628637.59.1790217192226;
        Wed, 23 Sep 2026 19:33:12 -0700 (PDT)
Received: from [10.1.1.24] (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad4e06sm2075342b3a.41.2026.09.23.19.32.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2026 19:33:11 -0700 (PDT)
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for ColdFire
To: Andrew Lunn <andrew@lunn.ch>, Greg Ungerer <gerg@linux-m68k.org>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-2-gerg@linux-m68k.org>
 <42ad1525-fceb-43d6-aa03-d17e844a9ad9@linux-m68k.org>
 <eb987eb9-f368-4d28-bdd0-c289c3039c3b@lunn.ch>
 <46246a5b-3e95-4ecb-bc52-e374dc136514@linux-m68k.org>
 <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, nico@fluxnic.net,
 linux-can@vger.kernel.org, linux-spi@vger.kernel.org, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <3cc86de9-9007-42af-7291-70e52f6b0dd7@gmail.com>
Date: Thu, 24 Sep 2026 14:32:54 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Am 24.09.2026 um 02:15 schrieb Andrew Lunn:
>> The driver will always need to support big and little endian hardware, so I
>> am not sure how to avoid some abstraction like this.
>
> I was wondering if there is a linux standard set of macros which is
> supposed to handle this big/little difference, the macro knows the
> architecture and does the correct thing?

Knowing the architecture may not be enough - there may be multiple 
platforms within one architecture that need different address 
translation, different endianness, access quirks, the lot.

We'd need a 'bus' parameter in all these macros to avoid what's in 
current use in arch specific code (take a look at 
arch/m68k/include/asm/io_mm.h for what may be the worst case example. 
Don't do that on an empty stomach though...).

Like, use arch supplied functions if needed, fall through to the 
standard macros if no special handling required.

Cheers,

	Michael

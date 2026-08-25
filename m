Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A6C3DEFF6
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648466; cv=none; b=DtcXT4m48Kuc7kGHpAa4Fv+DXkXo3vvb0gRoTdoBqewZ+F+aze/W9jA/gXmpKuCdD7IXRhaq4Tjj8hiUHbYOu7/A+Zl5KQjP07sfQraBWM1p8EwJrqnHq4sH9eK5rXrh/6gTBdmX2NtsdxG7YxkiBv0bwOMJA8Qs2hzz/eFO9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648466; c=relaxed/simple;
	bh=9xDn1ajVKRzKRfLuy/bg7I+rTvn4E57pv+fN44j0jRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW0MFAJ/U6EoPOW+115IOQXqQi3++/9ijtqdHekpNMaArnNG7K+EUQoHy9yYdBRa3q2e/f45hgDueY0pRY/h2IfdfnzRMDkVGI/9EPcGjNIiM5yc9PHKIx4J0LHBTnzTfWCsRyh+cmwbe5zAqwL+8tn8h3gOVwsiSsWINd0rV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=MEYq5CQ/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="MEYq5CQ/"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso7937726a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1787648460; x=1788253260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wjyio8DgLKHGd4Hy3nKZBHOklYUNmSY9PP0wGlRlgZE=;
        b=MEYq5CQ/HVX7dajIOA7ZKckDZlrKERevk+9wwR4UYtAvDqj7Uq7+MevA73IlGCd3Aw
         vC90E0+cTEULRJWzYVEcp2vZG5Os3NfbYCU03nTdGL2vtDJCnlXij/7L7ZJ5ChZlBdE4
         rl3csxvKQuckPQ10zPj6lrihx8s8wqDJZAYS801J/h+9ZV9JqIL0HFjUCRYBhy0EvlqX
         Nm5KWD5pY2ZnCALi0DWt3cAIIzYAU5Bv7Vr1KWlY+FC1jaMcuHNJHbRCJ8vejyfD0BU7
         ryUK5WH8IzQ53II+N2s788CNriE+COBqgGuB2nyqNvWndK/8pJBgfkQkjTacDIqcyc73
         f7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648460; x=1788253260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wjyio8DgLKHGd4Hy3nKZBHOklYUNmSY9PP0wGlRlgZE=;
        b=GTIQJcJ5jZpi2TVE7lnTO+U7OEHgEDBzd2zTauVi4e1N6z/GFh1R0JCX0QNa1JJ9iI
         wesrOVyqDeRYxH7NDsmSr+OaB5kDY4upIU0QnTwQbj16Z1kgOL48t9JvtdApIRritBEg
         QzfDBB8eizSqM1KiNCqaiYSHcvPpE5m8EyAUeUYgOWXCTTWH0S3cic3O6+RJiSm2Qo9c
         +sORO77jSk845ypgUNpS05azFWkbCXN/0K026Hr9UmrzyKKS3r9p6lnvvVqQBls7Q49s
         nM4WMPzQGZDJ1Gfx3sM2ib1GyqfVeo2mKKM2Z/SDUxT4GADq7HXUnkiOntOHSkxJ2vcp
         kG1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rod4z8fZsNtpoTXbIKOmyWK2/u47x8wLTB339uoLBOdlCvo2t1OJRnhTAwIk8noITYQgNU3k44=@vger.kernel.org
X-Gm-Message-State: AFuF++netWkHHBHnXj9xTZ9Dl8DOmyoI/S3RmqE6IiFpj+CDwzieMX7H
	MsS6BO/Q/2ny1nzWFv+S/P0U2Ds/kEecVNbg1coqP6r2Dn8enjarMbdBa1wPSB8SEMM=
X-Gm-Gg: AR+sD113QSIoGwYA5kxOQBgYWDNGScr8eDNu8JlNWu6bLBQT9MolMZ8rbumM4M6y9LN
	k/Oe8nFZQwAE3pKaB+TB7wKPBaM9z80EzBgp6ZHkv+ZduzLDQLGC3eb+8QS848bRVXMzAeP/X2j
	fsvFx7tzUXxEzUmxrQpsxr1xGAzwd8TgvdSllFq9DFIhv9g4rD+qIdwYeGt91h2iFUb1EAWM5Wq
	PzTbTf0lGh5sX2S/aNRzNrta5vG5TB02ZbHjbZf8wycQSo07M8oMESukCMJG9F81ZhSvQqmhk6z
	qzmzKdSxUh86MclTWa3TL9nmpU73gphdXgdlOmFdq6gf+GhK20UK0/mRvI89NvlkXuUXt+brrti
	vUpKCLUfBuDUus5tTRwqgcPvJAYp1Z/R63utubRKJVsboD1xY0bJR01n/kLyP6xoK99wSeTcQxC
	2MD6w5+EHYzMyMGxUkxXvyB9kMMKHNJlU0EjJcAHnxw578sp7WA2MPdsbXjmQbsHCgbMH8Taf8b
	S/c
X-Received: by 2002:a17:907:1ca0:b0:c16:14d1:b529 with SMTP id a640c23a62f3a-c249262043bmr2784972566b.18.1787648458278;
        Tue, 25 Aug 2026 02:00:58 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f99basm1591648166b.37.2026.08.25.02.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:00:57 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:00:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Ali Rouhi <arouhi@sitime.com>, 
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"cjubran@nvidia.com" <cjubran@nvidia.com>, 
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Message-ID: <ao1Zh0uHO0mWj-2t@FV6GYCPJ69>
References: <20260815221919.64226-1-arouhi@sitime.com>
 <20260815221919.64226-4-arouhi@sitime.com>
 <6a529684-bd6a-4187-9ed9-bb40f4b98065@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a529684-bd6a-4187-9ed9-bb40f4b98065@linux.dev>

Wed, Aug 19, 2026 at 11:16:18PM +0200, vadim.fedorenko@linux.dev wrote:
>On 15/08/2026 23:19, Ali Rouhi wrote:
>> Add a DPLL subsystem driver for the SiTime SiT95316 and SiT95317
>> clock generators. These devices provide low-jitter clock outputs
>> commonly used in telecom, networking, and data center timing
>> applications.
>> 
>> The driver exposes all inputs and outputs through the Linux DPLL
>> subsystem, supporting:
>>   - Lock status monitoring via register polling or optional INTRB IRQ
>>   - Input priority management for automatic reference switchover
>>   - Per-output frequency readback from hardware state
>>   - Phase offset measurement via TDC (time-to-digital converter)
>>   - Phase adjustment for fine output alignment
>>   - Embedded sync (esync) pulse control on outputs
>>   - Fractional frequency offset of the selected reference
>>   - Optional reset-gpios for hardware reset
>> 
>> The driver reads all configuration from the device's on-chip NVM
>> at probe time -- no firmware loading is required.
>> 
>> Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
>> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
>> Assisted-by: Claude:claude-4-opus [chat]
>> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
>> ---
>>   MAINTAINERS                    |    7 +
>>   drivers/dpll/Kconfig           |    1 +
>>   drivers/dpll/Makefile          |    1 +
>>   drivers/dpll/sit9531x/Kconfig  |   17 +
>>   drivers/dpll/sit9531x/Makefile |    4 +
>>   drivers/dpll/sit9531x/core.c   | 3111 ++++++++++++++++++++++++++++++++
>>   drivers/dpll/sit9531x/core.h   |  372 ++++
>>   drivers/dpll/sit9531x/dpll.c   | 1232 +++++++++++++
>>   drivers/dpll/sit9531x/dpll.h   |   69 +
>>   drivers/dpll/sit9531x/prop.c   |  397 ++++
>>   drivers/dpll/sit9531x/prop.h   |   39 +
>>   drivers/dpll/sit9531x/regs.h   |  371 ++++
>>   12 files changed, 5621 insertions(+)
>
>as the new version is need, could you please think of how it can be
>split. reviewing if 5.6k lines of code in one go is quite tough

It's a new driver. Linear review in one hunk. I think it is better that
way as you see the whole thing right away.

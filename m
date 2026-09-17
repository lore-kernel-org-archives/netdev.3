Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1EA438038
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634593; cv=none; b=YqXwpjbDv3RBK5EDYyqBWkd1a/TR8JYVjjfJvXj1m5HqIun7EpR5UNcnBgdnXVY1uSOeOtn6K3vqbD9IOZ/xL44qzOh9NTXei7Si22iRb/JHj1ATko8jqhC/AJnA7J+4EF0fRItA59XzAXBMZyUNunKAX/FsQ7iHhzJsilUsobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634593; c=relaxed/simple;
	bh=xZ3JSj8oevdfblevZOGxIZ7GwtEyzSx++6y/65fyjlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL1dG+Pmhb8IA9PfvvDfmJew7PJlHMe3IKgkgAJYSjjhIiGKDfIllNSiFIlxmU416bjgOtovjCM6SLljSYWvtJOqmBlqWb8qIeZ72OoxwvCiHUOzLsSh7+H6HshAzRvZD2xZT/N5cFc7J+VbohVYUa4olEnzUX/apeH74LP95IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2wRNW45; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2wRNW45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789634578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnj5bGFt5q5vW3x1crtWWx2Ui97eiSoKFvsTpuZ4ym8=;
	b=N2wRNW45491cN03EKdoJz3QTf4HtD6w/dQws7i1I010RdSbmWZVlzYfqGtuvzDXgr7OzqJ
	OZmkVjwS+sVuKQbo1+wuQAMIC9fSG/GIWbsdqE/DY6usSH0R1cQbyH3V4QHyHgsE5ByPPK
	BGxfhrUtxXcwrJfJFKV/K65OAslY96o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-Nye_faDPOGKCA8dwMkPHsw-1; Thu,
 17 Sep 2026 04:42:55 -0400
X-MC-Unique: Nye_faDPOGKCA8dwMkPHsw-1
X-Mimecast-MFC-AGG-ID: Nye_faDPOGKCA8dwMkPHsw_1789634573
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7131519540C9;
	Thu, 17 Sep 2026 08:42:52 +0000 (UTC)
Received: from [100.90.87.156] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25A921977588;
	Thu, 17 Sep 2026 08:42:48 +0000 (UTC)
Message-ID: <371bb5ad-ecdd-48ce-9288-8f9209b8ffdf@redhat.com>
Date: Thu, 17 Sep 2026 10:42:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 03/15] dpll: add basic SiTime SiT9531x support
To: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>
Cc: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "cjubran@nvidia.com" <cjubran@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260915000015.80480-1-arouhi@sitime.com>
 <20260915000015.80480-4-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260915000015.80480-4-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 9/15/26 2:00 AM, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> The SiT9531x is an I2C clock generator with four independent PLLs, up to
> eight input clocks and up to twelve outputs.  Later patches register the
> PLLs with the DPLL subsystem and expose the clocks as pins; this one adds
> only what is needed to reach the device.
> 
> The register space is paged: 32 pages of 256 registers, selected by
> writing the page number to offset 0xFF, which is present in every page.
> A regmap range configuration describes that window, so the rest of the
> driver addresses a register as a page and an offset and never touches the
> selector itself.  Pages come in pairs for the PLLs (0x0A/0x1A for PLLA,
> and so on).
> 
> Probe reads the rate of the crystal feeding XIN, since every frequency
> the driver later computes derives from it; takes the optional reset line
> and leaves it deasserted, because the device configuration comes from
> efuse or from a blob applied before probe and a reset would discard it;
> then identifies the variant from the single byte at page 0 offset 0x02
> and refuses to bind on anything unknown.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: Claude:claude-4-opus [chat]
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   MAINTAINERS                    |   1 +
>   drivers/dpll/Kconfig           |   2 +
>   drivers/dpll/Makefile          |   1 +
>   drivers/dpll/sit9531x/Kconfig  |  17 +++
>   drivers/dpll/sit9531x/Makefile |   4 +
>   drivers/dpll/sit9531x/core.c   | 272 +++++++++++++++++++++++++++++++++
>   drivers/dpll/sit9531x/core.h   |  91 +++++++++++
>   drivers/dpll/sit9531x/regs.h   |  56 +++++++
>   8 files changed, 444 insertions(+)
>   create mode 100644 drivers/dpll/sit9531x/Kconfig
>   create mode 100644 drivers/dpll/sit9531x/Makefile
>   create mode 100644 drivers/dpll/sit9531x/core.c
>   create mode 100644 drivers/dpll/sit9531x/core.h
>   create mode 100644 drivers/dpll/sit9531x/regs.h
> 
> ...
> +
> +#define SIT9531X_RANGE_OFFSET  SIT9531X_PAGE_SIZE
> +
> +static const struct regmap_range_cfg sit9531x_regmap_range = {
> +       .range_min      = SIT9531X_RANGE_OFFSET,
> +       .range_max      = SIT9531X_RANGE_OFFSET +
> +                         (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,
> +       .selector_reg   = SIT9531X_PAGE_SEL,
> +       .selector_mask  = GENMASK(7, 0),
> +       .selector_shift = 0,
> +       .window_start   = 0,
> +       .window_len     = SIT9531X_PAGE_SIZE,
> +};
> +
> +const struct regmap_config sit9531x_regmap_config = {
> +       .reg_bits       = 8,
> +       .val_bits       = 8,
> +       .max_register   = SIT9531X_RANGE_OFFSET +
> +                         (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,
> +       .ranges         = &sit9531x_regmap_range,
> +       .num_ranges     = 1,
> +       .cache_type     = REGCACHE_NONE,
> +};

Couldn't it be useful to cache at least page selector register or is it
volatile? I remember from zl3073x history that page selector caching
helped a lot to reduce number of i2c transactions.


Thanks,
Ivan


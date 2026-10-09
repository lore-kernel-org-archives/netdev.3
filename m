Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5EC4F648C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570975; cv=none; b=UvXIIXakC4WxiWGhfyFwTMUBrA05Eisf3oi+dF9E+HWbG9sXqsdpioNODkgYrb8z07j96L0ZC0f1Qji7Ne/ww75PweBCDYpYy3uS3nfQQWMD2g1RGiS4qInv3YwQXAxO2iU9SZtRfFnVncyV7RcA5hwtU7RG7rSEjGHqXMs0brc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570975; c=relaxed/simple;
	bh=I1z4aPNe1j0jS1fSnM13X27jRNV74YpakQKyGVVJaEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R53uEzAaNfWtgPDiYeGZGclr/08DdxAho4Zpt5XZm89VXxuYfEMnNTwsJ5MmRAAoJilagCYylO34mLE362UMDKQQOLj+7sWaI/gKyEOUjnM/DcqRed6b9yUmQ09n6KmZif8NySI8AunMj9jFiWimCI6a9bCvdzVek1L/J0/nm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uwv6hlyp; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uwv6hlyp"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93e706a6ba9so541405285a.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570962; x=1792175762;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zgxSyNtrJXDQubY2aMyQqoQIxuV+Slem4S799JPhD9I=;
        b=X4c2VlpCL1G9xh55GRR1lfErLmdwKveqBd6Eeg4VZHjjgDNS6C02+qwldrUdIlHlCX
         0xBhvM3W1Ygw+0LZ8r0PyL/DRCtaMlc3ewwlK6cKj8kJ2uXfVcppqQfwqYm0++VOXbI7
         dVxNujZqbkqISc37sLCugWq8H5gFweYAGtLj4rmriASbg1em4VjfnxUzbG2XHWaQFbRA
         mEkhAK6pVVOmJlB/5Q8w5nqUqQpM1xmOTMjWF69qBI1V0fZhtrU7rk7vRoBt6ctxjf/C
         7wKkWes2qQl2xAihhVz3bQGrSnfIEMhcSFgjxWkfZ9iFfC7Q8vPj0K0SyVGquXAczjbR
         wdjw==
X-Forwarded-Encrypted: i=1; AKwUvBxCWCW7InvBJY1P4+jdbEcBqFNSfxzhVIPz+WmlSfELLgvCdrw+KOTY78rQjuEyPtrHVSSUvXI=@vger.kernel.org
X-Gm-Message-State: AFuF++kz73LtqVY59E60EoWJiyIfl8zlZOo15kuA0Wi2b/QIyYir96U5
	+NK+549uwG5USoMafshRIjhWDCGmtaRK08EEVO2QUC3DfbBPTOdtmM2kKPnuuuN+awv1Gqo8+9w
	0nafn0acKbOElzHiitPTa5DmJSiiVi8w6o26x1C7+w6L85L4SAgH7QFGjSdoKJU4vmTDEyFx1Ze
	anJvNg7weq5mSDXgCGqe8nuKLqDhsz0rHRFe9XW/HcwBMqkPCMLHKI3j9vrWGUdXLXWaiw8Mzda
	5ilDAv+rA==
X-Gm-Gg: AYBFou1b3JgAglFwwZ2TPsmOMQinkNzNWXRsVM6qWRQzhUl1s6xp1DeHnW09rdPgE00
	1eawCSy0C9wemN2rvXBX1LjFlPCJVgpjwisZNXiCTVurHPJ3c6HHbt9qcRnw0cz+BpIbnHzEUoE
	RV/hQWtzbEoeIy4MwbxssTwHfFUJlSzK6Tgm6RpdVQESEiLhTUnVXyxIJQS80XLWHiKOBfpBAwl
	Z+yEr4tTBP3pxC33UYHHwyGC9ZuXhWROPZnNwmqnqLYk8iRoztt//p03LjiLXAGbyuAMiCE5qpW
	iSYIZsVQ9vm7BH4ysLVvagZbsc8piRX9/fHbojvg7RBDXlQ5DEGBd2RWiozXBkrmtKYjLh246/g
	IGH/56G1IVL0zwzO5bhNBR1FAL7cHW+mEQ4HB8T+hR7GaGC6Ct24RV1wQGAZZqj30tm4zVq6MOy
	Lg3zQ6ouekyijh86eyC9qZ5W6mv5/ETiLMvIKU
X-Received: by 2002:a05:620a:17a0:b0:93e:c12c:fbba with SMTP id af79cd13be357-93ec12d08bfmr316490485a.71.1791570962108;
        Fri, 09 Oct 2026 11:36:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb97132c5sm52189185a.2.2026.10.09.11.36.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:36:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab7f1efe5dso38837a91.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791570960; x=1792175760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgxSyNtrJXDQubY2aMyQqoQIxuV+Slem4S799JPhD9I=;
        b=Uwv6hlype2h447m9gJUtfgDQ+tFsS16rL2T4nApljToRddvluwF+G3z/bO8u8ygI1K
         ZJF4EdHj2PlykmZMIEPW6P/dLpBnCtHWfCY+E48pcXXJi+pq91dD0SEtItnRnLxVF27/
         nfJas9etmlxg+GEIOqXbjMpWWkDqa1WN1TIDE=
X-Forwarded-Encrypted: i=1; AKwUvBx2xr65a9tCNr20zOxaKGJMV9YY3AhTO1sfYq8MWXhpeYlpIh5ko1pa/BGA/F5V0h4BMMOvFN0=@vger.kernel.org
X-Received: by 2002:a17:90b:48c5:b0:3a4:b418:94cf with SMTP id 98e67ed59e1d1-3ab3a7366bfmr2791686a91.14.1791570960409;
        Fri, 09 Oct 2026 11:36:00 -0700 (PDT)
X-Received: by 2002:a17:90b:48c5:b0:3a4:b418:94cf with SMTP id 98e67ed59e1d1-3ab3a7366bfmr2791661a91.14.1791570959864;
        Fri, 09 Oct 2026 11:35:59 -0700 (PDT)
Received: from [10.14.5.199] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab396620e2sm2960086a91.3.2026.10.09.11.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:35:59 -0700 (PDT)
Message-ID: <2b7d0487-dfb7-47ca-b740-178bd3391d2d@broadcom.com>
Date: Fri, 9 Oct 2026 11:35:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/6] net: bcmasp: fix mib counters struct alignment
 with ethtool stats
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
 <20261008210621.1374785-2-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261008210621.1374785-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/8/26 2:06 PM, Florian Fainelli wrote:
> When EDPKT stats were removed in commit e9f31435ee7d ("net: bcmasp: Add
> support for asp-v3.0"), the corresponding entries were removed from
> bcmasp_gstrings_stats in bcmasp_ethtool.c, but the edpkt_* fields were
> left at the beginning of struct bcmasp_mib_counters in bcmasp.h.
> 
> Because bcmasp_update_mib_counters() and bcmasp_get_ethtool_stats() index
> into struct bcmasp_mib_counters sequentially based on the order of
> bcmasp_gstrings_stats, this 16-byte offset caused ethtool to read from
> shifted offsets: the first four software counters read unused fields and
> reported 0, the next four software counters reported the values of
> alloc_rx_skb_failed, tx_dma_failed, mc_filters_full_cnt, and
> uc_filters_full_cnt, while filters_combine_cnt, promisc_filters_cnt,
> tx_realloc_offload_failed, and tx_timeout_cnt were never reported.
> 
> Remove the obsolete edpkt_* fields from struct bcmasp_mib_counters so
> that it aligns with bcmasp_gstrings_stats.
> 
> Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6598246781
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885432; cv=none; b=N0+En4i765Dbw4DJg4cgVz7TrjTkdrBWPRPbYoS8BBi/6pAUlY+nOAV64Ho0myXQUL+BdnKdZOd54d/6zIJnygqTfP3aXad3gl91RRP2T4pQW+du9NaE71KEEM3m4q8mbha2ZWu6pZd5Iu7z2EHcLhbSqmk8vNWhzhlj8N/iWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885432; c=relaxed/simple;
	bh=IUBu7wYhG92bCszbpUIow36ogJPjX28c1u6Ji400pEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYe4tXxF/rOLyBRhb1HECFRcwcqSPaG1hP/o5FWJwI0tQt7vp9TgTwO1m9yyKqTCC4UM1GDBCrktVLma8iqfD0g28XWzP0ijr4++1Gy4BK1njeST41t5sJ2ctv2BAKimapcrSFbf0+eTlBQFffmbc/D4ShqaCCJrIk7Buqofm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZHkfNEF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=easdXY9V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZHkfNEF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="easdXY9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791885430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqSjm367VUjfmKlJjO867N9e+hOQdSiN0ZNGwVg2kIo=;
	b=aZHkfNEFP8BHS+De1dIOUjX092BRrLNFX7FBS+dSuQd6e/bGKAOocChLAmuRx/Xqc/wPtV
	FDLywvAw1esjhWDkEhUpICIQfbFORBxwbEiv7nw1waKQ0MP+F4Kd/KqKQl2ZaSBDm/z9r9
	kGrlUO0AnBu4h2WA47jE+PtI315yh+I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-pWAPyyHCPvyHTjp6EFQdxA-1; Tue, 13 Oct 2026 09:57:09 +0000
X-MC-Unique: pWAPyyHCPvyHTjp6EFQdxA-1
X-Mimecast-MFC-AGG-ID: pWAPyyHCPvyHTjp6EFQdxA_1791885428
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b0679906dso1645103f8f.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791885428; x=1792490228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqSjm367VUjfmKlJjO867N9e+hOQdSiN0ZNGwVg2kIo=;
        b=easdXY9Vt3q0NptP/4L0L4rl5tyjZreuaSGbUE5FuquEuQtMgQVm32pu0DDyvZXrNI
         FPPJ5QHTpdTkolNhf+fPexd9LTY2pHpwPoOt+mW20HnwdcvB7YTcjT5JIOb2jVPsr6PV
         baVzM6fe/gE+wkt4SZILnkKhouxAZXdcDFxbWKQ7pPRxQM1PPhlcvcZuEo50k9MyiSqo
         iffImXuydVmK5ojRakkQrCNFgbjRWwEE3JSXg/2IGkPmVJ0v74ZaiQvIQY0dGEIKC+aQ
         qaSs8v2Cj1p8Mw7IFYhoOBGyAbGLQ7zm/RXTWOIyeCYbhvNiOP7NLi2A5vZGlgL8HGa0
         KCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885428; x=1792490228;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqSjm367VUjfmKlJjO867N9e+hOQdSiN0ZNGwVg2kIo=;
        b=13rIlT0CrnucMUFyAzCJrbZQSv1yNSX3vsz1uZOqsJdaefLCv1h0RFNI6RC404S+F4
         JiQb2uZf1MK8y492Kd+7N9rxA+tPl8fnz9ugecp03qKLZUf8Oqbg6/oez8Kx+5+Ez26y
         Vyf9si6jSVgEJODH5705IAa9EFzatkIcpjY57NICFxnqObNLIp4JMATgowlI3GLRsM6Z
         xwptJaI8r8GxPuiKQ2zW7szvjKJAyisxCfXtYca4mtQmxoleVlxdgkN+Ba3P0CKzBRKc
         n3mw1+gyMB3gS3VXgEs2n6lzs1btv5MjCqWUCquvQLaIYX0aFN6KiIz4Ejui8OJN/RdA
         Lepg==
X-Gm-Message-State: AFq9FYJdeweetTiaWoh9d9gkqKeVizNKqoDZIHy8LD9PrQEHRn05VbK6
	6duN+h1czeorjJDCgXJdWULw5o0PP9KU5uwhhH6cw9/Jg0cSa0ujyM6VQlyxXroVx/ePAsJtYQa
	rzXFM28CxE14AdYkyLUbgFL6aQHyp+Y5d1ej2XfGr+r17XBRMyZmRyL+nQQ==
X-Gm-Gg: AYBFou3e3ERkZHjkveozJ+VRypzYGPPJOSb2ShOp0L+Ln+9seBUMv/snQKGrlLSoXIJ
	qrruAqVrMvKjcMSMkwb6PT7osMiU32e7XB4JAjzDmos3t9GhvKrHD/6IeZz1cJM7zdAqEEBjvaw
	+J6q5vrvH4XGHQPNlPgEGnFEk3j56c80fNpN4is+mZhKbA4oQFoIYtzSOjbItQq9kfXYCEerWQU
	tQlZXaz8Wu4KP1zdu7drLSW4xs8dhnHM7GaZS2CEQGkOLEuizs66hUQ/1eBTudArOS8QMxJjoKX
	AnDrlXvth6+XRsD67KtlehD3nkY21Cb9P1/8lJtPfMhVfaptR887NmfOWf6mv9gR3mxg5x4YoGW
	UZpULomePHdzsQAI4UUWxGJW7NDCAXGtaU9f5T17KYfpODgAQTO2LMcNUUwl3iQC1T+BH7PVh7w
	==
X-Received: by 2002:a05:6000:46d3:b0:487:40d:af3a with SMTP id ffacd0b85a97d-48dba781a73mr13828297f8f.2.1791885428180;
        Tue, 13 Oct 2026 02:57:08 -0700 (PDT)
X-Received: by 2002:a05:6000:46d3:b0:487:40d:af3a with SMTP id ffacd0b85a97d-48dba781a73mr13828256f8f.2.1791885427776;
        Tue, 13 Oct 2026 02:57:07 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc50e0sm5431099f8f.49.2026.10.13.02.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:57:07 -0700 (PDT)
Message-ID: <23649f43-f015-4754-be50-94e2bfe40c4d@redhat.com>
Date: Tue, 13 Oct 2026 11:57:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnge: skip dev_addr when building the VNIC unicast
 list
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
References: <20261006141928.1432927-1-vikas.gupta@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261006141928.1432927-1-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 16:19, Vikas Gupta wrote:
> The default VNIC programs the device's MAC as L2 filter 0 in
> bnge_init_chip() via bnge_hwrm_set_vnic_filter(bn, 0, 0, dev_addr).
> bnge_cfg_rx_mode() then walks dev->uc and programs each unicast
> address as a further L2 filter, without excluding dev_addr.
> 
> Skip dev_addr when building uc_list, since it is already installed as
> filter 0. As dev_addr now takes neither a uc_list slot nor an
> l2_filters[] slot, count only the non-dev_addr entries for the
> uc_list overflow check too, otherwise an input such as
> {dev_addr, A, B, C} would needlessly fall back to promiscuous mode
> even though A, B and C fit in exact-match filters.
> bnge_uc_list_updated() applies the same skip and count so the
> change detection stays consistent and does not loop.
> 
> This issue was caught by Sashiko (nipa).
> 
> Tested on Thor Ultra device.
> 
> Fixes: 9afad4a17174 ("bng_en: Configure default VNIC")
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
FTR, redirecting this to net-next, due to Linus guidance for smaller
RCs and the above giving AFAICS some perf improvement in corner-cases
over the original code dating back to its introduction.

/P


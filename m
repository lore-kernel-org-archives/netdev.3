Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE80481232
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997237; cv=none; b=A0xwdy7duj5jhzDdgNSyiNpFRyTJJF0tu7XZr9MyGRX7YHZIL9DP8C66nXzKi8F2a0se7e+UAsjcQJRrk9FcTBvCXbUzx1n/G/IEY5XtpozcmKBMA5PzCxVassgVfKoAT0oxJS46O/WzSgWxlqwEA4OaX/H7Vc++7H2bOhenESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997237; c=relaxed/simple;
	bh=3n5TIWlAtiuC0/jkCjsxHjVyWzyduJ+SmWLkvFU5I5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZEeK25jf39HFduNEwSIyYkZZyp4N5T/ZDI+wR5xbGXpX4vZuhh7BY5WUvSDFzGnQHzMyOlG8QcobLwNFbLA9Y3XafDAWFuOdk3d54qfN+od+nVsUSusjiJggXVnYicoZKwND/kDG7UKtH+SEKP0w0jajVNwp23Jbq4JQHZhv+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuhuZW/4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+AJZ5J4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuhuZW/4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+AJZ5J4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782997234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6pSlXcpR9eIUdKQEibbtvg2uPNiqfvKU/fEuqJeoAY=;
	b=EuhuZW/4AO0i8PGpvx0fGRg2SFAWkJgmz0PpQ8VrEwvpqdvk0wUB/J2XWGdHSahZAEBvo+
	0L3zww5coKLliVOAn+oocNWYFzGvxJkYfTPSjq6HhfXeczYS4vbn5lm9QpwZ+x7z8TeUhw
	6yNazMHSIgFYWVcMIzHVvBkoF71465U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-693SJDbMOcm_AaDAYEmHfA-1; Thu, 02 Jul 2026 09:00:33 -0400
X-MC-Unique: 693SJDbMOcm_AaDAYEmHfA-1
X-Mimecast-MFC-AGG-ID: 693SJDbMOcm_AaDAYEmHfA_1782997232
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1273e18eebso188973766b.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782997232; x=1783602032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6pSlXcpR9eIUdKQEibbtvg2uPNiqfvKU/fEuqJeoAY=;
        b=W+AJZ5J4TrxRncgcvAO4HT1+RjdpSagS+wuoo+M62DbfnUo1SAlqoqkcCOyXhjRXFd
         jIsDdsZDCt6xSakIQP0T9oI7M4Cv9EAsCaLpWfrm0BqVXhNxaNzmMmdQOGx0XbZiJiUM
         plUA1259xM3Db+EHTSisffDPEjbhKtn0VJhm5KslIeruLRGmh2gkRCd8mxAAbr7nSaVn
         9gfFxO6bRIJeM5I3qguQ3Tgs4lFtW8u6jK72q76mprI0H+Fh4jvSzA79BEdR3q17xFOE
         jaqXzsUIEblXJRR9hZ8H083xFKNM8ScVwcggSBO7XzmquiaZnneFE2YpODGvzIGYaF1r
         /ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782997232; x=1783602032;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6pSlXcpR9eIUdKQEibbtvg2uPNiqfvKU/fEuqJeoAY=;
        b=Cwh8bHmxPJSUl6WuxtGgWrS/Wg+SppbOhjloWfGJ6TbwZDxHF02Eo/SaNH061P4xEB
         315qI3IYRY0hUFce//Fyr8n0xILS+286QwoHKOdyqqHZS3nDChld7Du1IOI9k5BopG/U
         1mLGbXnAxxzH1OvW08QN5vgry4Dok7PsYtSfrSlGQXmMaxB/9N01idiy8Aqx93ckDgMt
         puhAuaM42oQmHC13wl4Y4E7+YGRZW/IaSofEyTPILVRCHxVOB0Gu/0obgZydA2u4mhpj
         0rlMog6F37WEAnq2q4vWLY04ZiYV0ekbPGBZlWlqLIop47YbVKwM6d5B4H+iWTXALJ+q
         /lRA==
X-Gm-Message-State: AOJu0Yz89ySymAr9XqUqvdHdz+d5CpcqHyn+QymElMYQCF5K9x1D1/+J
	BBfIDHeCAJqZPX8rYVLjv+fa+lXA632XGX8/6tthMRPzsFLbpOKEBIoHzJsq2CpOLytKugacfd/
	fGSAtUx+W8uiLuoIq6NT9QjSe55h/AvtxR3ofaVAYL5taMy9f4ov0OvSzwg==
X-Gm-Gg: AfdE7cl1ltMjm9J2cRqvl1ZG/TZI5Jq/1uAE3HagiKlJ4kWEXAraLY5duZCWoWI0Mmk
	xKvrwBc6rsbQyOaroIcwPmpsDMJdmmvxKWfooKvTcdqCIk4K4UAGAkezK8aieUqynXVG+vQpbQt
	fbGRIxTlEFtvqsHiwsczF/7YhZN4v3X6drsC6+Ep8MNkm149uscY4dB6cf/ApGK91ava/cIII9c
	IdzSmZrXNyQOuk1nIkE+NNeXt1h+Nz6xLFTUEg6z059yU0WP2oT6IWR31hfCTA+FFKIYAZmRFxI
	cC7O5GjjVEKu0HhulG9bqAMTmn0QZSfwzxxxoI/BTCzagMTPuncEbHcm5F/hhz/FZMdT7yburHr
	YhLtxnZpnshtGSTGeFE32DB7fyAsp3eO3kI6KiU+CkxC7QR4GeHKM8UizraVGg5gBTLBzUvGH/T
	rxRaYJ9twD+w==
X-Received: by 2002:a17:907:a786:b0:c12:34ed:da0c with SMTP id a640c23a62f3a-c12aa3694damr287969566b.56.1782997231583;
        Thu, 02 Jul 2026 06:00:31 -0700 (PDT)
X-Received: by 2002:a17:907:a786:b0:c12:34ed:da0c with SMTP id a640c23a62f3a-c12aa3694damr287967466b.56.1782997230911;
        Thu, 02 Jul 2026 06:00:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6055039sm125146066b.4.2026.07.02.06.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 06:00:30 -0700 (PDT)
Message-ID: <4d7f991b-60c8-4b4f-920c-46bc7f82d049@redhat.com>
Date: Thu, 2 Jul 2026 15:00:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] net: mvneta_bm: add suspend/resume support to prevent
 crash after resume
To: Yun Zhou <yun.zhou@windriver.com>, marcin.s.wojtas@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260630060311.4072140-1-yun.zhou@windriver.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630060311.4072140-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 8:03 AM, Yun Zhou wrote:
> The mvneta driver uses the hardware Buffer Manager (BM) for RX buffer
> allocation. During suspend, mvneta disables its clock, causing BM to
> lose all buffer address state. On resume, mvneta_bm_port_init() re-
> attaches the BM pool to the NIC, but BM hardware returns stale/garbage
> buffer addresses. When NAPI poll processes these buffers, DMA cache
> sync hits an invalid virtual address causing a kernel panic:
> 
>  Unable to handle kernel paging request at virtual address b0000080
>  PC is at v7_dma_inv_range
>  Call trace:
>   v7_dma_inv_range from arch_sync_dma_for_cpu+0x94/0x158
>   arch_sync_dma_for_cpu from __dma_sync_single_for_cpu+0xc4/0x15c
>   __dma_sync_single_for_cpu from mvneta_rx_swbm+0x6c8/0xf48
>   mvneta_rx_swbm from mvneta_poll+0x6fc/0x70c
>   mvneta_poll from __napi_poll.constprop.0+0x2c/0x1e0
>   __napi_poll.constprop.0 from net_rx_action+0x160/0x2c4
>   net_rx_action from handle_softirqs+0xd8/0x2b8
>   handle_softirqs from run_ksoftirqd+0x30/0x94
>   run_ksoftirqd from smpboot_thread_fn+0x100/0x204
>   smpboot_thread_fn from kthread+0xf4/0x110
>   kthread from ret_from_fork+0x14/0x28
> 
> Fix by adding suspend/resume callbacks to the BM driver:
> 
> - suspend: drain all buffers (with DMA unmapping), free the BPPE
>   regions, and reset pool state to FREE before stopping BM and gating
>   the clock.
> 
> - resume: enable the clock, reinitialize BM defaults, and restore pool
>   read/write pointers and size registers. Pool allocation and buffer
>   refill are handled by mvneta_resume() through the normal
>   mvneta_bm_port_init() path, which sees pools as FREE and performs
>   full initialization identical to probe.
> 
> Add a device_link (DL_FLAG_AUTOREMOVE_CONSUMER) in mvneta_probe to
> guarantee BM resumes before mvneta and suspends after mvneta. If the
> link cannot be created, fall back to SW buffer management to avoid a
> potential crash on resume due to unordered PM transitions.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Sashiko gemini has found a bunch of pre-existing issues; it would be
nice if you could follow-up on them:

https://sashiko.dev/#/patchset/20260630060311.4072140-1-yun.zhou%40windriver.com

/P


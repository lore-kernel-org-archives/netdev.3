Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014941D647
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423878; cv=none; b=UafJKKrXCpQbGsARPL5qU29Pffkrw5tGImWYVnHPbJi3AqVemynvrRfpIb4eLFvGiJKXtz+3Cm5gcrYyzMJHmTliXXWNEASsPIxXDFb+V0v0g5Sz6Z/uERaGu6all7KxAla36Vg2Il06bc9B4E22jZ/YeRlEwitLmI9Y+j+RdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423878; c=relaxed/simple;
	bh=jUqRKiy1Als/fPzU2pw1tgkS2Mh780PlQdOLEThN/FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKYya5PpcXlVWjoGXL6Rgm0YsEDW3qgEsR3rjM2BGHW6TdWb86zKAYXNgm29ScBYs/uxxuKuZbLh53zaGVsG+jhxQ9yvLSfhNueIDTIb98oEHhhpCM9ObPEIshgebjL941Gd2mvqHFfvR9fNkIbeQZ5dMFasAbC0eLFwOYwOszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTVGaBHg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTVGaBHg"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so206875a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788423875; x=1789028675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MgOyUEIfGCWyeavJ4iucCikM9YF8g1HwJk3n6ykR+jw=;
        b=NTVGaBHgNQn7vMQGRLjUt/SMTYhvWyZFM4Z6hyK1oTS1fZTR6tcXpXBCuhbUZpDfPA
         vtj/DRX9gir9Itx7Tdfoxmm4SLYuzVgEGYK8WdhpIMKzBX7qkPxilxoRZNM3ro8hEoj0
         OlNe4D9R0jdgCxrauRvFnklLZsfa4VDgm0b34ByvsLqupe0IP3qU3Vf0MhXX175VwFQn
         E+pLOv7lp0G1kYrwF8IE57n2WsHU9LeQ3XjkLB2QoP2hqToozQlXQlKvG3oGJLPphrpb
         nY5ztHIw7h5N3MUMKb/NQs4KxMxby4e7g2GJATMRyIKDTnnNjZTAonFGFc7c/H9uj+wi
         ao3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423875; x=1789028675;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MgOyUEIfGCWyeavJ4iucCikM9YF8g1HwJk3n6ykR+jw=;
        b=m/hWUMElN7o2R+tNl1ZVN5tCnHQRzlGa1sxGMkUODeFjo46gXJu4Tn0cGIdY8UApus
         Zi7PnMIRhVmo2zqvUFIJnUi6v03MvoY6631n1C7VnZl5t6cJRF/SbeAs//yNYJr6xy1B
         U9ZTwrSWakKrg62SqLjSvqiCwssvkvNgu9y5rTTcFN172/JjPokPBleU9VYvUCF1GY4f
         4eLu5/EjYGNO7u2v14ur9qvW6DLYAQyrXYUFyeOsVwoITmojMFG9Z8EqNv7+Vk6fMgSR
         4M5nIeBGCo5PbVReNIa9DcQUX9hSFcTW3C915y37SB2k7wW6gAtD2huH5aHUpHxFo56i
         SxXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFCZsmC7owyHFDy1bxX2yKEFMlmrjPAdByfpryS+b/enAsm+OFVAJ6gNSrCgDO2UeC4VLJw+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lmKxb5hnlmbpKjh+36TPmsAiaZmdIJ1tV+Zl0zm+Ja+B7uKo0i
	hwK+S0CiJGKt25OIKAFi7oBWmj/a02fnoBrNpCZeABa0G3HBuI4AvFYc
X-Gm-Gg: AYBFou1+1+XoSjdYyoudM+542b42zee8IcqLRWmkS6apEw/T9v0FZkX1YviJZCCc9Tz
	umT7mEuRy2S1GAMMTS2Yfbnr2ffuxaACUuYn0udSWOPerFfhs/CQd2NSp4FSmZu2rtlAxKSQUsk
	647Flc5SreCUohBKB1JKC85TmYOOlRGGqZBxIW8+Y3wWiyZ9Y+4jJ54Of9rhMBw7ditJ1R1utNA
	sLA5bmWcWUMNNDS1tDmaCFLScYXO+MLAjXdItLBAuzD5nNmows/wFH/Zuf5Zmr4WZp4SRVKdpLq
	3HeEdSBBOpjIoiU1iD6IqVBykdkIW9tEU7ouxCSOOkUkVM0WVOD8RlLWSf90wPKxBu1RrgmzP+l
	PypVX1qSwWAS4Y9j9GRKsrDEYOJFtuM4L5RLRvU/jTxsYUmzTrXWKGUvYmgybJkr+DCO8uGETgW
	GBXxtlU9Dxos/FHUKxYrg53KEiZmsRLXaRGrSBkL4xUnmH8H9ooARoljNe7WjTNRhwhDObQSop1
	Vq+t9vA147uYw==
X-Received: by 2002:a17:906:c104:b0:c25:2cbe:edeb with SMTP id a640c23a62f3a-c25d5532148mr662129666b.21.1788423875110;
        Thu, 03 Sep 2026 01:24:35 -0700 (PDT)
Received: from [192.168.1.124] (78-2-9-45.adsl.net.t-com.hr. [78.2.9.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f42861c1sm63169966b.63.2026.09.03.01.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:24:34 -0700 (PDT)
Message-ID: <f81210b9-abb1-4e95-8995-f8ca1435583b@gmail.com>
Date: Thu, 3 Sep 2026 10:24:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] net: wwan: qcom_bam_dmux: account network packets
To: netdev-bot+sashiko@kernel.org
Cc: stephan@gerhold.net, stephan.gerhold@linaro.org,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260831181006.1382372-1-sinyavin@gmail.com>
 <178838348238.3394541.9061693826070810058@kernel.org>
Content-Language: en-US
From: Dmitry Sinyavin <sinyavin@gmail.com>
In-Reply-To: <178838348238.3394541.9061693826070810058@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the review. The TX completion concern is valid, and also 
affects v3, I'll address it in v4. The netdev lifetime issue is 
pre-existing and should be addressed separately together with proper DMA 
teardown.

02.09.2026 23:11, netdev-bot+sashiko@kernel.org пишет:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0 (1)
> 
> - [High] Use-after-free write of the netdevice's core-allocated per-CPU
>    statistics from the asynchronous BAM TX completion callback.
> 
> Pre-existing issues:
> - [Medium] The driver allocates netdevs with alloc_netdev() in
>    bam_dmux_register_netdev_work() but bam_dmux_remove() only calls…
> - [Low] Drop paths remain uncounted after the patch: the `drop:` label in
>    bam_dmux_netdev_start_xmit() (drivers/net/wwan/qcom_bam_dmux.c,…

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EC5453A49
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787232538; cv=none; b=n3iUnnxIXvT1TdT7yMHdgPVPD1YiSbibnL1iMc+/xEw8RYgUga7gGD4ykUaBCup5BCvLtMZXVLMMDWO3tNHEYuBQTdhgvNpzBgJJ8cCds5/wzxZ/FFSSkGLSA/le9AXzXAXN2JACsBNxZyMW1QaOyPXzqI8CYb0b3nLAhoB1Kbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787232538; c=relaxed/simple;
	bh=bgd/aBKkexWU/D1QHpCDp5dKjnRhTgnL90kp3gswrPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYkpzk38Krk4rasMppr8U2HYkwaoVX0vzfUwfcrMtMcQnFVa8ZRq0HL9rt+UR7bwb6Y2w+iR6C+6idO+oMlEw7yDAuWqlFl1L6wrGHX6Gv35uyR81uTV8UG2wsUay0joC/DAH/Mqdd36djT5oTh1HZvSDEi282P5e6BFMRDE1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRDoP4TD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLJJcbQx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRDoP4TD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLJJcbQx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787232535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81FXEFEAWoGzBEUkp5WTBnX+AFEQNiURHAaHyp35qfU=;
	b=VRDoP4TDBGoPL5is6NQ+ObAO0hFz8TbZIH2V01l31Ox8pAOYEViaqqZTxQ40vC2C6TD8J7
	Ego97sah4Xwjr/tR/VFG2gnc1o042TW9SXtQLiUeQPg76xq3qVE5gP2tHrFwsbtVfZkWLf
	8R6DmRy0T0+bt5fc0eiiciFrniekQOM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-bgXvM5rwM1i3UbHiBc7-GA-1; Thu, 20 Aug 2026 09:28:54 -0400
X-MC-Unique: bgXvM5rwM1i3UbHiBc7-GA-1
X-Mimecast-MFC-AGG-ID: bgXvM5rwM1i3UbHiBc7-GA_1787232533
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso20766335e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787232533; x=1787837333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=81FXEFEAWoGzBEUkp5WTBnX+AFEQNiURHAaHyp35qfU=;
        b=WLJJcbQxzG5uIEpP7OT+KhvWY9f1eTP5cLasZskybto/qEL0SHq5lwlayRJag83Vht
         CGMFQUfJiEYoKleGaNWSSHSRiUKxc0ash2QoALBNLsZk7nwFxDL+uSpGAzzlyyBu08ZB
         6wWMIC4uS9lwe+mlbpQRCCo6FDS3atu1rmFrfsXaKAqevJDm/ry5zGEaRPeGi9yHTu76
         KNnCDKwu8XegzqaCCB6U/SdI28eGIHSu03g0Dxqj6JkVyHJQLd/8KZxTexHhr5+dfR2r
         TzHyZE/VbkweloMm6ixVPYta6i8jmgQcJ1SZ1aWlrdbli75pUV+tnkh35hE0TkY5y3UU
         5lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787232533; x=1787837333;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81FXEFEAWoGzBEUkp5WTBnX+AFEQNiURHAaHyp35qfU=;
        b=nHrY3j8QkPCTiz2TPZRPnesEDmPnZn0h/ubiRFWWGdFV8S6xyvVNQW70sM9hDoSLS0
         H1/dAGTiDhmyVWmEhrU3vGg8JpycGZ5injD7JgUXYHXNCotfMG3F3ZjhsdISkIaOJ3Qe
         NcUKmiHbNuK5qvSzuPu2kK4frh6qC/VlWj0ffBQcwxqjRvDdhC9WfDssDF53Y1or3spY
         WGtA/qEw9fiVIR51cBOpTdArfLBM1UES8FZMfFrCQ0d3O8QW9jfPZvI7r7qkkAM17Q6b
         dXTsbXOprHnC8wgTK3FWlZOJYfxSK8uKqZewwUqKJXnH5OOkz5eS7nB1FjoJV1k8duyA
         I3lg==
X-Forwarded-Encrypted: i=1; AHgh+RpxI7hpH8YQaB2KYoBqpMu6A7qZEPoJIEhME3Bh72zQLUbENspalBzO1+Xd4A58ubX3vF/7N+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsCT/MZcAgvjPSIuX6KuuP2+6y1YNNhxN9C9avnLzoIcyYc3qU
	N4UrGGX69YcAfa9uFeIHKU6V7Z4sDWWLCOwGG+5BzETO1XhzvmSpzjnBTWg7OTuFgtySHmHejQZ
	aPo4Lor9ZCbrqJp6YIIp3FBSjhs9MbpMeCthhNX6Sx4n2tPKA5vI9ToHuDw==
X-Gm-Gg: AR+sD11qiGEPgmmRm48sADIstzVU1qitNxqGsdQuYNDaswD2zmk7ZL4feq4quHeZ9qg
	I5JZXHzQ/gSExPsAUgynnz7sO2HCYNLaLOOmXQzFdRr4RSuM6d3Gfg68WveLH1v0WMO9rVTr+p9
	mAKexGcPT7WWDa+HiUnFdKp9A+Poh8R6mpSMurNAcHlPAsYWU0bmYnN1sb9LZnXhaoxvFpBnNrg
	lSkjmXLCSj8RKeP2kY4a5wl06YGEWSSnj/lBeJ/BQxhr5iQTBY/FpU/AKZhkgrvRICdWuDSPHiR
	DNIMPT/rtczLHtlp4UDAWmS3bYmfkkmsW08orMcwmMaiOs69CsDi8Ub9UQRDDiYYCzBUAEPCtW8
	Od5+s6WujYEh4IeJdUTh1gr2Ctlyo8GGAokBGxj62F11fBV/TqWqB2kTVHN4A2qCWTLyH/AXgSy
	I=
X-Received: by 2002:a05:600c:3b95:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-499aa1b97ccmr211342215e9.11.1787232532931;
        Thu, 20 Aug 2026 06:28:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b95:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-499aa1b97ccmr211341565e9.11.1787232532604;
        Thu, 20 Aug 2026 06:28:52 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499affa25acsm82583045e9.4.2026.08.20.06.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 06:28:52 -0700 (PDT)
Message-ID: <5dd2fd63-48f4-4f28-b3f0-fd9b7f502c2a@redhat.com>
Date: Thu, 20 Aug 2026 15:28:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: fec: Propagate PTP initialization errors
To: phucduc.bui@gmail.com, Wei Fang <wei.fang@nxp.com>,
 Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260820111416.97917-1-phucduc.bui@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260820111416.97917-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 1:14 PM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Change fec_ptp_init() to return an error code instead of silently
> ignoring failures during PTP initialization.
> 
> The PPS IRQ is not required for the FEC/PTP functionality, so its
> absence should not make the probe fail. However, an unavailable
> optional IRQ should be distinguished from an actual error returned
> during the IRQ lookup.
> 
> If a platform does not support the PPS IRQ, it can omit the IRQ from
> its device tree and the optional lookup will return -ENXIO. Propagate
> other errors from the IRQ lookup instead of silently ignoring them.
> 
> Also propagate failures from devm_request_irq() and ptp_clock_register().
> 
> Update the function declaration in fec.h accordingly.
> 
> Found by manual code inspection.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


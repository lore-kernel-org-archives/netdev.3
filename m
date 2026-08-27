Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5A3C583A
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818327; cv=none; b=puamLT+BDgePoc1KhoRfaOZRbwpHwpQ59wfWtAfOiv+e7XPhnQSsA+KEGp07SXdMUArijVo94q4IkwOZjrbg2W761kYsnWFACZ5b9MYl0F03UddC2HLJyJFiFmFpC0KX1pmVrKjrhBvY2kNFm9JiPJz/UYMO3vOY8Xuvfm1Cnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818327; c=relaxed/simple;
	bh=XXvcOg7psB4DZp+ToXMNSc3t80UQlypy5XmnMsY69s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIcBsrWbz3uXNOLW5iT7t9Ea/Mp3zwjfbN0GvSuSnKCSjXJTT65UFvyeQZPNv4TjoobiOwapvclXAXCI0E9uA4xPlYC16dqm7KZJDXdnxxjtbK+sern/JTjBID9fQsmpCTTA1USgZc+FNQV5fijgu0/XE08UiBLcwV3xdWtoDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHVejlFq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ds+CB0t1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHVejlFq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ds+CB0t1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787818323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkXgBrvkEFF+FLr+uh/pkSXPW3YzeXDokkwBP4HpY6M=;
	b=JHVejlFqlJmn6d+qdJSViADpiL1jMnrq4vWoTychD9TLNSf/uFnnlPMzS5Iy8t42/eGkut
	SQUF3+M+FzYf7mpCndQZbDc6XUSgsdSVJsj8zG2H4EHB14LcAGnYAv6U5cxiBkJ1DptIXe
	ToaPjraSeyNuOIyy2/VP/SDUr8LsUV4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-fuvvQfvkPHS55kYzfoiqmQ-1; Thu, 27 Aug 2026 04:12:01 -0400
X-MC-Unique: fuvvQfvkPHS55kYzfoiqmQ-1
X-Mimecast-MFC-AGG-ID: fuvvQfvkPHS55kYzfoiqmQ_1787818320
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482db84a6eeso342279f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787818320; x=1788423120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kkXgBrvkEFF+FLr+uh/pkSXPW3YzeXDokkwBP4HpY6M=;
        b=Ds+CB0t1EeJUc0/dDoK5yHrT4gl1Q+rwhi5x51pCd6Fexiqy453xFLiq03dSJkuADz
         ZcqyS3lccNNN10yrexcMSlzC1vMxGcUjY0jkARuja2vduowJqv3ek5SQZzZn8JpcRlfX
         yeBRARSs4PD7hR224LbEE78TjEUqcSPeU+P9/nFdzWh/2aobnZbyVfSGRLiFp7rwqhWZ
         dngMySMp/Qiq8tODO1NB9rxz7FSHqUJBzq+fU1RDstshoqCq7qWP5bNQWnrUQEUFnV8Y
         SBQoVOpm9SNWHuhas9MJidSTJ6ydLDhl8wrB4RkUwCdUnMP/4Ojv/QrCbnYb3ISqbfcF
         2jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787818320; x=1788423120;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkXgBrvkEFF+FLr+uh/pkSXPW3YzeXDokkwBP4HpY6M=;
        b=Fs/lkAgYYuCcRKOYkjMIYUa2hmoIM7a41+tiiQq+m0E0K89bp3ZeVcSe9Q6mmwW0VX
         H256ygTOxlj5hZ9ywK5jjRn4HOZ4eGf5CzI4hGBJnrTllY8WqDJhuYvRCQCMd58aeurR
         8PgSNDlwevxikxeiF+kQpsUq24Bub7TQ6yBy2+s7QnWzJQ9fapreefgQR90R0O3Cvgwp
         X6Z+8J3LTQSHsSlOySZP4Y55j6aNthQUD3db37l6O+jIzEEwAm9UCCH8hiXn2KFL/OAT
         dTlDUNattSclmEFWyqq+N3NsK/I2rFFGKnX8DB5AukALMm2Fp+6OeLu68fRhltPn0GDO
         UbOw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0msb2qpfPYax6waUglQmyiK4rm12LNG5oL1tDmcC18AeAS04dPYsRKqclYVvEW6FfRILKc2k=@vger.kernel.org
X-Gm-Message-State: AFuF++miEwGZY5Rgy1FikcyOxoiYo2UKBwqw7L/Wz0Di87tPXoPyxVLq
	DrtxBjbsyuUM1FzCTqiYbbcUHn+m/TqQy1ZJt0cXl2FwLIoPx5HZxUplKzp4q6kOrTO74AhIxKr
	v/LsZTr6jMOSqOvqdrwY2XYjFFbHEoNffMbwbOh89kFqfsALX9zpfyIKilw==
X-Gm-Gg: AR+sD12edT2fQhnKsrJRN3Jc3kWNY4xA0ZpLUgLbk12GA0I9B0+mlXYrTOuc/vYHWT0
	sedtpNE6vXjhgXrLCYBEIwtbrIqHeN4WuMTqJMU3VzROq/wNK4yjRg6zNde1cToRVfL5zkYv+o0
	KJeF8Ndo4LYWGDD+s4wCUqdlzAz4ZKda3taJ1OhMAKq4uxq1QwSDfSm2C7y6SQsJmjbqtHiriO0
	m3md+fPxv5aKIrGtM/9o3VL77bM1CzOyyQNVQTWOBQlwC6Qc5NyZSLjEFgEx1t+VmBPoeN64YGF
	p+uRRpieYbECwRwN3fiJX/yKg42Dof6cc3ibsL5ADqu8VVZ07++VeNaWObix4D853AaYyczvy1E
	O15K1N7JBHnS9IAPTciLH03aUwowdz/mrZ34QszSTEGzRVysbBLvovZmCPWUKg7HEJhmYC5A=
X-Received: by 2002:a05:6000:25ed:b0:482:e4bc:51b5 with SMTP id ffacd0b85a97d-482e4bc5453mr15956942f8f.4.1787818320140;
        Thu, 27 Aug 2026 01:12:00 -0700 (PDT)
X-Received: by 2002:a05:6000:25ed:b0:482:e4bc:51b5 with SMTP id ffacd0b85a97d-482e4bc5453mr15956834f8f.4.1787818319636;
        Thu, 27 Aug 2026 01:11:59 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28e8fb5sm7064565f8f.29.2026.08.27.01.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:11:58 -0700 (PDT)
Message-ID: <8d53fc95-c945-4cdd-bdb7-d76491b27eea@redhat.com>
Date: Thu, 27 Aug 2026 10:11:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/sched: act_sample: reset truncation settings
 on action replace
To: Khawar Ahemad <ahemadkhawar123@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org
References: <20260825160143.86866-1-ahemadkhawar123@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260825160143.86866-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 6:01 PM, Khawar Ahemad wrote:
> When replacing an existing sample action, if TCA_SAMPLE_TRUNC_SIZE is not
> passed in the netlink request, s->truncate and s->trunc_size retain their
> previous values from the prior configuration.
> 
> As a result, a user cannot disable packet truncation when replacing a
> sample action unless the action is fully deleted and recreated. In
> addition, the hardware offload state and netlink dump continue to report
> truncation as active.
> 
> Fix this by explicitly resetting s->truncate to false and s->trunc_size
> to 0 when TCA_SAMPLE_TRUNC_SIZE is omitted during tcf_sample_init().
> 
> Fixes: 5c56784d852a ("net/sched: act_sample: add support for packet truncation")
> Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


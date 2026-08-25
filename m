Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB53E3164
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646818; cv=none; b=fWtRs1CnHi6h6aj5u2Fg8WYMU9mexu+a1BlmUsE6gSpvyDFKyMJOMJvsCrEvZrROy6sQcxnyN6wnFTzLHZtGxLhmRfOx17BeAQb9hVoIuhd34+hptinJLJjYHmgzI1nauJOmKBrcob6gC51Yy0a676JsE0VC8JMRX+OqbpYddn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646818; c=relaxed/simple;
	bh=fWBWy64iKsCBFztcv+VWls7yQvkNtUNfFO4diiqfAXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dcqyk3r1LjNzmH2xm0oBiyA9JfblIbc95GisXWJ/yDNizzoh4WxYxlgOdflLhGN6QiECG0db96ft9d0ieNQo3z0BdHrBP7JEg3MZ0nXP87v2lvEggD9QECfmELxbt0A+/mvFQoxZRTIrmfFV/Dfgupk24Kt5eGgeWrlDUhkmJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9fHPQjZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIzW07p3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9fHPQjZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIzW07p3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787646815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWBD3iJL83l1SuUqrEcE1y4U7JlqfeuMYAAUlvs1TeI=;
	b=S9fHPQjZ9pI2QgT+FadzoRo4OP2MijkxZx/Tgir9g2fOpiYdUIpp4u2U4C/ZgRhvyAZwiI
	/Xz5KLr/ltPdMhWWF+54LGO6ofVatzFsNcHqNFsvMWg4UuuumQ7jQ+pjVMUPFAOwABLWUL
	vKBqITyiZE4heqxVIPwQgLpEJMT73vo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-6q6vyNe6P_K4IQKXDvvQew-1; Tue, 25 Aug 2026 04:33:25 -0400
X-MC-Unique: 6q6vyNe6P_K4IQKXDvvQew-1
X-Mimecast-MFC-AGG-ID: 6q6vyNe6P_K4IQKXDvvQew_1787646804
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-698a99b6140so4453946a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787646804; x=1788251604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWBD3iJL83l1SuUqrEcE1y4U7JlqfeuMYAAUlvs1TeI=;
        b=CIzW07p3TN9oQ1B+AJto1w6t5BZQJkVElCVjOO4XhJ7i/JapgecfgRHMVm4Rx446zG
         eJnzr6OR8w8uFL+M+P1ByAFip5TpI1i9b/+jKdTZidL5joP42r+PUzclC0iXlOwrYrz2
         SiB7Mmby2MG3HBXT6i4xuTRBAIFKD4EIc0hXvST3QKnqgS0ObnS02Pxdm7XownlrCbVh
         Uf4nmS9I2ZA8UTl/dW5Z+kJtI6pELw3u1nPWkhGdbBZahSjUCrlDpD9FnYncoQccRp8B
         Jc3BQoSar0rU/g64mTbyNs27uhMIl9WVbkltaAX29l5tpnTcqu8IlvFxIpF+yUxVsrJg
         0Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646804; x=1788251604;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWBD3iJL83l1SuUqrEcE1y4U7JlqfeuMYAAUlvs1TeI=;
        b=rfAqUxDN8rAmtLAhsDk4uPBZMGqOP691YYUlIHXskRKRUXnH0Sdqwp5GvJHVEtV3gH
         FFcAiJ8y9bcd+wVPBGnP/KQfeJKZtRJ7KDpCfU2YguGefwczgCfL8ykJOVjOoJzPU2n2
         AHENYVfcOrxTUUfnyPQ9zFNb2uiPBoCdUEkFLoolbAhm8qLPEgGyxZ1YndIABoclJ9aV
         3yzRg8KB/yx4UIIIy1I/luU56jspUvSnfgz82Y3J5sdagK3S3uDvkWmVb3cOcB2Tiscs
         l9ZCTNzYjyRlYtPLDsEJvYH/Xl4K513jjtJCQi3zw1pBSldjs1GGf5J1ha1vmVnYWh1D
         ZkBg==
X-Forwarded-Encrypted: i=1; AHgh+RpF7gdHre0Es5LTiQifZ6gIgLwEA6nRgnALjrU/3wMRcTww5KPgf7OUf9WXEEGJjOBSxdGioLk=@vger.kernel.org
X-Gm-Message-State: AFuF++nK7aM42Lt6YTwurEWt/cCOXTcI9aq6nxsUSb/8Zg7w9Xyk58cj
	d6wXOd4ebeW0SAh8Cw3cIN7cEwl5mZRoo6pm41kHF4kz7U8GSBiy0TOY3IbEoQ4YdJrPJZ5gYvv
	HRE/abcVh5HNYDCvieKjdAiDmu1gXFGbEe+L1qbQT4sPRcTWTtpViEMTi7w==
X-Gm-Gg: AR+sD10qkjvCOUZqFE7aSdxH5oDZeIekcRdcHgKouAQ8r/r0tMwAa5xBirO29Wl36MV
	1zdezJrD9ecNcMI7Blt3B0yVRox5eOo5ErTwzk92ltWve/h6LDnMy59Y9uZH7W/5Hxt3hfiz1LY
	CSxhq1vvDOzI/psfDT8YD7LE33HHqtXJlxd0GzYkTFEPlp+VkQeUU4lmkrjGsfKOT4O6p+XDJSA
	cv5emI1EpbN8H/15cl2qVC6JYJTh6qNjKSnJLsA+0b6fil62J/suAiN9INVydf78/0PSAQfDItr
	DgtOV8hYCiOLWUrHB40h6MG2ZJ3mhcVCh4oA8BX9SWLdI7Jj99+xIkHBtATCemXz+hYnQxzHXDh
	qNKQg3yC4/qtT2hOy0VHEDbINaKPq9EQCdMKviqek3q9zjmBnz+21wpfP8J6yn/GPhnUIiB99
X-Received: by 2002:a05:6402:52cb:b0:6a1:f7f4:200b with SMTP id 4fb4d7f45d1cf-6a42f1d6913mr37890445a12.12.1787646804373;
        Tue, 25 Aug 2026 01:33:24 -0700 (PDT)
X-Received: by 2002:a05:6402:52cb:b0:6a1:f7f4:200b with SMTP id 4fb4d7f45d1cf-6a42f1d6913mr37890401a12.12.1787646803937;
        Tue, 25 Aug 2026 01:33:23 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2ddad2sm12253271a12.30.2026.08.25.01.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:33:22 -0700 (PDT)
Message-ID: <62618ef6-28f1-4d0d-916a-96fc54dfc2e3@redhat.com>
Date: Tue, 25 Aug 2026 10:33:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 4/6] net/sched: fq_pie: clamp default quantum to
 avoid signed overflow
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Mohit P. Tahiliani"
 <tahiliani@nitk.edu.in>, "Sachin D . Patil" <sdp.sachin@gmail.com>,
 "V. Saicharan" <vsaicharan1998@gmail.com>,
 Mohit Bhasi <mohitbhasi1998@gmail.com>, Leslie Monis
 <lesliemonis@gmail.com>, Gautam Ramakrishnan <gautamramk@gmail.com>,
 stable@vger.kernel.org, vega@nebusec.ai,
 Victor Nogueira <victor@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
 <20260822195509.112717-5-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260822195509.112717-5-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/22/26 9:55 PM, Jamal Hadi Salim wrote:
> fq_pie_init() sets q->quantum = psched_mtu(qdisc_dev(sch)) without
> clamping. A device with a huge MTU (e.g. dummy with max_mtu == 0
> accepting MTU 2147483634) makes psched_mtu() return 0x80000000, which
> overflows the signed flow->deficit to INT_MIN in fq_pie_qdisc_dequeue(),
> causing an infinite loop and soft lockup. Emulate fq_pie_policy which
> is already bounded to [1, 1 << 20]; clamp the default to [256, 1 << 20].
> 256 matches fq_codel's floor and is a sane minimum for a DRR quantum.
> 
> Conditions to recreate the bug: a device whose MTU (plus
> hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
> device with max_mtu == 0 accepting MTU 2147483634). Requires
> CAP_NET_ADMIN in a user namespace.
> 
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_fq_pie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> index 069e1facd413..b27d95418707 100644
> --- a/net/sched/sch_fq_pie.c
> +++ b/net/sched/sch_fq_pie.c
> @@ -427,7 +427,8 @@ static int fq_pie_init(struct Qdisc *sch, struct nlattr *opt,
>  	pie_params_init(&q->p_params);
>  	sch->limit = 10 * 1024;
>  	q->p_params.limit = sch->limit;
> -	q->quantum = psched_mtu(qdisc_dev(sch));
> +	q->quantum = clamp_t(u32, psched_mtu(qdisc_dev(sch)),
> +			     256, 1 << 20);

Sashiko thinks that the soft lookup is still reachable via pie_change:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822195509.112717-1-jhs%40mojatatu.com

and has similar concerns for patch 6/6, too. It marks the issues as
pre-existing, but AFAICS they overlap with the things addressed here.

WDYT?

/P


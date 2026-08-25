Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CDC345749
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677413; cv=none; b=IphkHm0Sy+S1DATY5+e1CAtDmO6tWcbSW6p/guv7A204suDSZFwPtGxwShV+sTMU3/N65WvkxY09ktDldMnCGyMwiUOqv1Lj+Cs11/+A2y0+/+6ZYy4WbELnIl5vqmCY/slLBEvzSEAPcwPKlQzrxbHpFr/VM/v8rS/8Wumdh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677413; c=relaxed/simple;
	bh=6VxzQcU5gwUAm1OIoWROcDPRf8VEitMFSmwvuiGiFwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgPMfDkdaZBIQByNkDWNBFKRbe2bJ5NxlMgOwOC9aJ1A6L2R78C1ccSW2pRZo4e8z/4GGRpQXhSwjBAPtbi6ShvtJqnyrtiLAlJTuiZdb9mkVFcYMZMTgg8dxIXfTQO06Z3og5rj83IyVXdaJyRnSn1mgg3clYwFrhXCOJFQvRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Gvr3UsLX; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Gvr3UsLX"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-977ba4d3b49so11418241.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787677410; x=1788282210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kt1KRjRDTEuJqQ5xwc6xT/XfBUPuShim2DbNeahPWIo=;
        b=Gvr3UsLXiENM0u+QD+lMmZZBvLEQDrQdsyaOj3gHVubEIAssteL5CK84k3JuDdCv6o
         ABloTfoPW6GXLR9alw71MxqPQVL/iLfjMctPvEsoKTdmZ6bqC4GLbVcULpexUFN4t271
         GXhD2gCmgEcf5XO+mWZM9SFZ7THqqlufp2oz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787677410; x=1788282210;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kt1KRjRDTEuJqQ5xwc6xT/XfBUPuShim2DbNeahPWIo=;
        b=Ng0LDd/hTG9SpPHZ3TbZdBH9cXg65o6htbB/8cs+BfcDbCttkmFbk0p6V5mvBH2Mum
         a1TvDEKBXuLie1Cr/FFJytpi0utFRbUAJ++DyPIEh359Gw/ebUcP/T1V0F3mWLLXo/Ne
         NCYew7TsOKV5AOFATDuJW3BT50btJPvM3omXfVOkfAQEYwB6yjFZ9arR9EQlPBrIHalQ
         SpzqoWpW5pVjIOdcokQewpqGSXV0YXoOiFP/SnC/QGQRqH1Pc+HvXiFvtYO9syqWbiSA
         G+dcQJeWp/l1b06nbYdrafbym+YmffqxwMHGmXiKdEMQQZKBIiTyIUi62RDRxjG8TG9J
         xaAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1laWxWMzPFF23uSJMnhbhNOrQdMHCfrICiQVV9zvmttlpxt7cg7AwT6QDCr9JsWoaketbqB4=@vger.kernel.org
X-Gm-Message-State: AFuF++mGxDHGGbEAiGIAcjqDA6pAUH5ujuyJg0M+GmN8KTT0BmEt9JwG
	thAc9PpEYZTiCM+BPvMavmw8WWgVTEX4qKY2YYt/3tye7nofCPIuMyTZJzBaYrFV0w==
X-Gm-Gg: AR+sD11zaExCoi0ZbzQDhcvj45hwCS5X3wfAI/UPXrpRM2U7F6T1I9EDAV5cCqYSI+/
	enWLrJzf2ZIPAmm0ZyvdKgFHOgSeIUDlaTCjb3H9ofEDC1FvFL1VYUrn8bQCj/OYlCiSgSkVFTM
	bdxNkI+6OBRGPc7tTVyrF9LMke9W0IkafNwuxEp8aFBMUJLjV+4UETbe4rJJcg78Vz2RMaOTcGi
	x0kpKa60TYCyC04iE2QhonS/8CfYQMVdbpwXWsx4xsSvveiJ12HlYkPT9CYi0gnzq/kuVuKly56
	55C7jcGXzn3/OxhODAIfYa53RbiIU+wk3xKNSPpsJLE9rqlxD6iP+OrfzjuoA7vjBSKMCTZ4C0P
	hSV3T8a08fG0p1vtFi1Liq3YyEYm6tCDlBQucVRzkMxhym9YoyOWuOJxiJUQOPJZZ+v/9Tb4BVo
	jkeiGsYoQEfp8JB2x4DEotaKZrC3upAQsOmuI9uuvQKZmCi9SRQZk/XxaJg/IJj0PKaIr4hA==
X-Received: by 2002:a05:6102:3c4c:b0:774:ce64:242f with SMTP id ada2fe7eead31-77fd6508183mr1598915137.20.1787677408786;
        Tue, 25 Aug 2026 10:03:28 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97cbb44542bsm101377241.9.2026.08.25.10.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 10:03:28 -0700 (PDT)
Message-ID: <e6b875b8-4c90-47b8-b967-e42f3700362f@mojatatu.com>
Date: Tue, 25 Aug 2026 14:03:23 -0300
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
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
References: <20260825160143.86866-1-ahemadkhawar123@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260825160143.86866-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/08/2026 13:01, Khawar Ahemad wrote:
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

This would be a behavioural regression. Users are not expecting that
a replace omitting truncation parameters will silently overwrite their
previous truncation settings. Can you instead create a new netlink
attribute? Something like "TCA_SAMPLE_FLAGS" which might have a
flag telling the action to unset this parameter?
Other option is to interpret 0 as "unset", but that might break
some setups.
Your fixes commit doesn't seem to exist and, since this is a fix,
you should target net and not net-next.
Also remember to wait 24 hours before posting a v2.

cheers,
Victor

Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E639768D
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073849; cv=none; b=h1oseleSeD8TLlz+ZknoYIuIzwczM9kHF+llYQVTSxUHyb9C+sDj93eKusARX3M2i0INd5n9Fnbx0vXk521lVsZ9FFkgRtiaV0o9PkgoDzL3+eG+Ks5J8U8hgx4ucHNvsKqoD3VEYzV2XT86+0bOXyfPv9ainBvtEHvKRPyDHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073849; c=relaxed/simple;
	bh=jtexLRd0LMEvWjSqgopV5i9TmNSBRk6qk2dv0E078/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nK4u9H7fNDTw9LQJ0d1hxnhpes+tvt2pGE1rHWnPd7nMp7sV7+Lq+cH8hCKuwJ001eMOn1KBhCVHYyxY+yYQlfxHXUagEhrmQc8VO4SfJzbVpTGyKLPbM/bg49WO6G+itNIMhzJ6updyQLSMn4Jzd3vaJVahNdafo2wZa97BB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgNfjCxw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgNfjCxw"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487214ad2bso4515092b3a.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786073845; x=1786678645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q+fTOtPno7yWUV/SDfx7o6rMybrKsJN3GZDuyA1kW44=;
        b=lgNfjCxwz6BA6r8khcLhKKnd+YOUSYJDMOaGG+0DFZezRR/VhjhtmuE7M6TngxKiBP
         /roAPCFWT0lKzKE19iQKeT3ZYGOzdUoZdFxrlUmguLy1j5kdCus3LWtUUOTyTBDMU1Tu
         ciKqoy+DV27jOqroCdVsIQVWK3EWo5+fHMDbMxfxiAkv+n8sXGFsB/1kawNe+vH4O1nN
         mG7tahrV68GChoNF7ahiupLXxo4ZhaChArJr7VldS3AA5yysqWVtwU7YAhKIqK3QzQ2L
         rqq7vVBsYcIuesXUJrprgSmxwn6ZV+kw2Xd68dJ4WPUegQgiLHg+saFuuf1h491qV100
         KAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786073845; x=1786678645;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+fTOtPno7yWUV/SDfx7o6rMybrKsJN3GZDuyA1kW44=;
        b=Zq0yDQknqzqxslIDSa7YU0usHp6/ZIYgS5ob+TnQlUTNCLHoAeIaV3gZ+1sGy9QPF6
         F2bpzTjUwM9h6HhNm7+b6irtqeE0vIpEgRURk6GB0iSZ5Z9/MkjSyskwg2AwizFqYJ//
         H6KUBpm2PfSCFWTx9/2lA/gGo9OSu7QZAkoVOPwi2bhECXJTOC4XFxKoJMT1pZksGD0c
         VfeLvqxpTGM/iAiclsneFNxrtTFJ17GIU5KgBIM+4ZEhmu4KHem7VvksnggiKxNt34xU
         DF8wjzb7oT1+7L/I7VfD5Md0G9SbqsxMB2MfgL04WKErdPjgxPBRWMilrMyGd9Lb4Ipi
         QQjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlVlW2EHOMoQQ9CAlMWGwbDdAwlP4hNSBBigK5ZU4/QTrtWuOBwm8We2L53j9/rddOe35aE9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5TxKcsEg/r7v1wYmTR201KvGcD5770+TpCGYbAdzR3p9eo6M
	ZOIblI1LTVAiHuBvC74lfbSTHtUmqXpZZCr+yGAke+Cei9P1kRPEn5y7
X-Gm-Gg: AR+sD11TOE5mGY81p2oiKtFc/X5mCAahrux30WAmY2tCHjcHWnn6sxhs9sEe3ypA52f
	xifelUlh6XAsGC33QXav1cp9e9rXuR6FBRG/D5GnWw2QaqTuMOzGJfFFsdbGSjsEY94miUyIIaR
	TyvG6Xdfjl4jB+ESG1q/6gp+yUwVz/HIgSplMqiUV0T76FCgghKocm/+TH3w/VxWxRpbrcze74e
	lUPMfX5jQQdC6DyBUtRY9y467j+QL7kUZbovuYjVfQqXktyIuOV7RcLiVcHxgrz3sW+Al9KGXyZ
	ygIxvm26/nk1XsgwS2DXtOcCF5GlSX6KWS/R9+pG7+4dV6S4L0TwxWAJiRjJ00gHLXlcyJ5jJ19
	aKcFnZ3xaYL3/bOQ2rY8NFiMoExpGxm0Q09xvqBfygh6IrDOBUsuVlISpKLLaZOqt1csG7zwfL+
	Lgjx5fXOAKg6h5VOOCnPTEFW3aKAmYLCxytIytOTTNwpmvSNMroCMGHGD9QtS88sXx553QQn0io
	9h8g2awkDR1Bk470MrK
X-Received: by 2002:a05:6a00:1895:b0:842:6004:3fda with SMTP id d2e1a72fcca58-84f5e0685a6mr685783b3a.25.1786073844634;
        Thu, 06 Aug 2026 20:37:24 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3cade6sm285307b3a.21.2026.08.06.20.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 20:37:24 -0700 (PDT)
Message-ID: <c8c6f8ea-3aba-4dbb-ab16-4f696441033c@gmail.com>
Date: Fri, 7 Aug 2026 11:37:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: cls_api: fix tp_created race losing
 existing tcf_proto
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, corvus@tencent.com, henrymei@tencent.com,
 stable@vger.kernel.org
References: <20260805093012.95155-1-henrymei@tencent.com>
 <CAM0EoMmZGXhHL2v=AyjR9xSs8-s9EfkA9FkpULqtFBEOUxHQQA@mail.gmail.com>
 <aabdf499-20ad-4667-b289-626c09a56c0a@gmail.com>
 <CAM0EoMmM-7cphQGmfZa+H3p5HjQ71gJ=8J6-HhhRwzAv--74AA@mail.gmail.com>
From: Lin Jiapeng <ljp1205831794@gmail.com>
In-Reply-To: <CAM0EoMmM-7cphQGmfZa+H3p5HjQ71gJ=8J6-HhhRwzAv--74AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/7 02:38, Jamal Hadi Salim 写道:
> Thanks. Please respond to that patch and add a tested-by tag
> 
>> BTW, "TencentOS Corvus AI" found this bug; and the patch was mannualy
> 
> Also add a reported-by tag to the patch response
> 
>> written and validated, so no `assisted-by` tag here. Noted for future
>> submissions.
> 
> It does look like there was some human touch to it (other than the
> verbose comment) - and is a reasonable patch except you missed one
> spot.
> I am wondering how you tested it. We had to craft printks to see the issue.
> 
> I was kind of suprised how quickly you found the issue. Victor had
> something already based on what Sashiko said but i said to wait until
> the first patch made it in.
> Does Corvus AI watch what Sashiko comments on?
> 
> cheers,
> jamal
Thanks for the review! Glad to share our testing approach.

For this bug we placed kprobes on tcf_chain_tp_delete_empty, 
tcf_proto_destroy and the classifiers' change() callbacks, capturing the 
tp pointer arguments ($argN) and return values. Matching tp pointers 
across the traced PIDs shows the losing thread calling delete_empty on a 
tp owned by the other racing thread — right after destroying its own 
tp_new, which is exactly the signature of tp_created not being reset. On 
an unpatched kernel we observed 927 such wrongful deletions in 3000 
rounds; with this patch applied, zero, and normal filter 
creation/deletion is unaffected.

As for how we found it so quickly: Corvus AI continuously explores bugs 
and security issues in the Linux kernel and generates reports. Each 
report ships with a PoC and a QEMU-based reproduction procedure, 
covering both static audit and dynamic verification; a human then 
reviews the report and reproduces the result before we post and patch 
the bugs.

cheers,
Aohan Mei

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491045;
	b=hTEcR7NyPk5nVhXe4dPLPf4BBAphN2sHCq6NmCMQpJwrIpgCCtpmivSVgJvNFmWOmQK0
	 WWjNOARliW4K869PdohJ+sFfvUgDjYyvba2kCm20mNQzRiSXu6WI+YrG5jpt8PPvanN/X
	 T1po9fYgcqBXSgFtkuD7D9A6lNVsxO7ccfWfs5s+CCJpfinJrfAbtp083xcQ1VgO1btXJ
	 KNCIfpNz3GWWUCPAi4f3yWZHWcKcfvsByJRVkYxz8PW92OReu29PBSWQHVoZIj+q4uNfA
	 GC+xb8MsasHFtmc45kUdtwzvtejOOOZXARAIWVBpYbhborfokx3+uSY1RjnPz3zWong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491045;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1ObhwPum69aDUV39SNJmJP04Yb8owKhA7mNwPpuepF8=;
	b=vHWuV2Nz62dFMGxphzrndxUSwbKHS4/eie9XWBriR8WOCIW1UBpgEYOQhLcNmRkJF6Ti
	 c43hl5II1uL6LY5RT0OfyUV/6Armkiw1NbWCSrntBNnyFTQFrgAEW6paQYNNrFhRChuyZ
	 Pxm6IiThzbOdY/qyGpMwuUs3O/vzDRkOK94TnazATPNy6zda19wIp3pFea5/1nS5ioilG
	 16J4wF0WXeHXJMBub1Bx4Ibn9P/ZcnT74H1mOPtMs/9BPr6V79GGmTp3bfmEU18PrKMiT
	 5XPd3IMRxj71SoHrcfOWrqWXVULTScs64Smb6mh6OC8dbtN4AS7OFIDRY2VfN7jkvtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="LYtT/lkn";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=isKD7XaP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F3B606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74F3B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LYtT/lkn;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=isKD7XaP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794491043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ObhwPum69aDUV39SNJmJP04Yb8owKhA7mNwPpuepF8=;
	b=LYtT/lknOT7cH6/dm8O8ISZhLuKcOHrYi0ITtU764AW7B9OG/VAmt8SKdDtBfU/vdJEFJ7
	jHXCNXnIi0ryEuXzZT0JYfHwMMAZqu09FMPTPtyXblMoQzIioknoswF1wqxyqkxMeHUj7h
	T4lKzIA/s/DSwfMSTqprpDN4j/oHAeA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-VayTwaSmNa-zIhc9IaZOMA-1; Thu, 12 Nov 2026 08:44:01 -0500
X-MC-Unique: VayTwaSmNa-zIhc9IaZOMA-1
X-Mimecast-MFC-AGG-ID: VayTwaSmNa-zIhc9IaZOMA_1794491040
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c50547b4992so254843666b.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794491040; x=1795095840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ObhwPum69aDUV39SNJmJP04Yb8owKhA7mNwPpuepF8=;
        b=isKD7XaPxeYF7ge77GAW3uvPieIkX/mWvfKhUW+4MGBxTzkS48NvxOAvg3x+9jmky7
         jnd7LKdNHm41rJyON7Cfi3kDEWmbU085Tw2Xev93EQC8m0pE95p6HedGBth654YK90Av
         wCfx3c/b86YKe1SIAqRVfpwXmH26BHVEkgkYHd8/b6EN7JxEnVIGnvcVAIz5ZZm/YqeR
         TDrWUOtv+S2Pb7CoHuHbX8AvlHkaQnWvyjdeff/UJoIG80OmC9T+fFeAbpRCIGZWIzmi
         fIUcaYVBwfX13mvxkUiYyHOB6Usv5QASwyFB0aGyi72RIjl1yGsXztzv8XTD37Aan/2f
         mTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491040; x=1795095840;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ObhwPum69aDUV39SNJmJP04Yb8owKhA7mNwPpuepF8=;
        b=HqKQS51sJYL7zmPL6anicZhBJSkCIkLypu8FUqPNG7ULrAo79mSmDtNsR2qUOHvjAI
         PZyZ3VFn7/2tx6Myt7HMtsgQ/Xq/OGdmvUraK/NOgDey6kupUc919for3B2j62xCziRb
         F1Skxdy1j/8H6kt21xUCaRbkIwrhVUm5rDSOk1D8SlFD+rV1EnJs+V8EEI8fd8hGqQ0x
         VfS/9S83O4Rif7TGfx1Ho0LksZYLEmeeZzwEfok7UzuzihIa7cbWXRL5nI3zkWJ9w71e
         pYScYjgITwdWOdER4EXUJHjHpvgJLDX8nlPBqMt8eGNxY5rGCIah4He7aUCCy1k6Z3xx
         hcmg==
X-Forwarded-Encrypted: i=1; AL+hErGhiaD2AjCCxtBLfhLUUiiqEwfjpN89XkrsPoJGBiunjKJi8gQTqaB602qeNF0fGZtMiS/P+ME=@vger.kernel.org
X-Gm-Message-State: APuU4Z97JPSkze0Atm5GDZnpIcXX+5nfeehGpy2ZdcSJ5jomqXRoFyN4
	fLeZKlCGurls1g98P5iN9zEsmbQEimIq0NKAj1pSjZPs+kI7izgb8OTJMNzou3DULqLoaZTx0kH
	AGZhsBQ0EL6B9KDwp15SfRH5nwwtjJul88AvSmgj1XvwWNfVRRiJKIJSugA3tf+FEjA==
X-Gm-Gg: AYBFou0S/+Qj35/RlZpYN5RyEg8n5GSm/fbDEUGo5YazUU1I8KMTtC5vceTLgkRlylg
	yXWrVG5bJ3fl/6sdpIL0VQeorYlf7G6uiXVa4HiNxqXU9mDFuOnJ8oQS4xzExqnZWcBzebH1FGg
	2HSf01fbHvYPVuxflOMstLmanUhk/RNuJDl+8/1mElA13+v2Kbz3xkaeNCo48hoFDmS9lrP/++P
	wiFyS1BS/FB36yyiiN6mwkLb7cUok9042L33AccYOFUs9FndCsQcvSGBT4ONBMbQmJhZikEtI/Q
	PniXmUL0JhaOJ9doqjL/HJ4eEKLvP6Xxu6iwOdMjPr77ebYgGV2oWnkrcQZvzaAGdl1kY9PlX+k
	jHsgBfKY62rEvT7P8tM6m6VBzFITICNu9Prppl0wbNLV147/0pFEMmgMix2MuxGkc/eYTtv1NYR
	9bAGhzP4pBGckYbun/2w9NhKa3NAcGdyrIblpn2OeCuMOa
X-Received: by 2002:a17:907:9448:b0:c49:a571:c4f9 with SMTP id a640c23a62f3a-c5066aaaab9mr461891766b.13.1794491039967;
        Thu, 12 Nov 2026 05:43:59 -0800 (PST)
X-Received: by 2002:a17:907:9448:b0:c49:a571:c4f9 with SMTP id a640c23a62f3a-c5066aaaab9mr461890566b.13.1794491039561;
        Thu, 12 Nov 2026 05:43:59 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a6930sm349521366b.5.2026.11.12.05.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:43:59 -0800 (PST)
Message-ID: <62abc297-daf8-415f-9450-202d226ebd9e@redhat.com>
Date: Thu, 12 Nov 2026 14:43:57 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/sched: cls_flow: avoid integer overflow
 in perturb_period
To: Wei Tao <taowei@kylinos.cn>, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261106063823.99731-1-taowei@kylinos.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261106063823.99731-1-taowei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 07:38, Wei Tao wrote:
> @@ -486,7 +487,13 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
>   		if (tb[TCA_FLOW_PERTURB]) {
>   			if (mode != FLOW_MODE_HASH)
>   				goto err2;
> -			perturb_period = nla_get_u32(tb[TCA_FLOW_PERTURB]) * HZ;
> +			val = nla_get_u32(tb[TCA_FLOW_PERTURB]);
> +			if (val > INT_MAX / HZ) {
> +				NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
> +				err = -EINVAL;
> +				goto err2;

Sashiko noted the added code could by simplified/substituted with
a  NLA_POLICY_FULL_RANGE(NLA_U32, &range):

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106063823.99731-1-taowei@kylinos.cn

/P


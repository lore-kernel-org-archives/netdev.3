Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADE4252A6
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324317; cv=none; b=H6kY+228JDuczsn2Uzhp0PAqNLCqNEnXOlNCy/RCN/+FuNE+lV6Emxaok17jBpszwZ4G8MkK3m1yqYzQE8wz7tEBjDjetBWILm+fOGXEYxaKfiCkXgKdVDOCMpGJNoU3S9/TvkdqFJcbq4ABvv8wNbnmGk+078wOA3AKMWE8DiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324317; c=relaxed/simple;
	bh=PS6I+KUgNXnSi5weearFYWADpgw2S69/E4pMW3bzEiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olpkZAu1UcYXniuAfF+IKf4WB93dS15lUJ8pkv0kLyUvKsqsGyVZknab7uvNbu2OCqDcyY2cfceF8lh+7yCYv0ghxu9gZVqvcYOs2QFHEAmZfXypCfN5yag9bYwOtjep1cL1FQ3B9ZEvamcXwAyUYRIXis16IrM4AfPVEpRRn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15de09d5c4so62257966b.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324314; x=1787929114;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rhb0TY0Zhu/qlTKmV8jY/t0dcWFmud7hP6m4a0m/wLc=;
        b=Xt3IAhXs1wFZXD2/g6qkS7rmTZ+4MmZXWzFNLT31SEpyPsWBMPA+rcRKnecQzUcJZx
         LJ9CCqIKMgexKoP5rMVLEgtqwVr5MfgVUrFMGO+q+Fh9HWbpdf0uUzfVso0NRDKRDdzz
         9KzAIOyt03258K6500qYUDKR6d09H5jEKUuVUKRV9maZliEcglu0cKBNqim34DH40r5N
         aQx9B1CN/cDbZ4Y4BpT+HSaBPzr9VWuyd5+16LlrcITguPFiHcCQudu0UOkRs7FGctnl
         Ge9lFZv7TZvbCmxuIG1/GcAndxN6ID71pZeFdhO0oN4S6byp4Q4jxRFItIxRy7o7iBNw
         lBIw==
X-Gm-Message-State: AFuF++kCqtiqz+cIiErCggwVGEgSihJk+T3RHhstgZtY9Jx9/4r36/vN
	WgnMv6387N4MzKId1Tv+lNaU2aUzz/0O4zQP0sjuVkNCUNe3KWBWRLXrWMLCb6Xi
X-Gm-Gg: AR+sD10k41913CUOn6wJCrggEdTEiDrZgDKFtmVdopvmvVQ9quBfPXph+OZyYP/LqOu
	dCacq0hY/I+87vNf9MPvyDtHsnO9gwlMPY39lNB2B+66P4VTStyEf1IuGVYW5FgopBdSvK3a6i4
	I91ReE7TQERkA0av3Av933v4WzBDAZkP4P+c+u2mwq8gUM625mGQ9R1qA7jwa4KdIkrxHCwBI/E
	WPzi60RHLbVRTuY0IkSew+sWSssX75ZSpGMrCRAtMYQy5R5LNN+7136KC25OIjkWmG9fu7quvDq
	/k3Wao30QtlZnS3QtvEA+f8rr+ohOKuDBMAO0Wxw/vteafXhID2ani3XdCKmHlh/EjyuUBC7DNF
	Iq6tKrkMSbxwQN+py4VajKLYUmbbhGuwTVWIpGz4QMSh8rXhAoLKCRgj4n+0/2IR86Iu9j54iJe
	WvUpN1QMJN5154EiauOXzc5M0yhA+Kx5C+kfC/jWvrEaiEbFPDM8S1jCmzKCM9MlF7mJUjw2aHd
	Ok9uIDjbu2UjnG8
X-Received: by 2002:a17:907:da16:b0:c21:752f:c3f7 with SMTP id a640c23a62f3a-c246a69f381mr715794866b.18.1787324313742;
        Fri, 21 Aug 2026 07:58:33 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589d9df9sm508540866b.1.2026.08.21.07.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:58:33 -0700 (PDT)
Message-ID: <72d250b0-74f6-46ba-a23a-2543dd4e16e5@ovn.org>
Date: Fri, 21 Aug 2026 16:58:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
To: Jamal Hadi Salim <jhs@mojatatu.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com,
 i.maximets@ovn.org
References: <20260819204210.23722-1-fw@strlen.de>
 <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
 <aoboL020DIcOn2lx@strlen.de>
 <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 1:58 PM, Jamal Hadi Salim wrote:
> 
>> And that doesn't solve BPF (can sit anywhere) or OVS (no idea here if
>> its affected or not).
> 
> OVS is very likely affected.
OVS should not be affected.  OVS doesn't allow arbitrary changes.
It can change mac/ip addresses or ports, but it can't change protocol
numbers or other things specific to a protocol in the original skb.
Unlike pedit or bpf that can just write data at random offsets.

The only way to dramatically change the packet is to push/pop a new
header like mpls or nsh, but that triggers a full packet re-parsing
and no metadata about the original packet should survive.  If it does,
that would be a bug in OVS.

Best regards, Ilya Maximets.

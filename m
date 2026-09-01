Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F146AA95
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247904; cv=none; b=KI+2Dft6IncfWC7VDZygNEI4Npw9mabmbsahct23nTwFFxJruDRfsKvu5BSGvf/DPvDUJKdyG0fFt9QobO7MniXvG2kuaHoiErgTHld+WZT1vaFMcdU1pAPeLcq0Ndz1EHSeaNYUp5QRi5XMvdkR2dSI7YOSDF2ARDT1BnPTxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247904; c=relaxed/simple;
	bh=zGhJ9HaYyZ7K+ijAn1Ufy6dOppFjBPbx8iBoOPASPKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2R8ygKUEjaPBieHI+27+mDn4b+UBwTjWYd7lfvdjpKfrH0XEQIC4qn1Ned3kg+ekD1YzxnEY91ynNbSGLM07xCEvlAu5Bsesq8OIslHWOnQ2NvyVsUvGpf7MUD4mhxX8/jTubnRjcAUbMW/32o1xiiHaIWmHJOo4t/EQcQebAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzgKZERY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uAWSDE9g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzgKZERY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uAWSDE9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788247900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=996Do7cli1wrzMhcoRVI4Dpnoxul8kFICpQpjRm0D38=;
	b=RzgKZERYlM4x/o0dIbfSWC+joLNqR8x+fJ/CuTIOR00iJ7eIRrx5Qow0ViQa77BjtP/4q3
	95ENdDiS2xeBFc/FR4Vb6OTt806vR3zH2TaZE2Nbo36W0LZgCaK8Mkjqv0ntUKP5qFDP4z
	dhIBNPRvIeduTfd5y2J7n/6L0gCZxH4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-MXTfo6nvOYi3hH7KIPy5pw-1; Tue, 01 Sept 2026 03:31:39 -0400
X-MC-Unique: MXTfo6nvOYi3hH7KIPy5pw-1
X-Mimecast-MFC-AGG-ID: MXTfo6nvOYi3hH7KIPy5pw_1788247898
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-499913d1a79so24513915e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 00:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788247898; x=1788852698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=996Do7cli1wrzMhcoRVI4Dpnoxul8kFICpQpjRm0D38=;
        b=uAWSDE9gTZaCtnNjCrRa0Cp47o69hAPjgpwpRhd8C2/bR+KAgqqz7raR/BZM7Jbsyv
         BWtFfQC5338IXnkaEic7YAJzCm82mqAlnpiBIQ//c6jR+Uh1JilL08lYdWmN5ZDitxsI
         AmaLSgRSGnzvub/8fDyf4Px/Z/bYEKZrNzKlWEckYOMh60C3/Y5Go6jMUxGml1pC1ryY
         lTydfSpNi+A/P264j2WdTIptcgLHVTyzLPCbV+/WeBfTGH2BNdMj+Rrx+fZ8ZZ/eC8E/
         154YD0uuMjrCy2ZuX17aNQ0Ga4YCgnfJ9e5qssVfeYxknrmnTrETQdcKM21EdMJW2X74
         OYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788247898; x=1788852698;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=996Do7cli1wrzMhcoRVI4Dpnoxul8kFICpQpjRm0D38=;
        b=IFJ0YJYLA8zBPPz2/kl+GW8/oNxZoJSnJGqj1PaqiWwUqIPQvX22KCABbHiZu776hb
         Wormp2+VWn4Ap5U9EtpL5o6AaWK/B8ivr0iTTHbhqKjO3KfMdCaqRVnfdLotjE252e3T
         j5BiNo10kLksNB/e//2Mtpqy2mAY0tQm/6tY6HyrPz0HdWKRyZ9hcGRtMHuDTR+ap4Ok
         7dU+Dn4LociXyCpJRtgVmTYBvM34BPlpszsVSf1YjC64GgyULOWqkRE5UbX8+aOIJYaD
         WL29WMgJEkslNoo6pFESuNY1xrlrMwCkJXQaJCWREMRQlt/qU19bahvzMOwkmQesHPGq
         8kQQ==
X-Forwarded-Encrypted: i=1; AHgh+RohHOvb0zHfEmuGxxfQaeifDhnS436qt3TpCji+Chn0lYcx/G0BZ+xNVeZcWyCgRGCe6Wf9qq8=@vger.kernel.org
X-Gm-Message-State: AFuF++nwTyCFmrOTAWUfwQAU5J7gbZMuMVUJ81Bf8eA4WCnyMBQLMdZv
	y2H1EUKxX5uJ0lErn+LfXfRk95zYAdM6X7/e+zaQ4G0A2z48bewdp72zsxB9SU/m/XhbDS9ojsK
	5qAMPTA4m8RGE+xmqRDqKZ4+9nBVS+gFbz909u+OlvYjtFlD4p3oEnrgPKQ==
X-Gm-Gg: AR+sD132y37OaTPbCFgp6aXXlUCHl2RzIvFEhRBHZOhxstH9W7oEFLHs8zezA4obK6Q
	f1oJ3n5m9TYCSHhrunRE8g0CryOLBaCJnT1QfiS6Gy5syslqZPR+EV09G+D/flSAS8Ywq3/x6pc
	82mGaUhVEHR8M0OVfzPzSvVnLYpLyjLvna3J8qPjZpmkKIOG8o+j2nefT+rfwBhzroY01PKT95c
	PWTBzpq9nBeVGMl8HeCt5fpmdQeTEUPxCr3TrU72PESPmYA6M5uA3+Pw1pEMXx6RV7zbB5mX7lj
	SuTXmYwUQhtUunyBGyMMItPffFCs3F16vVHO/ke2w00k6vwTE3wWPeFsVqnc0dBJl7mNYtHRkF7
	3ryiShBalalpUgEj3LMmxZ3WE8x2bg/06yBWRQH3DcF2VeD3sujakU5EKNo0cdF+a/XpD5xtIVQ
	==
X-Received: by 2002:a05:600c:a114:b0:49b:9438:7785 with SMTP id 5b1f17b1804b1-49cdc429f02mr92591465e9.4.1788247892921;
        Tue, 01 Sep 2026 00:31:32 -0700 (PDT)
X-Received: by 2002:a05:600c:a114:b0:49b:9438:7785 with SMTP id 5b1f17b1804b1-49cdc429f02mr92579265e9.4.1788247886584;
        Tue, 01 Sep 2026 00:31:26 -0700 (PDT)
Received: from [192.168.188.103] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10f08sm49011395e9.7.2026.09.01.00.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 00:31:25 -0700 (PDT)
Message-ID: <3b647dc9-6653-4a75-b0f9-d934337ac2ef@redhat.com>
Date: Tue, 1 Sep 2026 09:31:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] A Syzbot-style Platform for Verifying and Fixing
 LLM-reported Bugs
To: Guenter Roeck <linux@roeck-us.net>, Yuan Tan <yuantan098@gmail.com>,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, workflows@vger.kernel.org,
 frankw@nebusec.ai, jhs@mojatatu.com, ksummit@lists.linux.dev,
 kuba@kernel.org, kerneljasonxing@gmail.com, roman.gushchin@linux.dev,
 jgg@nvidia.com, mchehab+huawei@kernel.org, torvalds@linux-foundation.org,
 ben.copeland@linaro.org, gregkh@linuxfoundation.org
References: <20260830115546.3942129-1-yuantan098@gmail.com>
 <98d4603b-0559-46ea-8b76-1f0245b3b266@roeck-us.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <98d4603b-0559-46ea-8b76-1f0245b3b266@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 9:08 PM, Guenter Roeck wrote:
> On 8/30/26 04:55, Yuan Tan wrote:
>> LLM-powered tools such as Sashiko and Claskiko produce a significant number
> 
> Is "Claskiko" misspelled ? I don't find a reference to it.
Clashiko is the "informal" name for the sashiko instance running on the
networking subsystem CI. Since it's ongoing under constant improvements
and changes due to a lot of effort from Jakub, there is no formal
documentation on it.

/P


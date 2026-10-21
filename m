Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591640;
	b=2nDWtlS2+LWJ/7UXkhw4HPZITZebyTSTDUvivdaB9ZxnK7kSFplUEPy/YKfi1WJShfsD
	 EoDHLC89/8M+KRWsz4qbmlhihdEbSfPpYDqU2MeyhRqZ1bl0L/K3cqftR3lsQi1uQg/R9
	 e0J7rG7r7sCMUBQ8cfH9hg0vgZ4zMFx1anwDR+V56p4YmHbImQW9UAYbbC89mKsYXejgA
	 MJ97wyGMBwYijSXX5rE6ePTZpbjMn9b5nHugUM9sI/c8mof6mD1ur4umfqDCh1KM7dCxq
	 OPhlCRJg2p65SboNImCtyCjoqbXNKhI7hpgbX/GqXsY0T9c3TLgK43pojVBJukXNzDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591640;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=h/tGrN3vAXkF4xhrgSHBlBodyDLosDfdLftjO+4g2gc=;
	b=hdpyn2zIazSA57A5BNXovZliuShUHkcU1lOzHd5KbKePXT/wz5FCH7m67EevmP9cTjSU
	 Xs+bKlhARze+oZzTSpB6fUdc5vTgHv/D8VcpulchIK6tTGDi/X6QPiyunWy4oudBk3C6B
	 SQ8fI9SBCHUVnteRnpY7umA4Nuares/71C+gHUpjdwmgITOgku5pFC/FLYPkHncNb9BW5
	 Ty3MtIr3DYQ/+EuQ+P1e4zIqqT8IqQ+mCbzgTUtKp65zWiFqHEVn64NTh+dStaKPUfb7s
	 sDRncYUiqNgKbU4LRkquk2Ini77puvndosh7JsWOWwMNH2KikA18YH/KVl7FfKR+ePg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0XjNcTo;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ICya3PFH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B3606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 630B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0XjNcTo;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ICya3PFH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792591639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/tGrN3vAXkF4xhrgSHBlBodyDLosDfdLftjO+4g2gc=;
	b=M0XjNcToZKDSfxY/tHyI6aZaRrgmBFVevA/9gi9nj+qLTRLX+Y2G57B3JoNUru8hOxq8pO
	gkR17MYlIZsn3VVlS0TcSVsoof1D0JLV/JNRwEQhPb+pZLarvIkRdCKNN6jS75ApRRImz2
	E/KgEfuE6uSep6i/yVrHrjjJEzug5Bk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-sLT5WDCcMaeKC3NReLc56w-1; Wed, 21 Oct 2026 10:07:17 -0400
X-MC-Unique: sLT5WDCcMaeKC3NReLc56w-1
X-Mimecast-MFC-AGG-ID: sLT5WDCcMaeKC3NReLc56w_1792591636
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1e6ae710bso5781725e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792591636; x=1793196436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h/tGrN3vAXkF4xhrgSHBlBodyDLosDfdLftjO+4g2gc=;
        b=ICya3PFHeEiJVbCqIlM1d3igLwyeROOovbEBd3dIz12J1Fowl2gZUgMRvhhvjYS+dN
         3etkTZmimg37gv4VBGJpB/mflkHWBeuHFPADjBxMVcH6VysPITL/9DYKWtBB6mDmFgXN
         vhCxfJrQpJ+kpVwkGtKHhSO5cm5/47v6YVex7i5w+bqWtwu/tKFwfPKEZZxln2pG9cN3
         JYbXRJoPACLsEVkwFAmQhfcoMvICudpi8qKPfLLrXrbjin+F6Bsl9YCQeKEJQjSnZ9gx
         pT+hEw8A85P+42Xftxt9xGiNJL/WMm2lxfSWHGRqEnlI/VMqeu935m01Ot94gS8As+T4
         +MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591636; x=1793196436;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h/tGrN3vAXkF4xhrgSHBlBodyDLosDfdLftjO+4g2gc=;
        b=UHQDedTHVe3UjLazuqBb8q0jWylDNETWoUS/WuXwF8kSzvjprtnloZHgKz39kiy9c3
         nTWwvtT2fq4Vk44E5oyH/ScRbLPN981bF9tGTtdNlrwd7u+zBwgepnv3FySO9phqpPCU
         DmnfMv5+rD81QspjMUZgW6ioC2k19pvqOcgSihdGajyIqTwD3RVJf3BYUl/32rwbgFrB
         xq7wS37MzseWiI/WHmus2bDbD6MBjv3kCMFnQlgrtSuXlo+whe7mJBWU75AfO+zEXRzP
         Yp2sX3vIHUqdAwk31fP/b3Y2GqEFrO0hX3ra1C3vMkPrpB6mDyUG5+0HRyBjB960AcEd
         7f3g==
X-Forwarded-Encrypted: i=1; AKwUvBwpdfwyzeuq/oN+XLD+IIYn1OgsV4acvooA3NvmLh4T5vTlQyaPj7/ChFa/E+G54VwZEpG0QM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1JCQrEgXc3P2SfLjCoUnLU5ODxq8j5oa5ZQmNx43lWKptmdJj
	Kf4i3oOxjkez56Rn0XltMXmTzKkn+71yD5oRFsr1O1snQ9TI9CYWddgDPHCKmB/0sHfGvB4M4lA
	rB0GSwZTcGSASqWK2N+e6xW6WU0WrD7dSuxnjAjnblCcgWKc/uz7X1Zn4bA==
X-Gm-Gg: AYBFou2qCYfdVeR1+ON0m9SLzK0Fitd0Jw2TsxDDG71Cv3vC5ulvjDxo4O2jT7e/XwL
	jiX/UORPSToSAuiUivTa1dj7+Z6vIHfqeJXnjXNbpltJB4b/Kzkf6VqBljIP/kilY30aBYQNARY
	YtrBOLxuj4nurHOt4rbKav5ePLsbCzOWX2NIwauzYDzC6QWrf7+ShUxjYDtaGXf+Os1jprhKHdl
	qsEtMdTE0ZhYJcSD5wjvipGblvjk3+MxrcZR7zIPFJWt8p3QHUIW/OshLFsDtwmNCnaN55sU5hd
	ZvAsrRmja64fRGkuRa9lzPB/b8p3RdS2NRSAMABYgGf3rSIwnkgHvGYX9OaKvPoI7AgI8EKiq11
	G9ILHS+ffeprygHUZokQA1uJmHOeyK6IAVCbeu/7AQCa4bBAe/lLjXQLLdXomvc02SL2vrJK65A
	==
X-Received: by 2002:a05:600c:3f0c:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-4a1fdd39fbamr45861785e9.28.1792591636243;
        Wed, 21 Oct 2026 07:07:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0c:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-4a1fdd39fbamr45861165e9.28.1792591635848;
        Wed, 21 Oct 2026 07:07:15 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fe5239e9sm43986055e9.0.2026.10.21.07.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:07:15 -0700 (PDT)
Message-ID: <08a71c7d-d5ba-48ee-b80c-7997d07e6e22@redhat.com>
Date: Wed, 21 Oct 2026 16:07:14 +0200
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
Subject: Re: [PATCH net-next v2 3/3] net: ethernet: qualcomm: ppe: Add IPQ5332
 support
To: Til Kaiser <mail@tk154.de>, sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org
References: <20261016152449.934312-1-mail@tk154.de>
 <20261016152449.934312-4-mail@tk154.de> <sashiko-outbox-175580@kernel.org>
 <c40f4d8f-223c-441b-901e-5bea5bcb612e@tk154.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c40f4d8f-223c-441b-901e-5bea5bcb612e@tk154.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 20:37, Til Kaiser wrote:
> On 10/17/26 5:25 PM, sashiko-bot@kernel.org wrote:
>>
>> [Severity: High]
>> Does ppe_config_qm() calculate the multicast queue register address correctly
>> when queue_id is >= 256?
>>
>> In ppe_config_qm(), the code calculates the address like this:
>>
>> 			} else {
>> 				reg = PPE_AC_MULTICAST_QUEUE_CFG_TBL_ADDR +
>> 				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC * queue_id;
>>
>> Since queue_id ranges from 256 to 299 for multicast queues, and is not offset
>> by 256 (PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES) before multiplication, does this
>> result in an out-of-bounds address calculation?
>>
> 
> This is the pre-existing issue you identified in v1, affecting IPQ9574 as well.
> I submitted the fix separately to net:
> https://lore.kernel.org/all/20261016150140.929729-2-mail@tk154.de/
> 
> I could also mention this in the commit message or add the link to the net series
> in the cover letter.

Please note that you could/should ignore reports from the global sashiko instance,
and look at the nipa ones (clashiko)
The feedback from the global sashiko instance is incorporated and validated by other
models (which already discarded the above concern).

This series does not apply cleanly to net-next anymore. You need to rebase and
repost. Please note that the repost MUST wait for the end of the merge window.

/P


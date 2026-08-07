Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64556332EA2
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111902; cv=none; b=kkfujgXl34E3uJXTSBIDs/oiBsARuz0Z1/jD5jVYzNAQYrpDv9DN+X0i+NjoNj7Bx5AdcDKn7RbBmXn84euIsMdzDuaT8ey3uSpbBVLnep0WpPQIpuZBA5gmNf9JymD+mXw+G0uv2KNAXVE6k8xtRzbG4SBamIkQkEnoWxFtyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111902; c=relaxed/simple;
	bh=0W4fKAHbM+UE8Xc3sDu3vU6dgMyazOqlQbZUbA/JbWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjGSbdgnJr6/x0qP/ZjU8NEyv6RFK5Mf7lI9l8AwYen99QysTZfFfwVzxFDiJqtaKBWQAdjfyupH1Ax0tsHSPjGzrXK6LDDsSqOfd5slElnIeomxOPF2oeoZgxL+6LcXaFVlSaao21cIqOy1BwBWiLA7TLYW9cRbDi2unY5Dw2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XdR4O5xb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gHaimQ63; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XdR4O5xb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gHaimQ63"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgInT943008
	for <netdev@vger.kernel.org>; Fri, 7 Aug 2026 14:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jY/yOsvpc9aWjuEvUxwTi0KWtinXasaO3wK8pTemGEY=; b=XdR4O5xb7tobtL3Z
	w38JXbrqD/s5ZITebXeCQBNbWDhlxZFelzyFSR+mmHn+JQNctTe6yt7gmtIjH4ch
	wBYsPymzjHh1P+lw4UyxcfAv0lJWGI7r+7IRDsrJTbF8X2rz3dgly0+a4J/GlsZo
	V9cgcG7QwGzooIDmngRCgxEyD2ZkqHVwCD5De4/O4lsfrAxJa7q+ZreHCAHvEU2/
	LQNocv9NrrJB/+uKWW+hKB1ARfUULSi05u6d77XFGBk3rAcgCvURgPBOVR+CdyOk
	1UWcuP8GP/mNWQ2nKvEMIH37b8qTtivfD+ue0Ig9saO7rOQREGC+KdCjebYex3hN
	lNgjcQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hcahb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 14:11:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d02df2bf09so41715925ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786111897; x=1786716697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jY/yOsvpc9aWjuEvUxwTi0KWtinXasaO3wK8pTemGEY=;
        b=gHaimQ63SEnhgeOGBrYxRclaPDCFst/+iEuAHUR4QiotA1XAQlYiSNfkvO+eWaBDUr
         3b2usUJPDki/l5eq5C9AQkM2iM3f6AoNewbEPeYsVaaUkMeCzLlrzN6bgUeoAYRKGcA8
         ARXxE5jbXt69KC51l+tW/6qqobj+XiQRMN4OJ5DOAbU+NpVqPKUvNjwZlgsvhqJMO4wy
         OgnaW6/4r+w1n9b7Fr0acNVaOBVfSrzeJLKH+WI2qbGCC3Rr4yrOAO5eDTA4g8a+kKJS
         sTNNsd3hIRGARGlYZbGeDYmREm9XAJ7TJfiduXLfH4dGo4IeIgALxdlryD569U0SryEf
         oJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111897; x=1786716697;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jY/yOsvpc9aWjuEvUxwTi0KWtinXasaO3wK8pTemGEY=;
        b=iKQwo1tYy6QBtyYgY43AWIkxjknOAQtJ35UW+wNzkPIfBq29FBS8DtCa4SfSkP7ywV
         G717t0GbOstW3QMxa8JffhOFEhH5giq0MRJwA1puZc9kcboF9uyUTcnT2DTPU84CbHZa
         VUPmhiLZn9lWRMP1JQJosF94w3rlg1g/ZhYphSs08691y1ocyEZj83REBadqoeIj9baB
         TAi9aCB1BNo655/VH84NYGbEIYVPU2pIw0jxKUy/7/IisH4maAV7OqSVzsWpXNLr2nQF
         b5C9lYgoKw3SIkB90uWflw/NVPVPPp1H3qA2qj4gOgZWM0fzTx9ywDhd4JLmlpusqmwf
         ltYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXn+wV7yCH49NUrtFj3YiX435m7EKcj75nMNEVx7D0rxrunL53mHIoIgcvmF9/inE2P0i0kuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ULw4eWK6Cs8zOvr/yPK9LFAi7dcrWnwG3+r8cFyWkKCx1PUx
	/hbs01N5YGHIrfUayG+/kMZlTL/c79B3YjhfN80Q9ica49vTIBMGEV6ZFIN0/zLEebo4L+K5Ecj
	dv44arw42+BKT4GsMouu3buStNu3obExo6tNfZ4MKVNJnMHRAd/2RrXb0IGg=
X-Gm-Gg: AR+sD12uG5FHum7Z3bkSI2Ee3BDkAfdPiM2BVkPvCdLE1GSw0HjiRxyKEKz0T4tyKWn
	ZtlSCg3hSvaOml+A82X5TXMEw91NTaMSp6pmSoXTkXCSF9ecPz/B3QFzmv+qOX7x8IKF80kU0G3
	4faoJr8CdGAoSo+1muCVqiksLrf/AW+Kf44aDaYcpiYdqNJPXdRZpCcqsvu4yorEk8momi3zVph
	rpuHgLUgKpqwOBJ3g9LbkIEYwENdSA860XLTtdpG1x98lgSInUawVtGq4fE0EwTXwiTjYsjUE6J
	D0nwSZXeIYdAnbEKQHehD5NUl6IVfGSdzNW9oB5h14kKPFjSj1HTP0Fr6f7Icm1gtkrxnK1gFMk
	LjEf3sD6eFfiyMsAJYkWDeHQgXJqVQYlBWBXlCbNREE0H8nZ9jksropxP51l7
X-Received: by 2002:a17:903:46c6:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d0ca713b0dmr274945785ad.6.1786111896722;
        Fri, 07 Aug 2026 07:11:36 -0700 (PDT)
X-Received: by 2002:a17:903:46c6:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d0ca713b0dmr274945125ad.6.1786111896262;
        Fri, 07 Aug 2026 07:11:36 -0700 (PDT)
Received: from [192.168.1.20] (103.sub-97-215-187.myvzw.com. [97.215.187.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14d57f8b7sm10026305ad.30.2026.08.07.07.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:11:35 -0700 (PDT)
Message-ID: <2480a569-de5f-4d91-9b9f-60a46613e5ef@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 07:11:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: __free usage
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Ally Heev <allyheev@gmail.com>, linux-kernel@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
 <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-0ddc81be6a4c@gmail.com>
 <72754805-575c-4568-9dab-514e1b758847@oss.qualcomm.com>
 <ae840989-03df-4e84-a9cc-46c51f6dd44e@oss.qualcomm.com>
 <8f35edd6-6b37-4575-8a30-558ae0dee0bd@intel.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8f35edd6-6b37-4575-8a30-558ae0dee0bd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bGjtBfan6nTvALGjWodR2EGNnbRP5Trn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMSBTYWx0ZWRfX/3Yw+xDc6Nui
 Au0jMXB+Dr+LuZRI5p9lS2CgUDz1YZQwtII9DgTpMxTfAj0+VMmukO9ppFprnEZxiVPgiXyxop/
 ndqKFujbsCkG26pTx9ODjOKTjRKOkiORcZ+ulfjsBwBodLHvEKiOLCxh3X8eAlcJPSFQDmgJMdx
 MrtRdnx2EKM1xvE21Hfb9FqRqPflnnIXNVNUAkBZ1teBctYLZ9kMnJtEetYUZLvC5UhKLsCGzcU
 Lm3xoir+mhq537d7nLgQRBJyCtm3EZNX/XCkiqwJ0n8P4NDdYQofSYrs8GcsOIM5RZV/78YRVBs
 GaEkmvZRCjbOhUFtD0NwI6cCEkLFsFCgHKmxlk3FfBRlzgGkg57+a6GSIt6/Un+F55IpoGrjDVA
 ElifCfeXRIB0K4bJxb5Jhdf2wGALksMNGu+dc86r66nStXn1IrqBOfvP2yr1PsezrGC6HQFI3TN
 sQQU4AK++0gpDXw+7uQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMSBTYWx0ZWRfXxfPgDoXOWbvX
 JRSQ/gPaqSCKbgwZa6xbMipjdIuKazSJ948WMAtKFsRtaDTUFVbDmgkGEJaKbYqGEr8XXRAI14/
 4Q5k2xf9Vy0DFxTFLWjNwjCo0xCXUgk=
X-Proofpoint-ORIG-GUID: bGjtBfan6nTvALGjWodR2EGNnbRP5Trn
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75e799 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=UaEkX0D7FlC0tWE/LoNF7Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=XQPYAtKPP1igbtPNMl0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070111

On 8/5/2026 4:56 AM, Przemek Kitszel wrote:
> On 8/5/26 00:56, Jeff Johnson via Intel-wired-lan wrote:
>> On 8/4/2026 3:54 PM, Jeff Johnson wrote:
>>> On 11/16/2025 7:56 AM, Ally Heev wrote:
>>>> usage of cleanup attributes is discouraged in net [1], achieve cleanup
>>>> using goto. In this patch though, only uninitialized pointers with __free
>>>> attribute are cleaned as they can cause undefined behavior when they
>>>> go out of scope
>>>>
>>>> Suggested-by: Simon Horman <horms@kernel.org>
>>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
>>>> Signed-off-by: Ally Heev <allyheev@gmail.com>
>>>>
>>>> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
>>>
>>> <SMH>
>>>
>>> If using __free() *correctly* gives more readable code, why wouldn't we do it?
>>>
>>> The only problem with this function is that it doesn't follow the guidance
>>> from cleanup.h:
>>>
>>>   * the recommendation is to always define and assign variables in one
>>>   * statement and not group variable definitions at the top of the
>>>   * function when __free() is used.
>> OMG, not sure why Thunderbird showed this as a recent unread e-mail.
>> Please ignore this noise!
> 
> always happy to see some __free() advocates :)
> 
> perhaps with our new meticulous friend Sashiko __free() would not be
> misused anymore, especially if we let them know the following quote:
> 
>  > So just make the rule be that __free() without an assignment is 
> simply > a bug.
>  >               Linus
> 
> and the resulting "less code" is always better (if only to fit more
> data into the AI context window)

There are unfortunately some uses of __free() that require a NULL assignment,
namely when the allocation is passed back via  a ** argument -- see
__free(firmware). But for all the rest it would be good to have the
consistency. Anything to help reduce often buggy cleanup gotos.

/jeff

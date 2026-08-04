Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D89340A4D
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884223; cv=none; b=ahGdpnluSUT3tfA6JQTGEEEBxqepdrrxoTcGme2NyIXAZOYIURFNw3F+r4dW3cTK9Yv0sPrGNOEpJcjbJQfGOQvUMSXl0BwRWDSITjBVbVcEd5pCDDuvYTiW1RrjQe+xFVrh6elEsSSJMLzrtwmYcB3qBZeWksPhp8eKY/eRrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884223; c=relaxed/simple;
	bh=tSfz8srOomVUDPH8yzvTvx6H8M7em9SB5/usVBmQwmE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t4NW0UAP5/BIFdcINIWkJ5rGh/dW4CtAmeTEmTsN3lT0Qo1/CBQ/Duywh6TYY4VmaQjLHCnXg5avQZveVW29QobE0mprTzlRuGQtFbt1zeGH0sGVpT0R/k6uzJbouVlmtPdzDqAWuUXzgYLjiLD3kBXQgtEwTSITZv/lNeDiPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XwMaLr3f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=arlJTk5N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwMaLr3f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="arlJTk5N"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JlQUd770606
	for <netdev@vger.kernel.org>; Tue, 4 Aug 2026 22:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ze+t3K72EfpnZ5n3KGC63Upnzdy1PBzuoQci45pXTyg=; b=XwMaLr3fU6uwVKYY
	bkJcQUcNI0/QzsFDSOk9Z5aac5JiEOt2YP5ultnN+dmbKRez5r0GKzC4dMz04LRv
	cZsnKb+ghYEPiAkx3+KB3yuWMeIBxySK1kdCLmeJ5ahpERknKHCtL/MmwcYYVzfw
	1r6aOnUEtlg2iPdlvgrJ7RptbXg97JBEI0nqr3eH2tkYpPGe1VhifTnXjsEY1eXH
	v2tq6o9+s8gBQt+7UISsbzKh0Fqj0HsJDppG7s9lo8iwcJsLMk3J/0/t/W0ZAFhs
	T4flNGIO5LsqswYJwmx46pD53bPwFR/7VoPNOH8OPtTbn1d5s7dvAV9Jmb+DOtnH
	V9yEQQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum56hgfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 22:57:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so485334a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785884221; x=1786489021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ze+t3K72EfpnZ5n3KGC63Upnzdy1PBzuoQci45pXTyg=;
        b=arlJTk5NJSroE1kWRQKO3EXVacrTb4ves/BwLSUtASxEHfpqKMxy8E3lcpr2ErRfsU
         hGNBYOp6uJqNbxFeJMyoh4AHPgOgmeRn1Jpzehgrdk6FNcpPJ3UpMBLVQTLpUb3lRqCl
         kKVy0n3w3xIeeqGeBdGizcPYcKp1gT1lQPzsXvfsXQEdnGpP0FuM7AxBEWCNAdVYjXf1
         5Ved+cs5Z/55+EzwhH7NbDJP+cG98PDNew00PjDhrtl1ZRUbC7hB1PsSoywwTwkoFgnn
         lNLG+5/EIU+vt/tY3pZvICXkMdOjqgkLGfUFdU5goYr2VekLPS8NoVRhnWlK26Lp6DS8
         tUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785884221; x=1786489021;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ze+t3K72EfpnZ5n3KGC63Upnzdy1PBzuoQci45pXTyg=;
        b=SKOPxQ4bcan+l0FvYffKHTd+ZF5iaQa0UvLV2T6fyyWNUL8bBkPq7xkT7nZQNwRQBf
         6Nr4imvYRSGKA4voQoEqdSp9LvbsOMFGHWgtREWAtZCm/QPdIuYR623tVr6OpxZGhDUY
         tG6rZCq0xLdKytz7A3TZ7zXn8r6/GzgP7De+TKGyFy1Wyq1UDaCE4Dfzw36cMJ9NqBcu
         udNFkR5SjMpt4dkDLiBeM3xp7/ruX80n8KgASRrgFO51+36WC03z3+VXtnMgqMaDBm4g
         XGdC4g4zEnrCwrnJWfUeBkAQEJMRgpSeobEjyOaZcLJWfZghxRbCNzfKxlLARcOO03tB
         s52Q==
X-Forwarded-Encrypted: i=1; AHgh+RpHgehrJzfZyM5l52ENGMhWzgLdbzuGh5VS2utBEgpe24VBzkPfd8OVakghNMCHxtWLnk9eTSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweK1KKHJUdqV9Hs0mhB5JhUDepwyn898AAHFvLzNcZCCZZ4+99
	v0pbIT7H8u/B5GBtSuo5ubzF0tcyUJAlU8zq4XNq5Wg+uNnb2Igwb7+BY+mwuEa8BKXIbmAIY3M
	NRyaEDKc+Zp8P8DVswmicfZNFPp6R48TG6urptLseDcNOg3zIOyybDWqIy2E=
X-Gm-Gg: AR+sD138NTOOKVQ3X8qh1janBzudQosTr5OhZTQGKh1zI3PdbgrKyH2NEtyy+cH0VDd
	MoTgNsx7vjR5FlmyQane1J6TDI2iQmGv6ZcTg9T8O533Q2m7Crsjx6VgziRGY68m3Su4jbfqT7Y
	dXmFiD/hvUrIKvjOZjiPMqPXjtyi8e5cP0Cj1zmcH26GnF77RkXQkktSlbX/eUS82J45+ytIp6e
	BU1NVZZsnh0pr2GNDnUAW3mKhqKts6OR393SinqJOUk3PU4EOgmnRTtU/hSyY6if+jxXT3XvfOL
	rADAuuVyUC73f9ZO+7qvkuOHNbB7czKIPdUWCOywt8sua33A/NsVhu2jSvlLj6PCMe3IPTSZt5I
	TlBeXF6757jypRl+7RBCBPCoLuMrQ/fX+dIiOPeT2RxMr4WBc5eiFCZLQbJkk
X-Received: by 2002:a17:90b:5683:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-3903c54fbc4mr2149351a91.5.1785884221152;
        Tue, 04 Aug 2026 15:57:01 -0700 (PDT)
X-Received: by 2002:a17:90b:5683:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-3903c54fbc4mr2149303a91.5.1785884220637;
        Tue, 04 Aug 2026 15:57:00 -0700 (PDT)
Received: from [192.168.1.20] (103.sub-97-215-187.myvzw.com. [97.215.187.103])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586447d52sm8118099eec.12.2026.08.04.15.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 15:56:59 -0700 (PDT)
Message-ID: <ae840989-03df-4e84-a9cc-46c51f6dd44e@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:56:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT net-next 2/2] idpf: remove __free usage in
 idpf_virtchnl
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Ally Heev <allyheev@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
 <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-0ddc81be6a4c@gmail.com>
 <72754805-575c-4568-9dab-514e1b758847@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <72754805-575c-4568-9dab-514e1b758847@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aOQnu2wiScfJJd_9H-A3FncGMuGPB6Lw
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=6a726e3d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=UaEkX0D7FlC0tWE/LoNF7Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=sb2gSEF-3ozDpBDae7EA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE4NyBTYWx0ZWRfXx9MZq0YlCISR
 edfJyN7sDBuZRjqy2sLfLpDL5Kp2eOGA2QcXQd638WuKDOO1TPKwTDrB7SgeZmPPKMW9lcuTR6l
 vYMAV+oFu+KMnWQZ6IfOXwtNCOgVLlw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE4NyBTYWx0ZWRfXwRhwA6jGEr/c
 dGVroDBA1q9ZmNedkhoCG2yYLSpRlPIR7EwR2oWowyKw/Bi8PZJ1k1P/PmNuMMKdMaWrZ2Is3N1
 qZHZXNhNTLyYII5113PEtx5YlR1Fq/yEjdRbI9wkk8F5MjeGqIv3Bao5ei1SMytGK8M43UZ+/pi
 Q0pED+/pn1eGdy6DInzXo+YrqYzX6waMCk0UE403sH7bd5kzSLkK13QCcK0rsbZNjmaIWJGjtAz
 NyaFaMg2Vy9dxl69DT35Z4HE9cSYuBzdQY1PpEKpatcDNbiEj+7Z5+faH0mveUPvNpTFNPYIrme
 vKKTs9xCU1ldtlzSZj/PWSH15zuzi6rR13bc9fhnP167QNha5YJ1yQ/umE955tlFxblO6j0in9O
 qVQMmTwBQgZm2TnWH3mK94UBUUuiwrFNuXRdxBzRGClCVoyMK4by9cLXPVcdXaqv9xXre1jLhEa
 BDWswPo/VFfH2nDDbVw==
X-Proofpoint-GUID: aOQnu2wiScfJJd_9H-A3FncGMuGPB6Lw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040187

On 8/4/2026 3:54 PM, Jeff Johnson wrote:
> On 11/16/2025 7:56 AM, Ally Heev wrote:
>> usage of cleanup attributes is discouraged in net [1], achieve cleanup
>> using goto. In this patch though, only uninitialized pointers with __free
>> attribute are cleaned as they can cause undefined behavior when they
>> go out of scope
>>
>> Suggested-by: Simon Horman <horms@kernel.org>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
>> Signed-off-by: Ally Heev <allyheev@gmail.com>
>>
>> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
> 
> <SMH>
> 
> If using __free() *correctly* gives more readable code, why wouldn't we do it?
> 
> The only problem with this function is that it doesn't follow the guidance
> from cleanup.h:
> 
>  * the recommendation is to always define and assign variables in one
>  * statement and not group variable definitions at the top of the
>  * function when __free() is used.
OMG, not sure why Thunderbird showed this as a recent unread e-mail.
Please ignore this noise!

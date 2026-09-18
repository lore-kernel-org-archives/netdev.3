Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7E4CCDC7
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728748; cv=none; b=dGCrc+zTSagQFqMkw3YdgA7KzxwAJ3nr/UYgKxpSa9lG0L/apKsB6RYDlevUIPZLWyEj1ILxZyeV54tzRzeHIt/DpOM4wSvCde1sMvae8+lAmUckEL/SniIBKcVWOsJsjJmNjrRKhE1RJiCf2Nr6hm/ZqEx0EvrW9E5aXFfkv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728748; c=relaxed/simple;
	bh=KmN1ZuicIl3zQnKA23ZR6JOVKKX7TbTIEnZT1K3ikZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6q3DAL6MLHaY29UD9yHvfxsfh17r4W8MoCSposYwL46vAFwJwQI7GFdG4IXTvHcF+RMmWsS+5rAUYi4X538XY480gZb989xPvjFmBtHKJvfVsqgXQqjR3vQwwmEvFe//teyBzzeaDdvgYYX40Q0+ki/umvzrx6sockudOP6Kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LNyehHMm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RFXxIIgT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LNyehHMm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RFXxIIgT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9dXX0860477
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmN1ZuicIl3zQnKA23ZR6JOVKKX7TbTIEnZT1K3ikZI=; b=LNyehHMmb+JfDwnk
	sBDEIrsc97u5Id9GEQVz82GsTG1DwAl5yduCOUaw0ROZDq2FkAyDN8aRnHadQMeg
	b2HH3DztU9KKK4bbVrUCTGdz/yjeHECsZvLwpQXp7LTGcIP7NJMAaao0B4ZsvzMH
	IIPC+RIYbULQlaQU17BNBAZKZmdBx3APYpoF5KrUX9p0CcNg6S6ECrxMbVEHUupz
	XAmkBPTjJa6N3xJvcBBWdyubmXmnenonutrStYGlbpLXX9mgpiJnt1A08ee7vqm4
	36Dwh7XZv80y4vjjbDI5dXxtn7gpC1zJ2XHfc5BPj40/w6KUAkju5YGuVeiX9kEA
	j/UpmA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs2hv8bx8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:52:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso798059a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789728744; x=1790333544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmN1ZuicIl3zQnKA23ZR6JOVKKX7TbTIEnZT1K3ikZI=;
        b=RFXxIIgT8TFnpVSk0DzhFS1+AVrzQ7GE4VLoPhFEYEDfOJx8WRN639hcxu8t+4eYRu
         K+507eV8d9Gbt3dl21NbG/DPtlwEFFm/PmIuhgbypF1V2VVzVaOX/5J2Qw9p14xp4+01
         DLYwN0n5Ax9gblx6ttsN1GA+vuDINyGEzlprOBV6+fXjaTs+xyhmVZ5rDPgiTSq70fTw
         cCLr1PIXgPw3bbyy/KPDhfq4TPCVuLc3JXnzZbYO6aoblLYfNEtFHnLIHVp7RnJLr4Xf
         HXe0N4kCumvVERXsnBXOhXdk6o32Mp8WMNhrV1QIrhJgRj7nlgUPZFJ4xzQ/yiI4X9rX
         G/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789728744; x=1790333544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmN1ZuicIl3zQnKA23ZR6JOVKKX7TbTIEnZT1K3ikZI=;
        b=hIlHNhwYLK/q4Psls4JmEz7EnXW0lzUNdTVIZxRhaSwPZIQkU7nHGgbSMlIurxcrvA
         aQOLlzS9ykeOb1p8sGGa3mbSZGVsvSIgrJvqxJajLvw0XRI3g/txDj4ngBapJCg3S2lP
         E4HQecioUafmGhe1L0SzwnSIVy4jXmiH9pfW93rjHu2OGPcKXyPjanvstmuR0Na2gJWS
         640SqXaG7kedIH3zqtjbfmjpdPmwy7DBmUgBm9hTWZyC2qUTKsaqK640VmOof+A8hS5s
         NbOdjlpwK0xX42ELHvVWS/4zLQfxLT39eCN4uD5WqWFFpMOYrA2jQUjfAtEgpUD75rNZ
         zkbg==
X-Forwarded-Encrypted: i=1; AKwUvBxKH8pZGb3aoIdMvKQHaLY6UXz6ULCvy9jOMjbkGExo7FDXQ4xaavv+AsdwKAxvA458hxEB/Fo=@vger.kernel.org
X-Gm-Message-State: AFuF++l52SM0iC4KgP5wFfOg6Ce9OEeI/uwtnsifxQdj2JAXkS6Wo8GQ
	gpxJJes57CGQyNfzfSR3V0gbA7Drou28JBVOgwiiWXdxzI+oE0pRddp+9GEBYyWIZJEFtGEa0Mf
	q4ZPM3roC9Kaa3NuNhzTX9pCydgwmA3cbyx1iLQigvdln4hxyRFR89liPhv2bKvwAlYE=
X-Gm-Gg: AYBFou3ujfhyGgi+1tTF9+mTvB1jqXdFDrH6JEZq86TcQ1CQpa8D4K2Opt6orMT4S93
	h0h1VV1m/Q0IbdBykcbpDMdhncpVCBeyNsLHJnjPop+8znZMrc6AP7iyQyG81IbxFzoTuV4Ujxh
	MmO7MLa0bvZEbGQnDeuLTfWY7DFlezXGyJ2lQa3yF5ot+CFPTJfSqtJEGrFEbruPk01xWXcD8SB
	auhCp2T9ZY5fP3HYkRg9wZXQSmtS8wwOGbwlI6rX/8eIEajgzyA1cO3gmcpxlM2U8yPZ1XE0Fpa
	ghyglRYYZ719L74A8kepXMwQSI/nwy3G7ymvPX3UdcTJ4Sg2zruhnUUiu0bgdhweQdb65ZdItuv
	vPhHzHXQ7fBjrMuJ0YtsEZ0mBsozJKgHQSQ==
X-Received: by 2002:a05:6a20:6f09:b0:3d0:abdb:de03 with SMTP id adf61e73a8af0-3dd8c3f26a2mr4358671637.2.1789728743851;
        Fri, 18 Sep 2026 03:52:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f09:b0:3d0:abdb:de03 with SMTP id adf61e73a8af0-3dd8c3f26a2mr4358630637.2.1789728743466;
        Fri, 18 Sep 2026 03:52:23 -0700 (PDT)
Received: from [10.218.42.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b023bsm4369596eec.23.2026.09.18.03.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 03:52:23 -0700 (PDT)
Message-ID: <6e314a3f-c73c-461b-86c7-472ef02e440a@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 16:22:16 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] bus: mhi: host: mhi_phc: Add support for PHC over
 MHI
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Vivek Pernamitta
 <vivek.pernamitta@oss.qualcomm.com>,
        Sivareddy Surasani <sivareddy.surasani@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Vivek Pernamitta <quic_vpernami@quicinc.com>
References: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
 <20260917074804.08818813@kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260917074804.08818813@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE1MSBTYWx0ZWRfX5beapsJfxcbO
 6eEAql/vTiqS9HWn7Rl1zLnnGUlnjRWjDVFuaFQBgB5B3wRivN7kOCliXMfMAwYNuMlm6WXYX7x
 Tiyj1q6DqNR6iQcoHt4C8zOjlwUg1d4=
X-Authority-Analysis: v=2.4 cv=IOWXmQvG c=1 sm=1 tr=0 ts=6aad17e8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=BgRFT2qS3vt3802lDrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE1MSBTYWx0ZWRfX5OWOcsvNYe+W
 Ro5bL+kWIBXqS3Jy4R3xNKLa673BJp0uCE6x6ZKI1Bj1JLSdJWbNErrMFBKU7sRDgIAEKiJgsmF
 qnP31dGcmGa5yLPhSJiWnC6UwFD7eGbFBi141vsDHYEn+ihgA5VGSeFQJbfvtOrGxHipVgtNti/
 pmsTYPWFmeAxcvqP5STlcNbF4fKmkYzErKSMipbX6vAQu59E6nHJ3GuYkJSiFiAhdO6b4jsBWYt
 2ZSVzK6A8hBdUyc59/h8XwwwxqsoAqcEN2uF3fTa1yes+Wf+t3Tnz6tycHVHlzwxiCw5hPl/zOl
 nbTJWyLBJI3uQXCgIQ74G/aJn5mLkylAxEkBopuPRHiyhkaLD29kJHKt4gAP1N/KwfxSSqKWmYa
 YPbFxPFGzKJz/vSb3osdt1oxgx9SG94d2oSevxTYvdx0sSt4zVcLO9Uxt+eww1n4hycZ1qTRFkc
 lOYDBuar9Y83OkpwVlQ==
X-Proofpoint-ORIG-GUID: SwKdkZZzDcN-D3okf5LdrqJqYoSG8q0r
X-Proofpoint-GUID: SwKdkZZzDcN-D3okf5LdrqJqYoSG8q0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180151



On 9/17/2026 8:18 PM, Jakub Kicinski wrote:
> On Thu, 17 Sep 2026 12:38:01 +0530 Krishna Chaitanya Chundru wrote:
>> Subject: [PATCH v3 0/6] bus: mhi: host: mhi_phc: Add support for PHC over MHI
> The MHI "bus" is the worst abstraction I've seen. You're turning it
> into "qualcomms corner of the kernel". The PHC drivers belong in
> drivers/ptp/
>
> Carry this until told otherwise:
>
> Nacked-by: Jakub Kicinski <kuba@kernel.org>
Thanks for the feedback.

We agree that the PHC driver does not belong under the MHI bus.
In the next revision, we'll move the PHC driver to drivers/ptp 

Since the concern raised by the NAK is being addressed by moving the
driver out of drivers/bus/mhi, I'll drop the Nacked-by tag in the next
revision.

- Krishna Chaitanya.


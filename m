Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81414490BEE
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156960; cv=none; b=KlaiXVdQmxZfvz6Y/OAn7tzZa6J3ub7H0stsykpGYuSrg37Q4Z2DNUwHLv5gefL+HMxhdbwR5aKUtjfATKzKJeDwwVmYyQk/rjULSaTvPGWUgk/M6oRgbtHp9KMx2lB4vbp0NoV/fYEMJ0V5MNyM7tu2eFX9fL6NBLvw3fcyHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156960; c=relaxed/simple;
	bh=u3NCbjlF65MzYbR+oR2Tct4Ob6r1UTi0DYYNdD9tCKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YONtYCszhGPKucmHbX6awqwcFVI38f0GGujDq+rp40BoGjoMRfJh1SdpWjqiF050K5QDkuF006Muhqm8D3LA+QaS5t2HqeDZDVmIk5m4SSyhUL6l7UHW/5DnQcvjZkWglzidelWVwhkD6MGjG/1bARKUMZfeBuhFbDznt6MxiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8xAVPq2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SKfkc0v7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8xAVPq2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SKfkc0v7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAALbw1793802
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WFnblkCZk590L97ihVInQZtbtIXSB+YbRNIrJk5YPFQ=; b=m8xAVPq28s85+rGt
	66bkL94GxtJPu2AO1TQCIUNqtScwBLYGQHBI1z1cekyAjnhrLvGUVYUOBwQ1vmbr
	wVaB3zwHUN0OvxpSaYUY/MLzYVkFK1qnHjrvKvTpTmA8HRS1THBKHxWdvhLZyC3P
	z02XANusJN5Rg/Q5UpgC4yPDl2mzXU7qwLfyn1YGN2BgLjP4KRINTH1BFWsoRuUj
	4OYipnacOdXJRW7XWMla6xyMoJHRX+CZz5e2nAt/0fXHxxfwe15ai195rj4c3Wv3
	TCcdjYP/QJbMsSpwEHwmThg7HcqO0BHBPqHVJm8XxSguQoWZAuEhYrJZWDj7qMYw
	9vWoxA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3seuvkq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:22:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c97957d83bso258052e0c.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792156958; x=1792761758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFnblkCZk590L97ihVInQZtbtIXSB+YbRNIrJk5YPFQ=;
        b=SKfkc0v7C/tWWaeZrBS56URZHsekNavjAvYRF/ktJwOh6Yw2Lkvo2LmmFAUXGMWhnM
         7HBJHJnDA2h13dnU3exDX1xgjIJcH7EeG+8TdjxSY6y4l2QWi82WpQYKkCRwEkYB0t7l
         ewPenky37Y4ZCSpquxtGUOLS3qs/cBpUIDgc8hOAVLJl63uPGgx3oL2WE65sq6c1t7g5
         qBcqLepKIcOPoSqCH5TWtt/zWeQeBN6zTGz/k+rosO/5WuPM4yNHC8yu45McAivW6UwS
         y+bSKvAPF5xvsZIdw/EENFk0js7bTxKiJgUS+roluH6Ka0wEaaaq/215ZfqoMAENI6en
         smOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156958; x=1792761758;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFnblkCZk590L97ihVInQZtbtIXSB+YbRNIrJk5YPFQ=;
        b=kaYOKRSVWRXQlGCzhzYitgI3XW3HGqfwBYESbW9igIrUoOfm2AaQpsEE+5vGoT/l3m
         gc4X/MbgJLP+pQ4i8JCSGizl4m+nRTZGatU6WqwwVkYfqMCtZ17/D1jvyN21Rf8GeNQG
         JyncjwvTpdGr47XukLYKyzU+ZmRhA9mL+bUNWC8fYVVsGCZEaU8Q3+4nscgNvDlP9kH2
         vqlyvEjH1QlXBBj2SHbHjbgA7kiefA4XCjG5+WiBsJ9EjYFwWdxZGfF1J1e8tlW1au+w
         im4J31ljMBtZO3pT1w0AsthyTQkzhx2EUm+PXqYO6ZaA4PjqIQjj4kp9K0zO440tC2Yf
         w3eg==
X-Forwarded-Encrypted: i=1; AKwUvBzFLGwVSYiflYdBkCLhyLzzS4vgJdsRe2JkYkPItx/TEY+cLt3Yw/+A5k6P+zHBJdQc7rp3awU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1a9mp+i8cQ1MQ2E3Y13ipxcQMJDJ49Lwcs1QYyOUB8eK8VUjT
	mu9h/9iBPW5XsUIB/ZYu0Lq592Dm6UlPlAjFG/GJOMOSoAiPC1pv68bxzG3mCizdDHKxq13scAd
	jCsGigDcaDPdVzRTTBfNPr+6d4EhhOVfA9++dZk0SbnFlsHYZ5q97+YUzvcI=
X-Gm-Gg: AYBFou2Vs1BVnCb+P5CyoscJFK9sSsEvr6jaabkq8OOvSjzs6MQvQSpLYVDiKDovJ8Q
	nO+pawOaDZYMi+i4aeBZ2G/7SsSuqfS6lnCC8JKBilpRQ7Okzh64WWW3BAlNmcH4e7rGWhJnZyi
	vbVJ0thdJ55gf79QW9cQp0LkolngAwsgQ6fuilWdVfkhxWYyfsZ6epu3WC2eIc7qLqzCpumRolB
	Nvf67gqOtDKNOv2rMAz5CbvjIxUDkCzn0NQcxvwgbyqc5DSBqrCd8r2+uUP1TEwIvoK4VI1STcm
	qrZIt/JBxT8i37TMvug5piKKNCC1RjVAIFBmlVuhud2tq0bTl+2rnzLklr2cbJbIyRIN9imlxrr
	yUOn/aT30zfK6gtLln1B3GA==
X-Received: by 2002:ac5:c001:0:20b0:5e9:4e2b:4c9f with SMTP id 71dfb90a1353d-5e94e2b4d71mr3414864e0c.4.1792156957645;
        Fri, 16 Oct 2026 06:22:37 -0700 (PDT)
X-Received: by 2002:ac5:c001:0:20b0:5e9:4e2b:4c9f with SMTP id 71dfb90a1353d-5e94e2b4d71mr3414831e0c.4.1792156957176;
        Fri, 16 Oct 2026 06:22:37 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb256csm71413666b.78.2026.10.16.06.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:22:36 -0700 (PDT)
Message-ID: <95d6c0a0-b0ef-4e4b-a8b1-772ac27e9d07@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 15:22:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
To: Joonhoe Kim <26rote@gmail.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, christopher.lew@oss.qualcomm.com,
        deepak.singh@oss.qualcomm.com, pranav.phansalkar@oss.qualcomm.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
References: <20261016124600.31-1-26rote@gmail.com>
 <bbdaabf7-ffdb-433d-91fb-f6ca03b0747c@oss.qualcomm.com>
 <20261016132034.711-1-26rote@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016132034.711-1-26rote@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 62IAubL6GGlSQUjN5aTIpGkviIZKGwLl
X-Proofpoint-GUID: 62IAubL6GGlSQUjN5aTIpGkviIZKGwLl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MyBTYWx0ZWRfXy6g+fU/ozI7F
 7LruU9lvZ1ScIOose4FpNbM0iOPV4Vo5E3eR1g+4gdQjgPwxuoAH4oZFPlqJQH0Z5YZR/JHb96B
 ZlXtkRZYk+ZwuYPmpP6DPGudmrInIxc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MyBTYWx0ZWRfXyRu9F5aHyROZ
 tFsTbq7j6abV6IExZZaPq19b/uyfdyPwZpEm0iQmOUBJdEWsb3ObjT9+Mtv1+GzXaQk0Yp4ZUI5
 sFLXrXp8LUzOydKkl79b16FHrF2YoqncnW5PTzSYiprTCd1WR/eH+0tSESt4kDt3YzW7sMEsL/e
 rNEdmdMQ6DNNr5vr+shMEV7ztYmngFfehi+HEt8izpqAvY+6KRsBni2R0IjoM5EvsMac0eaPDsl
 BNXbjVFAKp8DgAZ7SpxhNPPmqIRC9YMqTvhD5Nf4/ni/KcG8N/Ww2xrf1IlI1trFXdTJWflyofD
 OtzDaqVm0Q31m4lyE+G+UfDvxG7omQX7W2Xn3ofXYOBS0Xz9ZL862qlsUyEsmeamk1H29DoniST
 97dekG6AF2XvbDElnt6aOMoe2WjJzukFA7L6uS08YbWPFSiQD8UxRent0Z9AB7wetKhiAlieZRl
 Xw9/Aqkd67qC8EakJqA==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad2251e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=BNqwQ8rykVb9Ldng7p0A:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160053

On 10/16/26 3:20 PM, Joonhoe Kim wrote:
> On 10/16/26 3:14 PM, Konrad Dybcio wrote:
>> Please remember about Assisted-by tags if they apply in your case
> 
> It does apply: I used an LLM for the analysis and for writing the
> patch. I left the tag off after "docs: remove Assisted-by references"
> was queued in docs-next, but I can add it back in v2 or note it below
> the "---", whichever you prefer.

OK so we went through with removing that, didn't notice. No worries then!

Konrad

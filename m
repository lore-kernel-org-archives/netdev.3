Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3E4BA1D5
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156492; cv=none; b=hnEmKg+8s6xyORq1kn6ciJ7rxZ+z4CEukVpwWzEmbZQqh2huqUxfX2Lb0rVGxHTDo7zNohOafTkoAk7BdGEkcMPkAediSCQR82wbUxPDgvXl8i7qUZE8bQJoB4Mn77zCxg6s69wtZLDmHzqPnfBUv1xftuSngGvms8VSl5vpvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156492; c=relaxed/simple;
	bh=CndP1bLne+UX3AI97tK+HL16zqhF/jGzueNBiUg3cEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEYLpDPPpb6SSEPVYSp19g/1AHIIuBNZZcA8JHIXjPkQPaO8hpU2u6VpkC+Q2KGkDO8F9bYGUqxNVdGPUC0XdXjQWAt/jjMpE3WX5Vj2CP6yKJ3w/Fcc+umyjL5Ov/aOaSmVf9TFtias5rLt9lA0ZnfR9IuSfGuW4OGgYW6/Mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OfG7Ut8w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E+YP8q3Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfG7Ut8w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E+YP8q3Y"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAA0Q3942520
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KQZsw4ftvBo7+ZjIXx+lUmsyKGeSp9JqGs4axL88zkQ=; b=OfG7Ut8wEH1FASSl
	NEvHE2n3yl99902oZL5LLaDFq7dvc20v6xIeQzZFh1PncyKohYE+C4nq69HHZKVX
	WN17GyN8VxxNLmLVPQlWBg1Z9kr8Y7PwSsnkBU6a1pIRiGhRrzAKPZ9SLIk2J2gI
	7iB2vkAgxufgYPzjoN8VejpzWNDck1fPhA/Bas3u2i7AUwNJKovlEMtVQjmQZkuB
	HvRiaQf3mWrALcCUAlom2KtqaXKgiLFIyi5LSbRz5r5kcQWo9KX4JZTDBgCbqewl
	Xwu/Jv9+crSCvZt6lM7CBybKRU86eB+C2DDvsP/IJM1mlbe0NSI1hh6vb1etnrb9
	++8WHg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur0msa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:14:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ea6b66e53so102486485a.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792156487; x=1792761287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KQZsw4ftvBo7+ZjIXx+lUmsyKGeSp9JqGs4axL88zkQ=;
        b=E+YP8q3YpnzAR1LmVbpfji4+vcTji3bI6ExV+Cda9QNwJz/VA9poOwg1+OpJ3LJoQz
         ODS4LwNrdDeJt4OyaBq+hL3tUP+eLsdB/NINS4vi91erE5G7HaBZFMvU8FdGcydYnupw
         40PTJ4l/uIPoHidLCRlybqLXB0wGVTy0IUFmzKZd4boH+KPnCATe3KFqG5UEg91N6aTq
         xm+9aSGwvRKUXKymJJRu+C/XaZxc+P9ZdRPS46dL4UDaT6zAYkOF+lZ4E4mnfpPG+fFe
         kJd2X6orW+uaCFo4Ft/fCKc4kdwfvG1cvn3yRq/YMHJ1auUBWGFXyib8PPrSlD/+Hi4P
         J+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156487; x=1792761287;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KQZsw4ftvBo7+ZjIXx+lUmsyKGeSp9JqGs4axL88zkQ=;
        b=GHrihc4BjUKtJaHs9IiSQLvfJU9y5k00sNpWx6iP+xMm5Zqvy6ZvNQisNe0bIp5oc9
         10LpevST2tJ5qVl/XBGkz67oMr6exIEACFx4BnCmnGmqMEHUaulfFG0IeXZ9PoVbDpbz
         Sl1uM2XS/YsdsveuZL6aDx/YerBdPLgogLeWBj9opn8cmY6XiDRCFnehBfw9U7rC1V8z
         1r5ko8NS1V4f3mgSvHuDxmQc7rek7GsgnPKTcg5lLx546IFgtAeQ/eu0vIe6fhaKyHiU
         1DUcBzNkWr+gHqXrk7aDruNZNM6qp9l0SCh98v874WB6+mANVi90VIBYIQOCtwcwcJKP
         d+/w==
X-Forwarded-Encrypted: i=1; AKwUvBywe/5nVnyUjU94E1E7fieRAD7yx81au7gPgoTF2+Bny07yyttE4+dFxiH5/ToF3gcA/SMnSzs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6DHjCxPPQjqhaW6cN+BTI9TZACaTY4EEQhbBT856fdFiMfben
	hrrEOh+pGYOQbFBwnITaXaKxxMxfkxCfPOta5OlVca5NgqzW/CEWzVvNahadCOW8LHvODoamNay
	uyWsL+pHyNjO1KPzmOENChhDxxzWwVaXNbmRax6YTMFHTmzlJMKGsqIqQFO4=
X-Gm-Gg: AYBFou3AuVS+bs4rBazFUampX3qRayxrDVOWeCoOz9bICHP6ROvROyBj81vsHMyTGOv
	/Z3BpIWI0JNid5GXGSG+Ch3HB39E79heZCv4Rcn9/VoTITSxXM2gjmZnr2SeOWszhX90zp3unta
	fLeswrJS0BUD65nk+DAGkv/5EwVxtBN4yWpoBkHR98HZI2Fw4JOkpgy9Mq9NPvxrBj2VROxOQA8
	9GPE0IEM/4evUbC+RVMObH10zqvVgi57Si908Deg78peXHabV/UKizIN9L2/jzcFmbRyZnKBwJu
	3xVjwClKD2HVQfn7qardYiCqIj9XRl/uUhBdNK2RKpOW1Ih1yUJRk5isAd7vWxpgplKXJ9cO8Up
	a1mCZ4YG6NCQPKKCCEhu/Gg==
X-Received: by 2002:a05:620a:a43:b0:93f:211f:7ba4 with SMTP id af79cd13be357-93f211f7e97mr152804685a.5.1792156487363;
        Fri, 16 Oct 2026 06:14:47 -0700 (PDT)
X-Received: by 2002:a05:620a:a43:b0:93f:211f:7ba4 with SMTP id af79cd13be357-93f211f7e97mr152800585a.5.1792156486768;
        Fri, 16 Oct 2026 06:14:46 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408b4a85b8sm71612466b.0.2026.10.16.06.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:14:45 -0700 (PDT)
Message-ID: <bbdaabf7-ffdb-433d-91fb-f6ca03b0747c@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 15:14:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
To: Joonhoe Kim <26rote@gmail.com>, mani@kernel.org, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, christopher.lew@oss.qualcomm.com,
        deepak.singh@oss.qualcomm.com, pranav.phansalkar@oss.qualcomm.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
References: <20261016124600.31-1-26rote@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016124600.31-1-26rote@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX8BqMhiPDWmsK
 /Xi4CbG20ZTFyxAo3IOQRvnFrSXrZ/PgCUs2ZxzkqNLW8GWRlRaBiQ2aApjxJP9oUu2SatwIoet
 8wdErgBns3Ei4/5CU2q6d92OqMFrMQV3Ofcz98FJCsz2knyZzvz8w4WVUzJaHKJpt6/gyBSjALQ
 ZPPk9+7SqteB/r7a2KGXs3afQJKjxWIkvCmNozqZ2bXgjMBuCzDCrsu5szsGwhSxT5NowkN4ERJ
 eGzgR87/JxbzV/5rMbFt9cjznCUfASV5Ie6xkVupkG749Fs7wvATPerWe5dH62Y/qbV6KZJFfnA
 nSgFF0L9F/HxfnBMxByRN6GZOnIgBIII6dPWSuRFMZ8C7D8NlhSlXT3WUFSAAbIXjzEXtdCzFnP
 MdJOss/OkhGdWL+Y/zBtwaXnTvQVyUTz7lETSCvT1HUN+6kwP22zrK3M9yI7nMIKlVh4yYYqV/5
 3OeEJnm9apLzlDw3F+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX+r5qGUsSg69N
 EydxyQSrv4bd4SQO/jn2EGM7EHsD/0RxuVW0T29oFbK+BFUvjBICL2On7RM6YwsQPK/5hG/5fHQ
 NDuNoyKLi+WvBrzeBSyz0u3VQHa63D4=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad22348 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=tdnHcQlNMze5R78DgzoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: K2KRx-bCJDvvg-1CpsmmdinCsHAzzJTQ
X-Proofpoint-GUID: K2KRx-bCJDvvg-1CpsmmdinCsHAzzJTQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160052

On 10/16/26 2:45 PM, Joonhoe Kim wrote:
> Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
> register"), qrtr_node_enqueue() returns -EAGAIN for every packet but
> HELLO until our HELLO has gone out to the node. The HELLO is retried,
> but the NEW_SERVER announcements sent in reply to the remote's HELLO
> are not, so a service registered before the remote came up is never
> announced to it.
> 
> On Kaanapali the modem sends its HELLO before it accepts ours. With
> rmtfs started first, the modem never learns about rmtfs and its
> watchdog resets the SoC about 40 s later.

Please remember about Assisted-by tags if they apply in your case

Konrad

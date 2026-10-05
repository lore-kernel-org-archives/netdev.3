Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360536DA0A
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226259; cv=none; b=HC12dcPa1/Y9KqIVUC0G3pMv057Y1FS2L3FdXhhptUQJCiSSJXIYqn9+QxTJld66f3NH1d5yS5Y0gV/XsSSbZ/8FR2qQMFW7Mq18lV+ZHkT4qxQckwMScRDITrJlzVaB7gveQ/fYsfkITH6vYPdFXlY82YmQZhvyTJ+l8vtY4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226259; c=relaxed/simple;
	bh=1m6NbDyllLCOuCwF8nFM4DsV2cbg3ieRxMAPKSw7bfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhwrK3OqX+Msx5FwIxYN1eHFNcJvCYBqEoRKM4PyapsjbdhWzdcEmcUFCLtbkfhu5nA+ueqsfTYCtFDV+qA0xe3LS6RN25aXfLiNOMzby6sHX+cLyWsA4eOfyPdQHQpEJHbfdGzKXfJF4fdTEIGs4uC9usyDSyys3CDTEZAf//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jGrNHHr8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=esOFHmql; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jGrNHHr8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="esOFHmql"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HuO0e2484439
	for <netdev@vger.kernel.org>; Mon, 5 Oct 2026 18:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UXkwJcax0xFjYGwMPPC5NzHIXIFh4Aygho6iVbLQg4U=; b=jGrNHHr81So8LHlr
	kiyTu7kHdqzJ8yjiS2Qwmz6ZnUnRpNKcRu1JbYRXqVb1DSKspJ/OxD6Uo0s8owRj
	QXe3tSOeqrEtzzovLXII9lKgQbJB0oXIn5XwyyRZcGDVAFrkihj8M038hev1mIoU
	tzsmT0yDYgsiQdgHJ1XBDvG0CR9/F5ixcNqS4x1Rck/Dcih+rx6X5KQdeecGyoSt
	7REW+xeVzDQBElRMWydqwImqXbAOl0g1YVxIfBzcbbqKmLB5J2/gjP0grSQQ2lWf
	Nu8GfK+FSBxkWKTqJW++y7NypAhRCXZt1IU5sOAlC8dEIKugjqbpWHnHhLDokMi/
	V6ysDQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr0875g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 18:50:55 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-155a75f91e1so1283219c88.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791226255; x=1791831055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXkwJcax0xFjYGwMPPC5NzHIXIFh4Aygho6iVbLQg4U=;
        b=esOFHmql9SkYqHk8xncNPZX3gprfqUQiuZBx0gOn6UGkQgvenGFm0kCT6b0lG3/FeL
         tSaAXVXKw/wr9FXSwzM2hWEW3baZOoNqcAGEWRQt9Qo1oZbkVQDyhP7ZVKb/HFIovtnb
         h1jZxYZIxEh7HNRFvoaEt+nMqnXwehlzT4RcnNYPKTd59BHn9zsXyg0Pd/eE992q2ZYO
         PEzKvn5lRjkwCxCVGSNec750YgbVFL6N3/gH7u4TbF7iIUuM/FtxzeEfj3gCbqpk5jPC
         tPOovWpTFHgH/kqNwtMk9f/wBUXRkkFpBC1uzwoEnLdpuHpZeo53A6p66V6KyxEiUtyG
         ZyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226255; x=1791831055;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXkwJcax0xFjYGwMPPC5NzHIXIFh4Aygho6iVbLQg4U=;
        b=duW8AnuFaQklrcckf6Ivc2KXKHXb62VXYliMMjrX0lcJuk8jRfZcULidf0D0Hn4k03
         CStakMi+pw0oE5YX0YolKuBO1x+Px0R25+jLepuBUcCecmQZ3sp8P8rEhqlID+V9r1Au
         EKyqDVxsgUE+9rEkslCDhMcScOasRIHJbWj9ivBNO1NzbYm0bB8lQ36rDzYwLnO8etHx
         TiK+zx6fjk0rSPZvelV28DMDz6jaxBseOH1D+riWJmvFX3WR9ZlE5TMgAeD0erbAQu4c
         YRlpmpGVxAaENN8i+lv7dg7ktprl3MiP6CCsisVntvX6OhbZq+8eTrMApGs/YTVzpiF4
         axHw==
X-Gm-Message-State: AFuF++nBqodmDsQHXsfiAvRUhSLr8TYu8V21s6mgNLFVqoomWH4Ns62d
	s1azg7Pf2I1KoS7ucxhqgRoXwAcTqs85thCIGLuvgrhLcopew2f5g6Azr7jOG9f4lgdUfg9pA+o
	oS0REbgbKM+/mT/X4JtTnco8lvFQsYCl9zpMDlc218lcSve0Fttz1KdB+RLs=
X-Gm-Gg: AYBFou2UV4tTUpaq9m9Z5DVHPhT3jytcthbywUJlc0HccNne5C8gKc/eOLGsWYZY38V
	fmWaiyW0fxmj8PiR3AcZCy+z5onalHtfkOKtpv6qPybMadAdSkSlWBUswq71v9uJFXzlH5yIMUY
	GKXMp/Q5eZFcrcSzKuAXAO6T75gZsJyhfqAccopJO0K24sXWVwm7IL1pgZmzOUBl6R/lOIj6Cvt
	boWm72+ajh/nH6mCAaKbtqsVU3KC/FAH+xKCNHvUnpsdEUdtY361c8j6+/U+K1dmHtQ2zMozS1w
	/mbXzKaWX8nDY8uITIWZ9MTceXjxS3RdG1bWWhS+NC1sfFUObwpmZLW+06r1x8sBS+aFEStCHTp
	mH0gNYQhzWZzt+BhChI3xwltyfDn+nGs5Ips5I8TFvpQGlBOd84xyT+IR7EQlSmQ=
X-Received: by 2002:a05:7022:ea53:b0:149:f2b3:efcb with SMTP id a92af1059eb24-15d2f292199mr446377c88.14.1791226254854;
        Mon, 05 Oct 2026 11:50:54 -0700 (PDT)
X-Received: by 2002:a05:7022:ea53:b0:149:f2b3:efcb with SMTP id a92af1059eb24-15d2f292199mr446350c88.14.1791226254251;
        Mon, 05 Oct 2026 11:50:54 -0700 (PDT)
Received: from [10.71.40.138] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351464fd465sm416153eec.0.2026.10.05.11.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 11:50:53 -0700 (PDT)
Message-ID: <b67638c1-e720-4a69-93c4-57190fd6b06d@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 11:50:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net/stmmac/dwxgmac: Extend MTL/DMA
 support to 16 queues
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-kernel@vger.kernel.org, k.domagalski@samsung.com,
        k.tegowski@samsung.com, cs0617.lee@samsung.com,
        Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>,
        maxime.chevallier@bootlin.com,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
References: <20260601162537.553512-1-j.raczynski@samsung.com>
 <CGME20260601162618eucas1p14be36902c4948647448160da08aaebc5@eucas1p1.samsung.com>
 <20260601162537.553512-3-j.raczynski@samsung.com>
 <1d814431-c01d-4730-ac22-c41f47f93b0e@oss.qualcomm.com>
 <asOUd4j4VWS2Svla@AMDC4622.eu.corp.samsungelectronics.net>
Content-Language: en-US
From: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
In-Reply-To: <asOUd4j4VWS2Svla@AMDC4622.eu.corp.samsungelectronics.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX8YG4gUKkoYea
 RG+k+SzAV8S/tvRec+LyOjIjwLMNwQxsfqr5U06wzkNZBn3LYHHTqo6TT+rMyzIn0XS3PJtTgzD
 L9ee+IIEZESqwWtCj2b4zUyB2FC3Vr3E1HpgHVRZ9YH3capGFwuDgePnGL7kkCm/8BeT22vSQ8B
 KsKK+yCqKXUn72Wfi58XUJpjRDs7EfkJK88ltEPygrqK6geccumW1PTTw0GMo/tntCqEfNv+Ujv
 LBu8qiybvFOLPW69t/2ZmEsEjB1o3/grwnegjBlZ+XWJXiimZ6TQSRBMuDBNrA7BPqXdeAJk8Bq
 1Agg5iZBNbU/xESyugjf8sYufx+tgRwz+nRy/HxXFl16v6VERWOCK6EJ7RlgzPbXY8e+nbmsrGs
 Vq67rar8zxe0Zrwe0kI+hG1Pu53nejQmhYPTadQFdzCFVAZ4RuPeyGNmN9NKAnrb/DKuxldNqRb
 iXRXRLsfWFd8VeaXrww==
X-Proofpoint-GUID: 2Wq0Tix64bHiBHkW9sQjmCeokXmDQghE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXzM+ywJqCbW/t
 baU2XrABwaZEFZ0H2zKjM/OukN/Ib5eUVyTaft5Qpa+gzqGt5jclKT/8jIH/8WYlEn28CTJgj99
 NMW3fyFVSWA5CV1NsKsTE/hJhfqWcOo=
X-Proofpoint-ORIG-GUID: 2Wq0Tix64bHiBHkW9sQjmCeokXmDQghE
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac3f190 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=ApdvrIFTvTaq4_YbBQQA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074


On 10/5/2026 5:13 AM, Jakub Raczynski wrote:
> On Fri, Oct 02, 2026 at 11:40:19AM -0700, Sagar Cheluvegowda wrote:
>> On 6/1/2026 9:25 AM, Jakub Raczynski wrote:
>>> New datasheets for XGMAC (3.20a and 3.40a, depending on product) support up to
>>> 16 MTL/DMA queues. Before we increase max amount through macro,
>>> prepare dwxgmac functions to handle that.
>> Hi Jakub,
>>
>> We are interested in this change as well. We carry an equivalent
>> change downstream for a Qualcomm XGMAC-based controller that
>> implements 12 MTL/DMA queues (MAP0..MAP2), and would be glad to see
>> this land upstream.
>>
>> Could you share what the next steps are for this series? Is a v3
>> planned?
>>
> Hi Sagar,
>
> Sadly not for foreseeable or borderline never, for few reasons:
> - Increasing number of DMA channels without providing hardware DTS
>   configuration for that is quite an useless feature,
>   and there are 'issues' with me providing DTS for our hardware.
>   Cannot say much, but generally won't happen for very long.
> - This has lowest priority and doing other projects, won't be able to
>   continue within reasonable amount of time.
>
> I will be very glad if you would continue this patch,
> as I will not be able to contribute that.
>
> BTW. Adding Maxime to CC, since he will be most interested in this as
> newest stmmac maintainer. Apologies for missing you earlier.
>
> BR
> Jakub Raczynski

Hi Jakub,

Thanks for the update, and for adding Maxime. I'll check internally
whether we can pick up this series and get back to you on the list.

Thanks,
Sagar

>

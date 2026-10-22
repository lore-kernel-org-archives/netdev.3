Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664542;
	b=uV8YN9Nu3Evw09/l+C/9jzj10U/55iJwtI8HnQZibQySupGlGL8LbwHYeju6GasZqYtM
	 8VDHcbAULTfWl6R/Vkacs81eOvQ1nRq+XTuvuLC8CG15wabeClyohVwYQb2x6RgUASJjs
	 hT6KojX2upjQSayBf2+lyaUCx1OL6fQD2HK5hCy+XvlDvhGM5m3RIdypNpWou4Rn/C5/i
	 pUMWUZ9h3RlTXozZ7/bnSdxdlB0BCttyh8wL0juZ1LdXcNLJWqcfawORwAefowi17UW6C
	 njdDmhyvHP3KxkEhUo9l21pmpZa5LfpnBJx0l9rDjmcjZK0GCQUfIprd4tAunqRLSiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664542;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4F3Bn4K4Bs3YPMzyvcJretv1uwSXuk9sX9+2pTIfL74=;
	b=T+Po0D4KP3OJE3VpwdTV5P+s9b2x28PZYHM1bKRTyDqGzlx8srl44nsVTQ6SMCg524ZW
	 OkoYOXINE+HU94HsfY7Ykzc41qGI3zNc/AiCVWfYUXUErOXTPMwqltoge/QhLZ4L/AHTb
	 juRJ3xN0g3WzSqNLywYO9IZDlzhAECz3M5BTU9YfxWu5YLHGnEAUPcuVAUEmM8k35Wj9m
	 OJiazhfZvSG9s0kszcsJF+tGyriiSIJtPu/3uDb12m3fOzzafDM53obdNYxiC7OUi1sjj
	 TDDA8Z4fo8mjmb5hwiObHgcaGmRuhmuX6L0U4vJKwjFzolopZn7pGVR0wE9om56CQmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JNanIS+6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YicCycm0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F277606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F277606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JNanIS+6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YicCycm0
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA06n61963435
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4F3Bn4K4Bs3YPMzyvcJretv1uwSXuk9sX9+2pTIfL74=; b=JNanIS+68yj3BCZj
	JREOdna+K6DvJBM6Ee5phe5EDE8FrgICg27v+D12qkExFPJckHRot3C/HEdi4TC/
	Bi+5hMHnX+vRkgUdJHznoPQB63Es9IIWnSf1ANK0AVHD8VNRxK8kh8Gka5LZcPlM
	MQ0SmC3/K/ngZ3rEs8Q3tBudrXHgsHNJtS3vDIwe+hOc/lVmqWm4+wMM0BvfrV+Y
	eODPCnFOP7jkWMGjLcm7LEiGapDsYHk+3qjzr7Dz6/29dAv2NOntgrQTXSbK5s7r
	E4TGg1oX0eW77DmrEzLsz8hP9+OmvuHq/e3tEZEWh48hgDTfOKgqagRS97yc2vAW
	F5mPYQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93aj0u4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:22:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a06da65d92so1238699b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792664540; x=1793269340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4F3Bn4K4Bs3YPMzyvcJretv1uwSXuk9sX9+2pTIfL74=;
        b=YicCycm0Cm7cnWi1yEVRn4FVsYgnMm7CnVtBoJtRlH/a8dvq5efZkjWjKRbburoi9c
         KBUdU8onJtVZBMGWC+4IJqlHJmgjung1bgQgGri5GKuYGme3XECfN2w+lI9l81Aegmvq
         qC7Y9Xj/bqd60j3TBHRygwpdR1QIgmkn0JDTzPWxF4BgHuOngrJt6cwJJpu4fqAoOdNO
         qxxEvFqLEPLeImj0UhffbOrRPCiQ9dLu+OLMgx9TDhVWhKVd/+C0yg+sP62ddePx52wP
         MJbal/TOYJ2MV6I170wpZPqpnGcn0IWNmKrsfGTez78V+yd1UxjvEDHMYFLCAPs1oj1u
         TCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664540; x=1793269340;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4F3Bn4K4Bs3YPMzyvcJretv1uwSXuk9sX9+2pTIfL74=;
        b=QPGNEPWC7vjI/v2VRmLT9oZsukLzo6UIG50+FIFo4fRckwuu4wlm0VebVRp9k5A8dq
         l/RWT1rzmbv6Cb8WzvPKpWyzzneef9MI/inU8/SAuZaL0lmASoAwDAPm0brWmrtYCjxS
         BR3gRKGV48ZY+Bp74zUD9diMAXEZdU0+I5zXcE+14GgjP0wmzq63M+6dOVYYm1lPrrmV
         pdLLo3yj+zFqtLd3A4nAOyP6gqdaWWNPefKWayGeQtcqL9IwhrZNX9Mg+O0Nyr4S3JU6
         y8bgxG+bgd23PJNotxncg1TWeQ1HT9FVk8iwgVTNxCaxLSp8qnTQHp5bmv84/DLd6C44
         uKCA==
X-Forwarded-Encrypted: i=1; AKwUvByXgtop7zn0htgoO8dSdltblT82BgicmEIZJ1X2N4MCJ7aUL+mYFn+J2Enno64IcTPswUtFqKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLN2+8dpUNpkBc2k8kRJJR6oCUB+u19Qc7HwSmUGVwJzJLTKdy6
	1zrAY3Rq2dG8/HWd17kFnIyo0JjJJDUL9sLhz7AxTsF4eKaircrItHMn7qP3jh8+hmKkTEejRlY
	Uu74AOXIEETlmybOjcBtTbpJNMMlEjTfjnnQJZzOwhhdl3uu1uyupQ9BLqPA=
X-Gm-Gg: AYBFou0t7t1IqApJpAS81Eux/2o1TUIdQNM2BqIP3BbDUEmmWtk8Kgvy/OeJqjpVaWx
	P1xvYD7kok5KKq+y+EK+B0xxJBTckFBtn9VWSJsOKgU7s+fmAIBnBFcDvT8f1H7FiJais3b90w7
	opfftPz8UBEy9BKlcXv7m0DwaMTsRvsi353d7X0AxMgq/nZqo5HrUmQTy9Zmf29AJw+Ly/RZhUl
	8UJcpV+3wlRM6lhDKdht88MYu4LQZJmUXavZc7N4A4X3Aqtia4c2OJmg3/kil+4KylRrTRGczMV
	YwR9n6QftFt5TCPNn+l2krauvcR4Wi4drZZ5FlLxR+3NZiab60gS/uqEmcatKfBrnljCkaxB9wo
	Y/VWYwmNyi7JQd4dUzgmGNO0w
X-Received: by 2002:a05:6a20:ac43:b0:3e2:8430:917 with SMTP id adf61e73a8af0-3e287e3c861mr4213243637.45.1792664540389;
        Thu, 22 Oct 2026 03:22:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:ac43:b0:3e2:8430:917 with SMTP id adf61e73a8af0-3e287e3c861mr4213230637.45.1792664539920;
        Thu, 22 Oct 2026 03:22:19 -0700 (PDT)
Received: from [10.233.17.96] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b864e165sm1000679a12.29.2026.10.22.03.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 03:22:19 -0700 (PDT)
Message-ID: <546e2125-7349-4a80-bdf2-d35dcef46985@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 18:22:15 +0800
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
Subject: Re: [PATCH net-next v3 0/2] net: phy: aquantia: fix PMA capability
 reporting and EEE discovery
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d@oss.qualcomm.com>
 <20261021132908.5a73ea02@kernel.org>
Content-Language: en-US
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
In-Reply-To: <20261021132908.5a73ea02@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfXx5ol5Fwr+cUj
 JZsyu46UCVMSy4OHiXxHRnMFr53SOTZASY4RKb4jLRsldgG7Kuz7W0m/oWbRSRPH/QTLfP9jMXF
 +ttP73p87XPnIXiEW+hQ0WI9ne2DX6+YZDLJG2nU0ljO3Hzbd7MMLUzpcaVOIvNnKRgrYxjmajJ
 kvrxcTB9Dlr2W4MGXbzvPSyGq2r52qwOV6VesnLFycsi7D8CRjBTLtx3bvdYVIq7KPPG5be2nix
 GJg58FquO6qaRCR98usP8L5/LpE2zmCnOHebLce+TImbWmjO6sb77sqqKTOUiYVw+RKz9yInPG6
 PGqUCFs0HOol1jovVdDl/Y7Fgl7HjjnB8tDXpwyVcVEtBlDmC2obNOka7mAKUSMhD7fiy/yGpDl
 WQnD54Y9kekm9StZQxdYF9L5PqcvAsQmkFVzRFzmygOwe2SHnb1S3PsNDl+yOxm6InL4wECggYA
 dpERVvCFf6Vuce3dTiw==
X-Proofpoint-GUID: bd0QQj6xwqrgt7tEhBPe-p3J04ixNYnk
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ad9e3dd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=C-A7-TqGoCA-4_zHprwA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: bd0QQj6xwqrgt7tEhBPe-p3J04ixNYnk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX7Qh/11iZMmlh
 uUE1KOlDU1NnHubkdakCBhzq3VOxx0Vm1JRQffSU7dpdXndFV9JVetD1UWR+V+cL1HHSaT/Npd6
 oLHTGQVAjUIbTqzCH7wni+UU8XNF2F0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220041

Thank you for the explanation. I apologize for not responding to the
netdev-bot+sashiko review in time. The v4 series addresses all the
raised issues. I will repost when net-next reopens.

On 10/22/2026 4:29 AM, Jakub Kicinski wrote:
> On Fri, 16 Oct 2026 11:23:17 +0800 Hongmei Xu wrote:
>> This series fixes two related issues in the Aquantia PHY driver:
>> - Patch 1 restores EEE discovery for AQR111/114C/115C by replacing
>>    the manual linkmode_or() with genphy_c45_pma_read_abilities().
>> - Patch 2 adds get_features() for AQR113C to correctly report
>>    10G/5G/2.5G/1G PMA capabilities.
> 
> You need to respond to AI robots in a timely fashion.
> Since you haven't and the merge window has started on Monday
> we have to drop this, please repost for the next release
> cycle
> 
> ## Form letter - net-next-closed
> 
> The merge window for Linux v7.4 has begun, and the net-next
> tree is now closed for new drivers, features, code refactoring
> and optimizations. We are currently accepting bug fixes only.
> 
> Please repost when net-next reopens. There is some uncertainty
> about how long this merge window will last, so please check
> https://netdev.bots.linux.dev/net-next.html
> before reposting. net-next _may_ reopen on Nov 2nd.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D73B71CA
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472833; cv=none; b=bXVF0u+qHLv0h+qFQ/bIh5HJbos0TUpOp2pAFPRn3c7pNJJ3HhlWVHZGLuEu6nti0EB1xJWrt9BV3nObFCRBCZ7gmNTeamYmTixNN0509Xw636tyNMdKrLQU0pKwf6tAseuQmg/GU7v2W/sY/yK4RnJWY3tlEMA/vHGmye6bHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472833; c=relaxed/simple;
	bh=AODr9g7jG0ahMDR1iDWx5Ha4Byxlb7oWkWpK+6uo/Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBPKbTklApZVdshcHXPjS0mEz2622ASW4BQ3qyCa/j0DmnA4I9FZzp3tLZ+pQ5VAIBSOREswzvih3NzvHBuYXdmCtPeR4FK17IJzRno/480fMR0ibGuvFPoqtPg4HKx63FKicYbxd2PMvuXld6GSgYOE+WtSQdNZOqrg8TWbkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g1zAlDyz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jngTtTGh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g1zAlDyz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jngTtTGh"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAck871143832
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	efSmsLNw8E+yGzrU4i9rfMYqOeX4WnsvoEalewcGYnQ=; b=g1zAlDyz9+fjFEn1
	eSLwg5hGzrK6g6mloSVh46LugG7GsSngDqO0kgNgdgND6LIRSGZXWL+6k34xsLaa
	E0GaUP01R6u7FDeAt4tY85T8+QZC9Ph7N8Rei1xnQJsIR4Vaf0ua58e2H44b4Vh6
	zsRya1YcadyGXUZMluRvvhQ3xB43A6rLUrguZaV8685jFOP9gawXuLDp9oJ8QMW7
	OZ+84CuflpoD+EzVf5b1tTB+t28WxZTCyyJYKTn0OQHTifpEoRseAGg/nOsISOI3
	y0d18VYFI12DOixIFrZ37QjG1Eex9Dm9DVSgncvQo/ETUDKXO6Ar3QOaNKB6pKWH
	lA1LTg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eewad1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:20:31 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9661a9174d3so17415241.3
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782472831; x=1783077631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efSmsLNw8E+yGzrU4i9rfMYqOeX4WnsvoEalewcGYnQ=;
        b=jngTtTGh/QW48K6XX3v+hysyuC0lWG7i7XbvFodzJ6RQXMEwG8vU9VMJ4Xy/BXVo6f
         xCxLR6c+EsRhbo69q2Ci9HPbvLvSCIId8YEthagyCWaqIrY1G6lHlk1FIW2JWx+J2t2K
         Vb6zK9TO/HsLg8NzOPbewohurkuzvZUDkV7wm3G+avBk90kvUmZ/WPUcePtwJz1FK3ek
         hDxXDGWh0jcEFC1qDIVtBsF9/QRym5+xr6cGUErs3w1IBK3raav2YuQZXCAFFEfbUzCJ
         9OEp/yoLLUkAZ1W2jaIsnYzVT0jduRtYpPZQmHY2nRVBa47EdfbxA4wq/wsEP/0fg34l
         JLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472831; x=1783077631;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=efSmsLNw8E+yGzrU4i9rfMYqOeX4WnsvoEalewcGYnQ=;
        b=Dfdc6XVFSEOZQhNhsgA49kOs4EU4FJ0vEwDz61TWntTDa9tnSGGiA2W4GeDlaou/yF
         S+CcdVh48unfXFOR0DvSQsEZLr36+1lT3CXxweYM3JMFVb77ln6MNkaGmSqLLnJbRySz
         vJqjIvM0Rj/TBFwDy3dhv7IrU3neylEDbvrYoMTEXE98ipZi4UmdeUJF926x4W3ghZYN
         OwkKQF4CZW0SSkNghzP6PF1yHhIPJHySUK+vdwKGLdh6CiSvOY4VmFBxN5Rnw+uUXCjJ
         aMl6cCsC26p0nczSN2hyAP6zhvCil3QHdUpQavnCixiOJWB3v5WKXm6Ir465vdj/XDIO
         njPw==
X-Forwarded-Encrypted: i=1; AHgh+RrU0bWw9maZNMesFvx+tSTY1PpWm2PYAriL2GNOcShgp7wcfzkgGn6qI7QCZpthOcZYjNffeOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgkRGL44YiD0M4um7J3e2xDzcRIBu40OomazwqrLOrOJ/cqua3
	4hGaoEIKIPkHRlpO8xT1THVZCLghQPMZfkEErGAYXhBGuVJ40mlBItEAqSasfB1alpv86Cdb3XD
	nuC7YMaAQjbrE2Pf5moxaChnqJb9U839mQ8/VKw3NCm71N+DmB1Za85Kc6CY=
X-Gm-Gg: AfdE7cmQJMBebcYm93m+iII3bS4FJozV3H+OKJRrfUmPrKfi9iIbVEnortWLBxKkfm9
	PRBihPATaRDYyPi1252zaf/OwdIuwDvvMC9EXBkIL/AR4vMT1njh6A4ORk6sEF56APLK8zv4m1K
	YpmIu0SJWfSfrUGmH//yhqsaYJPoZA4+FveXfdaGCEr/dPWYtZLly1tgMidaM8MDE9zDJa6U4vp
	RYdTQLpZkdHzpX2oPEC5/CNH6IjjyIOvSn4Xwa4y8kppCPlJyBlQYCMKpfdIh/vHffAyctxhLl9
	wYx9LT+BPLrRT7HDtC9qR8h3r3Ha+KmQcKL3mUXJlPVfo2qjfcIVy55DJUB6gUAUvq8C2cCLTXY
	h8rtRwkehUYhB5XXVKeXPEr4Qr/m82B6OHyQ=
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1071131137.1.1782472830775;
        Fri, 26 Jun 2026 04:20:30 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1071127137.1.1782472830410;
        Fri, 26 Jun 2026 04:20:30 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ade18esm2731485a12.7.2026.06.26.04.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 04:20:29 -0700 (PDT)
Message-ID: <38aceb33-b28e-4994-b277-de070b6dae2b@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 13:20:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] remoteproc: qcom: Add M0 BTSS secure PIL driver
To: george.moussalem@outlook.com, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfX5NHxjIl/0mPS
 0kJUyyjKndC6dr/TE1NwqvPBHVHmVjyZZHRSzEeVEKb1fa76xhIPnyJ0AF4CIIjiMrDuOKMqQXm
 q9WoX9/2ZWoq2Ck7t3RzYl0iytZPVsU=
X-Proofpoint-GUID: lIkkN5Qvn_waY7nVIuqMnEqzAUEuRHUL
X-Proofpoint-ORIG-GUID: lIkkN5Qvn_waY7nVIuqMnEqzAUEuRHUL
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3e607f cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=UqCG9HQmAAAA:8 a=sp8NEORZx8pkfp9qRiAA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfX9+jj+7KdTH3M
 AsAfuNgD11lZCl1DU3QVmAS0teE+NcM9WXUULDjB6udxAgD9b8/rY94fW9OT5oxugQdBG/9kZMP
 ZwqfCva7PbF+h4uEEBB4LsKoiRkSY3ZVctWBf4zl3jZjucg7jnbshjuCZwjSnqIP3I9+lFqIp3f
 UMh0xb/4NIB+XJ/iIwpKuu3W0nte/WThC9qjkAjNzshIRmjPrXtRNZhn8YOUzcQyHikTKmDv4qq
 NYtvDYO47NsHAWURLTMh/sBABBOF9oynJM65hrDPxXUwWspiXNBoByC4EVEE0lBzNhKLKbMZkG8
 LtWAdHNAGa7S/UyRjWR9ji4teOpF4BVQF+wL+A4YsJpaw9I8vfTJgzNmopEp/aQXnn8XBzIPeJn
 dTXtGQiiMy1OmQY9VGc2IzCiHUzpAc2/UbxGAfkbD1nrZAMMa4Zx6HLjKbFe1IwmazJn4q218po
 7aq0aO/Xh3VMy6AESuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260092

On 6/25/26 4:10 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add support to bring up the M0 core of the bluetooth subsystem found in
> the IPQ5018 SoC.
> 
> The signed firmware loaded is authenticated by TrustZone. If successful,
> the M0 core boots the firmware and the peripheral is taken out of reset
> using a Secure Channel Manager call to TrustZone.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Can this not fit inside the existing PAS driver?

Konrad

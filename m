Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010208;
	b=Ztb30L+GqLmaxAb2xxszLlxa9ZfdA7bmbOkPoPftx7MqCxwbOzBvgr95fRo1vFOzg6V4
	 yVM6Z4vx/3OMNMjFCts2GYd8q6IK79SJqBFS7ZujG6xN2zSYzt1ODEn1gSzi+Es1yAdKp
	 M/8ysVFYcrGivQ2LR0YoPr++v8vgeXbc8IH1QMAf4qzxCeoyJJP+Km9K/1UT9sVFr/2cL
	 tHDukJmKPONFMocHR4I1Kn151Xc56jNOKgpgCRvYH7UTzH0C1wkUZFIFr+KhObvDKDeZj
	 NJgGijhHGfPd3QYBCUdnN1TIV1xASzH4TZi7LCiFRsfk5myJY2+kVYgOEsyb7Yuhc2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010208;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GsDZSvb/ziwVv/+kCRkHifsd/bmXIrJplkWD5AtBipA=;
	b=zn8GdAMV/sUPTiA5QMHh3pEX9EtiCbwrcnccMdnWSbHri8WR97ecRCYz6OjPZr2/uZvQ
	 q5x9HpLYxoXDXzdAySl1BkX5bNtBAcQQOjJWBtKuC+ySGtG51J78qvA9sToRQ5BJHmE4a
	 dOs1zmivdfbv6fvK+zObKtZguQ+k9oE3Ir34t4WINi7Rp/wu/RCUUFGkyuJjfihG30w6v
	 U/d6z83vDS3rZ2/unP0o7vyOTZ/X72aOjX301DD5erN+TwWWWwV+65d59QDqzVZqGp+or
	 AB6Xc6vdM6iITyCsYk7N+pb9G65BByTPLzTQS8Rjx3oA7MUDHKV74LBg7sUD52F/vQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VLhNGqJi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Q4p/uIeI";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2A606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5C2A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VLhNGqJi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q4p/uIeI
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aq2w1181748
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GsDZSvb/ziwVv/+kCRkHifsd/bmXIrJplkWD5AtBipA=; b=VLhNGqJiB2hH0sFx
	e0cz73xlzSoHeP/ooJsF18kH0BAwW54LJBHJjip7cpNvxTCA2PrZU54P3I/q0rqR
	sLVN26WH0njsjljagUB5EezohQufzn8IF0dQRkCqeMRGQZGpJuGpVzJa+Z4uYYO9
	kFzbIXpq3zLwgzMY7ZzhEmah9TLEslI6SOfIMQPXkWK9OxWNymEJ+S/x0ijU1Y79
	ZSLvnXaTal1S0fzav3XYz2Hf1DrA32ZiXtAes5RrhHye5d0ONRO0fP+pYocoxS5p
	c0rPtODw0cnJXFnOPeWX6m52OFfsGqQzwgcKiG/JDJOlx7KBgRk6IyTUlQXS8sbC
	AiI6Uw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27wwpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:23:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dfb24dfedfso31254175ad.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793010206; x=1793615006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GsDZSvb/ziwVv/+kCRkHifsd/bmXIrJplkWD5AtBipA=;
        b=Q4p/uIeIY2A+i413NxhtZ6Vj7ILv+Ww7Uw9xBlhXGCG3UCppv4lPH2GDfi8M1q4iOt
         m8oqFWLzxulCLc7q9wmXQVR1v0fxcMBUhNjg0W/cwnLbZ5M0i5CYI3pb86yJ1y1GS263
         yvP9oL8q/042G2TWbUF2fLcYnT8Q0UDozpf1cX7G6lq5cNm0CKle0LCNdwAP9Lm+wfEU
         R+xfaydmneytURmrl+p9zwPE9p3jJg9LTfKrCcVEg2txfu9VhoSf4xkt3qyy9+Ycer9m
         FPwUvUsrdIz0OG6NLCpZZ8gXOtVEZcX1rJokPHar4GKoTRkX93VI3AyPC4dOmd9xAkoz
         Bebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010206; x=1793615006;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsDZSvb/ziwVv/+kCRkHifsd/bmXIrJplkWD5AtBipA=;
        b=Jwb6Cf0D/dPpPPQFIT+CFm93NzoKs3KFXb7RxlzPkNJ4paHuoDK79k2Ms9Im5VkW1h
         XCqYboilJOPMEbJZhkzvLWi5v70el71dY/Nt6r975A+epDFKXHNkMMDex1lfLmy5uq9u
         PdbPbjAICjG1V9p/LNtESxo2fpJgj6KC2aBdy3U5g7xtVdsQHplpuiukGQW1JPvfCdwg
         oTsRUgOrYx//XKGCgrhDOipXxgjrYncYg9eztUHr1zXKMiSlTsN4BeF5OPgdngEYcwx8
         17ei6oIV62lfu1xgIiuc0NhpprpKTSRQFTeto40MXhCfnNemnnOOCj4B0eTwdiLBtChZ
         Q7MQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTuzkzCFcBo40Gau75SxtEbkCNTha4uvI60MaYk2IHt926Qw6WeTLzQwzR0SNu3dEwxiJg2YQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJKDpMw2QQH0VYExqbhjtUe4CV7nJ20Awr5AhH48di0RBhDD9M
	0+AzP61hi6ky+k3NP0ccKm1/kBslsgyS+3Z0q7DkGJSkgTbr61yB2GTZVPee41ledyAXuy8K/rB
	LdUsFBdmfMKpOLetfZLxxC9duBeVyXYQpWcFrffG8HbhrpkBnsguxKX2im2U=
X-Gm-Gg: AYBFou07ocknI0FigqbtE1J5LuNXw5fQwGKm3J5lkx5CgHvC46T9YD3pbJHluf6RQ3e
	h8AEQNlD3MnziC6ncHH9CG4DbNBRAALHr2gLD3Xd3B4xHyOdYCpqsFqKx4/d/uygtj9GiFBAsu+
	1IPWJ17u6ZOHE3hMzV4qxt9uEHxEaFmwEU3eSElQcwYA4ZRaMjN7I3Jhz69fkH30WsKXJ+q1UdH
	r+mv3IpBo5/s8MWpyOHA7Ce8UZ0SGrAPmXmnun91P+tl75sZnEuLqK60UF79JgYenelV0h3mgGg
	PKg0FvqirscX66iM3ARNU6cv12crThHfvuUavbqi43n43WcL6wbW2sanXMVf7eAUtZcJDGicgPj
	agScRsfgTsUB80X5A63yP8DxdTAq9sQfQ5G2KRtfayVP4PWLecGL/fLR5SXu6FdBRcBaA0oGW
X-Received: by 2002:a17:903:b85:b0:2df:9497:3c89 with SMTP id d9443c01a7336-2ea9c953f2fmr51636755ad.59.1793010205687;
        Mon, 26 Oct 2026 03:23:25 -0700 (PDT)
X-Received: by 2002:a17:903:b85:b0:2df:9497:3c89 with SMTP id d9443c01a7336-2ea9c953f2fmr51636575ad.59.1793010205256;
        Mon, 26 Oct 2026 03:23:25 -0700 (PDT)
Received: from [10.133.33.203] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af32271sm14575335ad.9.2026.10.26.03.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:23:24 -0700 (PDT)
Message-ID: <9f76467c-5b21-40a2-95b8-e91cf1e1b47c@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 18:23:18 +0800
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
Subject: Re: [PATCH net-next 3/3] net: qrtr: implement shutdown()
To: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tao.zhang1@oss.qualcomm.com, peter.chen@oss.qualcomm.com,
        jeff.johnson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
References: <20261016-qrtr-add-shutdown-v1-3-e1cc01ca5919@oss.qualcomm.com>
 <179248895481.3135.9231497728918795508@kernel.org>
 <20261021133531.55da7de5@kernel.org>
Content-Language: en-US
From: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
In-Reply-To: <20261021133531.55da7de5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adf2a1e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=goVogqWYekQxIWN7P9wA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: kJDXyGIDiD6dsicYIkbEbLnyNR89U8nv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MSBTYWx0ZWRfXwYXNkIYNd51R
 xUnZKpszN25TyAmwjRjoXjHODSj88404r4aZYni9V2LzHys5fqkvM6LQuxVCZH3Yi7eu56CeUim
 6YVthBohwUxeOjrZAZl4D5zlJqYIZnY=
X-Proofpoint-GUID: kJDXyGIDiD6dsicYIkbEbLnyNR89U8nv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MSBTYWx0ZWRfX7tFkzWFLJMbC
 0CuHet2IVYFSWBaMVKs8otP0E6SWTg8LkLjS6ymcK7XfNw/TDt8N/x7bDNdH6Fjqv1i8bb0LTso
 GdPRLNVLb8bDnwHJeWRDSeNAxm09dZOkqGD8sDw3rjt+2/Py8ryhLujqqajGF8a3Pqhiq9yBRX7
 lGveXfTI2udw0BZPgpZKeckWZ8y3G2hwO9Zl/1dxL1h3PNaXlcxizwMWhQH81Kcm9JWvqh32+Ar
 AwBkCXif0GnArkAUamF4Taolbz2Mj3HBBOJqu6WwejjB1msJtIGkTGMFvVBmzm8/Kx18zFR538V
 iJIywRwOV8+h3bgtHCwt2Vu/hlBmVAoV/UVyzVwgVJAQmh75n8mWiwvIJJnKMs098s1bPsq42Gq
 CeclVioTNLe2J9Sstl73iKNpYe60h3evV+vcZhh5kfKam+AxgIm620wTRHCiR7sAAJoE7HUspWZ
 26RgS7BjCp4DnHoj7PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260041

Yeah, this is a known limitation and the commit message calls it out.

The sender sleeps on flow->resume_tx, which hangs off the node and is
keyed by destination node/port, so the socket has no way to reach it.
Fixing that means either recording the flow in qrtr_sock (and dealing
with the flow being freed together with the node) or reworking
qrtr_tx_wait() to also wait on sk_sleep(). Both touch flow control
rather than shutdown, so I'd prefer to do that as a separate patch.

Without this series, a sender stuck in qrtr_tx_wait() already blocks
close(), ioctl() and the rest of the lock_sock() callers, and there is
no way at all to get it out short of a signal or the remote returning
credit. This series does not change that path; it only makes shutdown()
useful for the recv and poll side.


On 10/22/2026 4:35 AM, Jakub Kicinski wrote:
> On Tue, 20 Oct 2026 09:35:54 +0000 netdev-bot+sashiko@kernel.org wrote:
>> - [Medium] net/qrtr: shutdown() API violation leaves sendmsg() threads
>>   hung
> looks legit

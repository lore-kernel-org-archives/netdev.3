Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A4585974
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963141; cv=none; b=A4kMDEKbp8HKCRsGOtEuWvcoN+gPRTCiGEoj6JEPJ6tneKT3ajBsLtIaqElue4L47i1BnJV2Kl/cwT7djrUutcI5SxNZaBn2oQ88g0JrEDPGbdVSjjkcLZUyncVKuYhXfMJNBJOlbmxRG3U0GcZNgBOJflPxEZgN7pjGDFi6RHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963141; c=relaxed/simple;
	bh=BvWUGhq18+3DDKj4XOXKcGt9/9H5QQsRsuO5iI193ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoBsZ6zpGBsjPlNAk2UxkUSB3pptJzeu9VEtInNmANpeTJd8T+hHexUMEkRxb97uqxFTGyIR/6aIXnbnrAsjSDPpwGukONqsjoCFoQsP7+6uxNkIbDif4x6GBBpMy6JHAM4xcJOdUMuzy/bIOQqUg+Rq6icR28yv0zo24y5mNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mve06kLB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bIdYk4Z0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mve06kLB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bIdYk4Z0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689DIRj22080978
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 14:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xlSdF2HOZ+5NxjHLPVwVCj4ppBlOqupjBhscykPtotc=; b=Mve06kLBnKeOZsKi
	Hzeymo+goblE/6clqovkahHG8lF7r9juI7sdgFXISJbil00mdLwcsbNc4MQlh+XG
	WRiPDggvMYBWXhWM2bDkC5kRtBOBVIHbYmGkDMhJN8AjziHYct36+7yDajq0IQMA
	YBwT26Pkdpe90mmKFaavJySoAEd5T9tb3XwnAQtQUdfjeavFm8MhiXV1W6kpvraI
	jfr4FvgMb9o04oWTphqLFrh95GLKitHhYRAVsIKSMJqU8Cc4mJso4xIrBYXKk7OU
	CS3Berc+GM3Kgy5lKiMx+hAaU9vbTO7bzAiosCJPWBbhRBhXTc1w58FbJEhjnMw7
	kyeE2w==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk87r092t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 14:12:19 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-836caf085e0so85604567b3.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788963139; x=1789567939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xlSdF2HOZ+5NxjHLPVwVCj4ppBlOqupjBhscykPtotc=;
        b=bIdYk4Z03BfNN41I3NkU6gqQuhgj0P0nyUBXzrzueJ7a1TODw5DdpomFlUY7iqIUte
         NrbA4QL504MqO2CR2L2Y5PilExB9Pu2aNJA8RhASNQZTZ2gHWHj4tZa3WaTS/YyL/y5U
         s9VBx/MIt0GUi1aM1wE2N34aJYihssMPFVq62XI7Jx4NL1I+IZWadzHNd5j657pDiDPh
         c3FxaRFKA9yHsvO63lEDT9F5Fwsu3yAg+OEemp1htE5qDpoOtNDn3sUTBjUbTrtk+VbA
         9VBd3jUToVt6lNbWkv4mi0MKcL+Im8id067abJiIHYfrqWf4yyMk1895oRhJ+hQa+rTd
         LHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788963139; x=1789567939;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlSdF2HOZ+5NxjHLPVwVCj4ppBlOqupjBhscykPtotc=;
        b=V7z3J8OKlcKzBUXe8lfGKMhWk04wkQY2PU7P8+Sl+SsPtCkqgy4h465FCRZnrtVX2x
         rwbWhFSP5d9AKvxCsBvKfbPIphn/iykQQ3fa8UTxmHKA8ZWmpJO8ArRDnAfG5yyLp9gh
         mq/Xo6Y+2vjkXULnsFaRKcy05SPmpqxtvB4VR1nWNidsUeODC3sRO4QexEAmUd2zfv4A
         Q9BRIfQezTvQ+ZeZo5TKja4qAmu3ZwUPh7JUTocf3D+v62w1iw8swqaxWeBGy2aA3z+t
         tKmRfApnonIJCkaKhvYJcFX8Z7u6GrlInw0WSANyxr6GIYdEROvL8E72qRg5z1+1AuRW
         2c7g==
X-Forwarded-Encrypted: i=1; AKwUvBwSp2vTsX1CRwuwZw82Ni+0S02mvVKFgjWA4b8dyE+/KefZbuIhserVt6L/yCmqM7qgIA6FGHE=@vger.kernel.org
X-Gm-Message-State: AFuF++lRPoTgp9eMrUL5Da9OL3234mdXzfO4rxFHdsNMpdvMev7x72kH
	8mo/+xrGJiSeIIimiPQKXMpg72DmtOtVXPst4/GSaolYwydAgmqILSWtyyJ0oXTO741YgvKDSKs
	bBmlxKUiceZ99Mgw+T6g8TxHQjtXNIvKFabVD+IK3QqqQCflWac3nJ+QWX9M=
X-Gm-Gg: AYBFou1EKnRT2cZG91f9gUrW5lpOvM+invYBtQiGIYx8nBBK1rjPFc+7pKbaMOPKR4H
	vovfP9cD7xlHSzFJ+HZtphbyqI455RxfiYd49G4CtXtsqBJ7wYDYoUK1ewg1AAzJb/9Q9F8vzfe
	iVqXTxsuGltsxboWYP/sb/UVSHVoJKmy8uCuwKT/q/aQsJ86GT7W6F+7UR9GnTZ4TJwbgOvDek9
	fc6H1Jh7A0XL5XIglc1c1o4fiAHnJY9+vBYZLXR+a0/n+aXy5lt5EkliIYfkVrDrqT5GcOjpmVA
	LntpovcJoMRqKSa4v2Yhjy1kbxxjujgKMTU/f0h+0CJ5iv2+iSPdHWdtuRlxRqDI4NTN1YruQo/
	hxrxHeSgzbCQ3qNn1pXXgqDL0m+pAfVK+s28k/c+9ppK0GmvdsCG5DUdpvFXb
X-Received: by 2002:a05:690c:6aca:b0:81f:64e8:cac5 with SMTP id 00721157ae682-87f22b7eb90mr28856107b3.7.1788963138718;
        Wed, 09 Sep 2026 07:12:18 -0700 (PDT)
X-Received: by 2002:a05:690c:6aca:b0:81f:64e8:cac5 with SMTP id 00721157ae682-87f22b7eb90mr28851897b3.7.1788963133502;
        Wed, 09 Sep 2026 07:12:13 -0700 (PDT)
Received: from [10.227.105.111] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b52f641sm109480327b3.37.2026.09.09.07.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 07:12:12 -0700 (PDT)
Message-ID: <80b5c9ab-de1a-4170-9ea2-26242b767e93@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 07:12:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND wireless-next 00/18] wifi: Add Seamless Mobility
 Domain (SMD) AP support
To: Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260908-smd-v1-0-9fd2d876a1fb@oss.qualcomm.com>
 <20260908125017.0fb226c5@kernel.org>
 <404004c4c97bf776077685b7ec33a14fa777cd70.camel@sipsolutions.net>
 <80266eb9666d6106110d998cb6330868da55bf59.camel@sipsolutions.net>
 <20260908132004.29176fec@kernel.org>
 <0e950f7f0c3f5a2c1f6476e255716b09876624f4.camel@sipsolutions.net>
 <e7089219-ed02-4288-a678-660a52289e61@oss.qualcomm.com>
 <e9b36721c9e2b0b24c89c2e1b5b03b17c438f30c.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e9b36721c9e2b0b24c89c2e1b5b03b17c438f30c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AImJJIpd c=1 sm=1 tr=0 ts=6aa16943 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Q5NyMDGURezFpV5zReYA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1OSBTYWx0ZWRfX3H28/NwnkuBv
 0oiQv5y3bgktNku/8TRIYD8PQnRSXaL5okWxHXBImNwIfi+CQlXQTLehJCegd1Wc0nxPiTZNLSk
 exUg3EL4zu3BWlFWPgZFO2eyigmeBxAvcW5Lff/oGNKJvzzbp99yE54NDqbjgFJJF6PgyhLR0fH
 w9G0OD4ZvYzXygM+3jxYo9VqbU90Zxkljv54WH7/QENJ094B4gz1gKbaJP/wNi8+IRHb5ftu+jH
 91f5O3yHzzo00vY5amQdSZOONB/vaHs7y5NBeDQmPJsYh4frh0TbpoLchBDAKpDOuSyjLJMiBpc
 zZQSmRq4hlE17dW0cpvFydQ3K8VSV0IlhkzGYIWk+K7R7MUzzreorSDniW2kRyFEs343IbzmDbY
 6sZfEdAFIFQWuRwMzmlNLvtoDl5S5XqhphLOecIlxNm4iY2AhBsvRQLNDARoldui1mbVfr7Bjow
 FlM7ttQzeoRb7gDYRPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1OSBTYWx0ZWRfX2knoddz81B4S
 rIUW0SEaxYJC/x12D8sV2K0b/Vo5q471EEcjOK+V84GoNdZv3MBUJxhjqjzBoIFq1QK9+RIIRlo
 +6TciKb8T21u9cW2Xp92JOuGZjSPfb4=
X-Proofpoint-ORIG-GUID: sCZJZd2PUMLW5fFqV2Pefeg34cXDmV6u
X-Proofpoint-GUID: sCZJZd2PUMLW5fFqV2Pefeg34cXDmV6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090159

On 9/8/2026 10:53 PM, Johannes Berg wrote:
> On Tue, 2026-09-08 at 17:20 -0700, Jeff Johnson wrote:
>>
>> Apologies for the AI-like commit messages. Those are at my prompting since I
>> want these patches to be understandable by folks who may not know or
>> understand the underlying details of SMD roaming so I requested they contain
>> enough detail that referencing the spec should not be necessary.
>>
>> AFAIK none of this code is AI generated.
> 
> Did you read it? The comments (in patch 1 we were talking about) are
> also all clearly generated.
Commit text was AI assisted. IDK about code comments but I've asked the
developers to be as detailed as necessary to justify the design/code,
especially the SKB extension proposal.

/jeff

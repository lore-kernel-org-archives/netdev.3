Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261288;
	b=fdUx5bC/lMx6CkTfChvkH1TZa/I99i63FXUIQmEpz+AV0qwZg8RrvKNtqkmrIWViUYXX
	 /+9rwLvQSclnPy9sO2CFkxk4ltYCmvMbqCvR42G+SKdbEB4uw9dX8uPdV4p7H8y4zotUz
	 wou10li7rzxenvbg0fHJMeZ5rC2TZgdDA+SXH0ixr0U+6Jsm3a6TgrOa+2g3K6d36sLVA
	 /Yv0uQePcGReQElj0e43qwJlvWGLpb7CrDB9y7NmY9gJQ+U56j7KGae8XC+ie+mlOCu79
	 MycMnwMcW1dk2KYPcfPHqXwsaL1mMkLIBU/mpgJQLiExJ05XceHT3OpHAWVIk0wuS8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261288;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2dGnBacEascwLV7PlpDA1yoO3iuD70WS8ruoY1ymrZk=;
	b=E0Ao1nWRaYRxTJt1N+WG9gddePDtaRsArzPe7LphFZmlzmysosAPqXEhNZqBK6r5x21V
	 VrVY+ROq/ZjVx7kfD5greEg5+M5aHPfzxYlp4cwK0EDDDSyUHtBRrtB1b+8zyZA3XrR28
	 yAmgVxL09HO1Eam06qnB6Qx6FGyxKqrgBKo/0t1ILTGw1UyieHjDHPEqFhE1Tj5K2NS34
	 vS/jEcNSe31Es99Axl3YfHIp3d24og/xVHuRFbgKLfWUnJAf7huNkWtqeOtcjyE2NraGn
	 Cfq2sNWeMR3CfVLhEuLYS+AW1zEAlqe/10vIGgRwsz254/vj4Y40uWmA6OpxZQVU9uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aGzoY2lz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SiuOJP1F;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE5606A321
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75FE5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aGzoY2lz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SiuOJP1F
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5HM432244876
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2dGnBacEascwLV7PlpDA1yoO3iuD70WS8ruoY1ymrZk=; b=aGzoY2lzhLKgvZDS
	wavnmCCaDeVdjFZRdROWQEq+yZyCqjXxo6IqpJHRcBg0fVDIejsA2VXy3BUUc1Ov
	WEuxBpMNsbfnyns34QVDvSFWcakINl2K18rPbPsFHqtOZF9m8xa2Nuf92IeeN08h
	LQld35e5J98OjSkUMblxn2NC2OTepzx17ODRt71p2IdBgj67buaWqbARLY1RUcZg
	LNc75is+7ooCV/pTuo/6YNkY245hxPXq14FiAspIkPMNUIPLE6kKn/shHqbx1O4k
	nFRDvZiDFkk01RinKZ8meXFI+NH2vNMESwzCQPBGn4yIHS5OD5GaOiPKxYtNhO6n
	1l2zDg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s8q7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:08:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ea71803effso19649495ad.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793261286; x=1793866086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2dGnBacEascwLV7PlpDA1yoO3iuD70WS8ruoY1ymrZk=;
        b=SiuOJP1F8c194OafCX524DizHsokakQu1GnG3B8AwOnjYGyjGKzjinJDcyUWG7Ex0O
         laDevBnRgA88Yr86hjgB4LKhTeOloQ3NyfoPHcHp4Sk1zWteG16M9udLhKAlBOdzp51h
         5uYoJ7g8z25RynJe7DHgFYfWj+Fiogoxxe97OeQHpTaeQGGvmop5yv4X7J3Z2dzmTgwv
         9lPHzJiiY7EyHEmde1plV6bViKAAXJcSKfMKvOo2NJTuCotmTMSJmKrGvsdNq+Z0HO52
         kzQ7TyvxOL1txHzMynd6EsYmZBAvLhSrQIctBmPZjsfOJewGLZm1uO21rgmTMealKvbq
         WsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261286; x=1793866086;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2dGnBacEascwLV7PlpDA1yoO3iuD70WS8ruoY1ymrZk=;
        b=vOEGntPkAySmVkkC8FjNBKveGOJ+U9lKXyqI48gmjo1gsKzwfR0b8RJAqxEcPhbDwX
         qFaGnRKKQ3P+2SOV8si816tQnxjCaLr2d7x2HklEP8F7k8sJAhqLTrXbqy+49POGm3dB
         M/BsW5hgXbOtG++eO/tQGQFybYgRd3/fAuEcSZUUsRJpJ2kpLLGntYuZ1e53kZS2OaiS
         Xs5cIeEe6zm2WYtDv8xhXgH9TilDEKFShBQdfDhV5MAwk5GLdM/MUz3kxaV/5NU02sZa
         IvluYR3QhtbOnLqaB933pJBwbZYOAw7DT3nrWAOzxwNmlmSNaTcwib1z5t65AdDZeCMX
         VSPw==
X-Forwarded-Encrypted: i=1; AKwUvBypXySSmwS/UTy02M6jkADOMnvwFHDIOjnD/VK2TEpsIJjlU0DelF5q6eoPs2yy1YTkgYxEokU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgW9oOQ1Vqm+24qJUOJBCUbeYyu6xOK99zVweBepT5UVS/BdAA
	3w1Yigzxxv2/29zuoYk14i2Z0vTJfy5+UhZGUMhTJhy1XlMoRqBcTQiDtHro1RVxbvJ6fk5IqFc
	dLVamAMliqI97TVnL82POOnFEygiegcVJMqhDUPtCtstrSStw/HgLppXeCWg=
X-Gm-Gg: AYBFou2G9wiY8tCBQlumHNaEVCijMJxX/xuR3TYIYuHVGLUH1h6/RAcjmEBpsrCojbF
	ltmaDVNxK56+30OY0kgQD7fdNtpzi/28urvnnOOQXxS8dYlt4RyKg5UKGyuL+DrDHGEGsTlN0YZ
	+1LW4ma+YrO5uVIN2o6fYZrUTQsSJulEhAvIdSdd0/JQt97CN8xYSROGU/R6e37bazRNRenVCug
	6pDgsq9y7FmEGOvatNFGhe6OYOant1KtlNEYE095dJI5V8y6fpWz/5sI+Epr5M46Lak2Ze1+KmW
	H3qzsY16jpNKT/JVtwE3SIPz6ZZX5+mvy+lkGNlUqG9Pf9FbBfLukep5YuS4Kxx2GzvoiLYb29K
	ryVnmzqQLZSQRvyyFn26CNMjxbHd1ho/xfi5q5EWAHPM/rl+r+/UyecEb7rEjm9HV3H9rR/Nb5B
	6piELEjPnfnThTUfmPGq6UjV6q4gmRqDQ5Ob4uE7sg4HjT
X-Received: by 2002:a17:902:d485:b0:2e9:401f:f0f4 with SMTP id d9443c01a7336-2eb003dcd00mr40685205ad.16.1793261286203;
        Thu, 29 Oct 2026 01:08:06 -0700 (PDT)
X-Received: by 2002:a17:902:d485:b0:2e9:401f:f0f4 with SMTP id d9443c01a7336-2eb003dcd00mr40684995ad.16.1793261285721;
        Thu, 29 Oct 2026 01:08:05 -0700 (PDT)
Received: from [10.133.33.227] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c37539sm30068785ad.49.2026.10.29.01.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 01:08:04 -0700 (PDT)
Message-ID: <b8f90e57-4aca-41ed-91e6-27fc072d98e9@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 16:07:59 +0800
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
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sashiko@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tao.zhang1@oss.qualcomm.com, peter.chen@oss.qualcomm.com,
        jeff.johnson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
References: <20261016-qrtr-add-shutdown-v1-3-e1cc01ca5919@oss.qualcomm.com>
 <179248895481.3135.9231497728918795508@kernel.org>
 <20261021133531.55da7de5@kernel.org>
 <9f76467c-5b21-40a2-95b8-e91cf1e1b47c@oss.qualcomm.com>
 <at9XxF32WiKBEJQY@debian>
Content-Language: en-US
From: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
In-Reply-To: <at9XxF32WiKBEJQY@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfXwXs9PN/osQID
 Tvwa1TwzgTADeM6yrukMLkT7X0CpDHh0CeKHKaOGf/DYnZnq92ceUdft1a5kKTTD/Zsmv7PZ/JZ
 H7J5WCiRmoQlUe3hBKiAI3G8QOggisN/jk1U2HqkS4V7Y8Igp4opLN3RVf8dJzR7bqMA40msPbG
 WOq+Db08CVdVhOiQKbrG/YgviaYbyRYUV/mYgCF+9sM0ADCvPckpXkEYPREb8ahf95gBppERNND
 YSUAMei6AcjYSTnk8BZRumaQnjXnn1Xohee4pcxgvRpJNnV1Ah+EcwiTPIXugFTKoy2cTWZxwOy
 v6fAeA1IuLENJIXM8D3/7NjhQI3ry1mN1UeJLc6MLxczHW8exzcI1SSQvmy6u5FUKQF7LAyRXRH
 UeFM2ckOOdR3PCFw7eYvYj09n/0dlp0btymS6ChnoWESYvcE3L3cb8tKkHhf/n39iJCQJJ85l7a
 n0ljHh8vvDX3RbdR3xA==
X-Proofpoint-ORIG-GUID: dJ4NQbpBlQyJrE-hQUGPCYwlJMfhk0N3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfX3FKXIEZ5iAd9
 hY8SqvLTSTVBnfIlE+dZy95HXRoN94WoEa7SJVgut63RY9JPo+IKe5/g8sWH95Uh7Zlt8R+e+Mh
 iKMN0QLSlnmRmiJtt/AjeainwXZDdmc=
X-Proofpoint-GUID: dJ4NQbpBlQyJrE-hQUGPCYwlJMfhk0N3
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae2fee7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=OT3QJeMhKsL16cy7qL0A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290031

Thanks for pointing this out, you're right. That is actually what I had planned for the follow-up series. Since it is outside the scope of this one, I described it as "no way", which overstated it a bit. Thanks Chunkai Deng

On 10/26/2026 9:53 PM, Manivannan Sadhasivam wrote:

> On Mon, Oct 26, 2026 at 06:23:18PM +0800, Chunkai Deng wrote:
>> Yeah, this is a known limitation and the commit message calls it out.
>>
>> The sender sleeps on flow->resume_tx, which hangs off the node and is
>> keyed by destination node/port, so the socket has no way to reach it.
> It is fine to defer this fix as a follow-up patch, but I'm not buying the 'no
> way to reach flow control' from shutdown() callback claim. Why can't you just
> store the 'qtrt_tx_flow' pointer in qrtr_sock and dereference it in shutdown()
> callback to wake up qrtr_tx_wait()?
>
> Storing the pointer here is fine since all callers of qrtr_tx_wait() hold
> lock_sock().
>
> - Mani
>

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B77535FB6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075119; cv=none; b=TWQ8A/Arg8Z5giUK/hq4lqKYQv1NdF05iQHqVYOlCSAC9w2ZGSdHDGiMK70bTe88C/6S7BbcdEE6Q2we+SCoPwD38anmB6TzRodnRuX0EchdSz5o+JM17Fdg4kVYaO4L+vZxeRlt1Tw2XSHtLnzi5wpy/GUdP2olI+osa/4ABN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075119; c=relaxed/simple;
	bh=UbQgd5un0qukt/+fB9cHHvTZOjcrEQ9kR7JHq5n/lh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQBgZSepdEtSItPZ529gRsxkf4ESKkRYFX7WZDr+JKbInoJOBbnjDvFi2fYXArAfusY9Jdgt+amyLMjssA7uKZo5kBNqGWNj429lgn/CfJUJFC0UStVBknV2jkDZuJSIiNjjCI+B/Hn7KNthwexoITjKPlRM75nO9V+lSEBP6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V2cuTS78; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hisv+sUk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V2cuTS78";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hisv+sUk"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M7i3Xu2174209
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qpELZ5f9XpMmdmJv5+YoiaMSy8WH96P37pYEqhI4u7g=; b=V2cuTS78aB7dwG5g
	p+VNYNNaQvlPwj4nxua//Ea0uIQcnxZqPmLBnMURrWOKkXTx8flCiHbRoVe8Sz95
	EkPdKqpnsL5kgIfsMMF94wIrrqRM970pOujSHfA/JS1MmcAMGyt9SMMjpl6Yl+SH
	6zTobyTTi2m/GLo2RMPR+n7gQYktokuHhcFfKIJzrUyjosZ4AYlpy8wS1lsda7U6
	rZ3p5clKxIR2ryc0CsvQBxfjrefxcU3xpF19G9d45Uc+lwgVQl0uTrlyx0rIUfKS
	c/tmdZjNm5/UIK/DE/P/JSgZLHp8hBpLEkuWnpfRv5KU2e9A3mWdanMtx9ywwD7E
	saWuVw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsqa2hp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:05:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db3d832827so52156385ad.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 04:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790075116; x=1790679916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qpELZ5f9XpMmdmJv5+YoiaMSy8WH96P37pYEqhI4u7g=;
        b=hisv+sUk9ed8+hnduxQxvfKEyzBJZ2KuXBuTBVF7sJl2mAbUui3jj/0bHjIRIgvjg4
         tZ9UFwgEz3nPCjlldhiHjpI7t8y02tmyJvkaYJ2Nil9PKMJX63JorkkpyVLASLjJbJNA
         fKE/zrqAppXj3zmv1UGZ70KpQB1iAU41bwP1H3PIXVyRjO2GlIuUzy1tl6EUbnexl9HF
         +SR3GnhYE4KQPED0iyZhlP6VlB3FPkzYjZ6zsmrFUpZH7cHafnyVDeHDpRrhn9SsaXKB
         e7QziB457LOv29ZtXzr+mV9q6J5l5fq6CByDkg9xZNMqCQpbUV0ClmLyxY4DITP6FXyB
         G6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075116; x=1790679916;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qpELZ5f9XpMmdmJv5+YoiaMSy8WH96P37pYEqhI4u7g=;
        b=flazhzV+T/ty/3PvnOolvGkPrEqrWYSKPiLvehh8PXvuwo90NNoN3m8jWpfE1e5MyR
         pcGlInBcN0nIeJ0oznn0uM7HSyqiws4/79HYJhL1t22haPetFJ7CGaDtcfgZWWo2Ry9t
         eMBepfl8fY36OqV8Dafua9+lscepU0Sp2Ka0no+g1zOcKN4/Y18wJaGuXGvrWY2icMr1
         a4Vjiz5mCLtz54NFOngfgExDGEQg4QVqTZsDeet/cgqRA9HFqkJdUNpXiCuk6FxyO1Q2
         Buw1q3NZdJsvtKmF1IlrA1NXf1rE7sK3Lmz7UCx783nCeZuoP/vapu+4dcWTJzXhnN7H
         GaZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIF6m5tGin4901YOvvnTLqXY1Bc/URak1nqksg6/g8A9zpZt41d1HHla80TOpDBZHmaWTlwSs=@vger.kernel.org
X-Gm-Message-State: AFuF++lop0S/ATYDB2K4MlA8dQ4bhOblUkRPeE/v5dhq+Z/DcVojfJ0E
	OfKjiPXeq++YOTepPXv3UdByOjvtiYCxpF4uXxcuZjeFa+3vo4wJsc/oDGFU2EpGGJIzlbKWioa
	e36aSdOXwHPAhL2WQ/u5HjopEJagIacIR9X7n3jb9/QdNTdgALBinzCYrE+go36xzgV8=
X-Gm-Gg: AYBFou2YgJs8S1g7XiM/7xi0i43vWOJn9DzoEoCWgWxWRWa8xAuhHoOfD6DVIwp8Ijh
	LZIj7pjjVuTzS0mPOotrnMr7rP2jH5lo5zsWClFfwjFock/EpR/W4eCL56XzxBwpQknJBkGijkS
	ZuX/NNYmjoBcJTol+y6R4FJ3XkcmLsZQ38fj8kuRCYLAdra5ODcWKzjXEsrsXYAq2bFIMkL9S0K
	xoJoyYZMzhR1nUhbJ+k4F8yg0Fj7inFO131WzMOnAtgH3ZRnmIckhzWsACbfrcGfYR0SwYjFmnP
	YvQ3CkQWTf98kMIjiH67uwLk3m1XbPQMV7eRDp7Me6feIFMHvSSpnkglF/vgjYDzxu4NSUoydH0
	unjUPP66xE+3vBYF/PK8N30OUnrVSDrq4EmlG49WS6El7N5g=
X-Received: by 2002:a17:903:24e:b0:2d9:2fc9:5706 with SMTP id d9443c01a7336-2df609b0c4cmr8781955ad.2.1790075115978;
        Tue, 22 Sep 2026 04:05:15 -0700 (PDT)
X-Received: by 2002:a17:903:24e:b0:2d9:2fc9:5706 with SMTP id d9443c01a7336-2df609b0c4cmr8781755ad.2.1790075115554;
        Tue, 22 Sep 2026 04:05:15 -0700 (PDT)
Received: from [10.152.209.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e61340e56sm6822733eec.30.2026.09.22.04.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 04:05:14 -0700 (PDT)
Message-ID: <c802e9aa-6261-4dd6-8229-8c9862965d87@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 16:35:03 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: ath12k: Connect to the QMI server belonging
 to the device owned by this driver
To: manivannan.sadhasivam@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>
References: <20260921-qrtr-multi-ep-v2-0-27dd80d841a0@oss.qualcomm.com>
 <20260921-qrtr-multi-ep-v2-4-27dd80d841a0@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260921-qrtr-multi-ep-v2-4-27dd80d841a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lbMv3_yT_XLqO-nyxbZ_7XI2gS3NZbGv
X-Proofpoint-GUID: lbMv3_yT_XLqO-nyxbZ_7XI2gS3NZbGv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE2MCBTYWx0ZWRfXw9AN91CF0QID
 HCwWV58Ak99hESbPz6UPJbq18dve53pdXm2IRABep6seKXkZ/CrnYLn865aIEPxwX86ev1rXYhI
 B0yBDAdSOd9E1PtjeP1GUgqpTVRiyt0=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab260ed cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=bQg6oyjaoxrshYPP:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=R4z_reooDQMcG2LTbH8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE2MCBTYWx0ZWRfX6CPZGEp8DmFu
 TkyeRFhScnfcwRsOb7dz0EEXyfn9T0vc2iQpM+iICz7monHtx+6khAgJpAm8JhRXEsXuryalXkx
 mzvZBsyC1ssQmmNkqR49k0oQMjCq2yRaTJZfTBCDHq1VeikUkypRpTy1BihLvEeAkwgPs/OPM2F
 xaM7gzZBwPl6UodTvA5Z30JnmU5GDxEVwyBzdibebQULIsnKL2pRhxHOkS+Ku0yKMAagfCAAmRx
 mF7N7y3bvJXWWHeKRkzUQi9C46okDAo2LQD9L3klB+5NdAKNUs+DcZV19tLtR8kZ4hRLEaeXqBs
 mNFN35kx+zEDzWrQYFLPRE3YaoqVeLV2kT4L1XFX/fs/9k3JfCumWUDEFUwXFCfYMaoBd4PNXrX
 PdqZT5NIZnrhNU/3KY5Z8bapvOEORaAyrl+pNMfP7OAkpexGBl2pbX+eJu7wWrlQD00TOSN5EIG
 P7C0eBi4kRzPMzWRF6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1011 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220160



On 9/21/2026 4:53 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> When two identical ath12k PCIe devices are connected to the same host, both
> advertise the WLFW service with the same service and instance id. The QMI
> lookup reports both servers to each device, so a device may connect to the
> firmware running on the other device.
> 
> But now, QRTR provides each MHI endpoint a unique node id which is
> different from the node id announced by the device. So use the same id to
> pick the correct server. Add a get_qrtr_node_id() HIF callback that returns
> the node id derived from the MHI controller index and zero for transports
> that do not assign one. In the new_server callback, skip any service whose
> node id does not match. A node id of zero disables the check, so transports
> that do not assign one keep their current behavior.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050489;
	b=YDvfqG43Dy2U3n9XVpJHEPOE8WwzQaN4o9JBrU2UNk/LVCqXCSlOzcJDCWdhzZHdhaKw
	 L5rJXfL/UUUc8VOJoRO0HO4n7POknXYjVJdO6aWiYTJtc6jmwsRQ2ODcrbPWGh7DJeDvC
	 KWwkwv9f3Mpf8RpnqItpeLQ33MGPlkp94PM5TKHvtm59tfPMMHbv0vmlZFaYD7rm92FsM
	 b//6jUFFU5T+6yFqLmsxF1v3/z6fbMMwCsumfzA4sIwWeGsSEbqvBDiYAaJPrP6nee/Vz
	 hJyEXL8BVnRGGdR5LR6H5h5zotW4Y0N0c1sk/amqHAz3AGLg6Ohg/QMizT1O0b5mJ+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050489;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tAd8MORnWjoXl94lwOMxgtVTViC1oD0+1RnyhP9e8qA=;
	b=XfvtwhBQKuD2IHfrL8BE4ybvEkgFs3BLUM8W+/3nk99vKMdHdSWYdmr8UNt8lY6KxpNa
	 hlyt+sydEDvX9fqT4Csn3QWavfVBYY3uQeO6AMqvAmGvAXTfFv4SiD0Xa3CaCCo7xyiUV
	 TPayKvNMQONCHUIfzwG26/ju/FpNzfBHVtEW06kSkFiuz2tm+IcIrcpfCA0AMyqFUu1RY
	 y45APoJ4gJ+HWI/cJ0byg5r054sxxj2xAu1o1yVtGQeesdbzvN4YtQHuAmkjL4UqgXYOp
	 mxhacaDY9SoPAXISUhZ9WQbXE6WXSlxZKqoo7nwDXgPMYLTIw1NekyMg40cZoYPAc4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SWj1g++T;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jkn6mb7P;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750C606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C750C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SWj1g++T;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jkn6mb7P
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QIoFQ3986053
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tAd8MORnWjoXl94lwOMxgtVTViC1oD0+1RnyhP9e8qA=; b=SWj1g++TF+yDUQr8
	ywP/9IqD0m7ocatSpMQy8Q8jDT3oOj4l1AKnxfYt7NwDHVSn7oZo922VNeVKwesH
	SCmUvdRkVSjj5lrCE1gqiQ2SkzGRynJOJpV9CID3rXqh8xs6btFZmteeIYKeopa7
	9klJ900DpTVcKDxhNly9YlPjwrvCMjExoMwOJjr2q90Bj3DEP47t1k27rzS0aYLR
	BGUzBjh7atVnRzw6c04Budrs2hCTw7GbfskyWYrhrl3pkIfpn4ddnwlfrPfMq9qG
	vsa36kdcj5yhOhBRDY6Z5T2l3WXxX3ylySjHtiZvmAH5vSk/T4qCGEKeFnDC/wER
	7hBolQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q2fnr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:34:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35cbea41088so5542345eec.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793050487; x=1793655287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAd8MORnWjoXl94lwOMxgtVTViC1oD0+1RnyhP9e8qA=;
        b=Jkn6mb7PLfiXNftKzZLoZrh8nZjG/G6KYD8SBkYZB4Lyhnz6J5jLVWnE/OIdqFEgii
         l57H3SLBVyezx15LQRSJAvsecejHHnbu62wHXwc/0g7WBJcic0HcFn4iOCy97L6DMV7w
         GphViXWThKsXNU4nglk0BMT22kZLH9doo6dt1s6eGao2MdgmcXrN/TbzWD47TEOhYpOP
         F9xdXGcltXMtxN7VHu2FDBIorM0S184a0LBMDlIl5ZI+yjIidOk0yrHrb3ct0k2do4GS
         sbz24SnVChtpzJjcxLZI8v+kmSiaPCGfVXP83RdkgusSWAKvl2E8jTarSs7int50nxMy
         hwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793050487; x=1793655287;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAd8MORnWjoXl94lwOMxgtVTViC1oD0+1RnyhP9e8qA=;
        b=GHsL99lVfT3wPfZLACY0003r7Vwmh5QrQsP0zuqTeiiXv4KUT9iBsroK2OnKTnLlKK
         ogTe7CCocg9SlpsKlJXc5f5Xne7udVl00qx4JA8a1dwMevJIwxlQ8kpJ3BhBKscHZBp+
         wm/gZvJNtXCKcmI5C8PZVbodsmyVcHOeOS3EUovxpXf9yBWapznRUoGuivJYjt2F2gJD
         hr7mIF9bDdO9ailk+dPkR3bytyfBbno68peO5XGqwoaMSbP8FZ+wcU79OGId12JAPHnc
         /DFluj4LoCLC29vgYji0vmyuvin5G7UYXdv00KD7LJQiwBHYFZXtYTx7zOfp8hgddZvA
         ITIg==
X-Forwarded-Encrypted: i=1; AKwUvBwNzCkcRarcDHTthxjjZDbbDBkyux4jupo609TbUrpZjV7OrTiraOWfhB+w9iWk4lp8tfbSaDI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAb2fv69CA4pQ6TwqEeEOSTD1lM1DXolcFmwtmGehlzYh4UbF0
	JaU7E8aB7NuArBcHYgDNY7GRZ+6D7QCoKoUlrTpVTeQV34XO0tr+gqZid/BBSIQixAcZI3JSYF7
	jwdK4/fm17YlFdA/kcydoWVRHLc4fG9biqWdL8UBHikPz85Pm/2EEBGG8c4c=
X-Gm-Gg: AYBFou0jqNJ4oqgRFX5kyMyt4s0NcmIoGkfssYiNHXCvnmrTXpWwTrcY9oAlUTzkJgg
	Cl9eQDRgxSob8af2Vjs9dKu9WE1+6kye+JHNpVPHNbhc2T7hul4y+2ygIiKmde6NGtoP+EHSCwB
	HENrXdZR+ob0joeIiV438LqaDAgxLurKPAhmCSrCYYfXjezyz3Q0m/RwB4sNOGZnOGm1PdaLwd0
	CXFscWPUYxYpICv0NJaZX96prwf4/yPrzDvI6dKHt3IMEyxpU5ku/70v3otckK68hLpoByZLirF
	RPx4/nvcfKgtTNGS9qPp/dtFcfJTFWDqOSWZ5HinIujeQAFmJpHV7OGBUQjL1w3AVfMUn4P68pG
	aL9kOSKRwX9RWQD+moHFPCvFkG7vV84VBtYNHRWToFOCuS8zO15PhfxuS4w==
X-Received: by 2002:a05:693c:42d0:b0:361:167c:2364 with SMTP id 5a478bee46e88-369e845a30emr11787575eec.8.1793050487026;
        Mon, 26 Oct 2026 14:34:47 -0700 (PDT)
X-Received: by 2002:a05:693c:42d0:b0:361:167c:2364 with SMTP id 5a478bee46e88-369e845a30emr11787520eec.8.1793050486424;
        Mon, 26 Oct 2026 14:34:46 -0700 (PDT)
Received: from [192.168.1.20] (33.sub-75-218-193.myvzw.com. [75.218.193.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm32084643eec.13.2026.10.26.14.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:34:45 -0700 (PDT)
Message-ID: <5f6a27c0-9e84-4314-b221-6bb9f82cb1ef@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 14:34:43 -0700
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
Subject: Re: [PATCH v4 3/4] wifi: ath11k: Connect to the QMI server belonging
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
References: <20261022-qrtr-multi-ep-v4-0-c6fdb75fcd3e@oss.qualcomm.com>
 <20261022-qrtr-multi-ep-v4-3-c6fdb75fcd3e@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022-qrtr-multi-ep-v4-3-c6fdb75fcd3e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NiBTYWx0ZWRfX0BHBuYncU/G+
 +egxjpQer6nAM3Zib4EBL2Kn+cbrNQ+V0LshKBF6oIYe4n1X8Leh3gRzytDc084fN568OpplhcT
 27F2fTguc8Vv+aqjYaXni90Z/lYKD+Y=
X-Proofpoint-ORIG-GUID: hkjMvXbomb7Ih3E-LwP0QoqtnH4WeknQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NiBTYWx0ZWRfX14giOw67TY2i
 6vsiTmBmuG8fA/H8rKQtr+noWkQanZ8snv0pOfYvE+t4njpp/Hk8aX0RK7eiA1OTP+8tkY7DhSt
 w07/mym+/BEMo5Vca/zptiMXSTOLlTd3XXoaZr8m1OrrI9U7ZzvJlbbBsnj/1i8RBBc9INWMG+p
 ctMQVXxTK+Mmk0zcnwGzqSrUih+vsge9LetW1n4GGwJQpaR+3LR8RgCiPsHl6C72vmd7SNxUZi0
 WSQWJDVsC3pSX9DJ5RF7dW0W2asK3YFXZvv6ZLMyEiOMDiG5vrWbf6vpBH9JA5Mjk/Mv88iJrBc
 JEAX1rSHJ8QQDdLTf4kFIqmx9OzEj/vO1b3xOta20q23yLdUdQRq6FiQ8j/ggmEwZrNiwPk8Fxn
 HuMnWI74n3Ghtb2Rcsm+S0KvygKum6ogYh06/dig1dPbp4ETI9azHMyuqToEPiBXNF6/hGqKiWr
 BZ42iqfl5OSd+k18srA==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adfc777 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=AnolQpdaNwb4XK4FG+QP+g==:17
 a=bQg6oyjaoxrshYPP:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kpOCkfKLFM9ZImtyOV0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: hkjMvXbomb7Ih3E-LwP0QoqtnH4WeknQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260086

On 10/22/2026 10:43 AM, Manivannan Sadhasivam via B4 Relay wrote:
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index 7dc07339b957..6d86e552038c 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -3170,8 +3170,18 @@ static int ath11k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
>  	struct ath11k_qmi *qmi = container_of(qmi_hdl, struct ath11k_qmi, handle);
>  	struct ath11k_base *ab = qmi->ab;
>  	struct sockaddr_qrtr *sq = &qmi->sq;
> +	unsigned int node_id;
>  	int ret;
>  
> +	/* Identical devices advertise the same QMI services, so connect only to

nit: note that networking code no longer uses this block comment style, so it
is preferred to have /* on a line by itself

> +	 * the QMI server on this device's node. A node id of 0 means the
> +	 * transport has not assigned a unique node id, so accept the server
> +	 * unfiltered.
> +	 */
> +	node_id = ath11k_hif_get_qrtr_node_id(ab);
> +	if (node_id && service->node != node_id)
> +		return -EINVAL;
> +
>  	sq->sq_family = AF_QIPCRTR;
>  	sq->sq_node = service->node;
>  	sq->sq_port = service->port;
> 

Since the requested merge strategy is for netdev to take the entire series:
Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


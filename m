Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526E3EDE70
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821680; cv=none; b=CSXL1wTBjjz425XX87vu/whRvnypQ/N8nGZbR+FriCc9fQr3PUGO0aEygELYLZUyd5U0ab1y5o+l4LRnliUlxiHlUJmhpY5XiBi79CV1dX7Cy3Ip44RtNhEFBaw65FtN5kXGRcE85SllST5j1If57lrnbnGfi1b2QuOZJyWWek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821680; c=relaxed/simple;
	bh=Vfq7tifQqkrQcDZiRviC31PSIJy8viYJL1W1oSt9PHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPqyuSNJv0+0a0yoZdVoxgbwlz6jTXEYouQagN4R+EPQeHKNGT39Fk5DZp70BmUeE6VmD3m2QFowRpeW3l0hWV+feyLN0ywkdP2d14wlljGxuz/vh/KucBqHwKCj0Jwqs+l6zhLTw+QlthjDPtxAUVKaaQTLXj7yZrphi2E6UGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y1Rrhq5y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gJSA3mSq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y1Rrhq5y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gJSA3mSq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mvQj1605003
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oBbce1WRUs3G2E0RY0k9esyoB3WwxEZLpDwnuzZhw+E=; b=Y1Rrhq5yt8TfNDWs
	EgLGPzpahCcr/ZfG0Sl64RZ5vc1iAyxEEkLH1gVw6YQ3d+itWHbU9H9bJAzAcXKR
	2/A+vh1LtOvqK7yf5qXmxGPN5wP6RNqQTW6KCTswuEgDz0nX8TYHu5pfcZpPeHup
	CbHdMu7jpW3GsAnLW8YjKvbzZDJ1rn867EzrtM4f7+vPrirw/3bfTvvPIzPMLQz8
	xSE6O3iF/rkQQq8UazZS2apXhMw9Q8sqNUmdOBUiGf3kKrUUD9ga2qbaEJb86ud1
	c/nDhl2v+J03zcyY/JVJF3+Hl7IPjvXeS0+icmcN1p/XJTSwqj/BuM4vw0fbh1fd
	W+wZiw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfjk7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:14:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e6415f279so16979985a.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782821678; x=1783426478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBbce1WRUs3G2E0RY0k9esyoB3WwxEZLpDwnuzZhw+E=;
        b=gJSA3mSqhOxYzhwVyFJNYHow6FwFnKi+pJoqsL6XfYL8QfaQZX03o1IuF7nIpipc8r
         ILmP8vkg6b2agZeCYHfKfHTTt33yyC1RxoD9ZwSVK3Ve+rd+ABaE4KR/bYTEMGRnPsJN
         FPGZiE6gWiFMedZcPBVXKFsXNlp1fABVcsH23jFunIkutrmLj6C4svRMcgKsSXI73t6D
         2F8WmhzKxpbQfX3rGe8OCafQKYBwinvcVq+cQfvHsk6tie6yfzz5fW4ycRI8nlASOfiw
         CHav6QhNoTkm4raNSzGCtZWVUXO1gW7EzzcKnjW3UaQmfpYQA23fVaz5Mrt5tmY2gabf
         PRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782821678; x=1783426478;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBbce1WRUs3G2E0RY0k9esyoB3WwxEZLpDwnuzZhw+E=;
        b=qVIGslbB+05sT64+J53NjxSgmsvgTc4zmgjEEqBCCi89vwtf5h/fnQrNXCjlUa4yWl
         OxYpEj8GsA2ycY/YlPZV/WpeEznfeSml1Z7XBJ6+yCQ0PfknTPawBpIAdc08wYlwKfP8
         2jegy4INmD5u/rCPOmfMtLkG89ZhSuAJIfdfuSn5Gh28FQlg/75XTHlVK/JX8rcJVBGS
         djpZjALuSlZS7U08D+iDOo0XL9H2r9Kv/oxtU9fPBVnaUXk6yH1oHMcytFSWtt1F8QRT
         6RwA4/0QW+Uk5JhPcGrtRQ/NOXrIGZVuNfSrzdmk6sYXcKdfdjzWAuyuYbKXcwQP2lcR
         N6jA==
X-Forwarded-Encrypted: i=1; AFNElJ9tpy06pJQ4pQsjjnIIiGVpeNBGWyyp6fYpb0RcB7fydgvZbPH8c5x0F9ulp1SEPSmp5Gv3YPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTcN1V+Tl33LORECeAffAMscldw05DD33KAHg10dR3iXH6/X0y
	J6tD77apDg1+ZrRW/EC/OeBoajH1ze4Aq9odhxrGOdLfBjKHMemJ7JG96XZIOYx2fSuJxDl+KZf
	mXbhenEE7AUsf2CMU0Pqy+1M3Yi9/yMM+S9p4nzP2XN1wlfVRskH/RPD7gyQ=
X-Gm-Gg: AfdE7ckDnrkPa75qiMGaC4H00hs7HqOcpkRN5nIvjUZdiZiIWTiW1eZF/Xg2vYnNYxH
	5M4D+zTQSA1wQ1o2yconjT8bWPj2Y92QFFJNIXm5oDFEkbs41UjHj+Zcj7iny+/hSSGFlVB+lQh
	1/T0DNxzC9SGEiQbbAmdrpUuy4bLAtsjDE6r4qp5ihzVj9vGPslA5qi/B4c2mBT+CijmG5bWrKR
	QliKqHOP7hjRbxdxYLv5T2Q9NHa0Cqck8d05FlEtBvMzvblVcWwV8CIq2A0Lfyl9o7rxT1nMRzg
	BTTDl9GnRFOAAN7IAsH5KgF8SmcqDfryV2xmATxEXeQpwQ/nECK2XTUlh0pXUlKXTZQkwKwqxIg
	+ZJ89rPfoexc5TruZI0oWPauhW6v2xWs3qME=
X-Received: by 2002:a05:620a:2589:b0:915:7c1a:1388 with SMTP id af79cd13be357-92e627e197cmr355400785a.5.1782821677740;
        Tue, 30 Jun 2026 05:14:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2589:b0:915:7c1a:1388 with SMTP id af79cd13be357-92e627e197cmr355395085a.5.1782821677127;
        Tue, 30 Jun 2026 05:14:37 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1296b1f9cesm21325366b.16.2026.06.30.05.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:14:36 -0700 (PDT)
Message-ID: <dc7e58d3-4383-4d93-a38e-699888bff903@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:14:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Wq5vuGTVDWy-7_0APT9hFfIw1CxDGwdl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExMyBTYWx0ZWRfX8Nkev3MQKHT8
 ACkDcnuLzkJMCyHAAInGYLULDkserZdLxQ+DROKcesNyCLnkMQ5Ucd5QbH2/zMPI3WEUyNbYMI/
 6eR+KuqrSPJuNqsh2Swv5MQ6s/sR5K0DiSGCfcJLjKjmA+DU45VexNtb5Xa2nO+cK44tYCZ1uKe
 slVzciILcWJWgDOPg+Gh+6ZgZycErrZJjT+M9rp2xQSwkWf6BEYx/Y2FflrZIK29hW1TAVUPUlH
 kxVmsPaA8qVW909TV8f7eHt+8eban4hTmdZTMDKc8QtIFrJKsow7UsYV5CBdUdJjKcJ7gGn3jUA
 SYPMB2kI35zMfLH4yVPpPji2uIZASqUbaMaaa4rC4cf8+lYCupGBkKtYYDEJAmpkpRpQ4DUOiAX
 6ynYGCYdjR0psdR1W+jl/6DJDeG1YcoQVdjRK7s2XQAlP9IT7+maWyLAJap9UQGr/P+pwOBk8nU
 7qhD8RR492MpqJ53k4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExMyBTYWx0ZWRfX4pztf8FZpXtd
 iOKORiOz9RDrVhFcg6gbOxrEEBZh3AgKPG2jGsakTFDf3az4viHQT9TK6jkqKza+rvVi0QvgOm/
 SNL2VczJeUvqFdtZUg871Rm2fwVSCwU=
X-Proofpoint-GUID: Wq5vuGTVDWy-7_0APT9hFfIw1CxDGwdl
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43b32e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Ltt3hjjT39zhUWiMmRAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300113

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.

[...]

> +bool qcom_pas_is_available(void)

This is the most important function, for which I would expect
kerneldoc be present. I think it also wouldn't hurt to add a
footnote in every other function's kerneldoc saying that this must
be called first

Konrad

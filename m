Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BF496D2D
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154379; cv=none; b=CltLH1LNFcYrNvua3VDJiujZ5XOEXvE0bGRsn1TEGtc7ZFDsswVWPXfxGW7Mr+B8ZoCVSS/ntmG7sFsblMj2UkzHwtMctWY7EV7omvuTlelry2FdmwZgropfp4TcvCeJHKen49gTVOXtuD8DiAFHrr20pOTR+nMEZNT5I/bSF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154379; c=relaxed/simple;
	bh=82SHgbFXIKNE8cz4W17AtU4jvEU/TKRageBEhE7plQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTRmAuLbmHG0FF0G/YUv4wRYz+/egrQ0a8HM/APM6NVrqZhIDbph/VEoOsPyYW94hTNDGGOOdCaQNlCqvJEZCVAWy/iP6/TJndRAy+uvH8uWYle+0e/cDWaEgrLvE1FGSFTKaamdLWOuKccM6flNuu7BkaDu9pPoWPtjR3amxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gux0B5Ub; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y4trg4ve; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gux0B5Ub";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y4trg4ve"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHXY24138493
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 19:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+DpU9d9yKH3MESahifjxuxIqp5MAA0YI6mbsse4jUfs=; b=Gux0B5UbIvbrfSbG
	WCX/heFkRvUZQPCsQkJxJs6z9uWTzM8Aej7j1ybGt7NmcHA2OguMmVbD0NgqwuBq
	0N3u0x8yfaqAjas7TWFuxjrA1X0LLYDmzok3TSORTsxkp/dEdOxYWm+9UWyqn13O
	9dZsqi+l6sGyMIZSxbDYUzEOfvi+PyIVR3kpCKDPYBgzaX590uIFSb/7lIqMZDFv
	Uj+/Zx4UcuVYyMESulXadJsHbEq+rIdZN2gdrE/E05MooV35KpIssBgB1vQ5bU7Y
	Hw+iRLcSLrKuLoX+WtvwyZ3rgTu1ukdX2NeAjdLexrMz5/QLQZEsa8i4zur36xHf
	r0sshA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmfbbjc34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 19:19:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso2431718a91.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789154365; x=1789759165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+DpU9d9yKH3MESahifjxuxIqp5MAA0YI6mbsse4jUfs=;
        b=Y4trg4veBSE7o+VeoiU6gZtZHs75ZUKME+r0q/WXpZCCfstrPIbtpYtoDvtd9/qP/1
         2jrw4lZ2Y3wnfg3tRIniRZwD57fM0IJWIloinnnE5VYntC+4ZI2dKiDi7DHP0wafczle
         Yo/rVCjMtD9EzexodMMuBLT5TaFlze1zSNS90K0blOinU2mLZb5Hi3eWVpVk8GIx9Tn2
         rzr+vWzhdqkDm5S1ZVS9+fUgrKFQkh1zwnicPFgKTbelqYUQNr//eQ71sHp+47cvBDrd
         8oCmnCbrkNK7bJzYMCH4PO/tX4ieuvk+ovb1Hdjnwd+Rh5LH85MX3rQdJvpARBPmi6BV
         R3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154365; x=1789759165;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+DpU9d9yKH3MESahifjxuxIqp5MAA0YI6mbsse4jUfs=;
        b=JfMATkYY4tevaIMs0pKpPIDETOhY4NsYDZfIVKMfgAghxdpegTLEmXSctvM3WzHFRW
         safYN+qIODehhud2ymoCOWz3rivPSTbK439j7DK8yh04Ntzo/r7bjIGPjjF7vNhJZnbc
         xP0kMxksoWrCkPBMOjlfUcreMghvduI+L18emcyhUsQT/ptQZ8LDQW3UwbfXEq01Q78a
         PWOE5fthfcASzLy1kUIQdJ0ds6xj3cyca6Jq9Kc8wwPUI1uejxKSghidgQnTV4W3xJb3
         R0mMIWcHCto8A9cbqOpNNaIzrEGMk5Aa64nBkD4/QB93n16N38vT+e41Z3cHH5fbV3q0
         arww==
X-Forwarded-Encrypted: i=1; AKwUvByYSfjJrlzSfq1ntkGvU19DMMBFzGvQAiYPH6kE3gudsQVAb2kPhuD6eU44S6Apbv+MnA+MTcE=@vger.kernel.org
X-Gm-Message-State: AFuF++k58Hsi3szRfUAcan2cZyVstXUEdtAZkm1YHL1sSoqCJIJ9FDOf
	XGSUY2r0ftOvnoepEozKT49+VFUlXon5LR9LXaaHduObNUissvHoz/G7G3vRjMFfYIofPHfeQpu
	qbbHwBZ2F+L//mophK9NXu1CFU5EujAyF0aZTnPW6wj/shBIKWTQrQT0drtM=
X-Gm-Gg: AYBFou1A9LPO81Z5cfmRmc9u8MtLXY+Fg6JL2lnujayt7waboeaOk/RF+4C9hNhmvH8
	s4ji/bD5UtU3kzCl0xHjiVOfQCkGqbrlKe8X+nNzbXcvkX+duyvpSu8arQxTex8o3WDZd05ioC1
	cN/j0ecfS1PrF5JVgYOKvsSRq3tv4Vsnhbxk2Y4U7goUdEqmRP14CniKaIOxvGBSUpE3cPBxL7q
	xXsbbBaog6PIp0LgbJtQzUXvz6+hO+Xsm282gJritD/T3SAOFIcSyjQ2a7sBTMNysbdGvXWqBri
	/nQ5kzBCaqMmjlZGaSVwRxNKqBmtj/8qwyjo+K4McZtGL2dXQaERgDFVsoU1uPIOmS5JEd6JqHE
	sSFQ2D8WpFSV74VN5a51HsC5CD+wkpMdk0Xaaa5BXj1z2zlBUdTxwaubSGFJm
X-Received: by 2002:a17:90a:d64e:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39d9c1db130mr11183552a91.13.1789154364733;
        Fri, 11 Sep 2026 12:19:24 -0700 (PDT)
X-Received: by 2002:a17:90a:d64e:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39d9c1db130mr11183505a91.13.1789154364261;
        Fri, 11 Sep 2026 12:19:24 -0700 (PDT)
Received: from [10.227.105.111] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a59b18sm8253073c88.2.2026.09.11.12.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 12:19:23 -0700 (PDT)
Message-ID: <ee32feeb-e626-43ba-926d-5786aaf1d960@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:19:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] ath1{1,2}k: support multiple PCI devices in one
 system
To: Juha-Matti Tilli <juha-matti.tilli@iki.fi>, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Mihai Moldovan <ionic@ionic.de>, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260908093145.2492666-1-juha-matti.tilli@iki.fi>
 <2cf63e00-95aa-41ba-ae8e-8abbfbc486e7@app.fastmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2cf63e00-95aa-41ba-ae8e-8abbfbc486e7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eCjQhmrz3ReX8xeEVNURnTwqad6d0yse
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI3MSBTYWx0ZWRfX1iReoansmLQS
 0GprJiaI3yk+vZO97RTt9aLEpDd95Sam1nFZzFsku41qE/kv5oJEadLhkjQJKNcSVbyB6CLu/2p
 dXFp57maZtJcJ+VPRX3/Eyp1sQIKC1TcJnXym9QcNckcsCVI1mneQ3qGKaa+W7joxCJ/uMNSi+/
 v07xQ27SbbBg7HSGZTCs21bD2idPUxYzLfg/i/DEqxwYFWCpfWlPkFbvJ7QCR/ikyWHz54MeELr
 Y76NsUUJBP1yJyAgYDNyYm23d9G+EWTrbD91fA+QZxQjN0uyaPJVKfoVDR7fdoFx45Sap42sjBp
 NSNGIZF8W5EOtX+kaSuHrJdKFuBkZrmT4dQufc9rSQv2G1I5i0TmVcZrI5Yd29LUoh1ebX0VGuW
 hG6GPjmI3XKjZzACwC57FKsViWw1rSfK11NwBRfiO8Nribdxmoa0Yk16EGGPyr21Ljo1kNvO0A0
 5Ylg0jcmX4a9STBL2+A==
X-Authority-Analysis: v=2.4 cv=X6jHu2Te c=1 sm=1 tr=0 ts=6aa4543d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=b6wZdvJBkCi_B7orZsMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI3MSBTYWx0ZWRfXw0RY5wKWhF+V
 +e0sddyneR/iJN3RJ6pAr84o+TA6oaTFfC+i5zowKBC4JK1zyVxf+B/71RS28zpLXxnBUzltabf
 jr9DFV+wspZhql5rIRWSFYsvTPuIJAg=
X-Proofpoint-ORIG-GUID: eCjQhmrz3ReX8xeEVNURnTwqad6d0yse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110271

On 9/8/2026 2:44 AM, Juha-Matti Tilli wrote:
> On Tue, Sep 8, 2026, at 12:31, Juha-Matti Tilli wrote:
>> As you may well know, multiple identical ath11k and ath12k devices are
>> not supported in a single Linux host because they use conflicting QRTR
>> node IDs. Fortunately, Denis Kenzior created a patchset to support
>> multiple QRTR endpoints with identical node IDs, and Mihai Moldovan
>> refined it, after which I took over the patchset and refined it more.
> 
> Hello,
> 
> I am incredibly sorry by messing up the threading. git-send-email said:
> 
> 4.7.1 Error: too many recipients from 83.150.90.33
> 
> ...and failed at the patch id 8/12.
> 
> So I thought retrying from where it failed would be safe. But that
> broke the threading.
> 
> The next time, I'll increase the waiting time between subsequent mails.
> 
> Links to mails missed from the thread:
> 
> https://lore.kernel.org/all/20260908093437.2493698-1-juha-matti.tilli@iki.fi/
> https://lore.kernel.org/all/20260908093437.2493698-2-juha-matti.tilli@iki.fi/
> https://lore.kernel.org/all/20260908093437.2493698-3-juha-matti.tilli@iki.fi/
> https://lore.kernel.org/all/20260908093437.2493698-4-juha-matti.tilli@iki.fi/
> https://lore.kernel.org/all/20260908093437.2493698-5-juha-matti.tilli@iki.fi/
> 
> BR, Juha-Matti

Unfortunately this prevents many automations from processing your series,
including mine which utilizes 'b4'

* b4 am -3 -S 20260908093145.2492666-1-juha-matti.tilli@iki.fi
Grabbing thread from
lore.kernel.org/all/20260908093145.2492666-1-juha-matti.tilli@iki.fi/t.mbox.gz
Analyzing 10 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 44 code-review messages
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v3 1/12] net: qrtr: support getting new endpoint ids externally
    ✓ Signed: DKIM/iki.fi
  ✓ [PATCH v3 2/12] bus: mhi: allow mhi to know about its qrtr endpoint id and
free it
    ✓ Signed: DKIM/iki.fi
  ✓ [PATCH v3 3/12] net: qrtr: mhi: register new qrtr endpoint id for mhi
    ✓ Signed: DKIM/iki.fi
  ✓ [PATCH v3 4/12] soc: qcom: qmi_helpers: add QRTR endpoint ID to qmi_handle
    ✓ Signed: DKIM/iki.fi
  ✓ [PATCH v3 5/12] soc: qcom: qmi_helpers: optionally bind to QRTR endpoint
ID in qmi_sock_create
    ✓ Signed: DKIM/iki.fi
  ✓ [PATCH v3 6/12] wifi: ath11k: add QRTR endpoint ID hif feature
    ✓ Signed: DKIM/iki.fi
  ✓ [PATCH v3 7/12] wifi: ath11k: stub QRTR endpoint ID fetching
    ✓ Signed: DKIM/iki.fi
  ERROR: missing [8/12]!
  ERROR: missing [9/12]!
  ERROR: missing [10/12]!
  ERROR: missing [11/12]!
  ERROR: missing [12/12]!
---
Total patches: 7
WARNING: cannot prepare 3-way (series incomplete)
---
WARNING: Thread incomplete!

So I cannot evaluate your series.

/jeff


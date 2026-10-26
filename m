Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995777;
	b=HP1iPzOCRtdkOZJdWNY0Q5lX9D9W6ZCMcXtiq53u0jHXkFa2qIfzn6J+2dX7lCifZ+Br
	 k5BU/ke7ZEmQ5CES8HYvyDmEFQqu5QKvlg/ZMbzteu+gkvpPFVpwkItuXYBJgdgYcTcsX
	 5eFvG0mzGDTQEAS6DnAQkTk6WAgqUB01WP+RXGcUNAlKaV6zvZL4Z9Qc9Ff0foDtV0iv+
	 LEk/X5hdcj3zCGPTNlaD/kRzV2a5PBi7LAJYulgtJOhpc9lg+WHRzDSvUTUiulwNGdXHE
	 bMqb8Ov8eAwwqda+EBvLFRT/7i2Dj7Uh1zSkgD4t4ERgfKcVclmB+PbzhemLDQk5DfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995777;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BRGzkDJlyaYo27YOEoR3qSlvLhrXH7ug7jX2UAfMTGc=;
	b=Z+gRByEqbp5BUoZj8tUfFtWAT+7Yu76PnxNPN0Xh/S+k54Q26Tyg6uDXFW8E3lG+1Wjk
	 IZyS2vLEx3UECKrKI2x5be7UhiRQHPHz3RtbhXE9XEfB51++NLDBmefjkU2eo4h1kl4nK
	 CbzeWxYgDVZoTCJ+Eb3AdaV9KbDCMeTf6vmVKPkKKvx+bW/e0D9rPL/oDMkkQWqV+oq/q
	 qpVSElm/CQey3uZBfjXa7f95u3/W6ZdCfy6RAFT1wanNasgaTkm1dgYVeKKiWol297Af1
	 dpSqMlrhgluEg1mcZCjAMkFNZz7idR6I7JJ0EFWj9NfqpZB4wib0Y7t78/ZlFwt5lsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Igk+3iVG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yjep0Xqf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46E606A328
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F46E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Igk+3iVG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yjep0Xqf
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aYGL1708753
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BRGzkDJlyaYo27YOEoR3qSlvLhrXH7ug7jX2UAfMTGc=; b=Igk+3iVGlbz5b6tB
	V0gA1Nrz0Jly4J1OoNE4xjoJzvyRPSUvYvWw5qqIicKvSIFMpsef8xt0gCj8xm6u
	m+3YAe/99SqF4IOPJYeMV3u2Ko1V4qRB6G2Y+eMGuU5FssFwDbDQYNrc36fCvlYc
	O0BbhCKv3duQ+abRD280UU5h5nx3fFj/1/w+yVP+P/zvM4xQI18VQikn4VPcPZGP
	nNEITFedz13srfsp0fnhIfkYyy5z5Y8hYyDCG8prtOzLpxBgNC8oL06RDGX2Qody
	DkZl0Q1IRZ6f5nDTmYLGJMLnUFa7PLP0gfiyQh+/vS/XClLzwNAIG136J9NUOcwJ
	xlMm5g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjd9437-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:22:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c5aef2a74so13393331eec.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995775; x=1793600575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BRGzkDJlyaYo27YOEoR3qSlvLhrXH7ug7jX2UAfMTGc=;
        b=Yjep0Xqf6bdTiKRuVRARy9CvCTiuRZ2d68nGzYVb6CtG4BeVFbiGQFvJ9WKUU9ekGT
         nnGSyKxquyu1S7mZnNDih2yW6IXTP7Kh6T0SHWeyx7ynpHqYBbWk9JUIRGm129+YhIAY
         LFiMHW1zLFueThJ7ANwDRsCUFW54wZlH6AGpbEe9Ga0MTKfoLKSYL/mQ/hEnyeKg0w7p
         t8n3Rbw/FbH+4BFfZ/6jc4gdCYd6aCXQNWOLxUbMmC86AbGd6UBEdn6iwvGGBjdl8dvB
         TogHWygR0R5YLouI4QlovcHdCbGcUVJKo8Y4iFmDpxhhW+7NNkJfAWz+oac6TsTDd7JZ
         WSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995775; x=1793600575;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRGzkDJlyaYo27YOEoR3qSlvLhrXH7ug7jX2UAfMTGc=;
        b=Qs0tjRiFxh+pya/ryey6bWLIFfWg6l48n5e1FR8wQ6bEAC9FaZw2fPDIWyRyPADxQR
         F1BnHuetAxFxS7HPDU7NEg+dDJqm5fjCOCOht78thz7qnJf0Yoy3l2UB+cw4sLRofLh7
         nNct8qFJ7NRlm7hLu+gEMMc88dsE2lfYzSpTxfZqo1XpFPjuiIYSyUCh9UUbMnlae/LG
         OOkZS8p0037oGT5FYZuHL6hPJol3RCAN63zq8yDvOy+vOpm6K2erFQy/OD6By3uLBMkR
         pIUKCk/g8cMLFVrYzp+ivRWgjQsorC8D5eI9cgg4kkLrl8RKO+5M913ccvDgxsTakjgq
         IOTw==
X-Forwarded-Encrypted: i=1; AKwUvByGogWLkUL3F1G8liLadeNwjicE1LGvB1ZWCFjWsgXL+P65T8ZtdltMjcZn0ElvbclpuxVeN+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIm9k37RShEwRiHGnLEdk8zqS6/888bBrSzqHM2J6gHxmBtpuAP
	uYhNseAVcENELzp4EuIsgZTLdD3ZIqdniz7GX5cKo2Z2bFmMWpvCGqD8PNUmzLTiGytyPDuuF4M
	1tsr4apGissvpwruwTe6siI1AwFLyoDupo3v7OQO1ZhQYBlGKWAbIUR6KuSk=
X-Gm-Gg: AYBFou1T/QBuVDmfhbjLC9PwjX8urdADsFIskIyowlhckPI1+iivw/pE1RuJcjWi1Wa
	fSaFVQ8iI+wtVQHdixf8T00Ann7WRlzSXoLrXORXJCYgNYDc644mZ0yK8sdLgT2iS//v/XKBkuS
	VU8oDFddC7xCpweVmfZHpy6100MP/bAAfTh2LWb/EvEQNuzeQayCSIs+WfvnDH6+pMifwVTOTYW
	zJtz0e6Tgas54F5uIYwZgrMyu2pH/itwQw2v3fW/aGMnBH3DXiaI8YRM+nnM54Pkax+GspeO8ZM
	8hk6e0z5+j355owdvyvxlPwipUYe+CoYaT3aF/+HrPv4l2qK/VFMHc5rOKcgg+1sXKRrgOndurS
	F46/Ynrw39wExSC9NEtJa0E237SrwzaW9
X-Received: by 2002:a05:701b:2405:b0:18c:e014:6f1d with SMTP id a92af1059eb24-19929a9e465mr8204918c88.1.1792995775075;
        Sun, 25 Oct 2026 23:22:55 -0700 (PDT)
X-Received: by 2002:a05:701b:2405:b0:18c:e014:6f1d with SMTP id a92af1059eb24-19929a9e465mr8204894c88.1.1792995774577;
        Sun, 25 Oct 2026 23:22:54 -0700 (PDT)
Received: from hu-daizhuan-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5a515sm19719783c88.19.2026.10.25.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:22:54 -0700 (PDT)
From: Daizhuang Bai <daizhuang.bai@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
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
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v4 4/4] wifi: ath12k: Connect to the QMI server belonging to the MHI endpoint that received the packet
Date: Mon, 26 Oct 2026 11:52:20 +0530
Message-ID: <20261026062244.2875432-1-daizhuang.bai@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022-qrtr-multi-ep-v4-4-c6fdb75fcd3e@oss.qualcomm.com>
References: <20261022-qrtr-multi-ep-v4-0-c6fdb75fcd3e@oss.qualcomm.com> <20261022-qrtr-multi-ep-v4-4-c6fdb75fcd3e@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P1SgA3RZWyb826rjbILsl67xh7tArQQk
X-Proofpoint-GUID: P1SgA3RZWyb826rjbILsl67xh7tArQQk
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adef1c0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zDojY5Dqmkyknr1b:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=nUn8ewCANHEy0S7HLBYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4NuksgCIlO6x
 LnvGLAPvBsVobwZJSSXd/gTVKseQB/kw/d3rxHsu9k3XkBwiT5vFq/blFFqrItHzfRN21A/G/GE
 A4X5fD3eIVl0AuIsGJ6h6JbE8xqKVnU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4FWJpv3Elg68
 TnbEnxxC/rPkUqvvQUExL09yzViRtxzWcLXFFir15gigcrOLaLiHBgUYl87ntmOTtn9+1oVr3k3
 YcBa2XC7rVMc2dIqhbFyB0UaJJB3lUUxFB5gbalkzfndb0MJ1ful6g4IIrDsseVjKftwL5OjM6a
 4WUftGQUN9N4WBs94MqUa96joJpq9l0bEzy91sQsS5MwXr/02/5+dw1+hoZCx4xWuesazBnTenT
 NA22/+ZdtCQgI1QzT7Mawq9b7kpisbf4p4JDi3Tfw0Hpwa2vf3ZUeovIFVeUXRjiJdgrqFc5bY/
 jLCes6FNc5CnklSeX+hkJxUEn0o1rLLV4dgJfMIryrNZm3j37BzNetfcef2qbg/6UpBEUjppf7H
 SRY2QRKE9kMAJh29cY5LLQDbWB4ZN6w91L1d0sksgotSKuVfwVBj7INQF/FXwleEwK9gtqT9jYo
 GEF5jEv8uG5r0XqflZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Tested-by: Daizhuang Bai <daizhuang.bai@oss.qualcomm.com>
Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00277-QCACOLSWPL_V1_TO_SILICONZ-1

I took the entire state of the QRTR directory as of after these changes,
on top of 6.18.44 kernel, and with some trivial changes to avoid conflicts.
Then I cherry-picked the ath11k/ath12k changes, which
had no conflicts.

Before these changes, Cologne WLAN QRTR NID could conflict with CDSP QRTR NID.
After applying this series, the conflict is gone and WLAN/CDSP QRTR services
work as expected.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320431;
	b=rcJjBi0aQZuBivXgmNv4aRUbWkeRhkPGrFtf4PaTMwrQkTZsDhaS9AUuVqdZTGW/foW4
	 rRxZjuvUC8wAs32TezvJ4IBXGVkLw2WICfVrnkSmED9fUobAeQkj8q1GYjPIUMws4vYI5
	 Fuxggi6II67JKgWEdpgojEyoF/xSLMgSIyGTBpSiIIbbmocf45+CdtxAaiu2uEptw1sOr
	 /TjHlLin3fpf3cov0tFpeV0nUH6fmFOEQPmXgVoCNFxOVkxkr50T3XrCTWkkmjkNvTqUw
	 ZXCsP1ZS0aIe0J6hQ/N52IRrmgqIymEj8Hj3f25dxzMsUGDuMg9n4TlUY/NLMpJYIZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320431;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ck5XRRHP22m9X3iNZf5BjNhfI3aiyPXUvxV7zc6dD6Q=;
	b=AK7d+rNMlu6Xr7FdgoEmwi8R3iCW/z/aTY9bl4bw1A8W10BA+lNHuI6W/AVlrAajS+7s
	 3vNMYzJM02jKmfVMFbUDAXh87UHhCAgSqEvjvkiIUFsRkywova/VMbipQtWTm4vtDuNY8
	 aIV4lTlaDP3kIugBXPOTO9lRgKaVBJZZ1aYtE0oNqdAwyBUNPkvag8A48o5VcVX8EcQ1L
	 B93ERdR7XZUJSxVbE4KA3maGH8/nyyISyjXQk87IpRsYpW+BkQBQZfQ9npZ1uvDR1ad63
	 hKfRu5NgkAO+WDof8DBUmhuPwEq3r0hZM1mOwpX31EIal5mHTU2dVol8SxOR7KdHqqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l7XBpB57;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="SQufQ1k/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857860A262A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A857860A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l7XBpB57;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SQufQ1k/
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9qtE3228357
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ck5XRRHP22m9X3iNZf5BjNhfI3aiyPXUvxV7zc6dD6Q=; b=l7XBpB57foeSGerC
	m5xXsz9xfKW3IDra2zZuwsxdvJkaQ+sMPB3p8LCrhBZTcHvBCSCwRuaGMNY4MCEh
	NyeVGcW1zNS2v/CIMe1i+iuwtlC6KRZgc1a9+WDr+CeB7Aw6+xBkdi6tB8YN3Uhz
	8UsZStqrHjrDSMX3kSDwEVqZSQ2pjvPynMWFSW/vpRtXRMldcfC/wwVEtMjQ0VBR
	WpGANWEThWa5E1yEJguRtPxpNoRUuCUNeVDiUOFyFnsyNWXZoiIn3MO+tjXoB9vQ
	8Vt+wOJxBnrVmVJtiCDnzJRDahla2Dy92Lt95CkpEBRgpKEtZgRO2CfRizsfEdSv
	yTxC0w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d9bmq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:20:29 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7d2e2cd9c85so1583376137.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794320429; x=1794925229; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ck5XRRHP22m9X3iNZf5BjNhfI3aiyPXUvxV7zc6dD6Q=;
        b=SQufQ1k/vqtFYIYhBBNozDJ16NuqRj4sTU+pN1B1GogsNWWHoHd+u8YlVJlQu7q/KA
         5FwWlxjGkk3dwuRTI3pMT/FyOGFRZbAGVPtzLc+cNvnDU/NAdDdyacxx+H68apFaZXo8
         c61FqIxrknJf8LYMzeQg8ZViJVaxjrR7uusIzoiOUauZYOljIuMK/VnmAWG+dWJKQ8RZ
         VNFXU+zkrhcwheHv6rD9OpWlhhcqNW8gMtUI9XRaqYiHvSxlmwrDyJH2iHDIropfywqi
         d9zjiI9zJy4sjuKcNSGRTCLfzNenEmxXmemMmDaYgfNUNVlHXKyMwBxq2vZf23GbioRH
         3HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320429; x=1794925229;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ck5XRRHP22m9X3iNZf5BjNhfI3aiyPXUvxV7zc6dD6Q=;
        b=Py6ZT9MGVvEbxhJnSzYpEdxH24Qf2fAuZmuawif3Drz+rqJzZRDw0zivbpCaz/5Pgd
         AmH7l2nqbGLHcA839o+dUkbtcGKsJqS+b57Z3vuox30krcPyR6i0ldc5CX5SvatlhUEF
         5wpN/+iFOdaTt5Rmj/Cgua2ZtL5HGdkIndKQcq+T8r59dngvKPL4AL3afKjyYeFXLpbF
         F0FfASYymb3IPS5GxoEq/jcJzDxscmQc0TGc6u26W+Q6Pc+WLq3jIAjaSfpqDDNtQhfl
         IHyWqPkvOZINutJ5NwznO5NfQkAR6e5rzSF4woDEtvWVX8owGZQtiQ7L5afEcFJ6Szhs
         ijAg==
X-Forwarded-Encrypted: i=1; AL+hErG8ke80Uy7NLB0FK6iIadHFNcQ1Nvh7aqVX2VpqJtIustshi4Tg/m3YygzQh1ZnelKVnzel7PU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9r50nVgNSszWC8xYvJjWS3ORWpXNf2lE8B0C7yn5SspW2EpPxF
	PzRYUBHG6p043bxFPOm6+lusTF6wgaLg/0Ylqdocpl46YnHQjHv4l6z/LYSdqlZCToj2HSLMiOz
	BpINM0zr73L+prhojXuHSuwkodUYDtV2DR1l1Ya6nSGLsaEUP9F0micJs/MY=
X-Gm-Gg: AYBFou3llkwgjKmiGQygEIY99pParVvj5Ok8LiXTDuk6SsuZ+3RJFtMehAN7/mSm/Yu
	13VGZ4abnMpSfrLQXevdO4DN1c+fTDaB1uLAWQ+ceSSv2ak4blZyn8u1n54wjSTel700jG5qeHB
	Mr/YO1GN1QFBWgRasWEMAVZa+qZIHKAwP0TzbSjA2PPz2trTJIUV+rz1HwIYAjfRGrEsVNm8ETs
	vfSoXzgQEfB+iq7R7iv23kRtVn628Xm4+Rw1mBLkheXnGc61DdjlZvw5UQqg6vJ4AC1ICQH2pJv
	sEETUQtTXZG5Z3qZP+Yxq9mV0JbDhoZ2UH3O2sWBi/DD6//W/uH7LY+Y4W9fp6EElC/fm/aBUtJ
	WL4G7FBHW1G7yZYpDUwelBEiUx9dhy0v6utAAfWWHqeQbXeViouj2SBIrpo08c/qOGDNG3hBued
	CL4YkviQSDaU0sLg==
X-Received: by 2002:a05:6102:e14:b0:7cc:2cef:b330 with SMTP id ada2fe7eead31-7d301b90875mr1015847137.12.1794320428758;
        Tue, 10 Nov 2026 06:20:28 -0800 (PST)
X-Received: by 2002:a05:6102:e14:b0:7cc:2cef:b330 with SMTP id ada2fe7eead31-7d301b90875mr1015820137.12.1794320428242;
        Tue, 10 Nov 2026 06:20:28 -0800 (PST)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365ccbccsm5242319f8f.44.2026.11.10.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:20:26 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v5 2/4] net: qrtr: Assign unique node id for
 MHI endpoints
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261104-qrtr-multi-ep-v5-2-4cdb2b4f1920@oss.qualcomm.com>
References: <20261104-qrtr-multi-ep-v5-0-4cdb2b4f1920@oss.qualcomm.com>
 <20261104-qrtr-multi-ep-v5-2-4cdb2b4f1920@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:20:23 +0100
Message-Id: <179432042357.601816.13272349217674070278.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794320425; l=1427;
 i=youssef.abdulrahman@oss.qualcomm.com; s=20261110;
 h=from:subject:message-id; bh=pmxqB3moG63ZiXPlatXfrHmi22c4brr8zAmv5UPA8I8=;
 b=3VK4IzgRzDq5+i8kNkOpzL1wcBaSJdMg4/naLLQ7vN/3KPtJH+B1yfG8lIp5w3xiAoLLoYDt3
 ZVuSV7r+yx/CX6B9QgIG7xJ7bIfu+nOZyq4a/C/87nhN4u704Cmn9aw
X-Developer-Key: i=youssef.abdulrahman@oss.qualcomm.com; a=ed25519;
 pk=JsDnG9UOJiLmu4WZj456fEwZASBHFVClDZ4KZkiVFAI=
X-Proofpoint-GUID: bHqz-2DuSuBnOAakziS1o4JkjDbBugMJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NyBTYWx0ZWRfX5pLH7/ZIIu7a
 3FSKH88xMGAGAb2P8OumJer3g/8PRx9/IaWo/djfDgOmzW3QKG+oM3bRzlJNjDmbouEWl8WMcsh
 hF/qYVlu4Pxq9+f3sBmPugTcBXNq66U=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af3282d cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=51d02FP0LlRxlB9DzpEA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: bHqz-2DuSuBnOAakziS1o4JkjDbBugMJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NyBTYWx0ZWRfX4qhDev8v7Zgy
 EYOD7OD+vyB8T7yiCci3hgtHDX/gt0XOqYdYeBPuvrhlsNW8GiIg0Ix/ky14Zd1w+kfjEIuT/VL
 umXVM7FqhU6NBwRzia5c7JmEVrLlKT/m80qy7qkgKm+LPRdTPQMIWN2dy39LcjF2amCzJpp5Bv8
 GLVNesrysvRPKzgZjXKlBHqAJAdOSBNiTuGxcn28xaJuaMVFOVNV30J40iDg6AYF3okWhKaQh9/
 sZ1js7TmmCFJP9+5YdgDaWKUKf/3G/AZfOlbIkHWQ1M7COA0zz2/LAGjvjiE9JDjEvLf0zw810O
 6J86Qi1YxgcKYEZjE96Pkx+tZRyVU0dhi9nq8I++mC3UrltjwxFr7KoXbjQ8m5ZFCD/IVglLIHh
 eQ+jbpuyTXU/qhtbkmUB4hMTQV0j7waFA0IVfpgvHmshyr70HbkdhqB5gJAyy0l/REALr27i14H
 IVMB1+g2oIJenrgDuSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100057

> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index efa70b95f8a7..7a59ccf15490 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -11,6 +11,7 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  
> +#include <net/qrtr.h>
>  #include <net/sock.h>
>  
>  #include "qrtr.h"
> @@ -590,6 +591,12 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
>  	    cb->type != QRTR_TYPE_RESUME_TX)
>  		goto err;
>  
> +	/* Host assigned node ids are not supposed to overlap with
> +	 * remote node ids
> +	 */
> +	if (cb->src_node >= QRTR_NODE_HOST_BASE)
> +		goto err;
> +
This breaks the functionality for QAIC devices, and any V1 packet with
nid >= 0x10000, for two reasons:
 - V1 uses 32-bit node IDs
 - QAIC devices use hw_sernum as the node ID. I am yet to see a device
   with node ID < 0x10000
This causes "invalid ipcrouter packet" error logs to be printed when the
device is advertising its services to the host.
>  	skb_put_data(skb, data + hdrlen, size);
>  
>  	nid = cb->src_node;
> @@ -615,6 +622,8 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
>  		const struct qrtr_ctrl_pkt *pkt = data + hdrlen;
>  
>  		nid = le32_to_cpu(pkt->server.node);
> +		if (nid >= QRTR_NODE_HOST_BASE)
> +			goto err;
Same concern as above.

-- 
Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

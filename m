Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123133;
	b=rwSjrRBUR+uAD7DfZ4hTItj5QkcD+ikkhNpI2VTqVW2F1YMvVauBqKmqVs/EhKfTj67x
	 rg2OKIIoI3g/PZXyvBzrv8rg6NdkN5bFn5PBk8RcpaWErVArQasduN2Vh+dUOJEfmiDxw
	 b8U396GEfzV089PeHxqyhh+b84ZMMF+eXWLr1fN4t9R3FzmqD4yLgjOsZHPNK24O92rTF
	 PT+yozFpCegfa1kMfZ7UYOAaxA2uNJ6ZSyt6pLqfVYPqVdE4PIrB9s0PD0QYCM+jReG3U
	 MblrW/rMR/Ej2bDtnOYU469S0vCXkVDnalnH9wx4JV2M/Ba8tsRSWFuTIHCKv4I8vLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123133;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:References:In-Reply-To:
	 Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gxiJBm5NHRze1wOQWiUuvxPhaR3l7aCkihnUvorIFDY=;
	b=c76+0IAtpVG/X/e3qphkOU2wNPtuGSBzCruscRhlQMK8pdUehVm3vqnO4dcWXsvO5z8l
	 WGuxyw3PdpNPTjiA+o7DI+LCnGYl+A+8JBjtY1dIxWezCQqbP+xbaV7H9pwN4t4g4ynwl
	 CqCJJ4TfM3129n32WGHp0JLnFVJ1oTf0JU3f5z5uO0B5ZEwPTSP68BVbQa4/cvSZKx2o9
	 JZubz8szWnoxhGLiEMssF61X02xvqizFiij6rCilBiH4sWO8HNrKyc4MyZ3Epkk4GhRpu
	 R1pcgHi7LLh+fYmOnsQCMC48logYlaENyUp962eFKbvnv1n7RoRKyWmAyTsiRMRlwCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ifk4dFYD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSRqLQly;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1C606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 07:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C1C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ifk4dFYD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSRqLQly
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8567VC3153534
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 07:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gxiJBm5NHRze1wOQWiUuvxPhaR3l7aCkihnUvorIFDY=; b=ifk4dFYDnT58wjpf
	MjXdboe71nqyIWFSqu9O76oUSUvdkmhwLM7mBv6O0dk4XSZcQukL20T4CwKNOAks
	CbYdZAarm+vggNFd6vzmSUkus+1IuWgH9O+U/pEXED/cDZuNEsKZ0UD53oIcqubR
	qsIvBSvwycrVXoCyOyqnG9miA+3f/F4+9OwH8pGlHyLbljMgKR85f+asA+QX4B72
	6Cy5dd2wWsLfQd6fsiQLuYAXsaUdjkg22aPf4/RhGaemKw5nWgIc5meSPnd7MHKl
	8EKN/Lyfd7aTz0TtpB9d/zNZTeJzLghc89xPTAaZHZDxcXKwZY80tAeBPqMgPkUZ
	XZshyA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw5k2b1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 07:32:11 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36f26e6abe9so526708eec.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 23:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794123131; x=1794727931; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxiJBm5NHRze1wOQWiUuvxPhaR3l7aCkihnUvorIFDY=;
        b=CSRqLQlyNrDLgFtO8o+8nqfxlpIdVEPDf5vpOdkUR2t+f/9YTEATyckCIyjmyQ1NQe
         JdL4QQCvkXefGZ7rRXXfgosJvnJ94LPO9DwR2+qfy9s39I0Z1yS6Sybgpj6k1+SD2hi9
         M8isAxXxM4Rjay9wOJjmwOj2/4ggxsOOi/hWpJqB0dT5PAdThR1/OIkAm//ZTpPWNrzS
         AZZNgSY13f8KX+peSS63g78pNKqMvFPnvmzK9t1CsqfsUNn6iezoxsulN6yvnqU+y3/Q
         1/T6MenuKcan8hmjTf3qgQNuHH/k/M8eIbwIFAAMopgAvPboUY5vbrxmpl1CIocSgzla
         Fmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794123131; x=1794727931;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gxiJBm5NHRze1wOQWiUuvxPhaR3l7aCkihnUvorIFDY=;
        b=O9FZc5chtaAf0kZMVOwq5sgkLHqr97k9NCDtfa/u6t1ggDNQmTZnQdlFbHKEJ2pHIY
         vXj5LsTcukvJuRY3uTQw0Sj6zwNSBG06L66qYoWOEMuD7mB/jY17JRa5eFDOyhaWBJcp
         jjDsWkr8M7W9q6pwG9xMI9ilO3TlaIWuDGYmJ4JeX5Y83HDnSYRM5GjcMSAliKsDMI/U
         32UBzkX8D1Xs80mTWv3p78+WVoLcQpzfnVKLhZ/0VFLZKcn6g9kpr9IbBCzbt1B+lA5e
         Ud2fJ3yFOXmeHkjyiwy6qfu3qy4ubYnkttRNI2Hn3/iyrUc25E0JwI1w8QGzLUJsCPyp
         pXSA==
X-Gm-Message-State: APuU4Z9W9g6AAeNTym2Ab3Al6ZWL2RSR9uefThpRnBJjez8r7yJsKTe9
	kfzqlNiPZ/iiCuDTp/M7t0SpEg/q+izFHx0DxRtCYY+NVPs5zK9sZMmU5jj9A9GYoyrFcj2qmy3
	i3X8JtyLnBLcT8k+YX7Bgo4yOONuYrY2/3vspsyrFq7Ijaio9LJt5rMdrKxg=
X-Gm-Gg: AYBFou30Sdjzxs3DoHnl46Tgk/CQNtRprtYSy77O99RYvannDqEbcqi/ESgnjhQl/0+
	nAC2zD6oVdGoLQWifoarrQGCCDoL/tR7SQxL1f38YSOJ8dSHMucAAHr5d5mHuu7i0bJBaCfkBhk
	hoJCoI4K/hAhK5l2CTlUSWg78n6nZ0Jbwxw+jQmgMKThwUuXxqXbiBSbrp1Zlbmnb1mU+Q/yWtM
	dtkBmDjMXyK4lgmTNxTOyffRRn0L38AdQSnx29pHj1bd8nDgF1PG1ELVd3xYiqRcWckJiG/iFiN
	+Lsld4+MQUJ0Y8RjF6JanC1JSqhhQcQpbj+BF1GiuqgY2bmDhpHElJBxOlcOkowxynLQGW7SH0l
	5bkaw6i5oFXnItW4J1nbtbpsnlYoPIwYyCO/L1rCHOgIoqtrapqh+Y2DV0HcwNh+pUmlY/86Z6p
	8HgO/cE6Pn42mTY+ceNmWkyL4Ac5sG+Cf8/QPsJ37pr9CSfJ+uCe56h2sG
X-Received: by 2002:a05:693c:26c6:b0:36a:12c4:8bd6 with SMTP id 5a478bee46e88-3725807c441mr2104207eec.22.1794123131146;
        Sat, 07 Nov 2026 23:32:11 -0800 (PST)
X-Received: by 2002:a05:693c:26c6:b0:36a:12c4:8bd6 with SMTP id 5a478bee46e88-3725807c441mr2104172eec.22.1794123130329;
        Sat, 07 Nov 2026 23:32:10 -0800 (PST)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d6088sm3933263eec.25.2026.11.07.23.32.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2026 23:32:09 -0800 (PST)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: =?utf-8?Q?'J=C3=A9r=C3=A9my_Jean'?= <Jeremy.Jean@oss.cyber.gouv.fr>,
        "'Sean Tranchetti'" <sean.tranchetti@oss.qualcomm.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: RE: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown race
Date: Sun, 8 Nov 2026 00:32:09 -0700
Message-ID: <000101dd6f53$43952740$cabf75c0$@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGbpdxbh/nRSzqnN/vaM8uyj5zlKLenWosw
Content-Language: en-us
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAyOSBTYWx0ZWRfXziYsZrOB+tUY
 xexhCtn6q3yd+r/QW5dt9Oc+SddyvZUx2uXRdR4ICCJTnszQEJFU0j+31AdfbMnXyzuQzbwxqyN
 CRvtmNic+HVlFd4P5PyV2h+9OryNxxpBVKvvb9gYu4nhKsQPqMvvdBRmXvuEq1wz1THIrA8Lh6K
 lIEPvuNMVN9r2pSQGlNaCcLzAFh6SIvXmM3AnzDFJP/BxDv4lAv7s3pYusAs8zgnqR4KeQIAMIM
 VfLHnMWomjxHXegd18JRSnxZsGX/B5jHIRftupCmdhpu2Ixnmfvqy6gprLontLzN7hJ6DDxOb3y
 /gtDGprzP0l49QcMKXOKA4prpmMB0xbi7HYVtBfQ/DYVxfzIZ/nEGrz6Zp5Agdh/jqvvSQcB0+c
 NS5k4xYWkUQP6Rt7VpeYn4LvcpE9Wp3Uvc+qE3+/4A8K23EIYsj75XVLWFZyQzEdCStA6PmcXAN
 v+1jRXKXfDGcgDr5a8g==
X-Proofpoint-ORIG-GUID: glheqAYiGLaVCmIy9Jne5ShnTL0LgvQn
X-Proofpoint-GUID: glheqAYiGLaVCmIy9Jne5ShnTL0LgvQn
X-Authority-Analysis: v=2.4 cv=G/aJgNk5 c=1 sm=1 tr=0 ts=6af0257b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=gUkXs5wQAgBOA1n-_pMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAyOSBTYWx0ZWRfX78C521rS4gGw
 5gZOXxD+splZB+XteRGylWuVCnatytV/UHUfvuNUO4rdxmPM9pQzcwYvowKZc81KHJjMhNXkmvA
 wXdyuc/up9ytG9XpPz/HL53/M0xUdgg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080029

> -----Original Message-----
> From: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Sent: Sunday, November 1, 2026 4:34 PM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
> <sean.tranchetti@oss.qualcomm.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
J=C3=A9r=C3=A9my Jean
> <Jeremy.Jean@oss.cyber.gouv.fr>; stable@vger.kernel.org
> Subject: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown =
race
>=20
> There is a race in rmnet_unregister_real_device() because it cancels =
TX
> aggregation before unregistering the rx handler. A transmit that =
already
> obtained the port through rmnet_get_port_rcu() can wait on =
port->agg_lock,
> then create a new aggregate and rearm the timer after
> rmnet_map_tx_aggregate_exit() has drained it. The timer can later =
queue work
> on the freed port.
>=20
> Unregister the rx handler first so that no reader can rearm =
aggregation after
> rmnet_map_tx_aggregate_exit() drains it.
>=20
> Fixes: 64b5d1f8f2d1 ("net: qualcomm: rmnet: add tx packets =
aggregation")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 61b04c6c0390..2ff4b9519139 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -40,10 +40,10 @@ static int rmnet_unregister_real_device(struct
> net_device *real_dev)
>  	if (port->nr_rmnet_devs)
>  		return -EINVAL;
>=20
> -	rmnet_map_tx_aggregate_exit(port);
> -
>  	netdev_rx_handler_unregister(real_dev);
>=20
> +	rmnet_map_tx_aggregate_exit(port);
> +
>  	kfree(port);
>=20
>  	netdev_dbg(real_dev, "Removed from rmnet\n");
> --
> 2.47.3

Reviewed-by: Subash Abhinov Kasiviswanathan =
<subash.a.kasiviswanathan@oss.qualcomm.com>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665589;
	b=dpSXaPXij1cnZjB6nJLeA1GuyBlE1QZAFWVu8l1YjYesOhU2MeAZe9Db52+/m0mJJ6yE
	 Nw4skm6ODP3yUQEc7fzubkmNdeyMmZTY2gzSo2kyl6RHxLJDaDdpAJRi7Uvbtli0yFNHt
	 E60tX7ztUoiqbMQG4vuskTQ1iIPPiIUQT1chquQr01yhwqGab9V+3shbk8Ch+5FXdDlD1
	 azV3k4yz14j4FiOHRFM9tm9zT/a+9PxGgNtxEJFEf+aNNER51OIzQNg8yfoRrRouA4D8Y
	 8eO/d4Q5vtEUu7wUv1TYO6dfCW/uGAmLKcU53Txsmt9OgiqMp0E5cXjAL6SOrFnrjrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665589;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KVUV1+mwK52vEYaTF69wDnDvl4/N5dnXbFTWcMNoPzY=;
	b=wv+W+Ge2EGopmykrdn6WWnuyrI+NwKuv3MO2BXd5fCT9NaPXmzRPTbQNwEjyUj6k42VX
	 EdPOzGoeRWbqsl/S+UE26urv+CvJS7nGrX8CyRZuzRuxhWPDoD1ClGgTMSfwvFSHZajEo
	 qf/lNOoZRbd7OJyeayX+lyzDLucj+R397ceDjbsUprb/3KjBNMVKUKja+YXSg8umiwbq8
	 8UytKZJ5PchBg3A5Wz25/qxqqQuoOTbtxuiq1o9dUUSYcwyO31KOKCCXEgQJezjlo9wY/
	 rJ/NxQpzO0hp1UhTaDY7LAnqnEcUtN8i2JKIjJGLZXTOpyjtH+dR9jxJLm5OGhIecXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="BVB/PWvl";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QwWQcrJd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4B606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 00:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A4B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BVB/PWvl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QwWQcrJd
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2K6CNH166078
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 00:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KVUV1+mwK52vEYaTF69wDnDvl4/N5dnXbFTWcMNoPzY=; b=BVB/PWvlG/fhji5T
	hTvL6LCPWNEYZsd9WtKha4mpxtj94caZ4gP/S2Qtl6Q0Zl9G3c21pmsOQYM550x7
	kjWciHXExx/IhVbEolWq6y27AoDR7tVYIxt+jqjlNJgLzum4e0PTiCSszZR2b8d+
	vbgvDnrY/qbcwuuTXMSrHGTF+M7kridZ+X82vEg5Oi7brLtoqwxyMPjdo9H2NORe
	nlHH5xPyUXAv5NpXYNRIAnfXmevDAZNo9fRDna3EF0azswSUH+srBTsLkZx7CBvi
	sFk7bGlN0XMSjFfEL6FnhE/LEVVFXpSvHnks0b9E0FxTfIzHckGdf55mIfv39h6S
	CriEZQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrkjjf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:26:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso6748730eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 16:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793665587; x=1794270387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVUV1+mwK52vEYaTF69wDnDvl4/N5dnXbFTWcMNoPzY=;
        b=QwWQcrJdDp/aPx4HzCUSdGXyGE8AF5Smz0SN3qyOyKIsdrKBfi489HbQqM+WqRNTMK
         MZvhlMQm/ihOkmUSGV31jGTIMDg+gmOvrXU2A94a9MOKNzRjnCoXm6kXAnqO8utRO2ks
         WzYRrp+78V+FCIeu0/9OMg8e/nmr+86h9vU8lzqXsQtsvZjt0MbO18S/jiuI1DHjOtWs
         EmaeFWMUneEikT3d6siduPtXOPP8fYtlrF31xwDtybPJE3Do1bL3Dt5m/rEBbLaw50CE
         I5U6Zks7x9gd9A7SWIJVBm+NBuySroWPLGYw7/xsP7ndu4uj46Grp+zh+uT5ezJakEML
         +fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793665587; x=1794270387;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVUV1+mwK52vEYaTF69wDnDvl4/N5dnXbFTWcMNoPzY=;
        b=LzdnBM81W7THUy8Nr2r5lWi3uh2pAPS4xZwC7j9D67IwRi/3WvImvKRNZZhnh/hOKM
         sN7lxw/00ScJKreDPcPkHu4IlpZF6NH4zKqTCSCunG6F3QfglUWTyO7k9tkQLsfBlaeS
         hFZ2g2B4vK+t67/mz32MytcllYHX5e0Z5BU00RkrWBZdbcf4z+fRGsHvoaOmRPm7cbd/
         CQHV2W9yjlCM4LIk3ka2MWSxbDKEgmflBZR9U4iBowfplRkyDGpoBnmDpa/BjPJJ1D/Q
         6HM26DX4ET7Mq5pbbWbuboURvBxXqXasjvxkffie/RWb5cMuYRlfsX8P5HzMcyrwmCeB
         Kl+g==
X-Forwarded-Encrypted: i=1; AKwUvBwgbn5LNI7xaoo89LDKjtQOGvJCmQ9bmr/i4gTmlMKRTfwcbT5N/5JFtSQW84xIM2m6ALjbXzw=@vger.kernel.org
X-Gm-Message-State: APuU4Z84SjDxqsoAZHumkaOYQTEQF+K63PPy8/5nAQIjsF/4L+oFktP5
	Yhm/jtgU6jCwhVoi8/WveKcb5jLimBuTL5ek8f7aQM1aImV0j2mYjIVXCQTllGBaanijIsAKN2L
	rAgVnYNNRsrT7S6kMeJrywf3gEy1gYCy1ouBMpRkZ1UFzEvweiYw0FPuM4cU=
X-Gm-Gg: AYBFou3l2y+8hyleOgEp3IuBT5gA+4hUKWWhD5HOrq4KXyEGyyRMkvyptGE26tpkyYN
	3SzR3GgYZkgtU1jvB97lCsxpw6N+NrzKIXAFG5pRVu62IsxqcqWfU4csfxoEsEkDPCC1lZk2ttP
	hxBnrT0rbplRxfVcc1/1VLimAVW48Vqyb9dx8DjceybjYAaZ4ED7fCrkdn//Cl4yd4s1pjEcs/P
	ZTTNqckNW0T81/hkBdEIiwxgrwIbzYUC0hNg05Gpe2VM6kw7Rzw/pqcQCtODtufKiC5YxKdn9f+
	WAsILG6ftWQYJkDRO1NMsfCAN4lGGf1jCnxJnF+hE7JFXi5bNRrEwrU4fR4MjlY/FHd4pUIAZSp
	FpMi5gfYdqnns7cnFhYNHYswUTjQq4DAY6pgBSz0/uEWgHqQSRtu09MFKc/cEBU253m/IA6NZ7A
	IUSrqsdID93u4=
X-Received: by 2002:a05:7301:6183:20b0:36a:1089:9836 with SMTP id 5a478bee46e88-36a423c8988mr16360461eec.15.1793665587228;
        Mon, 02 Nov 2026 16:26:27 -0800 (PST)
X-Received: by 2002:a05:7301:6183:20b0:36a:1089:9836 with SMTP id 5a478bee46e88-36a423c8988mr16360432eec.15.1793665586499;
        Mon, 02 Nov 2026 16:26:26 -0800 (PST)
Received: from [192.168.1.148] ([68.248.129.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm39285518eec.19.2026.11.02.16.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 16:26:26 -0800 (PST)
Message-ID: <374c9df9-eb58-48eb-8447-b6340df37719@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 16:26:25 -0800
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
Subject: Re: [PATCH net-next v4] net: stmmac: dwxgmac2: enable L2 split header
 support
From: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lorenzo.bianconi@oss.qualcomm.com, hongmei.xu@oss.qualcomm.com,
        abhishek.chauhan@oss.qualcomm.com, sarosh.hasan@oss.qualcomm.com
References: <20261015221215.1714047-1-sagar.cheluvegowda@oss.qualcomm.com>
 <179244898962.3135.12890405028818098249@kernel.org>
 <32fc0379-0c45-4011-a7ce-795c44594b89@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <32fc0379-0c45-4011-a7ce-795c44594b89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae92a34 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=djYDpCgIitZxdph7ACYjJA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ZIJvd-A7hXLYn3_D4tAA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: LtjC9nSVGR8rf3g6Vjnixn959Ithbzk_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAwMSBTYWx0ZWRfX7wRBTWQ0knm5
 UEE5fdD4dTa83bFIGZhMxtc6hmGH4lNDA0aLQSM3O15sUvzPYSnTU9nAukkCqBuIgb6L4QW+qWw
 akMYLYyIKA+QEdi6hSDyKeJ1ACDbc2c=
X-Proofpoint-ORIG-GUID: LtjC9nSVGR8rf3g6Vjnixn959Ithbzk_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAwMSBTYWx0ZWRfX77VyTIMnD98W
 g0k/U6kK6dneCQ6Nx0goh3qQXhVsWW6+ae7kdMA7rQU3cbBAGaG0K2wQmjoQkO/qBx2N2WaDgf6
 N09xKRv7ZVM4WP+J1OF4dR7b9BnoaFc2+vZWDJXtyhVR0gQrlaG3k1O0whT4DG47R8PLWXTC/+W
 uSE8nUhqdAYpKTKPIU0EjG3S+MpCytrsIkPditV2BkMpepZnwXddofVBXjLbQf95qzrEK5YYddQ
 JoMWwoNR3PeeXF7agWXRn/yzxBpca7Q98e56LRSmVBsDyMK2vHDNm/bw4fKqnch5twINGzxj/V4
 Kayn+PuRS+r6eHoQIzdACNoWFSaTUOz4c4WDSd4x8aW1c79sfJxzxb2ubY/cLecTkDgFTmXe1a8
 /AC5nFCbXVsWjf9sSVlbTYfVTxYdI0brqR3rB/7j0sF3JXL5E6ZuHrkNz1sUe35WWNnEuvdiWDk
 9w2kRKK7sa407ad7wWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030001

> Agreed. I will send the FD/LD handling in dwxgmac2_get_rx_header_len()
> as a separate patch to net with:
>
> Fixes: 96147375d49f ("net: stmmac: xgmac: Only get SPH header len if available")
>
> and rebase the L2 split header support on top of it for net-next.

Correction on this point: there is no user-visible bug in the current
code, so I won't be sending a net fix. On XGMAC the RX buffers are
sized so that a frame always fits in a single descriptor, so the
FD=1/LD=0 case where L34T is not valid is not hit today.
I will keep the FD/LD handling in v5 to follow the databook's "Header
Length Availability in RDES2" table, without describing it as a fix.


Regards,
Sagar


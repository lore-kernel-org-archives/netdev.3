Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315F4AFE14
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560240; cv=none; b=Axa+F98rXOpvAIMT5GH/zN/ZwNkv01INabmk3eNhSsLRm174EXf/jNQDng011eZXKN8iyNkicXvz8yv+0OKiPT8XYErXTVST2vVF5i6/Wpw3+4oY5A8z+zMM0HljXSEORLMdFZeZjs+Iv4MFr56nzRsCxhtZSmpujJ2SeuFnGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560240; c=relaxed/simple;
	bh=6sK5lF1uG0tPWOFM+OttpVt7fqKt3BCa2jrH2Us6oik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsarrxtqaVEVYyBHkJ877y2ocoeFxLWfzub7VtikSf4JXQNmnbxrBNr3bMlYIMR5QzB7j6sjY/u3mY5C5yniTduW2AUBrK+KVkg373EIuKl0CduvCzTNzuDw9YRGG/xGR0OUhifzBnlnbawZGXqi0KRjZYXEjZzsQMV0a5VxSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bb4xnBey; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XtCcQUhz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bb4xnBey";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XtCcQUhz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GBkc5Y1912219
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QFXgN8orDBjbvQKpvi/E0ueO
	Gqo2a07wjdptO1xinNA=; b=bb4xnBeyACviZAcfpfPaqE9zkcsZPlSAAT1vMJHY
	C23OlXMqgtSOwOKbulh19Z2Z6CSNT05JeBG+u8MvA05K9g4TYMWoHpryergD/xvc
	968WLELgWJShnO1JsJQ3jmMYk/fsz7XpkKSEb4t79RTJCboQbY8lNZkrpKaZ+uI3
	9RVBi6R/5HU074GhGHoW2V1tAtLazz7v+hr6aj61O+8WIS7UvTp/8r9Am5DptPNn
	mQK8Cn6LuzbtMxDGjxRtLpnk9ewNuI/OuuJfKemUCQWdBp0V0cmpITqJ3Q7ohCT5
	+x9GjpxXl2NIYVe8PJ23tGJjzKLk9zy43z1g8g3sKd2bSw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqthnr2ty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:03:49 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7f4e4b52404so7026561a34.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789560228; x=1790165028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QFXgN8orDBjbvQKpvi/E0ueOGqo2a07wjdptO1xinNA=;
        b=XtCcQUhzICyHhEry5k3JXMBi8KQxfpybpzdXLwSm2S5H95o/0vk0ZHC700Mv+epQeK
         KHJmAED59MX3qrLBxRWLwuCmR4m5oRrspF2zhSKALZtwXTnZaUGIp5Yl6q/VJDOlYsTs
         w5uvkJjqxHs4zDw2GAMv3nX57xe9vhg9VARGi80lXU8p3SaOXYC58vB0GlyOGFyYFBaC
         uaop0vg47GDvDAoRQstdVzpCjzfRZywN/FsGDn+elxxG4nkqR6PAitrwLxZeKaiuboTp
         vAeTZ0t80B6cii1/2ec/mUstC8E8clrwQtjKRlXnVt21wFfl7paNzf/uXJLu6M0XWKTN
         EXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789560228; x=1790165028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QFXgN8orDBjbvQKpvi/E0ueOGqo2a07wjdptO1xinNA=;
        b=AzzpXDYwLemiillcwVMQmmTt74bCV3NeJe6dqVENS9x0fsnUJ40fBj51Nwdqf1SdZx
         C0tKfDYuUNavG1OK4YTorYj5cvTZIjpEDAar5kgxYFHlt6to2r+fInYNGiterQt2xjgm
         288ODYw9iLHbzl9AtkYVGSbmWFAghxyvChGt5WEht0IjuRvlyZDcEkp50zlS8c3t196X
         jGHefhdi1cBmAO0HbAGywYqs8dxxCTLSttWRMKLhySPiT3jj+m2ybn8hozb571s0OUbe
         o3cT3vd+E2GrscvFLmQRWDn5m+dzUCvgzKvOw5aHcK458WPSk1XKBOLmqbAEwLfl1xr4
         uS6g==
X-Gm-Message-State: AFuF++lsHySnalVZNx32nk9+Uv1GgyQLXY3cZcK4/AweWksfyp9UBJRk
	MKjo+2cB4SH1hNoFIBMssinC3WNYVMfRT/IscPp/3Ly5+6VTn2HiWwKDN3tBJZ/iHBFinQRqusx
	ccQD2GzRvbNjfr9e/9n3UBTgSrmLLXwLdqop6wqR6GW8tJkR4I/xqHiFuJWY=
X-Gm-Gg: AYBFou2wXEZnSinTvVRlYMvStU+8hStOf0TiKjnfLiHRJ70OeHpqFUA+zn6VO3lwpea
	ooOn7bpLOoGQYkrau7xYV0Pw7KNknkENB7NdXMiCaeUdQS9zOnUmCJNLl/LGRiD3yjGh5C7paDs
	lPtbVeYX/SGnv844+9StvCFz9dYD/3oUMWGbMIGF7N/xAzFssZp/23N4OtmOIx48Cp96x1/z8/A
	dqy4KNwOqiQrE7tlx/xchBNmQQqoMFji4E+DhrHdjegaA2NYvJHSInT8xsiPoEhl7JqLUtI4olp
	l9AhG79mvYZtJ1Uo0pQKVhG3zcqUtvyG4geUscTVTQ+1mnD7JP8pw7AgiFPD6bD8eOI8jmWGu6v
	Gxwy5uz2QJR+A2Q==
X-Received: by 2002:a05:6820:290d:b0:6b7:46fa:169e with SMTP id 006d021491bc7-6c7d45ec697mr2271837eaf.51.1789560228241;
        Wed, 16 Sep 2026 05:03:48 -0700 (PDT)
X-Received: by 2002:a05:6820:290d:b0:6b7:46fa:169e with SMTP id 006d021491bc7-6c7d45ec697mr2271761eaf.51.1789560227634;
        Wed, 16 Sep 2026 05:03:47 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aee8b0sm16611955eec.23.2026.09.16.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:03:47 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:33:40 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Thomas Karpiniec <tom.karpiniec@outlook.com>
Cc: netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Choong Yong Liang <yong.liang.choong@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: stmmac: propagate platform mac_finish errors
Message-ID: <aqqFnJ2EF828xFFb@oss.qualcomm.com>
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <CH3PR11MB8413069BD77B03793D1A9B42E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB8413069BD77B03793D1A9B42E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
X-Proofpoint-ORIG-GUID: KpKhvSU2cp5BIOeA6z6eU0dzary_vMY3
X-Authority-Analysis: v=2.4 cv=IsKL47/g c=1 sm=1 tr=0 ts=6aaa85a5 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xWJGE7MbY3rzqH8snsQA:9 a=CjuIK1q_8ugA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE1OCBTYWx0ZWRfX555ZJ9u48f36
 Ykh0AM+Dbq7ubt3cGeS5rUf6acZq9NY+Rdq/fO0eUVRE+9JGLwRVUZ7RDykQU9/q8+dKwvWEwbW
 kFneSEyRL0eofon4QXc9FvmsWLc6d24cUHehw6pgZx34Pb6qRTX0N0nzSNSoy4/LERdBBobOdqQ
 IJDyqJGrR/v2VxE8kAV3ShtSW6zdwHXJOr472flWh25Y4Dmf0Qe3+QbR1bw/Z9GgSfigEuu2ZV6
 RKPjGnOLSNVQlBvuWG/IwxUryF95KKb4ft4ULzIpNeDbNmzFJmbZeZeoWNfjuUdoIuNfFZC0mtG
 IXbnK5mwCFrFVoeBlqNVUTfrHuGTacpa2TnTQq38q/GjNgHKdlmxvvCi8wrud67388KSQD8JcTl
 VSTCB5FUMGg1ekjX4ZW2ZdLp1ZlNXKI1N0QVfoAmHfurIST9Fzs9e2EfCXeYdGTH3Wcctiyz71x
 PlIDfKoQrJ32SJSnljg==
X-Proofpoint-GUID: KpKhvSU2cp5BIOeA6z6eU0dzary_vMY3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE1OCBTYWx0ZWRfXxzpcr5yHTzRF
 8gLBof3skriBc72H1P86QC8ubRM3oTd04arqJHGzIF225PZxY0dBtwYLnKqP3q/35eMGy1o/XRd
 hHlo66whg1qeXRF20u6b1zblfOAFImo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160158

On Wed, Sep 16, 2026 at 08:39:49PM +1000, Thomas Karpiniec wrote:
> From: Thomas Karpiniec <tom@wendy.sh>
> 
> stmmac_mac_finish() discards the platform callback's return value and
> always reports success to phylink. For example, the Qualcomm ETHQOS
> callback can return an error from phy_set_mode_ext() if SerDes
> configuration fails. Phylink then treats the interface as successfully
> configured and can report carrier even though the SerDes is not ready.
> 
> Return the platform callback's result so that phylink can report the
> failure and keep the link down until a subsequent configuration succeeds.
> Keep returning zero when no platform callback is installed.
> 
> Fixes: e654cfc718d4 ("net: stmmac: configure SerDes on mac_finish")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM sparse
> Signed-off-by: Thomas Karpiniec <tom@wendy.sh>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea23..1350e92943ac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1048,8 +1048,8 @@ static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  
>  	if (priv->plat->mac_finish)
> -		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
> -				       interface);
> +		return priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
> +					     interface);
>  
>  	return 0;
>  }

Just curious, are you trying to resolve the issue where an interface
gets created depite:
  qcom-dwmac-sgmii-phy 8909000.phy: QSERDES_COM_C_READY_STATUS timed-out
  qcom-ethqos 23040000.ethernet eth0: __stmmac_open: Serdes powerup failed
in dmesg?

Anyways, the change looks reasonable to me:

Acked-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan


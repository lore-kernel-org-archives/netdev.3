Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212533F5BE
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814722; cv=none; b=fHufI/CrzUhYWjqvssp+cO8ssLWAKyHGtqR+OA6LmJrdJJ8jv79RJajoizdg2jNKLIu3SKEcO/A4HKtQgq7+5ICS8BIxz93zZQLqlPj9ppK5REx3epcEa1hWzOSusVERN70gaaIJKYrA6Rv5hZPbqyU0k7S5v2VM4JcyVTAT7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814722; c=relaxed/simple;
	bh=LpYclh2Q4X6wwMY2qk7RFvfuMFSuPRf5P+LgVO6/xRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbryvBwDmu9rt95DEguOakCmInwN99Q0AnnS1NstpwKAR+jdNjNvSyq0tPWCQEttNwBHIFlpU9oo2xQGBiWIZKXlYMDcMVYQCPBbj/jrLrxQwROJANmC5LvAuLu7QP7FZy6rk0c5qFYZCrNjtZG0GNYPag6Po/jHGSkmYjY2sZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YN4I8U1Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kg+UAFHk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YN4I8U1Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kg+UAFHk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6RCrq2726628
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MgzfruFj4FbrPg8AHtV6XVyo
	uIx7S8A/hrzczQxqXGw=; b=YN4I8U1ZHI6rCIqtBq1c5feY/lZALBgGKvI2YlBf
	fiy3P0hqJJ/5tHjVcUyANtldJZYrO3KfIJLrtcuBvrNh8+lDm+fEJk1FOz7zTYte
	qIZuuf6Z6+tMUbBVOYf8VzYv7gDVPUtz3FgheW/p3alxvL7ARjmatiS7SV6keDxu
	QmK8Qw1x/ChI4M7lS2p90hjrzvkMCqetyAJU8uzPD02oPqlS42bgm4/92cPl+1tD
	Y6ERL6dGVNMuqD1+gFM9jZtuh70Ss9u98HlDIAf9OxPyIIBy93QrtGI9Ibc4YvF7
	1nJlZZWo1axPk9/AHqAgI/3cl54/Yys2DTLpy1k4Mb0/GA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga6etsykt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:11:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52cd0374265so32008101cf.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787814718; x=1788419518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MgzfruFj4FbrPg8AHtV6XVyouIx7S8A/hrzczQxqXGw=;
        b=kg+UAFHk1Z9SFAo8pw3y/0tTmBY52W9iLQ53Lv029Zqzmy8Cd5zk2JkRXfSor4DIE5
         lg5lmLIUlESSgLmy6+hYF4y4Ac+aqUvWJWwnRuNmh0L8sN3+nd77qRC+bUkrjQ+8+oTG
         rqcUyGt+lIYXQlZ1neGMfB6+BxDRipOVDNfFQAGGAhEnoPZZ6wxJ64LOa8mwgm2n9kMV
         ARzB/Y5v/GWkcAgDHCi22zj6GxXKPn6WeMZd6IYJQf/PUQ2kYyzVClE3XGMEbp+MMdCR
         vu5SfMy35ImmoVHMPweR5G4FXYEgfQdv/n1Jfj89bOmmuSWPKuD/kCd4sY7DWxOQrKxx
         iQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787814718; x=1788419518;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MgzfruFj4FbrPg8AHtV6XVyouIx7S8A/hrzczQxqXGw=;
        b=gExPNaHjc9sEcBrwyPQNCymrq9333gG8JrmXEBfPBUBfbKXVA8kGs05VXQ3iNlbvNU
         pIxoOKt4mIjzdTeC1poLfgMvUrqKIzgLb72YaJABd+YE3wW6Aks1qwPWHFIHYMRAWTps
         OmVvVwJ+/EjD9zGpOxWlfAQ0jG8dErn9B3lZD4+sd7jYqxcM5bO0MdTLZHJO0aTQnnpP
         D1fLzGHktWDQXvMZx6BPSzKvuLw5ZFnJpPwNyoMU8mew0rQJZwPvv58XJibayQo63RVF
         vEwaNQGwILPsVQbG7/O4t27219Cai+g5H1xszcSoAzbV31Md+PfGmNiN0JcYzvOC2ywH
         YIDw==
X-Gm-Message-State: AFuF++nGov7bKp2vRhFIEpP0+f27RTvVNlKuRhFjQ1gdSQUvdXI0gdL3
	IsaRggtm393er0qG4BqP24RygF42Jzek0ruqlfo9ufI9Jq59MTp/YwP1QSKrPVIAe0J/tMZ3DJ/
	3XImhEh99j2V8F4UvwBM91XLKD1RryA7O1nM74Jmd6ovIA2Uzt65Fi/oyrZs=
X-Gm-Gg: AR+sD12RGUbFZDEmkhnuwJbbzeG8QhNSgpKCbO4Cr5ZAe4qG+b1x++YCga062tiVxb6
	RJOLvHi4VAkrpt0OgwEXTccPWYfjAwAMYPmo9n30bMU6BQMY2FnobU4FISvT6hby16r8mz6KkZ9
	nvhAHwQoleUj5s7KudKVF9uDDRXZ3dmLd80ievUkLkzS3z90/Z2AU3eliaBwZ2l09r2pTVGXOHu
	73yNjBtjxyYUiIu/uXnaXfHrc3i7lYhyDI2OlrykPYhmmkhYJjzkXifvgUEpfG/1agA249uwRII
	gjAscDokvp+1V1hR/QCH1+25my8q0WTBPe1Pjtj2IePBslP+N3S/pEIpZmswqsf9DAc3+TW0sdq
	QzqgLxHCF1deDKA==
X-Received: by 2002:a05:622a:3ce:b0:527:7a5b:ca67 with SMTP id d75a77b69052e-52e423deda8mr121295931cf.20.1787814718168;
        Thu, 27 Aug 2026 00:11:58 -0700 (PDT)
X-Received: by 2002:a05:622a:3ce:b0:527:7a5b:ca67 with SMTP id d75a77b69052e-52e423deda8mr121295541cf.20.1787814717537;
        Thu, 27 Aug 2026 00:11:57 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4e2c1af7sm27101205e9.15.2026.08.27.00.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 00:11:56 -0700 (PDT)
Date: Thu, 27 Aug 2026 09:11:55 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: hold runtime PM reference in setup_tc
Message-ID: <ao_jO442V4eG7xd0@lore-desk>
References: <20260824-stmmac-setup-tc-enable-pm-v1-1-45172d241a4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qit4tLMxBEK2W8qA"
Content-Disposition: inline
In-Reply-To: <20260824-stmmac-setup-tc-enable-pm-v1-1-45172d241a4b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a8fe33f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=LK5SnTVSdOS2cW5lnr8A:9 a=CjuIK1q_8ugA:10
 a=_YFSIjxOcyUDFHQV-BYA:9 a=dawVfQjAaf238kedN5IG:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: RVdzv8sxrT4DRAwILxDEl3Dy8jiubFPu
X-Proofpoint-GUID: RVdzv8sxrT4DRAwILxDEl3Dy8jiubFPu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1OCBTYWx0ZWRfX6YwUP+w/qLjJ
 mOXofcV00+D7y9iaNQbSABbMll6uhuTdQyVga+UGRh2CWmZXDGJn2xIS8SGo6qVfNpwbY64obhE
 I8KjXKcb4Sr71ihP1Grcf+GNfarCIsGmLfOValiBgLsfEZUxxkCpmKqKopFU4JK3ihYXVMiVyfa
 2EeRdtbjiBn4M469xTZUdTcmEObdG0f96ms7IaEjDiQkggwrNRESSrZvsHN7962FBeU9GvyKTp+
 sQHw4qoSiA7O1RxNzOPgyF6q7xLmYC3FAM3ZD9u1JwgHwzUOWb9xVKRdSMkXeeS+Av+EJmbCVjo
 KCHKkikQDhMlxi4VHG/PoQ3xAEpjf3iqpgu6/6SKyhKuqx6zx/Lj36awcD/UMaALC6SADLntdwc
 aKhisYBdeG4a24eh5EZuf16LlBD4SRfjQ0mXpPF2cA0dYsYISrzn+EKc4oGQ+bOSNvx4Xs2xko2
 JYuogxjlKrYrX0bdRmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1OCBTYWx0ZWRfX70EHJp3tEZO7
 yoTI6etWseC4WVS0JQ0ey2MxVdQ038/EHdBXMM6jKot4YKU6Zu156puxrgyKvA7Cbt6UQrsZjg2
 DJjp9fyg7rBfCPMiirEF5M/LCq3BNX8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270058

--Qit4tLMxBEK2W8qA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The qdisc offload callbacks invoked by stmmac_setup_tc() program
> MTL/MAC registers, but they can be reached while the interface is down,
> when stmmac_release() has dropped the runtime PM usage counter and the
> device may be suspended with its clocks gated. Accessing the registers
> in that state can trigger a bus error.
>=20
> Hold a runtime PM reference while configuring the register-touching
> qdisc offloads (mqprio, cbs and taprio) so the device is active, and its
> clocks enabled, whenever the MTL/MAC registers are programmed.
>=20
> The TC block callback stmmac_setup_tc_block_cb() programs the MTL/MAC
> registers as well, but it runs asynchronously from stmmac_setup_tc(),
> outside the runtime PM reference held there. Hold a runtime PM reference
> for the whole stmmac_setup_tc_block_cb() call as well, covering the
> cls_u32/cls_flower setup and the queue enable/disable accesses.
>=20
> No reference is held for the TC_SETUP_BLOCK bookkeeping itself, the
> TC_QUERY_CAPS query or the tc-etf path, since none of them touch the
> registers synchronously. In particular the block bind/unbind must reach
> flow_block_cb_setup_simple() even when the device is suspended, so the
> driver never leaves a stale flow_block_cb on its block list.
>=20
> Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> Fixes: 4dbbe8dde848 ("net: stmmac: Add support for U32 TC filter using Fl=
exible RX Parser")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 34 +++++++++++++++++=
+++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index b2b7d0242dd3..4baf40fb01dc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6392,9 +6392,13 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_=
type type, void *type_data,
>  				    void *cb_priv)
>  {
>  	struct stmmac_priv *priv =3D cb_priv;
> -	int ret =3D -EOPNOTSUPP;
> +	int ret;
> =20
>  	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
> +		return -EOPNOTSUPP;
> +
> +	ret =3D pm_runtime_resume_and_get(priv->device);
> +	if (ret < 0)
>  		return ret;
> =20
>  	__stmmac_disable_all_queues(priv);
> @@ -6411,6 +6415,8 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_t=
ype type, void *type_data,
>  	}
> =20
>  	stmmac_enable_all_queues(priv);
> +	pm_runtime_put(priv->device);

commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824-stmmac-setup-t=
c-enable-pm-v1-1-45172d241a4b%40oss.qualcomm.com

- Dropping the -EOPNOTSUPP initializer of ret changes what this callback
  returns for tc_setup_type values the driver does not handle. ret is now
  first assigned by pm_runtime_resume_and_get(), which returns exactly 0 on
  success
  - I will fix it in v2

> +
>  	return ret;
>  }
> =20
> @@ -6420,26 +6426,46 @@ static int stmmac_setup_tc(struct net_device *nde=
v, enum tc_setup_type type,
>  			   void *type_data)
>  {
>  	struct stmmac_priv *priv =3D netdev_priv(ndev);
> +	int ret;
> =20
>  	switch (type) {
>  	case TC_QUERY_CAPS:
>  		return stmmac_tc_query_caps(priv, priv, type_data);
>  	case TC_SETUP_QDISC_MQPRIO:
> -		return stmmac_tc_setup_mqprio(priv, priv, type_data);
> +		ret =3D pm_runtime_resume_and_get(priv->device);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D stmmac_tc_setup_mqprio(priv, priv, type_data);
> +		break;
>  	case TC_SETUP_BLOCK:
>  		return flow_block_cb_setup_simple(type_data,
>  						  &stmmac_block_cb_list,
>  						  stmmac_setup_tc_block_cb,
>  						  priv, priv, true);
>  	case TC_SETUP_QDISC_CBS:
> -		return stmmac_tc_setup_cbs(priv, priv, type_data);
> +		ret =3D pm_runtime_resume_and_get(priv->device);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D stmmac_tc_setup_cbs(priv, priv, type_data);
> +		break;
>  	case TC_SETUP_QDISC_TAPRIO:
> -		return stmmac_tc_setup_taprio(priv, priv, type_data);
> +		ret =3D pm_runtime_resume_and_get(priv->device);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D stmmac_tc_setup_taprio(priv, priv, type_data);

- This is a pre-existing issue, but the patch now explicitly sanctions
  running taprio (and cls_u32/cls_flower in the block callback) with only
  the bus/CSR clocks resumed, without the rest of the hardware state those
  sequences depend on
  - This is fixed in the following patch:
    https://lore.kernel.org/netdev/20260825-stmmac-est-reapply-after-open-v=
1-1-dfa80735e0a1@oss.qualcomm.com/

Regards,
Lorenzo

> +		break;
>  	case TC_SETUP_QDISC_ETF:
>  		return stmmac_tc_setup_etf(priv, priv, type_data);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> +
> +	pm_runtime_put(priv->device);
> +
> +	return ret;
>  }
> =20
>  static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *s=
kb,
>=20
> ---
> base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
> change-id: 20260824-stmmac-setup-tc-enable-pm-149aa563d797
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--Qit4tLMxBEK2W8qA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCao/jOwAKCRA6cBh0uS2t
rDwmAPi5W46YAs2N7ck9ZndK/1g9U+egoj3T61BVVsU5jsTJAP466NaLx5IjYqmy
+tu/Ntp3W3JTj5GLfket4cN6CcZcDQ==
=DNMW
-----END PGP SIGNATURE-----

--Qit4tLMxBEK2W8qA--

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E849502C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549721; cv=none; b=JViEqmLLSAoGfRJUIOf4h1anMcsmBNIOqap8QqkThdbTZhPjmZM++SjRG0x66R3j+ZnsBxUtNFGYT+IH6bSOUC/+E5eOBRWAnEkiC1x2N8X/eUAYtcdU5T3m58v5GnfESAfJMaTIL+s5wweqG8ukJLxzk00vIYeTVOhVOP/c9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549721; c=relaxed/simple;
	bh=hbs/g2RjLQtsjjs2+IGvNqMpSjO91qtHamWd30lYoEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJtbEtiPfwBtihZBj9X0bfdTjjKH1DYv5cZmZ3Usot1DQMfguXvn9pufaDVaR9lec0mXi6lknLAHom7AjcT6EqYN4oBlr10kOby+XHM48KsntlGVvc4Rh2EfdRfsjtTcVWLDrKvyIY4yS33jBlxDRWInmq/DXO4733RcsSqk2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L5NQgKYx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a5c3oZie; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L5NQgKYx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a5c3oZie"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G92sFd1552927
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aQh8AWaRpKh1Q8l9bSylJcBR
	Ps7X0IfdPjMRSeBWiRQ=; b=L5NQgKYxrVas8nad6ppYH9AhComnAvqDowOB8nwz
	Z9wQiQIRp8hcn9ieUvvNAY/uKxTGbbO6eJCeAJPT88esjej212wzF3pF9adbO+mU
	6xeOV+0oNMLXTVngq38gVCApXxN/yQ7R9B99h5/t90r53wyYSYJ8AYgJvi+QkkmE
	BVStVO7sBE1L34299oE5GfSBxJG+ImwVynKpYYHv4bD3uwx7WrokMKB+0i8Rkk3L
	HQUOAtpUf8Z4EguKfFjiLxjKTE9+QUdqc4r9dU4yAVyqV6fliBkOjUxNu24zk2ZP
	o31cIH7DgGbY38bJmGXSdhvwA7wPB/knEZ2pV2P9rUhJoA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq9n63stu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:08:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a08ff8451so647596885a.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789549704; x=1790154504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aQh8AWaRpKh1Q8l9bSylJcBRPs7X0IfdPjMRSeBWiRQ=;
        b=a5c3oZie4ELaOQiAVNeqD5Zk+2TVHkzex5r3yKrrmXUqp4mB9FQzgL4s0RDGBzKXuZ
         6bYA54+03h0zGW5WvF6Mejk0I1KNP6tblZcP8YhtuoFZCVWTo0+h7rlE12bBvI9ZE88Z
         TGXCa5/n+CSemf9dX6Ik5dTTutb9MK4WP8srbrlL2Lk0FwbWX27aVsGN477Q5HSS93eE
         ewbMB6NlhX/m3QSLWYKwhlhU5XD5D4YaijefXcQB/3ash6oDQpCwieAqPBbYWAM+6cgh
         0NJT++X4id4eG82v1qTKLPysNCB9BIv9LJdutogYDsjvDMoZsqh2WiZhk0J9oGi1BssP
         fMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789549704; x=1790154504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQh8AWaRpKh1Q8l9bSylJcBRPs7X0IfdPjMRSeBWiRQ=;
        b=abk4RMlYsIUxFmCjahTd82xvWsrQFEecbU2lfDF6+gcfI6nOHc+p72kG1ygUySBEXU
         9PdgIPdury/hNLbTlIreUBKHHcYVHXpGiK61QyjqYA4V4SDbYiqFAzAcQtkChUejuaDE
         gRLMIxV1kYpRgjhvSv+MGIqqzs0JFqtOxLnYWgK06oqE5pD5AUp5qsUPjDN0c15w1Ssh
         lthmDQFPQouZckuZxSJ2CzR6l5gR4HKhmy+k9jkL4dcwdeY1qoKw8meHdg50vixJYcNP
         wiPoR8tTuk4Zm5O/WmnleOLsKGDAbXDdQiN3wm8oB+yShGmQitsYgPTc0mbJ7HNPfN49
         lziA==
X-Gm-Message-State: AFuF++mOwE1oI5QOfr51n2SkaRKSkmYCBhRsDGbJj5/PYHOPzNHGi30Y
	fztc5MslHwDFoYq6WfLtMXlqq4soXce0qxYzgeO2KkxwXmvJU6FYQcs8s+ZB7JpNayB4jQ7C0Jn
	NPHTP9pLI2tKaD34jC4E4jLSOlCotXg788va5PdCE+k0DNkY+2gqWSy/grE0=
X-Gm-Gg: AYBFou37kjmWvQwZ8kW3ibcn6CBcctV2hqsEQeO59kyKULSj93EKGAzT64c7ws4heNy
	71YuTYWcp8kSsANyrKJRKvfVJVIoVdt1zFmylm5Po3U50e3BuQHgnml/hQ052eJems+uTJ2JjR9
	PFx/DVQ9hPHFYkqA8WoWvfTAv4Xg7jtdMclXNzNEQ9N3mgTAJe8Qim45WcF9eP9i9Btn6zyMWv8
	HxLi8ts13wdOiqYNbFDQu0MWBFndumaC+z7KjjYU5JOzMbZvaaVDMUIYtHJL5A8x48tDCU5CNLg
	BE2ZzoV0+mAAIATA6q/s8h6tco17fGRQabVL+5W8katTlZKose0O1UXz4xyFEdNoZZzZ8th5R3U
	iArvBj0i54SnSFA==
X-Received: by 2002:a05:620a:2b86:b0:93a:14c3:72c2 with SMTP id af79cd13be357-93bb7899ff7mr241442685a.29.1789549703909;
        Wed, 16 Sep 2026 02:08:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2b86:b0:93a:14c3:72c2 with SMTP id af79cd13be357-93bb7899ff7mr241437785a.29.1789549703326;
        Wed, 16 Sep 2026 02:08:23 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83d9fae9sm62245965e9.6.2026.09.16.02.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:08:21 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:08:21 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v3 2/2] net: stmmac: preserve real_num_tx_queues on
 mqprio setup failure
Message-ID: <aqpchcYpOyX81Mg2@lore-desk>
References: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1@oss.qualcomm.com>
 <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-2-a76b1e2547c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S8iDoxvwvSgyEDhq"
Content-Disposition: inline
In-Reply-To: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-2-a76b1e2547c1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BdVNQbt2 c=1 sm=1 tr=0 ts=6aaa5c89 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=Lp37R7SOy4hbW3zDwkYA:9 a=CjuIK1q_8ugA:10
 a=Q-2sS2yn6ixtiu_JKUcA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX7xZ+QUFJM0gW
 u2Od3Ox3zEkT3F/i9Y+2pJXa9qeiHJQAxOkhNrX6VEwjdBn1sbu4tyhdeg71gFhCcT98PYPwr3j
 qE0I57uHSX01YWvrvNjkj6XUEpHUwAJcuiIbOKnZ83rkj0qnaQ5Roj5mGdHeTMkDEdkSd8buQAh
 w5rJnvqcFY5M+pXlfo4VPeGHEW68aydfTlGgnsrU9+okyHCrbvHnM3IQDPToAID27WvZbTfKRmA
 g8+cQ4YATzvsU/drTwiDAYvGVwo7BuF2eOfXrDCUTYmCxzDhW2iVQ3KooMn9sbjYU1MV7Mt29j5
 3SiYE95LlcTyKdQTZz22wtGv2AkrVyUizp/XUDzZJGyHYOBeyvrHE4qHyPL80Z29rHqb8zrhAac
 a9hbx96ZDrV7DPlB6qYGIQnSfcggV6oofEjYeJqAkXnJ72TvFus6QO9iXl+MY4XqtFDztTJJ9+K
 Yy3lFwT3pFOfpFHfN8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX6x7aqEyJ379z
 yf1/Jq/Qtb47bFrYlh/FVjZjjAfSdnx/nXrS5wzWJbj5eky3UvBATEyYn6O7J8/G6sMb5SsrhBg
 BDRUe+AzyktBe7cbjPrwVv6uYl4GrFU=
X-Proofpoint-GUID: aM4aA45_-9_hmQW2pyH4rHrSz73v2DBl
X-Proofpoint-ORIG-GUID: aM4aA45_-9_hmQW2pyH4rHrSz73v2DBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160116

--S8iDoxvwvSgyEDhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> With the FPE preemption-class mapping error now propagated from
> stmmac_fpe_map_preemption_class(), tc_setup_dwmac510_mqprio() can fail
> on the mapping step. The error path used to call stmmac_reset_tc_mqprio(),
> which resets the number of real TX queues to priv->plat->tx_queues_to_use
> (the platform maximum), overwriting the value that was active before the
> offload was attempted (for example a lower count left over from a previous
> mqprio configuration).
>=20
> The issue can be triggered using the following configuration:
>=20
>   # First mqprio config lowers the hw queue count below the platform
>   # default (e.g. 8 TX queues).
>   $tc qdisc add dev eth0 root handle 1: mqprio queues 2@0 2@2
>=20
>   # Replace mqprio configuration with a second one that fails FPE
>   # preemption-class mapping. stmmac driver resets the real_num_tx_queues
>   # to the platform maximum, losing the previous configuration.
>   $tc qdisc replace dev eth0 root handle 2: mqprio queues 2@0 2@2 fp E P
>=20
> Save ndev->real_num_tx_queues before lowering it and restore it,
> together with the TC-to-queue and priority-to-TC mappings, when the FPE
> preemption-class mapping fails, instead of resetting the queue count to
> the platform maximum.
>=20
> Note that a failed setup makes the qdisc layer run mqprio_destroy() on
> the new qdisc. Because priv->hw_offload is only assigned after
> ndo_setup_tc() succeeds, mqprio_destroy() calls netdev_set_num_tc(dev, 0),
> so dev->num_tc ends up 0 regardless of the driver-side restore and the
> previous qdisc is not reactivated. The restore is still needed to keep
> real_num_tx_queues and to avoid leaving the failed configuration's
> TC-to-queue and priority-to-TC mappings in place.
>=20
> Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 82 +++++++++++++++++++=
------
>  1 file changed, 62 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_tc.c

commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260911-stmmac-tc_setu=
p_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1%40oss.qualcomm.com

[...]

> -	err =3D netif_set_real_num_tx_queues(ndev, num_stack_tx_queues);
> +	err =3D stmmac_set_ndev_tcs(ndev, qopt->num_tc, tc_to_txq);
> +	if (err)
> +		goto error_reset_tc;
> +
> +	ndev_num_tx_queues =3D ndev->real_num_tx_queues;
> +	err =3D netif_set_real_num_tx_queues(ndev, num_tx_queues);
>  	if (err)
> -		goto err_reset_tc;
> +		goto error_reset_tc;
> =20
>  	err =3D stmmac_fpe_map_preemption_class(priv, ndev, extack,
>  					      mqprio->preemptible_tcs);
>  	if (err)
> -		goto err_reset_tc;
> +		goto error_reset_num_tx_queues;
> =20
>  	return 0;
> =20
> -err_reset_tc:
> -	stmmac_reset_tc_mqprio(ndev, extack);
> +error_reset_num_tx_queues:
> +	if (netif_set_real_num_tx_queues(ndev, ndev_num_tx_queues))
> +		netdev_warn(ndev, "Failed to restore %u TX queues\n",
> +			    ndev_num_tx_queues);
> +error_reset_tc:
> +	stmmac_set_ndev_tcs(ndev, ndev_ntc, ndev_tc_to_txq);
> +	for (i =3D 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
> +		netdev_set_prio_tc_map(ndev, i, ndev_prio_tc_map[i]);

- Is the loss of the FPE reprogramming step on these two labels intentional?
  The old err_reset_tc path went through stmmac_reset_tc_mqprio(), which en=
ds
  with:
  	return stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
  The new error_reset_num_tx_queues / error_reset_tc labels only touch netd=
ev
  software state (stmmac_set_ndev_tcs() -> netdev_reset_tc() /
  netdev_set_num_tc() / netdev_set_tc_queue(), plus
  netdev_set_prio_tc_map()), so the hardware mapping is never rewritten.
  - I guess we have already discussed about it. If qdisc replace fails, I t=
hink
    the driver should restore the previous offloaded hw configuration. It i=
s then
    up to sch_mqprio qdisc to properly restore the logic. Here sch_mqprio d=
oes
    not run mqprio_disable_offload() and this one seems a sch_mqprio bug to=
 me.

Regards,
Lorenzo


> =20
>  	return err;
>  }
>=20
> --=20
> 2.55.0
>=20

--S8iDoxvwvSgyEDhq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqpchQAKCRA6cBh0uS2t
rBBCAQDRlOxiCPPJ3sCvvfdFTDMDQ5Ut/zQo1xpKhzf6U9ggXwEA+cBSE4+3t0YG
CyDvRnKtUJ74H4LFtzU47fKvrHWBrAI=
=9SLr
-----END PGP SIGNATURE-----

--S8iDoxvwvSgyEDhq--

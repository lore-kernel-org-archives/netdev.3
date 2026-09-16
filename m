Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E5453A44
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544144; cv=none; b=qqbVwLEarSysJtAVqarqXpDjfaMBXLFnpZoFNPPACsT2nUS/Oc07AWasGybss2RTRFkU37ur4ys1LCRDfFQa2ud4LQleG74oqKN1SAEV7e/hEs1UICBGgBly018V3t3Dy5WksyFNUVkvW9kNdleRwwNXX2mX7NMF3rr6eiUTn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544144; c=relaxed/simple;
	bh=NpnsHCBx+W3WOKRYIjSOhHoOAaSrj6ddsoh1DYYbv2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BydB94nFDeF2o6XQEvWpOKkvtYUjxdYKXNhk5UmlBe0D7ApOpVwPMtJtdIyR79SND/OGt2cjHYv7AybNixnChvQUqSxznlRyXpxSN+7dcEjUtJI8RUKrzitjH7iGooxn9WK4dd62zM5tzwYjAMF7g17b64hkhoF+SzZyxHLdPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jR2WPIpR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PS/eJChE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jR2WPIpR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PS/eJChE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G6926s1333318
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uEfR/5S3Wv5GzRV9EH6EqanQ
	/UM6ccry5/7wH1HKDnI=; b=jR2WPIpRAdQpk5U4nBcPdRgJwfYE172GE7rL/IKh
	DKkUStrO6YmEp9Mo1fcnPSVOEpCAwixgtxOXJdQarmN+kcWQNNswgy6EMwN3GFNT
	Ch5eRAyAArkghUjHcF6rfvg3V/5yG0VOxw4hhDcXYd6TIPNHtFDCPK5FijyonfVO
	bG7OeS1hsmq3Ye8n/f90iAEIqI00wuI+e4FM6CbEqLGkkDuAektcdhTjDuPxrsbA
	QFZO2L2EuliREOxkPU78PMY7bycsWUiCY7vF3/4lE0genNITdCcTPEC2Nxv0k0ST
	+MXT0bjPBq22tPwrsM8CWup2m2XE0/nYFmnmnz/bPVNzhQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqbmnjnkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:35:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a07b5b5efso341777785a.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789544110; x=1790148910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uEfR/5S3Wv5GzRV9EH6EqanQ/UM6ccry5/7wH1HKDnI=;
        b=PS/eJChEvMMprHwFFf+wvPRh4Zrg9y0DOxTHEjA1FrM/7eRSLS+S6jIyV7XpFV/awY
         UuXl14B9jQiQLx9q17j4/DlkYZ2vpMzPstyBnJx+DMq4rQcbrZ55LqWt8lZbkOai0Fcl
         DHWD600p2CO1jjgdOwgWZlskGTVGHEn5v+/QN96aoYFGfRpWHXDz9yhCgfZyuvMIOEX+
         hQdKq6ByFRPWgYYqdXXeUtq7OwFD3OB0z5ookT0szoLiOWHE3wjGlK3av2FjW4RoBJP+
         9wyt/pkNyS7FzLHCGHUzYtQ274QcTBxEAfJYe9Oh8hjTl5WmuK2Q5isH3bt9P6uSWOOq
         Nudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789544110; x=1790148910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uEfR/5S3Wv5GzRV9EH6EqanQ/UM6ccry5/7wH1HKDnI=;
        b=o6vAM3zYxRN8c0gyjgcGES3ytAydAcXl7Fovi32qOAHDftsVDhW50gqqQNoHTfscqm
         Qkm7m8szKq9Oz5RYT9djnmQveSM1WmUtmPjhKhUzH1Cg2Joa5lJIdXyfXcyAFVF2w02a
         73KDeUheoxd9ZOxrmtPxiF+NISmnXvqG9mGKRWyje1ZBF45Q/bRp58gWZ0NC/4euTzpk
         CIA99yqN0KrCYgdpR9JAUFGHU3EJTB2GDSRzZsOLo6/Vr7TekJ6jaiAQYiPsEB0G01JX
         fuoenuBpCubHR/7EfuX013Mo6LVsFhh0PjuT8ZO3yd3VoZWl8lxifD8oZMcPWxbkEgqs
         t1KQ==
X-Gm-Message-State: AFuF++k/zfo/Vr5lB+7wD+11SF3639auX/mK4V9G4H6/TQ+V7cIZLnyS
	vqWGw4znsi3djrifofCr6SjpdF9n+zF/KjQGYxGndZE8DNzvS6SziFmMJeRSZHOYD/OQCd3Fp5S
	2aADFZaChs/U7xh9hnD57GDB3z1HomRFNA95CWHM780NmxLkouytnJPcbocs=
X-Gm-Gg: AYBFou1S+W8JVQCTPxC/3ZyTa3psAZKQnCmtg8QXNNTeyGM52eHX2mWQlyesYgRuD7X
	ODh6XTzivxRhM1i+DRMifIJBLZnBCN3K4FrDoni9pJzDLVJJGF4RmhFrcJx3xHqhul38wRSosf7
	1W3RBZQxdXqOVwf+8jS/sc7y+40SF0VOkEscISPygQL6etClarLqMi2b+W0fFEnLJXW1TTeWSgY
	SU+uhBsN8IJY9LQbXVfJrSEnTLPeW6JbbU4ebFgY6UPM1S2SbhHyhreoKh041yWavL7z9rbeOM3
	OBVKEHFalwQ1xl4v9jkRuP9Ki6wCGVXX8B/P8TMbz+C1AayDa9+aqoeRKClggA8ePczMaTdfphJ
	uBBOBel3+37CUZQ==
X-Received: by 2002:a05:620a:170d:b0:939:fe07:a13a with SMTP id af79cd13be357-93a345d5f43mr953362885a.6.1789544109590;
        Wed, 16 Sep 2026 00:35:09 -0700 (PDT)
X-Received: by 2002:a05:620a:170d:b0:939:fe07:a13a with SMTP id af79cd13be357-93a345d5f43mr953359285a.6.1789544108926;
        Wed, 16 Sep 2026 00:35:08 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de63c5e7sm72892366b.53.2026.09.16.00.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:35:06 -0700 (PDT)
Date: Wed, 16 Sep 2026 09:35:05 +0200
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
Subject: Re: [PATCH net v3 1/2] net: stmmac: propagate FPE preemption-class
 mapping errors
Message-ID: <aqpGqfV2HdFKR1PB@lore-desk>
References: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1@oss.qualcomm.com>
 <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-1-a76b1e2547c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5b69i88zLkTSu1Wa"
Content-Disposition: inline
In-Reply-To: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-1-a76b1e2547c1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=POyaavqC c=1 sm=1 tr=0 ts=6aaa46ae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=J8cgxKmYb7H1puaGB6cA:9 a=CjuIK1q_8ugA:10
 a=QHj-6YDLfriWvGvl-S0A:9 a=IoWCM6iH3mJn3m4BftBB:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX2nNOklVt/KV7
 d64TFPIttTCW8cICa0cmYqaTyBqtWqg4q2VaULTsT3nQEjTxXVd7/IzRZdag3NdBf0Dem4k4jCT
 UJO6H1r2WOjb9xD0lVLqBFrGR5QAU1ucSaqD6ycPF6Uul0ZZKNK+6VwO3dttKOustZkEdPqVQmY
 FKF1QN+w7jZtS9seuQWGQ8tTZQNhnPUDU280QeIIeC+UJD3cxJ0W42CEOcyuZmMLa+dSlk32Cm9
 Y7CxQP4fPMvXI/9B/j9k9s6zgpK0XNGyJuJMr2DGWZnB2OEVpbBZ00iPAPndaKyjtGim1E4Yg4D
 C8VJJibpsdjGSUZBPF3Z0EczSnHGWSi39IM4GmbDeLtMo5ghnd9gSS5K7Sf3oAx0pnrsJbtZwUL
 Vyj8J/XRu3NUxF76ag6uVt0OCVeXoXKBLVLHttLM8m7H7Vfz+sATN5EXz/Ql6z6OgdtcEieQgWp
 cKRIH80aNN5T37IIUdw==
X-Proofpoint-GUID: Ios8G8iSNi53sQ1dms9Yj4A5tM6CUO9L
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX1N8Y/poK3fii
 FPoy04TFVAuhygvC848rWO8v0pfCZhCntFirZQZsKtiC2gwRp+T9tjV1FVXSGFz8Wl2iPQiNJYG
 1TlqoAQLqPlw+eiMVT2ccqJkjcaH+3Q=
X-Proofpoint-ORIG-GUID: Ios8G8iSNi53sQ1dms9Yj4A5tM6CUO9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160098

--5b69i88zLkTSu1Wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260911-stmmac-tc_setu=
p_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1%40oss.qualcomm.com

> stmmac_fpe_map_preemption_class() dispatches through the
> stmmac_do_void_callback() helper, which forces the callback's return
> value to 0 whenever the op pointer is populated. As a result the
> -EINVAL returned by dwmac5_fpe_map_preemption_class() (e.g. when a
> preemptible TC owns more than one TXQ under SP scheduling) is silently
> swallowed by every caller.
>=20
> Switch the dispatch macro to stmmac_do_callback() so the callback's real
> result is propagated, and honour it in the taprio and mqprio qdisc
> offload.
>=20
> Note that the taprio "if (ret)" check in tc_taprio_configure() used to
> be dead code and now becomes live: a preemptible TC spanning more than
> one TXQ under SP scheduling cannot be programmed in hardware, so a
> taprio or mqprio configuration that previously returned success while
> leaving the preemption-class register unprogrammed now fails with
> -EINVAL. For taprio, the failure also runs the disable path, tearing
> down the schedule that was just installed; this is the intended
> behaviour.

- Is the described condition narrower than what the code actually rejects?
  In dwmac5_fpe_map_preemption_class() the SP rejection is not gated on the
  TC being preemptible:
  - I guess we can do a little improvement of the commit message if I need =
to
    repost.
>=20
> Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.h      |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 19 +++++++++----------
>  2 files changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/eth=
ernet/stmicro/stmmac/hwif.h
> index 04dafec021b4..9314bcb85c22 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -494,7 +494,7 @@ struct stmmac_ops {
>  #define stmmac_set_arp_offload(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
>  #define stmmac_fpe_map_preemption_class(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, mac, fpe_map_preemption_class, __args)
> +	stmmac_do_callback(__priv, mac, fpe_map_preemption_class, __args)
> =20
>  /* PTP and HW Timer helpers */
>  struct stmmac_hwtimestamp {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_tc.c
> index 14cabe76e53e..5398616fcdfe 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -970,7 +970,7 @@ static int tc_taprio_configure(struct stmmac_priv *pr=
iv,
>  	struct netlink_ext_ack *extack =3D qopt->mqprio.extack;
>  	struct timespec64 time, current_time, qopt_time;
>  	ktime_t current_time_ns;
> -	int i, ret =3D 0;
> +	int err, i, ret =3D 0;
>  	u64 ctr;
> =20
>  	if (qopt->base_time < 0)
> @@ -1120,9 +1120,9 @@ static int tc_taprio_configure(struct stmmac_priv *=
priv,
>  		mutex_unlock(&priv->est_lock);
>  	}
> =20
> -	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
> +	err =3D stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);

- Can a failed TAPRIO_CMD_REPLACE now leave sch_taprio and the hardware out
  of sync?  In tc_taprio_configure() the FPE mapping is validated only after
  the gate control list has already been programmed and enabled:
  	ret =3D stmmac_est_configure(priv, priv, priv->est,
  				   priv->plat->clk_ptp_rate);
  	mutex_unlock(&priv->est_lock);
  	if (ret) {
  	...
  	ret =3D stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
  					      qopt->mqprio.preemptible_tcs);
  	if (ret)
  		goto disable;
  That "goto disable" was unreachable for every MAC providing the op while
  the macro forced 0, and becomes live now.  The disable block sets
  priv->est->enable =3D false, reprograms EST, zeroes
  priv->xstats.max_sdu_txq_drop/mtl_est_txq_hlbf/mtl_est_txq_hlbs and clears
  the preemption class register, and the function returns -EINVAL.
  - I think this issue is not introduced by this patch, but it is already t=
here
    and it should be fixed with a dedicated patch.

- Is this ternary reachable in any form other than "return ret;"?  Following
  the call with pclass =3D=3D 0:
  - dwmac5_fpe_map_preemption_class() takes "if (!pclass) goto
    update_mapping;" and falls through to "return 0;"
  - dwxgmac3_fpe_map_preemption_class() has no error return at all

  - I think the current implementation is more robust for any future change
    even if in the current code if pclass is 0, it can't return an error co=
de.

> =20
> -	return ret;
> +	return qopt->cmd =3D=3D TAPRIO_CMD_DESTROY ? err : ret;
>  }
> =20
>  static void tc_taprio_stats(struct stmmac_priv *priv,
> @@ -1237,14 +1237,15 @@ static int tc_query_caps(struct stmmac_priv *priv,
>  	}
>  }
> =20
> -static void stmmac_reset_tc_mqprio(struct net_device *ndev,
> -				   struct netlink_ext_ack *extack)
> +static int stmmac_reset_tc_mqprio(struct net_device *ndev,
> +				  struct netlink_ext_ack *extack)
>  {
>  	struct stmmac_priv *priv =3D netdev_priv(ndev);
> =20
>  	netdev_reset_tc(ndev);
>  	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
> -	stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
> +
> +	return stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
>  }
> =20
>  static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
> @@ -1257,10 +1258,8 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_=
priv *priv,
>  	u32 num_tc =3D qopt->num_tc;
>  	int err;
> =20
> -	if (!num_tc) {
> -		stmmac_reset_tc_mqprio(ndev, extack);
> -		return 0;

- Same question for the mqprio delete path: with pclass =3D=3D 0 the value
  returned by stmmac_reset_tc_mqprio() can only encode "callback op pointer
  missing", after netdev_reset_tc() and netif_set_real_num_tx_queues() have
  already been applied.  Is propagating it useful here, or would keeping
  "return 0;" after the reset match what the hardware state actually is?
  - Same here, I think the current implementation is more robust for any
    future change.

Regards,
Lorenzo

> -	}
> +	if (!num_tc)
> +		return stmmac_reset_tc_mqprio(ndev, extack);
> =20
>  	err =3D netdev_set_num_tc(ndev, num_tc);
>  	if (err)
>=20
> --=20
> 2.55.0
>=20

--5b69i88zLkTSu1Wa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqpGqQAKCRA6cBh0uS2t
rBXYAQDeTCb+b4tMZ+vIn9CP0NyzAFTiP6RzSd6WlENMsVMsEAEAxvwWwa2Fh7+u
yLq3I47qLOt5M84M3vAVz+vy61PJpww=
=/iNM
-----END PGP SIGNATURE-----

--5b69i88zLkTSu1Wa--

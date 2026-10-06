Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753D41442B
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290770; cv=none; b=u52GYPTjljqD8Ba9j66faYmgPAt3qUn/4Q71iytWfn12Vql5zQMef6y90V6YchOO8kf3qSSQxjjNPqMC+gbE5mioJiyQAaCItxSKiOkX5JEkASjhq/FleUkELu/IwnchN2cyBjdYkoKiT6f92S7zjPOBQP1ffchLyhNbh+RatYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290770; c=relaxed/simple;
	bh=HKgl3CglwVyBDHhAVdhvh27FHhcXciiJFKP5W3FEsN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USIUnA8g11blldw+zbFlshASdmJ5mQ1A/1QG56rkxkDs7EyjFAu5YoV6oFBEDFrlhj0b2tm5/PpEqoDPQ72YQ8PKJjoQf7o3RBCwVRcwlsVGhEsvBQHRewA8OWnNZ5kynUtqITJHaZNNb2ryqKOtVSlgfFTXoZnWKp0hNs77Oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0i0QvC8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BLL8rOeI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0i0QvC8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BLL8rOeI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPLGu3454735
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 12:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FbVkivpfpNWaYBFRJqIcd19B
	3Lm5ZxhVxyxWOYpj9Ho=; b=X0i0QvC8QXXVgdzJ7U0Pc4IcMBBfaO1cACnGnsci
	TuY+KeQFDaaCb5boI+W34cYw7lMduvWiN1SsDQxoj5qnNaladmI6mSA8T2yjZzTr
	YkxXPMASelW6kOIdL9acMJoDJrNuDnIdOIYF9BZO593YVxHY5T1NWkHNB8inCWQk
	T9T5SiiyNrGhQ9Nji6lxk+gKX/52KLUmGXCOSZOdlLGaNuQ4VCh1Hi/GPHO6FmmK
	j/4Jhmp28j+uqwPJ/el1vLaCOu3WJ7H3CU9jz3IalvMQNNaC4AfOv7b8K/3tA1na
	ckgLer7gpI5tIwQhD2xB1HFbA1Byp8Py+PX8EIeaTyadUQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4y91gdbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 12:45:55 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5e3ef255ffeso313850e0c.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791290754; x=1791895554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FbVkivpfpNWaYBFRJqIcd19B3Lm5ZxhVxyxWOYpj9Ho=;
        b=BLL8rOeIsSOr+xKi46RqAqTFpE+AwUWQ06CYrpbwc+6QQH5cRhFy42d9+fvs0KOFYl
         S9gzrhI2Z3WY3R6ITPHapzLWUKxvnIRhaa73Uy9b/lqPzUcFoej4Z9BVpiKVDRLeHV9R
         6j3Xe4/O4ThQZFcC1q4zb48tqlPqMvK7tpzpRZdU+O7PAE+0S9uZVjsuvkPvi3iCh7mf
         9C7JMmZv8XxwNnRAo3Zx/Oe+o3V5H90MWMF0V6k/4vkS2k6jZxJsM+mPIRbgKuPRLqEI
         Fvp5wonXbK1pe3IwwFJfmAe+4JK1yMZ5UAhaYAlRUMfwa83FPUz2dykPD0XUYTOP2UV1
         biDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791290754; x=1791895554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FbVkivpfpNWaYBFRJqIcd19B3Lm5ZxhVxyxWOYpj9Ho=;
        b=zgXryznYn2C8iZy3hlbxScvrAR4y4i3IwKyDm1wmwH1BMDDY7zZYQbLPymjEnikmH4
         jyUsFJXhAioiPo4Zho5IMMPOGrJEmftVs7wHzcQdDHTrl6UpX63Fpa1zpFzk8hXl2OXE
         6hGQRdMD5OtLTpJfkPQWTnXVmHJyZgNbgIq2nVmMvQ9U/k9lKjPG2aShYBUDwDJQO74/
         YRTR608Z4mJ/pun8zcb5hJaezeLsA9sLtKXXyzEc4kCMxCb0kgzwSZ7MT+2rWVXfVQqY
         WEDHfoys35HmZfnln5uFppoHlvHJS/oFpcZm0hv/wfFYwnMrDB43Sal4hR7E6wtRFypt
         9PUQ==
X-Gm-Message-State: AFq9FYJuYERorhkydF8E7FCvcaz3Aid0dfogCuTgWkYYmZYZpl0ZlX6G
	Py+Av7WkcXpFk2LIsSeog0lvPIJCJq3UTJuJ4vF2oEjUw43YU5CdxTmanGAtPvGJkpHGOgcwCyd
	6mv5FpRdgxK8ytz27g/sSYorPgMyPp+e3RdJKqAfMCEwGwgdGt3fKH2evRjU=
X-Gm-Gg: AYBFou3TsruK+iOjb9fiFnNusShftuFurVRFUHFRcLoC6UDpuXwzGLSc1f3Na7jBm1p
	RZMWy5oDtzr9FDG/bK+pKPlD4WL1gBUJuOfhPiqfXHB/pf6pqlvG3Ck/W8jubmqMMn+09j4k8nD
	vcTn8C53qCWDKkQZx6YeIjwhcGGkBF/c1c58Mmfw3bbfENVMP1ohzcN2hJlsZxwuy/hfiHAw7Ez
	gdTm7wDj1WtUL9XSLTp6/5oS64JKTtDifPLNQIESistvJHvMv8Z7++eRBHAp/ljR18lwJ9i3pL3
	K5uxOS2sgL8BQcUNN1EsSma9OcIsFJE3abmEX8Km+9xI9WVUlA1GI+prPKNPR3E/bsxCzrKvBEa
	eLXn93F9uShqjtA==
X-Received: by 2002:a05:6102:149c:b0:7a7:ce1f:6b95 with SMTP id ada2fe7eead31-7c877ce24d2mr279274137.2.1791290754034;
        Tue, 06 Oct 2026 05:45:54 -0700 (PDT)
X-Received: by 2002:a05:6102:149c:b0:7a7:ce1f:6b95 with SMTP id ada2fe7eead31-7c877ce24d2mr279212137.2.1791290750344;
        Tue, 06 Oct 2026 05:45:50 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c69afe66bsm4402752f8f.30.2026.10.06.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:45:49 -0700 (PDT)
Date: Tue, 6 Oct 2026 14:45:48 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: serialize PTP timestamping
 configuration with priv->lock
Message-ID: <asTtfFEiprbiLJA5@lore-desk>
References: <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6hfszCiDjWHCFxZ3"
Content-Disposition: inline
In-Reply-To: <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfX7J2YT2XY8aak
 juipGY/02z5S27hNlEaLSPLOxCRsAdTtRrDyTlFbe5jq7qQF3ItyIbBFlBJTKz7Sou4Naj8457P
 cyoq1y/QPdeWBlUlx+HZvvSOes1Ay3I=
X-Authority-Analysis: v=2.4 cv=Ho/jiETS c=1 sm=1 tr=0 ts=6ac4ed83 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-_Ip9hOUUtcLEFov2a0A:9 a=CjuIK1q_8ugA:10
 a=QyMo_hAzWTYccEiHbj4A:9 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfX9LK2vEguGbs3
 pjxSuYp0F63dXOutzGsa+LVHC4XMk+rFqTxekD+J1p0D47GqWgFz+xUSb29mMkdhgsc/bsBDR53
 7nQltAyhZGg601GbVQi07ZUFkpdObwOIEAfBtapWWbDWy/LSlvIxNkdlhT3wh/c8nn52LRbjjZ2
 TahwOC5W1guZkF9gxzICq73Dfy//H0Q2UGMHUjZxMOImoPqqow+MaxdwrmHNtEHD0gOdQCIrF8o
 zSjwhXqUqwX+BFekPPV3T9Wj1czUqnaS1OgNpniSMX9UK1BEwDGqoinzKhuGkf4aCw3ypqB40ms
 Pts05gZiUApMIhhvgfb0esmdwI+k+Tsv7wbB8az0XfAmJewLNCH+JVTpL6YAzDmYqCdzrPi/0aL
 ovpuulPkp/RsyhWWic7T0s5tjjkBiJGB4WzjmZI5uBBLrmlr/19xehUp7XifWGoRaRaIijkhCkG
 SXK9jAcdi89kSIch59g==
X-Proofpoint-ORIG-GUID: HObQKfurjTGFsxZrJXzba8tjUQTspqMt
X-Proofpoint-GUID: HObQKfurjTGFsxZrJXzba8tjUQTspqMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060050

--6hfszCiDjWHCFxZ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> stmmac_dl_ts_coarse_set() runs under devl_lock only while
> stmmac_hwtstamp_set() runs under RTNL. They read/write
> systime_flags/tsfupdt_coarse and run stmmac_config_hw_tstamping().
>=20
> stmmac_dl_ts_coarse_set() snapshots priv->systime_flags, programs
> PTP_TCR, PTP_SSIR and PTP_TAR, and only then publishes tsfupdt_coarse
> and systime_flags. A concurrent stmmac_hwtstamp_set() can read the
> stale tsfupdt_coarse, build fine-mode flags, program PTP_TCR in fine
> mode and set hwts_rx_en.
>=20
> Take priv->lock in both stmmac_dl_ts_coarse_set() and
> stmmac_hwtstamp_set() so the timestamping configuration is updated
> under a single lock.
>=20
> Fixes: 6920fa0c764d ("net: stmmac: Add a devlink attribute to control tim=
estamping mode")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

I need to rebase this patch in order to fix new conflicts with net tree.

Regards,
Lorenzo

> ---
> Changes in v2:
> - Use proper Fixes tag.
> - Link to v1: https://lore.kernel.org/r/20261002-stmmac-hwtstamp-missing-=
lock-v1-1-189ce151a624@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 43 ++++++++++++++---=
------
>  1 file changed, 27 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9741f97fa37a..a6793054a179 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -685,14 +685,7 @@ static int stmmac_hwtstamp_set(struct net_device *de=
v,
>  	u32 snap_type_sel =3D 0;
>  	u32 ts_master_en =3D 0;
>  	u32 ts_event_en =3D 0;
> -
> -	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> -		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
> -		priv->hwts_tx_en =3D 0;
> -		priv->hwts_rx_en =3D 0;
> -
> -		return -EOPNOTSUPP;
> -	}
> +	int ret =3D 0;
> =20
>  	if (!netif_running(dev)) {
>  		NL_SET_ERR_MSG_MOD(extack,
> @@ -700,13 +693,23 @@ static int stmmac_hwtstamp_set(struct net_device *d=
ev,
>  		return -ENODEV;
>  	}
> =20
> -	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x=
%x\n",
> -		   __func__, config->flags, config->tx_type, config->rx_filter);
> -
>  	if (config->tx_type !=3D HWTSTAMP_TX_OFF &&
>  	    config->tx_type !=3D HWTSTAMP_TX_ON)
>  		return -ERANGE;
> =20
> +	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x=
%x\n",
> +		   __func__, config->flags, config->tx_type, config->rx_filter);
> +
> +	mutex_lock(&priv->lock);
> +
> +	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> +		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
> +		priv->hwts_tx_en =3D 0;
> +		priv->hwts_rx_en =3D 0;
> +		ret =3D -EOPNOTSUPP;
> +		goto unlock;
> +	}
> +
>  	if (priv->adv_ts) {
>  		switch (config->rx_filter) {
>  		case HWTSTAMP_FILTER_NONE:
> @@ -829,7 +832,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  			break;
> =20
>  		default:
> -			return -ERANGE;
> +			ret =3D -ERANGE;
> +			goto unlock;
>  		}
>  	} else {
>  		switch (config->rx_filter) {
> @@ -859,8 +863,10 @@ static int stmmac_hwtstamp_set(struct net_device *de=
v,
>  	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
> =20
>  	priv->tstamp_config =3D *config;
> +unlock:
> +	mutex_unlock(&priv->lock);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  /**
> @@ -7753,9 +7759,12 @@ static int stmmac_dl_ts_coarse_set(struct devlink =
*dl, u32 id,
>  {
>  	struct stmmac_devlink_priv *dl_priv =3D devlink_priv(dl);
>  	struct stmmac_priv *priv =3D dl_priv->stmmac_priv;
> -	u32 systime_flags =3D priv->systime_flags;
> +	u32 systime_flags;
>  	int ret;
> =20
> +	mutex_lock(&priv->lock);
> +
> +	systime_flags =3D priv->systime_flags;
>  	if (ctx->val.vbool)
>  		systime_flags &=3D ~PTP_TCR_TSCFUPDT;
>  	else
> @@ -7768,13 +7777,15 @@ static int stmmac_dl_ts_coarse_set(struct devlink=
 *dl, u32 id,
>  	if (ret) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "failed to reconfigure PTP adjustment");
> -		return ret;
> +		goto unlock;
>  	}
> =20
>  	priv->tsfupdt_coarse =3D ctx->val.vbool;
>  	priv->systime_flags =3D systime_flags;
> +unlock:
> +	mutex_unlock(&priv->lock);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int stmmac_dl_ts_coarse_get(struct devlink *dl, u32 id,
>=20
> ---
> base-commit: aaaaf87ea99b8766c9a8aa0e71aa42e6bc8a5320
> change-id: 20261002-stmmac-hwtstamp-missing-lock-b6a7979c643c
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--6hfszCiDjWHCFxZ3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasTtfAAKCRA6cBh0uS2t
rM5NAP9Eza8nyukSl9Qo1CMplJnUvHBmCko08k7lFeliq50iBwD/QJp1fcMk51+3
rSPRkfEo2InsTtqIfLt4rb751iUC7Qc=
=JIfZ
-----END PGP SIGNATURE-----

--6hfszCiDjWHCFxZ3--

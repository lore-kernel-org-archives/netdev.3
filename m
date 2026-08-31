Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BAC39891F
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188004; cv=none; b=ZY/6oGJcHm07arbKJG0zNVO/bCJQHAk0reN6wNB0skfMvVG7Exdg11DF29SCN15dAmPYYTdem4sleuqz3fKsHhQ0q6H2euZw9rq6Z/Tnqjxit9e6udlEbDAbRag7rE3+z29v0GUoo8b/oehWgKLhqWyFrnu7Jd2iwBAYMhyeVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188004; c=relaxed/simple;
	bh=Q24dRF/nr/2PDw5S3pcnkpx39hu9HLtSdwyqRrsgbTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOd2I/utVJgEb14P88ag7dLeXDFK6r25lWww8sMhB4XTR15DjpfdMdmbehCkC+MzWBlPdFPemiYDLtt8sz9ZBgd05jLPYv8Vpw3/vI186KsKRirzZBWACTIG14jsUXCH+FsMTn//eLxpQ8sQjaJZ569eGbFSfzews4ecdyWWBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KnmebIwP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PM+tx+ci; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KnmebIwP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PM+tx+ci"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETG4R3894980
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Pns1MihtwmL9c9kT7PkCbhGs
	fSXcaatikP6GSVqofzI=; b=KnmebIwPGIvQjMQbwb2Ri7O6NXENkpCYU1MPlyg9
	jJm8lPmH6SY8c3U6eEv+DklfaKhiiOrfrdRwbkhb3u5JeBnVkPXRUZdAeqdOUEmn
	rrIxBYaUt8LyOcZqDPrImL+VtZkuuEmSnk/k3YmgAIfgSgXIDCIEgCjsT5Lwt1LT
	vcHYvGF8mB1yV2lMTKO3iQmEaB7uEBcgSU52kzgS56sRjdVrbzSspnkLDV36N9lH
	jqe7IwXuv+vtS8PBnK0n2kQ3Cn3M6rbTnUouN+RW6vKhcdpepvgcyT4dpGfj29Ct
	YjRYa+yTwD44mlT+xll+QwE+jUEY4veN5h05MHv7W24Glw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rb9c26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:53:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5fc4c7e9so324430585a.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188001; x=1788792801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pns1MihtwmL9c9kT7PkCbhGsfSXcaatikP6GSVqofzI=;
        b=PM+tx+cik92v38kQmcQssg00B2s3kWkQh78SkwWP81F05khqKQ38R5n3/pfo39g+JP
         KzowHxYjMqmGAHoNpGeAZPB+TfNR8r6pTIJ5H+A8HWkVVIy6S2rG/mB5ycI2YhBe1BKJ
         YhQdSwLtnVkPUEyYaP9BoVTk+pRHDcKbrBbTVcJnUeor3X43WyTniqErYbN15LiY3Pzb
         zcmBbzfQQV28ovwFIGNOB0G+MKfoCG6AbK4+rsICow3NAxyu3TNlXPA8lw6M6XIoaAIb
         sZwMq0BfJVPwsrO5r9Mbu/AFFv56fYqqh7FZZPfkG5S3/nV/bIgRr9/SYnYNSZ+7GrsT
         hmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188001; x=1788792801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pns1MihtwmL9c9kT7PkCbhGsfSXcaatikP6GSVqofzI=;
        b=d59gTTel/0jgaDbWbICAucIQwjyEJtgiBLwGZSU4D1xIzJ8oYKR4kSEi4JQ4PKF+oE
         JCuYWcveN9bojIU2hb6s85F1quZvchPsSxsS9Qe2tRn0FH+2WzNsnk7hjO59XwndOJLK
         KuzUW2R2vidC/LnbhdbUXYyxFq6YYFpXYyJxjnYliIcteAToJcGw2iBp3L0vK6JJ51eZ
         mExeMJP/nega7Rdl3rxMDyKQ5br0yv6v0HJoLQh49gC+S09myPGyEaodxNPiVB3lHWiO
         aox7+XdS6T8wO9SbqmsbQwzkHAiHeyCVI8sgW4DuNOHf/GN6b/bRTcUi9+1wtw//IxO8
         IC6A==
X-Gm-Message-State: AFuF++ky2Rqkrw/KqsCw+aPztfAhxuqAs48lL8eGTZxP8X+NGO08yxYK
	OGY2o7rD6dSd0sz4DAMccdzAh9LukFYJIZHpzrsL1UCXUCMF0rQ/fvcKFIbDpyPntQeGiBXQofe
	M1Os9wowXZIzWV/caCmnvgRGlO3g0CPGMbMN2oDlzjefHxNpjrKCetCUrl8c=
X-Gm-Gg: AR+sD10PV74oDcR6TaBZLrXnlBw8BbWdSmo8J1nD494tYf1MBMg2NcR37wa5ORTinr4
	mXCMucpFtfUKvSPMyAfGNRfxsTrQ1xd7GUF/v0XBFjoa1KFsiDGnR/vzNknEnDWN/zQvmUIkbZH
	9JjvJVnX5RuNph+3ipLFQYbj/xvXnBIDJ0eL1+WEC2O9zDz9y2mn25268cFOgFzan9NYoggOO6r
	P2hnMKxywdM0cFkLRKd3D8c6bC6wtGdCA5bIuyQy4kJpICsWeVZvW5C7WnqBBPMYvY/d43aIV2x
	j0ZMIkMizR65jhi62zR6P8b9Xs0GWOCW0x6rEHHJDtibqXYlutsQl2xy9aW6IvoHQ3nMpunF9iO
	ryb4MliQeLUiO0Q==
X-Received: by 2002:a05:620a:678c:b0:939:4a47:932b with SMTP id af79cd13be357-9394a47946fmr18917585a.36.1788188000980;
        Mon, 31 Aug 2026 07:53:20 -0700 (PDT)
X-Received: by 2002:a05:620a:678c:b0:939:4a47:932b with SMTP id af79cd13be357-9394a47946fmr18907885a.36.1788188000170;
        Mon, 31 Aug 2026 07:53:20 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2e6e8sm25248955f8f.32.2026.08.31.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:53:19 -0700 (PDT)
Date: Mon, 31 Aug 2026 16:53:18 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>
Subject: Re: [PATCH net v2] net: stmmac: re-apply taprio offload in
 __stmmac_open()
Message-ID: <apWVXj8eGhckxhMD@lore-desk>
References: <20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Uy84GhePRTg6nSKL"
Content-Disposition: inline
In-Reply-To: <20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: XoeeNfQ7QHSR_pRC_BR4C27sXMdMnhcb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOCBTYWx0ZWRfX5OxO6h/ShMbq
 TN2Tzrv84ZbsnYdHamZ+bGfrcTDgwXdmG1FaMVql1gKe5eMIp1H6FV1aBiM+fSiR3pBUFelctAU
 THto9mIViD3V94mm11zLgYkG1lAiYnhVTvYrZ8kWZUzIOAudt2pOEJw/VSPzitbyYW2xFzSSypq
 9j86oTanKHQpi8vWb5ZEuFg8QRVYtRKdCUPwpleZK/uAUFvGCCqdRiU2CeFGJJ6S47RktV/Ris9
 6PAjI2JD98HKzZ/CJVjyzXrt48Pg7m8B80SqaqGTApgA8UBK6LybZnXLgZki5Qr7vOdJxHZs25J
 Y23UZCvcEIsgJI0bdDwhZaWq2ypFSpqY4dAUptuSAnuKH6I9BbcsFHi+rx4cwiAOn8p4lGedGLz
 yVL+/APq3ouC2Ic7/AbyZGzFCIh4YklLl4sadtU7E4syExiSrNnZ1VTSEVNyf66OSk9j7Hnxb6Y
 cYvoc0wNEUKpeFZjjTg==
X-Proofpoint-GUID: XoeeNfQ7QHSR_pRC_BR4C27sXMdMnhcb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOCBTYWx0ZWRfXzo6OcHntsXZE
 /D3KEjjANwqgfEPP3ngWS+DWNZV/kphVKaluKulg8ku3XGL4VgyaTex8byfabNm474iS9uhGVpW
 7ezJVqkgsyvqs3L2gC9OoWkfy5Jx9ss=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a959562 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=JpBpa1p7AAAA:8 a=YmQodEPVK1i-oBXoWTAA:9
 a=CjuIK1q_8ugA:10 a=OdBlZyHpQ6Ekdqw2xb0A:9 a=IoWCM6iH3mJn3m4BftBB:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=YCh05so4W2E6r1tszMC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310128

--Uy84GhePRTg6nSKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The core soft reset issued in stmmac_init_dma_engine() clears the
> MTL_EST registers, but nothing re-applies the taprio offload after it:
> priv->est->enable stays true while the hardware EST block is left
> disabled. The TX/XDP paths then keep dropping frames larger than
> priv->est->max_sdu[] and taprio is reported as offloaded, although the
> EST block is not programmed.
>=20
> Re-apply the taprio offload in __stmmac_open() after PTP is up. The
> base time is recomputed from the reserved base time and the current PTP
> time, since the timestamp counter has been re-initialized and the
> previously programmed base time is stale.
> Introduce the stmmac_setup_est utility routine.
>=20
> Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler AP=
I")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rename stmmac_est_reconfigure() in stmmac_setup_est().
> - Rely on stmmac_setup_est() in tc_taprio_configure().
> - Link to v1: https://lore.kernel.org/r/20260825-stmmac-est-reapply-after=
-open-v1-1-dfa80735e0a1@oss.qualcomm.com

I will fix the issues reported by the following sashiko's report in v3.
https://sashiko.dev/#/patchset/20260829-stmmac-est-reapply-after-open-v2-1-=
5e5ccb185e92%40oss.qualcomm.com

Regards,
Lorenzo

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 33 +++++++++++++++++=
++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  2 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 16 +++++++++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 26 ++----------------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 27 ++++++-----------=
--
>  5 files changed, 59 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_est.c
> index afc516059b89..bbebd33c8a88 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> @@ -80,6 +80,39 @@ static int est_configure(struct stmmac_priv *priv, str=
uct stmmac_est *cfg,
>  	return 0;
>  }
> =20
> +int stmmac_setup_est(struct stmmac_priv *priv)
> +{
> +	struct timespec64 current_time, time;
> +	ktime_t current_time_ns, basetime;
> +	u64 cycle_time;
> +	int err;
> +
> +	mutex_lock(&priv->est_lock);
> +
> +	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> +	current_time_ns =3D timespec64_to_ktime(current_time);
> +
> +	time.tv_nsec =3D priv->est->btr_reserve[0];
> +	time.tv_sec =3D priv->est->btr_reserve[1];
> +	basetime =3D timespec64_to_ktime(time);
> +
> +	cycle_time =3D (u64)priv->est->ctr[1] * NSEC_PER_SEC + priv->est->ctr[0=
];
> +
> +	time =3D stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time=
);
> +	priv->est->btr[0] =3D (u32)time.tv_nsec;
> +	priv->est->btr[1] =3D (u32)time.tv_sec;
> +
> +	err =3D stmmac_est_configure(priv, priv, priv->est,
> +				   priv->plat->clk_ptp_rate);
> +
> +	mutex_unlock(&priv->est_lock);
> +
> +	if (err)
> +		netdev_err(priv->dev, "failed to re-configure EST\n");
> +
> +	return err;
> +}
> +
>  static void est_irq_status(struct stmmac_priv *priv, struct net_device *=
dev,
>  			   struct stmmac_extra_stats *x, u32 txqcnt)
>  {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_est.h
> index f70221c9c84a..f620d3331c2c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> @@ -65,3 +65,5 @@
>  #define EST_GCL_DATA			0x00000034
> =20
>  extern const struct stmmac_est_ops dwmac510_est_ops;
> +
> +int stmmac_setup_est(struct stmmac_priv *priv);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index d576059c04df..b30036428188 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -48,6 +48,7 @@
>  #include "stmmac_ptp.h"
>  #include "stmmac_fpe.h"
>  #include "stmmac.h"
> +#include "stmmac_est.h"
>  #include "stmmac_pcs.h"
>  #include "stmmac_xdp.h"
>  #include <linux/reset.h>
> @@ -4153,11 +4154,22 @@ static int __stmmac_open(struct net_device *dev,
>  	ret =3D stmmac_hw_setup(dev);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> -		goto init_error;
> +		return ret;
>  	}
> =20
>  	stmmac_setup_ptp(priv);
> =20
> +	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
> +	 * registers, so re-apply the taprio offload after PTP is up.
> +	 */
> +	if (priv->est && priv->est->enable) {
> +		ret =3D stmmac_setup_est(priv);
> +		if (ret < 0) {
> +			priv->est->enable =3D false;
> +			return ret;
> +		}
> +	}
> +
>  	stmmac_init_coalesce(priv);
> =20
>  	phylink_start(priv->phylink);
> @@ -4181,7 +4193,7 @@ static int __stmmac_open(struct net_device *dev,
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> =20
>  	stmmac_release_ptp(priv);
> -init_error:
> +
>  	return ret;
>  }
> =20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 960249960004..917ef7ddcae6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -8,6 +8,7 @@
>    Author: Rayagond Kokatanur <rayagond@vayavyalabs.com>
>  ************************************************************************=
*******/
>  #include "stmmac.h"
> +#include "stmmac_est.h"
>  #include "stmmac_ptp.h"
> =20
>  #define PTP_SAFE_TIME_OFFSET_NS	500000
> @@ -55,7 +56,6 @@ static int stmmac_adjust_time(struct ptp_clock_info *pt=
p, s64 delta)
>  	u32 quotient, reminder;
>  	int neg_adj =3D 0;
>  	bool xmac, est_rst =3D false;
> -	int ret;
> =20
>  	xmac =3D dwmac_is_xmac(priv->plat->core_type);
> =20
> @@ -84,30 +84,8 @@ static int stmmac_adjust_time(struct ptp_clock_info *p=
tp, s64 delta)
> =20
>  	/* Calculate new basetime and re-configured EST after PTP time adjust. =
*/
>  	if (est_rst) {
> -		struct timespec64 current_time, time;
> -		ktime_t current_time_ns, basetime;
> -		u64 cycle_time;
> -
> -		mutex_lock(&priv->est_lock);
> -		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> -		current_time_ns =3D timespec64_to_ktime(current_time);
> -		time.tv_nsec =3D priv->est->btr_reserve[0];
> -		time.tv_sec =3D priv->est->btr_reserve[1];
> -		basetime =3D timespec64_to_ktime(time);
> -		cycle_time =3D (u64)priv->est->ctr[1] * NSEC_PER_SEC +
> -			     priv->est->ctr[0];
> -		time =3D stmmac_calc_tas_basetime(basetime,
> -						current_time_ns,
> -						cycle_time);
> -
> -		priv->est->btr[0] =3D (u32)time.tv_nsec;
> -		priv->est->btr[1] =3D (u32)time.tv_sec;
>  		priv->est->enable =3D true;
> -		ret =3D stmmac_est_configure(priv, priv, priv->est,
> -					   priv->plat->clk_ptp_rate);
> -		mutex_unlock(&priv->est_lock);
> -		if (ret)
> -			netdev_err(priv->dev, "failed to configure EST\n");
> +		stmmac_setup_est(priv);
>  	}
> =20
>  	return 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_tc.c
> index 14cabe76e53e..b41df317d73c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -10,6 +10,7 @@
>  #include "dwmac4.h"
>  #include "dwmac5.h"
>  #include "stmmac.h"
> +#include "stmmac_est.h"
> =20
>  static void tc_fill_all_pass_entry(struct stmmac_tc_entry *entry)
>  {
> @@ -968,8 +969,7 @@ static int tc_taprio_configure(struct stmmac_priv *pr=
iv,
>  {
>  	u32 size, wid =3D priv->dma_cap.estwid, dep =3D priv->dma_cap.estdep;
>  	struct netlink_ext_ack *extack =3D qopt->mqprio.extack;
> -	struct timespec64 time, current_time, qopt_time;
> -	ktime_t current_time_ns;
> +	struct timespec64 time;
>  	int i, ret =3D 0;
>  	u64 ctr;
> =20
> @@ -1069,34 +1069,23 @@ static int tc_taprio_configure(struct stmmac_priv=
 *priv,
>  	}
> =20
>  	mutex_lock(&priv->est_lock);
> -	/* Adjust for real system time */
> -	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> -	current_time_ns =3D timespec64_to_ktime(current_time);
> -	time =3D stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
> -					qopt->cycle_time);
> -
> -	priv->est->btr[0] =3D (u32)time.tv_nsec;
> -	priv->est->btr[1] =3D (u32)time.tv_sec;
> =20
> -	qopt_time =3D ktime_to_timespec64(qopt->base_time);
> -	priv->est->btr_reserve[0] =3D (u32)qopt_time.tv_nsec;
> -	priv->est->btr_reserve[1] =3D (u32)qopt_time.tv_sec;
> +	time =3D ktime_to_timespec64(qopt->base_time);
> +	priv->est->btr_reserve[0] =3D (u32)time.tv_nsec;
> +	priv->est->btr_reserve[1] =3D (u32)time.tv_sec;
> =20
>  	ctr =3D qopt->cycle_time;
>  	priv->est->ctr[0] =3D do_div(ctr, NSEC_PER_SEC);
>  	priv->est->ctr[1] =3D (u32)ctr;
> =20
>  	priv->est->ter =3D qopt->cycle_time_extension;
> -
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
> =20
> -	ret =3D stmmac_est_configure(priv, priv, priv->est,
> -				   priv->plat->clk_ptp_rate);
>  	mutex_unlock(&priv->est_lock);
> -	if (ret) {
> -		netdev_err(priv->dev, "failed to configure EST\n");
> +
> +	ret =3D stmmac_setup_est(priv);
> +	if (ret)
>  		goto disable;
> -	}
> =20
>  	ret =3D stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
>  					      qopt->mqprio.preemptible_tcs);
>=20
> ---
> base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
> change-id: 20260824-stmmac-est-reapply-after-open-181d70a15eb6
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--Uy84GhePRTg6nSKL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapWVXgAKCRA6cBh0uS2t
rGF0AQCSnwsBWdnSzufaq5R1abu0d2fGGSiKKrl9kADSv+NHNgEA0wYvVZyHdWvj
MTdgO1rqKsSBHvbiUAeHVXpdJxuDGQA=
=u2qb
-----END PGP SIGNATURE-----

--Uy84GhePRTg6nSKL--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619167;
	b=29wW+rnS2eY1gjg2fShCInj1xB39Dkg9c2b4x756HrS0be2wecAVjBsNP/ajt5iXTC+v
	 HpNCo0P+g0N5ctqljbnyU3ZKuO6ElVsU/28qEY/1ZsxASsMdOl9uDDEsD9e/W3pWztz6b
	 KnTq+lPK379KhHOURBkvwbJm4bCwYWhlr3N0SVkVk7YOgZEl0LHL6q1uVS8f8Ea/jPbjr
	 XZi3JzoQA3lO6ZgE5x6/FdkLPFHAbxzOJ6xG35qpWKgMvwYQi/FmKK+tlRTyCL/kgB6wx
	 6218qOu0ehIGMvB/sTzXTUzG/JvRLhpbNPDnzvsBc/mLCBVv/PnkHnRAJ+t8oc8kj2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619167;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hNMApI64BDzXWX7uofxqBhSLNs4PiRuIdYa6n5sxpzM=;
	b=d5/uF0UMCOhGAw6qegyuf5NAutpji4Qre/3HacXMyOGBiw+ENIXL/gmEnInF6lf1XrPd
	 OYLG0A05Sdnl5JCyyZyya6f/PEoU9lP9zELYisuSiAf5lT5XCEsAmb53I2HmYhy2GcBiU
	 uYNz+WzhL6vn0E8e5c9ifItxsPtE8rt0e37m3V5gVCtfMDGc849GnedJn8usovKFoq/9y
	 eIcfkbkgLmuWzcg2Dzjgt96jYuIoZ2K1hq8BgbjGIezXds3JYeNS7xo8WD3PCZ7MGNWsb
	 x89FvkrKh5Ja5f57cD8dXFBX5cP7RF04ybIpDHLxg/u0QSbIYdhGcNXt+BazgKV43Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aAGUXCZE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HA3J1D+z;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39002606A333
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39002606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aAGUXCZE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HA3J1D+z
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2B2sOe076868
	for <netdev@vger.kernel.org>; Mon, 2 Nov 2026 11:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hNMApI64BDzXWX7uofxqBhSL
	Ns4PiRuIdYa6n5sxpzM=; b=aAGUXCZE3le2vWGnM+L29f/ZXzXbQauQp0i1gvCm
	H9qb3wDccj3V6/+VCrRel3HdkoMUZX1tH8jgKqJ5CJEl7tJbW+ghWtNJnsgYitqe
	1qn/s6eTbKEpiMtH+2DUVggvJ78gxHklLvF4yUJKoJZzM4yyjxCC/pLYC6zhgQIF
	3QtTSr8avpqbOzl1S89PvFpPanIppGi1+rL1JSssULCShdwTV+aEXPJzgLuKacXA
	VeXZYPl/M+yduWcuP2gIQ5N6mjleRL3iqE5UEzCwnOTA041kyX20ghjeJlgWiDm8
	twbpdeOczyG1Dpq43wqdKXeKGquyIjb8iD4oU6XkZ3qnmw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6r3d3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:32:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-944101e6367so532708085a.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793619165; x=1794223965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNMApI64BDzXWX7uofxqBhSLNs4PiRuIdYa6n5sxpzM=;
        b=HA3J1D+z14QkO5MvmrQLhdyTRW/zyMYRUmnP+RvbFh5R/UxWUIgubfcvW+2H2QKFiK
         PKbfHVU/eXRwKY3VN6tHUjshprZ0ZbBq87PwdidsplTHxJDA0XJYhWtd6ti9KpPDiuwH
         fPcNNkrYdLUTU4TrcdQCCXkYZmBaq7vYqFt4LraB9mcrIAn1c7tGweiTSbQTvNWJZjjb
         n8omUM5Ary+G2bZNcDlJDpskMKX+IqvQwLLS8gg9xCz7cSWFzXtUH1nbM21DhlfL7O5K
         Y/WLiXW9z6qYOmz451Qtre0BLVXbzGHZuJuMDvjnXv2J95WXvV25akuInpkcCbZu90wF
         Zjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619165; x=1794223965;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNMApI64BDzXWX7uofxqBhSLNs4PiRuIdYa6n5sxpzM=;
        b=zDf57hX/UFv5niBD9lnZTACS4I1M/1AcVv5bQnd1DVOZgcMQZutExj/WU7F28fU/X8
         o0We3izLCyKfA7Q/lnlYEZiwnn86KVxITI5v+qw60XSxUuZhQMx0I18LMGzJpY2PzlZI
         CVD7WWPD30F0CCS0baslfMEiBcS2CeKVL+SuJJ5W+dDugNzBJH5KP8BncfLam1JKnm7A
         nXEPFbT2hm2KibNcduJ+d09Wd2oNqjfSg6gADnxA2ESVN1cWKirsEsDWhw0oBcO9PXJO
         rZmmXuiUEx2FpEwUkUdtR9HjfucJTE732IZRUnahs4kCdbkMX4KFtQE5E5b+vcAOjmDi
         c2fw==
X-Forwarded-Encrypted: i=1; AKwUvBwSLFb5oXvjEN7Is8ny5mOB2HsBG7+jN9OTlSAxXmiLtLaqBc5/6tagQRUW0qAHtI+Q7w4xedI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYYgfNZYZqJ0IZjVtw1fNTbxnmR/CI4K3rWA+0Ob7oHdiI9ab7
	iXX0kbO5/Jyc9NfgFz5Ai+UYtLhqb1OAKY5YVkHBNzAkl1KWihl/vfq3Mg6nn7XLDoT19Q0bqDB
	HNsMu+dPHWrBBg12ZuvPjD9xKwDAofuLL69zG90GeyAJ/z2glXRuuhp5Tmh4=
X-Gm-Gg: AYBFou0K+YsKQvfA6qnJKU9X51ZaxhUddFrgasipMWqKuQiCm3xxYmXy6BsO/kBRivN
	LsR50dAbBTWvyWlWkLqOoWMgagu1ghCakDYxjGwWJBBd4j1LDpt0p85rVDLh8k6epBrbNyWxx8j
	VmVihxO6dnkF5H2xL1TaIQBBL5gLNObaMlj8f07uBOwnGKRMY46qDBOv0MQZXV6ciN5pK3rlNmy
	EwMHCXYlNvRJj0zi5MItx8VUIm2n9WXLier0ujoCrdoqwZu88zHHIDOsYhrF4BohtRekET+nIPx
	PyHjNDacTtGDrRnni1WuD7f1sK9tQuLi7Zoq2aWBsq99ZHRlf5UIRRrR3OTTeYG/ra/X/poOmLU
	5BCROX0dq2BXFwSz8Po6q9GRk+LCyUqNv6hrg6y1de30/rHGIqrsAEm2FTPdlcQ==
X-Received: by 2002:a05:620a:7111:b0:945:af5d:287b with SMTP id af79cd13be357-945af5d28eamr575850385a.30.1793619164827;
        Mon, 02 Nov 2026 03:32:44 -0800 (PST)
X-Received: by 2002:a05:620a:7111:b0:945:af5d:287b with SMTP id af79cd13be357-945af5d28eamr575847385a.30.1793619164145;
        Mon, 02 Nov 2026 03:32:44 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf723b5dcsm269045785e9.14.2026.11.02.03.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:32:42 -0800 (PST)
Date: Mon, 2 Nov 2026 12:32:42 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        richardcochran@gmail.com, linux@armlinux.org.uk,
        Jose.Abreu@synopsys.com, james.hilliard1@gmail.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rayagond@vayavyalabs.com
Subject: Re: [PATCH net v5 3/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Message-ID: <auh02q2HFi2OJjI0@lore-desk>
References: <20261029-stmmac-est-fixes-v5-3-85b830a795a9@oss.qualcomm.com>
 <179361656787.3131.5817596791384004529@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KGy68gsddh448JTx"
Content-Disposition: inline
In-Reply-To: <179361656787.3131.5817596791384004529@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NSBTYWx0ZWRfX3SzT2tV9BIjh
 FsYEU8DWpgbnEHd+Jw6Hpe/r1VN0Fd0R/K5G8lApkKRXthFzNiEEdKe9HdXLO33ZVMbR3TVPJ+n
 OZHP7mx7jGTqPgFvmxy8qhxLYx41bf52DbcA1pcSeoQ2pDkIiPPqxazDdP8mnzhEn8saqIDuvty
 JOX+WCgPb1RdWIb1YhznOZar18vNWUs+6nCJTCIN4xSAhLLvD+D6tFz+krlFSfeuqEHh52mpZnR
 QJZ6/NB2gmoNOXlZTmBWlXiLv1/ZtUgH15IBABnfCO4db2XzCDmzg8b+s+/jO+3wwDS7m1QODNA
 E4rUw7BaZakboamQQ7wWsaj1ZGtbIf9zS0auzw5TLjddhCkQO6AM1Va7LMvhe0JttkoiBOaIRJ1
 HdjXWixRJ81N6LotfpWNy3Xldnh+nUEUNxVSYILpFMT9ih9RCx7Up9AMm0MNtyOQv7Icsy36zbr
 IapqED9KOh3Tb5b2L5w==
X-Proofpoint-GUID: 2GzRKUk-6nr_tFV73JSuwIYt7k5HI96y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NSBTYWx0ZWRfX2SmlUfP4gqbU
 34I8pOgonwbwciLtMvOOFFOiOYsV7WGc8ze3YmeK2QRNy+FEqoYcqpfbry+SZPMMokBXpBnNXzJ
 mFtpFoYtJcaIqBOFxYuH0vR3X6jWdDc=
X-Proofpoint-ORIG-GUID: 2GzRKUk-6nr_tFV73JSuwIYt7k5HI96y
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae874dd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=vwSTzRkvEfDpTB41HsoA:9 a=QEXdDO2ut3YA:10
 a=RYqGYfE62diCt-6m_3gA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020045

--KGy68gsddh448JTx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 1 =C2=B7 Low: 1 (1)
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] A taprio REPLACE that fails the FPE callback's software
>   validation destroys the installed hardware schedule, even though the=E2=
=80=A6
> - [Low] stmmac_adjust_time() still uses two separate est_lock critical
>   sections: it disables EST, runs adjust_systime under ptp_lock only,=E2=
=80=A6
>=20
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch adds
>   a new way to reach it.
> - [Low] The TX/XDP hot paths (stmmac_main.c:2753, 4861, 5286) read
>   priv->est, priv->est->enable and priv->est->max_sdu[] with no lock and=
=E2=80=A6
>=20
> --
>=20
> net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume=
()
>=20
> This commit re-applies the taprio EST offload and the FPE preemption
> mapping after the core soft reset, in __stmmac_open() and stmmac_resume().
> The base time recompute moves into __stmmac_setup_est() and
> stmmac_setup_est().
>=20
> tc_taprio_configure() now holds est_lock across validation and
> programming, builds the gate list in a temporary buffer, and sets
> priv->est->enable only after success.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 2163e79fea9a4..d1e3d2cc77670 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -4201,6 +4202,10 @@ static int __stmmac_open(struct net_device *dev,
> >  	if (ret)
> >  		goto ptp_error;
> > =20
> > +	ret =3D stmmac_setup_est(priv);
> > +	if (ret)
> > +		goto est_error;
> > +
> >  	stmmac_init_coalesce(priv);
>=20
> [Severity: High]
> This issue predates the patch, but the new est_error exit gives it one
> more trigger. If stmmac_setup_est() fails during an MTU change, is the
> running netdev left with freed rings and TX hrtimers that were never
> initialised?

This issue has not been introduced by this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> stmmac_change_mtu() calls __stmmac_release() and then
> __stmmac_open(dev, dma_conf), which memcpy()s the kzalloc'd dma_conf into
> priv->dma_conf. The est_error exit returns before stmmac_init_coalesce(),
> so hrtimer_setup() never runs on the txtimers.
>=20
> stmmac_change_mtu() then does:
>=20
> 	ret =3D __stmmac_open(dev, dma_conf);
> 	if (ret) {
> 		free_dma_desc_resources(priv, dma_conf);
> 		kfree(dma_conf);
> 		...
> 		return ret;
> 	}
>=20
> and the interface stays up. On the next ifdown, __stmmac_release() calls
> hrtimer_cancel() on priv->dma_conf.tx_queue[chan].txtimer, and
> hrtimer_active() dereferences a NULL timer->base. After that,
> free_dma_desc_resources(priv, &priv->dma_conf) frees the same rings a
> second time.
>=20
> Failures in stmmac_hw_setup() and stmmac_setup_ptp() already reach this
> path. A failed EST/FPE replay is a new way in.
>=20
> > =20
> >  	phylink_start(priv->phylink);
> > @@ -4224,7 +4229,7 @@ static int __stmmac_open(struct net_device *dev,
> > =20
> >  	for (chan =3D 0; chan < priv->plat->tx_queues_to_use; chan++)
> >  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> > -
> > +est_error:
> >  	stmmac_release_ptp(priv);
> >  ptp_error:
> >  	stmmac_stop_all_dma(priv);
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > index 9a32af00d7d2d..a37405534bebf 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>=20
> [ ... ]
>=20
> > @@ -69,47 +69,21 @@ static int stmmac_adjust_time(struct ptp_clock_info=
 *ptp, s64 delta)
> >  	nsec =3D reminder;
> > =20
> >  	/* If EST is enabled, disabled it before adjust ptp time. */
> > -	if (priv->est && priv->est->enable) {
> > -		est_rst =3D true;
> > -		mutex_lock(&priv->est_lock);
> > -		priv->est->enable =3D false;
> > +	mutex_lock(&priv->est_lock);
> > +	if (priv->est && priv->est->enable)
> >  		stmmac_est_configure(priv, priv, priv->est,
> >  				     priv->plat->clk_ptp_rate, false);
> > -		mutex_unlock(&priv->est_lock);
> > -	}
> > +	mutex_unlock(&priv->est_lock);
> > =20
> >  	write_lock_irqsave(&priv->ptp_lock, flags);
> >  	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
> >  	write_unlock_irqrestore(&priv->ptp_lock, flags);
> > =20
> >  	/* Calculate new basetime and re-configured EST after PTP time adjust=
=2E */
>=20
> [ ... ]
>=20
> > +	mutex_lock(&priv->est_lock);
> > +	if (priv->est && priv->est->enable)
> > +		__stmmac_setup_est(priv);
> > +	mutex_unlock(&priv->est_lock);
>=20
> [Severity: Low]
> Can stmmac_setup_est() turn EST back on between these two est_lock
> sections?
>=20
> The first section no longer clears priv->est->enable, so any est_lock
> user that runs while the time is being stepped still sees
> enable =3D=3D true.
>=20
> In __stmmac_open(), stmmac_setup_est() runs right after
> stmmac_setup_ptp() has registered the PHC. clock_adjtime() is not
> serialised by rtnl:
>=20
> CPU0 (stmmac_adjust_time)          CPU1 (__stmmac_open)
>   disable EST, drop est_lock
>                                      stmmac_setup_est()
>                                        sees enable =3D=3D true
>                                        __stmmac_setup_est() enables EST
>                                        with a pre-step base time
>   stmmac_adjust_systime()
>     (EST running across the step)
>   __stmmac_setup_est()
>=20
> A taprio REPLACE can race with adjust_time in the same way.
>=20
> Before this patch, clearing enable during the window kept other paths
> from re-arming EST. Would holding est_lock across the disable, the
> adjust and the re-enable close this window?

This is the same issue reported in patch 2/3. As pointed out before this is=
sue
has not been introduced by this patch and it needs to be fixed with a dedic=
ated
patch.

>=20
> >=20
> >  	return 0;
> >  }
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_tc.c
> > index ac926c60f9f9a..10b61fa2c27c5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>=20
> [ ... ]
>=20
> > @@ -1060,13 +1065,26 @@ static int tc_taprio_configure(struct stmmac_pr=
iv *priv,
>=20
> [ ... ]
>=20
> > -		priv->est->gcl[i] =3D delta_ns | (gates << wid);
> > +		gcl[i] =3D delta_ns | (gates << wid);
> >  	}
> > =20
> > -	mutex_lock(&priv->est_lock);
> > +	if (!priv->est) {
> > +		priv->est =3D devm_kzalloc(priv->device, sizeof(*priv->est),
> > +					 GFP_KERNEL);
> > +		if (!priv->est) {
> > +			ret =3D -ENOMEM;
> > +			goto error_unlock;
> > +		}
> > +	} else {
> > +		memset(priv->est, 0, sizeof(*priv->est));
> > +	}
>=20
> [Severity: Low]
> This is a pre-existing issue that the patch did not introduce.
> stmmac_xmit(), stmmac_xdp_xmit_xdpf() and the other TX paths read
> priv->est, priv->est->enable and priv->est->max_sdu[] without est_lock
> and without READ_ONCE():

This issue has not been introduced by this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> 	if (priv->est && priv->est->enable &&
> 	    priv->est->max_sdu[queue]) {
>=20
> If a REPLACE runs while traffic is being sent, can this memset() and the
> plain stores after it race with those readers? That could drop a frame
> by mistake, or let one through past max_sdu, while the schedule is being
> reconfigured.
>=20
> Setting enable last in this patch does make the window smaller.
>=20
> > +	memcpy(priv->est->gcl, gcl, sizeof(*gcl) * qopt->num_entries);
> > +	priv->est->gcl_size =3D qopt->num_entries;
> > +
>=20
> [ ... ]
>=20
> > @@ -1091,7 +1109,6 @@ static int tc_taprio_configure(struct stmmac_priv=
 *priv,
> > =20
> >  	ret =3D stmmac_est_configure(priv, priv, priv->est,
> >  				   priv->plat->clk_ptp_rate, true);
> > -	mutex_unlock(&priv->est_lock);
> >  	if (ret) {
> >  		netdev_err(priv->dev, "failed to configure EST\n");
> >  		goto disable;
> > @@ -1102,11 +1119,16 @@ static int tc_taprio_configure(struct stmmac_pr=
iv *priv,
> >  	if (ret)
> >  		goto disable;
> > =20
>=20
> [Severity: Medium]
> If a REPLACE fails FPE validation, is the installed schedule still torn
> down?
>=20
> The commit message says:
>=20
>   A REPLACE rejected during validation then leaves the currently
>   installed schedule intact in both software and hardware
>=20
> However, by the time stmmac_fpe_map_preemption_class() runs, priv->est
> has already been memset and overwritten, and
> stmmac_est_configure(..., true) has programmed the new schedule.
>=20
> dwmac5_fpe_map_preemption_class() only does software validation, and it
> can return -EINVAL. One example:
>=20
> 	if (priv->xmit_qdisc.algo =3D=3D MTL_TX_ALGORITHM_SP) {
> 		NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
> 		return -EINVAL;
> 	}
>=20
> It can also fail on a TXQ weight mismatch. Either error takes the
> disable path, which clears priv->est->enable and turns off EST in
> hardware.
>=20
> Meanwhile taprio_change() sees the error, jumps to free_sched, and keeps
> the old schedule along with its full-offload state.
>=20
> For example, on DWMAC5 with FPE: install an all-express schedule that
> has a multi-queue TC, then REPLACE it with that TC marked preemptible.
> The user gets -EINVAL and the qdisc still reports the old schedule as
> offloaded. But hardware gating and max_sdu enforcement are gone, and a
> later reopen or resume will not bring them back because enable is now
> false.
>=20
> Could the FPE validation run before priv->est is changed and EST is
> programmed?

This issue has not been introduced by this patch and it needs to be fixed w=
ith
a dedicated patch.

Regards,
Lorenzo

>=20
> > +	priv->est->pclass =3D qopt->mqprio.preemptible_tcs;
> > +	priv->est->enable =3D true;
> > +
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029-stmmac-est-fixes-v5-0-85b830a795a9%40oss.qualcomm.com

--KGy68gsddh448JTx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauh02gAKCRA6cBh0uS2t
rJLzAP0eEh5JhobVfUU2pRcoC6A2k2LeDfoAm4CDQO0r47r1fwD/YmaNLRHdQvDc
p1aeZw1CGQpbDVDs1PAkqrgm7fOw2A8=
=YukB
-----END PGP SIGNATURE-----

--KGy68gsddh448JTx--

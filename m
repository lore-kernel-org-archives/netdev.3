Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A43DB322
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671678; cv=none; b=IU3sR04cUP57dz1mY9nTniYB+uhYPtBA6jRaTNun4/3TL46AIDjC+yte6frB5GUU92mhYzMJ5aSvZkb3EyLAWQZmcgS7mF2sCpSwiT7Fs7RTu3jTP4Sju8vAvo2SWcU6ui0K1FzqVl/Q74E/BORBiDoqd1bNFeud6yvCyADLmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671678; c=relaxed/simple;
	bh=Vyh4BxL8Wo/0cwGe+rx+agf2/S9/HA+rhYqAN0h2Jlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+MRvSxLlearrNsSfU11lqnnfR4Op/GO7qbg9ZRdx9ggVrSLBr08PFCTZAQ4fUsuZyNVTdk0QpJ2kGYRwq5GrtdMlu1xF7XCPtsyfCISy8U3kk6p7maKcnB+6fUR7/jO1HXGP4pYf9772LFQF9k2a6qcrLFczCFUjuk9S1gaIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H0nyUJKQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MYMjFNj5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0nyUJKQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MYMjFNj5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEUqdT2243783
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=frtGNcVn5NDL/agSpjrx2zVo
	bwDTBHuob92CW6m54o4=; b=H0nyUJKQMFJv6vMfFknL098fHZm3O+cOn8HaEN1a
	+ul83dAc3KQbPvOcIpJrVe1h3YZbhLa1W4KU5YpUtU6PV5jHyAtbDfuSkU7U2BCF
	+s6qHQ2iv0HOaaK6dH73j5P8kEAIS3fi+UJGtdBY3yCqIJuf5B+Bd2K0262ks771
	Mi91JKudN1zOi/+JpYzl1NiUgulk4zyw+C8Nymuipdrlc8X62Yavya9tg3F/8W3y
	Mpqb6N81gazhvU9dVD6JDMY7JHrK9zmmbEz51BlaRg9wV9CXHnitSNOee3UZst4G
	0oER6y8WXdmEJsU4nNmk2VRH+RzS7qj32ciBtuRMtGNEdQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g96abt6ct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:27:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52e2d1bdce2so20603501cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787671675; x=1788276475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=frtGNcVn5NDL/agSpjrx2zVobwDTBHuob92CW6m54o4=;
        b=MYMjFNj5UpGfwY6pKAvKEHOhtHJ6UowYrPSTgyUzs+C0vJcrVFeC1dY2zIuPxCsm4R
         2FnClPRvDJTPq5fQq6a0P+s029pxzshB7uOoERmPxWoSdeGxUII0pDC55HKGRxcqe3ul
         qeZNfr6t0nbpE/3IdC/tV1REzfYWFByHSokCmOEpHRkpJgZVphklYDVaPXm1Zryko1dC
         GIUWHO/VOrLSoA7qIMEzeI8rpq3uyxjZ33KLW9rJ2PWBfvZZmfNPDo8Z0OqVo/XWyO/c
         27hsbK0x32WkgkGqGv52sgcb6wXQFLhdTxs4wBjLa8Xvi3iQR/7bGMVQIfRcPrcG1kva
         38zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787671675; x=1788276475;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=frtGNcVn5NDL/agSpjrx2zVobwDTBHuob92CW6m54o4=;
        b=lwNfHzmWlzoMe9Xw79tT3XOUZd9ekJIj9JbSmb9M/61YtUEBHd2BzPlBk2nRDGcruB
         UP1rhq3mmq427ZPJCI5535V5V/dB5uSavsOvYZ1GmvO/bD3sHTbibpwRJAzUTuv6X6A/
         q1VGbW7TvuIrVF9+j6VSlSkO3shE1pjZVyKAy5yDMcu2YnbPnEeB71Gg/yLNPAQbJiUU
         f4iNkCcy6DQ03bPw4OgxmilpmY1yHtInKUMtLSqVL+ZQDvhkR6hIRLdjQoBx3MJPW7ea
         q5OdVZg1YqfT5dOAT5alzl9vdHAGuYQKtgiNvNr6uLToPMMJt2YJBnY5N17pJzvRisWe
         v4pw==
X-Forwarded-Encrypted: i=1; AHgh+RpoGt2j9Dy/c18a4765irGPRKRvZvKKT5TsUPp4UAYEOyeoKlu0GXhwyvj/SHsCko43ajO6cDQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nfijQDSxabAiTAODURYYOwpQ3z7qbjjt6SOF11UAcOlWRerzZ1
	goqWJlGWpXVNde51W8AoXZpStpV1NZK9s7HLqFk72vl7a5D+c+zqTnx1K80uY2t6sKG/gc9u9S3
	OPybkJxXA4yfsOQMWqKjhLG0sWCFsebFUxi2+agMowsIqd5s5p4fDsw93iBE=
X-Gm-Gg: AR+sD13ZVVFqFCJjcwRSIDlcwMlpdNkwuLuSGDzUtFCUuRIIl/e9ncC2kbVlP11JJwb
	HY2G7nm4Wio8iNXwDv4xTQYiT79E0GssWy2tASXqlNfqaXFBEqdvXIboa0+Xzo/gx0hGWoQH/hJ
	GOMFf37o6oSl7sAkoOG2DWNiP/kcPD5UpMHB/nOdFG+KDYciSw+2lLsaXKAWmbtChlze7/siTz1
	eQMrpADKl/1DZda+TpmuwoG6TBShO5r7no44fQiw6fTEIdV+bqmLWcQWMK7p0ENzgOkWeULt5ik
	hSl8c9N6269udoi8PT/1YpLaQMKtUJt1LpQEK22Js/CAFVrgR3mAgQ73mS2qOMvsDhKFO0BPASN
	i+mAqQfbqkeV0YQ==
X-Received: by 2002:a05:622a:4c0a:b0:52d:78c9:9379 with SMTP id d75a77b69052e-52e2f144748mr79689101cf.30.1787671674945;
        Tue, 25 Aug 2026 08:27:54 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:52d:78c9:9379 with SMTP id d75a77b69052e-52e2f144748mr79688061cf.30.1787671674206;
        Tue, 25 Aug 2026 08:27:54 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d6acasm9422066b.9.2026.08.25.08.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:27:52 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:27:52 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>
Subject: Re: [PATCH net] net: stmmac: re-apply taprio offload in
 __stmmac_open()
Message-ID: <ao20eOjQLwyLfq0e@lore-desk>
References: <20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com>
 <324e6485-633c-4a2a-ba62-661f75dd6c31@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RjxRD0fGgCNWreNJ"
Content-Disposition: inline
In-Reply-To: <324e6485-633c-4a2a-ba62-661f75dd6c31@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzMSBTYWx0ZWRfXxc6IYpKDSWyn
 Eu/wGp3pj+wfL3ontW49CcyhEF3kDu19CyXDnC97PPaE40+56Q79GTfFRAsJ11PRVr7yC0TLVjE
 VGbToWyAh0aAqpmguF+LyM/6mlBZeojidiXIa0jZT/DuyGvg4LiQ192u6Bi9YPcVf+VIvwr/O+c
 oUbAgeZ0qKQWZptvkRWsTiNSTPQp4aP6SKjTCkUaPpphwgzGytTW+GwVfJSIFpuUz/1KDxpvftP
 NAE/TFO8E0MjdJI9uD7TPenLncQFvD0CTU4PbJyr67HoEQsQOti1h6J5OMwy48utYUWfC0BO+4+
 h23BadEYjhaF9xWR1RM/UYyKqRX3OvXuyuvpbrpnUG/pMQVNebb2YbuZCGaxHSvoMG6/uJplKBr
 ka9DCpnpb2cW7DSRVkaK1JgqJjWw+cYoVyGG9Uc852n6gUtyEmkyIy/MNHyo8NCxU7ZZLuuPDOp
 iI6pfTDh1tilU0r4Z8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzMSBTYWx0ZWRfX5gYO01VxgsUg
 y1aQDpjF7jBjyupDXkhLrRFS5zzl/VftuS0Elbl1sQ3T/p+NPWoGVpSG9u/68GCFCi75NI4lVrn
 62AxNDfu1cDH9fkiU8Apb/7Wwx0N1Cs=
X-Proofpoint-GUID: dIqSjgPnH3UshLPXkX9uals6QJDYVW_d
X-Proofpoint-ORIG-GUID: dIqSjgPnH3UshLPXkX9uals6QJDYVW_d
X-Authority-Analysis: v=2.4 cv=SaHHsPRu c=1 sm=1 tr=0 ts=6a8db47b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=nIpPZXGhJxVyofb8EZsA:9
 a=CjuIK1q_8ugA:10 a=3ofb-eRetcnstJVkoFkA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250131

--RjxRD0fGgCNWreNJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo,

Hi Maxime,

>=20
> On 8/25/26 11:24, Lorenzo Bianconi wrote:
> > The core soft reset issued in stmmac_init_dma_engine() clears the
> > MTL_EST registers, but nothing re-applies the taprio offload after it:
> > priv->est->enable stays true while the hardware EST block is left
> > disabled. The TX/XDP paths then keep dropping frames larger than
> > priv->est->max_sdu[] and taprio is reported as offloaded, although the
> > EST block is not programmed.
> >=20
> > Re-apply the taprio offload in __stmmac_open() after PTP is up. The
> > base time is recomputed from the reserved base time and the current PTP
> > time, since the timestamp counter has been re-initialized and the
> > previously programmed base time is stale.
>=20
> I agree with idea, but the way I see that, this new reconfigure method sh=
ares
> some code with stmmac_tc.c's tc_taprio_configure() step (the base time co=
mputation).
>=20
> Can you also take a pass on that, so that we have a single helper (your n=
ew
> stmmac_est_reconfigure) that does the base time computation and the EST s=
etup, that
> would be used in the .ndo_open, clock adjust and tc_taprio configuration ?

Do you mean introducing a single helper (e.g stmmac_setup_est()) where we h=
ave a
tc_taprio_qopt_offload pointer in the routine signature to distinguish betw=
een
the 'configure' and 'reconfigure' cases? E.g:

void stmmac_setup_est(struct stmmac_priv *priv,
		      struct tc_taprio_qopt_offload *qopt)
{
	...
	if (qopt) {
		/* configure from tc path */
	} else {
		/* reconfigure from __stmmac_open() path */
	}
	...
}

Regards,
Lorenzo

>=20
> Maybe rename it stmmac_setup_est() to keep consistency with the stmmac_se=
tup_ptp()
> that comes before, this would also open the door for an equivalent
> stmmac_cleanup_est() if we ever need it.
>=20
> Maxime
>=20

--RjxRD0fGgCNWreNJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCao20eAAKCRA6cBh0uS2t
rCWPAP0dtF22l4GthdsLp5ww51FQYvuX/6UpG3VXmDHxHcb8TAD9HGCQ7Xzmu1US
s/5xpqTPZFpaX+MJoDQrocRQD0SD4AU=
=wQy/
-----END PGP SIGNATURE-----

--RjxRD0fGgCNWreNJ--

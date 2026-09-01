Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08841459AE1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253634; cv=none; b=bWSmHZDNhy2QerDbbP9mqv1Xqk5wCtM3aRu9cwhklUFnRx83ICvHmTnE/e4PHP3u3io6UdIsjcJ9RAUuyLZIcK4xkYdKpeGjgYQRfd/Ap7SStdsoS+d2bA60AmuF8SKx7+2kspSaalcAMRA1mooDYAI7mO6fPSdlPtV7Uu7kU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253634; c=relaxed/simple;
	bh=iks5nTzbu+Vx9ifKf/aNkUVxblbtkM4p8FQj/wsHie4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fwc4jSy31JtGzma3zFBmUqdyLKnEFoJ7Y600FP3YYNClDxeD+vf4UXz23t1zJ90b6sRMsuxwtyxgy6Cj+eNZdRIiGrb+fe6ynyr5r8zsjWpIa6WBUlacSdlwIAeaa7Jw0flkejDM/02lBTcnFkW7WK+mDQWArfHJD+u7Iq9cqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jKW8ZG75; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XmjtzvdA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jKW8ZG75";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XmjtzvdA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68179Ras2322014
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 09:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4tTkCcMq6zotwRicGA7neKe2
	8S4A5lFqmzjTU8MYQPE=; b=jKW8ZG75NTlQIR4jrv4KkMX72pX2UEteYN2bAmsO
	TnlxoaPY0S2DF/s+10YQA+xdqpd18Tr9wSiUdhAiEVA71d72RSVlm4BbhFgwSpFw
	/oi6x0BcXQhDsWz2d2lE4fFfkmUsIt9B+k8AHS7RlYY+OPx06D8vdGK1U8pMA8O/
	YF+NbdUVd7kCyYkS7QBAg1IrB6DNHDHI01f3YVVDY8cC/D9RNdut88RTR722EK2D
	YkAgLxJp5CwCmQtNwX2f74ds3hHZjdn746qnUOjdvlIRoFLvxyFCBCJXoKqShRNd
	Qb6gFWovopyyidhDmH+EfxGpT/rPDG3kXF4szs493FxrGQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdfchb4hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:07:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e820609d9so894617885a.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788253626; x=1788858426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4tTkCcMq6zotwRicGA7neKe28S4A5lFqmzjTU8MYQPE=;
        b=XmjtzvdAIDe3hErxwQ8weVk/J+lOZvVlADwtbdijyRaokKVahqZNMIABm/JXIz2/7r
         hPTHaSv0FguVemp4RMXUTf6AlF0uDB0G7bHFpmQOArr+1ZjhGB/wltc0VI0wgVDmw8tH
         EDjv6B12g5uN9DX4RLl2GcgJBNuSKXMzvUM3mxR4+HaauUGhiJL5jImf53k9mD0DByXz
         baAyTovyyzEE+MEj0dHb+eF8S33VjztlSkwqOyYC4vCJ42vIGyL8jnSJjuYjufjzOoSU
         w4cxiqbXJCPcmYWxhuJMhnkzdh74y/6SBGsk0aX6c8F+OOEnbgN2xxAcQJwpxsCK4mGI
         0QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253626; x=1788858426;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tTkCcMq6zotwRicGA7neKe28S4A5lFqmzjTU8MYQPE=;
        b=SbJUcz3M7l68lHtcz8ObAVFwBQrS/EwdoO1jfrMj3PQyRbra78X8YfkXc7yPl+xsqj
         rUlDLn73VCkBg1PhR37EjBy/Tq1c+P+0rRizF0vux5c/up2RrD3z7BnUI9avOkStUoxV
         rZ1eqQJLdgIFA+1qJF9Td+UnPEI83IuXjD/0U2U/PCpJZTb26w45g81VCzexuXmnYZhf
         sa+olJVrr0HPrl2mFiCzMZf4q4tY3vFzagWUFF6U5DN5wcmdDBxlRbZyj8G6UmiTkWbT
         GGx2l3YTQl0ksRWAmZBKa31ohis1LrxuKAOHQZSyUZgBKi6q1+VMUXK5FSbwYxZszlST
         T1RQ==
X-Gm-Message-State: AFuF++lqXit76x3Yg3y9PQXWUhWpOUDtWwcsj7oe1Nkdxlq/ygrMyA55
	FyS9FbWh48nay69fvdjdAqdl1f8XG+FLt8qfaQ/bySlCAvWTNdtgOpgJ6Fsxf8pd6XYeSNpEnU9
	mewV3fJ8Zc4+YEZNzuSO9va0Y+hpwPh7+z/CgaKr0WaAE/5ZjTauLeqzIO5Q=
X-Gm-Gg: AR+sD12FzrMS994e9QHjL2WK+ua3HFmptqFuFut0tOEr5g/voll6BkiWNHlc3y4yy7t
	QPH8WfDReC9GHq4UwyUGkRNWPUtAwkvPCL/XILcKJ5JEJcAbthgInzpeMiudXeLfPaof72TKocz
	cKUVfMMf5dNqRsbFdlLY5ii0EK8A449oY5FU7rm9n3dZTI3+FjN/VWZ1kj/9rRPUx6D1RSPENOo
	fTo/Szg17TJE8z0OzGzhabS1f2P4Z42pKb4Lowt1TQpH/zaadETfA7cdwNUo9TUCVmsWhSbeajZ
	wWFVTTE3iIBFLBSgzCB3IJqgJC1CDzQAaJnPFFhCwOgclHmyXpqbiyUvIoSfmz8AxF2VpS+ydep
	cSTtsgwFIGariCQ==
X-Received: by 2002:a05:620a:440e:b0:923:7821:dc0d with SMTP id af79cd13be357-93948132c08mr841860985a.33.1788253625922;
        Tue, 01 Sep 2026 02:07:05 -0700 (PDT)
X-Received: by 2002:a05:620a:440e:b0:923:7821:dc0d with SMTP id af79cd13be357-93948132c08mr841852685a.33.1788253625338;
        Tue, 01 Sep 2026 02:07:05 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d791a7sm3645264f8f.31.2026.09.01.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:07:04 -0700 (PDT)
Date: Tue, 1 Sep 2026 11:07:03 +0200
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
Subject: Re: [PATCH net 0/2] net: stmmac: fix qdisc configuration overwrite
 during qdisc_graft().
Message-ID: <apaVt5NN-FTjtTfJ@lore-desk>
References: <20260829-stmmac-fix-graft-overwrite-v1-0-a4f84c4c264e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+NEuofCU5XXUBBBx"
Content-Disposition: inline
In-Reply-To: <20260829-stmmac-fix-graft-overwrite-v1-0-a4f84c4c264e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 0gvmjbMzL-5yneQbfaxkCAWxcDKyG-4B
X-Authority-Analysis: v=2.4 cv=G9Ms1dk5 c=1 sm=1 tr=0 ts=6a9695ba cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=GaJwwe295ui8M3rlBr0A:9 a=CjuIK1q_8ugA:10 a=5MFtv9REYAT2gr-WTQEA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 0gvmjbMzL-5yneQbfaxkCAWxcDKyG-4B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfX+Usa1IsBK5lS
 2VmJj/AZcLeCdhGgi2ElxrYB4FI89mh/LuqMEH12FQudfiQ4s4AOtpM12WQZrvy1X1tu4DgoItI
 xqndCRbjyr1cEMqOBJ2Fwo+zCWhMJ50=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfXyzMVxScI/Atb
 wdn1slDQT/DKfUuGhZ4TMTfwowO0jaS0WcL4an4WTeEPWIooezzWdo9oEHDZekXJocGLQ0wUoQG
 cduB5PxjWHdlIWezQx1Z2OR50IDyHAKMGeEpCMdw9g0W/gun3RF+t4/tgJKFI1O9aibkDZJWKnZ
 baKY0xo0oPBZ1MntRylZlqy2ND1WoZblIr5juIGRPGhcLdN8in9Pg03M2J1Ive20Upd11UArtZR
 k7a9MW9P56YsWww63WqVECGbV6A2mFFdWvkOTjNVJxDaV1pK9FGa4y1g04gKBkpeRNQV1Og6oDA
 FjgkqUvCDMuRdWtTnah8tYt3QzaKKbhlbQslqwHp2YEyATQ/HV7q5+jqeSnr399uyJRHBHE1IWH
 QMUbc3L6b2Ni89OppGaeRQTmvT+/XoTZv+Ka+qpml8I2VQl0hIsC3Pw8ew2IVU1ZND/Z1z2qSd7
 +//SDQkJ3zTM0IkFtLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010081

--+NEuofCU5XXUBBBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> ---
> Lorenzo Bianconi (2):
>       net: stmmac: preserve real_num_tx_queues on mqprio setup failure
>       net: stmmac: preserve FPE preemption class across qdisc replacement
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h    |  7 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 97 +++++++++++++++++++=
------
>  2 files changed, 80 insertions(+), 24 deletions(-)
> ---
> base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
> change-id: 20260827-stmmac-fix-graft-overwrite-d3ec2e72d901

Please drop this version, I will address some sashiko's comments in v2.

Regards,
Lorenzo

>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--+NEuofCU5XXUBBBx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapaVtwAKCRA6cBh0uS2t
rJT0AQCa9ps03VLvVpsG68lb345JfNeswBHXjWyOPPGvKjsjKAEAkoYEoKyPKGei
DAnKuH9j5nC3/fVKBpAavY/ehooieQk=
=+nd+
-----END PGP SIGNATURE-----

--+NEuofCU5XXUBBBx--

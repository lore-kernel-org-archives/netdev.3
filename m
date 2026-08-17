Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8A2771B
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933364; cv=none; b=W3LxI+BRXONXRLpDtsbCS6cg3kiErP2AWjTlA+Rz0wvpPXF09E3whQtHjpQo39f9kzrDICxpPbfWwzWJmYgS4iqXdtKUERCXhuf9BOhAYm0/RUsxQVDWI3iNrfwFYVmotGWHhMCNO4stmdNb5vxWd50Wxx8WraZgpqHsV5FPz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933364; c=relaxed/simple;
	bh=qYUP7JlwNZH1GLrIZ/psgwyj22tFbCD/BTVKvIKYuKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5whAeCn5YfBU+p/8TQXGN9IMyM21XPaWYB+136LvrtgG3phLv6V0rILMSxW6lwMnN0MyOFb5MTKvN/CwNop7VNzezODz0IyOa+bfjwVw0N0RS+RpUq09Ha2SxmQbz7W2gAhLIY5Rr8IFuQuSpjq7wsm/2bmbZ6zOHSjNsA1R78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h449e2ON; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Scf4k9Gy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h449e2ON";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Scf4k9Gy"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLCmnx343840
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=x9kex6Z3WEWdGPRk9qXlwnM8
	PV8rrpdTWy9hzLWAGRM=; b=h449e2ON73OsHk9px/cswg7IFKCKrsbdpAfXeZfV
	BjS9B0tqF6uMBE5v64QugdxRZzmb2KSSVg3Ly1eqNd6+Q8KySbXaEqfboUNsWrde
	wmGxN85khnVugoeVeqMzUpvBxXmmWzj+KNJhBSmuc9H4ep2mTg589ORv4PDR3OX7
	yt0lzIOnqJ3tsFx8qnct8hzy0ACZaTIIUapLACl7PR/X8DdOtjLGrBgXRCWNS5aM
	Rnpwg7VfJOAYXNudAbr0TwSyuS2WDg5FqSOSK9SZucRSeh1og25JtQgrwrICQV2q
	xihm2ZUGBFle1/hg7JnwgKhOfd9Hy865RgAmWvjmxPeh2A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghemxpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:22:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cacf17c7e0so41775965ad.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 19:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786933361; x=1787538161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x9kex6Z3WEWdGPRk9qXlwnM8PV8rrpdTWy9hzLWAGRM=;
        b=Scf4k9Gy3P0EJg2qeTHm1MIgn85uAFiMKk3xU/L5icEbG0ts1qEdUVocXTbXVsZZPe
         fo1DpDmkFJjraulLtioHdn/sO1pKd5ETGWVVRLa6dSmSzUMnx1Fzp+94RZd2YDDMRZKK
         ct6f4qQXiwmMNJUnnacarYvvGdIKC4JfvV4A4av6zmM9QRbMAi1IFjNPSf8hRt/HH9VG
         I6WdCf0YpTB6XX8POMUjSFzvFkGQIO4SFMNaeBq2zOBxT6uP3fU0UD/OnqK0j0fFrv40
         SMKZukDroA+wap35NO2B7t2rgS6VIZJexprm1LPXirQZjg/Z4wC1bWAOzlc5k105fRhw
         VY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786933361; x=1787538161;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9kex6Z3WEWdGPRk9qXlwnM8PV8rrpdTWy9hzLWAGRM=;
        b=JMvh/4XLJij0TaKcppjwNr+IV+1VWnwZCqjsTHCX/KnMsihjPoBVJlSa7oO1QCSJjb
         Vp7cd2iOpLT/BXjiAO8N3FrUOqDEj3EDJKD3cPu7gJqH8sfkbXoFZnOhbpMJkW71FbNi
         sBDMQmW1K/4C1wl0j8ROH7ScgI+5Np9f0Zy/7iDiHkDssptWHtLE4xJ3UnIOshD4UX2l
         +UwZtiy/TN56tlMkv519oETVrfP8fHpt2GgxnB1diKkGQdY4oF+sO7DoiGXUsJguUuTC
         Lb/LudEBoMeMSG+X0MKgWE40nL11Pu8rr/diUfx5V4qz5XGhyMov7dW6NIVFP9w1NUtj
         uN9g==
X-Forwarded-Encrypted: i=1; AHgh+RpBxbfjGX9/EVAuiKQHNCoJT7Ov/AkplAhAc+1pbbPz2/hBUfIgaL/AtIRiyX1Lah9wTOWHnP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSlrfuezkPObaTq0oXE6cpUZvNiQdbdRLrL8CsMqWjbZOarOX
	mXrHDdZdwXetxINuj8qJgIzSEoTvaT84zGw7dKp8ODzJMIuRsUpVxg6TW83q5uDmzaQ425dfZTU
	t+N9cHcHMF7y3axtx1ywWMbBOThCDrHKPKFljPsnQ8tLWFr6ZEGU2WfEeQwA=
X-Gm-Gg: AR+sD11u7kwk8Bs93FNyT2/h12p4F0XJgOljaKlC4CpwyUmHkOeqiLzXLTCx6FRJEb3
	Akg1nRcX/qBvL/bVwxPLg7R0ASdjvmKHq6WQT4sKU8qpM/Ab5lQOBNyuKWMkTDz0nxX65qYrbxv
	H0C2S16H2R/0g6hrIsOT2MTn54aOq+ZOiV7e7Kzalon1be6x/RSqGLsKy0cg7rSTnZYFlxRYPwQ
	7yulporqkwxnAjqr2aYJK2TEUigbKo63WQEnkYwmI1C8FZPP9fVujBc84Hbw1PpOVLc5kGmGLnJ
	LUbWfnlb6ZFSJkobtXUM1dny53HIh/fS0oA8dJ88azWzNVwKZ+WVvJltokP2x7um1ficwtOmbCe
	iCVKZ6K6/g75FTA==
X-Received: by 2002:a05:6a21:339a:b0:3c3:91f5:82c2 with SMTP id adf61e73a8af0-3cc71b16a94mr23599392637.16.1786933360883;
        Sun, 16 Aug 2026 19:22:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:339a:b0:3c3:91f5:82c2 with SMTP id adf61e73a8af0-3cc71b16a94mr23599319637.16.1786933360209;
        Sun, 16 Aug 2026 19:22:40 -0700 (PDT)
Received: from localhost ([4.43.230.125])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a1faf1sm2645151a12.16.2026.08.16.19.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 19:22:39 -0700 (PDT)
Date: Mon, 17 Aug 2026 04:22:37 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: stmmac: improve TSO/GSO queue selection
Message-ID: <aoJwbQ-v--cTcysz@lore-qca>
References: <20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com>
 <anybM_3Rdg8X8CMs@lore-qca>
 <20260812161038.5602eac9@kernel.org>
 <an4qzUrK62-rN7Q6@lore-qca>
 <20260813172156.0243cb7a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QAuoag7Qlga7XwOH"
Content-Disposition: inline
In-Reply-To: <20260813172156.0243cb7a@kernel.org>
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a827072 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=y9u56/S6JbnHW3dtX7SsYA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=eGnkRP_O6TsY_KFkqcMA:9
 a=CjuIK1q_8ugA:10 a=eUwoYkQ2b4UhtwRhp3UA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAxNyBTYWx0ZWRfX95It31h0raNb
 m0BbthDdKgQ19lZe7FZyGuDbhvvcg36axnVSyjIULr1j0KY+41L+SVp/eiTi/xNxOaVR3MoXWYp
 aM7BGN3Be5eDZO5cXw/TbsvfbX/jgcc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAxNyBTYWx0ZWRfX5lzpA9kQ+K+p
 6F8deAKYTqvRHO/1xxGAdE6dXrHaClXHPTImPPhCpihGgCLSqn1wshpLfBL8rO3cWggSmTcd4Rt
 Nm/2KRmFimcOfMjxEH0ER7awu0eIZw1Hb8eKuDuGE21OlW9sn2lewsz3uWzcQU5ULkg9YkCTAV4
 sYcldV2IYOLlTIu7xqSd4b79pQAWL030hmi1QyiacWj70lJMcfgobKk6CckL+f6dlPPW+RCg/US
 xUlt39jJgeRsuS0Wg+kceJuM52WbAY58SLlULVZN1RRsvJdpn3EgTyhAwN/LTeEvqnQVfGK+LY9
 WN4vgp16POVNN8ajnZ05VGnG00MSN3s94dkeRVhzzceKGiXePYuSZxgf5VABG/Gs0getSa8jWU5
 W20aqTGT0G5CE4qlgMgKhYNjSroPq4Nmxpy4BI+TdVAZu77xBgDmfD0ymbDPQXK0IB2W5TLvPbW
 SfHkK79pmyHI1v+YpFQ==
X-Proofpoint-GUID: aGgcG4Plan0AC9MNUBcMJVvUQOreSH9u
X-Proofpoint-ORIG-GUID: aGgcG4Plan0AC9MNUBcMJVvUQOreSH9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170017

--QAuoag7Qlga7XwOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 13 Aug 2026 22:36:29 +0200 Lorenzo Bianconi wrote:
> > On Aug 12, Jakub Kicinski wrote:
> > > On Wed, 12 Aug 2026 18:11:31 +0200 Lorenzo Bianconi wrote: =20
> > > > please drop this version, I will post v3 to fix some pending issues=
=2E =20
> > >=20
> > > FTR Russell was trying to fix TSO in this driver too, before giving up
> > > (on us?). The direction he was following of clearing the TSO caps in
> > > ndo_features_check and letting the stack GSO instead of all the weird
> > > hacks this driver has seemed much more sane. But maybe I'm missing
> > > something TBS specific here  =20
> >=20
> > thx for the pointers. I reviewed Russell's commits and I guess we have =
two
> > options here:
> >=20
> > - manages all the TSO/GSO checks in ndo_features_check() (stmmac_featur=
es_check())
> >   and disable TSO/GSO if the selected queue does not support checksum o=
ffload
> >   or it has TBS enabled. In this case I guess we can drop ndo_select_qu=
eue()
> >   callback completely (it does not make sense to me to always use queue=
 0 for
> >   TSO/GSO packets, e.g. it does not allow proper mqprio offload).
> >   Please note this approach would introduce some performance regression=
s with
> >   respect of the previous implementation.
> > - implements TSO/GSO checks in ndo_select_queue() callback
> >   (stmmac_select_queue()) in order to keep TSO/GSO enabled if the selec=
ted
> >   queue supports it and at the same time do not always use queue 0 for =
TSO/GSO
> >   packets (proper qdisc offload). Please note this is patch I am propos=
ing.
> >=20
> > What do you think?
>=20
> I don't know this driver, or how it's used.
>=20
> From the commit message it sounds like "if the packet wants TSO and=20
> the queue has a scheduler enabled - take the packet to another queue".
> Presumably you know why the TBS is enabled and whether the packet
> should or should not be going to that queue in the first place if
> you're sending the patch? What is the use case?

Reviewing the driver codebase, TBS and TSO can't be enabled at the same time
for a specific queue (TBS is not enabled via DTS but it is hardcoded in the
driver). Moreover, for some devices (e.g. dwmac-intel, dwmac-mediatek, ecc.)
TBS is enabled at bootstrap for Q1, Q2 .. Qn, (Q0 is never a TBS queue) whi=
le
for others (e.g. dwmac-stm32, dwmac-sunxi, ecc.) TBS is not enabled at all.
The current codebase forces TSO/GSO packets to Q0 (since the current driver
guarantees Q0 is a TSO queue). However this approach does not work with qdi=
sc
offload (e.g. mqprio).
I think it is clean to just move the TSO logic in ndo_features_check() and =
drop
ndo_select_queue() (previous option 1) but I guess this could introduce a
performance regression with respect to the current codebase (we could disab=
le TSO).
If we move the TSO logic in ndo_select_queue() (previous option 2), we coul=
d avoid
forcing the TSO/GSO traffic to Q0 if the selected queue supports it and
at the same time avoid any performance regression with respect to the curre=
nt
driver.

Regards,
Lorenzo


--QAuoag7Qlga7XwOH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaoJwbQAKCRA6cBh0uS2t
rHTwAP9OB+KuL9paucKapmcutF0REO2rHlCVsGoKX73Bqi4/wwD/S3Pmqa6JYHkp
oialF9o4sGc2cArZAMTn5p49Fe/u9Q4=
=jfRM
-----END PGP SIGNATURE-----

--QAuoag7Qlga7XwOH--

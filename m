Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9D18BC3B
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786846356; cv=none; b=HRkmzGb5pioqWmd606RgBGH3CS92SAyoi+RWrjXGiudFhDf6rTL6NxIc99RIxVMC6NS9HMUjUUHkP+zTm2kL8VbeX9wtX0gcXrUMjAdoueBJm8EHOsqlgtSM/oTSshT5ptjQU+6oi/6xFmSc8ekocvekVJxELk3IHT0A5kByVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786846356; c=relaxed/simple;
	bh=FNcJBW2fZpfcG72m7YD8cMo3vuAaGA7fVmhcO/olNII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1U0IPA5lgHUTM6PA4Gc3HCfliz0ll+o0RO5gmF2QVf0dEM2tKqud83iQCWUsPPx9SHIg5XtWDfU9vxvCZ563PEioH1WvIiqz4m+5cqMCaHwTGG5BgU5ad/7MclmWhFEiJHysMtheZm+DELMaEdceQBp5zrPCLQYYg+Tg6XH4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P3/vRRwQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I6c5xdzN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P3/vRRwQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I6c5xdzN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FNlKpw1540746
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 02:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FNcJBW2fZpfcG72m7YD8cMo3
	vuAaGA7fVmhcO/olNII=; b=P3/vRRwQAsaGG6Ms3wMZIdSL/xzhY8fvHKlty6Vk
	uLn1xFRjQ1nKZZaSakV8NWFTbr7jibmOaYe2FQE030CbnGDf02LdVb/G/a2jm+Fy
	FDXCz3ZhySGoVGrnHadDE8sV9FHw9khRFQYWyscIPuL1DvQ/qb154tAT56kSm4HO
	EoYSzCl4FYiLGs1FcwVSnqiGJmwxg5X/BwojGfKVndg6KwF98chSXh3N1Tw27CYD
	U7psRQWitjKxcRi6VIF2uoqpP8LfpM2LO2Y3+XsBxcBh5/ETHehr7CjO9rcaV+Lu
	/bYmhOOGYV+HsEXJcvnLLJEcgPp9Mqh22HEi3U5C3kSrOg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g322q87cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 02:12:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so3327110a91.3
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 19:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786846354; x=1787451154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNcJBW2fZpfcG72m7YD8cMo3vuAaGA7fVmhcO/olNII=;
        b=I6c5xdzNKOS0gXjZJ1o4OgRhMl0hbWyNA6AzlYgvx32enXMacsIFuXsf960iACTXAk
         ELKbrpRyxzju9zlCyMyKM1g03gt624S+IPJb/bCgrNKfl9Xabz9FVThEehIG5M06MP4e
         Q6ZuG+IPVomXv7o9OI9WRQNXwPluIyX/gvyN+fxgh7M2Bo9qStZNvZmq0G8zQHUhNtYz
         kOWsOwHTaJSTcJOBGh5+wbXbr/OlEbV+ml5BxpToyrI07sZ0AhgLEJ4mA4CgOVuPC59l
         GOkOCqBNKe6gzMLwOcmrYYReH7xSnBSW2D0UbjPBbDbYol9vItl7WCobddZm5WKiy9EY
         WRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786846354; x=1787451154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNcJBW2fZpfcG72m7YD8cMo3vuAaGA7fVmhcO/olNII=;
        b=jcm50u3yhmoBFvx5Py73RJwkdf0eNsZbbXmWjySR3n1kIGta+PXNlpSrrbknJb3xSm
         nLcOzRlNSehyXdq3lHa2XsR8xF9bOCuHDOoVfbTgbbsZgPcHqYBd0oEOCqScs5/xZKEJ
         ROJ6cyHgkZADc7PBxoKoNk6M57GaZZwOqvrDjVVl/JzIk05ONctc8sTtORzvj0B+Gc4R
         3XkOCoe2NnN3MhFP3F6B2h5ngt6Iak5NRAZ4bH16vEpQsjSY2M1hOrobBYSSsxKkfNA5
         ouhVCs4R3SRmtGlQAKiEM3sItPnvUgNhxq7+tq3hj9s3P0ZPZVe02LPxKYibt3rt1TXI
         +b0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoF+qqJBU5S0AOZ/oi28srqnbvRe64yRJEsM/UeUcCkDZou8KRDmjaihEkqbOh/DIEn8MV8dX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdfpXUJKdsqqOdWCfqWbhYwuc7D46tqF0x9a+80FCmOkrii4v
	Y9mRrpxx/3z+0e8tpc7jBY/TLDsIiPo9bw6+yYhT5jHvfwWE8NAcnF5iXYxLkVnWmmQPM16e+Ea
	e+tyv37XV5c3YKY9Fj27Ya9DV1hSsoUzHTftqoN1XtWTWRKuaILjle8P1uio=
X-Gm-Gg: AR+sD13gnfggYmbKABkdtdsYR1tx7GV4I4cMGjWsttX//M9dZPkhA5adYWqr0UhvEZR
	/lGf0zm/XixVAePSAgilTFqGG91s/5Q6Kpo2mwcytlR6rVr0aHSm9p+YX8qu8wM7dvCEoFnctqR
	ZPu5lZs+ht9wjZ4t9YIQx2pi0GYfuvQwO682zKJz9lruiHnulyo2pMarMILB6oFrfM2aWy8duwI
	nPUWRpRtCYCT9YTIFn/XmUAeqfkWobdRP9JLKehREA5lsPADMrYxyQ9PvIsWTQEYQYKklzcZySw
	hAozdGBA3osig8Zy/XCd/1Jtf1UV9Cf4w57e93rvu5m2BWaZgD9X2Hp2HDQOTgxOzlRHsUnGddt
	4NG/onEYoRHTI8g==
X-Received: by 2002:a17:90b:2c8d:b0:38f:caa2:5721 with SMTP id 98e67ed59e1d1-3933e62f4f8mr17525818a91.17.1786846353600;
        Sat, 15 Aug 2026 19:12:33 -0700 (PDT)
X-Received: by 2002:a17:90b:2c8d:b0:38f:caa2:5721 with SMTP id 98e67ed59e1d1-3933e62f4f8mr17525772a91.17.1786846352936;
        Sat, 15 Aug 2026 19:12:32 -0700 (PDT)
Received: from localhost ([4.43.230.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e142dbsm150525a91.1.2026.08.15.19.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 19:12:32 -0700 (PDT)
Date: Sun, 16 Aug 2026 04:12:30 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Daniel Thompson <daniel@riscstar.com>, Alex Elder <elder@riscstar.com>,
        Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: add tc-mqprio qdisc offload
Message-ID: <aoEcjrBy6h7E22dI@lore-qca>
References: <20260808-stmmac-ets-offload-v3-0-b714466142b9@oss.qualcomm.com>
 <20260808-stmmac-ets-offload-v3-2-b714466142b9@oss.qualcomm.com>
 <20260814135631.766ceb41@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwF8KmuxzVjuS+UV"
Content-Disposition: inline
In-Reply-To: <20260814135631.766ceb41@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDAxNCBTYWx0ZWRfX4CCKoN5jx8IE
 0Sl8AwR5TRGqfAmZEYptsT1KGTJ2m8Z54nKc/bkXq05pXcpnWN6QqV5CwAPtNIJvJEV24tPic0s
 C+ltABHRY1K1QT+1HG/pWFx7xbTTpt0=
X-Proofpoint-GUID: 2HMIvXvFD8kB3-YYnE2a7Ut-LYK-UtFw
X-Authority-Analysis: v=2.4 cv=C5PZDwP+ c=1 sm=1 tr=0 ts=6a811c92 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=y9u56/S6JbnHW3dtX7SsYA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=1LTPP7CxEm4iLMqfjvUA:9
 a=CjuIK1q_8ugA:10 a=abe5JHccC3Obh-31B2kA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDAxNCBTYWx0ZWRfX8FlK5e6Dh0QV
 7sELl+M2u4ZqUMDFFSvsZr/vGUKF2CwX+JYxEB+3GXfRl+gGXgJ2RVv0dgpGcMCr2hbpGcYfFyS
 bsAwQWseZ+CrZSBSlQWLVbtoV1vFYJ+oOXv9EOEbBmKBqm6kkwrs+KmO9ODUpAQNyHWhTtdlVQC
 j93Rp/DDZl2QjQo99i3afLIrP+Vh8BrH3Szj2qnib6dXvxu5hZe2Z5WUsG3IUAr3eQQi3TOCbq9
 v/qN6ubzVzZXDEXnG83cWwof8IoqsK5DiUzQdZnohU/1tPvRQcxg2yZsUTiGoM6WY5gT1VcuvBv
 BusvWZ0da6RjVKlWn2ddzBD3jvmBCp4/3su+fqXgUANt5Z1Lt+cOd5rDPfCRYYQdmYcEX1bgBe8
 HNjoIQ416n9GRwtiwzKSsb/3iNspnZX7NIqRwkh3s82Srm1fg3D11Fhiqh7P8u6v/9o/O6gZWIL
 xjPqrBaqZnNTZzhL9BQ==
X-Proofpoint-ORIG-GUID: 2HMIvXvFD8kB3-YYnE2a7Ut-LYK-UtFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160014

--mwF8KmuxzVjuS+UV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 08 Aug 2026 16:49:58 +0200 Lorenzo Bianconi wrote:
> > Subject: [PATCH net-next v3 2/3] net: stmmac: add tc-mqprio qdisc offlo=
ad
> >=20
> > Implement offload of the tc-mqprio qdisc in the stmmac driver. The MTL =
TX
> > scheduler is switched to strict priority, and the PSTQX/PSTC priority
> > bitmask of each TX queue is programmed from the set of frame priorities
> > mapped to the owning traffic class (qopt->prio_tc_map).
> >=20
> > The offload requires the DCB feature and a 1:1 TC to TX queue mapping,
> > with the queue ranges bounded by the number of queues the MAC implement=
s.
> > Configurations with AVB queues are rejected, since forcing strict
> > priority conflicts with the CBS algorithm.
>=20
> Clashiko has a bunch of comments, I assume at least one of them is
> actionable. High level - you say "add tc-mqprio qdisc offload"
> but the driver already has a bunch of mqprio code. Background
> would be useful. You also say "1:1 TC to TX queue mapping", if there's
> only one queue per priority why offload mqprio and not prio?
> At least a note in the commit message would be useful.

ack, thx. I will address them in v4.

Regards,
Lorenzo

--mwF8KmuxzVjuS+UV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaoEcjgAKCRA6cBh0uS2t
rPLaAPwNhvlwtI5cH91/8Oj5jzqnm4RKoWFYOWz0EWyv0Vw1xwD/QjanQNDBanDr
aT49OJ+Y1YE70hdbgSPIwPHmy9KRHAc=
=PVBu
-----END PGP SIGNATURE-----

--mwF8KmuxzVjuS+UV--

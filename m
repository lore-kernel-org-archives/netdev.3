Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500C4AE8C8
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387875; cv=none; b=jj77sD0klmsykSN72CvatrQ5zlhXLlkT6q31zRYnpZ7Iz+2dkxk3VR38dWFPpBuFgv80rbkihjHIakpVVJcbVIv+BFG59FFkSd1PXYg2CvVMyFyqtFjIS+UVPHNEew8KUuqUB8OvTg/YFOOFjEIkUUW+IRiQSjWvUR15vO454Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387875; c=relaxed/simple;
	bh=Rz4totOzuCAyXVxPJQ7uOXwVilujvZOEhoS6wFuB4r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qusq9VX+DOBvCEtCQQCPW0mhju5hrB2t9Ma/qZ292Z4kgfp7zP7aMN5G3ZKJrJ1wZkP63pp5JBe1ENKEAglp8cDaq835M9x8lD09xptr313tEcbYRysHbXV4nBtR7MuuCQt+JDslQFL5xVbyBSkMVVkgb8sI4NLl3crbTQz6hV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DB5w7My4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HDa30e9s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DB5w7My4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HDa30e9s"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHFLo2581205
	for <netdev@vger.kernel.org>; Wed, 2 Sep 2026 22:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=18vPnmJEZtEvBUuGwHJgoJZ3
	PhgzCYtMv1/K1VGThH8=; b=DB5w7My4ed+/r9Wj8JS6IRovwzDK5/P1HYQ36629
	AFmkuMI4wxbU5HGAVjmUmU840F4IUFC/Lb/ZLNBvMdAdOjgEPwotk0y5S+L9egzm
	5xjHVbwHQy5Fl2clS6ML53Q8EiOCHbiRMr2rCNNVmrt3dhBwGHUzL3p4ZZ7mFomq
	YgDcKNMx75ow0quXwvzLTHSVXZSyeKKUtUdjlNcXyd8Qp3nhwH9UeLNp6qvCbQgh
	/7NqhuLelTHZ3HlCktrPzXhma1HIM/JYm8oSgIL6QInEX4NWLFn3nwHdXOJ5Qqah
	PbfAADsj0zzjrqhfsTl6KNScP4fvqUjwUl3THhpLODeS6Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2cb614-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 22:24:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93494cce712so325513485a.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788387866; x=1788992666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=18vPnmJEZtEvBUuGwHJgoJZ3PhgzCYtMv1/K1VGThH8=;
        b=HDa30e9saBIufgyC6RbX5005TArWixyQ35ZIq/qzPVdkEeT8tts4aB8s480iEettrg
         LlQ3S+wViBYbLFG/wsapU1MGPCrsGKMrZ/BGpLCL9jU62fXytjFcF1T3yH/jJwOwfWxQ
         1nTQvr2nw3RkY2ZjcJUDydVox2GhWeHxr2v1zV5QqNx8veYgjpsdLIM0plCReUyqucnv
         qMJtQQZb1r7pRB5rHhqJOMrPNBu30Ad69GZmbghMn6QMb3r9rfhjQfsIXMwp0DM7FrR0
         sxaYYPuppHpvd+tTDBBHXdCQbUREcCeDV6JXhWuiXZF1jJGmAPCP2pDCXYK61cG3DcrB
         yhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788387866; x=1788992666;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=18vPnmJEZtEvBUuGwHJgoJZ3PhgzCYtMv1/K1VGThH8=;
        b=SemkKBuTRQic65u33gCMPY3S8LO3UlYczex+wKlyE2XouMU/jC7L7LkN4qfDUEfUCO
         XbGs/4wmmxvy1VNSHYLh8310ek985oAiZB4P0zYDynOPfOTi5qMa5dF17AGj/y9RB8aU
         baE+la3oL3dWL4kas9B2puewItRmBuNjGGFvLyWPiViWKeLRr8pVqwwSde/kNz4kRE3i
         EYPCwHXd5mLdDi13kNRRhbywteMKDVhDgcO24p0uaxUr+O+fcbqhBkY7QWkZu5c/IzVu
         Ug9NVCCMvfJQDXJHUzQC5znX0YIeJlT8038xi3uSb6NihMPVQk7ugTqrugGT4L60lWgj
         f65g==
X-Forwarded-Encrypted: i=1; AKwUvBwsShcsv2z/n1wdULFUUcC0F7OtDBBubicOeD84gvY6e7JDfSj9P/xK2rc3wU8O0kRexF1QIoM=@vger.kernel.org
X-Gm-Message-State: AFuF++nRt/dfkV1Fzzz8SF7pT3uUkh51AgCMoNG7uIdRueVnlvv3LgFs
	mhXnikQlJmGKC9oDUqRlJblcKCOZi4ypJFCer+kFceYzHDcSGSS2KYTPem3shlXkCF5mFKb3jf5
	DM2IIk/4drweF5PffFIejZsfU4VFJkuu7Yd+3yK1YsA3lEJJCcqP2RRlGivc=
X-Gm-Gg: AYBFou15xJKrMNhBeIb72mddG46L8yIhBn3DFwzZMI2UKSBNZK+C7Rq4gjUvsZuCrro
	pJnx46s07wqEit5Zy36rjjDrYB4nJOOQCrh7GjLTN8wdQhjpZo5wX/gbE3oNrB/CINPQQ5zrUN9
	175jXq5eNxX7kPeVSxG7Nf0zGNX8bOCl4sBb6Jgks8vZiLOE+fD1PplHvrDdxZVCyqcwukFlQXV
	X42THknoXNVcM/5VnETsb6c+hqmjQG6uPefv4q/uGvxvSFJ8BI/qdrlRRey52+0Y9glGz7jn3uF
	4NpwH5BR4wvbzmdV7oLc0nAabrTiDrlgvXz+nEH7yt+9GuyuwTCTLF9f5FEbyUk72JMAjoAaOQ7
	cytPQd0N9xUwwnA==
X-Received: by 2002:a05:620a:4110:b0:939:639b:2e1f with SMTP id af79cd13be357-939639bdaf3mr827531785a.7.1788387863496;
        Wed, 02 Sep 2026 15:24:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4110:b0:939:639b:2e1f with SMTP id af79cd13be357-939639bdaf3mr827494285a.7.1788387858198;
        Wed, 02 Sep 2026 15:24:18 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d2019sm21672695e9.2.2026.09.02.15.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:24:17 -0700 (PDT)
Date: Thu, 3 Sep 2026 00:24:16 +0200
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
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>,
        Thierry Reding <treding@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3 1/4] net: stmmac: propagate PTP init failures in
 stmmac_setup_ptp()
Message-ID: <apiiEIS2ExdBIPqr@lore-desk>
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
 <20260902-stmmac-est-reapply-after-open-v3-1-e72a6df5a7ef@oss.qualcomm.com>
 <1010cb80-d9c9-4891-a719-8d7ca31c732a@bootlin.com>
 <apiT0ZrlBMF2k8qz@lore-desk>
 <ebe7d40e-4f2c-4c39-8d9d-ef588074154b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+uG7zYthDkJCX/Va"
Content-Disposition: inline
In-Reply-To: <ebe7d40e-4f2c-4c39-8d9d-ef588074154b@bootlin.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE5OCBTYWx0ZWRfXyXkguI7HanJj
 SqRYp0rpT54HFESs1XU17v4eGI1RWHwbpOlwx7Z/ItdBE3cbZPln4SFsSsKITNBdvQaO7eXVMjw
 VM9GOoSQVf74JyyaeUxjQTELKmT2Ums=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a98a21a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=09jnV3MRIQTx9f2RKdYA:9
 a=CjuIK1q_8ugA:10 a=xbPlxFjQ-td3EfFMwg8A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 6OGRgftXhf18i2edI3Se7QjwMcfwP5K4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE5OCBTYWx0ZWRfX9PsGQYAD/LFx
 KgXRvdDqhbfoAwXFxdthh6rB10XIH4pSyrnhcgcayxIWbmGiq8elq90aQsihahG6MOxBFUhtWqK
 FuGwc179e4FjgvkBQbFPrd12AbU71CPSH1wu4qVcE54EWGN1Q/e4pg+BVwkzbaA1f9SuRUfEZsG
 wRDKYL8piOSwWzPv5bKGtgIus6EMhX83X/yP+kIR6QguL7gQyhUm80QbCI7oxRzLqI3hzizqXwi
 V6Nq5JT58yV67qpdmvzjpdHREMLVZ9aH0Ev4a12EfEtRgSuc6hV8qtSN+/btba7f2/VKraqNuWw
 5FO4dekbOocAVRgn+Cmtiyc/+zt6fXS5XcAAyTCQy4twm/a0lNh1jXBYFx2xVY+8fVintmZROYc
 appUKzmCMW+tINd9Kde+JYvpNGVTXf8SSyXCIf7zdDvkP7gBKt5Oo6mD0jqaE6MsWHMt3iBVORZ
 X0dwBkrKnBBSmwWEzMQ==
X-Proofpoint-ORIG-GUID: 6OGRgftXhf18i2edI3Se7QjwMcfwP5K4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020198

--+uG7zYthDkJCX/Va
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> >>> -static void stmmac_setup_ptp(struct stmmac_priv *priv)
> >>> +static int stmmac_setup_ptp(struct stmmac_priv *priv)
> >>>  {
> >>>  	int ret;
> >>> =20
> >>>  	ret =3D clk_prepare_enable(priv->plat->clk_ptp_ref);
> >>> -	if (ret < 0)
> >>> +	if (ret < 0) {
> >>>  		netdev_warn(priv->dev,
> >>>  			    "failed to enable PTP reference clock: %pe\n",
> >>>  			    ERR_PTR(ret));
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	ret =3D stmmac_init_timestamping(priv);
> >>> +	if (ret) {
> >>> +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> >>> +		return ret;
> >>> +	}
> >>
> >> This can legitimately fail with -EOPNOTSUPP, we musn't failt the whole=
 open
> >> sequence in this case.
> >=20
> > ops, right. I guess we should just skip -EOPNOTSUPP in this case, or do=
 you
> > prefer to always not report the error from stmmac_init_timestamping()?
>=20
> The clean solution IMO is to gracefully handle -EOPNOTSUPP, here I think =
you
> pass it on to the caller exactly like you do (I don't think it makes sens=
e to
> still enable clk_ptp_ref if you don't have timestamping available), and i=
n the
> __stmmac_open() path you don't fail on -EOPNOTSUPP.

ack, I will fix it in v4.

Regards,
Lorenzo

>=20
> Thanks :)
>=20
> Maxime
>=20

--+uG7zYthDkJCX/Va
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapiiEAAKCRA6cBh0uS2t
rMpeAQDSlOGBUoDB8iAvL0AANqgwiQB1TA6IntKZ+pzplorvugEA+k+rry0HXitb
TP2XILNZCA5T3YbdGL2pMUmnfThEIw4=
=Q2Yi
-----END PGP SIGNATURE-----

--+uG7zYthDkJCX/Va--

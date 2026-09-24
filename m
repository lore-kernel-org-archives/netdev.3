Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43E2D5408
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236640; cv=none; b=LsjVc/KYlMr9nHBxY08Xy3+2QMJiaH5CS/Fkq+1jU4oamtp32UQIsA7JutziU7f1J2675xy7dn2dn7bQT+TbQzQfSVYiiExaj7cHI/cIFSYID3P+XwgfJKTV5z0Kf9KHpXPluK46b3S4EIhWvrES+dH9pPsA3BTR9EQOiz4XwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236640; c=relaxed/simple;
	bh=HcXaDz5KCiX2wRs6pF4PPkcCP1k1shxEJGxo93Vesck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5Ou01rRIkx8r6NxubQGTMGTTeP1dDZvvzGwF269RiNzbZf+UcfP5i5Z2rcHynoLNPdafEf1ff7vo3KIWzLJtDsZeXG3zp8jWwsqFoTjzSW27ng0OZLNPSUiL0SprM6cr05BXSobOfx2Or7eRhF+eNSNt18k3M8pvp3ta+mcueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oo1VqYwB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OHUzVrBt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oo1VqYwB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OHUzVrBt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eJRD772577
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B1KraGaFrLufIKtIo+iDUvbQ
	2uJXNY7+zBo1hgqcENs=; b=Oo1VqYwBPFQ3domiq5wFNAbS80Pr4QJt0FKuaRJ6
	lJjtc0bJQSlO1pvn9TqdO6onCUIfw8AgSdJ+xetIjY7F4PVdSjWaP1DXuu4fNj4p
	aVuWI21NdNbkNXgfIIB604sz5ApHhHOx2g7Gif3/pyqMote+wi0X7P8gEnWi/uJB
	dDA9yED9e/0g1UScS4GelwgNkngf8pybupmf+9lGuhqJMBmu2W4lHRjBzCe/D7Of
	FFOYaUIcIHw3vax4tj0+yhz7HLuwSGPN1ElKQ6oJUf6LHgGNEAdZidSAqPHaBAKh
	NTVQK7T42mp+Getc7cYCBk2O6MmUAtkbfvVtMqYnfLAuKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr909q87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:57:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so407154485a.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790236637; x=1790841437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B1KraGaFrLufIKtIo+iDUvbQ2uJXNY7+zBo1hgqcENs=;
        b=OHUzVrBtCJo+Wjb7l5plDlQ9h65VNMIVqfmgStPKIfmB1lVf8IZWxdYZPaQqnsnkbn
         yyVwy+vX+9FDSPmGvnI1qP2hQiUKhcM9Y0xqiAycUwPU9rcQTymwKWQPwnbUQpLaOu4f
         UaN1ns0u7xRevEif1SuesOiKsIMGiL4RQxuazvljE6nP2kosXLNuHkmphZOflJTvrEDq
         GPeMok14zIb8gzVVEGdgYTD5Ql79yzLCgiC0q1+GV8vwlFajBop2uHZOApdGRs3Z4ioG
         H0agib8cmQt7nQZ0/myEJwx7K4aIsLivqN/cauVPdNhj5WQqDdTcIwN5Lr2VdMBSfwrT
         Ru9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236637; x=1790841437;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1KraGaFrLufIKtIo+iDUvbQ2uJXNY7+zBo1hgqcENs=;
        b=NjEdy6s+FaOrxhmdckAseohDK6+H513wi5RmqHSoz2UsrbJxqtLcf9AlKrAGcOM7y0
         4woXLFIVnj9WCWOKtw8DwBkOFVoKE527F+sADpUOZ5janwaZcpWHqBDYE6e+YUFglweD
         9VpXS62zWdzsBH734bP+qXl2Zrrk8Sx7WLE3QJqtTxJ3imCiB3Wp4Ykfy8zGI5+24lsP
         NJJiZs7T5PGTLnmGvi1EOHYwMGhn12Rq2lK44kM6NmLXOJp9Ybzcsqy10158H9UbGAep
         bXq1sBFeioHcLIN8cwRd/Ckl2WdPJ1GRJTrGN7aivdxnTXcQTOfdC6vMn5xGoHLqnnl2
         FJOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcmauRgrahxD54aIZ/NJIEFsGo9d3hS18t3mgXO6Sc1pDNS01SlfJbCXd2tbI34QlFsKpLd9U=@vger.kernel.org
X-Gm-Message-State: AFuF++lFB5YNCq0s4SJo41tpoptV0L16id848emeJ0EPkUn1NURhncr1
	7U34dSHRgCfG9vN8P9ez658SrVRA9GDpHthp6CnxrOtpnVlthwnbOgzIX12HJs40y/ULTbXd21m
	CXACnrCHJndMnGg2jIiWF1Mb06Wsi0BKXUEqsm4Negyh3DPp/J0dn0l8sQ4Q=
X-Gm-Gg: AYBFou0I6ccVuAeJU6lnLXPaUcD73WfvKZyj/5rCv53oH7d4eIQLtC/ct9hFLmWK+1e
	44hy0AmD2n1z7mRkIFQrjnZiHLbMZIKuY1HMwdkakxf9OpCQk0+Uwt98d0CG7bVUlL0x60EXxdw
	SlX6qYocZUqDfJHF2U65pZZ7XoRJtj7nXBRQLp8yQsMv8JrOPXcQ3twPmdZvKW6bOgJYP7/zBoT
	jj4AsC+FY0KD5yeSskmwq4VV4yJPFE3R6HPhyca8Mgq8EPtlHbgGvrv0fBucSad75kkl/IK0TMv
	YCJrl4ZxH97mn/7stmCMZmcHdBK8a4JOr8a9leWziV7asDtfJB/aTt5MmJ18s+P1lXfLerIp4zg
	n4/9IgzCw9M713w==
X-Received: by 2002:a05:620a:29c8:b0:93b:d7a1:ba0b with SMTP id af79cd13be357-93c3640435cmr182041185a.54.1790236637211;
        Thu, 24 Sep 2026 00:57:17 -0700 (PDT)
X-Received: by 2002:a05:620a:29c8:b0:93b:d7a1:ba0b with SMTP id af79cd13be357-93c3640435cmr182037985a.54.1790236636558;
        Thu, 24 Sep 2026 00:57:16 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bae53dsm49769305e9.4.2026.09.24.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:57:15 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:57:14 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Message-ID: <arTX2kNFGXLg7vdn@lore-desk>
References: <20260923162339.1375698-1-qwe.aldo@gmail.com>
 <arQ4dVkI9llhXCDx@lore-desk>
 <78724445-4c69-44fb-b82a-1f9275e37e9e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35r0MCTMsnB7aZOv"
Content-Disposition: inline
In-Reply-To: <78724445-4c69-44fb-b82a-1f9275e37e9e@lunn.ch>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMyBTYWx0ZWRfX/+A8aMhIbgua
 lYJN/mN5u/SMcbd0vNhAwAr+vqS+uMhzA0raG5J60z2Iq3npjMbyXifneqguXnfoiLWbr0Wh9X/
 te8u1JHFkWT23dBrBFCgoS/dYFTyMuk=
X-Proofpoint-GUID: jE78lEKtHnLxeO93p32MmkkYvnyloQWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMyBTYWx0ZWRfX9ND+23zGhLbx
 /mB3wEAB1QgsTkLdAHmglZ5+04AQZ2q3lowy01RxNtuPgadsfTOdKqJutb0AuVpiOPVvcIWfEdq
 vV1y3fPwcJ8JUrOi0/OYE+wbagpoTtGMSDxuNpsCm/rPbqdDM/OvE3nFihQLbOMAaZAeVozMC4h
 jYRXIaN//2RB6ZHlP01Ij2XXgPc5Z8QzwBn61fXGzDjAKa0XE41RrLs34uvCF+HHtZTS9/gg7vd
 OB4Z3YaDsvT8VBeLBpsbvmkpeb5/xS2YvqIIFjxTK03gQqmI9ntaGt7DEZdvMZpavs5vTLvGnul
 1+nzl+wQTxHyccyXmmLlNWzO3S/MZK4nayrOZjPpLOyFmrB3P4RMe4h8lL4FIKb9UuQ20icdTrY
 IvRZ+ecugjvcyP4LyNTz6TbVhb6asyX6SRHtvbe0PEajGAREMxgKHhI+r0JZvlpSeTd7F3ReMX1
 EOqyQiWb2aJXl/hw/6g==
X-Proofpoint-ORIG-GUID: jE78lEKtHnLxeO93p32MmkkYvnyloQWi
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab4d7de cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KVXIDpKRKy7ce-yJhUkA:9
 a=CjuIK1q_8ugA:10 a=u9Tfa8qlk6M8Y1NLbVIA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240033

--35r0MCTMsnB7aZOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > @@ -5808,10 +5809,10 @@ static int stmmac_rx(struct stmmac_priv *priv=
, int limit, u32 queue)
> > > =20
> > >  		/* ACS is disabled; strip manually. */
> > >  		if (likely(!(status & rx_not_ls))) {
> > > -			if (buf2_len) {
> > > +			if (buf2_len >=3D ETH_FCS_LEN) {
> >=20
> > I do not think this approach is correct since, at least theoretically, =
the FCS can be
> > splitted between buf1 and buf2.
>=20
> We are talking about runt frames here, so less than 64 bytes in
> size. Can such a frame be split over two buffers? What is the minimum
> size of the first buffer?

Why are talking just about runt frames?  According to my understanding,
this codebase (at least the one in stmmac_rx()) is executed on all
'last fragments'. Am I missing something?

Regards,
Lorenzo

>=20
> 	Andrew

--35r0MCTMsnB7aZOv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarTX2gAKCRA6cBh0uS2t
rJBuAP4nU5clgQENSyBlnzWzn8AMHbSqn2jOuJvlgtlkekrq9wD9EZ3PQdweW0zF
We+ngFGarlY007Y9aBFBkMttXLF0Kgo=
=UxuT
-----END PGP SIGNATURE-----

--35r0MCTMsnB7aZOv--

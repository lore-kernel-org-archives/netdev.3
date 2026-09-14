Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916C37AA97
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369865; cv=none; b=eQl86Z06nKX6DODY2+39DEYXvWD2CptXJ4owXtweSro/kLxdxj1sXH6faT7TOFlVorRKp2hE/uBfZvafbzvH4UYdPAXh4HnKYj7EjtHJNqMYDDQ7PXjbbplcwqkNh1muJq2qx32zABL0JM9wNqQyemCtyHTPiezT/sopI8L4ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369865; c=relaxed/simple;
	bh=6OvIkQ7WXbvC+cMXKjpvm4sPjisZNwPMuEMKh4zZOLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzgcXB8sWmKyH9gRreYEh2rrPkIjcsEnjLwO+YPx30wwqgxgEG8ynFDpo6bZGOSfEnEh1Zti9vWHqfOnkVrie7BDhHsikdZ7QukTg3EhtSsUGw3sTOgL3eV5if5AmDoJdfQ737zD+zclmfGvdRYVXGBAVm/mWIJapJJx1ZQPook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QAhZ5JF0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QOaAiIWz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QAhZ5JF0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QOaAiIWz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5jaZW544305
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6OvIkQ7WXbvC+cMXKjpvm4sP
	jisZNwPMuEMKh4zZOLc=; b=QAhZ5JF0vMZvzJ9c2l5tLcd8u0/o8W6LrsQNe3KE
	3qDIDG9oquWS3QOfFPp6rwWbQYWQdUqIni1t4/bDIY2yP2vFu2bcgbDPQTiwXiQK
	TO86wcd+jK38U1QV29/tWLBL44ebVwcc8TAhPsENBVBTI5lTtAlMrGD86RZTWZje
	AEdw13XSwncNQTEu1AtoQjILJvMB0Q9vM7om9XSv4VEXa/3Z7ywXOMO5eziLCwG/
	yk/YibVvOaliarQgoWYax4w9aQ1e5DiLDPXxlRbhyG5OgapEHznLqpDeOexIP6v6
	tHlwWpIJu/jEgaQKu29zAnhN5vCempN/U8/7+go56mDufA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k099tp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:11:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93903622880so806699385a.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789369863; x=1789974663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6OvIkQ7WXbvC+cMXKjpvm4sPjisZNwPMuEMKh4zZOLc=;
        b=QOaAiIWzSE7HGA2uFC/SBB1B/nSRkiWUVBlOB0DYHt0jOG+xwIyPfdfC9PglD5bq+p
         jfrKjneBZ0Gm7+zdyySziJ7r08wTOTBosG2APJg9etfqHaoHID1Sr9SaA5+EKY8fFEQJ
         HliEmGJRE1Lx6UPtA6v/s5MDMUz70nuuBsIbBNUw9Bkp9wKztx4GK6Nc66HEKEt+Fu2m
         3E+9/M0xS84T2S+d3K/49n7uys5cs3qHwl/ju1nAUIfy0YMdDzyBNd8cDyQdRooXzJfh
         gPYaNEvUfCWTcWLkN1Ui7MfCMikLuBtlD7HfczNlS/vJ/hXvaNIe6+X9Qeq2mGKbA+O/
         mEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789369863; x=1789974663;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OvIkQ7WXbvC+cMXKjpvm4sPjisZNwPMuEMKh4zZOLc=;
        b=gqYsL5WAUtRrktW4LjLUIrLKrpWvfJlq41PlKbwhQbN4HouvWv8SdXk/salNOrCmAb
         O2dqQ0DsfeNhmwwCF8ul7/1jmecUZnAqLGhUbOguH54fPNpgSexBp02imJcYlWon65kl
         +WQO9UlFOQV8tumutBF5jTOlyUkZxsjDsvViRRcGVaKc6CD3CECT4wGRPyT73MVV7ham
         BT1jCfu/hZTBNrHYdHQ6Ylziyjj/nuUOEeRKbWfJDkQSqmwa6FEQsOxuUl8fs3ejaq9p
         y2/SanRK7zb5tVY3t9vf986Ke4jqrmn2w7M4ceI0W/Izqw3uYXOxQYKOVHg8x8xY+QVD
         We9A==
X-Forwarded-Encrypted: i=1; AKwUvBzYtB2S7MYyIDLLiFMLDCX053lvZeruIwHCRhfpKi8hkS5bfao5gn98bQm8bfBBqRXwdYIiGcc=@vger.kernel.org
X-Gm-Message-State: AFuF++mEGBD2VUCBRkzIEvnLxBX6rdrtQ9ULO/TgglkPkR04KbJk3RV+
	F6EFXGqAlp8ymyUZu0ouu/7eIw3BnaeP+I4DGDo+XwrZu0jz8XuN87q/5HmIJ5G4vL5PEsJpG8s
	s43cWBvvGCV7eSqbjIreJEfA8PWtTnUCQA/9Em8d07WYRMDn03rRANy+khJQ=
X-Gm-Gg: AYBFou35G/PMLtffhXlA0UK1Bi94SFPIYvdwh4XcRw19ezKyLhUCmCXcJgsn19XYKCi
	yS3AsSUgAmL+MaBC2Y4QvtP+tPm+i4xw30i7kalivtIo6LBAZxI1m8VGOxYTSHN9WiRgmscVvKX
	sqs+K/VdwlBhsNHHyw+KCHOha9bwBFqsLvYRGVpeXLFtvxcr2Ah3TJGUZ4eGHh6J9o48eYt+c4+
	xJnfNe5BwV6n86GOa7tqzRWks3uLTqI9iSqSn+12dmnv7x9NWkkyEd/ctBd8K5eMrfok3he6IWF
	yJJLipmHAS72SZfNnHQg0ml5hAuCXUqe6/E77OqD/pwjI6F6au3RUwauZ6Jbr7pQV+zBaR6DAo+
	v3eUBJ1sm01n1xQ==
X-Received: by 2002:a05:620a:461e:b0:93a:5d6:9ef5 with SMTP id af79cd13be357-93a185a8922mr528238485a.12.1789369862510;
        Mon, 14 Sep 2026 00:11:02 -0700 (PDT)
X-Received: by 2002:a05:620a:461e:b0:93a:5d6:9ef5 with SMTP id af79cd13be357-93a185a8922mr528234685a.12.1789369862013;
        Mon, 14 Sep 2026 00:11:02 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486f0403125sm21787846f8f.8.2026.09.14.00.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:11:01 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:11:00 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Gal Pressman <gal@nvidia.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Carolina Jubran <cjubran@nvidia.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: report phc_index as -1 when no PTP
 clock is registered
Message-ID: <aqeeBOjej4CYTVGZ@lore-desk>
References: <20260912-stmmac-fix-phc_index-v1-1-26e1ead25324@oss.qualcomm.com>
 <2eecb396-8b5b-4e82-bff5-c163a6c16bb3@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fUqptj69rX3noc3V"
Content-Disposition: inline
In-Reply-To: <2eecb396-8b5b-4e82-bff5-c163a6c16bb3@nvidia.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwMCBTYWx0ZWRfX4PmnqKxDCYin
 KMAzIwQnXAR2B0kMH61BanoT9ynBbOHjeEog3nU963prJJwr5u4JKtJe7d8irKPM38pTXj3vL31
 auN+Uy2QMDE8O5TTEvJNQJfp/HKtR8I=
X-Proofpoint-GUID: 3rzG6hZAlPJCG8DTbMMOsD6imbZxBk7h
X-Proofpoint-ORIG-GUID: 3rzG6hZAlPJCG8DTbMMOsD6imbZxBk7h
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa79e07 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=sM7fFmaBarVHFOEcdfQA:9 a=CjuIK1q_8ugA:10 a=lUfVGALKYBMCpC4gGrwA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwMCBTYWx0ZWRfX3w27QvOqsxI4
 Yl80ej33Y8K9vFSWj8/uXAGYy40M1Qn7qVddkqyppKxpgEZdWqXQO+PtvOaBuJzpHc2zFQlVRHk
 qwoS0Yk1TdO4JthSnjLjTEbX1IyKC6HkTm8KIE42EhfpAZM/ZZWyuYAgvWROcXzLRpi/y00fQ2X
 2kRsvfqzXJ4xBYq3/mDCoWhWCvmYqAIeLhpq2EO33shOd3os2WmXKocN5iDpLLbnBP0V/47PDfI
 RrjNI+tKICueZ5dTK0ToHQFOZ9yJmlrC3Hzf7UwVBkvnDaf3yJeJv9bbwKUNqdJ/+HdSpb5yJtO
 /0uuSPdmw+nv5r6oAgooKG5POvy/4pj48giEpyF+i7cQHmMmEnduhaxktcdK+cS4V5OSZpTKFTN
 GN6tzs+RxqR+hTKdogFbOQLoNRY0yHPKasAvcFEohrpHKBLsQ3lHTpqXP4GAkP7SSEg3D+aAoOt
 WSc/+94GluE1hBKkZkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140100

--fUqptj69rX3noc3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 14, Gal Pressman wrote:
> On 13/09/2026 0:16, Lorenzo Bianconi wrote:
> > When hardware timestamping is supported but no PTP clock has been
> > registered yet (e.g. while the interface is down), stmmac_get_ts_info()
> > currently reports phc_index as 0. Zero is a valid PHC index and would
> > make userspace resolve the wrong clock; the absence of a clock should
> > be reported as -1, matching ethtool_init_tsinfo() and
> > ethtool_op_get_ts_info().
> >=20
> > Report -1 when no PTP clock is available.
> >=20
> > Fixes: 9364fa7fcf12 ("net: stmmac: Remove setting of RX software timest=
amp")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> In all other drivers I just removed the assignment, why not do the same
> here?

Ack, I agree. Since we run ethtool_init_tsinfo() before running the
get_ts_info() callback, we can drop phc_index initialization to -1.
I will fix it in v2.

Regards,
Lorenzo

--fUqptj69rX3noc3V
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqeeBAAKCRA6cBh0uS2t
rLULAP9p+1QhfxrKFkt0RxnqCsrRXbe/JkA81oDL0nUz/IVfDwD/YsAbhRIhavAz
alwh47B1TC2mbg02iCAsXavqhs35Dgg=
=bxxO
-----END PGP SIGNATURE-----

--fUqptj69rX3noc3V--

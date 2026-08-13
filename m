Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD433FE0A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653396; cv=none; b=EssLKDquZW/p65OrTX0SttTih688MDC79biI4MJEiioIDwJ3p9JMbrt5ZMfAVNrhK8NQY4eVD+5SCDC9PwsaftC3M1WA1ny5BY+rl7zqvBD17dCVDNW9bt4qD/MbT5tpngA8pjKPhTJhzSKDWUtnGbn8xy1ux4FNZ4PeUEp5Hgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653396; c=relaxed/simple;
	bh=IpgPeMiEpk25zUEGwKbV/pNbaJp+/ypaBinzYGj7L0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twzYR3Ifr44NSJZoU/h8NhXOK9ZmfPVatb0THg+DRTFDflSYIZ7tHPH3ctMn7qfU5vjNrQG3niAFNiQQtm+f60gH2mrCSAKF46MWoRKXIAt9JYiEe2x+6CX2Bi+u3oBBdO7dQRV0puU9BP+aGaEoMtwsqeWlP0CcuazkkrvmdKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UF7qj7o1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XlpSTKpS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UF7qj7o1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XlpSTKpS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DIhcDY3928562
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 20:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ScWLcB/fMLJOTJ43EoCi0hMq
	y36OYwu47ooR2PxtXT8=; b=UF7qj7o1JQ8xcn4DuuBDxxrMmkIMr/CwqceJPZ/e
	jKs5S7f1thRenz+oyRIpoQplLg8yUAk+yLP4lG2GSAQaen1ZXBdbYtbVaRXSMoIT
	EvDBIu8QTcEi7WNVzdGTzEEXzYOW25FF/aacNqjkB+h78L5xPsu0cqUM5NOJYMGN
	ZwHR1gNbhhbNNLcMDVr01jNSFnnSioj4iEiBoORCUb8OpNnZccCaBKqYRyOELCbe
	/7wemTebMw3O3O/1KVOc07gJT9Gdu0zcwcilJN1g1yiPWNvydcwyjbVYcqRoaJ/O
	ZIdcymJKTwhz0Q8DC4OQmjM/2Szovdhs+zt0t654GI550A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g18183saf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 20:36:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1005450a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786653393; x=1787258193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ScWLcB/fMLJOTJ43EoCi0hMqy36OYwu47ooR2PxtXT8=;
        b=XlpSTKpSFMRXzmY2kRv10BSuHgk+jnoLGNd/Zp69eXHtkUjnORzv5TSDvtEdwsCrUW
         Ll3nP/Z48McqdHxrVJ9yJ9DX3QHaIukVYNOREBPv+c8AgN11vutC+xhEkDYCuMyq5Y4d
         z8an1h1J1UHzEuz+BpQa7hLi6B/3WNwX1ZNplkBTOs4WkNE73ZhOWA29Jsy+8T+U1Beq
         OZ8uQgYJflJs2a5awIPK1phNmzAc7w16ZndbQb5ZLXpkHI1obvZVHCBMn7awVA3Aa8XI
         ZUD52xj9JLNOoqSMJPPeBdPpXtxUv5nIOqG8ySRCwsp4eJQL03NPYFREQNGBwU+vL6GP
         EBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786653393; x=1787258193;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ScWLcB/fMLJOTJ43EoCi0hMqy36OYwu47ooR2PxtXT8=;
        b=R+351Egcmsf65AOnsaedOpUeq6r9oAF5eHTVw+IFRYgC8FbHyGEGHMT0P6Dl5lLxm8
         tnORo8LTqHAwGcK69YIPlZx2eory2zrHkcmphhXTDwvebG1uY1Z0Fc3HL1fdaaXXUy8I
         FpcXq9Egp6qovqcDmnOlhL8dq6/WzJgjLrGTAi9Qaa6rIi2Hswh6+DQsxCQJJjKQR7zH
         SxstKJgQCfbICluB+1s3xc0o1HMmsNBMzWvMNFtsoen1JTUFgl0LOsO6+FT4+Nyv4YKc
         dmYTmetsKW0fVSFmyhKrgC+yTWr/EKPXp6v11ZI6tTbfPH6BQyOUSIz8uAFPoYXtrgAW
         IqzA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9U2J8+kl0Hz9z6jvBkrgiIlq5D/7qP2GNSApVFIAPfIEBVs2gyXLbfYVl/UECMCflhGhjonM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47JOsDYzx8KswjO4N+gxzihM7pM+/VhXdXnzTYwf2EPq3ccZX
	nVS9BMa2AohUS0ioVAzC3c6fSnewxs2W+BI6FYHaGQMre1jtO+jK6nvnYerd6qbnd4sREGIHMhR
	0OF1ZorxOdW+6y5020zoKYAZd44cm/Kn4OdxDM5T6uWqkW2m5nWl5aceNBFo=
X-Gm-Gg: AR+sD109mKYdIft4VxUo7RShAbmds3nMr75y+u5gBIiXHKkK7FYZXw19PtC9TqmL8dU
	i6YXYlnc/T21ask9be41WFs1y3TREuFc4bKKLx+pUwY8DXPvbxx1K7NNIN+Rdg4lrpZi2BDSFBf
	hI7H6xk9lshw6ZWWGc94kVcsVTwyxiQ54D2mZ6Z/cwCZD2O6kwDdIsL3lg3z6mWjF4qhJMTuAqF
	r/2+FG0etiK8RGq9D8PzAwOB7C/PeqECN2ogt6b+/o6CbsQXoIVjlmBIiC2kjm8hS84+5FqXPaJ
	6z4Xx6fZ0Bxz4t/qhkTLV1FPtt03pC98Qd/TyzH1wS4J/plXyX/kLHqe0CzMV0xcDmTLop0zHKE
	8cZj18p8mEzEtyQ==
X-Received: by 2002:a17:903:18b:b0:2c9:d8c5:d55d with SMTP id d9443c01a7336-2d3b00300b2mr5126185ad.16.1786653392629;
        Thu, 13 Aug 2026 13:36:32 -0700 (PDT)
X-Received: by 2002:a17:903:18b:b0:2c9:d8c5:d55d with SMTP id d9443c01a7336-2d3b00300b2mr5125635ad.16.1786653392076;
        Thu, 13 Aug 2026 13:36:32 -0700 (PDT)
Received: from localhost ([4.43.230.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb2e34fsm1884765ad.48.2026.08.13.13.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:36:31 -0700 (PDT)
Date: Thu, 13 Aug 2026 22:36:29 +0200
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
Message-ID: <an4qzUrK62-rN7Q6@lore-qca>
References: <20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com>
 <anybM_3Rdg8X8CMs@lore-qca>
 <20260812161038.5602eac9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zjnd5hJChYYzsEVt"
Content-Disposition: inline
In-Reply-To: <20260812161038.5602eac9@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDE1MCBTYWx0ZWRfX3Ddbuqi8ylNr
 84KjaNSwGNYsf3DBgnW6QVEoe9XRemXNgWzZchi3ml+HPupQbfjnn3IEInmhQkKm8x6pmKFbCE3
 RCpmAWhrOPIDRq08NRtVT14bwXa2Evo=
X-Authority-Analysis: v=2.4 cv=I45Vgtgg c=1 sm=1 tr=0 ts=6a7e2ad1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=y9u56/S6JbnHW3dtX7SsYA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=dAi-wvVZejihfqittbwA:9
 a=CjuIK1q_8ugA:10 a=Mqtxpgegto6slhnK0WkA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: GN-81sLCQkl5ZPUEbnJgXLyGznO6Ehyb
X-Proofpoint-ORIG-GUID: GN-81sLCQkl5ZPUEbnJgXLyGznO6Ehyb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE1MCBTYWx0ZWRfX9FDH8uZ2BnoT
 RhgFMOB2WBLJH1wdrA0B43vOQAxK0DaT0R0UhZlcCww7xg0zlpPMGa1QN4uu/dMc5H7nsERvwpu
 lfy7X6HgBG/Skvi8gEddajY3Zv/NqwRVqcUxawNK0JWpD00YIgiWYskpf3HGvjqJtMbYqFUdP/i
 GpufsgEFpG3ftshhurhYClE9GHr4Mx1WwK10SRmGgMi55yooKyCbDyVuVWe3L/f9HCGiSm6lAJl
 qwcNkYgY1YAbUXtolEFrNC2oLNuoxCakSW7lrJi00NP1fAUdXHB7xtSU4Pvs6rCdG/IPg5AfueI
 WdSPg6CtfNhGT36JRqm4dA+Ipl9bowrhL6HFtwnq+GoRoDzAWeAMHI15v/FX4WSXvnnxp5k0vNp
 jn8+kmIxLoClxukrESd9U2LXmFdxBoqNqN8ObR8JSH70rDhmzPamkzIwfar1hffjIi3ZOycB9ae
 AJdKDRegxpOGRoiJp1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130150

--zjnd5hJChYYzsEVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 12, Jakub Kicinski wrote:
> On Wed, 12 Aug 2026 18:11:31 +0200 Lorenzo Bianconi wrote:
> > please drop this version, I will post v3 to fix some pending issues.
>=20
> FTR Russell was trying to fix TSO in this driver too, before giving up
> (on us?). The direction he was following of clearing the TSO caps in
> ndo_features_check and letting the stack GSO instead of all the weird
> hacks this driver has seemed much more sane. But maybe I'm missing
> something TBS specific here=20

Hi Jakub,

thx for the pointers. I reviewed Russell's commits and I guess we have two
options here:

- manages all the TSO/GSO checks in ndo_features_check() (stmmac_features_c=
heck())
  and disable TSO/GSO if the selected queue does not support checksum offlo=
ad
  or it has TBS enabled. In this case I guess we can drop ndo_select_queue()
  callback completely (it does not make sense to me to always use queue 0 f=
or
  TSO/GSO packets, e.g. it does not allow proper mqprio offload).
  Please note this approach would introduce some performance regressions wi=
th
  respect of the previous implementation.
- implements TSO/GSO checks in ndo_select_queue() callback
  (stmmac_select_queue()) in order to keep TSO/GSO enabled if the selected
  queue supports it and at the same time do not always use queue 0 for TSO/=
GSO
  packets (proper qdisc offload). Please note this is patch I am proposing.

What do you think?

Regards,
Lorenzo

--zjnd5hJChYYzsEVt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCan4qzQAKCRA6cBh0uS2t
rI6EAP9J25F2Q4gh4miQLO8THVQ860oLdyW+dsFaeCCIgsuycQD/Y8L+jrNdnTer
JzDtEwYoeEhEuyDRElDyMFqQeZT0Qgc=
=TZyt
-----END PGP SIGNATURE-----

--zjnd5hJChYYzsEVt--

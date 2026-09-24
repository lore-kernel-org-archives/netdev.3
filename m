Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF86472523
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246406; cv=pass; b=IGFluuB7SL82UgBX4V7wFkg/8wdxmIl3DU6vQiGa8CRGYnRBpZuKiHn4knf3At3rwUMdyMt8pFM1TTls7rvhbHzT9yPYNLcUClcWIv0J0Kou+6L3YhBTwjtw14W3WRA+09ffytbrzuFFWyx9fNut8Q5QOqkeSf7ow+wyd6xmcIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246406; c=relaxed/simple;
	bh=O9RvXjEghXZD2/aPoY5H7v7za7lV7EhylGFxKm5DyHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wev9I74Ra0Gw24Gdv/WMssJ4wGvtIADEqQLEndJOOt3RUGt+dHXRFcP4h3zdzdGcqgQYDpl2fxQn6ISF2w77S7DnZmjG9Dfl+Bw5FAR7cZqrDrAkYMBPomWupIOeSUiULOsqc+4qXur/O8qUv1DVN5imgwP44VNBvnEUIxPSZpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y0XfV+Ke; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C6EWUPKZ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y0XfV+Ke";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6EWUPKZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O9PlJk1270581
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7o4sXqMEUD4tozolejNSM52fQJ7Y6v3Lm6hqHPo0dic=; b=Y0XfV+Kec5xWXhkk
	DaUZP5E8GRnVIGZQiZ+Kxi3av16QfNUGxpIcCRBbpU4qC273GQUEHplgzStWb4Lc
	ujrVJRZZbNafUvk1uPuJWWXee+i2CbcW4hAsWG7Ou3Cwjsiz7fVI/8YRlohnqBZa
	17n3sB5QPO3xFK3vRnNT9lFURJBQfCrc4RjPabLQZxR3X+1AiSK7xGYj2Obt+TnT
	yWUW7oRBNWkVvrOJMZ4ydfpAKXDih5G+wqJTXddF4JyWD8TPduuZ60TIn658bbCS
	lBCuc32EJu31A3L4hjPcmfj9ZBooxfYVSt/cBhdAaT4XwwW5jd/a4tDQQW7PDaml
	8ZvUhA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr90ajqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:39:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-395543dc382so2045538a91.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790246399; cv=none;
        d=google.com; s=arc-20260327;
        b=HEL8opZGVK5noYd10ZHTw6qudqj7lPCgl91uhajzgdDswmUumMBSQJ3+V/r27NrvHA
         IxKAZsqTTCsKDJn6RjRg6RW303ewIuA6H5LF3H5StY1aRRPzAFZQfIxEcWliOUZhVIG4
         XxUn9oQAzgq7LdoiFMWo1FMzu0fmM1wOgFSe9Xt2w1WGi/Q9NttWpps+RNuB/j/EBU3e
         jiiTNyQOPKcpRhLYUzpsZOedXYFt9HTq9Srgv8GLZALiVki3PmZPFBPWu9RK83MjxnVm
         J1SgAW0tanBbAToMYJqigMqBbhHr/pjF7+mZyWXDY8Fb/U3GlGam6jaGn+DxKs1MXJ2+
         tdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7o4sXqMEUD4tozolejNSM52fQJ7Y6v3Lm6hqHPo0dic=;
        fh=UHdwgk+jEdJLw8C99FiqthkxownWUirCPKl2ModXu0U=;
        b=nEC+cnCkPErig4LtJy0iufRMdPkjEfeLB1hWOeoH1nD/XQwJvaNyUpcqdhwzWdeDl/
         Zlqgdh7UdMKL5GWg/HjkWID0Ol5MyVG3I02Ot8gK1cWvD7kMqefdBjhTvsUBpurngbQh
         6IG8leXwKUjptFDa8pywLjnQUuJ/b9vE2FSEV5/+2CvwEQtMP2FLfIAy3SEyxY2qFY9P
         LwpwsA9IsVyQqVkjWmFxUvZalfLN+vZWYX8WHnxcaHSOeUmth/u4b2H7ThdPMGSEw3FC
         mmV6Lg8a9Lspx3NUQrZAdTaxL9oCLFyC4l9NLQohwvUy22uO1VXuKubMjC+H3yX3bCj1
         q71Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790246399; x=1790851199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7o4sXqMEUD4tozolejNSM52fQJ7Y6v3Lm6hqHPo0dic=;
        b=C6EWUPKZNM1EThdnciR/U9OxydXCUGw9ZYReELthg4Qnj5SMWZERbZmEnFh3YemaxL
         eS6h0B8Nt9iajwddLrKR8BIJXW0MuhGyGLWja+G485qGbJDJWL6dQxS6/ijoFSxnlK8v
         CxXSJDjT9iV/B8GtZBvpkNFFq6HwsQOTNSXY+AEvZE2OW25NTTLFuZ+xS0ZSOZtbyUUf
         ILxUEhGcjT/1KjZnTqoMi2y6KdPnXZufAI9AtdfCa7vZv4wBx+nAgHbrxiNE9IhY43BV
         BlaO/jUtuhAZj9QGXods+KHwXVPHU/MMAC8l0nKyEE0s2zpGFGW+RR6XJv4jquFpmGXt
         qChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790246399; x=1790851199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7o4sXqMEUD4tozolejNSM52fQJ7Y6v3Lm6hqHPo0dic=;
        b=Nbv+kFpA4ChIEP0xYpqiZvw1E0RRPxCuvw1wSpXwUcGp3p2sisP4c0Cq7aaT4+Ctwy
         jTAEW8Np9YVqj2+50PLFtyPMJ+d7uGPDyl7PWfdBsIsy96T1NtGpm/biJ47eBAq7EhDJ
         9BCDXD0W3f8quUN/OuN1CfR/zWalfl13lEX4KR4fayzdzvkey9pXZgpqowWqL3BF7i/3
         frObYFBhF6jSBFrLQnBvFHXJeOmdvxVlkabSUJ8thM+SWeletWP5optn9GuqNzL++vL3
         wv8c5eurpWRtwHA2pqm+y7v6yS3pq6xii6J2lTuFNSXvqkJdjBaBUAZ2nEEjcztvbBn0
         z/Aw==
X-Forwarded-Encrypted: i=1; AKwUvBw7hE81eAPz2z9N7qGBO9qGZNtoCnYNOG5TX7GXeDwsedZh4SyMWCAaCEL5S9DgMgs7p0BchVM=@vger.kernel.org
X-Gm-Message-State: AFuF++m31WDxC0vOv2ZU5UoUUpUTpfy6yfwqD+cvxVeXNl9dizkPApyf
	MJiNlCeSUd413mOHfb/D+uJUMtly4z/jNmkuXC+1YdvZ0PrMKSRJ2z+DiUCxttm6cVo4bqENety
	9ZS/7gqojnKk/aNUghEPM5Vnr3Obx5RUh5l7MHJIChri+PBzcA8NtdG6Or0Y75xra2CI7efyoBJ
	VAa19yPZFwAVp5MqrP2Af9oz76DOE/NyWyRQ==
X-Gm-Gg: AYBFou2q/KV6kidWZAmprbkSvrXLA+fa+5qf6muts9Fcn9MphKJ1b2jGnK5quIHdOWg
	ks13NKI/A6/63CFZs9cCxdk61cqFk+Joh6zfaNGhsWypr5PNGkAUwtKlYwUKDMqXZ0OvbUiMNE5
	jWhcEv1l1KVQNcH0Qyzighw+1x3gdd1g7h6jHS4FdK4nJJVrdADzXK6rNkOw==
X-Received: by 2002:a17:90b:5288:b0:39e:6c68:1553 with SMTP id 98e67ed59e1d1-3a09896c4f8mr1845409a91.27.1790246398843;
        Thu, 24 Sep 2026 03:39:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5288:b0:39e:6c68:1553 with SMTP id
 98e67ed59e1d1-3a09896c4f8mr1845401a91.27.1790246398385; Thu, 24 Sep 2026
 03:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com> <20260923084921.3942100-2-zhangfei.gao@oss.qualcomm.com>
 <828e6cff-79d2-4349-805f-cca927f7b908@lunn.ch>
In-Reply-To: <828e6cff-79d2-4349-805f-cca927f7b908@lunn.ch>
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 18:39:47 +0800
X-Gm-Features: AclHuK_oSplCB1cNSh3eb4xbYdUh-XZKkPLtPpesSmH8opQdf4f0pOgS5eCsp-s
Message-ID: <CAFkd8htx-MTOMFO1S3uZt_8wyL+qoOhb577O2MMYr6oJ9jc=vg@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: stmmac: support low-speed USXGMII validation
To: Andrew Lunn <andrew@lunn.ch>
Cc: shengchao.guo@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        mohd.anwar@oss.qualcomm.com, maxime.chevallier@bootlin.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfX1iUch/UZqHOG
 LXddEAXrpYclcu6L3IvqeCOtj2fosa5ACEp2k5jNpoRVBZLz/9de52ud5Iyy0Yc7OZbwiA5ErQn
 2OD5pVdZZIRI6u5pT2A5iUZj7wuwD4Y=
X-Proofpoint-GUID: wPEecKHu6N6xN8mRVxWxrO5M-nrgvRbh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfX35FlcdkP4wOO
 8MiFE/pBZzHFSsSF+n9YcmGARmg6E1i3kKrmWpulJP6xYuA/OH/yr7wrhA21jtqFSYw1HhZfz75
 SqUX0sHrPoRP3Y6ydQqnRqNrZYUH/sLR02gTQQ6NhixasAcHY8Y2g99c9NFHzAusmIdWp5bAqYB
 2jSohRoVS4UUesJ3k7EfP+0D8xSu50o87CxeXcR8QnRl0iozNlVMNrsY01Vw621KvAVbiqdtwbQ
 PmIJtaau4fdnlIR5JGs0MM27RO8Gv7Re8NCzfIsf2F4nLFOjvQ8VboEQNSd6dP3DAskDAnb2Q4V
 3uLRInOC1YR5+G5zIykeEn/9V05im+Va+e3wFyLM285aWSS/nEOeOcDbpFkse+zzCxAA/neBvKg
 +BCfchEwjODp+Q0Z/et8+CAOIOUNUxcQFCa6RG7IqNu1q9U1ub+ADFAoZ6Jwne9c7sKUhzsqtA8
 SykUAf37ImWgj6RkMHA==
X-Proofpoint-ORIG-GUID: wPEecKHu6N6xN8mRVxWxrO5M-nrgvRbh
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab4fdff cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=grw64qVw4vexnSpzSHAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240044

Hi, Andrew

On Wed, Sep 23, 2026 at 8:58=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > index 091c9b57388fa..58ca296fc4420 100644
> > --- a/drivers/net/pcs/pcs-xpcs.c
> > +++ b/drivers/net/pcs/pcs-xpcs.c
> > @@ -23,6 +23,12 @@ static const int xpcs_usxgmii_features[] =3D {
> >       ETHTOOL_LINK_MODE_Pause_BIT,
> >       ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> >       ETHTOOL_LINK_MODE_Autoneg_BIT,
> > +     ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> > +     ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > +     ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > +     ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> > +     ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> > +     ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>
> What does T in 10000baseT mean?
>
> >       ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> >       ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
> >       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
>
> Compare and contract with KX.

 T denotes twisted-pair copper media, whereas KX/KR denote backplane
  Ethernet modes. USXGMII is the host-side interface between the MAC/PCS
  and the external PHY; it is not itself a media type.

  The BASE-T modes are needed here because the attached PHY reports its
  line-side capabilities as BASE-T modes, which must pass XPCS
  validation.

  How about using a separate feature table for Clause 37 USXGMII, while
  leaving the existing table unchanged?

  +static const int xpcs_c37_usxgmii_features[] =3D {
  +     ETHTOOL_LINK_MODE_Pause_BIT,
  +     ETHTOOL_LINK_MODE_Asym_Pause_BIT,
  +     ETHTOOL_LINK_MODE_Autoneg_BIT,
  +     ETHTOOL_LINK_MODE_10baseT_Full_BIT,
  +     ETHTOOL_LINK_MODE_100baseT_Full_BIT,
  +     ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
  +     ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
  +     ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
  +     ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
  +     __ETHTOOL_LINK_MODE_MASK_NBITS,
  +};

  -     .supported =3D xpcs_usxgmii_features,
  +     .supported =3D xpcs_c37_usxgmii_features,

  This keeps the capabilities of existing Clause 73 users unchanged.

Thanks

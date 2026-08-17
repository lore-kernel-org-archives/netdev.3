Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C8275AFD
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994515; cv=none; b=oYg4MIyH29t1GKhedKcz7mI5nVgvudV53gb4eE2MLZYEzJ+lJYY+nsNjSLg7cnaszG955jkdrzfob18a1m4+PWJMK1rWPWRqd1aKOg7d254gNnezLQKc2Mq95ZnUpQBQMpPVI2kf0tv0bmC0l5aBVRl9iE70QXnT9lZvM2nrktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994515; c=relaxed/simple;
	bh=9RpO0E7J/lG3GpE8UW4LVLQwEezOvI/G3cQGwPU1fjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWTuZeZ9vqV22b4f6WFATB2E+kKe6A6GwJZU7C/9xOlNqPARzNbpvouT7vSTAJkASKJ0H8MCSDDPdtNE7Mssb9+544HvK0L808BXqs5rQ2WIBWe55XMQ/10KJtVDxK+DB0F2a2dUjr88MGoxIzw2LinBl9o7oqMJExV+icJghGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxUHy9pN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UEJLPG8Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxUHy9pN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UEJLPG8Z"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HISI7v2706778
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=l7cD7zJIO/Vbh810jB9n/zTX
	P+2YLhUqswVtiuzsEmw=; b=BxUHy9pNj+4euHlp6Ns+cS3KauA0vkLEqF4dw46x
	uNO6jKYUOW83vaS+EU0G3j3qAs2wqzitr8ibP1tXv2ByRmJ0bVbuzxkt8U3yrXcv
	/dQkHOG5K7W8HhSQRqe5e88bMI2wjpMu32wnSuyHoEeKzijMJD4564+mkD2gWNVJ
	TjzsbHfAnfg0qIWE7CZMnSwCQBOGrPBT6772txMcSdJ+16AauKuuOSwv86YVu/Pj
	Wk6M1RO8839RZ2e4aXiZ6PbVT8swGXqHkxPu3DJnr9uNUkM2bAlKL5Tq+fHU7dXK
	HtCo4Hu5Nn/f24QdlB7OcPYn0g2/qWtH/Trjzog3x6AB9A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xb1jrsf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:21:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so2955264a12.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786994512; x=1787599312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l7cD7zJIO/Vbh810jB9n/zTXP+2YLhUqswVtiuzsEmw=;
        b=UEJLPG8ZjEB7eTHtm7m6rlEY183QjDqfTrWW5KFQhWN4/ri7hdHBe2WWrxXppjd7Ph
         KPaLYJ8ogVH/YHrzZjEDpwnlUWU8pGMO7Nr9kJ7VboF8YdqBhWzAUJodzy/QwKJxpurO
         Xk3I0RqDmBZ/QwrI6AzArAtMHxH7Pg24mOdQ1/JELkY2ZpNbLGLPjt6KWND53s9LLLU2
         sAirPvAx4m0Vz/Ert9tvcSYYbfq6ogZZuwZ5LNnCjE2MjaHspFh9sWafNDMyYqw6P1Dj
         wwDPaMA6Yb93ujc8m8vtbaT5geQIV2nUeiUz2DuM8bgV5pdjLqnw9GXI2VWGTLjpJbu4
         w11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994512; x=1787599312;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7cD7zJIO/Vbh810jB9n/zTXP+2YLhUqswVtiuzsEmw=;
        b=pAYBFCmaIirH8VemfETbVNLWPyZt0ua003h1KVH/s71OE0v11gBGzvmHGGWAYw73JF
         HZL4oGMeX7BOsQgR20IXAJMjrF79yNWtQJFbutZ7RQMMWLmFCLKRHkTQVqFySvoIqpXK
         c1lkO6RJOZNO3NFaeqKz+LYSRhA2q0Haxcl3Ox4rOz5XSocGBN4ZLW422uFArsS0jcxZ
         ReN1dFX9zOWL/J3QDxtPkVDzZmyO4nsYDpahva5hgpTxLhtPEuqNqsjojvdNNyqVekK5
         ja8ZrRaK7IWdIEzSPXBtnykkdx2eMe+p30thJ0eBQ0epCQhCQextST9vFLpX2MkbxPLr
         VSqw==
X-Forwarded-Encrypted: i=1; AHgh+RoK1EmEk9BaOIf0ou/q/2LCc6HGuYYjeUR9DBMV6xehL2MYcPZKSzOlbpmPMWpR6JpJiI2XqI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUFto2Qj+PYgs3rM8Fcj91+eAY06WZ76re9SZFsrMEdVy89qpz
	bxzLsMKpx+BNSH5237CmNwzuC7HCWCsQ+Njb+eYeRpY+dZ9vFSgyMQyGSE2GZqOV3i2ZM7aYrjD
	CCX93PeuMs5wqOpJf2q83tvlkUWLHbvSc0u7R683Oc/tXG9nWxqqOHz3Bmig=
X-Gm-Gg: AR+sD11vE2hN0Io83htv/U3zhRmhxrqQ6vcQ6RcuUwC9zhfLlcgw63DSVzwxyPJMZD9
	8NgkWXBUMNoWGlzao9KvpwAVTB4Nxjqk9RenE2jywkaB+FoTPMFQNxNIw16xhVK/Lz25r++MmJL
	+JyUR0bbrjcy2HG+em5B6Fg7tdIz5M1/pmNSE5pSmzpUf+FYUG2QNAtEUTMSsCFR/bk6NdKM4Kh
	2Xpib9nLEofxF+kEVluZLb5UYMPYfpcjPuFmytBW+Uka9fmfo6rCL2wK3OPMUV0CJoUpxpFNBNU
	VazgrB/zm/9lbOXBbkIaf325lqaKqwSvhtlp8gACZRoE28BLi8mQ7umHEkl0rZ3t/PKzpNz40LF
	WauK3r0kqlMb3+4YWcpt14+KMCVwghsgO4TET+SSZ0C7YO0Ee56mGlg==
X-Received: by 2002:a05:6a21:7a96:b0:3c3:b57b:6459 with SMTP id adf61e73a8af0-3ccda403569mr2887258637.7.1786994512168;
        Mon, 17 Aug 2026 12:21:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a96:b0:3c3:b57b:6459 with SMTP id adf61e73a8af0-3ccda403569mr2887177637.7.1786994511442;
        Mon, 17 Aug 2026 12:21:51 -0700 (PDT)
Received: from localhost (syn-076-081-086-222.biz.spectrum.com. [76.81.86.222])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141530793ccsm9326393c88.8.2026.08.17.12.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:21:50 -0700 (PDT)
Date: Mon, 17 Aug 2026 21:21:49 +0200
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
Message-ID: <aoNfTZbXWCQFjtsn@lore-qca>
References: <20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com>
 <anybM_3Rdg8X8CMs@lore-qca>
 <20260812161038.5602eac9@kernel.org>
 <an4qzUrK62-rN7Q6@lore-qca>
 <20260813172156.0243cb7a@kernel.org>
 <aoJwbQ-v--cTcysz@lore-qca>
 <20260817094140.0e92f54c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R8sUz6w0t/9s4Rjn"
Content-Disposition: inline
In-Reply-To: <20260817094140.0e92f54c@kernel.org>
X-Authority-Analysis: v=2.4 cv=Ua9hjqSN c=1 sm=1 tr=0 ts=6a835f51 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=tSTSPR48TLbTv/DgUuj29w==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KhV_WtukMbZTWkMfzPsA:9
 a=CjuIK1q_8ugA:10 a=qldvxho5sSfUmWRlgdwA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: rFPRDtyPmApnEvTJgo3mmkErhyJ_erBo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0OCBTYWx0ZWRfX7OIbc001KyuA
 LWuzeRQVvZM/caz4Vy+duZ3kSv4bxmBxB2feL5SarKmHkcnhRWbFasxx2W0G9+4i0ffw+V4R9qP
 kgnV1Ki13gdnoqBkDvVRpWDTwIadChq1qnusgOh/yG9GPDs41SET3jn+XMYIE76Y2bEwCv38ZSs
 jIs6xtB/81/V8FIOhUdl1LYdMLdcH0Zds1zPdJzhubzqfyZdvcqMGp3m0gOcoUoUfQNLAf6vzSW
 Fdc7IDWgqaUvfCsOy8+Px1mL2QO9FMadOZhFmeXO8kruKVeLMwJ8uTX/cvx2gIqfr7S90XU2Tgi
 quNOkZJt0paKll+LqRVVhw/MnX/yMrUEpKAr/47kV8MEE2z9zn6sy/3dDwUxsgNDcF19ol+5cwd
 Q+ArAWWPpHRIFoTgXhQHUZpt8M3VU0rXof2PX+KFk9N8ATQcVP6D6xH/og/F7csE/2cLvQmnD5O
 LJ52ZTOSTntLa41K5Ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0OCBTYWx0ZWRfXyncWmTOyVqId
 NEppRqLfiuEhc+LjS4nbRc+3h531HSnPU4Up7Efvl9ANp1/vK+tQvkM6/6vfr2WnEkMUp/1L4GG
 mVhdHguWK8/GQhIYkmViC2Mhgrr6g48=
X-Proofpoint-ORIG-GUID: rFPRDtyPmApnEvTJgo3mmkErhyJ_erBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170148

--R8sUz6w0t/9s4Rjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 17, Jakub Kicinski wrote:
> On Mon, 17 Aug 2026 04:22:37 +0200 Lorenzo Bianconi wrote:
> > > > thx for the pointers. I reviewed Russell's commits and I guess we h=
ave two
> > > > options here:
> > > >=20
> > > > - manages all the TSO/GSO checks in ndo_features_check() (stmmac_fe=
atures_check())
> > > >   and disable TSO/GSO if the selected queue does not support checks=
um offload
> > > >   or it has TBS enabled. In this case I guess we can drop ndo_selec=
t_queue()
> > > >   callback completely (it does not make sense to me to always use q=
ueue 0 for
> > > >   TSO/GSO packets, e.g. it does not allow proper mqprio offload).
> > > >   Please note this approach would introduce some performance regres=
sions with
> > > >   respect of the previous implementation.
> > > > - implements TSO/GSO checks in ndo_select_queue() callback
> > > >   (stmmac_select_queue()) in order to keep TSO/GSO enabled if the s=
elected
> > > >   queue supports it and at the same time do not always use queue 0 =
for TSO/GSO
> > > >   packets (proper qdisc offload). Please note this is patch I am pr=
oposing.
> > > >=20
> > > > What do you think? =20
> > >=20
> > > I don't know this driver, or how it's used.
> > >=20
> > > From the commit message it sounds like "if the packet wants TSO and=
=20
> > > the queue has a scheduler enabled - take the packet to another queue".
> > > Presumably you know why the TBS is enabled and whether the packet
> > > should or should not be going to that queue in the first place if
> > > you're sending the patch? What is the use case? =20
> >=20
> > Reviewing the driver codebase, TBS and TSO can't be enabled at the same=
 time
> > for a specific queue (TBS is not enabled via DTS but it is hardcoded in=
 the
> > driver). Moreover, for some devices (e.g. dwmac-intel, dwmac-mediatek, =
ecc.)
> > TBS is enabled at bootstrap for Q1, Q2 .. Qn, (Q0 is never a TBS queue)=
 while
> > for others (e.g. dwmac-stm32, dwmac-sunxi, ecc.) TBS is not enabled at =
all.
> > The current codebase forces TSO/GSO packets to Q0 (since the current dr=
iver
> > guarantees Q0 is a TSO queue). However this approach does not work with=
 qdisc
> > offload (e.g. mqprio).
> > I think it is clean to just move the TSO logic in ndo_features_check() =
and drop
> > ndo_select_queue() (previous option 1) but I guess this could introduce=
 a
> > performance regression with respect to the current codebase (we could d=
isable TSO).
> > If we move the TSO logic in ndo_select_queue() (previous option 2), we =
could avoid
> > forcing the TSO/GSO traffic to Q0 if the selected queue supports it and
> > at the same time avoid any performance regression with respect to the c=
urrent
> > driver.
>=20
> Sounds like we don't have a clear understanding of the Intel / TBS use.
> I'd rather risk introducing a regression for them, and have someone who
> actually knows this system help with the fix than accumulate
> incompatible workarounds.

ack, I am fine with that. I will fix it in v3.

Regards,
Lorenzo

--R8sUz6w0t/9s4Rjn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaoNfTQAKCRA6cBh0uS2t
rHucAPwNAt0gkFEhUci2GLx+gnpNwFwKJi7Sb5fWvEFWhLzGDgEA16wWdP80EihR
RWpRu6f5NX+XwxLo8nqNpJdEzwzQAQU=
=BORM
-----END PGP SIGNATURE-----

--R8sUz6w0t/9s4Rjn--

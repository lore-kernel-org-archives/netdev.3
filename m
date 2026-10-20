Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502279;
	b=Jb4LrvXrwQriouGRL3RZHNPrQuw/v4rnWriZdv33BqcUZBOxwfgBwA4ZfFP9F5LPSzk/
	 ZNWh2hKB/wkx/pVsVDUJ5Jd7ckyNT6Ae3OMYyP9KG9T+xGhbVVYvZ7qqk6nXHZxbRCHbF
	 QgZdt10UHFBnTT9st1fBwBllhHhgah2jI+K9Xwo3iD8PpB0HCgXLJ7cv7gg2DcZZZQG8C
	 75yfMW+gPsMVpbRaGeX3QxCWK1MyU4DfNmWgv1340U648jZFaioHkYkbypBNgjE/fyMMo
	 0mBWsN4CkOcJonIVKKnmyT/MPdVLwgUmFBR3VuSRxGPDcbZGOBvwqp2gyboJpKyPpOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=L1RqAEfTuGbkvUdAUwAcy8yMPvcz5IhXkDHeJXVKQMg=;
	b=f/kryzVgWlBydC1/TP+J8NLyYrlJP/GydYIXDAOefbbBoX4r2tc6QkyodrO0ajguoB4h
	 wO/eYmj30BpxUOckU9+mUN8oZfGIVaupUOhqS76/yT4oaQd17g/cxjYQp9j3LGEDZq0cE
	 SIHxjf7yQHfvWWo3ACBPwGqvaUSi69HrRmHCCIhU2MuNaw+hls8H7evPbSVMXH+JMPsB4
	 ET+/yR8yWd3p+nBN1g2n0PYTKH3GoYm61PdpcELoPkQrIO2ihgZohyauDOqDm+bWP9nbY
	 zcmXgGrGPoxJ0g0EYbXtejkMz5b4ggOOimcmfqa0+k+Ll8lx8o2amb6xuyi9dqxFIoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bl9Y6qAB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dQ5qnD5g;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCE606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CBCE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bl9Y6qAB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dQ5qnD5g
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDAJTu2214644
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L1RqAEfTuGbkvUdAUwAcy8yM
	Pvcz5IhXkDHeJXVKQMg=; b=Bl9Y6qABYgqtoQKdJHCs5a8sTn62iZskwg7QMeGc
	GCkh7xI6U9HoZRs+U7tPz9GDgH6zOUeA1Pbi5ysDD+6eaYqL+lcSu7NKK6G/SdSC
	lHGVcfJEW0l/G2f8m2S9z8ZHNWY/fwApnhSoGhVR5p+VDaNO2z+F4vZHkMVpBAnn
	ljXT/lvFInhxPmR6jsHemw/8okDM6Akx8i8e5Xg0s26YLDQgh9JMAUZ0Om2dGPpR
	H8yokCtISbqgiHZgAevMNbdrr0BTms/q59poNlWRNZKT9Abi0ZMctXpA+cSpTXDD
	y+d5uso3qLhrn6/TP4KfkOeEKo2DW+eVOcWglYqtW5FKYQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nthrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:17:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f322ef7d3so581196985a.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502275; x=1793107075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L1RqAEfTuGbkvUdAUwAcy8yMPvcz5IhXkDHeJXVKQMg=;
        b=dQ5qnD5gNly0auPMERAxFVKFT7ZPc+Ayj53OePcXmM6PNDJEOLs7C/Hl8kq1TbN88o
         81isYgWkuIahO3uy7NkT2gRCfUMM9zrCjye+Y5roDgn5W2giQVTwCknjrSr04mWRQQEE
         Iawwjc1NyB4e5BehwSusuf0ZfDDJQIhze16j+tiPaRokZybylCgzyD7QX7nqIAPfmQl5
         RouXVXNmTa2Zign/47bqC9Etv9PO73MgJE2Z6QLfXgR7VoNwuTMLACasBdXhYEWwg2IJ
         rO1jDhafOyYyP/WVXvDIQZk7pREJRRGuphAbJrNOctlrp28tLqWSvT2IweP2uvgCIbKk
         q99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502275; x=1793107075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1RqAEfTuGbkvUdAUwAcy8yMPvcz5IhXkDHeJXVKQMg=;
        b=TQXDzpDgKDnMxlclMEzGsSzG+tlz+Dj1p44aHYdcum+jSO31MOumSNf6Nq2Ac4pkNu
         MzcX45/stBs7+kAQqNmZirHZkGRqunnlyIRNdqXwN81rVRuy1KjwkYM4zjPAPxFjTeqx
         X07SZ2pACC2+E2AbFTbhZcZ+3m63x4gpVSVxRqwWhpWp4XvBBfbCpdW0YEgpfFAgVpZy
         YUlxLjx8bmXkQWW48DglB2qfoh6hZJ1wgjbnAV81znpLLQEmJE9ISwSwCbjSrM9enBi5
         NmgX8p2SV+Rbx9ttpj2uGBUwM4asf6L8GrSzH3ecYLNyQ0Fac4Qi/kMsNYfuQVD/pmEs
         ixxQ==
X-Forwarded-Encrypted: i=1; AKwUvByI7mVui7c8k9thKpuDpFu4/C6LVDBe8yqsd6hFxPwTjahwlCuLSwfch7r1csdWPFWKgrYOrrY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHX13f+ZThT8ucK/G8LH9XFAWaj2yM7kUK0fclDz0VWw6/kuDg
	RFewcCzL+3yJyjtGk9AKe21OA7cRua+i9oeYQdAb+hcgQl9v4jVFfQk7hD4E6KDBv9cCpWx+iWv
	dcjZvDCJHtCiTU2GTFe7EHXoWP2K5SBYx1J24bAjgLQ+a7KteGQZIiYljyQk=
X-Gm-Gg: AYBFou3nowj72959kkDkQPGfZzQzYRS0R1kh4TsyPQnQJXqROnV6r//PO9IrBaE4xen
	xK6ckWUUGKcbyKWuj0tZAnkYc4TceSLpo0wd6XoUuKnI/yKBqDXy5R7BUFVZyxmhfJMZlUgGIJQ
	PZYTwzAkt3TbwFyMvJd0kfEomrODAFAWgV1chg3j5xyUMNHWHRlRDXWdbAgFAlGBl45jpdp18Za
	FsBQui1/Fg/SQRA4nbl7rNvRh8wBlhHdlJx521PI5VDW9+Yu1ffpTSGARYySf6UmbKcytbk3EuV
	KnNV5ClCijT77p06KXgYPsDOHf3p3lmLcFgIybi+HelwskH6jUUrBlfl7+n5wfBq9fI3f2o53VI
	i7ihje7zOfcuj6Q==
X-Received: by 2002:a05:620a:280b:b0:93f:1ed3:a9cc with SMTP id af79cd13be357-93f29ceec2bmr1774236085a.17.1792502274425;
        Tue, 20 Oct 2026 06:17:54 -0700 (PDT)
X-Received: by 2002:a05:620a:280b:b0:93f:1ed3:a9cc with SMTP id af79cd13be357-93f29ceec2bmr1774228685a.17.1792502273730;
        Tue, 20 Oct 2026 06:17:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d817d8bsm5401884f8f.24.2026.10.20.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:17:52 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:17:51 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, maxime.chevallier@bootlin.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload
 for jumbo frames on bugged cores
Message-ID: <atdp_0QJfjR_H3U-@lore-desk>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
 <179190522792.434549.2113659711683261245@kernel.org>
 <as5PVATLFOcTHbkV@lore-desk>
 <de6dc65e-04bf-40b2-b5e6-d7035d2f9b7c@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VlBw4mY3Q/Sm2KIC"
Content-Disposition: inline
In-Reply-To: <de6dc65e-04bf-40b2-b5e6-d7035d2f9b7c@redhat.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MiBTYWx0ZWRfX07ZyRuMvEuW/
 lcr0eIARHqSPEv4iur7lmQ7yk/5nsWbX7A8OMoOJucPcFDOlAzwrzv2tzVlZBl76YIVU714cmXu
 VbOuZrKpyqqYzw8/WqXUAu6RUdg+fOo=
X-Proofpoint-GUID: kefyT-yQZSqH5ZlXeWiDZEdxYblxjr6I
X-Proofpoint-ORIG-GUID: kefyT-yQZSqH5ZlXeWiDZEdxYblxjr6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MiBTYWx0ZWRfX6M33KYWvuczb
 R627UcOytUI85eMu+L943egj28GteoKfk3xJWd4ML9QgZpa3MnYIOM77hV8QqzGQBQXL0fjzvrL
 DHdfxm76pXaxUiRh2DvY+alYl8ImgJCDXMBWvM9vB8ccfU1+igcjY6JXwntDRqtVeHL4ulNgzBu
 h3eJ0/wdpR9jHDgfgJ6D6R2t4xRpP0WFWvabfRh6iRUQZC+zploZ01QNxaRyS4Ks97NlITauJVL
 woNhYixjyLOGhfo8CkKK+l+/yW4txT4QdZiKQ4t4gcsotkBhhR4dgz07sAxbrWKwvbXmGzQhK5F
 rHI/WwwKDsg81kWDHM3qLH1Vz5NyP7aCQ/RqsI4f9wgSH8SwcokGKimxRoeZmd6+Ay+F5xPkOM6
 MBV0v70IQ1Y+qVTn9b2SF732yP1iNR6RyFuDRf8tPGOUwwGM/DrJnl1OJLn+G16U5YDluYQZk/G
 d6ePJkotrt9ONYcc1Og==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad76a05 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=xPDQizAfL9ec5cwQt_8A:9
 a=QEXdDO2ut3YA:10 a=cxd64Jjv5Ts7904Sr0EA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200052

--VlBw4mY3Q/Sm2KIC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 10/13/26 17:33, Lorenzo Bianconi wrote:
> > > Thank you for your contribution! Sashiko AI review found more severe
> > > issue(s) in other patches of this series. This mail is only an FYI, i=
n case
> > > you want to address the nit picks below when you respin.
> > >=20
> > > Low priority / nit picks for your consideration:
> > >=20
> > > - [Low] The commit message's premise doesn't match the tree.
> > >=20
> > > Pre-existing issues:
> > > - [Medium] This problem wasn't introduced by this patch, but
> > >    stmmac_xdp_xmit_xdpf() never looks at priv->plat->tx_coe when deci=
ding=E2=80=A6
> > >=20
> > > --
> > >=20
> > > net: stmmac: disable TX checksum offload for jumbo frames on bugged c=
ores
> > >=20
> > > This patch turns off TX checksum insertion in stmmac_xdp_xmit_xdpf() =
for
> > > frames longer than ETH_FRAME_LEN on bugged_jumbo cores. It is meant to
> > > match the stmmac_fix_features() workaround that the skb path already =
uses.
> > >=20
> > > > The XDP TX
> > > > path bypasses that workaround, so once XDP is allowed at MTU >
> > > > ETH_DATA_LEN, jumbo frames sent via XDP_TX or redirected into the
> > > > device would leave the interface with a full checksum insertion ena=
bled
> > > > on those cores - exactly what the workaround is meant to avoid.
> > >=20
> > > [Severity: Low]
> > > Can this scenario happen in the current tree? XDP still can't be used=
 with
> > > a jumbo MTU. stmmac_xdp_set_prog() refuses to attach a program when t=
he MTU
> > > is above ETH_DATA_LEN:
> >=20
> > This is actually a preliminary fix needed to remove the MTU limitation =
when the
> > device is running in XDP mode.
> The point is that this patch does not address any issues, no it should not
> include a fixes tag. I'll drop it while applying the series.

ack, thx Paolo for fixing it.

Regards,
Lorenzo

>=20
> Also a more explicative cover letter would have helped.
>=20
> No need to repost.
>=20
> Thanks,
>=20
> Paolo
>=20

--VlBw4mY3Q/Sm2KIC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatdp/wAKCRA6cBh0uS2t
rFmoAP414FEDjStL4n4qvHemK+O+WXPITqOkK0QE5TTAxXJutgEA+GNB2i9SNe2P
Jm3Rh13AJigugNCR10M7PsREpZKSwwc=
=zatQ
-----END PGP SIGNATURE-----

--VlBw4mY3Q/Sm2KIC--

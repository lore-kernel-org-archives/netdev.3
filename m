Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653662AD2E
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255453; cv=none; b=QmWVYxlXBkxRdBK4tn/QHDFWgEGpsQ5iAjNdBA6Dh/5oeTxDuDSXp0aiOsnRZme4XEcOyrxrLYns8p0vjEyAPgVeXduQDG4yWPkf3Mu4Oass5vgZQwALB0L1Vf5uWspDMJO5zpJXygGT1MiZ9gI4RAnj8u3KKw8QVMg1chUc3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255453; c=relaxed/simple;
	bh=LEbGtS8WmyppljlUHIFZla0GOEs+0aoAt5wsCaKPPSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWCDhcvs14XU++fX9zGpvNY82108q+os3CKCmqIqbuKbCll7lnQ0SE5gdsIJZiOmIcnyMMnd87uHzdhxpIhbdFsnEXNaCsaTY98OeYh5W2fc/+JLsf8OTNVaRDkBSkhUrBXRhBmyLPewk/Dc4TZWHURlSTfr6y0HZWT1NrtNua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jwUievlG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CHnjgurO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwUievlG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CHnjgurO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC51we2595126
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=arsILVgrBpwLtL9SX7rYgMeh
	d4uTdc54DY2C8hwmI+8=; b=jwUievlGRJPT2B4zZGab/WCKi2OT7Vehn+3TYe93
	/tCcrjNO3mf+qBgO6UZB8lExboU8y+akqZJYQAIvnYGYJ//fPQy6+E5oMb1i+6sk
	ExIESb5mzM7nt1QvBfTmDkKzhE9GHQDgTEje79BXwnr/9R2pc7I3aC0+m7/KhQYm
	OHFBx0WNijI7NsTr4ucNfNtVWQAUQUitGvQQCmFHlmsCbqTFkhLd6A+bVdZv2XLE
	TPnny9J+SdZZ9NYk+ATorfEijLsdrKGtS65RPrgHo6etrH+dorWVXlKIYfMXyGVe
	fkIbLSnVjiev+XTmR4azzeL+F4ICEct0onh+aMC10bEnDw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjgnub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:10:51 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97cb0a317c4so284731241.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790255450; x=1790860250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=arsILVgrBpwLtL9SX7rYgMehd4uTdc54DY2C8hwmI+8=;
        b=CHnjgurO1GHj0sJX2N/asu2Bpu1bYjl94dXIlOe45mIAuUZ606lOQNOWlzVqTsDSeL
         9ZQJffbwzO+lkO+TLmYiQSOyF9QjxUxgLjJXDsYqs9H1F4/cV2jGdjWihx0WqDEmgJaw
         yiYv+Oo4eQbxDaILYqANPqcpm8xYgbAQmw/H33VJP/LyjbEbzHH/ijJsLiv6Lpm+ZBgr
         KwOTLb14jjtj08GkxgTe/6FBB2xGYlQW431u//8S/JUK2PBmJQVbo49H+W6n/xGXiTX4
         5SL436OrODVFm73MN7Y9Qopb/vd3fBWB+FQMEJVti7fruJSOgVpng/pJ9yVxJWL8RRve
         X5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255450; x=1790860250;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=arsILVgrBpwLtL9SX7rYgMehd4uTdc54DY2C8hwmI+8=;
        b=iq018pQ5u7CVTuB5P3mFXCp4n1nXgT9hnFcqZdoo8kJAyGOb+sg1GUm8BZ1hJ24aNS
         EiFXgBv0cIHF9vK7IsbCfOre2rEc7ew1lxDK6j2ttZx2qjO9aPN1fl3rAGRzp9izi4CH
         NHHlr0H2n0jnCpMdbV8FGtLqvH7YE6cj4HkWFKhNUdbRvjuazPo/opGitGtDeiuQbaIP
         yFqND1SrLuJwtmobpcQgVDh+2gXGEC3aNBT2qNyta2IXoA3tzqoo/Ev1pEtdHR3CBuqG
         9rG9Ae5yMGUycWXFAmuYrFEt8CLsQYpHtMbyJRs8J9MrdeLHUrK9bnwaIBpKnted2cYu
         T1Gw==
X-Forwarded-Encrypted: i=1; AKwUvBxmru8l+WK3elSWKuYc5SLBKYD3sjZRHhobJR737E+HNfJSMixDruQEEtVijVkv/3JIEed/U8o=@vger.kernel.org
X-Gm-Message-State: AFuF++lHWWomD+hbxpOAaJsMuZZWJQHQgiboBf2h82+9j/HzGNfVc6bk
	SiC2xv46evHaBC7vOMxH9H3iXKuUgAnkPhfOTyuv16Y8oBlt3ZTZqFYoyR8IuO08ZIulFE2LoxI
	hpBIEw2gOPBX4bowUEMW119sxDYPPzf7yT0svK581KRlb1LkX8uPliixwJB4=
X-Gm-Gg: AYBFou0abIULl38+FxZ++7DE/e83dOndC98sNgP6jMOK7u1+LunjKMB9Tz9vjY5psNd
	PrWlYYliD3Zc9LbALPPMZb6I5kc5IgP3JMaWOGudpVxXAKo1vbrZUmGgZQSWUO94pQo9dUZ+Dpn
	qrMYz+gt3ATfw/bPHoAGu1w/8floBL0miOXTMKeaBDzEj/Zmy2fzRQ9N0F5oBu6fwfoRTx1Of2n
	qc/WKBUEFfXBKNWqK/Fjpk3GfgOypT1J3PZyOTWPaBnq5lfGCBeataDCKKQeymLdP2VQtyG9mju
	d6GdsBEanCDnJfO/S+Sgeo5k/6hg/kqAuYQyHgB2VwBBpC5l7+Dm2fnahg58AIOOD9duwQR2I4f
	xIFsi9IurgEydfw==
X-Received: by 2002:a05:6102:5801:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-7af1c99cf51mr986826137.6.1790255450147;
        Thu, 24 Sep 2026 06:10:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5801:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-7af1c99cf51mr986806137.6.1790255449373;
        Thu, 24 Sep 2026 06:10:49 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf99df60sm107231235e9.1.2026.09.24.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:10:48 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:10:47 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Message-ID: <arUhV90af6coj2IK@lore-desk>
References: <20260923162339.1375698-1-qwe.aldo@gmail.com>
 <arQ4dVkI9llhXCDx@lore-desk>
 <78724445-4c69-44fb-b82a-1f9275e37e9e@lunn.ch>
 <arTX2kNFGXLg7vdn@lore-desk>
 <8b3d8225-0d86-4e73-86c8-b7f644faef56@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhGvZqQR+CkuDMS6"
Content-Disposition: inline
In-Reply-To: <8b3d8225-0d86-4e73-86c8-b7f644faef56@lunn.ch>
X-Proofpoint-ORIG-GUID: 9W-LvXA1NUT37va_gUnHFp6IT-EmJXSy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfXySrfgfKat3hY
 jwVmAsuQ4497yCG3RIzR8WWQnCJINVsOLTidFh66a95eTBMHIPuW1tybxVQnlST8aXHIMrtrO1X
 rD4VW91B6UqbM8tSyC1+OfK4x65LvhFyZ+aoRsp4xvfdyH0ewvnHqnxom+c/IzQ9hQrV8qEWagw
 g8i7dGYPvZhfo+G58JRejwK1MvVFU0G9F1E7nYRKfCBXW9ureuM09u7ciii3SzXIC2KQ4hRHaUq
 6ncjk0u13i0au+gmeHPztjKDAAC8bxwnzI95R/H2j5sR81bZXUACw914D+C8TxKZxLzbaoehjQC
 fDEOiEDBrsNoEaDiNPDNYE7mr3Hqr/JjFQOTklbyK9ugIVezYWg/gHPziqeCkenyEVcgb/bIcIJ
 m28rn0noZLFWpoChD0xjGEm52P1++WJlYhkaGWN8x1hkPu8fKrh4D97m+JYTq/2nUO3Y5Kf6HPB
 NQ3Janaxh0p3TM1eQvQ==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab5215b cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=8V8mYWrpQfyZ0I-j8N8A:9
 a=CjuIK1q_8ugA:10 a=zS1Ju1pEN-1IdQOvjlkA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 9W-LvXA1NUT37va_gUnHFp6IT-EmJXSy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX/iCQZV6MAxVF
 9SJaU19WqxBfAmmV34I3j15/fTQbk56lMXMOENNg1L3AnO8LsJ2uFPevnWpcE46FjV4ceahCFha
 V7kymLrRtI8eYl5xRM3vSqLvmh++Qdw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240054

--xhGvZqQR+CkuDMS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Sep 24, 2026 at 09:57:14AM +0200, Lorenzo Bianconi wrote:
> > > > > @@ -5808,10 +5809,10 @@ static int stmmac_rx(struct stmmac_priv *=
priv, int limit, u32 queue)
> > > > > =20
> > > > >  		/* ACS is disabled; strip manually. */
> > > > >  		if (likely(!(status & rx_not_ls))) {
> > > > > -			if (buf2_len) {
> > > > > +			if (buf2_len >=3D ETH_FCS_LEN) {
> > > >=20
> > > > I do not think this approach is correct since, at least theoretical=
ly, the FCS can be
> > > > splitted between buf1 and buf2.
> > >=20
> > > We are talking about runt frames here, so less than 64 bytes in
> > > size. Can such a frame be split over two buffers? What is the minimum
> > > size of the first buffer?
> >=20
> > Why are talking just about runt frames?  According to my understanding,
> > this codebase (at least the one in stmmac_rx()) is executed on all
> > 'last fragments'. Am I missing something?
>=20
> That the patch subject is wrong?
>=20
> [PATCH] net: stmmac: guard FCS stripping against runt frames

ack, I missed the subject, but I think it is wrong, the issue is not just on
runt frames.

Regards,
Lorenzo

>=20
> I suspect this is an AI generated bug report, a minimal fix has been
> proposed, but no actual thought applied to the situation, such as does
> the hardware even allow it to happen, does it apply to more complex
> situations, such as fragmentation etc. The usual AI problems....
>=20
> 	Andrew

--xhGvZqQR+CkuDMS6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarUhVwAKCRA6cBh0uS2t
rMCYAQCnZVdVYwp4BlPYl2ifvd+7xlnUC2ADvKHkMNQ/jXTGOQEAubiTI6IBnWJJ
sv5VixPu2WCzvQQZjYfHjmwu4kWZRQw=
=IjrR
-----END PGP SIGNATURE-----

--xhGvZqQR+CkuDMS6--

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD13C061F
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075431; cv=none; b=uRb83qTNMWr3Mj2O5US0aHVoE3Q7eX+os+lo05XkWZX1j58trozfNtNDfi38ZS2eWgHokOFWZaxCCrk3cqhIbSpTGV3ocfhbATaHujCE74Cz2Xa1I70fgVU8eL1ZKpnCH5ZpD501WoKbb6AnQsBGB7YbXVj1ipmYhZJ41XmSgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075431; c=relaxed/simple;
	bh=M/I0zAJEPMLBymuryoqRmhRi8flVdbFTmfF0TrHzyAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAq2WU24/gWXIAOwyjs8kOoA9dqdFXY/ef6McZ46hqfQy6yPPpeKiWG9NmWtQsXU6nYZo2MnOIQAcIxEIogV06jRK62Iqm6t6WStKBmu5t1pOSXPjCzFLaXliZANUVKqnLBUyApIqWG3XzXXH9JmGQMIVHAuprUiG7dyYJL21bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mBm48ztO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZsTSEEy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBm48ztO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZsTSEEy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jTej2809317
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8Jv8ziNJlXPNbrImiv89bm0v
	lgkuGeTAZkaRAOPky68=; b=mBm48ztOA1eZbqumBtIsAII9V7fboMf1X06aeRcY
	qPnmimI85JtRl+STdR+qMyyTYhgpTTtvbnhHofL5oUApKe7B3YvjCVhtxTZnz/5n
	LjMnkDZtZXgtIDGG4GBudEfU6zsSGCps1gGb3AiYvxtlEAO0QZqih0gWmQce8/VJ
	8EOgDCCHaoWgDlPpou0bUhjWk9zZbq19XSp6cfvrxgQ/YD7Ugl6J0GH3av9oSJx4
	IcNgKC/WT3WCLb28dLZ1uiaOj3QsxnLOB+6jTScwQLHpqdDzDNmzIoIt4P3wbE+w
	KzUhiqlS1U8wpMd8YGpnXxoZOu7i3IAjF0XyvznKSe14zQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54u467-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:43:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb98809caso911153785a.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792075427; x=1792680227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Jv8ziNJlXPNbrImiv89bm0vlgkuGeTAZkaRAOPky68=;
        b=eZsTSEEyTq7XHTT//5TJQjiQTzfVhPoEo6stmuv5uBasR7dgX6uHWdPU0Ncbh6d8dp
         ZRxJP2nqNUarnPSfdQSs3Kmys6B1SsfmvNie6cnVuQmb5+q+5s854KS5J00R14/lqzft
         +QmV6Qf3FZ10Wa8VXyLp/bCuDObotsvPJr+XBWFwarSbRIcbIY3NeAkA0N6SlItQ52V4
         EjglB8W11ndLT1QT+RXZkf5+7H3RCZc+YtFc3GzFslSmcn857XXVVOXb6IkO4DZbyEtD
         vU5qlVX4G+km1gMc+xEXHyLK2RyBo06hysaGxwbTdgkeHtdWmiM6L/wPk6IFJDero+9H
         jqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075427; x=1792680227;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Jv8ziNJlXPNbrImiv89bm0vlgkuGeTAZkaRAOPky68=;
        b=zocq/LZmtBeJIV1DIFoGfjdFKtiwHUfTbI65+sKEsJUGXlF9wswuuJJd+Pk+gQinQI
         MZ2zDpRk4+gSZF2YWbAVQYYQKg5Oof4csbjm9EWxl6JSCjLbDuVkgYEKqPo2v5CvNjDd
         CMGYzY3VXNnBxMaZspc+c6PveZtgnfZzceTkx54fTICUXJOwIKL0ejOO6ATsU8VYATsS
         rfC+WS2hNAtXuy4NAiO1aJX/TBLylc/V0NJtKSQccrlP2Tk9toT2X1Gm2pSp3zGh/4wF
         o5WjcAnPM/nPRFWC0UMFNdd6Fzrti7I4KUjpkQwekNllLaoy/SCVCdZsssdUI/cN5qR0
         FytA==
X-Forwarded-Encrypted: i=1; AKwUvBzfpsodx78uX3Whu4pV+xwGBZNCxoQRHQ/lPxhG+BGQD05B0cLT4xC3Ha4bnebFADKuSTf4jG4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNSDhATkTuBCTQ92kFX8Qfq/yoBfrxOtVXHUqV2J962GsiDvFh
	L+bo9Rsm1SilxjCNpm7jfp68/B8BVyVsgaiEybBGmH3ifZJ7QE9PTnbDoPeaJsgoAXxLmxL9/rx
	xReUVL+JzUThLymjL6DZ6NiE9F/HbzgKbxOtROPbDr0e//iAhgf64Gpz6KXtKKHE7Hvk=
X-Gm-Gg: AYBFou2Y3WR0AnuphUMYeYB1aYajxyBjF24SIri4SuflReg8ujlGayhZOZis8dYszUr
	YvvKfX9jC+dKMYMWo9UvWbsiBqZZr0GMm7BaSogHmSSCCvHOLDUf0P8HCd0iPSDWmk7TxwkTN/W
	omDNcBiECE+fY+SnwUMnvPzmzufdZS+1WfPYwPORHX5scGdBkpHbp0QWQcGzmXRXG9wVbcZ8SQD
	8X5x9oOIvujpVD5wE3niR0F7OzyRR9BqqlYCuDKKN9sLgd8QEvakXzo1j1G78qgBH1qblYbACRB
	FPPgFekoBbe8RQUHPHq3WNu6aat3M8TZa3ewIdXYLE764P1zeG37la30V6IMpfYtqVFxT78FAS0
	nitoXxFZeLiH6CQ==
X-Received: by 2002:a05:620a:4449:b0:93a:17c8:a1e7 with SMTP id af79cd13be357-93ebd263d3amr3069401785a.44.1792075426908;
        Thu, 15 Oct 2026 07:43:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4449:b0:93a:17c8:a1e7 with SMTP id af79cd13be357-93ebd263d3amr3069395085a.44.1792075426160;
        Thu, 15 Oct 2026 07:43:46 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df758258fsm3327631f8f.17.2026.10.15.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:43:45 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:43:44 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v7 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <atDmoPpmzgRoaOWj@lore-desk>
References: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
 <179198374828.320699.17103999780938670424@kernel.org>
 <as-Ef22VEKQcZ9QQ@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bkfl3mL1k4wIuKjB"
Content-Disposition: inline
In-Reply-To: <as-Ef22VEKQcZ9QQ@lore-desk>
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad0e6a3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9R54UkLUAAAA:8 a=zPHIA2Y_rLiAKEAzPmIA:9 a=CjuIK1q_8ugA:10
 a=hbj8jUmztM6ql5xhcn0A:9 a=PEH46H7Ffwr30OY-TuGO:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX6a8j1xebDMaC
 s4g1Gy3FzG51ufZ93wUMAqXKokYEr+c0olhhu935ciziQRuqIl7YWkbN6XBbBJT5u9JcZ7S973z
 /FEWOvl1VfKtjP5h+cnMPPRImMPR4bEIowSOHwXf0RIcVooyHepi86cSpEtTdGA0OQhnsDozQbL
 6w2pnTPMCxzbGgGrHC48xSIGoHq5+1OE/ODWeH/bcDtNkKJerqVQlMAzZwArC7Qm1AgqMW2Olss
 8p8us8nKqcNGMOqCpnDLdXL2tCNx5zdajKIQ1u9dsqQSvfTbVfTQ7yMc2p7k2j8PlpM2DYo+wIH
 i7RKr9FLZpM3xFTXnGToAwffY3X/j6O+3VWLWLdtTbGqUy2Bk+pzeoDpufmmMDgP4tEmC8VsnwF
 aYog7GlAlo7LO6O+71FQSrdw0u8ZmpgqdV61OWvzdpoYlJllMaz3Y6DZtd3KNQzoadupgGeUYJx
 R4KsTZRg/a+TUq9koFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX8OgOe31xmZR0
 44uSqurAwYGa45hmXCafG7LlD8bM5P5mERhCQZnkf3JsY589w3FNpo37daE11gdzOoQOVldkWqI
 vqqHwDPhqpqSVgyccxTcuKN5C2nRJEI=
X-Proofpoint-GUID: wQ5iCEvbwCyL4cEHROPCtu_lvw8ETaKx
X-Proofpoint-ORIG-GUID: wQ5iCEvbwCyL4cEHROPCtu_lvw8ETaKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150058

--Bkfl3mL1k4wIuKjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Hi!
> >=20
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >=20
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
>=20
> The issues have been reported by sashiko.
>=20
> >=20
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
>=20
> The issues are real bugs spotted by sashiko.
>=20
> >=20
> >  - What hardware the change was tested on. For driver fixes please
> >    mention the device (and if relevant firmware version) used for
> >    testing, or say that the change was not tested on real hardware.
>=20
> I tested them on a Qualcomm RB3-gen2 board.
>=20
> Regards,
> Lorenzo
>=20
> >=20
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> >=20
> > The evaluation is done by an LLM so it may be wrong, if you think
> > that is the case please reply and explain.

This series is marked as 'Failed for Unknown error' in sashiko-nipa:

https://patchwork.kernel.org/project/netdevbpf/patch/20261014-stmmac-rx-mb-=
v7-1-5d2d70f052cd@oss.qualcomm.com/
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014-stmmac-rx-mb-v=
7-0-5d2d70f052cd%40oss.qualcomm.com

Will the AI review still take place? Am I suppose to repost?

Regards,
Lorenzo

--Bkfl3mL1k4wIuKjB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatDmoAAKCRA6cBh0uS2t
rAGPAQDOR1UCr5HtCIe9Nw2G2i1dLH5T25axrA2WLWy1e+QNnQD+NEiaGtvnHBvQ
+ig5hO6JzXsfluj3NPTkahcQvLfiUw0=
=PWr9
-----END PGP SIGNATURE-----

--Bkfl3mL1k4wIuKjB--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783204;
	b=mrBkZ0GI04WZQmWdfvtSWdI8HXa7+O/7h3Tq4x9p9CcfiH3D89wjfwnaHMJhvPlMZqpo
	 UF+eqv6AqJhMUrhqB/u2l57UZF0RDMPdJsiBPcS8FNYvEbMw9R9TD+/s9IQ5Ro/oRRrwp
	 JLwhS/5I+DIs8fDvnP7Th9ySFz0roBdd2o0i2UWEiiFPM9+Rcq455UrXfoHJQmK22C3Rs
	 SDrMb6arMRvb6m1c6f1cbOvUbaH/rF961v7KoNHr6e92Uu1oltrHQ64DaEYdnKGHhJt+0
	 0AL7z8oL2J7EgglRXsFwjXHFU0f6/vKCoGvO7wS5XUPIyrKTI0822tKp4qiH/TJzBoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783204;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gQa5DpLs14qhLqK4W9xlR5hZAyauWHs/0OTG6Dba/a0=;
	b=WkwvPseUkujZXg907I4pf3nm5/hbYnmE/odbpe9s/x55T/haJWkS0l6kEe4ubbicQP9v
	 bPMLaEPZ+boIt/SeeZCpmJxvm9SDh+FgmXupIDXXrlgJMm7gJdWokcJRlGZU/jrB34mCp
	 sWtAdoTVxXh/RLQ+9Py3PbMRKnG4grKw0ArLjTEDuSWvyrCzGqKrukyatrNBC0MohD/0u
	 +aNLpqd5vZfAYXXj0TnhDFen6Pq66mHCN7l5ayYgz+yiU+gHdpWb4mFzRnEoGiFVjy5n0
	 TJJJ10/jGZN7kjm96nlzGPImU1BPF4llKtL/6zvvPFUCWhSEjiWJy6k0Kyu2dPr0Y5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aUPH3eH+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FpN3s08e;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85056606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85056606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aUPH3eH+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FpN3s08e
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KfUp1263941
	for <netdev@vger.kernel.org>; Wed, 4 Nov 2026 09:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gQa5DpLs14qhLqK4W9xlR5hZ
	AyauWHs/0OTG6Dba/a0=; b=aUPH3eH+W2Rx/McL8mFEKQtohjYWBhIjjM4jN0V3
	lyzDJthwnyBW+z5luReBNvb+k11Vl5fHrUIkQrfSds5qig2LF6mqSztI6vLyf278
	uBnaLbNu2qPW44M2nAz7rR9c/ILi/7JpWxD43G0UXC61H3clDbvRwuOcFAqdYhrS
	hWB7HXPXiWJ+7CpM8lo58KIBIAfqwQCPss72x9cJWE6MOwsd9e2lo1++u9WanaFI
	XPvJiAN80P2o43AW08gbzrzQbUM2gxcB0RodB1EpZnIcG/w/zC3OEyWaXr2OMRVE
	8xgw9LqeB1TjBWM/qUS1ZVrl6+f6TYqN0jUMsGfYKAjujQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqjubktbf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:06:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so131537085a.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793783201; x=1794388001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gQa5DpLs14qhLqK4W9xlR5hZAyauWHs/0OTG6Dba/a0=;
        b=FpN3s08epL+CLggmbryzfWraDB1hBUicZZcmW5d1+/u/phKLA+WmyEMXgfgX74SUmb
         C3fA4eS11fmtJ5RRiw5YCcQMr7cOMYCuy2P/vqu7bwQat0EBOT7Vthf655vW+Ur+5E4C
         KDU36Dfqo4YOHp9VQkLFFHFRbcol0V8SIaf1VLF6Cz0N/agOYqewdmMbfaf+YmSgUxhK
         O80E8chEm2iENmKDAd+8jQCuFqUymvnI4FP6j3I/MabfzFIA9xos51t3V+tvHWKS0vnl
         RZdgVkisLAeDRmWA1FBf0dEN8lX/xd+hUF81Mgkjp6DFFcrXQSiKosjoBmqbJ6/3lQc0
         oZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783201; x=1794388001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQa5DpLs14qhLqK4W9xlR5hZAyauWHs/0OTG6Dba/a0=;
        b=ceh+drR+vXfuw0ho/U1NnSjx5zvKfI+YtshuaPz2aw1FhQdknGmMG3HGPDc3GnsF8p
         q2Bs0LoEvhfzxPOJPtA9RvPco2A4RHI5jcCtgvh1I/Pm08cc8S3OTOHmGavbF24fKzPu
         MZm+WWE+I+rwJ/l1GkI//cRmUhj/XctwAo+S01rHNenS0Ga56l9lXPKgch1XyRid+pVO
         1Og+RVE69TmkdSYg1O+qFIB3rJLvzR/KreDPv+i9WoZO0Kz9ARDTvUZYla9csvlC92jb
         r5o7hw2KNm8RV8CSAQju73NypHu6X9Ss4tRQLqmQlzWNpicNqg8tFlClYgonhImZl5Yp
         9v3A==
X-Forwarded-Encrypted: i=1; AKwUvBzaQ2xeONoaHuKUtlaKq9EnujRusf5DTGXSz6phe/sNgx9kkAGDSsjAEZ2nSSjmTgcUQ9toTAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/aSpCg/cHED841QhTUMmAe2hNKU+zLLJCHs7RrzP36nH8L2XU
	uqMPqD2rcUPUoDTnzAX8qfawN2wJGMcsMEY3s+4mncc+6RbmhOyVKK4nRdgmZPKgdLUUOwqa2ZY
	WQVHd7dGny1tpoWd/02jKOJT/OBzBLHdQnKcAIiEMtjBVQadbzJRMp/qly2o=
X-Gm-Gg: AYBFou1Z2K4rVu7C6foPLpt5NPjUPHt/VxvRe64vonmT0iunMILt9wY61wDUfZPxk9V
	nASU46/oXrYv1LPiQmAg11khl2wDSEPuuVR6ELvn6ke4HTcmQgEYPXeWYb6fkDIelyfRmsxr9a4
	JYPEkbT2+GK+La5eZWohKMXbC6Cl4B2orDWrJfaHKxmLxD2uhyfZLCBdCPmDZUFFpVoU6W7t/4v
	aaia6kL0uSdYcJjavDQT/9u5SDK3Latwndnj15G9o6o6LjrMNEa9smjmgu9b4USfGEpFlF4jpzE
	l1BEifyMn5Wt/jIbLtBEXN1TVPmMco/+8GQy8FanMRE2x3PmgFLTGAMZPe5Y/8Shv04PFC+GJqN
	lzn56Z0GWppFGNfrpMHfWlpwZ2t5fCo55K9Eto5RXC6HGv9bQyY4QDV5U0Dny5Q==
X-Received: by 2002:a05:620a:2605:b0:93f:2d52:613a with SMTP id af79cd13be357-9442171be85mr2685786185a.29.1793783201273;
        Wed, 04 Nov 2026 01:06:41 -0800 (PST)
X-Received: by 2002:a05:620a:2605:b0:93f:2d52:613a with SMTP id af79cd13be357-9442171be85mr2685783685a.29.1793783200670;
        Wed, 04 Nov 2026 01:06:40 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43d4c9d4csm53083945e9.12.2026.11.04.01.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:06:39 -0800 (PST)
Date: Wed, 4 Nov 2026 10:06:38 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: James Clark <jjc@jclark.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: ptp: fix support for PTP_EXTTS_REQUEST2
 ioctl
Message-ID: <aur1nsTkMRiws3ff@lore-desk>
References: <20261104052504.1886335-1-jjc@jclark.com>
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
	protocol="application/pgp-signature"; boundary="SZJ/srcPBu4OL5we"
Content-Disposition: inline
In-Reply-To: <20261104052504.1886335-1-jjc@jclark.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX9KzTkECNf1Z1
 bqvtl2y6syaBQv8VW3XD5+teBE081yA/PZvcISHRxzouIpLV87Fh/K10dAcVCd0ut8tPsPUnvGZ
 lrfzuM2t2rFZH9siO3mTgdSi9yK6qw0=
X-Authority-Analysis: v=2.4 cv=JeUpPkKV c=1 sm=1 tr=0 ts=6aeaf5a2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=idZxcIp9AAAA:8 a=EUspDBNiAAAA:8 a=IsTqagV5zfN5wvrX9F4A:9 a=CjuIK1q_8ugA:10
 a=lgwzRCrlNXK7KLFCy_wA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=NzLqzEvlDKEySyxblcRP:22
X-Proofpoint-GUID: bQzGq2IQn2S7iOTPcpA6-YJg_KyvHY5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX9XxM/jbOM3pz
 7tWMZxFk3lR72XaISwyOUTED4bQZhZWbf0GX4zEptTNRAA6tf61wTjCvuBO/6UXiFpQMTyyipRO
 bvmEo8e5DK/w6NbaSp8Mz4T9L91PcawEr78zpNMsgoBB/HcGpC9bgRs5Ay/DkyeXHibnm6NAgnL
 jkNcTTwnMgrESPiYZQMYVBbB8DxXcgdWJaYC/eHSxiXQWQrTAtvHiALOmR57oSm6pii0thxpRDO
 vPWgTOvH+ZLzhp6W5qCqJEWDZsp+xTb3vAqnT4Ur4IJRFv0kf64ZmwS48/JETYyXA/KsH//9cz6
 5ZqET93Y6huFKuqmWgW5eVikt/Qoyj3P0hmFTfbZPO7cVEISk2YAAoIM+Ifnxno1/7+ELfh1dg2
 LdvpOksBJXhSFqhAC4FBiuQfiRxCdEr9ph9guoVfS7vUfXs+Fud5OIxbZpsqlsUApgdIei4HrLD
 DCjv1j6qn2iFCmjVKQw==
X-Proofpoint-ORIG-GUID: bQzGq2IQn2S7iOTPcpA6-YJg_KyvHY5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040036

--SZJ/srcPBu4OL5we
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
> ptp_clock_info") modified the PTP core to validate the supported flags
> of external timestamp requests, rather than relying on each driver to
> check them.
>=20
> stmmac_enable() and dwmac1000_ptp_enable() ignore the flags, and
> neither stmmac_ptp_clock_ops nor dwmac1000_ptp_clock_ops was given any
> .supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
> PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for
> this driver with -EOPNOTSUPP, where before that commit the same
> requests succeeded. Only the PTP_EXTTS_REQUEST ioctl still works.
>=20
> Tests on an NXP i.MX 8M Plus (FRDM-IMX8MPLUS, GMAC 5.10a) show that the
> auxiliary snapshot inputs timestamp just the rising edge. The reference
> manuals for the STM32MP13 (GMAC 4.20a) and the Cyclone V HPS (GMAC
> 3.70a, which uses dwmac1000_ptp_clock_ops) say the same.
>=20
> Encode this in .supported_extts_flags. A PTP_EXTTS_REQUEST2 for the
> rising edge then succeeds, and one for the falling edge or for both
> edges fails with -EOPNOTSUPP.
>=20
> Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_c=
lock_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Clark <jjc@jclark.com>

Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
> I used an LLM coding assistant to help prepare this patch.
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_ptp.c
> index a37405534beb..31a66e855d6b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -277,6 +277,7 @@ const struct ptp_clock_info stmmac_ptp_clock_ops =3D {
>  	.n_per_out =3D 0, /* will be overwritten in stmmac_ptp_register */
>  	.n_pins =3D 0,
>  	.pps =3D 0,
> +	.supported_extts_flags =3D PTP_RISING_EDGE | PTP_STRICT_FLAGS,
>  	.adjfine =3D stmmac_adjust_freq,
>  	.adjtime =3D stmmac_adjust_time,
>  	.gettimex64 =3D stmmac_get_timex,
> @@ -294,6 +295,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops =
=3D {
>  	.n_per_out =3D 0,
>  	.n_pins =3D 0,
>  	.pps =3D 0,
> +	.supported_extts_flags =3D PTP_RISING_EDGE | PTP_STRICT_FLAGS,
>  	.adjfine =3D stmmac_adjust_freq,
>  	.adjtime =3D stmmac_adjust_time,
>  	.gettimex64 =3D stmmac_get_timex,
> --=20
> 2.56.0
>=20
>=20

--SZJ/srcPBu4OL5we
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaur1ngAKCRA6cBh0uS2t
rF0OAQCBQ4Jznbj+YmV/bTgLSjoDCUuZ+PomAAi2n95oMB8GFgEAu1dSRv/ORtKN
Qbwi4a7nP3qZRg0fNZrxJwojDXqy9wk=
=YZZD
-----END PGP SIGNATURE-----

--SZJ/srcPBu4OL5we--

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7873BFE26
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279745; cv=none; b=lAXfH8+O8HZVqlIv+reACG7H6jYOvPDSvu8m5DmfgIWkV+V5uGR18FFwkFOeizQpdmWL0W09LMYPYhPBZH2sh4EkBtRN9j0c164Ej4HUbR4XMCBkYb0tU0QqeHizzLP8Act/XEkY/fWsFx9nibItkrv2ZygeILHTGERktqBi69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279745; c=relaxed/simple;
	bh=N0cBn/U5phHjk33caX0C+8gh9x9iMzSnCbasLzRRcEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKfvMW0SUK243X0bcAmX98nBTXaHk5+SZv0f2756kTvwPY2iaLjBvI0bDsQ/RtetXBUOgYQTWJcuRH5dC1h015JtuLoMItv3HzUnj3zOuaQKVTpHSA8BDC+8ZIpFvlV1A+RUa6iwGgNqDk9jmAmYajoifVlQ4j5mhvIJ8DGlmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JAMvpwAD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PnUE8zGw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JAMvpwAD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PnUE8zGw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6969R8hD423542
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 09:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kcOil/NwtMA68u6bwhNQDlDq
	9DYU9sJ5Fd/m/3qw0dE=; b=JAMvpwADuXrLTUegRGlnTjHlueQHFC0euuqJquGL
	D05bY9Eh3b2UpEWUvXHXhd1E9Vj4MEgiAGctfWGpk2XrscciFmQE/g19uhIEaz+U
	GzjdntXXpE61qJAJVHglA/OMGfvdZMWObm1xleHT2W53A5ikl0C9q4r76dbNMnJt
	O99AKPrtup0WIdbS8NeuVTZ5kFz8I7Tk/T4/s+YOcszJ/I/uq63H1QhtgFB0hEDC
	ZWfxnt7TUeS6R0OtYlaXu0z+JvRnW5eZynBwQuyUhkYCz3ndwVamAXEDP1pnFHCr
	CWgvuspiOk9fQ6DWhWal49RlYivZU2VmuN2uuNtaBERCyA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9r1sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:42:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93c5ab5c136so433132785a.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791279743; x=1791884543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kcOil/NwtMA68u6bwhNQDlDq9DYU9sJ5Fd/m/3qw0dE=;
        b=PnUE8zGwKP75GAljOCehvFYzt5xSwouaCY/ZAIxhT29c6Cb0RThMbqGmhcsZsJbxxY
         bPAw1kB2pTgD1CI6qBfAdmDh/dN/l4nAzgILJFfp+xehn/x6iJ3qjHdvZbSGUlCBQz8+
         F9aG6+j0FcrZ2azvO5GFKSjRwF71qHmkicUkUmqUUGxmL6jXtGFxt8HaIarJWAsSIqnk
         NeQ3jmRIj6ei8xEn0PJ6HjjQ0FF4XQAzX4PjYrslfoq0f891KXDNvxaJU4xWzpRlW02N
         d2JoQhj46E59sDyQ4r1+aiTFFIoKV1VAL6AVzfRnvK6OSzZDmH6foChcggQa03gJXUrP
         t1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791279743; x=1791884543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcOil/NwtMA68u6bwhNQDlDq9DYU9sJ5Fd/m/3qw0dE=;
        b=TZYAEynYEVbiUfZ6lCmgucFipZ0xq7bKCptOBFXkY9DblRhivqTl6nmloB9PR3dHpr
         COQbA9gwqZfueGtSQHcSXRwdbj0gpqu7LMM/QJAcJL4wuu2DogeEMeR7Vj90ii4KIoaf
         xJGrg/Pxr8GYXrSP4G3KizyqEVDOy4kgT8aqyRsxPNm2LG6VGNSw2vhsMfCsRQknjCBj
         FHNh4NPi9gI6dARh5wtaMGAYveKtL9QcGjnBo20CBrsX1kftgSyd5glzEa2LghWxrxTG
         Glr09in7ebH2hWe6lLYdUZ8r7TvMyoPF+K6VVU9j7LNMbpmW2D5GgPg+35BD0y8hh22S
         NORg==
X-Forwarded-Encrypted: i=1; AKwUvBwr85iJsNhmz7zkoDIUJiY2E7SvVoN1pBLmZVwvOeeUULF5zjyShD1RKRlboxQ8EwcAAFsotiw=@vger.kernel.org
X-Gm-Message-State: AFuF++kaddhoLN9X3xXN61ZMVFbbaoWMMKz4MG7FSi9td5fRH+XC5yMm
	DvKo1iYEabRqWmL7bTrqCpYj9K3h1Sbw5UtLLvaD5MzSRfSTdHCb2SoSOTs4X/DRPxTMz2bgH/D
	w/HsDwphP/Fks4J64/E4OxW+Dqw3HuYvdgQ0HJzmiE5p7WoigzEIHb5mVV9WgwIDHnn8=
X-Gm-Gg: AYBFou0AuiEbE4d0rVAerwkypSGTENPdUisz5mc+FHVCU05n1umZFeLo13UKLoxPzWU
	Mlxrm15rI6rW2r5Q8ZUSYhaBmgsvOGkj23QJLiURXxYptT5ek0Gzan0UR/CC+GzLoxxV2jbhE0R
	51pRRWWg5hSDImQ+Fu+s3r9RHLoB+OalhG3fIaH11gH4rXifw45juyoJNJ7jHLA0hxvLbwW51BP
	zNmv4dhiDvqnJ2mXt9xvKEagKxBcRn+ufM+jccRZ9YwbHRfciZzUqOoDND9cKOOn3Qrefxwbe7/
	rS0jJuz/RMcAqWG3m/NucTKRbsOBnae75JNJckAccCaea6ANhtLh0kVthFUDM0IXz5MXz5Y89tG
	MEDOvTz2bJj2wJA==
X-Received: by 2002:a05:620a:711c:b0:939:4b31:4669 with SMTP id af79cd13be357-93e8f35d7a9mr140705985a.29.1791279742631;
        Tue, 06 Oct 2026 02:42:22 -0700 (PDT)
X-Received: by 2002:a05:620a:711c:b0:939:4b31:4669 with SMTP id af79cd13be357-93e8f35d7a9mr140700585a.29.1791279741909;
        Tue, 06 Oct 2026 02:42:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6f3a36dfsm639859f8f.19.2026.10.06.02.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:42:20 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:42:20 +0200
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
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <asTCfOqNsv7fhX13@lore-desk>
References: <20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com>
 <179114695065.1402591.17659606391395950626@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Bgar8i1ZwHvrwxx"
Content-Disposition: inline
In-Reply-To: <179114695065.1402591.17659606391395950626@kernel.org>
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac4c27f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=wfrYX8O7EWgUh0Dss7UA:9
 a=CjuIK1q_8ugA:10 a=edXyOhOlrqVGcbvKT0AA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOCBTYWx0ZWRfXzEFWLoBc0eu/
 gCTM/RzJMJXfB611gj6eF87UrGfgWYGbM5PU3i30MuRPTgs2K1mnzgbxMVuFh5Zp+7GBEMDawX+
 cdMFWNA+IMwhVz5aTIVS3B78OQrc704=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOCBTYWx0ZWRfX52L4dovPuWiq
 TPWxqcZbNUYhcJ8Xtslut3zjPAcVX495gQ+eyIxzhoarI9Kll4eUn4My0XLLpj3u3ZdGtjZ0NpB
 2KaRfbYTV4RYxartnPn9SXceyjHIvRanzmRCA0RP2NXV3NQA8j4jI1nHwuidKNjn2hfxIvsEmsi
 uFq3df0yNptg2GWGMOjQttR3p3Uw54cJ9KKYdVcrtzQ1qv8C1YNd2k0zEhVsHJOtp36eiC4EjNp
 YGImDE61xA6hS78gcz84csrTxpVUCIBJuaFc6u1JfOUfyeom4DBDytrrB920ToNm4hMBbfVodwc
 yvldrNl4bqG2Jb5jL2l9y1FPludMY7v2f9GGMavzMeZjGvrS50OcELHRngm4p7G9QFTU3CpbrIl
 020dkFEMN5gjuCqrFP0k0G2uZMBhYB/UGSMKR2xohqybivO6vSIkEwM/aHAJNKW4BnNkm9mzNZz
 5D+J/0gIxX8c0wyK/dA==
X-Proofpoint-ORIG-GUID: E4qvtE6DD36EbJ8nfrlZe17e4ksbN-h6
X-Proofpoint-GUID: E4qvtE6DD36EbJ8nfrlZe17e4ksbN-h6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060038

--2Bgar8i1ZwHvrwxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I will fix the sashiko's reported problem in v4.

Regards,
Lorenzo

--2Bgar8i1ZwHvrwxx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasTCfAAKCRA6cBh0uS2t
rLkbAP4wA6iHjzlqIoQ2A2AtB/Sq+wGDHsP23jOQzttMk/mS/QD+LC7sLvYYF00Y
1excpxc14pI3OvMuh5vX1oy3OHdsCgk=
=2/xG
-----END PGP SIGNATURE-----

--2Bgar8i1ZwHvrwxx--

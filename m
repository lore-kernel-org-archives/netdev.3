Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEAC4EE863
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983540; cv=none; b=A47tkxq6XsoQwtF8oHxO15Fikq5LN2N/OKX3AKpppKiec9VgEOkXrO4szaOT4RFp3WFOA+C58c7LqYa+OzF391OZpBw1VRiqG1Cjn/Q4dTRjU2Sre8vKGzMkKq7in3EVPwwbDic93/tj2VHrmplXg5RitJv6ok82w1HrvO6EYlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983540; c=relaxed/simple;
	bh=rD1oI78/CsMZr9juTjHcrQwwhF4y0ThN6dI77XsFzJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErWpg9LrhsbtNutQvQdbGou2oHVwQFzSYjqQ7NhDAqIMphfbb56XxLf5DN2fWC98zo1ZpqTSSL5hycSQ0TcoFSN0mAsyGW9R/kj9h0zeuiy92yiz++XuLxMXU6S7rOlH2HL6NQz2EEfW2384Y0SzYWXs1mCz5MVE1+At5Olltaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=du8jH2u/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A7J5U6+Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="du8jH2u/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A7J5U6+Y"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EDBAXL2874283
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4Q4tREkVd7vcO1xKvc6nTYP1
	DruPRGr6e3zl/2j3jwk=; b=du8jH2u/dd+oMW82JODINScnacuBtPztJNdXcUI0
	juO//2N2ZZ9lcS+0SZoJz8YfoZxy5bSGx3RwgtWHvljrL0kC0CShR1Kcfm9gqCjM
	JlcKI8Fh0QGcZ9525vAgjI8tQAOChqU5TnXBB36rPST5cBq31dN3Tqz2E9mHmpZ9
	s1vBsocgEN8KV6x63y29d/tcub1ifY5BUrZw+2wl0kPE8k0iVIIslvYKdI1dHBok
	6qVKKmcI4QK3vzIwt79AHLvepEt9a9fTtUAMkjPO6r1aXNE89oz3odcj0DQc5xWg
	DB5IpOA1N88mcpmiFWqb3zVSbB4080RnS97JIKTiy2X6Bg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphjpbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:12:15 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9902e6f65dbso217383241.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983534; x=1792588334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Q4tREkVd7vcO1xKvc6nTYP1DruPRGr6e3zl/2j3jwk=;
        b=A7J5U6+Yfl5iwaTHjtnGxQl1oJ3eUwVj08AIOgAnzFNEncq7BykgYNs3qgW+v8kO43
         hVg8/nloIV1dMyM5aI8UJpKjxtmYzZVR0hp86cfZFRtGTfkJncr00K1rQWIdRV/raHbU
         brCI0kT89yoZBnLwNg7DqiPbngpXAkzK0RLMquawXr8yVN+3zkikyLthTfOBgncAUYC+
         z56/wTsuXZFwzIyhA6L5GkM0k6D9QfoojChbeSgmr42XT0B+OCf4Uw0QEznPMUKesRMv
         /g3lzFWMHQW1L8OqpzAZXFJ+NZ/Vhk5Qp+1crZjmu/NlNoeHvsboi+vyzL2ZSXA8lFvp
         PUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983534; x=1792588334;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Q4tREkVd7vcO1xKvc6nTYP1DruPRGr6e3zl/2j3jwk=;
        b=lzYlZ6gip5PKX2ozjpZDKLL16J1OeCyhJRroMpqFHlqLtaUt16d7VNYGHVDShfmF6x
         Yx3uJMBn4P1A9eIs9gwylrS+q25fMuA2qa7vQu1P12OZxAc7EXSBFd4+PcimMv6KXv/+
         u2yu1/Xvx+//aUzsh2ukDlGMfg5M+FaHXindqfP8I0LL5TKUWqL7VU2xmpzPU7DRbUxJ
         JYUH2KgtlyA0li4CE6oNgzpanCITyeX4JgVdrmLbyoPOQCiPVjFdZqLPKcmOZuJ8SK+h
         FzVDSO/PcLyOwgiQZNwUBwwQidpvSDv+cniKVcCkUmF1VrJ/tM93969/xlMiIquGUsMo
         xsBg==
X-Gm-Message-State: AFq9FYKtUcg8Y4Pg6cqgfBnqIneNI5VjfylBxrYpMt1Z1G/hGhjE76cg
	WkVoDu0XXKb4qTFfuf1YAm/wxnMJb4dUW6UITSL627R/XAA1r4dVtaU20F3kVCOe3BRmzwNRtt0
	uzgtH7YpbBDKTP/SFsgy6YL+XppAA5uJwPkX6l/RKjX+dsnkIh3h+aasHHqg=
X-Gm-Gg: AYBFou1osJCYtpSSF0dWaV2QF5k9pzhatCb2dH53wKa/xWI7lSWg/1HjhOHVvTAL0uW
	Hgrv5NCNNXvSmGpkYjAImxJ0+LlQrtvwRYsXkIS208Wnb3EoPhc5pnVKmWHeP/uSCNMKd9yp3vk
	Fyk958GEXkTV04p1ddJ/wUekjCQLafGv50/2YJ3546TjIraCRkjOcAN9Ko34ZnfJ2/tOi4q492x
	GzfpWPAll+aYwld3etCuSH78V14rsKV4D3lQ1oYoxfaMIOSYTBbUgYLD9J83B7Hg2bFAMzVB9ZH
	5pywfbFYqODGa87IwuNxAxbeIa/FI31Ldos+fdVj9UFCQiM9GMU985nEqLa95Uqsvcy6fj2Hr/c
	msUO+f7eoy9M9IA==
X-Received: by 2002:a05:6122:8006:b0:5e9:6d96:a910 with SMTP id 71dfb90a1353d-5e96da64d4emr521203e0c.3.1791983534191;
        Wed, 14 Oct 2026 06:12:14 -0700 (PDT)
X-Received: by 2002:a05:6122:8006:b0:5e9:6d96:a910 with SMTP id 71dfb90a1353d-5e96da64d4emr521135e0c.3.1791983531912;
        Wed, 14 Oct 2026 06:12:11 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaad1sm11597371f8f.17.2026.10.14.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:12:10 -0700 (PDT)
Date: Wed, 14 Oct 2026 15:12:09 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v6 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <as9_qWH-Vw07Zr_f@lore-desk>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SWwpvJ7uYLKp8rBQ"
Content-Disposition: inline
In-Reply-To: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
X-Proofpoint-GUID: ESvwRWDCbx9Z60qy_cJLETXEOasyAGTq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfXxvEVJQt0MZ4b
 jqFlCLw8TKnVkmShOgRt+fOf3OsT1IKPDO2CSw+adx6veuq5DTJO59QzdCEMFnPHBQDm/s2qLUa
 4smai85bGxAnWXAUhuNmJor9k3j0PkM=
X-Proofpoint-ORIG-GUID: ESvwRWDCbx9Z60qy_cJLETXEOasyAGTq
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf7faf cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w_4PuGcMj9oXbp2957IA:9 a=CjuIK1q_8ugA:10
 a=2yseMgosz1EoShofO10A:9 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX//MlUtqmgDGq
 +5Tn3HDXn2Bg6a+gnVuSrfT85CV22+er4l0SorJX9MkSMhtuGatVN9XWXnJ793gHn8PInlIhBPr
 GbsuQABTiCQbiEDg6HunsNB0PoxCPrsnv4rxHm4+grlSff+WH+6GS1/V+07av4OhnceqRunjcqq
 KzI24zP1ccT1ygz5171dhlLZo7hA57NslHMCXsrLM198kEI9JpzWSvykLlC8y2KWDtYaJdSlYsO
 tjhvtWa8SOh5ei1fz3qk4Po3zwv0z6gxLi+6p7klSlI497reRNW7d4xDGs6ow0asfoyVFTrS211
 4oflqf28LVqjMpaqxB6Pgfp/31179mmsv5KG6Z2cHSmqHlqeMHbTPzQW7ub3rAhtkqJzX0tNrMl
 JaeIMQGbuRvTAMT8QV1ujh3l7ZvXUncVk7Q5zH8bBvvhSFmt64/Cd4D7VI/+yld7d3FHXHM9O9i
 aJ8dlunmo0NVdO0c1+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140052

--SWwpvJ7uYLKp8rBQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Rework stmmac_rx() to build the xdp_buff from all the descriptors that ma=
ke
> up a frame, so the XDP program runs on the whole (possibly fragmented)
> packet instead of the first buffer only. Fix possible rx_q state leaks
> when closing/opening the interface.

I will fix sashiko's reported fixes in v7.

Regards,
Lorenzo

>=20
> ---
> Changes in v6:
> - Drop patch 'net: stmmac: allow non-linear xdp_buff in XDP mode' since
>   it requires some XDP fixes.
> - Introduce patch 'net: stmmac: drop split frames on AF_XDP zero-copy
>   RX' to always drop XDP multi-buff frames for AF_XDP mode since it not
>   yet supported there.
> - Introduce patch 'net: stmmac: drop multi-buffer frames in XDP mode' to
>   fix pending bugs due to missing XDP multi-buffer support before patch
>   'net: stmmac: rework stmmac_rx to support XDP rx multi-buff'
> - Link to v5: https://lore.kernel.org/r/20261009-stmmac-rx-mb-v5-0-c38fa4=
eaa138@oss.qualcomm.com
>=20
> Changes in v5:
> - Fix possible read after bound issue in patch 1/3.
> - Do not allow parsing non-linear XDP buffers if the program loaded does
>   not support frags.
> - Add patch 3/3 to remove MTU constraint for XDP prog.
> - Link to v4: https://lore.kernel.org/r/20261006-stmmac-rx-mb-v4-0-efa4ca=
974e3d@oss.qualcomm.com
>=20
> Changes in v4:
> - Reset in_progress flag when the packet is fully consumed.
> - Advetise NETDEV_XDP_ACT_RX_SG capability.
> - Link to v3: https://lore.kernel.org/r/20261004-stmmac-rx-mb-v3-0-50fa17=
1af9ec@oss.qualcomm.com
>=20
> Changes in v3:
> - Return secondary page in case of error.
> - Introduce stmmac_xdp_shrink_tail() to remove the ethernet FCS.
> - Add patch 'net: stmmac: take ownership of saved RX state at poll
>   entry' from James.
> - Link to v2: https://lore.kernel.org/r/20260921-stmmac-rx-mb-v2-1-6e826e=
1ff306@oss.qualcomm.com
>=20
> Changes in v2:
> - Rely on xdp_buff_add_frag() to create xdp fragments
> - Fix bugs in rx_q state recording
> - Fix the corner case where we receive more than MAX_SKB_FRAGS fragments
> - Cosmetics
> - Link to v1: https://lore.kernel.org/r/20260918-stmmac-rx-mb-v1-1-0b4517=
d404af@oss.qualcomm.com
>=20
> ---
> James Hilliard (1):
>       net: stmmac: take ownership of saved RX state at poll entry
>=20
> Lorenzo Bianconi (3):
>       net: stmmac: drop split frames on AF_XDP zero-copy RX
>       net: stmmac: drop multi-buffer frames in XDP mode
>       net: stmmac: rework stmmac_rx to support XDP rx multi-buff
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 407 ++++++++++++++--=
------
>  2 files changed, 257 insertions(+), 153 deletions(-)
> ---
> base-commit: 29f144016f03608abfddcd6ebaeabafd7aeaadd2
> change-id: 20260918-stmmac-rx-mb-16469a2714ea
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--SWwpvJ7uYLKp8rBQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas9/qQAKCRA6cBh0uS2t
rHAeAPwK1fCt/8yBFk23UATpkL7SEGGsdCm+B2Y2kUT03z9WZgEA3eCds9amV6h7
fRwlHyRLNHXnRlCNpT1QfbCTUE5N0Q8=
=us9t
-----END PGP SIGNATURE-----

--SWwpvJ7uYLKp8rBQ--

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158D4A387F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820377; cv=none; b=QSdr749pdVZKgsz6xjJNj7EFI03E/x7Mi8nxWZyzo4GykO4p+GkPpSwDmNmsgenZ6SNZb5tqAK5ECRYHlfzgjKGvD9tkB6t3e674EZhtcz7tk/5/Gw2H4aeF8SQpiFWgjoHBpznU1m+l7AlgBIGZMG0ASSIbmqW96wl795Y8v50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820377; c=relaxed/simple;
	bh=LHMwAWagy6GhPKXqHPYzseRLeMTAefpgZrXkoLY3gD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYgxchr6UnNivaSJpdhQev66uStCwBAzz96dcDG/TTiJq9vqF/tH25OBh9AYt+QzNvwP2lqHbIzAJu/R97VcC4cN7NUJH4Qgsgo5TI6DEpk0QQAHE3XIgFvnrsq4Is56PD47UXoZj8r221UUWJv98Ova1GibOgz2AGuqcev4XJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxBot3MI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lm/UyzQp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxBot3MI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lm/UyzQp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFes0h3272311
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/oJKRRR72jg/nPW1o56vlRji
	pAWluWMfTze5tftOJ0s=; b=jxBot3MIDZXo+S4b8hKG6K9YVcffzgO8qTGXTEUZ
	6r0GS8QRiOcJ2yVqRwUc9uJqBSRH58zMt1ba3UW5e2A8IX7POOtYiuyZmUKUtYsr
	BB1aCcGF1/7LyEfcPpWqFUe51Ai3SvnneFTemqoJqyydGFVPpaqBiLkMV0fIXL6Z
	Fja2TuT3xoC45r5iWBdn06h/ADKGk6kBvUS+L8tLt0PLdyQq38ISyfx8MvOOyUXu
	1fWd6bpmpiU+yefqSY+cWSbLfWe4igTiOPm7fxNynK28cQ0SewoaNj0uB6CLoHzB
	pu1uFc9lxJ2vDATlJlxfesX9sKvwNF+80olV2vCk013RDg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffhg58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:52:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a1de6d5c3so482393785a.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791820374; x=1792425174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/oJKRRR72jg/nPW1o56vlRjipAWluWMfTze5tftOJ0s=;
        b=Lm/UyzQpwk8njeemVkodiv5aV9oGcKTIK4jVsQzAej9CbumLKQdFpV+zePopifqQm7
         YCZVTAjG9hamTzPc/C67e/4+XnLYGm+VDBfTmTodZcKwQYNJUzRLgxgnROdEOM9H3fix
         ogM9d+Vwaod2woxo/CZzD3a64LUxqlX6QCKdn1DmEXwtB4Aew9WluUe6mKAkMz8Yg2O1
         82GLhn7N6dAXcskL4604WskLEU5ObH2hkU8q31QlL8mbMSWG1IPJEthZhRfWHtvxJDvK
         KmGS1gzckICaJj8CbSAYxri2lXI+VTrrjHX7kXmdwPC9v1bDag0pUmKfZIvLle2F+t9H
         gV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820374; x=1792425174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oJKRRR72jg/nPW1o56vlRjipAWluWMfTze5tftOJ0s=;
        b=qTqfWZNKs/lcItXzDGXcdE+vOQhpf1j+DD6/2oNKexr+vvwx4Ws+o27gbJyIk5bNH1
         SfaOmcJ/6jBFuW2NRrmj1SULLcQLO2/Pe5f7SRBg1C+nJj6X9LOQtswaXb4vmLN/sPIX
         sxnylZRkiJZfSKWHgqNaSWlecRKmKQrCFN08dSBngutd6yqiUuEgUOLq0nZIr1N7WE5e
         S9xuNwD9+6n6GTnzduKBuX332myRaSj5+uVu1bM8GzBTnqTVU228HHNLGxHfrnKgAwm6
         oaBP+LHfXuCslN5aJVowyVs0B9KT+2txxKSG7Kixtn+LZVpXLQJAH18mS8FqAmYL3LPW
         qgbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjyEPfNAKIxroLvHdJBT0SvKaEYrCDTyfU0s0R3GVCYQoBzZQhuEhIeWfdXpB2i7d/VJwwVQI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYwdljd1GhmqlsYN2cVI7S/hHuGes2XOhQ8C5WjTSw3uMXK/ld
	R9SwfnqJ2r/75CxQyMOgXJltuyOAHvglumzDg0gEUhUNk2admeaFhTzJfqV+Bl/SRSmSRIDyBPD
	9S544ycdRqMk5bc4VJZgTP69+BgwvvAczIaxb5/Ye4ES6wGVdHW/MAHW0q0o=
X-Gm-Gg: AYBFou0oQlxI8M8xECNr/15UFnzs/9bTAb9q7Vb7VV65yVBTnw03BKK8gH//aNHwz6T
	xeKa9sdp5IURan3GrfDwUqKMvIGy86Ju5NUD8uef7e0B5/LpV3LZI+whTvMpiQkAxItDLuyQ+iT
	WueI0rGUwlmyj0j6cto5uPUZsBuArPq/Dh+84xYfq38d+ILrQfex3PUCAQNOFSFo42E0wQ44n3i
	sHKcqTZtXopG9+fVtSpo/OUCTfH2jJ341eryQIChXTTwcuWCsP4NYL2KjOGc+4xMdnZ/NvB9+EH
	KZBdRFACuHMO0bSdMKjx2mKJYZSsxUUC4DCZzcWMEd8JAO37gXquAwZrdWxukL9GOXRlpeE+cse
	6R0/DSdpP1YfpWw==
X-Received: by 2002:a05:620a:4383:b0:93e:74b4:3115 with SMTP id af79cd13be357-93ebd248c51mr1554726985a.38.1791820373999;
        Mon, 12 Oct 2026 08:52:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4383:b0:93e:74b4:3115 with SMTP id af79cd13be357-93ebd248c51mr1554723385a.38.1791820373370;
        Mon, 12 Oct 2026 08:52:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaa34sm165063f8f.20.2026.10.12.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:52:52 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:52:51 +0200
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
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] stmmac: some XDP fixes in XDP_TX path
Message-ID: <as0CUyuWNOrV4WPP@lore-desk>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <179181904740.2527009.16307700795539761723@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="or10+gSup2yG4+kv"
Content-Disposition: inline
In-Reply-To: <179181904740.2527009.16307700795539761723@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MyBTYWx0ZWRfX9UKXCuW1l6+p
 KtD3oNF+ET/0u8UvpF5/Jc8LGRO5BQ9QA8FdwgB67E1bn9lM4y1WqF8xp15IvTTr9wzQ0Xals/t
 9EFCUdpsVu0k8QnwJZHKV3t7rCmAE7Q9JeViD0v2Bi5grzSfzX3vZwlYwI5RbcSnDAaFTD/uGzm
 i0NyEbQSdUyzEkOkafDH0kYs5soUz7njgqIuPyExqFcU3HNADMLxnFeK5NW15rpWDgb/kyLaA2R
 Uoa0aksP/KtO4Xq2x5ab7ZQQeW9AF08T24eUba4Pdx5kkWlWtfC7PBwS1du78oV8Rr9aXVmhxNz
 naa+g7wsbHXS90kDhrv9STw6qDtJtHSBCKOQljvNIokAukwybI+MLLvZZmzilmDR6ZjXRJpXVWg
 O5rXpiKZcXlzWUj43DUyEApjpsPbi/2zaK1K9n4Eo4Z60KJlr3XldZx9w4T4bBKHQZO2HxgvbIk
 2qDvxOGAlIeGXY1Y85Q==
X-Proofpoint-GUID: Fz_sTU-fprQducSnlmh2DoQhVTnNgHhg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MyBTYWx0ZWRfX2o5sa7MaFCpB
 AEJsSdVBf4+HHhfAWZKmCfT0z6FiN+x0MEdA0AP73tKwn2AIS7js8v0I0sj6mpcYCthg5PoYF2G
 dGgDWovDNvz62NvI01LOPavMTpGUCwk=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acd0256 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=aJ77pqhsylUep-8PoN0A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Fz_sTU-fprQducSnlmh2DoQhVTnNgHhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120063

--or10+gSup2yG4+kv
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

these issues have been reported by sashiko.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

they are real problems spotted by sashiko.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested them on a Qualcomm Rb3-gen2 board.

Regards,
Lorenzo

>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

--or10+gSup2yG4+kv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas0CUwAKCRA6cBh0uS2t
rNW3AQC2/QeMrn5IqfOYKh+NSNDgIXxUvz26WKNJJ4xN0lVxgAEA/W1AUeFJcriu
MA8eHjFtt2TSRtfyi2A3pmw9qVuFYAE=
=Ixfu
-----END PGP SIGNATURE-----

--or10+gSup2yG4+kv--

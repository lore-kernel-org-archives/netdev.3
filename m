Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49239488D92
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837661; cv=none; b=POOA49yfVAmv8k1fJDPL9N+Wx1RqXeXCMCpXUnuYyR0k5y7IRzwbieTQyrsE+TrVQyWA1A6F1UytevKnK92UGYJtFYOlL7rO1/SxJ88U/CgK0uhCAEJWT4OTrqk6vS5dGDuQxSMTMyyo/Oj2sKcIjNlJeCKUtUE2gjKAX+TEBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837661; c=relaxed/simple;
	bh=1qCWEQtcXj/xtdjmkzdjnJoDvjBCufSmuRRYxIMCqYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSqgmC/I4BESSMxfkvbOa9D8r86b4BXnSqPAqz6jXqLtM3KCHzO9ISyeLGFJi6m+lmLPQ13V5tkFwzshdUK9sD3VAHDc417Otf+oGSuTMc2LuZtt1eRro6Or79D0bEa4S86x7y+ZEvfvM+Qkx9vTi0rnFk3IjxxZ2iyD3QjuZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jsOdSStN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IZ2WYOfz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsOdSStN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IZ2WYOfz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJNEU53656184
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h56h6pNSAkohBNVz3YvAbtH/
	DQ/UmMvY90TTNPOXguk=; b=jsOdSStN51RteghJR4I92yYZz6DYtmPDmrL93Dee
	ZbA/TvdRlCOl5uY/rkmYi0JmnVr2HA2hgWPZG3B+qNDFdm802ErcDOwIbesLQyrP
	OA7PUvYLnxnbReZi2WPViRmfqcz60LqNwxbCl6+oZHk5dsfhIbNQHYhpegiE8XoY
	ar/uS/IUak1jMX8DmGFoT+SEp+3wFfe3Rcj1UtnYV3vrrPZEtaothmQj8a+1gRM3
	QQ7gN7Zpvh3LvTbQiRRC0MYuf7zQWOnpFZbcqxibDXupZ91MxuKPr1HC+aBC6PHy
	WxYLCRYx+LYoWkTgp0svj9TJaiSuge5g0YKqohHaHjkJsw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1uy42-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:40:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53513d2a70eso53877051cf.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791837658; x=1792442458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h56h6pNSAkohBNVz3YvAbtH/DQ/UmMvY90TTNPOXguk=;
        b=IZ2WYOfzDYWXi8tUqI4vqyJAwGjyUZWttScSpTG/xN4thJPubkdc0ud1NfsuuFBJom
         hmTcmioVyd45YcYaYAB39mqSNzTYkJ9Wl3U6R1hnaKiZTNhnIGX/GY2fA6jMK6k9o2iW
         CO6WHZ1kDK2iwQTDEUGn3G9CZAOy1RzfI2wLTewmjrQqeWR4WnNsY/p84N0R1CuP0p8s
         4nnxuhYYnndATHjsv5ekznvhB+lwB38CJnDGkGJXJqi+UYhVi8Fw/cSOraQUrPFjBqHK
         dNT1q/rBRpjzkDzLxW6Gf4iNydGjFjj2HMgdR8lxzHq7tVVlgZTCNeK/S6OLt9+3RcwY
         L44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791837658; x=1792442458;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h56h6pNSAkohBNVz3YvAbtH/DQ/UmMvY90TTNPOXguk=;
        b=N9w8wRY3u4U48yfg4iCWFa3JDVwBlCi90iM+9yYl8CUZ8Etcq22iO9tJT/TRHdhxLI
         BwUqzdw2FrkYoAB5NTu6Moblk/6gslfoYriG/cSDHfEriNLiKeYxMc1JEDDFzCHtNOlA
         YkTAwSiOYIwHsst7+AAoaqJXRdCMZvbYdDoZIpckydOmBkEdBV7VQRB3Pefu0TBkHSyv
         TDdOfvB7gofjWycvxsfLaDjQ7iRCG9Tf0chH2WMaPO6qtv0w22Y3kITVIaTQUWEytrb7
         3o4yYNz78Faju+ueKm9X6uSQAUAyyEBsqikBHqzIAFaFb0yF8BFo/uM3imnq+1V7Ctc4
         aqNw==
X-Forwarded-Encrypted: i=1; AKwUvBxyGt8dvqUgUmqJRYot4mDg8iY3eEleibT1cKAlzzPHBORz+5MC8lKSSv/I6bdAZe0jWekOb1k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpzXAMsT8iC8qPYCuux8rEEVyepdp84InFNjFT3qIgs3e7RgYA
	eSqowsCQtVP05FGoXkQywh6Q7i9txRl4/MTlpY3h+X+CzuYRm2OmLJrrrTJYnnJx8ErKUygmNkg
	ybEYm6bEJP7M31EXgeaAbqrpNSTVqoCsYdyGXk9SZRHek268atUaTjWD1qDQ=
X-Gm-Gg: AYBFou2HVwxpFIJP6QhfiCeqhCp05mSGLlBbTffMMpOMVLtmwEwRte/xvf+1D5+f0kh
	HC+ySN7shTW4WGr4j1XeWScAcYw3h4FT4MunfgZ8pWcCbabcrMtlcIDyDDLwA7+li4udRf15uik
	sTL8q06JSLq0FyEuZL9VYtFHNP7Ka38ezzQl9MPIoyLcWa4AzoB4FW9zeFlxd34pYVIaLdDEilp
	fLXU9HgZsEAcOVwU941Ew8Vz8XUCB5aQnWT1/xPQ02tbasiEP6TqaSFAzT46JwfB4XGZym+Rx6J
	IN0iglb+t0memPS1QBS1wPfl8ownFG9pN22Wue7dqNKSGnaSxDZIZzmiVlCbJnEqtReBr7TtbCl
	9FfqvpiPMEPj1NA==
X-Received: by 2002:a05:620a:2248:20b0:93e:c12c:9b77 with SMTP id af79cd13be357-93ec12c9f5fmr1187247385a.82.1791837658206;
        Mon, 12 Oct 2026 13:40:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2248:20b0:93e:c12c:9b77 with SMTP id af79cd13be357-93ec12c9f5fmr1187242785a.82.1791837657603;
        Mon, 12 Oct 2026 13:40:57 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4764sm1152895f8f.25.2026.10.12.13.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:40:55 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:40:53 +0200
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
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v6 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <as1F1WL0zk_gC2bS@lore-desk>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <179182385023.2527009.17648648661045341604@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rxRsXlv5vC+nRl6o"
Content-Disposition: inline
In-Reply-To: <179182385023.2527009.17648648661045341604@kernel.org>
X-Proofpoint-ORIG-GUID: qYJZ1btZhpuAngyfgkwJXmDLAYDSjgql
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MiBTYWx0ZWRfX0Lt9cAPEbOp1
 /FKiy7bzh79xWIrEX2CvXbYp/ACWvolvw0SI/PQdDXejt+P2UQwrkQ9/YI2fAv3vv3csE9Fjjvw
 Cv+BnjlrjoOwwsPO+ddssbpiQuBdyUw=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acd45da cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=dga_IyV3Fs-R8JpTthMA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: qYJZ1btZhpuAngyfgkwJXmDLAYDSjgql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MiBTYWx0ZWRfX3vE6I+GjYCaK
 2SYT/wSDWRuxE5rMNNZ7XrQD0rBSKXbnRksfQ9UNKc+ADsd1KmbSX4SVXkH4r3wM/9jTGbEDOm+
 Su68R7qWTXVoJa1n3C4sOM3Tp8697yUnulitUF1EFiHJ3MvAzbeD8XXobrwkQ0hMo8TyUnE+5WZ
 9F+X4urDX5VAFAbdSfLzg4h/81jA7fwGjl9cJ4AcwGkraqXRVsKy7ToOWr7lTSMP7WGAMqubjmq
 QB46zztCOSO71z5eZm8li+r2JhUv6MGbBUw/1P9t8rIxoeQHFczzoGWT+iFZ5uzyfXVgbYkdv+l
 goAbxEZCIi61IV7LIZ8aukYE8v5DjsakWn6TOOAi7l5AAZiLYZ5m+mzzy8godk+GelJRw2FBx/H
 l+i2JqbiXMKYAqWVnlsz5NRXf5Qp01erv6xHcWwb2MiJyYqpyY/uGkDRSUuRvPLxpkuO8/Yv/lS
 E76H12IxAcq4bpJTPhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120082

--rxRsXlv5vC+nRl6o
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

The issues were spotted by sashiko.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

These are real issues spotted by sashiko.

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

--rxRsXlv5vC+nRl6o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas1F1QAKCRA6cBh0uS2t
rJOKAP9qqujrHhbYPapooWYnIlitqwx6Dp3BwcpZ/9MswxVuTgEAhgVCJz8M+1PW
bIVO+xMtJeXY9gyZzRBl9XNIgSCZNQA=
=uJCv
-----END PGP SIGNATURE-----

--rxRsXlv5vC+nRl6o--

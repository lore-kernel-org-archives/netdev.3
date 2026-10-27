Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091015;
	b=0mN8IFhZoLdqnbEcbkMyKDnsejmcE/XohDxRfjdx/vbyy7EVivUymouQXn7UGiqFn94S
	 WcqR3FjTCuPKBcz0O/mWdODbZUDlGikUHxX27SZ59QPTrmANSCWT/ABBgtIg4OuPE1Ngf
	 qw1BA00Y1kYj68OUdnRyow9hLPuezg2gFhs6mnXiJaZ3gJPcJPbS4VvDIhWjvNnMVNtNm
	 3SnZQmiMaLeGIe/qRwxQWKbMR5AREgbnJGtV37cQfSMAEkEv9/m6CrOMSmIkh+f8fyp+e
	 M4xbZ/L187KvwGz/2YE8ZwG7WXC2TP9CpkmE/+0uObvd4cnWxcZDPccLlUsZGVuwTsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091015;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mmllJ+uXvvHcM6LuUW8/Fr+YPtzrcmRcBhLz9Ri9Lqg=;
	b=oX98QVvdcf6rQJL0GILi1D2TUf5E8/yILy48e0fC0DW9aEqHcw4w+jaQakhONFdMWTxW
	 vjRw3x29uVRmlrZimJn8XyVrnGIfFuVOY5+BH5+W+ER4RgEzqvEFQcc3Aic0N9rRUVq1n
	 bqBJLfqY9jpUj9+FNKoWV5/zhIH9wYFuWYZAjNYDmeNcyqsJwpaA+rhq1wyYX+AdF40ck
	 0nVB90Ix3wFnfqx3xes0oajW0CcLzah9k6rJAZDXq5ZyJ0CuVMnz6ODSvouP04Wdu248y
	 j1WoHOdXFdt3+k9IqCKEo/SxLUJWe2bFxbHoxLZqkTezYyO2fg6zJ7Nj7u+WoUpkWvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ib9L1Dlh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="aXkmF/FE";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F918606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F918606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ib9L1Dlh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aXkmF/FE
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8gLiT1162782
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mmllJ+uXvvHcM6LuUW8/Fr+Y
	PtzrcmRcBhLz9Ri9Lqg=; b=ib9L1DlhuUsKOMYtISN8lfypSlHItgn9BDIPAo72
	yl0jbtnqDgrk61AmyeiZJz7oGslsv7sjZm21eXi9hmwmixHh53AEZpuaeWG9gpPb
	IR0eXAJWOARj0HFGK0QL4AC3AL8YmMkhizY5Wc+RcdL2QyKcGX2Jf1Bxq2sYpz3V
	zlk25sTbfB2gDiQjTNforaAwxUaS2LZSxJG5AFLYoO44GHwVRJjQ0RRwQrir6BTi
	gut56YRJM8+z2PS1/jgjitLk37eyqeys+AK/+BO/clS7+rJHwrZYrnEjUOLfjGoG
	niKop6X35isBcWeoAUCe7ZQsH1uoaP+x0FfDI+cHqj/uXw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmarkm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:50:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f559420f3so370756685a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793091012; x=1793695812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mmllJ+uXvvHcM6LuUW8/Fr+YPtzrcmRcBhLz9Ri9Lqg=;
        b=aXkmF/FEhywXCaUiBSQ3o3TFXadO7wzEVd3oAP0Kj7iIZR4x/qBMxX77EE6CvvlfSR
         18RPfiVmChEV8I2TJBnQe1OvMiXufrYxLt6e1+DGf1k+aaEQ23h0IsNFEBfT+Uq+HNDo
         kh4KjNgsBbYV/yTI6TRFzBFtA3pJG16P7aV2kXgz+W5N9JhsNQRS7UbcI0uzypID8SxU
         XiMXwuqrln+xwsXIVsO9C6ebdDrtfkOi3tRlZQHaQ75CGTCC1Hb6JWdNFHTH4EcUR4FI
         fPmxTQL49ThEDIHysbKpkOC1Y9QxDo8Zb88dgWThu8AExO0yWGCXxB0KPYzlb38bIt3u
         etzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091012; x=1793695812;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmllJ+uXvvHcM6LuUW8/Fr+YPtzrcmRcBhLz9Ri9Lqg=;
        b=AtcOYkUE9GRYV3fg3PgJB8CUXA23xfq2XFndieQtNzvUdrfcCVASneWitzoP2hQ7Op
         za2ETDvydM7+wuR0F/9COSyJFZj7SnCu/Zw/056i9dZC01mxaxc2DHniCQMWxz4jbfCA
         /bkAgd+06iVzGkDbehcnaCHPNqebUnouK00W93JcDaU2ynkeM3J7ghpUO0s1xkcJ0Bz1
         LR5kT6mR4KshvUI46A8gyyy/LdS9tko9skYBPvOnrzIchqbHCVVC+uSQmFPSrHzVB8Q+
         O0ad/Iq0PJWUvhoB7X1MTl503F+g+tO7AcGruggFbJ9R/XSOYcs2Ju0WJExBpOYhbZEb
         5Rsg==
X-Forwarded-Encrypted: i=1; AKwUvBw+f2MOPe52EcT8TtqA57DAjnhJ7prX06eQjq6E3B7zEcwAunmdgqEx7fvOCcw9sD+pmELCCPA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrzJOaEnuXPkghWjVx4CHOksNVehYQyOzh3IBJlZRESXKF8/TW
	SWP/7lmABC9x3c2gbSfIOd0t0r/nthYSpTYYzsCV4uPo95XIOsDdnTy1HYMDPRo3MflS2FdCu60
	SpUC5S6b6BxUa5DIF9bMJKK+5QGUc5vdR+uPeUy3biw/KLr0SjmjVNOLFOL8=
X-Gm-Gg: AYBFou17W2ehN4h/fnn/otCEHrCrtDHuECygtEiFDXWn/t6m6dcUiFhZXUWqSVu398a
	GDrk6XsApIk0+6QYhBZcKuFmWKTFStChAd/cuBAL09JOV6zMTaoqZg+jCl+JlgPP6CPv5bVP14j
	6/3Om0S4yS19j/nXQCTEN22abawRA3VyR3ybs9sesqe4usEvAZGGk8W7xW780TEILv6N61yaaJO
	yZ2tYte4OwWSmTZY0o7yv9ew5902l7a187M+jo19w3RJ+5e88qVMpksmPRvZbHrtY/td2W4Al22
	k1AgaHpD2KR/mbSn4wQcS4UzsoGD16LCcHHkpiXePzILNLQv3X+SBbs9QiIUb0b4MgvRWxCR8v/
	lJJUT2EFbeGPLCWf0xbPlbe2QU9oAO0kdEzbSYhkviH7q/08G
X-Received: by 2002:a05:620a:4009:b0:93a:48a:167 with SMTP id af79cd13be357-940ef952696mr1440550385a.39.1793091012171;
        Tue, 27 Oct 2026 01:50:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4009:b0:93a:48a:167 with SMTP id af79cd13be357-940ef952696mr1440547985a.39.1793091011553;
        Tue, 27 Oct 2026 01:50:11 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd49afsm21753979f8f.35.2026.10.27.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:50:10 -0700 (PDT)
Date: Tue, 27 Oct 2026 09:50:09 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>
Subject: Re: [PATCH net v4 0/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Message-ID: <auBlwUjTDbmP-5b4@lore-desk>
References: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
 <179303405498.3327.6709797406209936415@kernel.org>
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
	protocol="application/pgp-signature"; boundary="vlBb5iuXm9umAb6K"
Content-Disposition: inline
In-Reply-To: <179303405498.3327.6709797406209936415@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzNSBTYWx0ZWRfX/ACKnFRJuYS0
 KCE0hyz2aQn+Vb0CidaCCkCp1qEoRjPXeXIt6yxD9l2MmCxqwR42aivculrct1p7p2tG8Ui9lLs
 mpNym9iyhajL4aQ6YBQiLquyak0PEso=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzNSBTYWx0ZWRfX33Wt11Wn5ZhB
 U4I/DX3Y3NlZLiITTUVBNhE0fWlLY/mPAYaWwZKRMZ7UBTn36IlkVBEkexxbLAnOuPQttB4/A0b
 mfR5Eqy58Vrz8rTFA1JR6rBdLmSGJQ68g+I5lhwKK6lYFk/Cv5mLZQpxkLFEF7QAR1qq1DyTajY
 4wPRlGL5Vc5bB7K91205PA+nW4tozbbDXgOPZt3Wd2gmOBfwTOHp2ky/RUcoPpgfn8Lav+98N2K
 Dntwo9qoMaUEBeUu0KiEUaaoQ8Et9EmkbPo5s2R1Uc1PosPzoSxaNQAjDti53lyDHeJzzF/wdxf
 dHVG8lIwpZarEAR70sWeQq08GtPyDr2ySudz2MNdjTzExERUnwbp3STtaBWxSPPoSnDIy6IaJBI
 oawrD1TeyEQSWa9fK19PtV5cA+4+T0n5yzsr1/lvWMta97BVjqM0aVBHENUdK5oc9QK3TevLMLG
 UU6K7nTGQ4lcDOxseUQ==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae065c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=jeKYxtEjmYGD5WCmXysA:9 a=CjuIK1q_8ugA:10 a=tIGJ7Hrp7TI-VMH61SMA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ofpPLiyr8viBvBOMB02i1KfHMo_mrHwO
X-Proofpoint-GUID: ofpPLiyr8viBvBOMB02i1KfHMo_mrHwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270035

--vlBb5iuXm9umAb6K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 26, netdev-bot+sinfo@kernel.org wrote:
> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

The issue has been reported by sashiko

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This is a real issue reproduced on a Qualcomm rb3-gen2 baord. Flipping the
interface down/up the EST MTL configuration is lost.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested the fix on a Qualcomm rb3-gen2 baord.

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

--vlBb5iuXm9umAb6K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauBlwQAKCRA6cBh0uS2t
rG4XAPwPblbkFMjt3UOpk9xsG7z+kYXCKiPBWyd2rgnb+wB1lgD/Q34ricHLI7TE
XHy8rWR5LMTrhrHLLZEYgaz7Den7YgE=
=emFh
-----END PGP SIGNATURE-----

--vlBb5iuXm9umAb6K--

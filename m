Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E04EE867
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837007; cv=none; b=sgLMEO5Wu+cUE4oQXBIRksH6zIzJ5kmiU6v0JR98gGX3CHtUqVESKBnOJRSVbtzwXWPWOQ4XI+DUs+VDwEC2sFJPIJYgJUvWphS6jcDMiIy2OF5VZSZbjtQytioREAX858ce4YLkHLmt+4hYt+93Rrh+7h824CuLnRLFdCXagz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837007; c=relaxed/simple;
	bh=OgXXUa/f+2IQENw7VxVcuxkaXYRlSYTVwmw1zOa+r7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxd4oXemAqoeTqb8Jy6HMbC6v9Ca35MH/VT26aa5CF5L2kewiZJ4RCZ9R5LxfYyfzgrgUlOyTmQmF9GIgkl+NT1n4THJaWwNULAXpt6OYs6BfmtF3RyfEd70X6jGpRmwlVaWBHzyXDP84DRow6mKT8s4BKJT3yD9Y2IIqMvG2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GA9ZyJox; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DOPqX7md; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GA9ZyJox";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DOPqX7md"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJMxXY2384340
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mwAVVDCRlRix98sQkEjepCst
	OH1RiFvVFbweyqzpRZc=; b=GA9ZyJox15J5NJie40dVRCpwKUtWlh6tcoNuBh63
	cmpinXdeADUTGHRel5O3OeZWlN+FgjDysfflNdUJlxOUcy1GKfbysr6KeyKhD99p
	AgrEfNVocbw4NSJaCLhB8BQdWLghFIq6CYLS+lZezFWIE5QlNF61nsF2FJgFT1QQ
	TXOTw84r19D94h3/ciK6Kmo9FcyHjE2Lm57GcMRuBrxcbArCmV8Em7ARcHmLrPps
	sQmapk6mQScWAZl3i2rc2gvgYAhMFGr/MK1Mhymn913cBhlNGAueq6Sz+hF6Kf/Z
	zDegDnt7URXd+PqNWeBjK/J73orDqtHhAGo7o1jyM0haNA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ku33a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:30:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ca9b53afaso632432485a.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791837003; x=1792441803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mwAVVDCRlRix98sQkEjepCstOH1RiFvVFbweyqzpRZc=;
        b=DOPqX7md/Mk2tzHHPfekc61GfF0+F/tgdgCsBfEvTTV6KJDXDbERgRf9wviEgnGlLN
         dkKDmDAKehOZbrX2pyYL0sYWDvhVqY+NpSJDsz0gA3dnKvLObOwO+D8Gb/wF09Xxaz0U
         60IuH7sQGr+eBNXeAOzJ/TKP3QKK34izAnkhZUXJG9qF1AdUjCghug1woFXZabbzGaPQ
         h9tbBCVdnznGK9V1Mj5w7XEuCXMf9gEfEjifNqLHs6vb0ZP+X1MXLefXyOmt+cqdlq1L
         n+A17ueEEwuMnqSLi6PvZdZepOyR9ljd+ARfLInyXSWVE4qJ0C+R1ffj7O+pcxxh7iut
         ugbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791837003; x=1792441803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwAVVDCRlRix98sQkEjepCstOH1RiFvVFbweyqzpRZc=;
        b=u0EwrcpiPoxHLqvy+ZLHXosLiH5m/Tt0kdFjbFiO+wkjawnLXBxy29bwGn1GgwOgzL
         j56utFkPsv2eoa5Vrk/nwhH4ULRohvqEl3PD3DRZAaVyDMBcY2fY6S6tnTZcIZUHuLgf
         WxuzT9RLNNfK0uMzUj9SpjFqfQnKy0SOVsq577NsUnZ7Z2X7CxNFDfd3jegzmUxoXz0t
         LuHpsPqfU79Ilv8JBMk74A92VsOjRKqvGePJF/zkCYjR42GucCrSof/63H+SLMc6PXCR
         dJpQ8QHTgdG8CFmKu/wKsiLAATJTxHiuX7vOWnSlPtzAr/OoBozvlP8BUr7yOaR39g8b
         0VCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRzn31UKtT6j68BeXHk1jgP5hZZND7YOPlcpvL/yC9w/oXj2Mt980M3BF6UxHYb+zbj9FPDBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNHy3ACwxxNZbisjScKefBo7HypIu8olp3zoHTHQqN8oia/4AU
	tYLWJFuktQriuMlEjuTL/s8engMUKIudeICH9Xwmgo3WLfAxO/g4WIKkrSzEXKqqj0Q81+60zWS
	C6qu3PeDK9zEgkRYMmBwSn4wvs0vwO1D9ELJgVkbA7jZIl8dsugvdcYjgJ54=
X-Gm-Gg: AYBFou1NrFG8G79aC3mIXdPhIVZDi7AFfEA9To1BtQ6XSyg+cg8GUHF1PQ+JuPcOX1K
	oV7RnONSkBktnNGxvM9qcvFivYuEfTTdGoresXmY55sfdCFsnX0A2t+qOpz/vNfW8WudMJyloA9
	aG9/tms7CY4zG2JtplTRxHnJrgaO3nQVAL+WOD81NEAzKtIhi23ySTurVaRtStsjsTtjuWysmtP
	u7v17eVPRIAI4f1VVNluPJXXuj5AROfdXW5A2EvJiGiAxIVF17PUBQiCYN5QL4d+W0QxCNz239+
	cvd2q1OaqjywPxTXgmAltxrjvtY7SJzNX0CueDhx/U3dXcppuUGkAgxEzeZU7dbFXm7hZw1m890
	RbUOc9vXJDTqkBw==
X-Received: by 2002:a05:620a:19a1:b0:93e:653e:698b with SMTP id af79cd13be357-93ebd27d873mr1663645185a.55.1791837003331;
        Mon, 12 Oct 2026 13:30:03 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:93e:653e:698b with SMTP id af79cd13be357-93ebd27d873mr1663640685a.55.1791837002753;
        Mon, 12 Oct 2026 13:30:02 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de096922dsm1001134f8f.8.2026.10.12.13.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:30:00 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:30:00 +0200
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
Subject: Re: [PATCH net-next v5 0/3] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <as1DSAxuXDJ9hIIM@lore-desk>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
 <179154182368.2527009.383686573505818394@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kKjh0wB5J+VbIG+m"
Content-Disposition: inline
In-Reply-To: <179154182368.2527009.383686573505818394@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX2XhxupIfsc9M
 xeyYOiBYWFZ2WAgfM98cByzfXSr+ANCUB3lX/U+2hauii0G70F5Yb6uV/fphHYwnofhJRo0wPsc
 nM4kVy7iymcjiHndX63BC7uC7l3nwSGgU1fRg/R84k2IUK7nvEzGshDtSKnP3YHzh0XePUQwEIl
 AOvsQT69aPO5CxrThEwzuK9dImVEOFUBRSR9AMWhh3sdc3QoL8AxRqh9UM6X0RycmDxGbxseaaV
 2pUf7avupBIgYGzGYCGmnJKNMvfKBPY2cwDsHNT+8rup+FV5lJqv9MKow7iL58oba4XZTZv1sRH
 XENSyXeFgHRzKOazkXQ7wSNUQ+4j7/5AqbP4ktpneLx0iT6MjEFPTDGoihB8FeyjqJRWkhDhg4e
 R+3H/xZymU6qDjG+vZ9lqCtVNnUZ+1AlBSVYN+XUK30zVLhATOC5Hx+VSPYNDMiYSGN1Hupz42J
 ramMrcjJAw2aCSrePdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfXxXsuR4XHAaQ+
 elLwBgILK+QC72NiCEUK8k6hXTGvvfL1SgCU9P9R1nRY4WpDGrDzmbQF7mK/xykPdkDSvu6236O
 4Q7voYtPV8Gtfqmc7O70yFuniGBitvs=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acd434c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=wfrYX8O7EWgUh0Dss7UA:9
 a=CjuIK1q_8ugA:10 a=2sSK_cnNksaZuBzH8zMA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: tA5-myEmAAIB0Bsgq3CCs8yt8SyhQTDG
X-Proofpoint-ORIG-GUID: tA5-myEmAAIB0Bsgq3CCs8yt8SyhQTDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120081

--kKjh0wB5J+VbIG+m
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

I will fix sashiko's reported issues in v6.

Regards,
Lorenzo

--kKjh0wB5J+VbIG+m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas1DSAAKCRA6cBh0uS2t
rKejAP4gV7duzIkrdPWPXvIjqkWPfXtxyWImDmCZVcRrr7dkIgD/USVZbJLTAVU+
+L4mMOrD5VRwd1aTXUsiPcjZwQbL7gE=
=spw1
-----END PGP SIGNATURE-----

--kKjh0wB5J+VbIG+m--

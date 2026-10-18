Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1593A5443
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344004; cv=none; b=EWqEOnso1tkuaoMcCQvoVacqKTM1vpL/+ft01WfNMrQ0T2l1FlDJK6zdHz6++zJIOkYmtYZe+hqFWQ1ZaZsMZRnclWcvd635BHP5sc1J5XM+n/75uj9137x8i/3X9XxZx0AYkgkMqdLAXysDtfl5f/8/AWcJOX778VcTYVszPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344004; c=relaxed/simple;
	bh=5CHyBq6+hpt82CrYxDzI8fviha4Yg/+dp2ZyyFPEx5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIF7hRzldH7kHlW7gAbFScU4vPitd5VvvmVSLpkH+b/6aBS6kuA3w5decWeJgbwFrXTqVXCQE/RMwP+LX42zKb7G3VLXG5V6bR+StfgmqC9MG3+uzUrUHK9Sp8n38xZveRTZp9KlDrxiP0SGggqAT1Xkqu8bSFZgepxFXFd3kOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2FtwSGW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b5cMPQRo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2FtwSGW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b5cMPQRo"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IF7F4Q2772159
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=T0p+EIzAf6jC8zjKtsjkjlrP
	wlROr4CztFJTT33WVqk=; b=i2FtwSGW8MYD3I8B6nVJFFiB5dVUYIUDadrih8zK
	VHgl0NMp2nHbu2ek0fGkxNqFJOS91wSOpwPQ+RGnjnJb4yeaw6wURDsWITqUy9kq
	tkRcVIX0su71SVgXE6R1U5Ug+hprBHzXyIawRzJBohzV6mmwngb7RBO2nnOSSJsK
	AwewnhP4MqqMF7ZdztbTQycGeB3fjzqHuOW5IMiytBeNZZSvmb0pZpo6QestzOeY
	RRra2dLBoSyzERCfFmb8ifsuQI1MucmYqaSa1IqUV36NSKpIgwFgvfwnDwdEffDF
	bAUsDVzsEzaJBP7oRf6ekU1vNRLeMoTuA4HpJ2SHcl85Mw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k3dr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:20:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e49a1d3b1so374651085a.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792344000; x=1792948800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0p+EIzAf6jC8zjKtsjkjlrPwlROr4CztFJTT33WVqk=;
        b=b5cMPQRozLg2uD8AMwYME6JhRt9wj+nj1AkopwdBqK8gxp/bpoucFeyCWcD2tVi55B
         jue6aPF55cMC0mL1LjxVU4yExWSgGApxDjPYy9wie5JgxES8kIILujFSSfwZ6dy1whSP
         KY9zes7+oq0ZN1NLGnQA1+MiJjG8i4NzpSn5bPA/dBn4WbBu40a5eyIWkzl5OsB94IWJ
         +VoaGZopTN+ad1nZ2+6j3dPQTuNfEIGKVzoYF9G181ExJfaerIqOjIilkKVxYqeLN4Zw
         M5E6HNnftzFm3e6aXeUUVgMjvHhm3fBOpkH4bl04FcvoFMnmuFM3Ruf7hKl0rpha6Ezs
         8xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344000; x=1792948800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0p+EIzAf6jC8zjKtsjkjlrPwlROr4CztFJTT33WVqk=;
        b=rksLdQst0/kkKJcoj53MvDMDPWlwBNQS/mqZ2j8+pL3sly8AgG28v3M+pIU8RyBbwE
         mP6H0u9a6jRkUrZLT9usRa0xagw1K+gbQAhm4eOYi8umP5pOZmyY1BxaLCBLbMLyU4yO
         s8aAr+wKrmJti8sKIiLJqFu5G0DBLisoPuwWqR7bQNzKVK+ayMeeTb7RSGtmZY1nb8in
         kFHFLCHVYT56Py8kImUcRlespder1ipYxZ+nrsYWZE0rKCMcBm4VwUZ27+31TQtJW56M
         6XZXHxzj/tCwjXy1Q6bdcA0xGZI2kHcUUBBsA0AMuGstfsT50XItibm0PDEkRudJQ/zt
         yaNg==
X-Forwarded-Encrypted: i=1; AKwUvBzyMOMimvioynRWJVLxifBvSXzzQowRwePW6wEjkXLL134aWtg21UrrceKpD3OwbY1QjYRlkeY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7gy+xv3riKeOsEkudpl+HxdnitRmTLlxfi5qpjd0NtGWGYe6f
	cGvWKA7T3s5f8AlWeYcXHjA+y6Z+d3zOX82bjN7dPzyDgmErYLM8xNA2y+ZMPZvg4qCQ/A5YSfr
	UscbwLRt49U5eV22/PH8s52pyXIg8UEeuCtLZZWRqFhGYY3b9paE97QVCt3M=
X-Gm-Gg: AYBFou1P61FtDrMW5sH1SrQG4SgJI0zGNV/8xndUo9Sxrp6eURK2YZBkR/T85jPWiu8
	2t6VY3vRwsuflMXV4DQBkmmxZlsmvTJvnqf5Lgqym59Gpg4wlkyxtabNAB7KdOMFArEMHZsMNb+
	TRpRsOMROQwKNdiVEtCDfsb5lW6On9WbjeMpeToJX+3/qY6zApGz0ehYBL3GqH3OPmtoE1Zq57Z
	/7nzF7QYJzbJwxuwduJwh8qhrvSh6A91CfgGhBOheb0QR0EAtMlD0zJQ552G43OUV7C9yJpmw+s
	kR2gaUAm1Uuc4X4Lls8KUqvDKq55AWrG0z5Rb+0ItbvzlRTt3aRuVTu6KR2jddyK5gUXHxWr3f4
	pEues9B0d3pG4VQ==
X-Received: by 2002:a05:620a:198d:b0:93f:2463:f784 with SMTP id af79cd13be357-93f29dce82dmr927323985a.66.1792343999446;
        Sun, 18 Oct 2026 10:19:59 -0700 (PDT)
X-Received: by 2002:a05:620a:198d:b0:93f:2463:f784 with SMTP id af79cd13be357-93f29dce82dmr927320985a.66.1792343998916;
        Sun, 18 Oct 2026 10:19:58 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503a24sm18085517f8f.49.2026.10.18.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:19:57 -0700 (PDT)
Date: Sun, 18 Oct 2026 19:19:57 +0200
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
Subject: Re: [PATCH net-next v8 0/5] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <atT_ve7qmxaE9ZBl@lore-desk>
References: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
 <179234329183.3290.15960565045054355734@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AgvfZen+EKhfDhbF"
Content-Disposition: inline
In-Reply-To: <179234329183.3290.15960565045054355734@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2OSBTYWx0ZWRfX79gDVcQjxQAG
 awaf45/33GiG1vwzygbd1yTGozH1LewibfJT7yzJFMEnoqr1UI7q0YczxMmvMSShMczSdVPWKcm
 hMe34zaPZ1uZxjpodmYKrBClhGxdCFUmJjlY1XpUww57S9ptL2L/cxREyRx0mF996mbEwL8XebA
 VY+86R/2uv/FPjeLzVIfmUm7UjlsX1dAOrCAUSmpyd7yEOmGY9Jik7avu1krW1rQ8pjPqayZP7W
 xq27nSMhvQdtH5H06H9MNsdggds/Jz+7s/ZS/k07POzre0N6dMdsKmIPjYcE1fO+MSrgbmmUmts
 RnrZCRulsXKy5vt+7SLV/ehEHtyXzSxvUM0dtwuiurnD5yeDp/TvTvXn7CWFdGYrWVb8E5U8ly6
 SZHApOOQT67HkSlZWUEoGRRUKANiEkT7aEhGhC/83t/T2xWM7UeBw4Gj/BM9mjOkEgITjlFuZ/x
 X0akkiRxjK/le66DvEw==
X-Proofpoint-GUID: P4Z57a9tYCxOHYatUadcXP7OXLsFcLzl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2OSBTYWx0ZWRfXwGzazgHNq03L
 p1io0QjXlywGgGbu/lQTjl/VSTBLAFvbf3wsXOwPLX8fwC8NMrvVU2OsfRUBV3b8Rbn406/DXYT
 kzskTtJptCC88MFCiCvu57PXXmCQrRA=
X-Proofpoint-ORIG-GUID: P4Z57a9tYCxOHYatUadcXP7OXLsFcLzl
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad4ffc1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=lBbZA46aXh9jGIf2LhwA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180069

--AgvfZen+EKhfDhbF
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

The issues have been reported by sashiko.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The issues are real bugs spotted by sashiko.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested them on a Qualcomm RB3-gen2 board.

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

--AgvfZen+EKhfDhbF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatT/vQAKCRA6cBh0uS2t
rMCUAP9wts/I/Spdip/Po0TyZ6S93pscCx7yjQHQeCpXz5zWsgD/XObM8IQhNJgO
JwuM9ruODNNYhXQtjGzh7mzKxktZmgg=
=u01+
-----END PGP SIGNATURE-----

--AgvfZen+EKhfDhbF--

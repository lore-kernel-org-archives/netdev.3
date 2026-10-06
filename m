Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8C3B27E7
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281349; cv=none; b=PIEcom43LtRPIaNkNGIBhnOjCnPvBpE52pgm6chInhf9j0bPBwp1KeR60tH3vhi62iYqQUSiGyKffwkCmaMf0UOWS3AUjF5e20opW5xeNFY5B8hXGWfGZ+x2nyZC/nD7lM3nbfsrDFeJTVojQM9dH/qUaqw20xZkGJlHJULJXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281349; c=relaxed/simple;
	bh=WzjAbsCldg59wLuZGHPnNC+rmOuIOCxIb8Xty26BK3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brRRSpaOb24qXX8xb6FDTrxKvxnvEx1gVAB9re9YzmN9zaaH2i0DnaIyf+i0bDWRn1F+SAW40N35ord+j3Y6pToDeguskgSoTPiEDF4y4mqnPl5ctwqUKjwY1kL56JkF+9NeSBraaMLeL5p3JR51c53qliQsmfd01YcX2wDkAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ri99tvIN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g4+C8JFT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ri99tvIN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g4+C8JFT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696A5Ba2160578
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 10:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=P8FAVozE5WvzCd4JZdvKH90k
	hQe7swBvImbAOZ1Mrm0=; b=Ri99tvINWq6C8UEA/OqKbxWLYBE5xUv6ubefmWhG
	scQEbLDsUabsQjcZ34uMyHbxW+qKlRn8JVpKLVIR/BKuTvD3oI0LB0rXWvTfaysk
	DT5iwkFxUY+l/QHSv/0twNMyrwj6Hq+zEEcs8YkJb2q1NXQAA9e4+YclXFqov4yo
	Y6bfq9TVi37O2Gni+0sRP7kSWmtCN8P+ro7dRxAFT55bzelayeFw35sY3qPhy7ZI
	6WinaNzBczDuAR+WoftzwQLhsc+kF9CEX8GxJrqvlm9/8nJB4/rF5WIXJ1YkbDlQ
	ViZBMRY2XTXCOZSh7wzGmYm7/eD3DVf+qP4WXdUvcSoZqw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xdu84mn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:09:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934963b2bc0so467461285a.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791281347; x=1791886147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P8FAVozE5WvzCd4JZdvKH90khQe7swBvImbAOZ1Mrm0=;
        b=g4+C8JFTNq6sn3BUAJ6Etz0G1xrzjuZXFC9OFBw4aQzcBGD6zvHNZpUMtmN+ykJW7M
         M4MU/OvSbPW6EGuDoD4B4Mk04w3pr8Ik/jui2IHRCiNSxGpON36FPfAspvoxhHSJIjEq
         QA0CvJNATKplzbrsPkeN0uf4n1tCqQs+YgTUEwIWXigD/zX+nXUC7iDNFRRTXmXmQAWe
         IKcK4ONJlqrorJ3lF0jk0jZxdyD6qFUnNBwOIvFkg9g27Y+mVvJAOM7ehOE/fUa4NQgq
         C7WGCjTxGy+tYNckOXxB3pe6YLevWlFSyK+uJ0TQhgR25MNhqKb0zwQvzgbMqUcOcKhH
         vrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791281347; x=1791886147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P8FAVozE5WvzCd4JZdvKH90khQe7swBvImbAOZ1Mrm0=;
        b=VM8hiDt7UunFQop5fSAQJeHEXEimnPzBtF9Ne73D2wBNyupCEaX2zUV/jLd0Jt57BX
         DBx72/kGtYLRI4f2jLg9mbeoeDS8IV1REyuoTJTUa+khktlZJ6i1+9nw3Z1mFbIjY6R+
         Hf+51JynfKLYRLzlwldRtss5/1yepqCSQoQB+3TwiwXzvGiCBvmDRRZbYZAS8xnGzE6T
         +23WgO9EBFIQpq39QqMpW+5rHHvebYIWdrz2RqHjbHYJmVzHzFuuCdJuQfVqDcRCcpEs
         vn206gVUSVT0sXJDf/Z2SMFsLmj14js7dxxlaa0RwOw67BAbqnb/59wLrb8peOTpniIC
         dqng==
X-Forwarded-Encrypted: i=1; AKwUvBxPBpdDiskLUaMe8ZOF+lPotJuDDlNkRtDMwNOTzu2P7HBF7fxwOwxB0dgWeOpTlNYtp5uzDCM=@vger.kernel.org
X-Gm-Message-State: AFuF++kcEEPQEBNnvRXlqQc0ZzToLXZiTwW6uqAI8xvuP0f/vsb5CvLY
	Dq4OmBQSR6OdEGiMXeEE8MebjFRnag8Tab8mlZVqSXHjUauREWvHqCsVoPZcHeftTJIM8MShRKo
	nclN7FJi1Of2lI6nmLqwGOg3+deLoQBCMddxulIeMcxb+3zbtbBi41nVvHnQ=
X-Gm-Gg: AYBFou1isU3XpzCWHyYkoepGh2l5+TgfKmrefj4fDFsjfoeaYmVFTZ0H6DRCfHdU6Tw
	Vs/WV8DCQOMiM79pPvYc2KH93pQ8kEf+wXnF3Z/zPmdBnFQQBFlWx7o5zD9/l3dhyxS9WyfMW7y
	8xZLyYHHsQH6mnY9fTsVlsjgEy53SmOkH1j8x0/hi68KB8Ng2sICXjrVkJxsH3qMnc4pyjBHAjh
	yzv+eVZVUlbzegWyJkzq8MYhX53AEbB2pLrYgnewAnkJzS+HOrFg6HBrQGzctiUw/VMuGvFClsM
	mxllYdjzC8vaLWIEseGMI+3KeI4rWN+Hr9zFul8Y3UrF4Y6m1vtcWYETHixinxVbEQVqvcPiLlv
	1IYnMHmnOPS8Pmg==
X-Received: by 2002:a05:620a:608b:b0:93e:4594:f5ce with SMTP id af79cd13be357-93e8f4d2590mr149449985a.41.1791281346489;
        Tue, 06 Oct 2026 03:09:06 -0700 (PDT)
X-Received: by 2002:a05:620a:608b:b0:93e:4594:f5ce with SMTP id af79cd13be357-93e8f4d2590mr149443085a.41.1791281345932;
        Tue, 06 Oct 2026 03:09:05 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db8f28sm81402955e9.15.2026.10.06.03.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:09:04 -0700 (PDT)
Date: Tue, 6 Oct 2026 12:09:04 +0200
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
Subject: Re: [PATCH net-next v4 0/2] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <asTIwPvCldoB6k6M@lore-desk>
References: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
 <179128112868.2231598.3214023601488420681@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iX6v1ENqMiuLe7Dr"
Content-Disposition: inline
In-Reply-To: <179128112868.2231598.3214023601488420681@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MCBTYWx0ZWRfX5uf5n01ggOz8
 vYIOq30xRqjlKlJzi1LN5R9PCloVhLne0lDw/JzNn38exmph2DafJbdgGC2CyGNILRCxNoCHimK
 IbFFZzyyqpUNUlgv+oKRCkR9yWuDQi0=
X-Authority-Analysis: v=2.4 cv=NshE4MdJ c=1 sm=1 tr=0 ts=6ac4c8c3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=t5qijVwJ5qrZhGx_HZYA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: r_d7XIIOhQQPqOLiSsFbjoTArBVHpnFU
X-Proofpoint-ORIG-GUID: r_d7XIIOhQQPqOLiSsFbjoTArBVHpnFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MCBTYWx0ZWRfX7klcWC4zTc9c
 Bp0x90Kqo0rbI/mNtIleZPaNRLErJ68p25HLBwqO9NxIrsbgWmoJWV2d1qlm3x0xcS4NO8rPDpI
 lxy0UOtozLwm9SrzFOzuTwePub6uWEVtqb2IVSsRw3WGNTiyQh8+93Aodc2HFfYwiS6VDoJbfAH
 KqzLnnViPHoSlKQIKhWJPUtNgey0k32xVERM8Pd0EiZa6KorwoNgDrNxn10w1A+uopjY2Cr/llS
 KosCoKLHAv47Aw1iYBhoTzUUEhsW8XzE5ahYWlrgONbM3pfCadbCJk3HfOnsWAmYNhuNU5gjDlG
 eSTmfdmjWVnQzHVuysAjlehJA3vhQdrcsYFu/OGziWJ0R/dznbjNNDQmRp7cD1GV5WRmukSGg2l
 akRZSaZ/lQJCG30kUFC5ACV59PLROghTpZK39mBVbYBu7orrJ84GM46kTKR9GYnBHuBkRfMSq06
 kC1rcSiORxmxgTjS8wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060040

--iX6v1ENqMiuLe7Dr
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

The issue was spotted during code development.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This is a theoretical issue found during code inspection.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested this patch on a Qualcomm Rb3-gen2 board.

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

--iX6v1ENqMiuLe7Dr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasTIwAAKCRA6cBh0uS2t
rK94AQD1ay0m6XxveCEdXhyNeswr1zCBysXJQMVwAqFY/g0HxAD/f0z+Dv7kiczT
hl+d0FIxP+dRUzNQ35LhC8xB5TtGZAE=
=avE6
-----END PGP SIGNATURE-----

--iX6v1ENqMiuLe7Dr--

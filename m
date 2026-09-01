Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A4478865
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255225; cv=none; b=adF/oVVa4hGG0w6dg3j34RRv7fYnje428J1cv5zW6M62w123n0CvG+pet9T2Uv0DgLLu9NHDA9JSiPKJXAFhzzrQzzvbLH/qDmJdwqZBt0OtbnJFoHEHYtG53H+CEz+o/EHZM92pbOCL/TVlEwbLx7LnZBK/oyEaq0wjU8RullE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255225; c=relaxed/simple;
	bh=PEwDHV4We4q1EQkV4ljEk2/bfD0Pkct99vOEvbsoojU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ik1TCS99zj7Fp+htODHciA0hkR2SaAUfWVwpdWHRJoGSzwa3cYNfse3NaQ7/CKa6HUB5dUQZc8nMINk+KFHUa+rfCzFf9E0zF7Qo4mh0ZLX8E6ZoEiA1JG5AiMnAHuJ6/0RxFT8V5YOrTZ+qzgWeFQP6PB/vqwPsOJYr2CDHfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a4IOrlKp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FbZp8alP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4IOrlKp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FbZp8alP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68179IVC1335387
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 09:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qeaOyJCk9cex+e5o7JjHCxLW
	rioSsoMPLRXcs380aPs=; b=a4IOrlKpzE7t4dcemMBXOE9PzfcMJpttc5ennfqT
	TtNT/l+FIydPbLaECvLiWQfmkvvxfa8O4sGIgx7CebqtkqPN8rhc6ZKJzfV4vmEJ
	ocNq77spQ9pvGPByAkgp5ubWcrmD3NuIsmJ4SZtTe7kcbD791N1FOSGzXebSXBgV
	a0xUkINLZmWXEVP3gNjTR1dEZRW/J1ubJlzTcplZ1k6BASH5cxOmsFLTQ/8BgGfB
	dQ5diqo17IvRDrpSpaFByOUNJPEkmWnoavlQYfG8dKT1jxr+SJGGmdqUSeiIaN6c
	pdcRWMpx2+tMLmOe08ejjaR/34S8BjQ0YQFTM10p40lKqw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdjtx2edj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:33:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939187562a1so1127889485a.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788255215; x=1788860015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qeaOyJCk9cex+e5o7JjHCxLWrioSsoMPLRXcs380aPs=;
        b=FbZp8alPrKWRGcZvNpNsZy6bqQkX8F2mE+OvfEQ5cdHdmcERHO4MeUr+UO97FI8aP7
         M1L85uWrJNb2JVxfVeq0yh+BsZmMtO6WptNXKb0gGrzzytu1sMbnOTdggWJ8GDCjJblI
         QjWF3Dh8wQffvaIjq39pkycDueAKeLEXUTS0wllXeA8GDbTqQWJnyPJ6zg0WyPjHg11t
         QvcmjPA6kH+J7Zh3tgYt96zFuI5yQNkyizwpclSS8f64bB2X+AwVH/wguTzFITfrZAnJ
         BlY1kYwl3CfqWSizMb8Q9bqCwxqKFoWPJdXT/objig5kJq4wyoPkKaF+mM5LREMnWiVu
         Wubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788255215; x=1788860015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qeaOyJCk9cex+e5o7JjHCxLWrioSsoMPLRXcs380aPs=;
        b=iyx4Jau2WP5+VOCNe58RgKrDvCF1nKPG3Sex1e9f26ZE+Iswaw8aH8GLryIJqqYhur
         ZcGmnvxU5F27Zts6Lxb9NCNdCoY5WRypKZLJfaCpn2Pfo+uLDim9z1vLhj1BLSdvy6Ur
         Z5uWlfSSAFweI3ZJiNVXB8uaw6NfMHRraYrry4unv3fHakwJgEeQIqnSqiTNH1WAiMlF
         YzqDCYfMwOoSS4f4xLkOY2KM4/k+fYEyIpeFDsl0V6XmNvyJQ3UERiJv2fTqQiDbc/ci
         DcBhnR1fc4o5qQdxck8GKLEqYg28FwqnkpIyPXwbvnTxGn9XK8QCF/94/YgiphQRuqZP
         4xNw==
X-Forwarded-Encrypted: i=1; AHgh+RpUoFlci5WOI03881/+91cl+rbuzGWEHObjFQxxGZ7FMQHE8w4xJYLuFbJCrTO/plL9E7FQvOg=@vger.kernel.org
X-Gm-Message-State: AFuF++khJfiVX8tLdHa/rUUsvGxd2PqRMvVWIaFEKm9/mSwsBcNHkTyn
	tjLcbvaskGt+HXP3BkOz5xUwea4ToXSm4uMTdgjl8m5zSEeIgzYu0PVH4aAHJRLFn0uX7kpuiXS
	XME6Dvrv1lLa3fBC0lX+vrk/8ny6Gsalswow/J7rleY/ROlRSGXBvbXdJHPI=
X-Gm-Gg: AR+sD13AE9yfYiTra0rHT1NpHwnKpCIUyBhmvje0FGnFP7opdlTq3m/4gNceY2rgraO
	ju8YH4DlKGcUNbxjdU2I99H6TSY1cshrj4FIdt4f4QiIIoTlxqZYSVhmJZm34Wi0fjjuK5VnT7e
	O/0SlvqA7ryh9rbMCbcBC/SZynrbwPAJ5Ze6EsMHm1Dkc43WMGzQ1a2XCt+kGvDbdcYL7RPyP0O
	7o1jTnQe2+uBsuy7dZ7jcqkUAsoF+AJkefKunw9HnhRpEQ6y150gB25P99ommMZjBtgvUSmUCJH
	ystGLowD7oXSwObOWh1re0nuVA3y6f9qJn6WJQ0yur7GGFQbb95u6Rq25PBznOXrbMBhrG3FZK8
	b2wLOGoix7BOscA==
X-Received: by 2002:a05:620a:6289:b0:937:65d:d89e with SMTP id af79cd13be357-9391378427emr4366694985a.3.1788255214534;
        Tue, 01 Sep 2026 02:33:34 -0700 (PDT)
X-Received: by 2002:a05:620a:6289:b0:937:65d:d89e with SMTP id af79cd13be357-9391378427emr4366686885a.3.1788255213973;
        Tue, 01 Sep 2026 02:33:33 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b28ebsm532678066b.29.2026.09.01.02.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:33:32 -0700 (PDT)
Date: Tue, 1 Sep 2026 11:33:30 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: hold runtime PM reference in setup_tc
Message-ID: <apab6tPGZ33OoXX5@lore-desk>
References: <20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8a5948f41@oss.qualcomm.com>
 <apWVBrXNt74gtUd4@lore-desk>
 <20260831172632.64aadc2c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YgACt2WWoxLzx2dw"
Content-Disposition: inline
In-Reply-To: <20260831172632.64aadc2c@kernel.org>
X-Authority-Analysis: v=2.4 cv=K78S2SWI c=1 sm=1 tr=0 ts=6a969bef cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rNchZ6wNclprkupQ3ucA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=8FirTQ5JliGXrdKJnOMA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NCBTYWx0ZWRfX3H0pmWCOHRUo
 Go9FrrKGPP7q1dCla5cR3y8kzOJuiFxniaYDVygXV1gQo+KxRKwvaP+gj2+GEZhT6Zt+2dvIUAH
 ICp4qDUAK5XQUEL5yscEgfkPVgWuVuI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NCBTYWx0ZWRfX1P7jGAVjkUog
 DyN88HIyVGyqAqsKFHLoHe72jgJx2OMOVNQiB6ArdUpPvoUeH1R4QAtaaNFslPS/+BuaWUIw1vN
 ei17yrtFTueH5MpcZjz0W1EHja27sW/I6+Hc9iH0RDa24RgAq7hyNhsBmbzmBt8LhOvdPnpnkoe
 gNwHvD49nIwMM/BdaH4DEbBGutat6Yei2O/Nm2EIzGJGrAWKaB3UqpEq158DsRpjf3kJlrqDxGi
 SiFAQPeQScagNmdxlqsK1lc488ifex2HK3q44j3+UQ61Bm/jomB2EeyoeGfI6mabK2tSfIybXFl
 UduZhZHI3Aj8HLSLsnx9GmD0rd8i7Fxd40GFZYTkSTD0EEIxk24my05Z+2uZ2LGFcfM6hcDRIfS
 lxU1Div2Do/KpS7IzIGXIN0l8cjpPRPOw6d1QcFy4V45FVEZSsJMR5YmwsYAb9xEwfBh/VsV4ey
 1M5QQN5V7GkJApl8+jA==
X-Proofpoint-GUID: f6ng-9JSg_NHqD5vEhmgQ4v_3ZK545VK
X-Proofpoint-ORIG-GUID: f6ng-9JSg_NHqD5vEhmgQ4v_3ZK545VK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010084

--YgACt2WWoxLzx2dw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 31 Aug 2026 16:51:50 +0200 Lorenzo Bianconi wrote:
> >   - This issue is not introduced by this patch and it needs to be fixed=
 with a
> >     dedicated patch
>=20
> Looks like the driver has multiple bugs in handling of TC callbacks
> while down. Please fix all of them in one series, otherwise we may
> end up changing approach.

ack, I will do.

>=20
> Can you also confirm that the device programmed while down retains
> all the necessary configuration thru the open path, and everything
> works as expected?

there are some leftover issues I am looking at:
- https://lore.kernel.org/netdev/20260831-stmmac_tc_cls32_reconfigure-v1-1-=
21cb459e64ae@oss.qualcomm.com/
- https://lore.kernel.org/netdev/20260829-stmmac-est-reapply-after-open-v2-=
1-5e5ccb185e92@oss.qualcomm.com/

Regards,
Lorenzo

> --=20
> pw-bot: cr

--YgACt2WWoxLzx2dw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapab6gAKCRA6cBh0uS2t
rAzkAP9PVIHkeOY8Bd+C/l/C48j4rxhvXtwJQqY++nM4MzLxpgEA61NH14LNrjgF
+HHRWRLkq81brcUvd/opfeJSsuNzYA8=
=7Cq8
-----END PGP SIGNATURE-----

--YgACt2WWoxLzx2dw--

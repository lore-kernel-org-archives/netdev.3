Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F43ACA58
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057939; cv=none; b=FMOfOZuvhIjnBwAP+E9lQ1EzWS5UcCWURMPFbisjTaNkB8xL4iTtX9wRjk7jWD0opWrgJxC/q5Uq/noGD4KfLGuKGqbUpWj2A7PH+DuW+Eg67Nn7ekq9EbYZO3UXY8fs2iCnaErlV+Sw8zN7pvKPGZNbcXXdfNt4/S7M+/lR//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057939; c=relaxed/simple;
	bh=/P1Jv0DF4UzkIT1u26XRyNwrpVHhc0h6XCRRh+gwWEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps7Nqy8k73gOLf/LAEWrXyr2YL+s9pQrFuU2lQUvVFl3uEp4ci81Ek/PzWAeG28OmsB+5rN697VKgzA6AU80X5ANMZ6iRDbMMcLI09Yj1MbMckbtWg93nqOd/SUPTxe+45x4dk9MBy+A5z68Jfs35gm1WTpsH+iVaKNv1WDzTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y/HhQ0aA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MoyhswqR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/HhQ0aA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MoyhswqR"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4bWJ107250
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/P1Jv0DF4UzkIT1u26XRyNwr
	pVHhc0h6XCRRh+gwWEc=; b=Y/HhQ0aAM6DG5jxxIQCHpQpK9SwwKxlFyT+eq+7C
	6DURNVHIO4zTHjNc6u+3t6m2WBGNmcPSfmheDoyBAHm6Bf7nLyERpuqfjg85yjat
	kJdrJQcC/TK+nH9qf904KIvagUymOGsn3k/dhrGwZoTef3S2On0aImOsFkbV5JuP
	uFRyzn/BzSXR6yl0EAK2mpmeBWi1ZivEthkz7k4kvsSgu4oEZrPDLUpJZfphCqza
	649JER6DhqpZLDC7omP+WMeSskEyEWbIr0MFqPV0jOCxp6zLh2Wh5TttyvMFGpuo
	+bw3L7ITgIWIDxqwiE6zd05QyFUN7kwOBL86sX/FwDN+dQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gksh8t2qh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:32:13 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b1b8b593a4so24193eaf.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789057932; x=1789662732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/P1Jv0DF4UzkIT1u26XRyNwrpVHhc0h6XCRRh+gwWEc=;
        b=MoyhswqRq2FBE4jRkQ/0iqFg5GPwnrfIH5vw9cXDlGVMJIhIMgRhszirf62pgQzZao
         54o3slgeqkhRAmthDoLJ6vq/VdR4xwbp7lBBnaqOVLXzfaBe6SxVFv/UwVvxp7Tzdnt1
         dyvZBlRFiwbIFT+73c5Wz6CRkS/wfAK8pjgzSKgCT/dt2UZ9DqKRX/mDHfmRQuX6J39O
         zyhxjK6t8/dpQl57+j1JRl64/5dpZJm3bpMEFIGGBWBKnwMYIKl7cqwj4ja3D+jrOLov
         jeUmvV+TC2qx7x1A+2norGZNJCyiAE/3beHUvuI9868yx+WffFoN/uxosHUA0ZN8c82i
         F7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057932; x=1789662732;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/P1Jv0DF4UzkIT1u26XRyNwrpVHhc0h6XCRRh+gwWEc=;
        b=S2X/Fno+++eeMiZzvGZkCqJhIcjhwVx0nwmlX26EWnbYRuYRMZ3ZJrev44+UfR1HB2
         HFpw1pQVfScpbvjKen8MP4OMMPGHJVCvxxONhbIy6eFHOu36/vVbYSIs6lTkhCJqNNYS
         LYe/gqiWHSXceVf5w+699gTv9e3D0gJzcxliFuNBLmAn1pawpW08MH3krLBmi212csdF
         SJnmCwkvU993bTkoqxB8cdFZ6EwsfzP0fKkP46jdzdAv78H4eQfqODblZbp1/f9J6cwZ
         F6R7Vty9Et7sfhQaHz1LK48UJztNOvfoobn2cRf24TSy4/F58iggLfnxdCK1IEfNa1Kh
         60yw==
X-Forwarded-Encrypted: i=1; AKwUvBxcL8Lt8w36d+TPeajLADSkUPcDsA2q2IxDlOItzVm4NC58cSLEcyzqvYGFEtsMDUOE9BbFmLA=@vger.kernel.org
X-Gm-Message-State: AFuF++nR9Z52UOGazlIOGL0tjwC/7Z1OhOga3S0dft3leKDu2/PYKVT7
	ZlWiUV3qCgwhk74Nih0bMRe+co9bl3CdRn9EXCyiL7GlZwLeMTeYBVgvsXSxmSgC2ahKvYWCXAD
	/kDGVjqJKosU9ZA3FLv7QTrZ8MWFwuiL56vQ6yqEAxPycO0I4egOPj3GEHNY=
X-Gm-Gg: AYBFou0kyCiWlTiAzsNZcWRydeGxKk3m1RojYxiDRw/aIYSf+xN+UAF4sUwb9udsGnD
	UCULJBhsGbHQ2z6wmFzxpK3zEJy7LNA759dLJTPiNC+DSbfpyj+ZBqIdWZdIP2urA9Lb8pwu+QO
	KjY2Q0m1JCoNnadeKZezYO/RwfnNuDRaKeCIJiyNO5yKVihq00sBib+gzsuKtYQ5BMmEtD8wu4d
	Olue9VpoK6qZO2NrKGCdDFEz4XehmImLOQ2EKcAfmS4/3NPEHhYcBJcTOEh6XSWpxaOUe4nJSPh
	5FY/Hm1RSH545LlqC70gIik3B2aRFXVOntQnpgubY2heqh9HxL8vAWrgnkxacQr+FsdXbbSdiNM
	41DMB5vb9Wbkczw==
X-Received: by 2002:a05:6820:8584:20b0:6ba:3635:8010 with SMTP id 006d021491bc7-6ba36359c46mr10463465eaf.67.1789057932485;
        Thu, 10 Sep 2026 09:32:12 -0700 (PDT)
X-Received: by 2002:a05:6820:8584:20b0:6ba:3635:8010 with SMTP id 006d021491bc7-6ba36359c46mr10463418eaf.67.1789057931956;
        Thu, 10 Sep 2026 09:32:11 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c38e3asm90572365e9.9.2026.09.10.09.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:32:10 -0700 (PDT)
Date: Thu, 10 Sep 2026 18:32:10 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>,
        Thierry Reding <treding@nvidia.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
Message-ID: <aqLbikuYvneJcNjj@lore-desk>
References: <20260907-stmmac-ptp-error-propagate-v2-1-4a2e8e41e860@oss.qualcomm.com>
 <20260910075213.1c9aff98@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DcyQ1168CK4VEaSG"
Content-Disposition: inline
In-Reply-To: <20260910075213.1c9aff98@kernel.org>
X-Proofpoint-GUID: SKUdg_81vkuCBkBZo92soMtymdDPXxyz
X-Proofpoint-ORIG-GUID: SKUdg_81vkuCBkBZo92soMtymdDPXxyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIwMSBTYWx0ZWRfX0htQUHbJhcR1
 AvwgkYduSrnXpqEHpAWq7XFOKkcCnJPW/L1PmyN3NNmxuCHhqExDONRF3aIcWPWFER5jaMk/rcu
 hawqWJVNfByP3zDR2t2E0zR6zRAULpb/SpPKA18P7y5bqo21PNwTvxA8Zh9axibBFJhMQXBBAU6
 odjTc7j7ohSppkL6XdKwhIyWNO3ucCCD2DM9TQkVcd1Pwb7+qCp2sfVhlwIksa8+TsisMMKZejq
 +yWDeg+kmFfRzvthLLosIhhiNzV+RDrIt9m5SgjKJdc2zBkh6WbnYemgDBsn8EVP54OYMA37yBb
 FpsEXn+y0vsND8wXI9Z1bHTpPPmxm1zVFkCqfo6sEm1GVtZSTghTqYSpYisID+6mXiZyGld2gMF
 3GkYUiswmdfY0ozZAWF7OmUp9iABG1y2xdcLnaA+aPIKYYOXS8wxGtfZBWyiP++1Vrw3aLl5gH5
 GT9CrFIr5Kj7IsW2VlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIwMSBTYWx0ZWRfX/qrX/JOPSRfO
 ysBdJxWzIISwmxJywQ/KGDLn//aH21iIHtwQFTGRgckSjLcPnDeUm5SuVdkjPcA06qd4PXSktZx
 N0vb3jo6fsaL05YGbn9H5Bc8xjLdsyU=
X-Authority-Analysis: v=2.4 cv=a56lZkSF c=1 sm=1 tr=0 ts=6aa2db8d cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=zKpTHd943Rx03GREjosA:9
 a=CjuIK1q_8ugA:10 a=vQJXkPjffEpyFp3C77kA:9 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100201

--DcyQ1168CK4VEaSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 07 Sep 2026 13:50:46 +0200 Lorenzo Bianconi wrote:
> > stmmac_setup_ptp() returns void and swallows both PTP setup errors:
> > the PTP reference clock enable and stmmac_init_timestamping()
> > failures are logged but never propagated. When they fail, the MAC
> > system time counter is left in its post-reset, non-running state,
> > while the driver keeps operating as if timestamping were up.
> > This matters for TAPRIO/EST qdisc offloading, which derives the EST
> > base time from the hardware timestamp counter: arming the gate list
> > against a non-advancing time base would leave the schedule permanently
> > stuck.
>=20
> pw says this didn't apply at the time of posting

ack, posted v3.

Regards,
Lorenzo

--DcyQ1168CK4VEaSG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqLbigAKCRA6cBh0uS2t
rAz5AQC5mqUXWQW5lWcrVqX8VwH7UExQ5V8EJae67/Mr1xrXJgD9EZlnC4/Qpq+0
SYzMVRkB1CBnFcHX4kIqKAF3WpxH0w0=
=phU3
-----END PGP SIGNATURE-----

--DcyQ1168CK4VEaSG--

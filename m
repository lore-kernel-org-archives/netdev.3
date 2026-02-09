Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3CC25F984
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659747; cv=none; b=kZMRD/6UTFkDssItJFwOga3gWnHioOIfgACyhsuNCVPBufpBkashWcCbRXuQ2y0e9JAi8D7bcPesbh4WAVZtgP0zB/q12J1Ogtlmm/rexcoBLSIE9J67n+Jpnnw7HL+1ISKXHUzxR4io02eSZ5gWK2u2BlJyvbq3yKrUzWlMUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659747; c=relaxed/simple;
	bh=EfVHrbdF8/yG09IBQ20HHyfnxAzay8Gf5YSnWq6tV7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pJ+hUkwLv9gAlQHo5xMrdh9wPrC+oMriJik8g3eMwQjfpVRLNMnrfECYZJmbzFVdIW3Tu08IiTWG42kEvLHVnsmm2Hb5kn7EArI67ODHgt6/wImFVktfGkWmtbULvN0WQwyFTrbdtEBfge96NuXOqDhUxZ+rXEfhtO2ZGpv/mJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Bn8cJZzv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Bn8cJZzv"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619HGiDu1007540
	for <netdev@vger.kernel.org>; Mon, 9 Feb 2026 09:55:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=EfVHrbdF8/yG09IBQ2
	0HHyfnxAzay8Gf5YSnWq6tV7k=; b=Bn8cJZzvLW+ub4TphsBLMPLV5SKHguDedL
	Pmr/Hz0pmdWlvaYIizESDJUnX0Co831psKGBQQP41MVXquIaEmOjLuY72489pEX6
	uUkIYnTEbMesvCrCMfsz2ngkU+bK8akRc0WLolTjnE9uiHlyem7KOcinTdArb38n
	6h5krBnqhUPSD5MMnsZDiO6TNDmvrhzi/B2JOOXf7huOHvhMkRGOd/okchsUNbS7
	4p/zdTxoqlJnjamaY+JedKvDKb8qGUKL7jcxN/T5gte3S5yGJpI5XouIn5dwzkn7
	lsiQDkAZmgxTzp49aAvAQX9bEBMXpWHJLQhmz7c6/UzGA0Zp4nRg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c7f1vv68y-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 09:55:46 -0800 (PST)
Received: from twshared25002.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 9 Feb 2026 17:55:42 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id A763A100D0418; Mon,  9 Feb 2026 09:53:18 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 0/2] Retrieve tph from dmabuf for PCIe P2P memory access
Date: Mon, 9 Feb 2026 09:53:10 -0800
Message-ID: <20260209175317.1713406-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=dIGrWeZb c=1 sm=1 tr=0 ts=698a1fa2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=yWaUcmrBNUFKcz5DFYsA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: JQSXUkVrLdLhttEMWH1uBoYV2Uzi7Z1R
X-Proofpoint-GUID: JQSXUkVrLdLhttEMWH1uBoYV2Uzi7Z1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1MSBTYWx0ZWRfX6a/nAce/WHnG
 Rff3H/uZUdh9RoUtQcGz0jxRjVEp/SqP/UlC6XKFCDyjO/1OOodb/8HDANmLerdv4A5xi2Ik5p5
 dOtS0twsAz5hsXqiNOETcFq3gAQOlzEyj+8UP/k9+FMAm+B19WNLpO0FCTHCi1yY4CfR5i7wp97
 GifLtLC/1fBUW9bleAmQ7NLCR9lQ64V/rfGf09uQlYvlMuBF6OU+ksf64zQRbKu3NW9To2AFG0B
 FtworlP6LNi2zCpQQniX4vlhkmRVna7ynoNskfEnB9YvWinvw2Sm4fWK6WudZmSDFbWDbA0vfDC
 TntGf00dzoBEgPhP8WO6ENtdcKbbFEfruuogLDNtHDhkjUOnvagPBemuw9LvmJJLktQlTINF2iD
 +TtLDYYolNPvkdfubPP3ZWC6v4kYF9yA66lzQ1Sc1wkYBxUq7khi/qQzwVMGsPu1Xk3QUOvqxFv
 e20StAralPkgH6h7IJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01

Currently, the steering tag can be used for a CPU on the motherboard; the
ACPI check is in place to query and obtain the supported tph settings. He=
re
we intend to use the tph info to improve RDMA NIC memory access on a vfio=
-based
accelerator device via PCIe peer-to-peer. When an applicantion register a
RDMA memory region with DMABUF for the RDMA NIC to access the device memo=
ry,
the tph associated with the memory region can be retrieved and used to se=
t the
steering tag / process hint (ph). The tph contains additional instruction=
s
or hints to the GPU or accelerator device for advanced memory operations,
such as, read cache selection.

Note this RFC is for the discussion on the direction and is not intended =
to be
a complete implementation. Once the direction is agreed on, we will work =
on the
implementation or a real patch set.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

[RFC 1/2] Vfio: add callback to get tph info for dmabuf
[RFC 2/2] RMDA MLX5: get tph for p2p access when registering dmabuf

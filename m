Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214853;
	b=kLoM+xlFOfLElnhtoUdOxKaPaeIoAn0MCEXYaYy0+WRwhqPI+GAOWlWshLhGD6EHBdiV
	 XtM+8wC8sWe3OKR5H8jmt8wEcskgA3JzPw+WpyKZDP14DUImRrGBRWNUa3zWZmQWfqnaX
	 msKkel0X9FhtUtBM1VJ1KPyMuD6HmiNF8K4OyW+/oOEg+x8EVv/97eHKhmHqFN6DCZH3W
	 bcTYpJ7VQPaui1hk9K0GcV4KU6VYaEg95q1etslL7erhDiG92DNdt6g3bDK/vnnAJd7Hz
	 FmyIOV5sFiU+2/QPjNBq1xddct27jsgsSXip8Kc/IyldmtUTnOFqQXnzUPlXfqw2I2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214853;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=M3qhSf+pCcjyV4GewqSUeDdRXL+jOt7T3AJXgM8fBOI=;
	b=saoyRn9dzC7zp0Sh1gYCi9n5zlHlQDhYTfuBKvCkvl0/RKo745vQZuumbE0aynDYV+za
	 306uLZyjPhjt86imL7CS/7NtUUSZpgZpC8xWp7bIyw06aSTWUuyIQ/YNCjrHOC6hxl5CQ
	 0TPqH8S3RqRZ5wE2Waz4bChKJbPL9AwJVLv7nBtenJ0S3G5G9YgiXl5hjaaa8JD8iFNFD
	 3MNyYyxf+WHR8e2igKQeL0CPqiqkwfFTMPPw1ppeJ0OOzBeagJRXyabtqL5fR58xeUY3I
	 XHtQdTOlZ9HZXq3yChV1P6ucB5QM51VbEDozvliW8JjTaEBvs5KruJEZk0Tu5uXVo8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=XYQYVs66;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="jV/x/qkm";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84239606A321;
	Mon,  9 Nov 2026 09:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84239606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=XYQYVs66;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jV/x/qkm
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96BuMq3169932;
	Mon, 9 Nov 2026 04:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=M3qhSf+pCcjyV4GewqSUeDdRXL+jOt7T3AJXgM8fBOI=; b=XYQYVs6
	69iiG9iRhneYs+gD0N+NxoKxSulKG4oUTIgsojw4nl753k8wCfDn4KWAq3xRSN8O
	92Nx0FqQAL+Y5rezCwNmnn52M8ADeYJXjhBLQqlsChUrTD3PiJcOlkmvlJ4dsA2x
	v+mxilLE43PzwG3gUBrjh50dOFBRgIryV0yE3oYXkumd67I1/67Vd7wnNPG1l9A4
	2/wlPipkBOIe9Bhr/amrL2oqEJEReg63gouw5woZycCm1EHBwG7RQbWkqsoVuFXP
	LPcm+h00JoSSJm547QUt5ai7xAR0+KrCmPMb+fCZXDpohVHk3I/ZkrPSwiVQ9B2u
	u4evZJYdNPQWLaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=M3qhS
	f+pCcjyV4GewqSUeDdRXL+jOt7T3AJXgM8fBOI=; b=jV/x/qkme8+36nD16SeK1
	x5thqm8mCu34kLCFrh5UTXznZYsnXbuuzR9DRLKevyYGO4C0K5Dg1RLD9QBCuu1Z
	rv1waEEoL+V8nVGNfsuzDaQt7Hq/uILIYmLZyUsyOB3iThUnRAijAKSOLsw4Iw+Z
	8Vc9elPoZHRQ9adyVisnwelu1SRwOrVPuI2P1JSsYzQCi5RrSOgKMSC/PqcoImAO
	Z/vZDHKcgfuhQN/syUFAlT9AjhagvyfdEdQDOgVugfRG03nehPa7HS+1YUZ9EH7N
	V7/Mjdrte/hSn8Z4pnEZiCavrrOOg2ydeW+GSQoHgS9jCzRg3sW7saWTf5gYF7+o
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ht1s7a8qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 04:00:21 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A990K63032012
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 04:00:20 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 04:00:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 04:00:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 04:00:19 -0500
Received: from HYB-6AVb5If9qTU.ad.analog.com (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.41])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A98xreG024796;
	Mon, 9 Nov 2026 04:00:14 -0500
From: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>
CC: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
        Ciprian Regus
	<ciprian.regus@analog.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Iustin
 Stolniceanu" <iustin.stolniceanu@analog.com>
Subject: [PATCH net-next v2 1/7] net: ethernet: oa_tc6: Forward declare struct mii_bus
Date: Mon, 9 Nov 2026 10:59:46 +0200
Message-ID: <20261109085952.105331-2-iustin.stolniceanu@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
References: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=c4A+0h9l c=1 sm=1 tr=0 ts=6af18ba6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=kGO4wbbgxORi5zMqEYgA:9
X-Proofpoint-GUID: k6NKNCqlbesu1-O-ab5Hh8dMVzDkxZEu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX/Dlc9e/I+XEV
 +ad8bwkpzomawUY65PhBuYGS3Et02OQtuzSxhGZAjvEs802HVQZTyWzqlhInO5u2avfPXVgMHbB
 8CCVMDy+Pnby9IkQR0VW7bCJZafepUka1ZBGZ8iJT4vqbTxX3sK+HniABSvE2pxxfUjC10WsA84
 95tIFMNhiu1sL4d4HQLbW2ojDrGpHHrcD6qwhXrsZL89KwRCcWg3i5zKQfWNb2wjH3bga9OCJyu
 ziOylao6wTpZ+ZLydCagU7dVJk40C4w21v/r7FH/V/s96fvrrjPWmJ+L0c4LxKjmtFVC0M/NADH
 r/Iau8XLjtBjJalgVnV8bpsLqsoOochNGzwzJM8hRrG88qq6GS+kU6UDwJEItqdpDuDAYE2ElUX
 EHqfkEwf247VZOYbu6vj2OWUCpJ/X5QZvx0Az7ptgSNGlVG8ImpJKDPT1ZaN8MaUeSlNkmv8CC9
 ILJqiKqjHHBgc/uZ4Hg==
X-Proofpoint-ORIG-GUID: k6NKNCqlbesu1-O-ab5Hh8dMVzDkxZEu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfXxRL8z7/re5Xp
 NrbK4AL5T9esllU66mwN99JOgglcrEF4EmLOyMdUcVZURJZqkZ4q0z3sF9pmhgjwR/kYY2jHSb+
 HnhwI2RawnDk1FS0QwkMF2DkgiaCuWMV6AxBRqn6IClNrTuuBu5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090035

The Clause 45 MDIO accessors in oa_tc6.h take a struct mii_bus pointer,
but the header does not declare the type. A file that includes oa_tc6.h
before linux/phy.h or linux/mdio.h gets a "'struct mii_bus' declared
inside parameter list" warning, which is an error with CONFIG_WERROR.

lan865x and adin1140 are not affected, as they include one of those
first. The adin1110 driver, which gets OA TC6 support later in this
series, does not, and hits the warning.

Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 include/linux/oa_tc6.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 27f652d4920b..6eac6b842156 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -64,6 +64,7 @@
 #define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
 #define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
 
+struct mii_bus;
 struct oa_tc6;
 
 enum oa_tc6_quirk_flag {
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722195;
	b=392G4IcEeyQJZvQMO9sR0Ia+eoLpXpSH4kEQCRGMYBK+wDYPkvrYq6f5Xtr0xbkd5xEM
	 QJqBpvK2QPNyoQERj5H9gpacc8l4lAhOsftT9OuH0Fq/bx2M+IxOaTvq7GKKVchy5XyzB
	 IUkE+hK6kZg2QRGSethj2udP7Rewqtn4VZzdUmIviBnLQ8rytv3ltLzQW8qYELaYld360
	 VXICy0fFhxMh9yl1l8eMAmJu3SQ4o6sRoOX9Xzn3QaPhCMQL0eqgzvpmPW2eFmzF5RfNU
	 FDGOfOmY70o7XEZ5HqNPTbXsiJY2st9rcjtsLfcR9yHLi1LJtBkDADyk59F8Iky1ayQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722195;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OuaWZW47xa80VtNZN87PeC+6cZFmNIOYvLm/e8xzNxM=;
	b=GJBVscW4RynB4K6DSKOod5pe57L4Mul0BUXEfuokFQTB493v7o+jvCTTgVIaC5Am3OAE
	 CXThvLlOKYn0iKwQf5G6fGH54pQdHu9w7/HlSoBidf4WpVPkVp5kWeA+x9Te17d4lb3j4
	 h7cVJlSm44H7bkJkUw80vea0zOLYietyFiaVU+ErBVs0mF36fr36jKY5kiIxWq+P5CWT0
	 mlG1jkCY2oe784AqBvQ6845ukd9FpaKYnonm0+cJ3tuHpsk1Jxj150MQQDUJdnbODE6QG
	 cN9yZtR9E20Isl59PKp0IhdiTc09jhRGVLEmDDqzeJLL0cAnwBoz8ocgBWDvab+Ji5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=b4GSPEAZ;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=JQniEtXy;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB2606A324;
	Tue,  3 Nov 2026 16:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAB2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=b4GSPEAZ;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=JQniEtXy
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E7Rx42823013;
	Tue, 3 Nov 2026 11:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=OuaWZW47xa80VtNZ
	N87PeC+6cZFmNIOYvLm/e8xzNxM=; b=b4GSPEAZdFsN+osqikkg9SZfdYRSVBbb
	q1l+AMuBEVv7TZZRmbvWWoCdAp7ywGFDWzgkNIPXJimXo7J/aKTrW5h+hV4Vn1Ns
	XSzvqd04goNqpA+aEkdi43hETz/g7yzcQXSKPoHHvUvFOAJIVYi82FXGJKLoZFt6
	/ssTYS8GQ68Qv8kvIxwBWeVNtULs2Lky+/loOJmaIh4xh235yirvrUcVfDLQFpbH
	Scl+6GI5seTyIlM/oBL6sxMDE7TLaI9V7arRn9hg9vgDlFyG/UCmAVw4X/mkmiEL
	65wSCvUiz/VztQMHnxElKlj+JqxQZPMj0ysDcN9aUMei9JZiRxPsyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=OuaWZW47xa80VtNZN87PeC+6cZF
	mNIOYvLm/e8xzNxM=; b=JQniEtXywB31y/YBAx7GWX8QQseR4/Gt32eyubs3Rcv
	tcXSFfRwdPWwMw+/OVf+2v+Aqnj4AyPXyOvVeC1KbZSoT1qYnmcUXyPnwpFB/Jem
	HscZGgprKm7U2JR+KuElaCPT5/05RenV6bEyf2i3cxNFCzgU6C+J31bDRNWFUBNO
	/7NeVIYp4Rea7XqwZaivsXV4eGg1x43ICFyOjzZueIPFXGQqVYjuxeaFiHJ4XXHq
	EJN6OYKdS1gh8rb3yIj/7xWCHRcKg01xgWcsLTSwfwrWcGXBge5/nytipZG2qz3V
	QRQMT1oK5QdOcucktMNpt+yOlJO/rjyUQGW3hwwJdKQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hq0trx22d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:09:40 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A3G9doc003109
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:09:39 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 3 Nov
 2026 11:09:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 3 Nov 2026 11:09:39 -0500
Received: from HYB-6AVb5If9qTU.tail230d3d.ts.net (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.49])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A3G9KcM032393;
	Tue, 3 Nov 2026 11:09:25 -0500
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
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Subject: [PATCH net-next 0/5] net: ethernet: adi: adin1110: Add OPEN Alliance TC6 support
Date: Tue, 3 Nov 2026 18:09:13 +0200
Message-ID: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX2W4LJhhh7nQM
 s+exXm7a3VizBDGr183ed6uUh1xs9E1fbBDUHvFZWrZVa7KE45JsUvwZxvY7fICmvi6mUoIXHei
 t049X2ARW9HLk/TEbhpWqD9FekM0HR5/giMzk4JBCY2VwVTUVBW4iJtysfpvIFNbJI08u1kn6hh
 5EcNDVCtf0merwM5x4Ds/HHwxhsBgyi7nq4fB/jIsvuXX9XSPTGd/0Sl7SJinzZVdf+uk5X4YpC
 o6mpcJHLm2H+fKEURz38xIxEfAUErEl1MFlr/Wubx+/yTYw9c5IvZHAMBumaz21SFARQUHUD7+E
 Z0rgOO/G+lXkwARH+9Lp3emJevp8FKz0wmbkkPyfqjJPOtGM36l+UQuMC633rLax59D/jOAI4xD
 xpcfpH0MR71+rwN+bsU3y+GiJtoqcspHDaXyhNwzUvAQdNTlFZtMsR2wJXATnM67Z5Z/RV0zBUv
 +i4dGDpvHukCEpP/sGA==
X-Proofpoint-GUID: LoiRJ7TGOlTUax15GRWRQDLp_FxrEz87
X-Proofpoint-ORIG-GUID: LoiRJ7TGOlTUax15GRWRQDLp_FxrEz87
X-Authority-Analysis: v=2.4 cv=P/OvFSAu c=1 sm=1 tr=0 ts=6aea0744 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=czmgoKAXU1_dXEfi6xsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXyXHOgRfTPPb9
 fG3En3V5t7RBYEXxUMDzo+0eY2wJhO5GaEtDwmgGHrl/pcRpWX1gz4CpEDcQlqKh+Itebwha/IA
 kBPdGZ7QKD9P4y/5JJIM1dHyXa++DHsmCiziAtPDWcFvAi2cb5u8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030064

The ADIN1110 supports two SPI host interface protocols: the generic SPI
protocol, which the adin1110 driver implements today, and the OPEN
Alliance TC6 protocol. The protocol is selected by the SPI_CFG1 pin,
which the device latches when it comes out of reset.

This series adds OPEN Alliance TC6 support for the ADIN1110 using the
oa_tc6 framework, selected by a new adi,spi-oa-tc6 DT property:

 1-2: oa_tc6: configurable reset settle time, and indirect MDIO access
      (MDIOACC) for MAC-PHYs without direct PHY register access
 3:   dt-bindings: add adi,spi-oa-tc6
 4:   adin1110: add the OPEN Alliance TC6 probe path
 5:   adin1100: skip the soft reset on ADIN1110/ADIN2111, as it resets
      the whole MAC-PHY

The ADIN2111 is not supported in OPEN Alliance TC6 mode yet.

Testing: Raspberry Pi 4 with an EVAL-ADIN1110EBZ, SPI at 25 MHz, against
a 10BASE-T1L link partner. OPEN Alliance TC6 mode: probe/remove 20x,
link up/down under traffic, frame sizes 42-1514 bytes, flood ping,
~9.4 Mbit/s TCP in each direction, 0% loss on 10 Mbit/s bidirectional
UDP, kmemleak clean, also on a debug kernel (KASAN, lockdep). Generic SPI
mode: no change in results with and without the series.

Known limitations, unchanged by this series:
 - A "Config unsync" error (e.g. after a chip reset) makes oa_tc6
   disable the device until the driver is reloaded.
 - Secondary unicast and multicast address lists are not programmed
   into the MAC filter, as in the generic SPI path.

Open question: indirect MDIO is used automatically when STDCAP.DPRAC is
not set. Would you prefer an explicit quirk flag instead?

Parts of the code and of the commit messages were developed with the
help of an AI assistant (Claude Opus 5.5); all changes were reviewed and
tested on hardware by the submitter. Patches 1-4 were also reviewed with
Sashiko (Claude Opus 5.5) before sending. Patch 5 is too small a change
to merit a Sashiko review.

Ciprian Regus (4):
  net: ethernet: oa_tc6: Allow custom reset settle time values
  net: ethernet: oa_tc6: Add support for MDIO indirect access
  dt-bindings: net: adi,adin1110: Add adi,spi-oa-tc6
  net: ethernet: adi: adin1110: Add OA TC6 protocol support for ADIN1110

Iustin Stolniceanu (1):
  net: phy: adin1100: Skip the soft reset on ADIN1110/ADIN2111

 .../devicetree/bindings/net/adi,adin1110.yaml |   6 +
 drivers/net/ethernet/adi/Kconfig              |   1 +
 drivers/net/ethernet/adi/adin1110.c           | 186 ++++++++++++++++-
 drivers/net/ethernet/oa_tc6.c                 | 189 ++++++++++++++++--
 drivers/net/phy/adin1100.c                    |   9 +
 include/linux/oa_tc6.h                        |  18 ++
 6 files changed, 388 insertions(+), 21 deletions(-)

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722218;
	b=Dz8sDI8NrnqOR7FKlFOp24SUgCJiRu9MekiBK+9het7bz2b1zATUhhZbK6XHf+URmg3n
	 TUHj+ctnO+WLI6eMnAco5kfmjyqmkGcRKF8YzWY1HAVhD7iUw3RhThd5azYZbEASGYrDq
	 3vRYgv4JyOuaia7f3LTVUX8lQ7T578rV8pb4RvulNOTVtslmYwOHS2qRQ3J9SZ2hXMRl1
	 OL/3QHVTetMvKOqxyfLU6GLA7m5DKkQQN4GrRCD1e94FfEN2Ju2rM5E2Va1POZWo6SGit
	 IlLkitaSmkZGXvnB7Vsn5eLpaHl5ctNoMfeXZxaFzEDlnrzLF8QypJ192IN/MCsU3yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722218;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hohM6ubqOwK9rt9w432+HjdUJT7WDOjI+cWU9ybhUGE=;
	b=YXLpKvE35r4CWm3AsR/9EXtuJsC3XXEknyW6/nnKmTSkLFktds1kRyOPx8j3G6OmT6n1
	 Uf6mZAC0IMJPlks/yEgfoJHllgRjQvwasJR9g6C6mCfHNc9o15lIlOqFvjYVZe6RnK5h8
	 qNd0cOgwUmNfi+iiynd5ubgZGTsfp4Upo49y6lYtBQiPrVpsJNstGm1TIYsTkqOg8rYfa
	 RTkSjFzQfCKYoEWwq+cYg/jUTgyOMN/wjxs67z2TaqY/As3N80Gh/m/Q6txrgnpGoMY1j
	 hzOKRBeOztiaXCEzFaC50ryKdxccLqWug6+TtIz4xN5GXRo1Fgi8HU8mwwSmBxXsBnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="t/uZi4Td";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xU0hJ5EX;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499D606A333;
	Tue,  3 Nov 2026 16:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6499D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=t/uZi4Td;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xU0hJ5EX
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E7CYC244918;
	Tue, 3 Nov 2026 11:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=hohM6ubqOwK9rt9w432+HjdUJT7WDOjI+cWU9ybhUGE=; b=t/uZi4T
	dKitwpJuohFkYkGzdwmimCDHX4vs751eAmeceyTsKC3Dpeo0aNRE2FEpLVlBbpjw
	a92eI+FDX2LezCBbPlpAIPXlXNQS7Ks9nDLvgzhh2tILT1N0admzvhPPX1Vyp9JY
	ZRPYs48GF40ah3k52R3ylZaEb5cHUaTWF2YuUJ/JvmB1ddy7VQ1lgkjl/SXO+VM/
	VbPDS7cerQ7JUgSLM4jQNmWPt4ENsGIK9wBvSwjHevedspMyVirNrcDNCPlKkFaY
	dVVZjmJCgAr5w2JvSREvIDadYkMdun4juL7gEGxlh+j/OhM2K8OE23SjnTM7itAj
	xMbtzo4NsZ8a91A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hohM6
	ubqOwK9rt9w432+HjdUJT7WDOjI+cWU9ybhUGE=; b=xU0hJ5EXkhsPZLmb+jyZ5
	ojGfN6U0jGRvspy3Y8/UhGNGplgNtU46LRnqnEa5eru0ZisiYr2L/T7I8O0og+vS
	8EFI+o6759FWoJqwbRmn7ah0Hwa+rYkgZqNHbhBTDQGRbqrecUiN8rtjq+TZxhpM
	4BqyEpCl0t7Fa6XtEHMJTszeo+xNejEiEt4czmrSTnqGv8348FqsPwOi3yA8XMoJ
	AjxRRB6RLlEyWokKXvKroadeUIE56mJbltCpD4oyWcn4SKh0jbuVn3kYsXv50e5j
	mQF1LrkpwyWYsA7qzWMkCBLqMuj+K+69kS7pyxw7FbBAQw3xIoIBkslEKyfqfuaM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hq0nnp3gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:10:08 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A3GA7xN003127
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:10:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 3 Nov
 2026 11:10:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 3 Nov 2026 11:10:07 -0500
Received: from HYB-6AVb5If9qTU.tail230d3d.ts.net (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.49])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A3G9KcP032393;
	Tue, 3 Nov 2026 11:10:02 -0500
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
Subject: [PATCH net-next 3/5] dt-bindings: net: adi,adin1110: Add adi,spi-oa-tc6
Date: Tue, 3 Nov 2026 18:09:16 +0200
Message-ID: <20261103160918.409701-4-iustin.stolniceanu@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
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
X-Authority-Analysis: v=2.4 cv=XIOl2ghE c=1 sm=1 tr=0 ts=6aea0760 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=5jv5b5KtEm5ENIyIVKMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXwaypRJs3dYun
 Y4RRl7mBqBvT7TnucO5z9DEeYqbcYN+VPofLyga8fV/EaUDcALSkp1KXMfj4QPyyn2UDN4KmLq/
 SYEZtLhAIcIl1gOrth8wHvAet+4QB9DAo0Gd7dakC0D7OtlZh9lQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX35IoespH/83f
 xgXNaGB138PJVKFU2kNswAYXzN8LwrFmhZqdFe6QqGfXQ012OGpc1IaXHDJL37Xt//D3ZAyRuXL
 rmbQWPL2gzqzBZiB537jMkzoVB6o+mst8aM2jCrDcefd0e5hJsPTvEEIf0rMgwS3LtNPy5BcDB/
 zmAuPwmfhnrFK0jVjSXN8+T6KHFPHGWQ1R+sf8UcU539zjGytRXV0YT5vS39hqwGF8bmCXZSbat
 Dr2EpXac+SmzLP7XZFopuqKOaF8hDjK3dF0OfYay60oJ6Fy2/QcvzLe0NUqVziNw3iwpRWPrD6F
 G//3huPXLPv+4mv3nSeY8n4qG/85zzZdmqBiiVmF2vy05YfXy8WnM6c4E3EEnFwuszE1VowEPLo
 b5vQ1GuS+oP5WdVrfMEMSqmT0DUyHBafAaGNA/WEpa3/zwa7bSsXNrFXWhERiLk488xbjYW2n5r
 tehqujHpU1Ru0mUPmxw==
X-Proofpoint-ORIG-GUID: FTBL3Vy1MoZv9hf8zQO6WbMlQJCjy0pW
X-Proofpoint-GUID: FTBL3Vy1MoZv9hf8zQO6WbMlQJCjy0pW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030064

From: Ciprian Regus <ciprian.regus@analog.com>

The ADIN1110 and ADIN2111 support two SPI host interface protocols:
the generic SPI protocol and the OPEN Alliance TC6 protocol. The
protocol is selected by the state of the SPI_CFG1 pin, which the device
latches when it comes out of reset, together with SPI_CFG0, which
selects CRC (generic SPI) or protection (OPEN Alliance) mode.

The protocol is set by the board hardware, so the driver must know it
in advance. Add a boolean property to describe a device configured for
the OPEN Alliance TC6 protocol. Without it, the generic SPI protocol is
assumed, as before.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 Documentation/devicetree/bindings/net/adi,adin1110.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,adin1110.yaml b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
index 0a73e01d7f97..e19b6c94708d 100644
--- a/Documentation/devicetree/bindings/net/adi,adin1110.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
@@ -43,6 +43,12 @@ properties:
       Enable CRC8 checks on SPI read/writes.
     type: boolean
 
+  adi,spi-oa-tc6:
+    description: |
+      The device is configured, through the SPI_CFG1 pin, for the
+      Open Alliance TC6 protocol instead of the generic SPI one.
+    type: boolean
+
   interrupts:
     maxItems: 1
 
-- 
2.43.0


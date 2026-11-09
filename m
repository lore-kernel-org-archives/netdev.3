Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214852;
	b=3dN2nF3ymywXwtX5FF57i0+cyPeSCra0BQn8W8hLtFBRh3CY6brHYiTm3tP3+mhD9WIl
	 96woUwL8F1hksqip/ykxV4D6mkS23iG/kb93xqjC73sSM+5Oac/ANDAXUFyS7L+2aDYmd
	 gSGyc1DlXCsq08z8IpGmj0gSRut72QEIZV1nx3xdjgB0WGDHEPwVxjf/AOGua75oUXy8L
	 LTe2HVni9pOSMGB6uGqOlCVQYG5oaZI3hQuXa7tuw5Yi6IXq0Uq1JIIT72bTsnZZqu54f
	 tw6Lu/B9HjXyB2NTi7wWxlEpTfVTp1UnQS/yX9PvFexYiovvwi8CYtQ5xVXU/+waVUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214852;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5cQRvkXNtjJAnko0WWY5a15d0+AvbQkqet34XcNU5HA=;
	b=F6oep+jzWax6piV/vdzWAdDFkmWXl4/DqPY6EdUOXeJCPSunibXGLOJBDAbH+SO6OoC2
	 D7/euAosnUVTnZm7bH8wlD0CQo6hvnM2wQs64KV0j/xH4R7BCOdx5UuPo3v+4b8bJHtoD
	 5sWxH38njgph2mqRh6F206GaD8xey2o+0N+NqkOaEPUrzBu1VPpJbBPbyf7sBtmY8AXa7
	 sQ2E+Sk7NNUiCpbQa9QTl0Gg5xg6m0rXLhvEKeoB6ADFRSxZ632M2fPq+PcvKXjKuP+yK
	 8cI7Y9KPBj/WA2P892hA4ujaG42q2mtWS9BH+jaV6t3klAcEjhf72JBm270E/eexAsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ampd0T+T;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=L0leps9C;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B37606A31C;
	Mon,  9 Nov 2026 09:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37B37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ampd0T+T;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=L0leps9C
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96C3iM2401967;
	Mon, 9 Nov 2026 04:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=5cQRvkXNtjJAnko0
	WWY5a15d0+AvbQkqet34XcNU5HA=; b=ampd0T+TjOLux4JH/4qX4C4LcP8uzC2d
	8o/gh9GFvp5qOpy4/n5bv1pP/e13p5PwWLRGNyZkwtEH7wBqDe5gqQozGJHnXpO3
	rZZiVb90lQddwrMJqrzMtmfUB2ibYQZq4VgOo2xRyBDXontsFOvT5N+DCkdV21wE
	Jsv4//LFj3b66khmLtgksIy6ovzGCz83ZAa3rWcCeNoFg+LPrjGV8LWjx87Fc07/
	P0Nmd76mfkjEq5PPqu9ueyw6/Bm1AjQ4mDR7p0c5iSDbuoqy2NLDx+pwEcZNhcLh
	c81Y9ZZTgSe6ln3svNMFboYiBec0k2NkIHZSpE00sg8feo3d4RBVxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5cQRvkXNtjJAnko0WWY5a15d0+A
	vbQkqet34XcNU5HA=; b=L0leps9CWulFAeBkmRzwu1R1yVlsAKS5pEIFE+MM3mQ
	jfoBgkfY6CBLtq5Z0bBbiBvXWUP9yY41pBQPA5xD6XaFGJy+gdv7NvvVucAPls7b
	reop4P0UZfi/sEtXDuknie79SZoeAJh96L7idF7lrZzycwjAtcRpYA5Ox0FxD/YF
	0H0DNmsL3cRR1ZEsqHfCsGL84k2F58LnHtrzZedHbKOv4kuTDYMb4K6DqWOq33uA
	LKAoxdCJaBgi/x4V/hh+VCWSBZpeTq6AhqDbQvScdqc+nselecby9nfC++df+bLk
	KnVci5it+8ucH2WoJM6Cl/KCmoeAC2F/QAgkd49NUJQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4htk6je40r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 04:00:14 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A990D8v045687
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 04:00:13 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 04:00:13 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 04:00:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 04:00:12 -0500
Received: from HYB-6AVb5If9qTU.ad.analog.com (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.41])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A98xreF024796;
	Mon, 9 Nov 2026 03:59:58 -0500
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
Subject: [PATCH net-next v2 0/7] net: ethernet: adi: adin1110: Add OPEN Alliance TC6 support
Date: Mon, 9 Nov 2026 10:59:45 +0200
Message-ID: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JVYHGvlzRz_wvuc7DVOj07o5X7dWnzBm
X-Proofpoint-GUID: JVYHGvlzRz_wvuc7DVOj07o5X7dWnzBm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX2LU24/J9QWKg
 JsRlomIgAlRw4ivgrgx84jxI0LEO80mGNHSUgLy+LW1fssBOf7ExD6FHgRGj9jfHDebXFeTrTOP
 R7MEkFCBFqEB7sEkLyopO69hrNSIztlawmsGuoePX+fkRYNK+k68
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX+o6qdxuHfq85
 ywrZ4y92M6/RxCMmuv7P14xLD/5O7e2z3Z/w50UORLXIS9J/wImTiZ5C2vS1XCyxE8P4Mtic9kb
 pei6+rSosMsX9M6M4wQb03DcCjRj9IIg+m6QiKmarWj7SB5DYiuBFtBd/RW18IjArAjvyw2dPN9
 d53OJktkfKdliGG47nOeH0kYAPlgt+ZaM/gcBBhmGEKPptWrXQrc9921AZnLD552uIoEVjGN1uB
 QL4FrhJu/abTuYuFZBX5ODm/sVrrhIvTSrwgS8v2e4+I2m5NEetvSz8WaiA8KHLoy8RUY/J1wps
 2zWMUqwpZ5SoI05/XXuu13X4tRcCAcJ9AwJn1BT8KgCKDGvRg8DQ442LF0K2wUgWxHrecx23eyP
 5EweAOvbfSW/KLN64UYqR88ugMU6RPIOZFYopyIJnrJaU+rKvyxXnDLKPpEcDUDXbZsKzUwWK8A
 F+QQUnB58xeHq0cP/XQ==
X-Authority-Analysis: v=2.4 cv=O7+sLx9W c=1 sm=1 tr=0 ts=6af18b9e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=iT5Kz9XhaAhAbwJ0Y2EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090035

The ADIN1110 supports two SPI host interface protocols: the generic SPI
protocol, which the adin1110 driver implements today, and the OPEN
Alliance TC6 protocol. Two pins select the mode, and the device latches
them when it comes out of reset:

 - SPI_CFG1 selects the protocol: OPEN Alliance TC6 when low (or left
   floating), generic SPI when high.
 - SPI_CFG0 enables the CRC8 of the generic SPI protocol, or the control
   data protection of the OPEN Alliance protocol: enabled when low,
   disabled when high.

SPI_CFG0 can be read back, as the PROTE bit of CONFIG0, and the generic
SPI case is already described by the adi,spi-crc property. No register
reports SPI_CFG1, so the protocol cannot be detected by reading the chip.

This series adds OPEN Alliance TC6 support for the ADIN1110 using the
oa_tc6 framework, selected by a new adi,spi-oa-tc6 DT property:

 1:   oa_tc6: forward declare struct mii_bus in oa_tc6.h
 2-3: oa_tc6: configurable reset settle times, and indirect MDIO access
      (MDIOACC) for MAC-PHYs without direct PHY register access
 4-5: adin1100: separate phy_driver entries per model, then skip the
      soft reset on ADIN1110/ADIN2111, as it resets the whole MAC-PHY
 6:   dt-bindings: add adi,spi-oa-tc6
 7:   adin1110: add the OPEN Alliance TC6 probe path

The ADIN2111 is not supported in OPEN Alliance TC6 mode yet.

If adi,spi-oa-tc6 does not match the board strapping, probe fails with
-ENODEV and a message pointing at the SPI_CFG1 strap and the property.

As promised in the v1 thread, I tried the wrong framing on an
EVAL-ADIN1110EBZ in both directions. OA TC6 access to a generic SPI
strapped chip gets no valid reply and does not set SPI_ERR. Generic
SPI access to an OA TC6 strapped chip returns garbage and sets HDRE and
LOFE in STATUS0, which are write-1-to-clear, and OA TC6 access keeps
working afterwards. So the protocols can be told apart, but I kept the
explicit property for now. If autodetection is preferred, I can do that
before the binding is merged.

Testing: Raspberry Pi 4 with an EVAL-ADIN1110EBZ, SPI at 25 MHz, against
a 10BASE-T1L link partner, on a normal and a debug kernel (KASAN,
lockdep, kmemleak). OPEN Alliance TC6 mode: probe/remove 20x, sysfs
unbind/bind 10x, link up/down under traffic, frame sizes 42-1514 bytes,
flood ping, ~9.4 Mbit/s TCP in each direction, 0% loss on 10 Mbit/s
bidirectional UDP, joined multicast group and macvlan traffic. Generic
SPI mode: same results with and without the series. Both mismatches
(adi,spi-oa-tc6 set on a generic SPI strapped board, and the reverse)
fail with -ENODEV and a clear message. OPEN Alliance TC6 was tested with
and without control protection (SPI_CFG0).

Known limitations, unchanged by this series:
 - A "Config unsync" error (e.g. after a chip reset) makes oa_tc6
   disable the device until the driver is reloaded.
 - On unload, a lockdep enabled kernel prints a "suspicious RCU usage"
   warning from phy_detach_internal(), as phy_disconnect() is called
   without the RTNL held. The generic SPI path of the unpatched driver
   does the same.

Parts of the code and of the commit messages were developed with the
help of an AI assistant (Claude Opus 5.5); all changes were reviewed and
tested on hardware by the submitter. The v1 patches 1-4 were also
reviewed with Sashiko (Claude Opus 5.5) before sending. For v2 I ran
Sashiko again on the settle time patch (2/7) and the adin1110 patch
(7/7), the two with real code changes, and fixed the one real issue
it found.

Changes in v2:
 - Reordered: the adin1100 patches now come before the adin1110 OA TC6
   patch that needs them, so the series bisects cleanly.
 - 1/7: new: split the struct mii_bus forward declaration out of the
   adin1110 patch (Alvin)
   Link: https://lore.kernel.org/r/au3C27DWOcZiMLxb@analog.com
 - 2/7: split reset_settle_us into hwreset_settle_us (default 1 ms) and
   softreset_settle_us (default 0); fsleep() unconditionally (Alvin)
   Link: https://lore.kernel.org/r/aus8XiLynJmSXaXc@analog.com
 - 3/7: use if (!DPRAC) mdio_indirect_mode = true (Alvin)
   Link: https://lore.kernel.org/r/aus8GQ-Xut5XBNwU@analog.com
 - 4/7: new: one phy_driver per model with PHY_ID_MATCH_MODEL() instead
   of a single entry with mask 0xffffffcf (Andrew, Alvin)
   Link: https://lore.kernel.org/r/309a1eb9-8255-42f0-a510-b40bf3302bbd@lunn.ch
 - 5/7: (was 5/5) omit .soft_reset on the ADIN1110/ADIN2111 entries
   instead of checking the PHY ID in the callback (Alvin)
   Link: https://lore.kernel.org/r/autAidTgykOObtzp@analog.com
 - 6/7: (was 3/5) disallow adi,spi-crc together with adi,spi-oa-tc6 (Alvin)
   Link: https://lore.kernel.org/r/aus899mJ-XZg6ZgF@analog.com
 - 7/7: (was 4/5) set 50 ms / 10 ms settle times from the datasheet;
   -ENODEV instead of -EOPNOTSUPP for ADIN2111; whitespace nits. Fail
   with -ENODEV and a clear message if adi,spi-oa-tc6 does not match the
   strapping (Andrew). Accept all multicast when the multicast list is not
   empty and don't set IFF_UNICAST_FLT, and use DEV_STATS_INC() for
   tx_dropped (Sashiko).
   Link: https://lore.kernel.org/r/aus-LdkVRPxR6lFu@analog.com
   Link: https://lore.kernel.org/r/c1747691-2c2e-4a7a-af04-92c94cb041b2@lunn.ch
   Link: https://lore.kernel.org/r/sashiko-outbox-197578@kernel.org

v1: https://lore.kernel.org/r/20261103160918.409701-1-iustin.stolniceanu@analog.com


Ciprian Regus (4):
  net: ethernet: oa_tc6: Allow custom reset settle time values
  net: ethernet: oa_tc6: Add support for MDIO indirect access
  dt-bindings: net: adi,adin1110: Add adi,spi-oa-tc6
  net: ethernet: adi: adin1110: Add OA TC6 protocol support for ADIN1110

Iustin Stolniceanu (3):
  net: ethernet: oa_tc6: Forward declare struct mii_bus
  net: phy: adin1100: Add separate driver entries for ADIN1110/ADIN2111
  net: phy: adin1100: Skip the soft reset on ADIN1110/ADIN2111

 .../devicetree/bindings/net/adi,adin1110.yaml |  12 +
 drivers/net/ethernet/adi/Kconfig              |   1 +
 drivers/net/ethernet/adi/adin1110.c           | 206 +++++++++++++++++-
 drivers/net/ethernet/oa_tc6.c                 | 188 ++++++++++++++--
 drivers/net/phy/adin1100.c                    |  33 ++-
 include/linux/oa_tc6.h                        |  20 ++
 6 files changed, 435 insertions(+), 25 deletions(-)


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.43.0


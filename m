Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821983033F7;
	Thu,  8 Oct 2026 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421048; cv=none; b=Y5cxv2zrwzwX3jDRTx3+FBJj29oEyxQ9C8SqANKN9uNpL05HY+pntI1XY22cZ4dZiD7D31c7fBvR/Zt6PmU9nRGjajDq6hZ7Doi5PBMXhxfyNzhk5zLcBE2LPEPLOyUyvC+d5VbOGRsmcFfmTN0Q4Vn7Yb5iLkP86vwLUdFHhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421048; c=relaxed/simple;
	bh=q6aqTcPApwoZIH99lg+gmqxeisLInlIv8sHdIheY+l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqEEt6SK7e2fkzgFrv13/jjuU9jPLFgUMn8h2tfVgG1LB+yF3cQWJR6zMoLGM6BJgjz1iFXP59kitoMKqML7pjHSNWdeQzEjYVjHVgPKAUXPWpl8JgPsh942HIfpPhDhW51PsbXiyzcsvLDq4RJyjvw6eREydu7FvX6yeYyFhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rnf1OTX1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rnf1OTX1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697LtcCr4151874;
	Thu, 8 Oct 2026 00:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EqRY0JvMDN+0milvFlxc64ylkS8xwlQMdLA0GSny/Bg=; b=Rnf1OTX1ui4/3muQ
	97oSXG3LdzMb6l6dQ5akn/FCENwmhnVjHa5c8ckWuNASClejameKGiew1HFdTce0
	hH0qpliMMMh7V79lQocuSK7kx+RtEzoUxx8E4cX3kHonf5VFST05y/mGafbIplUH
	ep12Isz38jVkG/yB+wN4fhAYLdx0z+QulCHqydfWktmadTjSAivIbXUpBjreAee6
	gFd9z+iCM74bZaRjKiCQXRMI/4tzX0MZsN/LHcxaed0aLHTZyrVOHEg4RJqANP3Y
	asnYEqNPd7fA7XQyfrArqWz8tl5C5FYYsiLo5qRVNXQ24cXdu5cClXfqd8t0eDFM
	gUT8CA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe38egx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:58 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6980uvXj1429389;
	Thu, 8 Oct 2026 00:56:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6980uvs01429360
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:57 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id C38DAADB; Wed,  7 Oct 2026 17:56:56 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v2 8/8] docs: networking: Add documentation for the coalescing support in rmnet
Date: Wed,  7 Oct 2026 17:55:45 -0700
Message-Id: <20261008005543.2630828-9-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: C01Q2O1VyNTyZpXtkwZZaTL_m2rL1TI9
X-Authority-Analysis: v=2.4 cv=QOz91QLL c=1 sm=1 tr=0 ts=6ac6ea5a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_MdbunYu9wahxpo5STcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX0tW/EdVYPD3V
 ejJKF4E++o4gHbSIXt8d505Nc7zmhWMJu4lwDDuLlCAUnHjHGxijMytTiAvf6Dfb8RqliVVqiuZ
 iKih3h9VUuyUxO62IYOp7rfz7r02p20=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX8eR0TIL3aSCi
 4Kp0YvWLfdBHjGl7+ZLhD9/2gQZ1tBuFgvucdW1fqvfVL5IbnWRSah1nprfk/8+et+yUXC4CG2L
 eCOAVOiaTjUEaZ93m3Io4uwc7sPwDPuIQepGHtNAkjafzQ7TGROVBTO2ncCl/5IdK2JJEozgaP7
 DqtDlXWqOQyMV1RNeOndTsBUOHd5U6pwjIwIY+f7WeaEZlINHSuEW2bQRLxByEFZgFpOWJLrVOu
 OeH944+zialkoyWs9j7f6eIHUpWKF9mHfBFJe5NNroCiVPL20+t4wHDqa9U1FZNdovq0CuEhhtl
 9cINb2FJvU4B+f9ZAWQ7JGal7o87XClt9jWW/OC9s1a+xUbyEjMLhjdi+Y7USKCSoLGq9DK62QG
 mjBm+rLNDtTmATngDvmpi9GGwWJ3mqDcTCll5ZIZQhcU7++y4cSx8Y6xta7UPEZckLj89DJlR2e
 3nHXyYKBRLe/NaDNREA==
X-Proofpoint-ORIG-GUID: C01Q2O1VyNTyZpXtkwZZaTL_m2rL1TI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080003

Add information about the MAPv5 coalescing header covering the layout
and the information from the fields in the header.

Document the IFLA_RMNET_FLAGS coalescing rules. Ingress coalescing
requires MAPv5 checksum offload, and MAPv4 and MAPv5 checksum
configurations cannot be enabled together in either direction. A direction
may leave checksum offload disabled.

Document that the frame-level CSUM valid indication is distinct from the
per-packet CSUM error bitmap. Multi-packet coalesced frames require RX
checksum offload and rx-gro-hw. Single-packet frames are delivered as
normal non-GSO skbs when those features are disabled.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v2:
  - Update the documentation and commit text to clarify the hardware behavior
v1: https://lore.kernel.org/all/20260930051345.857443-8-subash.a.kasiviswanathan@oss.qualcomm.com/

 .../cellular/qualcomm/rmnet.rst               | 153 +++++++++++++++++-
 1 file changed, 145 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
index 5aedbabb7382..52f92d2fba31 100644
--- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
+++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
@@ -125,8 +125,8 @@ Command (1)/ Data (0) bit value is to indicate if the packet is a MAP command
 or data packet. Command packet is used for transport level flow control. Data
 packets are standard IP packets.
 
-Next header is used to indicate the presence of another header, currently is
-limited to checksum header.
+Next header is used to indicate the presence of another header, currently
+limited to the checksum and coalescing headers.
 
 Padding is the number of bytes to be appended to the payload to
 ensure 4 byte alignment.
@@ -150,11 +150,11 @@ Header Type is to indicate the type of header, this usually is set to CHECKSUM
 
 Header types
 
-= ===============
+= ======================
 0 Reserved
-1 Reserved
+1 coalescing header
 2 checksum header
-= ===============
+= ======================
 
 Checksum Valid is to indicate whether the header checksum is valid. Value of 1
 implies that checksum is calculated on this packet and is valid, value of 0
@@ -162,8 +162,109 @@ indicates that the calculated packet checksum is invalid.
 
 Reserved bits must be zero when sent and ignored when received.
 
-e. MAP packet v1/v5 (command specific)
---------------------------------------
+e. Coalescing header v5
+------------------------
+
+Hardware can coalesce multiple same-flow IP packets into a single MAP frame
+to reduce per-packet overhead at high data rates.  Packets are grouped into
+NLOs, with all packets in each NLO having the same length.  The coalescing
+header (header type 1) describes the coalesced content.
+
+Packet format::
+
+  Bit         0 - 6         7          8           9-11         12-15
+  Function  Header Type  Next Header  CSUM valid  Num NLOs    (reserved)
+
+  Bit        16-19        20-23
+  Function  Close value  Close type
+
+  Bit        24-27        28-31
+  Function  (reserved)    VEID
+
+  Bit           32 - 47        48 - 55            56 - 63
+  Function   Packet length  CSUM error bitmap  Num packets (NLO 0)
+
+  ... (up to 6 NLO entries total, same 32-bit format per entry)
+
+Header Type is set to 1 (coalescing).
+
+The MAP header ``pkt_len`` includes the coalescing header, coalesced packet
+data, and any MAP padding.
+
+Num NLOs (Number-Length Objects) is the count of active NLO entries
+(1 – 6).  Each NLO describes a group of consecutive coalesced packets
+that all share the same IP packet length.
+
+Num NLOs identifies the active prefix of the six NLO slots.  The header
+always contains all six slots and remains 28 bytes long regardless of Num
+NLOs.  A slot with ``num_packets == 0`` ends the active NLO prefix.  The
+full coalescing header is included in the MAP header's ``pkt_len``.
+
+Some hardware may report Num NLOs incorrectly.  For compatibility, receivers
+should derive the active prefix from ``num_packets`` when needed.  This
+requires unused slots to have ``num_packets == 0``.
+
+CSUM valid (bit 8) is a frame-level indication that the hardware checksum is
+valid for all packets in the frame. It is distinct from the per-packet CSUM
+error bitmap in each NLO entry.
+
+For a single-NLO, single-packet frame, CSUM valid must not be trusted when
+the close reason is a FIN/PSH close, a packet limit, a byte limit, or a time
+limit.  In these cases, the rmnet driver treats the packet checksum as
+unverified and lets the network stack validate it instead of relying on the
+coalescing checksum indications.
+IPv4 UDP packets with a zero checksum remain valid because that checksum is
+optional.
+
+Close type and close value encode the hardware reason that coalescing
+was terminated for this frame:
+
+Close type values:
+
+= ==============================
+0 non-coalesced (single packet)
+1 IP flow miss
+2 transport flow miss
+3 hardware limit (see value)
+4 coalescing closed (FIN/PSH)
+= ==============================
+
+Close value (used when close type is 3):
+
+= ==================
+0 NL limit reached
+1 packet limit
+2 byte limit
+3 time limit
+4 eviction
+= ==================
+
+VEID is the virtual endpoint ID of the originating flow.
+
+Each NLO entry::
+
+  Bit         0 - 15        16 - 23            24 - 31
+  Function  Pkt length   CSUM error bitmap   Num packets
+
+Pkt length is the full IP packet length, including the IP header, transport
+header, and payload, for every packet in this NLO group. The IP and transport
+headers are present once in the coalesced frame and are not repeated for each
+packet.
+
+CSUM error bitmap is one 48-bit stream formed by concatenating the
+``csum_error_bitmap`` bytes from all six NLO slots in slot order. Packet 0
+corresponds to bit 0 of slot 0's bitmap byte, and bits are consumed from
+least significant bit to most significant bit. The bit stream is indexed by
+the packet's absolute position in the frame and does not restart at an NLO
+boundary. If an NLO contains more than eight packets, its error bits
+continue into the bitmap byte of the following slot. Bitmap bytes in slots
+after the active NLO prefix may therefore contain continuation bits and must
+not be ignored.
+
+Num packets is the count of coalesced packets described by this NLO.
+
+f. MAP packet v1/v5 (command specific)
+---------------------------------------
 
 Packet format::
 
@@ -187,7 +288,7 @@ Command types
 3 is for error during processing of commands
 = ==========================================
 
-f. Aggregation
+g. Aggregation
 --------------
 
 Aggregation is multiple MAP packets (can be data or command) delivered to
@@ -208,3 +309,39 @@ rmnet userspace configuration is done through netlink using iproute2
 https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/
 
 The driver uses rtnl_link_ops for communication.
+
+The data format flags controlling the ingress and egress processing
+pipeline are set via the ``IFLA_RMNET_FLAGS`` attribute
+(``struct ifla_rmnet_flags``).
+
+Relevant ingress flags:
+
+``RMNET_FLAGS_INGRESS_DEAGGREGATION``
+  Enable MAP frame de-aggregation.
+
+``RMNET_FLAGS_INGRESS_MAP_CKSUMV4``
+  Enable MAPv4 downlink checksum offload.
+
+``RMNET_FLAGS_INGRESS_MAP_CKSUMV5``
+  Enable MAPv5 downlink checksum offload (header type 2).
+
+``RMNET_FLAGS_INGRESS_COALESCE``
+  Enable MAPv5 downlink hardware coalescing (header type 1).
+  This flag requires ``RMNET_FLAGS_INGRESS_MAP_CKSUMV5``. MAPv4 and
+  MAPv5 checksum flags cannot be enabled together in either direction.
+  A direction may leave checksum offload disabled. Invalid combinations
+  are rejected.
+  When RX checksum offload and ``rx-gro-hw`` are enabled, valid
+  multi-packet coalesced frames can be delivered as batched GSO SKBs.
+  Otherwise, multi-packet coalesced frames are rejected. A coalesced frame
+  containing one packet is delivered as a normal non-GSO skb. IP options,
+  IPv6 extension headers, and zero-payload packets can also prevent GSO
+  processing for a frame.
+
+Relevant egress flags:
+
+``RMNET_FLAGS_EGRESS_MAP_CKSUMV4``
+  Enable MAPv4 uplink checksum offload.
+
+``RMNET_FLAGS_EGRESS_MAP_CKSUMV5``
+  Enable MAPv5 uplink checksum offload.
-- 
2.34.1


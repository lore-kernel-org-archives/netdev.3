Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397983FE37C;
	Fri,  9 Oct 2026 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535514; cv=none; b=X3jo5g8RMvGT07XyG3FFrS28REhm/qEhPV/4OApn89KOmeb9gI8rRMkOSHPEsGr3XFv+ULz07z/8FPnbiQSxseqQiB/FvIGMf6kEhKenbM/REUSpy1iKXvkLqWZcQRAQE0Q8HjaHErNcHQFfL8G3YLwad8wgCmHfPQii48/rWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535514; c=relaxed/simple;
	bh=JaIdaxXfdJDPiiZQklzBMYKx62B8zoyDlv4i139wMwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLbUzIHkwX0eJRf6OD4lCYflvGWlYFfxqC+h6JA4tsJzDct3VE2/tBmxeib6bTY4QJ8HfQVXq7Zkqq/Jh/IOCv2RQEbVgRDLKA4/e1XP0KA0vtFFLRTIgq5z/9VbuGliA2pKQ9hNCynTHA5M1YYPN+ZO2JQ6nwpa7MRsyQ+NfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ELw6qFPd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELw6qFPd"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KFHS906806;
	Fri, 9 Oct 2026 08:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OdfteGWj2zbncy7if8skYKN61LNf3q6gCDwaQZnr/rc=; b=ELw6qFPdanPJY0GI
	RdJ+5nEDlBle96RGkfeZdm9ipQwLtVmdCYjkO8EukQXP3UjlUQjU93C3CKgbFIDB
	I7c75KYX91nk+FXeS0C+T1+gftxErwK0U1Q664eZqp8Jle5EUgPncyAy0GFwAkXJ
	RPTUaxIKYTXb3rj3Qrnb8OXdv2r/dVl8wXGAlqsl7R0hh7Tl0Sw8QH1F/OxE40tl
	iiYQgCWzWL8B0FxiEs1SN0QSusREt6VRsSP30ixnhiKPUzmAcdoCCbPC4QTvokbE
	giG/8/UBeKINMb5KCxyMUzhTsxzK+TfqMr+7i+KEIvybqawlsrUJZpRRcsdjgGAs
	bXUK+g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqtu99-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:55 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998isap265926;
	Fri, 9 Oct 2026 08:44:54 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6998isnT265614
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:54 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id DFD1EACA; Fri,  9 Oct 2026 01:44:53 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v3 8/8] docs: networking: Add documentation for the coalescing support in rmnet
Date: Fri,  9 Oct 2026 01:43:52 -0700
Message-Id: <20261009084351.317632-9-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009084351.317632-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20261009084351.317632-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfXyswo9oD20GxK
 MeAXLZpARMI/zY3ALFesFWqeyQHfHoMhTY/LEeV34aZDJ7ACFoAJcxkbwn5VDng1CaRHLE0/fxx
 IL9eDozFfz7XusdudE/0yEKGyM+QAq8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX2WedKa9d3gv7
 J/sTcwMR34pWIHN+ZlBDBQyuqZ/6WMr0fBTnG/7MrEjLhyzSGMT8PHhy8RUSpagn5l0mzI0g6HT
 dsa0J98stuU3sX3o+wf0CQMhglvkciGVDOY9Knqwp1KdBdGH4d2muimtjNzGNwsELUnYX4tbLkk
 QLBc+/ZHiYhKMiij5gRPb2TAV9t9tJuAqjIkG8MiRexCkem0F2lFJBUeRYULGxfcKHDOFHux7Bk
 DwNe/Pl92JFm1hDa6NWIwAizC5s9FnSKLgpBPhI6kiC+SVIShgeFAuNzNIVW5MiVhN/9oHHdxnA
 GUg+DwAZK+yMGTl94IdStzm1z4y8/Osad1iuK589M55kHhp+H/SmG99Wlub2unp7p2yYSYqIdoI
 jjVWjwKpVOO05MSwRZagQbcOUsOZOl2Rc5LEgCFGBTD7AxWLHoxCTFd0/R2eoVvPGdVZeuFvcf2
 qW1ey4ytkQNR+xhagug==
X-Proofpoint-GUID: Y12_8nrnBrGWjUyFuqEmOy0Z5mMtew9d
X-Proofpoint-ORIG-GUID: Y12_8nrnBrGWjUyFuqEmOy0Z5mMtew9d
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac8a987 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_MdbunYu9wahxpo5STcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090034

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
v3: no change
v2: https://lore.kernel.org/all/20261008005543.2630828-9-subash.a.kasiviswanathan@oss.qualcomm.com/
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


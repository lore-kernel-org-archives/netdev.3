Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5513AFCF3;
	Wed, 30 Sep 2026 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745299; cv=none; b=WZcIA9nVJnU4v3xLvoRm1C1EDt8uEY01GDKgtpZzQ4rjnn4JDnfPLBhuED3SbNEe77vdbCzhFVCu03zRj8e4SemFoOjrdiCXuVYVsoKQo1HE7iQ0bFifkSOrL0V0FUp6Uq70pfc1JaDwBzFzNdNN8twaRT61i5xaQMzJfQcPHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745299; c=relaxed/simple;
	bh=d2t9HPv2sFS1cev1wesohHSN2v2vPPyqILUP1vyLSdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOur9c8ri3SftYY0Z+mBCQAr9RuAURmoMium3LuZrRpZAXgpeZTs8kxa/snUcGw2aCmSfp5oiFl410ByP9o6tW/skF2yOebtO3vZNnTGQjbihlLewMwPQVnUAJ3OrZAFjhJUqpkANyPYveKvqW7a4pe9r5ErHzSv3pAwY/JSWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ikr/pGhH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ikr/pGhH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U2PNV41522917;
	Wed, 30 Sep 2026 05:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TWhKAYNZ3pd4AMQZ5AGLMiUH/S4wqSuKd9PSgfBM32g=; b=ikr/pGhH9+sEiKXw
	RZB2vxbyCO6U9P6WF/pOwp3IEVbXkVXadngc9629HCyWEI9NxTGTdkhna0JT4vQ9
	8YgJKiglZiIhqMXzDxOTQksrJeVAlHr9RbR/+k8TWiLC2bXb2jND83AieI+NOlJk
	k2l0Dsi30O2vYFOsRhwgIFaeSUUPcXWjzCYZYrgLxweRauUreC+XetNcQTUvAWDo
	1K4zNVRcZitZSFkAcpRFnJ5UTmoEyxQDhmGRLNc/yNtxZmYCYbwTqG4gwJYFgVR2
	KkMk8DeAR85zFjzCige9zFI6fcJXxJAE8X+EykO23s6XbLbmSgWQPHjl3UD0tHtG
	w+UpNA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjgn5s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:40 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U5Eedh1571324;
	Wed, 30 Sep 2026 05:14:40 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 68U5Edhb1571316
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:39 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 8702BAC1; Tue, 29 Sep 2026 22:14:39 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next 7/7] docs: networking: Add documentation for the coalescing support in rmnet
Date: Tue, 29 Sep 2026 22:13:45 -0700
Message-Id: <20260930051345.857443-8-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX4n09f3qbm2S5
 PVwZob75vl6rRdK0AMTZR1bI7ALFgOoyGY1GeEYM0hF0CBgifCWk7+1r9NaRVd9jeFkTLIfFzX/
 leZKmyHsmMZmTqJ6vGhD9X/Ajcf9cuU=
X-Proofpoint-GUID: od1NJ4SBnotcoRAW24_hiLHGWOTiHB72
X-Proofpoint-ORIG-GUID: od1NJ4SBnotcoRAW24_hiLHGWOTiHB72
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abc9ac0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sVPlsHBCrIiDMYByxr8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfXytr+tsUZG9u5
 fSp/wVZlWCt0+vdPJnY5/KExDS/C46XxutOclVkGewd8cktped9HrPOWl1FAQMn2InfWB0OeiOj
 iRNLimXyxm4159+pnj8+M8v8sfrBFOK51KNXUt8AurondqZ74ZVaQibYUafVdpTaIvgO5W/rcCx
 DWL7cs8Clrl8RS+pUC/DHxij7XCoXCodLqKP5C60aZgR/NRa4sWI+Ya4g2BNEIf783GFFnnRBVP
 8cCfwfs9ux6IjDEL6vuhgak6st6E3BCn9lC7FzzM9QF+3BBU2TqAvEaCtiD1gRwrArczgRzNC33
 K6+3WWxhona1TiVkbwfCPaibtH1P6Qczf3mEa0OIAt9auLnFlmIEiC9676SLmwAbNwthFlhOCST
 60KC1Nv6eaMbG78t7KzP2SdZMuVu8/Nv/dmC8mSzms2dBoHmrbRKve+AIX9GTFGnrw7PTB35sPg
 29TzlQbCz4QJekcVE3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300020

Add information about the MAPv5 coalescing header covering the layout
and the information from the fields in the header.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
 .../cellular/qualcomm/rmnet.rst               | 115 ++++++++++++++++--
 1 file changed, 107 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
index 5aedbabb7382..ba8e947d54e6 100644
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
@@ -162,8 +162,78 @@ indicates that the calculated packet checksum is invalid.
 
 Reserved bits must be zero when sent and ignored when received.
 
-e. MAP packet v1/v5 (command specific)
---------------------------------------
+e. Coalescing header v5
+------------------------
+
+Hardware can coalesce multiple same-flow IP packets of the same length into
+a single MAP frame to reduce per-packet overhead at high data rates.  The
+coalescing header (header type 1) describes the coalesced content.
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
+Num NLOs (Number-Length Objects) is the count of active NLO entries
+(1 – 6).  Each NLO describes a group of consecutive coalesced packets
+that all share the same IP packet length.
+
+CSUM valid (bit 8) indicates whether the hardware checksum is valid
+for all packets in the frame.
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
+Pkt length is the full IP packet length, including the IP header,
+transport header, and payload, for every packet in this NLO group.
+
+CSUM error bitmap is a per-packet bitmask. Bit N is set when packet N
+in this NLO has a bad checksum.
+
+Num packets is the count of coalesced packets described by this NLO.
+
+f. MAP packet v1/v5 (command specific)
+---------------------------------------
 
 Packet format::
 
@@ -187,7 +257,7 @@ Command types
 3 is for error during processing of commands
 = ==========================================
 
-f. Aggregation
+g. Aggregation
 --------------
 
 Aggregation is multiple MAP packets (can be data or command) delivered to
@@ -208,3 +278,32 @@ rmnet userspace configuration is done through netlink using iproute2
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
+  When set the driver will decode coalescing headers, reconstruct
+  individual IP packets and will deliver batched GSO SKBs to the
+  stack for efficient processing.
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


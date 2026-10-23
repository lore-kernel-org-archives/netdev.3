Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739957;
	b=fWZVbWezzkP63Lr53DRpSi0zA7jugJvSDY1QDsjb48A9u1wgSnL2zRjnBjB5fHwkSujz
	 5K6BsfYyYZ5Oc+4A59E0lCooJnDjNV64+BF1BBED3dkIyKqPveq/PpayZcVAR54DUNrBx
	 iVEEHCqA6Fjws1sevDSC2LGqLNiIsYrlt3/Ha+cosiFZVKhTA5rOJ+XdXWcA+FiFJghl7
	 TAkJehAiVp/P16hHpEllW7QArXECKMOzFLME4WUVdhNSjQKjUTb6fAyQn7115rwcrOc1P
	 zRGGuHABl3/UpBreeXXZUjlJ40z2q9qSUc9aL97KZBUMBo/rdCY5d2LHghyauduJO1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739957;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=sjBoBNagG3bs/Tn74GMqC6JSYkQzxcT48nSaPWKgX/A=;
	b=r9maGk3zcXPBMqNZ3kBIW1mUICxe1X5M6b1xxDXEl3VE7pwsLCPx544CFWYm18IF+kzv
	 Iu4s8RoYOMcJODQr59o4D31vylT7XssRcgwlhrbDYTMXofwhgTikgtCl2R1ILcicL98Hf
	 vY2Oy61QKmVOE5W354NNm9aFYJk+62G+KKHNROM9+ukpPXUEo4RgKNZKTPl44vHfwgmRp
	 SrROTcwxRyBmUrytZWfiszkJhO2eeDfiQbgAzg7MBxV6MbjsjtLoPPVoO3aAs9n5lki3p
	 WJSqMvSJhQbXqdT+silxupEI8ReVvpfmURGVBqXhmH7Rca6pma+ZtB++gHnkePFBxGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=FfuOtVMm;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A468F606A31A;
	Fri, 23 Oct 2026 07:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A468F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=FfuOtVMm
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Dto02770028;
	Fri, 23 Oct 2026 00:19:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=sjBoBNagG3bs/Tn74GMqC6J
	SYkQzxcT48nSaPWKgX/A=; b=FfuOtVMm6oqKEn7U7sH3ROuaQQ8IQbIyfuhdF1h
	jq/hsapsTingZpy+OollKqUp7KNCkyWD3D9Zafd7oWOtSXhDJySOqp7r9WO+Jft/
	n2h1sOSfU1usAyxYHI3vJElZYv9qwOiFBg2d+di7DMF1T2W3j6B97/yNr95iyI8C
	MafVeyRsA/H7v4k0UaqiphFoUHVFyCN66sUWSj7n3FRf7YAQ6WfvydK2ZWnxU/Be
	G6fGMWZ+h9FyxpDANklVFREs7vXkckUAEzT1/NXMBUP/iyrElnsFNgHiaewP5aDQ
	UVZYS+U9Gx+knCnrbvUs/eFlDA1QUdAAc75zPzzsvIrh5KQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hfv15su1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 00:19:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 Oct 2026 00:19:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 23 Oct 2026 00:19:08 -0700
Received: from sjc4ccscust-vm07.sclab.marvell.com (unknown [10.110.24.160])
	by maili.marvell.com (Postfix) with ESMTP id 319125B6923;
	Fri, 23 Oct 2026 00:19:08 -0700 (PDT)
From: kmahammadraf <kmahammadraf@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Kiran Kumar K
	<kirankumark@marvell.com>,
        kmahammadraf <kmahammadraf@marvell.com>
Subject: [PATCH net] octeontx2-af: fix inner LC ltype match for RSS flowkey
Date: Fri, 23 Oct 2026 07:19:05 +0000
Message-ID: <20261023071905.2922825-1-kmahammadraf@marvell.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: _jtWFSjQaFDWC-DWL13Rs9wTDpIdo4nn
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6adb0a6d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=a7OA6jbs0lbN1ggfU4QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX9zEstZeMfmQj
 cLyDU0ITf7X3ADi2mwB/g9XDEBBezM9zOOg05vwAeIiygs3vt01rtpnURIcSh7Z5dtrgkg6LTcs
 T3VENpEckOp2hdGvtHLS7WJ9vQrPauY=
X-Proofpoint-ORIG-GUID: _jtWFSjQaFDWC-DWL13Rs9wTDpIdo4nn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX/wEvw7I/DVMy
 oTtMV2KSuUBIeLpUfLbYA5aarKbwfwOdCYDog6owD5xswwuTTz34PerCpqrz/2BMiSjAZHFb1sD
 zD6VFGohmQG723dY9vP7XhUJKob6G/EtnpDwb3+Yr5mS6uOW9mDgsKM9pldw+bWfgKb5RpJY7yG
 4cuJUyFPHh9fQ9xIEg3aTJ4MDrpXzt7TdBGy5+UBhZe6u1yrHsnLoax5MhJSQ+JqYmX/Abt8cZA
 k9TzHvYUQhWuDT54L8pOcrIe/jzQskyLGJ7uxfXisAxvCm09GgdyLGyI3jsPKdxKL+8dWavDlBN
 e0Pm45dZnqXUgM1VN1UiBiiO6wMS5MtB3vSKzi6fzQ9hA9oKzJDEAn6KYDYBgOP5o0XAgjHZfFA
 3C7m55+VxB9bogmsUQnQO2iad+qRgIu3woUFTHytRSvx9dySPNhI/l63nDI6KMNYjaA8umqauPe
 bYFgPLZU7JFHDn6HmpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01

From: Kiran Kumar K <kirankumark@marvell.com>

Inner LC ltypes differ from outer LC ltypes, but RSS flowkey programming
was using outer LC IP/IP6 ltype masks for inner IP keys.

For inner IPv4/IPv6, match only the base IP ltype and do not include
extension-header matches. Keep existing outer LC masks unchanged.

This fixes inner-tunnel RSS key calculation and prevents mismatches in
inner IP flow classification.

Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
---
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 95f782d47927..9cace7c4c9e1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4112,9 +4112,12 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 		case NIX_FLOW_KEY_TYPE_INNR_IPV4:
 			field->lid = NPC_LID_LC;
 			field->ltype_match = NPC_LT_LC_IP;
+			field->ltype_mask = NPC_LT_LC_IP_MATCH_MSK;
+
 			if (key_type == NIX_FLOW_KEY_TYPE_INNR_IPV4) {
 				field->lid = NPC_LID_LG;
 				field->ltype_match = NPC_LT_LG_TU_IP;
+				field->ltype_mask = 0xF;
 			}
 			field->hdr_offset = 12; /* SIP offset */
 			field->bytesm1 = 7; /* SIP + DIP, 8 bytes */
@@ -4133,16 +4136,18 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 					field->bytesm1 = 3; /* DIP, 4 bytes */
 				}
 			}
-			field->ltype_mask = NPC_LT_LC_IP_MATCH_MSK;
 			keyoff_marker = false;
 			break;
 		case NIX_FLOW_KEY_TYPE_IPV6:
 		case NIX_FLOW_KEY_TYPE_INNR_IPV6:
 			field->lid = NPC_LID_LC;
 			field->ltype_match = NPC_LT_LC_IP6;
+			field->ltype_mask = NPC_LT_LC_IP6_MATCH_MSK;
+
 			if (key_type == NIX_FLOW_KEY_TYPE_INNR_IPV6) {
 				field->lid = NPC_LID_LG;
 				field->ltype_match = NPC_LT_LG_TU_IP6;
+				field->ltype_mask = 0xF;
 			}
 			field->hdr_offset = 8; /* SIP offset */
 			field->bytesm1 = 31; /* SIP + DIP, 32 bytes */
@@ -4162,7 +4167,6 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 					field->bytesm1 = 15; /* DIP,16 bytes */
 				}
 			}
-			field->ltype_mask = NPC_LT_LC_IP6_MATCH_MSK;
 			break;
 		case NIX_FLOW_KEY_TYPE_TCP:
 		case NIX_FLOW_KEY_TYPE_UDP:
-- 
2.25.1


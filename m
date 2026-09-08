Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8671569F2A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887405; cv=none; b=JuueZm0K6Y3I41gcNumLzWD7mKKBoidML6rIsU+c2fzZQLn7tAgN4xIBRzhvepLW6ODTLkpB5wLO/ITmRMYe7ljxU3WwxYVUA0vv/fEiD1Qb229x6DyR2wSkFFW/gSZiITVONCR/DQ2tgfAm7FCu/HyKkHRTKAdh2GhiYgxFtD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887405; c=relaxed/simple;
	bh=xH0xcj/8vIiYjyrGF1xp0a3lv3Ll1FQIuJAs54n5Sow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CPxZzH1zGek3nqdSlsDNjRrZI7etPsDaupvw/sI4voSyhmQvR0DQv2NcwdjqeYFAr07B8+AnVaK8Gbx89TrPTtlVrIZzpRuRpVQfZla+CVK8xxd3I6bO5rgWcaRDDosxu7IZRMcuHVeX41UFh5oL/XBuZJQPWIAZ/HrS//IOP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KIA2kuej; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hcvNpse8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KIA2kuej";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hcvNpse8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdWA22769550
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QAf9itNhLtoKXsIvPQiM+O
	g4kU/n8TuTmvbZbJIJQWQ=; b=KIA2kuejdhBELiQLFKUdykIsdAv/7SznyxK//N
	WBc2bJQMmEy3xv4W8t2PPR/ijjBiYh1E9bLXBDfSSl388WBdjWBdNB3A6EVZifQp
	zWnOXcybqnLzZlOoFtam+401Q/OAO5kiI/ASyIvAhNPYxg5BohQIkVIuzmYx6R9Z
	yd+vd2Ht27LaTI0o/pLK2DHj6UWfzehtzL/3KNZepXclAhAXH03ePj/rTN+n8Ss9
	y02B/XE0c9IM0s3MfzBhtyNW5BWcfbn3fhFxE7JEzDac7Mog711FZJ4YnZjfN25O
	6Rjh5yqlO0vuFAsgco7+mUfsIleiTB11MHJQYqkObAiBlNew==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjjvuh92c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:10:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso2986653a12.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887400; x=1789492200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QAf9itNhLtoKXsIvPQiM+Og4kU/n8TuTmvbZbJIJQWQ=;
        b=hcvNpse8/M1LowOwQbfAdA6fZTouMAaQ7MtxhIG3AIJXCKtEg+rFDFBW4cZxqQRnqh
         WImubI6lFr0TNsVHkTq9YnTbQvfhLOEj0T6Q+w0SOXrMFOC5Joxxa5ykWVPAHBvzDBVx
         RIVKhIgywzKDwXAMZsNtO6zCLo/I/mzFyGvXQs0fUcNLplP4BKP4UnIvmQNXeRIVui8T
         u64UC9G8ppwDslBPnYiKEcfxpIVsbkDNWv2fDAFEzVOQ7ivy6duWWjI+mdCz0oz2OPKG
         PHWG5gcd+vz69KhzFsI6AwYCTIgij7HhFUcs4sYZQsNEA124otXKYku9ILaIvk2cOd0y
         UrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887400; x=1789492200;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QAf9itNhLtoKXsIvPQiM+Og4kU/n8TuTmvbZbJIJQWQ=;
        b=Ew++eqbjYcHJcSXG3Hpm5QwIwo2tWEQKAurhI6DwJq5hjOz1d4bgivq/jDBeR6XDGO
         W4plExQCkvmkL3+UT5WuJOGN/9lTzDm/AbGXyYjCUxrQb2hGzAUdZBtuyJoQ8glx0fMO
         FmpRTY/XqBZ1Fk4PAk6LNFWerLZfJ7N9vEIFF5dnblr1MZbduUbGmZgrFGtGw9K079Tf
         td/ahT/UdVRjQ78SaxqoS4vLfQVvg0QxJUbWuue6fmfbbw/lMzdCBab4F5bvVABGFaaZ
         XJ1aFw9/6iKKcJgaNEp4LF6rQZ0eTVkmXryT9zFEBFYyT+GArNmISUdzVgYCUHWjZ60B
         XjLw==
X-Forwarded-Encrypted: i=1; AKwUvBw3U4gZAhBDECyeqTIgni0UVBBSimYT3WJ+fbCyZRLO8P5PIE1hLD+VZBPg9Wz3IlgxJgp2yrE=@vger.kernel.org
X-Gm-Message-State: AFuF++l5NoXH5RFYqHP7eqJjSwXtwcSsieUrnJjo2AD6/SJosXVtz3iB
	wbam6XaCEGGP90BNJD4btbvOeiicjJRQQsZlMsOyfnE+a8DiTrr7RdSuXp+Q8TYff3SqcgxcJsr
	lFSFNExVOyZxs2tZBQDZY5kXUeLaA9h6pFrtcfgkx98lkHPq6dS38hA+4ig==
X-Gm-Gg: AYBFou1gwC77rY+d0B3BKf4NOidAm88QjAB69FeyvcoBIsg04xhrbXyaL534suCy/Lh
	ArgnBYpREDkRwDU1xbNak6+sNiDQJbGXGPn0uZcru29NcsAwZ1LDj8cZ+3Kifzi3ItMIgeuRsVx
	hWccnOZJU2nqtbiM8jG+0Y6UnPSkFzw0aiQEEZkHGnkS5hGYRXxUod+QM3pTphDHfKGbUib9INg
	tJI06Ggm7QQaKzcsw8IcYdq7Tu9AG7z1CiXysqaoP6SsuRTp60tS145A/FDjr8fo9sHtg3GrgDW
	bWhyFaPC7qQmUrNeu/1+LC5KncqiuN0jpnjpwhuXQAW8otpC4TBxneSQqE9mUVx3x+hnRWAkVQl
	rBmNLALvTTMPlkjQVMOkymG7zz0JvPQDPXvy5zUKckAtH6dxNvjmrI3aohQZnpcM9l9OOtDjY1R
	Wn7w5g3IPI3S+oSc0WERbo5A==
X-Received: by 2002:a05:6a20:e607:b0:3d3:ae0f:5267 with SMTP id adf61e73a8af0-3da3a152a11mr47964895637.19.1788887400103;
        Tue, 08 Sep 2026 10:10:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:e607:b0:3d3:ae0f:5267 with SMTP id adf61e73a8af0-3da3a152a11mr47964813637.19.1788887399377;
        Tue, 08 Sep 2026 10:09:59 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:09:57 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 00/18] wifi: Add Seamless Mobility
 Domain (SMD) AP support
Date: Tue,  8 Sep 2026 22:39:28 +0530
Message-Id: <20260908-smd-v1-0-9fd2d876a1fb@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: M4zb_SV8YReQXzNxm008KzW0kg--sVeu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXysdvqv5PxlGv
 A/UWXPI1wREEXzQWtQ4ef4ERItycxoHVeWHxJK2ZUQb8ZlRu+t0wmeTHDzIXNHCS+MrKkYQaqgi
 Ka9tt4V9/tPHalahNMuUZVzEZd48cGsKomvNbN3IQzaDUKekoGvpoX/Qu+CkqUoWMt7SSXPn70D
 CCyHsNwt/zCmndjJmc6wwwkrjKyauGE20L6Oa8Ed3DK0gpFqi6ksZLs84sxhfpMdbxPVbPdNxlJ
 q5kqo2h5TieJpXTCHK/yH676a7mtHclzI3ih60T/g6GAC1wWcTU68GJSrOCtWHlEGTzJYsYTYEL
 MxZx2DW7Uzz5yo/7Z2e7EFlR6t1x/3GX0te9qsaCmsyV74BRQhZFu8nGhXktaVJPwcwOgTVIM1k
 cmmUsQV1MKUVXGSzfbCbLblkESVf5dCHw+lBF/g0mCli2A1jSeZRlLaDPcspgvCnbYzY9Wp4lIj
 jm58cepy6fL1cMm0AkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXxfL28J9UzT38
 6FV0tojudkjac44IrwqEbEBTkxMJrE5tM3maAn09HpEu729zrJN6OxF0jXZUpC9/kF5WAVyyMrz
 SyFq4i94ilIzuphPCfAYZur0+KrgeEw=
X-Proofpoint-ORIG-GUID: M4zb_SV8YReQXzNxm008KzW0kg--sVeu
X-Authority-Analysis: v=2.4 cv=X8hi7mTe c=1 sm=1 tr=0 ts=6aa04169 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5AEPK_u2OLHVUZgZUq4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080185

IEEE P802.11bn (Ultra High Reliability) introduces the Seamless Mobility
Domain (SMD), a mechanism by which a non-AP MLD can transfer its session
from one AP MLD to another within the same administrative domain without
losing its RSNA or experiencing a visible connection break. The key
properties of an SMD are:

  - A shared domain identifier (SMD-ID, encoded as a 6-byte MAC address)
    advertised in the beacon of participating AP MLDs.
  - A Seamless Transition (ST) protocol in two phases: ST Preparation
    (cryptographic handshake and resource reservation on the target AP)
    and ST Execution (atomic handoff with optional DL draining).
  - Session-context transfer: the current AP MLD collects the STA's
    DL/UL sequence numbers, block-ack parameters, PN values, and QoS
    descriptors and conveys them to the target AP MLD so the STA can
    resume without re-association.

 1. ST Discovery (37.16.2)
 --------------------------
For a non-AP MLD: ST discovery of an SMD capable AP is via OTA signalling
 in beacon/probe responses.
For AP MLDs: Discovery of partner AP MLDs within the same SMD is via
 Inter-AP (IAP) communication (solicited and unsolicited) over the
 backhaul.
 IAP is housed entirely within hostapd and the communication happens
 between hostapd of AP MLDs.

The spec defines only the type of data that may be exchanged via IAP but does
not define the format and method of the IAP communication protocol and
keeps it out of scope (subclause 37.16.9). So, those details are not
included part of this series.

SMD capabilities are indicated to the mac80211/driver via NL80211_CMD_START_AP.

 2. Association to the SMD-ME (37.16.3)
 ---------------------------------------
Before roaming, the client must perform a single association and
authentication with the SMD-ME through any AP MLD in the SMD. This establishes
the PMKSA and PTKSA at the SMD level that will persist across all roams.
SMD capabilities of a non-AP MLD is indicated to the mac80211/driver via
NL80211_CMD_NEW_STATION.

 3. PTK Derivation (37.16.4)
 ----------------------------
Key derivation have seen some standard update and its to be taken care in
hostapd/wpa_supplicant, updated PTKs are plumbed to the mac and driver using
existing legacy netlink commands. PTK derivation uses SMD MAC address
(SMD identifier) and also derives SMD KDK which is used in lieu of PMK for
multi-PTK roaming. This is accommodated within hostapd using legacy netlink
commands.

 4. ST Preparation (37.16.6)
 ----------------------------
This is the key step that enables seamlessness. Before the actual roam, the
client pre-provisions the target AP MLD:
- The non-AP MLD sends an ST preparation request (a UHR Link Reconfiguration
Request) to its current AP MLD, identifying the target AP MLD and the links to
be set up.
- The driver in the current AP MLD, when forwarding this special frame
to mac80211, collects the station session context and appends it to the
frame skb using skb-extns so that mac80211 can deliver it via a new
NL80211_ATTR_SMD_CTX attribute in the existing NL80211_CMD_FRAME.
- This method saves the round-trip from driver -> hostapd -> driver to fetch
the context.
As the context is to be sent with the frame skb (as context is per-frame) and
may be big, SKB extensions help carry the related context within the same
frame skb.

- The context collection happens in the vendor driver and the same is passed on
to mac80211 for forwarding to hostapd.
- The current AP MLD transfers the collected session context (block-ack
agreements, sequence numbers, replay counters, SCS streams, MSCS, EPCS state,
starting PN values) to the target AP MLD over the backhaul IAP.
- If Per-AP MLD PTK mode is used, a DH key exchange occurs in the preparation
frames to derive the new PTK at the Target-AP.
- The target AP MLD sets up the links (NONE -> AUTH -> ASSOC + SET_KEY), and
enters the prepared state (4a), and sets the context via NL80211_CMD_SET_CTX.
- The target AP MLD builds the ST prep response with the target AP MLD's full
capability profile (Basic Multi-Link element with per-STA profiles for each
accepted link) and sends it over the IAP to the current-AP MLD.
- The current AP MLD responds to the station with the OTA ST prep response
and a preparation timeout is started at both the current and target AP MLDs
(duration for which the prepared state is valid).
- The client can prepare multiple target AP MLDs simultaneously (up to the Max
Number Of Prepared Target AP MLDs advertised by the current AP MLD).

 6. ST Execution (37.16.7 and 37.16.8)
 ---------------------------------------
When the client is ready to roam, it triggers the actual switch via one of two
paths:

Via the current AP MLD (37.16.7):
- The non-AP MLD sends an ST execution request to its current AP MLD. The
current AP MLD moves the station to the execution in-progress state (4b)
and transfers the current context, notifies the target AP MLD, and sends
back an ST execution response with SUCCESS to station.
- Context collection mechanism for Execution is same as Preparation.
- The response includes a Nominal Maximum DL Draining Period — a grace period
during which the current AP MLD may continue forwarding buffered downlink data
to the non-AP MLD before the old link goes away. During draining, the current
AP MLD moves the station to the draining state (4c).

Via the target AP MLD directly (37.16.8):
- Used as a fallback when the link to the current AP MLD has deteriorated
(e.g., after ST preparation, the RSSI to the current AP drops).
- The non-AP MLD sends the ST execution request directly to the target AP MLD;
the target AP MLD fetches remaining context from the current AP MLD over the
IAP.
- The current AP MLD uses NL80211_CMD_GET_SMD_CTX to pull the STA session
context on behalf of the target AP MLD and forwards it to the target AP MLD
over IAP.

The Target AP in both cases plumbs the stations context to the mac80211 and
subsequently to the driver via NL80211_CMD_SET_CTX.

Upon successful execution:
- The non-AP MLD enters State 4 with the target AP MLD (fully
associated/connected) and State 1 (unauthenticated and unassociated) with the
former current AP MLD post draining.
- No reassociation is required; the client retains the same PTKSA and IP
address.
- TTLM (TID-to-link mapping) reverts to default mapping mode initially.

 7. Context Transfer (37.16.9)
 ------------------------------
The following per-client state is transferred from the current AP MLD to the
target AP MLD during ST (preparation and execution):
- Block-ack parameters and timeout per TID
- Next DL sequence numbers per TID
- Duplicate receiver cache entries
- Replay counters
- Starting PN for DL individually addressed frames
- SCS stream descriptors
- MSCS Descriptor
- EPCS authorization info and priority access state
- WinStartO for existing DL block-ack agreements
The client may optionally request that sequence numbers not be transferred (to
reset SN to 0 at the target).

 8. Downlink Draining Period (37.16.10)
 ---------------------------------------
After ST execution, the current AP MLD may continue transmitting buffered DL
data to the non-AP MLD for a controlled grace period:
- The period duration is signaled in the ST execution response.
- Both the current AP MLD and the non-AP MLD can signal early termination of
the draining period via a UHR Link Reconfiguration Notify frame.
- During draining, the non-AP MLD is not required to listen to Beacons of the
target AP.

This series adds the kernel infrastructure needed to support SMD in AP
mode. It is structured as below logical groups:

 - SKB Extension definition: patch 1
 - AP configuration: patches 2-4
 - STA association: patch 5 and 6
 - SMD BSS Transition state machine: patches 7 and 8
 - SMD Context Programming: patches 9-18

RFC:
https://lore.kernel.org/linux-wireless/fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com/

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
Aditya Sathish (2):
      wifi: nl80211: Add kernel interfaces for Seamless Mobility Domain setup
      wifi: cfg80211/mac80211: Parse SMD parameters in STA addition/modification

Pooventhiran G (13):
      net: skbuff: Add SKB extension support to wireless drivers
      wifi: nl80211/mac80211: Add SMD BSS Transition sub-state STA flags
      wifi: mac80211: Add driver_op for SMD substate changes
      wifi: mac80211: Send BlockAck policy in AMPDU action
      wifi: mac80211: Define SMD BSS Transition context for transport
      wifi: mac80211: Enable skb extensions along with mac80211
      wifi: nl80211: Define attributes to pack SMD BSS Transition context
      wifi: cfg80211/mac80211: Handle UHR Link Reconfiguration frame
      wifi: nl80211: Pack SMD dynamic context along with frame
      wifi: nl80211/cfg80211: Add support for SMD context programming
      wifi: mac80211: Add mac80211 support to handle NL80211_CMD_SET_SMD_CTX
      wifi: nl80211/cfg80211: Add support for querying SMD context for target AP MLD
      wifi: mac80211: Add mac80211 support to handle NL80211_CMD_GET_SMD_CTX

Rohan Dutta (2):
      wifi: cfg80211/mac80211: Configure AP with SMD capabilities
      wifi: nl80211/cfg80211: Indicate STA creation via SMD BSS Transition

Sidhanta Sahu (1):
      wifi: nl80211: Define Seamless Mobility Domain (SMD) device capability

 include/linux/ieee80211-uhr.h   | 149 +++++++
 include/linux/skbuff.h          |   3 +
 include/linux/skbuff_wireless.h |  55 +++
 include/net/cfg80211.h          | 115 +++++
 include/net/mac80211.h          | 124 ++++++
 include/uapi/linux/nl80211.h    | 303 +++++++++++++
 net/core/skbuff.c               |  55 +++
 net/mac80211/Kconfig            |   1 +
 net/mac80211/agg-rx.c           |   1 +
 net/mac80211/cfg.c              | 166 +++++++
 net/mac80211/debugfs_sta.c      |   4 +
 net/mac80211/driver-ops.c       |  24 +
 net/mac80211/driver-ops.h       |  54 +++
 net/mac80211/rx.c               |  22 +
 net/mac80211/sta_info.c         | 146 +++++++
 net/mac80211/sta_info.h         |  19 +
 net/mac80211/trace.h            | 117 ++++-
 net/wireless/core.c             |  25 ++
 net/wireless/mlme.c             |  32 ++
 net/wireless/nl80211.c          | 941 +++++++++++++++++++++++++++++++++++++++-
 net/wireless/nl80211.h          |   9 +
 net/wireless/rdev-ops.h         |  28 ++
 net/wireless/trace.h            |  73 ++++
 23 files changed, 2455 insertions(+), 11 deletions(-)
---
base-commit: 1b60ed34f712e9f606d80951f1586f4274ebadf1
change-id: 20260908-smd-16986850d725

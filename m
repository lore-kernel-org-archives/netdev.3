Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301A13AFD11
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813202; cv=none; b=bmB9Dr5lH4tnBRDjbURe3E5zVS0xvU8oUVOMyrvcz0ZWhOtrYqp6uIDdoHGeVHp+u0KOjI70PzE6I5+lKBSMimN//TDG+9fXna783/zmSVF5ufjt38YQDdlJYthvgZD53v+MfmCfEcYNOGEyQg05kSdrUsnRYjO8E+lojdCVEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813202; c=relaxed/simple;
	bh=QrjGQLko2xZl5eg9/Ugvrrok6B1kxwMj1wQvWhfMku0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PibNYOUydxFff8DJDg7R3gN6VhdJq+r5cjYONEOClqsnZb9Z5aUe6KiWPXT+imu0FClhNwo+MjgrcG6P+gVZaaN+15Ik/0ia+4tjdh0eIoZrcbOmsb7ymAbZHh5PhaAG2rBDSuMm5AZ87p8EQWpsDjussE/o35NYW+2bgHVw7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UhfI11iU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MBooFZcc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UhfI11iU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MBooFZcc"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687H89q84062334
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lnAxO1SFfg5hCOo104KzuP
	7TlzZ6iyaB3J/9YbbJTcE=; b=UhfI11iUAhibcsnO/bZg+oik4dgQtPtSidJfUa
	nV02VX7Bhw/yKqah0fuvSWkecyJv5iFKvt4CI2VGqMMt9ro6hbHWG+zN5hHRyrtu
	58Uari1WFHwSrH5ZAIBlBPLnITDto5hLdVCyJNyffky1RfN9NFM5X8e0VO1gqx//
	nNUMVspCF3G3Fm+j6WsMrLMqZP8E/ShWYZvB1eRT0e2JW7/4tH5YqGjHH/3at9iS
	LojgvDBEFfiT80kmRNXTIooxsmC8JEaFb0FmSsfaKVZFcBQ0GBK7XU+Pqfd2ZInI
	EQptOECVpAEGi0TQFB9LqxnPcdxn4nAyFcX92jnawx1nnmdg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj077gtgf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:33:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6df0a1e18so75931065ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788813192; x=1789417992; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lnAxO1SFfg5hCOo104KzuP7TlzZ6iyaB3J/9YbbJTcE=;
        b=MBooFZcca/UsYylZMsj8y9jQ+Yn/uu8Wqg58K/9wmmpbnYEMtqX5T7l9taov7rq1sI
         d60Yeomqu3pfbSc8VwG8JTeUQ4rL7215pqyovnUoiB4aTChTgxlSKjgpPfKn1qapPgAd
         GbWp/G92sIb2/1aXJKQmbClbIAErBeQmj1wBm9VDnqdYPtEn3dVQFmLJHBy26hOvwwLF
         w7UchDcFeOjXkFZUPNifnrRTDRnQ1CGkS4+cmugapx88v05rOipAcqI3u/3aNlBWHMzZ
         MPwThLJUt6lwJ4JUPwIrJLohbF3KoASmK/tjvgHQNe708CurFPhRKfiZY6cYHKCyv6oF
         p/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813192; x=1789417992;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lnAxO1SFfg5hCOo104KzuP7TlzZ6iyaB3J/9YbbJTcE=;
        b=CPnpgzx3jWl8yLrOTesu9u9RkCt0O1jann1OApsDRuNaF5lHNA12nZwYBAdgkpbCoJ
         d25XoNk6YWNFBUOK6Emsp7EB3vB+ygFs0jGlrWcJ+uAFURsfQb9j4mrmD2w7fBLLR1Cd
         fCNgG5vedTzI74TBkuoqeYlFDUt9TlcdUvye9yU2vOqw8XeoO8Jr62lb57AZHYN6iJtu
         SUwL2Hep7bseFSQUmBJcDapbJHhuMMzZ/wPUcXNMBKMgpHgcZSCiwzT4diFkW9jdnpdc
         gUhLUIW75T7H37lORUODCb+NjdLl0kpUz2S2kUJ9m8shikXXHohavVmS6Ode436yMeCm
         13tQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5hpZ9JpiSHZuGMu0Ai9vV7S+P9h2XS7OL7cBQJa1RMit8/yzL59fuj42Aqqm0PYN/K9X72Ew=@vger.kernel.org
X-Gm-Message-State: AFuF++lAqDPwzEvu8KzXRznKgcdwITaa+5oD7A72yUjk1Xxo9uxSo4ed
	c9USY7XQl8PNQXqIyLkh7f8jBbu4kZRDyFgw9AImiaHXblKiaBBgOORPqbiOw5Ssy+utJ1KnB0+
	3+MhYGJ9+QElTvhXUJ8rIZSx7697FTGC0jUV6vFDdIqpJRGGgISrxrsQ9hA==
X-Gm-Gg: AYBFou3rIOAxaafvpJGC5fTzHvyO1cc6l4bcYVAJIb18aervbr4uADgaWtTKZfXpFLH
	1v4dGJF9FnDbY7NRA0vs81sbkt442SNaX9EXL4gZdWC3rvWZNVH5mM9gscE7szQCfSRC+p/qudm
	h8RsCsTQBZ1EjRWIYr+PvlNEwtQR2U75t3DFifFFFInOIVSiZK7mm49zetVpBLtSr0HgOdFRP3H
	r5+IbYHJVgVYNf5uYVdI72WG61AcFh4lJXXUsbbchhdmWWPolshkeXGuJES9jyMA+LLL6iG+RkH
	dUDSqABMrbTu8Fs4OqQxoBDs88b5pZjbcs4x+V4DUMyMmpivWGNBzi4uQNz2YlS7FhQ595aRqAT
	FGb2n7a+3VKWTNgiLcILYjsjXStqeV6VJWgI4TOskbZD8CbwpSJdY5IElQqB/22HaNiFkwBHmLj
	5CaPDEgXXDWZ32TjHhezpGSg==
X-Received: by 2002:a17:903:3d0f:b0:2d7:3f6e:5cb9 with SMTP id d9443c01a7336-2db12637ca1mr354381295ad.8.1788813192243;
        Mon, 07 Sep 2026 13:33:12 -0700 (PDT)
X-Received: by 2002:a17:903:3d0f:b0:2d7:3f6e:5cb9 with SMTP id d9443c01a7336-2db12637ca1mr354380695ad.8.1788813191713;
        Mon, 07 Sep 2026 13:33:11 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm47841297eec.16.2026.09.07.13.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:33:11 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH wireless-next 00/18] wifi: Add Seamless Mobility Domain
 (SMD) AP support
Date: Tue, 08 Sep 2026 01:59:09 +0530
Message-Id: <20260908-smd-v1-0-65ad4ab30fbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJYen2oC/x2M0QqDMAwAf0XyvEAt2NX9ythDtdkMzCiJqCD+u
 90ejzvuACNlMnhUByitbDxJgfpWQT8k+RByLgze+eBaF9HGjHVoY4iNy3ffQClnpTfv/8sTNlb
 6khkK7Qu8iu6SEXaapB9+qzGxwHle2zUGvXsAAAA=
X-Change-ID: 20260908-smd-16986850d725
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX5qFm0Yo8A3QW
 gEuJ7YbF3frnd0ltXMlhu3Pz8lzQbCRSi7EHid0ot/zYBCFJubgTwxHhgijrU/uMD4bQ+Ue0IQe
 TX62zKd+Zdumbwp9G1chBIEovVurLL4NT5ay1X08S4enCCmmBpYF1vBKp/YnTiX8AsPG2Evaxzc
 zWflVwU8I/uAIAevxF0uSZxx+8eJc8E8Rm+w0SDX0L+DkqxLWWmASKGHnj2SY3W+6ZjTf4am0MR
 OzfTLw3fHPJFetOBGoalcPoJ5TPCnQ/sHRMCPJVJkyHIel949EjPnPPK9yZEjjXgJCNG9/O/NwG
 gfl61NspjvOK7lSpSPApgQBGDm3W7Hmxw22Jc9/KHMtO7cKnChyzu2ORo4gjdUblboPwXQSacO5
 NAC/zRroOJdZPj2FcHC0Ha2tsl77Dm5BtT236+LwjvDlZaRb7tBE4TXnytbQgwTQnLvKMLaaExD
 c6r+wdGjsLKpAgN3TAg==
X-Authority-Analysis: v=2.4 cv=Xbe5Co55 c=1 sm=1 tr=0 ts=6a9f1f8e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5AEPK_u2OLHVUZgZUq4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: I3ckoY4Iy_7sSUAIp3GsVQz7L5Ckg1ST
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX7CpwZImDgjlZ
 oR6O7VfC5GmOypjq5/hDniv+muaAQ+Xyk4qqCQ3fJvHrIm4+8K0Nx49u7JTBsJYnFa56gm5VPN9
 54+5LgBJN6czMqzg0UKCzXW0lNUdxfg=
X-Proofpoint-GUID: I3ckoY4Iy_7sSUAIp3GsVQz7L5Ckg1ST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070226

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

Best regards,
-- 


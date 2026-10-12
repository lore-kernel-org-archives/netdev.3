Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE14B0E28
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823482; cv=none; b=QZNv/ajg66bcAlFmgIICy8Dyl9c5O6xg0xPulPxJnB7FsG0cZTS6e3Dj8NvwTgBRuap0JMLf6ebnspndhdd5B785pPTxBzz5dACetkN4gpYEg3Sl/2eNVjKgu8GY4NQLt9gIv2YklGkPhChrFHJFA1Ls00Fg9/sH6UA9OJsWgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823482; c=relaxed/simple;
	bh=G0ezcRMpi5gXGDahbwuNWo8UmJmJcsj7WUdt8DYFug4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NQJwYIotTeuziwqqRHpztGnkmQlH3Am6ngCAOzFsW/ioWTwEFNQ6yPxD8Y/ax0TZG+Zf/h0GTZlbURdxFbmFo0X6eEAVHb/FuzbVKY952OJLr+n87Sbj9yiPMd400TSDA74Wk16p6XSJ4IUwk6ehY7R/YD9Fld5RXRxHog8uT5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C74kC4st; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NxffjAb2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C74kC4st";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NxffjAb2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFfkLf2768693
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=64A0NSLF+RhR7KJefaxknO
	3D/6HTCylIyUlf60T2HYE=; b=C74kC4stmosWAflzTj8xlB+5cXLSEfqQFmx+W2
	NzmmGeiknym4AXBILTt/5h576z5z/RLQkxOKlipJPIqPo+HnuRh7h+PuqcLF036b
	jICrv43i+d15WVXEv2kTwqXCrRPIKZXKsho/UPDjVRjSHaXN96BQaStR/a+I7aV2
	13Cco/23nuhbiYICbxCY1uhPDyUxjBhuvXkh9+2tZu+KYuxeOmjjqosemcVrZFE2
	s9uBNBrw1dUq/w4SVv2sbZdD6wfAw8qnGZDQ7CCmm8nVcrPIexzPEs6mEXrYd+GY
	fQK06Y/7qhfw9jUy6o5sH1PbyqIaTomHyEZmaLVPqlnD6uRQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq2e7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:44:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ea8067974so550100185a.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791823479; x=1792428279; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=64A0NSLF+RhR7KJefaxknO3D/6HTCylIyUlf60T2HYE=;
        b=NxffjAb2dpG7ja28RSlsJArPS/rwE33HnUZYQ/KnDcoe2b++DKf+Rofq3fEmYHqxHL
         tJc99CfHGVFLyQjx9LLKRaGDqXysM+TXJ73Q+aAqEirlvlbHo95vjeJbU3wl1sklh5BM
         /FWxUoxd46LdWOLggN0ytTVXNFvknemfMtRwbf8J3nThPF/XJTWd9nGW9pWgApdQAsb0
         ghGIrnZ9lbdQqK2LyTfZC57422bnrv7FclleiNqpwyT6oVdD+GyVx99ChUOFH0Iraa/c
         9qO0zHX3x0CvwWY1n9VFYz3L1eAxfa5RvbDc3VJhcP9Zi9dSC4Bo3yOe9yA6Won6FkwX
         Q1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823479; x=1792428279;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=64A0NSLF+RhR7KJefaxknO3D/6HTCylIyUlf60T2HYE=;
        b=skU+WjRXdOpFFdTn9kuH4FXA0ftFUva/vSveLlyiJUqYnfNaHqN13wUPkuuFZY1q63
         BsUy33q5gpZIQL2m2pSe3MbXOTwquysoly1xjzZavmVhurerfZF+xF1srBjiRyY5h9Ff
         NahUKx+F1Qhwbt7uKJuM8CFUW/TjCGDpHpGp0O+IsZtw+MpLZRrFi4Oef6u7nNwSfvsI
         GabpPm3h9K29kbJlSyqMGagtBlcsuQ4KJKzQuhaFd0YEeVypav0IancmdKH/7zoOiFMp
         0eZywicEKmBQhKHk37+DTlBOzphpCxI4UfDpAM7kTCPUpf5qxQkkR53ZWDHI5da2KKFt
         FNWg==
X-Gm-Message-State: AFq9FYLMAI6vYqxH9DCX62eOX6l1U3v5qsG9pJeJ6B6mdZzJxPl1SJ3L
	6ycOSX9lv6ewdmcox30Do2Emx7cV+p5U8Mz32CrLWcWLtmO3hN2gnwDStuTHfKGzAFCGPIup9th
	L+XRG4Zbdk4FF3R74bOelOxRyXkPIEc/JtvwSCK7lXJB6maW9OAeV5GgqMK9PlDXZJetz8A==
X-Gm-Gg: AYBFou3aatYT5a2wSIBEXrSAhicVFQKt6ZSwEImyy9kbdo5puLZpB1eXgtUSCNd/0gm
	eG/4oSCTGt8h4FhoynxdaWVfwNdXef34sm9LTTDO6cnfEpqhGazFrpkZKTguoNqIR1jHiYd5SUw
	JKzpO1DIK8dnHYZH/Q3KsYNh/SxBVwhY33vcf4qSQnHECenSQ+Ds1VWQYjY+XuBQeEWWJddTNjc
	ply50/9+aiR8XbO4+pqOMaLhNSiRMsJ8b+rQHKhgVEDEYLcVq9juwqfjWFflhY48sDU171GDFKA
	i80de5HE9jDv5ZGECDVFCkgcrClN7hcWa9adP+rRwEefAlfFoxrgezvYmfdzGFUVxukSr3SNxjf
	sXS4EWHyE22dMXA==
X-Received: by 2002:a05:620a:1d01:b0:93e:8542:4f4d with SMTP id af79cd13be357-93ebd2923c0mr1685102185a.57.1791823479289;
        Mon, 12 Oct 2026 09:44:39 -0700 (PDT)
X-Received: by 2002:a05:620a:1d01:b0:93e:8542:4f4d with SMTP id af79cd13be357-93ebd2923c0mr1685096985a.57.1791823478730;
        Mon, 12 Oct 2026 09:44:38 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be96549sm419749845e9.6.2026.10.12.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:44:37 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v6 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Date: Mon, 12 Oct 2026 18:44:22 +0200
Message-Id: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQWrDMBAF0KsEraugkcay3VXvUbKYyKNGUNmp5
 BiX4LtXeFGMiTcDn89/8xSZU+As3k9PkXgKOQx9CfbtJNyN+i+WoStZaKWtaqGReYyRnEyzjFc
 JFm1LugZkEmVyT+zDvHKfoudR9jyP4lKaW8jjkH7XPxOs/WtyAglSXbGCukOF5D+GnM8/D/p2Q
 4znclZv0htDw87QxbDcaMvgvVH2wDD/BiiFO8NIJSvlCWog37I7MHBr2J2BxWBP6KitkU13YFR
 bo90ZVTGcaYrCRGCaF8ayLH/2Dm6ByQEAAA==
X-Change-ID: 20260918-stmmac-rx-mb-16469a2714ea
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acd0e78 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e9kd2x7fyNmJAygvsboA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX7D2EgBWFKj10
 nr1Nz41WVHBUKUXRCaovblXz/9GGgyKklS7zorzzNQE/CxvRw4QhPZ+6fTZ7XVtkqczsQIsbnCv
 1KhvBteqmRG6ageFZB7LezmMC3KjMsc=
X-Proofpoint-GUID: G0UO_ZD0RXQJQ7n8xT6HKlmdJyq6msIO
X-Proofpoint-ORIG-GUID: G0UO_ZD0RXQJQ7n8xT6HKlmdJyq6msIO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX7AQQG8XzTQmH
 tYOX4PvFJ9s2Hf0foxCvFLDZTVYmpuZaepgpVY2HMatGOpr6K4KD90wpiGby3bbKfTIsGbC9FCK
 jRAOv9aulGmvmyv3RILzYsJbuP2PTJpyWpZaxZiexTrrmyIN9FjFPS/ak0a8jTXQpLOmzAA/CNx
 LHHfYWjHfW9DPrY+sZRIUSGdNwRXc68wvAae0KS6TrfHa7uf9QP5fqZgEP5G3gm2PKkUM5x0y/I
 wv2p9tADB5qIyuzeTbeMz1voBjUFeH3a0HMyn6zhjYhzkHuH0QGi3BWzzsyodsnsx48j3AZY/mZ
 22wEVS0a5ienP6O2YnUTCxDJPe87WybWvHkYr/LmmjutXNSFEnEmpGFLFQixej3tPX4JpReCMRN
 c9TsB/o9RE3CTfdoUKtvwHjepifLI2nrbZbFhzn1Cm4c1uZYYfRlXOUMtudJ6huPvOiATOKc9BX
 iYOk5db2zhhQyfY7pgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120066

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

---
Changes in v6:
- Drop patch 'net: stmmac: allow non-linear xdp_buff in XDP mode' since
  it requires some XDP fixes.
- Introduce patch 'net: stmmac: drop split frames on AF_XDP zero-copy
  RX' to always drop XDP multi-buff frames for AF_XDP mode since it not
  yet supported there.
- Introduce patch 'net: stmmac: drop multi-buffer frames in XDP mode' to
  fix pending bugs due to missing XDP multi-buffer support before patch
  'net: stmmac: rework stmmac_rx to support XDP rx multi-buff'
- Link to v5: https://lore.kernel.org/r/20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com

Changes in v5:
- Fix possible read after bound issue in patch 1/3.
- Do not allow parsing non-linear XDP buffers if the program loaded does
  not support frags.
- Add patch 3/3 to remove MTU constraint for XDP prog.
- Link to v4: https://lore.kernel.org/r/20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com

Changes in v4:
- Reset in_progress flag when the packet is fully consumed.
- Advetise NETDEV_XDP_ACT_RX_SG capability.
- Link to v3: https://lore.kernel.org/r/20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com

Changes in v3:
- Return secondary page in case of error.
- Introduce stmmac_xdp_shrink_tail() to remove the ethernet FCS.
- Add patch 'net: stmmac: take ownership of saved RX state at poll
  entry' from James.
- Link to v2: https://lore.kernel.org/r/20260921-stmmac-rx-mb-v2-1-6e826e1ff306@oss.qualcomm.com

Changes in v2:
- Rely on xdp_buff_add_frag() to create xdp fragments
- Fix bugs in rx_q state recording
- Fix the corner case where we receive more than MAX_SKB_FRAGS fragments
- Cosmetics
- Link to v1: https://lore.kernel.org/r/20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com

---
James Hilliard (1):
      net: stmmac: take ownership of saved RX state at poll entry

Lorenzo Bianconi (3):
      net: stmmac: drop split frames on AF_XDP zero-copy RX
      net: stmmac: drop multi-buffer frames in XDP mode
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 407 ++++++++++++++--------
 2 files changed, 257 insertions(+), 153 deletions(-)
---
base-commit: 29f144016f03608abfddcd6ebaeabafd7aeaadd2
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


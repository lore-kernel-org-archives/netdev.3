Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980E485CC1
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983397; cv=none; b=thGEN9LehP4lbq19G1FmaJmTTbQwwLq99RaimLaZHKwhgyylRvK20OHk9djeJtPHQ4iipGpXzFZXwBEH8xfjGdYUdMgTd3ySur4KpIuBSywU/BHqT+AbyxfnS2FvvJkgimdGj7i59JrcbxDXlvtzb7yXubSijF2t6xJqpDKynH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983397; c=relaxed/simple;
	bh=oe0higQISNHB33yUruYCuFebMzPfyj0nuhkmsdVIpqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y0Ij+5va9ZboJDlOIW1eHQlmml2w45HVFlzyIsMgL5xexrIhU9BmCxl9yPwhY1eUXoHkJU6VnrE6G9PAjbgQTcPyY0DKdCE5/4XItTmqRoSWqoutox5OKLuCM+gnmCUrdjQNcllUGCpp5XlTLcY4fZ9mRWMbk2R58+9dnfit4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfNPI99D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SWUQfKH2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfNPI99D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SWUQfKH2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBLuFe3951277
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fxVyJQjkYpcPZ3DCNVSAAY
	sZSsu0sxPUoy58SbGtpRg=; b=ZfNPI99DaVzQX3sTpcqZYOPv/jC4NxkL4HBaXI
	4mBUJeYCXB7XRio2Ac6VNBoz2xHjBCmem5DM1tPz4DPL1Ypc/U77HMa/Fn4iUfJP
	/zsKhQHEnm1dabsLEbAubtUZqlY/syypHAj93izv62iB7BAHxwiatWUsR3dI3myL
	nSgIlB/nhwvrprCkS0nSGQQZB8YO3Xn+330EL0mhgK1PskrGEpHRuSPDGAW++D3s
	vJ5tz6VXAXFOnI/8dv2JBRfZOTzMOxu0hFJoc6eDrHWrKA9l6WpMHutsh4u8CY20
	kY3vdUUDUjop60ZfKp/N9ARjWMl6Qwcam9KJnlPSGX6BtQeQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p1qvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:09:55 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7bdb408a368so617670137.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983395; x=1792588195; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fxVyJQjkYpcPZ3DCNVSAAYsZSsu0sxPUoy58SbGtpRg=;
        b=SWUQfKH2gslWdRVgX43WhzeFchSFaERoRi3s2ivtyKWLeYBm99wdI4jbTbZffpjHL2
         N8rpeGHKA9Lvn9DNc17583emSRZuN3dFgB88PxuGng5MPv8m0/u5VXFtP9iJe1P2fLys
         eIlRbeIDs6Z4vjMNVoet4ER81Ssp+IS3cp8edCJe61Hp3cP3BzsJCnRGNiA6ql5vI9Yn
         DCTixw1ADEHSUwP5l0JTskDbQIcr/8+DpWYbW+5737QKy519326jFpGpx7GvxKrpa5HJ
         n32kdhlXvvQ7S0nxCu7/bNph7uEiGqKC9LR4ThGLg3dvdTwkwXWIcySR5oQOjTteXUbM
         uHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983395; x=1792588195;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fxVyJQjkYpcPZ3DCNVSAAYsZSsu0sxPUoy58SbGtpRg=;
        b=pcWIiY4h5GTETWedvoHWdneJUFrES+RLBn3uxzcaX++roWw8UQvLoP/EEN5srqOePR
         k7YYTngOSfexb8LetMGWlac1GZxol/c89a3EVPpcX/PWYc6gXVboo9QoJMYd9Jn62rxa
         v/M38cmJ9i8CcC+ITufOlW2CZr3MMzVlT9cN/U8Cz6vukwW2i8IML0gxaxpwz9IohuN7
         zswy+L/TPLNn7Z7TvwNfibz+euKX0qRTEWZndHbsFVvlScnOYEl/E6ghNpUK2t1h16ap
         dcF00no5+z2lPqUVjtp6yLjOM571ssJxhp4dOJ18/NchRdYB6SlLHkIHT4gi47rQHiTX
         QneA==
X-Gm-Message-State: AFq9FYIAF819yz92ekMVhqI1MSTBBuw6AGoxx35g84G9jkUR2hOXVK73
	LgEmDEB3XDsCVlSRRnKTpxVrmSmM9z0Jf348biEfAk1rjmv1Zd2EjcHbzN6QSLF5GYaZji6S+Un
	UvPxGNUh+y8BePvdevdF4Ml810VTh4zw6XcHX6l6ufiA57e44CRxo4e3g+jM=
X-Gm-Gg: AYBFou0UgexZsRRXSr73exnMaLVT+lm2KQQTmVcO1vkVleiQGGdzi5eIlrC9DNPcawX
	QJhVuL2G9hMpZlQ7ve7Iyn3T/T32pe/hz7Xryz21HrUC332vPOT5xznyryYX7U9wRZa5GXgz7rF
	96Guwk/CnYkq66XHR4KcpLT4Uax/iThLCTqHw0pKd+wssJog6bV6bp2z4t2eJKnrUBugIGthGTQ
	vMB+sB9AUFODoKMX5P7EioDbRoT2ubX7KbSkHJRY/5De5u2a7jPJWC3lE7D5Ebe5nem4avnZvUQ
	bMU6Sfrt/sFG4/d7FG1ZgyYxPvZF6zwTdxTSfbp4pcRTUl5sHqP1dpZe+IfM1V+urcomjU8V8b5
	w9OHWUnLCAjKPMg==
X-Received: by 2002:a05:6102:869a:20b0:7cb:bc5e:7dad with SMTP id ada2fe7eead31-7cbbc5e9b16mr1454827137.10.1791983394322;
        Wed, 14 Oct 2026 06:09:54 -0700 (PDT)
X-Received: by 2002:a05:6102:869a:20b0:7cb:bc5e:7dad with SMTP id ada2fe7eead31-7cbbc5e9b16mr1454810137.10.1791983393670;
        Wed, 14 Oct 2026 06:09:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac5265sm12641340f8f.41.2026.10.14.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:09:52 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v7 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Date: Wed, 14 Oct 2026 15:09:34 +0200
Message-Id: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQz2rDMAwG8FcpPs/Fkv8k2WnvMXZQXXk1LEkXZ
 yGj5N0nchghNBfBx4d+Aj1U4SFzUa+nhxp4yiX3nYTq5aTijbpP1vkqWaHBYBqodRnblqIeZt1
 eNAQXGsIKHJOSlfvAKc8r9646HnXH86g+pLnlMvbD73pngrV/Tk6gQZuL81BdnXGU3vpSzt8/9
 BX7tj3LWL0JNwbCzkAxAtcYGFKyJhwY9t8AY9zOsNpobxJBBZQajgeG2xphZzgxOJGL1FSO7fX
 A8Fuj2RlejGhrUZgIbH1ghI0BuDOCGIjojZeH+whPjGVZ/gAGKGRBDQIAAA==
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
        Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX9L5bs79f34uH
 4/NAMkML957wDB9AHz1AVRlSP4Dbi0RF2ylILL2HgyKmd4LUzI/aeAjpZgOdIifVxFIZ88IFqd/
 vf/QrBTLUeTGRuCFYwP3FCbknYIAhQM=
X-Proofpoint-ORIG-GUID: QzC_30Ff0lyDinX0LkWvctX5IfNgmtqC
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acf7f23 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u4BqklbH0r9NqUsF4ZAA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfXySTH7dT5iYPi
 uDFktmG4hhmpVVWcjipIaf9rBYnOYXV1RZf1mgL/LrtrIx/KtibS6qowvuHXOiCxQEvnqLbG0kL
 DXYrs+nKhD9ikBvSKAAv9diZxdN/QR6eTqbGvybYRbyEi7KmlAlSGTNLrieHkpODibRK3iXIkBn
 4Mmi3GzCZNwhtw2qsXP/vS0BZq3IyYO2P6PaTHeRIhNarQDcSrVtQ9J33KQtDHCiv08QV43MHtg
 6DTdoAQuZ3ZOhSxS9vcyTJS4IzzQeiS9HvyacYXhXhnMGPNlhmtWeaxfy0jYZjLmS9d6NDq++qJ
 MINQAZLXQlm0dfDjbcXWxsxHtbvx/qR4Fm+tsfKXvGZMPByzMsb5T1a/B+7CMWMe5TgWCeRf33v
 eRq4qk36uT0s42A8+iRcSjjeGmDB4rHlAhSxXgJOGdxyP2nLmLF9huqMSIVfMukVJM3ipqfUGxj
 3Z16u4mkquguWbCim+A==
X-Proofpoint-GUID: QzC_30Ff0lyDinX0LkWvctX5IfNgmtqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140052

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

---
Changes in v7:
- Take into account the case where buf2_len is not 0 for the single
  descriptor case if the interface is running in xdp mode.
- Report rx_not_ls bit if the packet is splitted over multiple
  descriptors for dwmac100 and dwmac1000 cores.
- Link to v6: https://lore.kernel.org/r/20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com

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
Lorenzo Bianconi (4):
      net: stmmac: take ownership of saved RX state at poll entry
      net: stmmac: drop split frames on AF_XDP zero-copy RX
      net: stmmac: drop multi-buffer frames in XDP mode
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 407 ++++++++++++++--------
 4 files changed, 259 insertions(+), 155 deletions(-)
---
base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


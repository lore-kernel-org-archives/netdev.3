Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4737E5C0
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343238; cv=none; b=IuswrXHPrB8HI8iqk2w9w3HmBzCzjvKJC5nraTKXk+YyoZL639REZ81xk/woRVAauBjw9ZYAAC2LOs/PiJS8Bmh/YkAikJxxyroNri9QTgrY8xCAlqPBkkZ8n8pN2PRh0R87lOYTNMdRKWFzlAylF1ZZ4hzhTSbB8ZsQFTy5tGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343238; c=relaxed/simple;
	bh=xopertD/ZBkChQhgx/DShjuXfdSkhJPloPiCWK9K+X8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NSa/GyuOLcGIZOIo2r+x+gB/wCsevQoJ4H5NuVcRvjPNA5TQ1j/i0tTtcKHPgeKKOlJuqljxLg1OKFiCl8NnSCe7IuREHROBDboFnDqFAwJIZtumV7IbWaBW527ouLYhEevIydrnbYu5RjGWYWFFrQ0XgQaul47HtaTSsagknu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwKJhMBC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jb+g+WdU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwKJhMBC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jb+g+WdU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IF7WUt3394460
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zkGr1FR6SIlZd2q171x8Ne
	vWe9GCqV1ciOs7Lm4JaCQ=; b=GwKJhMBCX/v16CfleU1lk/UqsiGdhI+5NWofk5
	I4b51PLmwiH63IKzDQgS++sGWNCXjArziE+BUMEGnQFqH3VPOa3lrwZmRLxLEftt
	jh0KxrQW0LawMd3dSaJk/xEAUG3PXyt3RVXmq/10PSjhIfqZ/NsHPx69zy4ba4Kf
	K/JAGy5I5akjd52OMzL+SpuxjjZi+bg2c858KnvWSZWfM1qXxSFU8LX5GDmlqRiK
	kKtKMO/Lb15eOYCznMxywoIute3NymGBcricRxELgjF6B/Ke4Bnqp4WLR4wEUoTb
	g3ZO+LshcrV43u9Fgsi2DNjTdiE8sSXR+vPKX2Hpj//0JH0Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9kcj2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:07:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so308983185a.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792343235; x=1792948035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zkGr1FR6SIlZd2q171x8NevWe9GCqV1ciOs7Lm4JaCQ=;
        b=jb+g+WdUzFrSqmnCwoY01ceEM9fI33xW8wW6VMZuPSnlhKEVpYGqTSzgZEYigcYAMv
         UD0vSeNGHvnfPY2M7lcEhVa/oFqO3QVfmKnG9FZ32pOc7+mdnmeSVauSlRfS0Z5AUViM
         j1IRxaYXLTdKBfphOwpQSmaTJjdqGsPYoEItD71Pta9Av38EjW02Tz9p4BdTr0kRcM57
         UYfS2P/wSrUyeoNwAuSdv0/1V3+NDxNP1LIBoP4HtdI+3xxrYz9sPC57ZeGr4luwlurl
         tPkucLBOn7sVp3urJt2YEGMRqebGB83GJyPFkT9/1cbA4Yi9TwtLvS3DEhb1nGe0/xDf
         4Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792343235; x=1792948035;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zkGr1FR6SIlZd2q171x8NevWe9GCqV1ciOs7Lm4JaCQ=;
        b=w6uDUREvvWkEn/eTcuC44HtrQ2b9tXqp3iEdIc1GABQEA6kdy7pigce2f/wBaR6uqB
         VZgTWXJZmx2/CPHZt6Td0zp637wBBB0vaxtk0+VVaSmWNt2wZL5xohel9Er/pCSe49Z1
         2Z1cC7vLiMTz4TGZ9h17eztO7pKWVHfNTEbGT+bjGixCIRLQrDgCNeqE0y98/3qq2krE
         T3Vw48m7dVpQolx4BIqiDt/TNERWFJ7fMtK76ESS2YxyKZ8i/nV30yToLnRIWu+g7taB
         6Kca89AUuktLRtZkzwSCsA9lrmfazuJiHlYDKz3yXuodPRGEGVcHkXo7vDo/BHUFgLKs
         YHuw==
X-Gm-Message-State: AFq9FYIctbpWTkgi9L7cK94w4dbB3NCWwNUXImUPAeZkqJkUzDXd8qvo
	wJWAGpL/Pfw74iXotaZ+T7DJQQCLPyrVruAf6nXlghe1RrMUcoBWoNGm8dktApf4r6C/LCMPu+r
	5ifKgbPUOArR9L8ZfnCB2AxDx7QjYZJlaWmcJhMpIAQPnA/+Lwx2V1LFvb0M=
X-Gm-Gg: AYBFou1s0dxC4bpBJv26/n+7JgNJKlIhuylk3fnbXWoBw8P+huArAx9uIPYsm/BZUUZ
	yuFC+T4JmLKTBkxv7wOVBmqadiXjUEuL0BFzocgWM3v4UWV9b/LX7mKAQh68ZGkINLxzTEi1510
	s5gj3/eUpeBJ+TbluyCX7UBymrr4l6JNKSRq2YGh0gNVaY8ZJYMabureeFaIaXGC8Artc9wzfX5
	FJcUYkJPIyeFWxc4o3Eyqb6xDojGOot/pWKW/1Ddkj54pkSaAe7YMdb03xIJjIkWiVwSdOaP/Am
	7vbZ0D9J2sN3so/pVzb3zSw8veRfUyb0+l4FQK+UWynO+uWZIaLl9TXHzZacmZ4TEmSvxCNoc3b
	Fg6uHX2hodIE5Vw==
X-Received: by 2002:a05:620a:6007:b0:93f:cbd:8e20 with SMTP id af79cd13be357-93f29db47d7mr961764385a.73.1792343234663;
        Sun, 18 Oct 2026 10:07:14 -0700 (PDT)
X-Received: by 2002:a05:620a:6007:b0:93f:cbd:8e20 with SMTP id af79cd13be357-93f29db47d7mr961757785a.73.1792343234094;
        Sun, 18 Oct 2026 10:07:14 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471877sm15028522f8f.1.2026.10.18.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:07:13 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v8 0/5] net: stmmac: introduce XDP rx multi-buff
 support
Date: Sun, 18 Oct 2026 19:06:58 +0200
Message-Id: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQzWrDMAwH8FcpPs/Fkr+SnfYeYwfVkVfDkmxxF
 jJK331eDiOY5iIQQj+h/01knhJn8Xy6iYmXlNM4lKZ5OolwpeGdZepKL1ChUy00Ms99T0FOq+w
 vEpxxLaEHwyTKyufEMa0b9yoGnuXA6yzeyuSa8jxOP9udBbb5Y3IBCVJdjAXfGWUovow5n7++6
 SOMfX8uZfMW3BkIlYHFcNygY4hRK3dg6H8DlDKVoaWSVkUCDxRbDgeG2RuuMkwxOJIJ1HrDujs
 w7N5oK8MWI+imKEwEujkw3M4ArAxXDES0ypbAbYADw++NOg//l0eHnVdRWQyPfrnf77/4mIx7U
 QIAAA==
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfXy59lg/1NNOzI
 F1loxOZ/vln4PcjOgp8xbXx+4I3JScIxbmGz86PB2q2Dpm6MGOTwbmXvuWIe7HiyUabzxMWEOlx
 83FnoJ1EgS36Zn2XAl6aRv4lduRqM+w=
X-Proofpoint-GUID: 5d3dPhS3N9l82IimbEThNvyUM7bU_DoK
X-Proofpoint-ORIG-GUID: 5d3dPhS3N9l82IimbEThNvyUM7bU_DoK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfX2aAu+FBDp2ix
 BXZ5s0CXHRw4iJdfXeiIktFy33VtFPbcw55zch5vDKbfSV1BlXekSR4PcUaomA1aZQ2IUPKTNOd
 5LAqJ3E4mVn1j1bf8OhVI3OGHaVazpsfQ31qhhVLnc5zFBUkSVSyCa5GojEkNZZ8jV2Ce/1FdRR
 aZXeo8SNv1YrADXBbr5qjcjXLxDltpUape3DluZnOiGbtotRa9vM7mASVmExMqaLMrqEaRSipaM
 RyEYYfxAR2bbGWfdplRAdMnc1YA2kEmj2EbyG4EsWiiMRrLnsALCbIIqNg7PIC0OIx2hGKAwBGo
 xH87ePCHArLZs3BTDCPM6+r6fcZCKnPvZCr0ANZ0iC9FD6glrQMJQwhLoZZ36xTQlkfjx9COUir
 qvZo6aTccEomvZHmY4IqkMzAuEJNIMLXccocy1FOhwtyzQLSKNhK4vx8arCZSlVFdsVh6cl/qV/
 fmIARunohJHrELgWIaQ==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad4fcc3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u4BqklbH0r9NqUsF4ZAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180068

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

---
Changes in v8:
- Add patch 'net: stmmac: fix VLAN tag stripping on non-linear RX
  frames' to fix sw rx vlan parsing.
- Rebase on top of net-next main branch.
- Link to v7: https://lore.kernel.org/r/20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com

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
Lorenzo Bianconi (5):
      net: stmmac: take ownership of saved RX state at poll entry
      net: stmmac: drop split frames on AF_XDP zero-copy RX
      net: stmmac: drop multi-buffer frames in XDP mode
      net: stmmac: fix VLAN tag stripping on non-linear RX frames
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 453 ++++++++++++++--------
 4 files changed, 289 insertions(+), 171 deletions(-)
---
base-commit: 98c2ad4f5d805dbc1ea436a334ee59311806a48c
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


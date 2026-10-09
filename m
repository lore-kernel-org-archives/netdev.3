Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A137267C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541610; cv=none; b=TCRGrFawFwZE6YtXj5snnczs5Y1hRQY2n/FQBZgMQz8pRiTC5m6clJlvf4ETrAkeEntIYe2qdhFvYNwHtf5Y8pe2WspRt2Jf6cflfLRc0YBT7ZE9VybDe5/9JH/nyfWRGRXPUGtasZocQGnXewsRHNhbT1YqYA7TqG76z7/V618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541610; c=relaxed/simple;
	bh=AZNfU2kByalCqyp+Py4lFQIfiU5+pwaMp8tdbOqR1lk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jETh9s4SqaHm9Ht5vKndyaSmmYsWRvqZz8l/BVzPB+H9UmqgLxPpYOsK3Nz615kPri8sN9vxEFfKwkghSKD19u1Bqy9I/Zr9w3B7dyAn/K4x2/AuGZEl72J9LcTihsRv+4oOTrjOTrS5Dht6OAemJbUsBogzAsyPpyThkTeTmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CoxNYTEv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bEa2Yb6i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CoxNYTEv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bEa2Yb6i"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KHQ9230929
	for <netdev@vger.kernel.org>; Fri, 9 Oct 2026 10:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ITMqI/Icq3NL235r6C2iwf
	F98d1/ZYkDkbAz5O1+M6E=; b=CoxNYTEv0X5h52BdwG1KUM+YOGdQe7QB5H1163
	AovaUeEZsAsU1gDC806gTK2aVuQzYfaPQOwdDBa0246C6aY/+obvnzJPGvJLrsKx
	YE1KN2YPm/A4/Ky64gqNFmlC+JIiW6CBTj9naSEn0/1vwRfd894KQN4UE4IJg+w2
	H7XqFUHhFtHXI1KIsO2ZXNfBG1phtGJr9ivwN2rrZ2kR+e1CXmoVN6A4TpW6tI4S
	H/Ui0ELYFCpb8+TKzSJZlYql5dhT7YfnBvOqECND+4vfkkxAhVzbNHbxMkulw+N1
	t94Aul8zA6myTNI5AeQCbXWNyJwyvRWaKNx8hnpSR+OiXGAg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu33fm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 10:26:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a3f673221so1706502885a.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791541608; x=1792146408; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ITMqI/Icq3NL235r6C2iwfF98d1/ZYkDkbAz5O1+M6E=;
        b=bEa2Yb6iRZjrAZrKXIVRU41eriwtmujUZP0OIxKDOwI6LhuIFx1HrKe2gHGoLF61vh
         /syvGYxA7Dgagi5LoKV1snvjngE6offKh+WKuWY8r3c4PDXtZMIRTWpAp1v8R1C4NWMw
         BrWzQCHwWp+GXJioM9FjJeGSmrVfDNPftzGaRME8i2wKNzjUc0YwJ8zaIY/9EPUFIIzd
         AhZJQarbhw3rHXSYQ2kl/kPh9NoFmTRuEc/5b+cNTGQSmmkzvD7cfXTS67QYPR27dQdv
         IdoaxpdNvI5C3DGCTtkb+rgT5WKfLG/zSaj9DJUmSl+NI5/p6Bc+J1QgtkyGe18PgJmU
         JwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791541608; x=1792146408;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ITMqI/Icq3NL235r6C2iwfF98d1/ZYkDkbAz5O1+M6E=;
        b=jjdsA7fIux9/qRPFO85tnWA4u2HzN90RkvAVkZ3k8cb6gDTUzhJLwPwVNIhul/52sn
         cWeAv1T38RgK7xOVuEXxZ8Lyle9/B8IrpTPnQvRp30baKgmod4TBPX9b7Cy6Ru9EufC/
         izER7Z+/6PcLTI2iVAWUpJy8yyCLHfP7FXiCwrJQ9KpsknxuIzgpvlpbrI9hQQXQ6mEg
         E2AVUev6SFY5LLjlKu6I1TIyK/3uJIWY+r4ov6KdKEovljiICDN2zKrTGUcNpo8ZxMKF
         l5ZvfCNcQYTM0mGQWogMp1mMcsnqi3kniJ8TVBJ6Kzo9qOl6F5LykkE4JPc9BnnaI19G
         wjDg==
X-Gm-Message-State: AFuF++mdwggi8zJuUFBVrPZdf4qFhp7H4/PztxzqWHE2ZDXtigUS2IG0
	GXzesSbVWZWX40CXFSZfXSIiOMBEnc1eoy/NzwExPhRQapN7JivRU4uEgjSf4MbISWyPMAc390p
	N/HEjD1muag00/8KLk7HoxqJE0r0Qd3qGYd0J0W7zfNAJ2LJ8YiYrihPq1GU=
X-Gm-Gg: AYBFou3G5i1D80s10G/oXvy8+dh9VDaqYTqgXaZtKM6cQ6A7LUR5YuKz13V02f7Jcvy
	2pxf/0x0FeASBaLJkGqEYmrQ1mDpGLj+tVuNBVT9UdqGxzgxGEYlAMqSUgvfUEqOmL0EO+d6dLe
	PPifmfI8A/bjN1oVLcWbkPoqYMmMrd6XksakdxumS5K9V5sBqyr6usGPfPfCLtz26nIbI/Jfc2H
	99F5C5Agg8ExWBrEOM4QbJBM0RvlPX0kPgp5YnXHajdQGXYpCsdY8Ky5PnfYQ7eCBBwINkD8O1m
	HLGaVH8rNMzEnfoLbSEKYvi2+yuSl9muf9RfgFwOQhqzeUP1lLMrP/ePLy7qH5m22P3dpEAMmXH
	cXC7ve/jOqSGRJg==
X-Received: by 2002:a05:620a:1d01:b0:93e:8542:4f4d with SMTP id af79cd13be357-93ebd2923c0mr184144385a.57.1791541607700;
        Fri, 09 Oct 2026 03:26:47 -0700 (PDT)
X-Received: by 2002:a05:620a:1d01:b0:93e:8542:4f4d with SMTP id af79cd13be357-93ebd2923c0mr184141185a.57.1791541607135;
        Fri, 09 Oct 2026 03:26:47 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm66345435e9.0.2026.10.09.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:26:46 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v5 0/3] net: stmmac: introduce XDP rx multi-buff
 support
Date: Fri, 09 Oct 2026 12:26:30 +0200
Message-Id: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQWrDMBAF0KsErTNBI4/luKveo3QxkUeJILJTy
 TUuwXev8CIEk2wGPp//5q6ypCBZfezuKskUchj6Eur9TrkL92eB0JWsjDZWt3iEPMbIDtIM8QR
 oybZsGiRhVSa3JD7MK/elehmhl3lU36W5hDwO6W/9M+HavyYnBAR9ohqbjjSx/xxyPvz88tUNM
 R7KWb3JPBkGN4YphpWjsYLeV9q+MaqHgVrTxqhAQ609Y4PsW3FvDHo27MagYohnctw2JFX3wli
 W5R+Va9/XhQEAAA==
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
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX0k1kug9/CPKP
 KYBV/gUxYEYUF04mlGXQFwmZSuOOvjJDifr748JUEiMxFC+6hGlf49zISuSIFZlsNsZMzKg7nHX
 f18zBxz+3eG/KOIRKy6tjJ66lbkWMGQpiXwijjE9KQYyNbuWH9HhtzBxc8FZA6UUz2ZiIrdIaaR
 RcJMI9R5aL2Pj/ZW29XqHRh+xGbifQP4dgpt7+fVsvM+gFW3rsRcGOgjCQc4Zl6IqPxNe2HsHxV
 pB17ROh5a9rSAhhqTfpR/X8DMDlL8qc/RWpdqizoaTCDKOn3+mFE4sIt0LguJR989yQFReFOW84
 JjEWdnp2uZPAb499SqF19nrevLQbZudSAPFTPcO3IyOuJSi6VeglDsiVYYxD1cH/2tw8IxNA+cw
 mK33PgV6qJQHUL4pP79ZmezKy8h01RSSe8ObJZzkSkPB3j6VR2PW35HQLnp51X2DgPvysgyLZqb
 /oK1g6PDPN4XOENyXmA==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac8c168 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e9kd2x7fyNmJAygvsboA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: OBYhSyzFFQnPCmC3A3hiJvKDSbk9Xzxe
X-Proofpoint-ORIG-GUID: OBYhSyzFFQnPCmC3A3hiJvKDSbk9Xzxe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX0t2d2Ons8mgu
 k8T6YJlcshzfxdisFepTKLI9pyLhjKl4XZhKloILjNlV2KV1Ckb6bmpzajoVJc+YyIQd3HTPNvR
 xSN4dKWbhLo85FL8wfmuHjjVv4n8frs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090041

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.
Enable XDP support with MTU bigger than ETH_DATA_LEN.

---
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

Lorenzo Bianconi (2):
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff
      net: stmmac: allow non-linear xdp_buff in XDP mode

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 401 ++++++++++++++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  |   8 -
 3 files changed, 253 insertions(+), 159 deletions(-)
---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


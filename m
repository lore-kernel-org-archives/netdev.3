Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743035;
	b=k+bZc18KLLi3GYdGL0ZIvbhj6WIqwH4QVpogaugmPJFk9bdwKMKsgPsQBAXK88CBLZbd
	 f1H5Tf9sL9/t37gr1csunsH2QN75y9pGah5rJM1nlI6xaDYsP6STAQSTqPd4zr/bgyYSt
	 zCi8eBBoPqty+BasFg40Izw25HWLz/kTE0rI/wzVLRS02qlEAlEccezbIkuJUAhKmyiKt
	 jXh4Btc9or4p7reEXHEbHy2X7+j+iC6Y7BMJVdzS0kZWI/h2BSwcLRgJUVszH9VL7ezGd
	 S5O7R79c29IDn67NPKrGe/fQc/+pzVsSe24d0gU9+FotwflGoYEU/cBORa3F9HTW4zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743035;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Q9T5DRA+uqKDqTbkysqot+G2nwnmqz/LaQ5soZeW3wY=;
	b=J4hrDB9BjFyzEMrtDpWpTHWV19q7J63rgqhf/BJO6b8k2OUyGxNLAhUpJrSVzMdsgagh
	 yXoFHBbdyzAmlgq3iXp9Lz+JBCvIDOtL2z2Rv73wX219T0FR1kpbB1aZmaehWxgUihZtJ
	 cbld8GmW3kFvnUSG/sQqBf+/c5tvRpo7YyNDrR7LF5jdmxXeqr3IqKf8go/UP4XanB5yF
	 9QsaWBF16AFf+hWPJk7M8/AH/al4vkLhTpdggUpot6ZxncC/fHWVfp7Qyk4GbTiwlRmBL
	 lVkhKvr8V0KQynwqEqAx4VRUxZfFWoCNoajThxkEM8ItJ+LQAU8y2TZjDX2+c1EeYqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lfPHrcTZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h4s+Ucsx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1B606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AA1B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lfPHrcTZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h4s+Ucsx
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FMow1048215
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Q9T5DRA+uqKDqTbkysqot+
	G2nwnmqz/LaQ5soZeW3wY=; b=lfPHrcTZPHwciuX5vPf4BM7XSbx201qyWTBi2d
	z4jrdP4O0O7Ntljn+qE8jlcT/vQBLD/EHCRFGit4tuXVURK7xpV6v/Kq+4fAnAJ1
	Ar9Gu7h7tdhSMbxibwJmNDqtqDcBUJmVFv7pEdOfH+Rcy10dmUi1+QHKNeeSYSB5
	Og3j5vVXfGms9RhUje8+7aO6Q/5GLUghS3PupICCmHgOxfr7XOntrK1kRpWUd5FP
	QsN3uCPYa9oDueb6CoPEkCO0DGycdggUIjKo9qOvh1pU0+h9QEpazr53T8dRLROC
	k9U9M+UnbIEr1MHBXjttMi4DQsuYPaxvyQzlj+8FKoPi15jQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbjpuh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917a3c27c9bso12414156d6.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743032; x=1793347832; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q9T5DRA+uqKDqTbkysqot+G2nwnmqz/LaQ5soZeW3wY=;
        b=h4s+Ucsx7uZGPLu3ccJfBtMCOUrEpfrn6l/ncxRmp0/8kAAF/ZVtuZeRCtqGGo8M2g
         E2YHpeB9n85Rr4OhNlnAsMWawkaDKjoSIcuP+tFSP5K443Rk8Xw2FULYmIvy15oVcuzI
         4P8AFzqIPIfQUGbJK1zz7FC2HxpEenPz+Fa5ZcYLEZ4iNawX6xD140DpcN6snXImemLV
         aQVQXyYTo0oYzBG+HkJoQ+Y+ZDM8E6f/t9ya9a5iRPqztd8O5d0MSoMuKCb8bVMxLMwL
         pQXR0gFQCFhfea0N6pvlwHXoP59FvfoKzPYMKpbvfF0izWXQe+4nMEKKY+0ci2TgCDR+
         rv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743032; x=1793347832;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q9T5DRA+uqKDqTbkysqot+G2nwnmqz/LaQ5soZeW3wY=;
        b=bsBUDawOao5K8wIaaDyHh4aaxqTz2k8eFo5N5OjOrIoMt0AKN8V4he+c3Hz50hnSbS
         H4O3bQkhtpR+bmVafDuIOFNcwzUQ2xoAG5m6WurrU2ioc9aX5CZj1gAt0Axcr1J4kALv
         HuNAMRFH2vC6QVktOauV2tUkeOKGj+DVqQsfj+rwsGh26Tnh2XT2HVO4i18mvIqlKXa7
         0HBNhsOadoHGv4X1JOeuyLHytHQUSNnONvA+NMIBAzGVak7+CKLi1eh59pcTok6Z6HMO
         qLQ5SVVL3PwJCs34GE2gMkuQ+Au7SpwcZJt0CqlR12XnySladwYfStWbysRzTY3dP3Fb
         CPKQ==
X-Gm-Message-State: AFq9FYKK3MrCrlJetpGftSzqGQ6dNiofvL4iG5izsMKJjrR6Rrev9g50
	Cmqeyj71Gr8Q/2decXUCPUXc5cr/Y7xQiTzLQzO9QIbqzYWN29oP3L4FxSCao4JglnZu9xvpGrI
	G4GhEAlNODIZVda0sNppWLYaQVvPepjCHRz1Nj5zOFz8mFcqVpvwIPFkJABA=
X-Gm-Gg: AYBFou21mFVp6jCnYVJM4/nKRABVP+EpfoHrGLFCxFkdwhmW6X+v6GdRv+lCMacahNz
	a+eBQaTIYsMo6/eHPDE1lIRcnxBDtSF8MwWEaPh8+/I0sd1npYoTmscoeK62LJPDDXKHG4FFr+M
	/9T+3mI7q0K52BXbGYTKCQRt5syFHkOQgkVSckKsROKUTlHc19Rbia6akOHCEvZC1nPjB3YvlaR
	O8aHuzVfOMy0Nwd6GcgUUflu12vPCLwBh1v2jsF2rI/NUrFGlj07pASMIQT5BQnUilWvBV2y+tu
	nx9euQibYFICOSWuq2/cLccpWJ+RwKWW7D9JHEwEd803/+QMKHFzlsAG6EZOodEofuGRFjdzTbJ
	LcdZr60rTNcM=
X-Received: by 2002:a05:620a:3188:b0:93b:d7a0:d9e6 with SMTP id af79cd13be357-93f6f80685fmr302987685a.64.1792743032603;
        Fri, 23 Oct 2026 01:10:32 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:93b:d7a0:d9e6 with SMTP id af79cd13be357-93f6f80685fmr302985685a.64.1792743032087;
        Fri, 23 Oct 2026 01:10:32 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2153c1b7csm18523725e9.1.2026.10.23.01.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:31 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net 0/6] net: stmmac: XDP path fixes
Date: Fri, 23 Oct 2026 10:09:52 +0200
Message-Id: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LMQqAMAxA0atIZgNtRUWvIg7BpprBKo2IIL27x
 fHx+S8oJ2GFsXoh8S0qRyywdQXLRnFlFF8MzrjOGtegXvtOCz7+xCAPKxpD5FrfDxQslO1M/Id
 yTRD5gjnnD+NFBfxnAAAA
X-Change-ID: 20261023-stmmac-xdp-fixes-00aa25d79af1
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
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX/bTOf7O0jFym
 M4F2vlFRYBh202AgOSGDmrOYhTZr82d+wUu23wG7I7fSlCUhKV9ETxMSkAA5AlU+o4TejkcA5Px
 suy2U5qCq+rJmAsnpEOxI58Cp7RLyNI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX0y1RDug3NUEz
 56KiShrms0QX3m9XBkt6PTsoAPwAAyenWetsumvAKjwwCKLEGcATiGQCE0uccnYuYJB2izeei67
 mEyMz7O9PuZa2eLxcwlK9FsM7qVtf9LF8NQgWUmUkNjGZUh7DzrnujnTaQrPSBXl5ODlZJdbTtR
 ybjRA08cphdaGvABElWLsebT/gMtNXhBMWT/ZbU2XK3HUXBGrnFDS5sLw57G+H1jve4VZUZP3f4
 H3Ed4UTlmJ+qJmrEnEhe/dohi54F5o2YaY2bMWTnqhYSq1EffgUT+w3I8Mb5ADk78ksQzq5DRTz
 /uPXFnzL5gWfAhX7nWrsAhe1VhElcuMXDgREEDIwwNgJ39nGQVO0lUC+VUv7IyCQQ9DZkxmbc27
 WL5qoBEBAcJo0G90SaOcmnXl+TJmdW7PbfiFeUEghEFW7J01WIAnQjW064zl2SroSxPUa5dgIFe
 LsjaL0SpH1Z8zWToy+w==
X-Proofpoint-ORIG-GUID: IO4SLi8G6ps2yU8qOZ7ZY6OLarwOpEtc
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb1679 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mZfc6SlRgOl0Hnr-beQA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: IO4SLi8G6ps2yU8qOZ7ZY6OLarwOpEtc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

This series adds some stmmac XDP preliminary fixes needed to introduce XDP
RX multi-buff support.

---
James Hilliard (1):
      net: stmmac: take ownership of saved RX state at poll entry

Lorenzo Bianconi (5):
      net: stmmac: drop split frames on AF_XDP zero-copy RX
      net: stmmac: drop multi-buffer frames in XDP mode
      net: stmmac: copy XDP metadata in AF_XDP zero-copy RX
      net: stmmac: fix VLAN tag stripping on short and non-linear RX frames
      net: stmmac: fix XDP RX buffer DMA sync length

 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 183 +++++++++++++---------
 3 files changed, 112 insertions(+), 75 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261023-stmmac-xdp-fixes-00aa25d79af1

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


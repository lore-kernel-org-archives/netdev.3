Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD83FD96B
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158398; cv=none; b=J1git8IHAw2UuBfuRFGdBFxEkUtoQs4TjOt/r8omSzP3JJpqzNArskLgBffYIE3zzPDhvOpkD5JNz8ukI+ndfyU+/sbOwVnbBXaA/EwhD782Qk5LzSNGavPxeS7FzoH1uHulUgpTt0gtFyIBLAzH32xA9fV+ACYx3tyVTl5I2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158398; c=relaxed/simple;
	bh=o01mtNQy3KwVF+ElcBbjBGFwVMtkk4Jqm1hOQQLr9Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NYEZqb7ptOX8/OFm3BgrMITYfFkf5BJnykC+vqNrq8+qZbmmGqowsKnVmM+3eh53BmEtRLKonG4ioCzECAL/Uk4iZ0rFJUuQnxvuDaRzG/2hfSlyIJ31VpWthXnPg7i2J2qlxcvAYG84HcEO5iOXzbSEGz4loXRwO2AZsa+/owE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CA/pydT7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TEirt8OC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CA/pydT7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TEirt8OC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA2XBP2236562
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FKQRrHaIRweaetYz3Unhx+
	PbssZns4EPFcVrQ768yAY=; b=CA/pydT79wiLZr1gEDqGS+aqL6DUC7xethxhLh
	072QKW9osXlXxJFu1uGGeg6TK4HRYp+74OThSXRd+hJxs9auwTTFkz0KkCl7Ogik
	Ne6D638MIQbmGgao8lcNxIPpcReXu5gDlOiJUCuSCekd0wImf8uLG0WJiH2a+fDF
	NgVd3GFd0ZukdtnZmkcmjqrgnzmV3KpmJ3Xeutl7apXui4qoR3ySVlXOXZTGUNnX
	e4Bdqp8GW2AaopYYsKIQ0uan/kkIC2uMw9ttsxeX95uIf/OzUl4F2znpyKzBYGmN
	7XX+IFTuWljousA93he/+gINWBVOI7XnhVGVseoB3qFMU7GA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbx7g8qd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:13:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a1e564fd5so146480885a.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790158382; x=1790763182; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FKQRrHaIRweaetYz3Unhx+PbssZns4EPFcVrQ768yAY=;
        b=TEirt8OCaU5UV+B5w8CTiAS1Ry0vRDacak76LvuASHXvD7iSK3bPR9LPdw2jx+G11f
         Lb//JSZpwuC3V0PNIEpihRXPdHcKxj29+s3v+hmK5QSJ2njOVpiys53adye1AGD+7LfG
         Sq1PhKU8dpyB77mHQj/Ez+R964PGTtE9QoBwLkceAFU+AJbBmWjNjGD6X3y3RBUIzOJb
         cMi4gcRE4lwPm1fgnNAaMRjTxqL9xVfqzCav/LuFxWAfOmMxS7ZBlSW2O+YyNA3jN6E/
         9hQObdVdQ/ox3P7N6Gh8ogyAxsVX5MZaNxh86WIZYY/peuoen6tybcFWFGHfdoW4Rm3H
         JdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790158382; x=1790763182;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FKQRrHaIRweaetYz3Unhx+PbssZns4EPFcVrQ768yAY=;
        b=B1VjUEzOc9CbNtGkar2YR2zLkryRqxXvap3R69H3suqnGDnPGalobI7tFzaxE0L6e8
         k4MLlhhQR3zAbBWHn4PwDUl3sotrKp5bcGdumHSPn8b+28Z5ZY78/uIX6SoPe5crM8nS
         qBaqQDBbkn970Po8PLL6B809yVrtztgHzoeIT3EK4R8T50kyp78oAT89bHKzHET8D3ZC
         h/JA50KikfV9MvRGk+KtjzOqJ3J8SVArC6KQ+x4j0sFmPYlrFO9TKX90kZ97OQ7U2U6J
         EPDnlwX1O0zelor7FCP+NIBMXaktcqKtS1sbpy2NQ4BxPDW25Ce//tbg66+aqiJOOnvI
         n8WQ==
X-Gm-Message-State: AFuF++nEyAldKm5sgW73yqGgPzCmiyBLac0kUchN2Hnykrr4kVeddyjW
	OSOhcULGfZ0PseaCxGd/ViW5Izc1WCrRWOb01U8+6PBkqXE3UdJyqQnr/TllD6pFWB/znl5Zboa
	vQrZrIEUK4Hp9XzTQPOU5vI0RzwdgP48G2cwM0awCIf/H5SEdtx1q3olvUXw=
X-Gm-Gg: AYBFou3qAjkwgeQCLQ9lLBJU9CdC8sLGUK7VY9gRgC0QQpmDQGuHWAJm/fk7KyV8x8X
	b6x1RB84IG3CFnkx+61GbB3MVrtRKloS0naeJZvt0qH8e7/o9ANwP2TDP+FvjXDXVcqRYfJfLCy
	7mXu9f4Cr53LesEMWDhydBz5vol/zrp6JF7QW0xLiladPGT+KEp6DrnRCU3eg/UA5HrOZXbyPy8
	xVspRGPNYLJRbZOVv5xY8rZTbCTqzYTjmIZvAkRnqwLZcAcwt6HNGwUxSQk+s/WtLFJaxPdMgss
	Xdhh/9ijPtirN5LTfyl1LCsXDgrBfp7093XAstMBsUv0ev8awwskfndlwFxtSTRArrF+JETuyNq
	8eqjIim7IIf5VZA==
X-Received: by 2002:a05:620a:26a4:b0:93b:be6d:4f3e with SMTP id af79cd13be357-93c2513dba6mr321427485a.25.1790158382090;
        Wed, 23 Sep 2026 03:13:02 -0700 (PDT)
X-Received: by 2002:a05:620a:26a4:b0:93b:be6d:4f3e with SMTP id af79cd13be357-93c2513dba6mr321423985a.25.1790158381572;
        Wed, 23 Sep 2026 03:13:01 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab38a9756sm1423662a12.25.2026.09.23.03.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:13:00 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 12:12:41 +0200
Subject: [PATCH net v2] net: mvneta: clear XDP pfmemalloc flag between
 frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-mvneta-xdp-clear-frag-fix-v2-1-298693a7ea6b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQqDMBBEf0X23BUTUElP/Y/iYZtsNKDGJhos4
 r832HsvAzPDvDkgcnAc4V4cEDi56PycjbwVoAeae0ZnsgdZyaZSQuGUZl4Jd7OgHpkC2kA9Wrd
 jS7pRgkVTqxfk/RI4xxf7CXkEXQ4HF1cfPtdfElf1Q8vqDzoJFGhatmRYW1Wrh4+xfG80aj9NZ
 RbozvP8ArnMYBnOAAAA
X-Change-ID: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: --asZMZU1yz6poQ73Xv7HYh_nAjF0uNg
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ab3a62f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Bf4p-39G4bmrPmVIT4wA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfX/bx++aiEHTY1
 q67V3F3Ix8K+f0TFP4gSRgiluN2lQ4s5m+JHf2Hizs7dEK1oeTKCttyrvuvrTkSd56w7JttfWJe
 OR7XQt83vpYsd5bntIfQzlgZ3lCPE5itwR80onYVRrFxbh1Lz9MhXlIZ2rlf9vnzqhT5VEJSzTP
 Vhin/Y+J9/czE4Xwgjkt42lrxa7GpCLkC7gElzCXSo9FNH4oiXTnxHvwObjSY1165JjxMAPYR5w
 GzmWizXboZcETVwUaOuENIJUoFvw185dmjJ1+2MNegLBOar1LrIwjYOLCGRPU0AheDoWnddYx/Z
 P9q/fUxlriL5p2zFLPxZMxncG2nH5T+isZlKXixuL1TDZ1zLe9CPmpaHQtCc07TvgoyC7tvK4QQ
 vLsgbI+OJdXDq3Au/U2xfk4wXSZIir7S7ElxDsi5+isZhnFoCjz8PnMibRvebR98ydXw40yBSWm
 4W70SLH3BS4Vtn49YcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfX7T383ACdXduB
 vo99i8iSTjYUGPg32W4NWLVhIVW/fbuX8RPnK6krFFdbujP+U7dfGk8zF+ThudLYv0iun1f28a6
 OIpxS9FwxX8ZyYYraRdMBTwa0PNDb2w=
X-Proofpoint-GUID: --asZMZU1yz6poQ73Xv7HYh_nAjF0uNg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230040

mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
xdp_buff when a fragment page is a pfmemalloc one (page under memory
pressure). The xdp_buff is reused for the next frame, but only the
XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
bit leaked from one frame into the following ones. mvneta_swbm_build_skb()
propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_info(),
so the skb of a subsequent fragmented frame could be wrongly marked as
pfmemalloc even if none of its pages are under pressure.

Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.

Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info utility routine")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Introduce xdp_buff_clear_flags() utility routine.
- Link to v1: https://lore.kernel.org/r/20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 include/net/xdp.h                     | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index c2b1098d8d1d..334896d67c1c 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2340,7 +2340,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 
 	/* Prefetch header */
 	prefetch(data);
-	xdp_buff_clear_frags_flag(xdp);
+	xdp_buff_clear_flags(xdp);
 	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
 			 data_len, true);
 }
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..2617a4908beb 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -106,6 +106,11 @@ struct xdp_buff {
 	};
 };
 
+static __always_inline void xdp_buff_clear_flags(struct xdp_buff *xdp)
+{
+	xdp->flags = 0;
+}
+
 static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)
 {
 	return !!(xdp->flags & XDP_FLAGS_HAS_FRAGS);

---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


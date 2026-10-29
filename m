Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270055;
	b=W55+gTvIGRz39l2PkNLsBEsXOuPoxtunJyoULRwsG+UB4kn4vE1DD4mJDB+YiKCkLXee
	 xhr8DsE5Z8dV9Jz8xl4J+U2aOkpfFswjAlQ3cNmErMmSDenh9MeiHgV7x8ljy+djeA4TO
	 fowP4RB2yVSM857WRd/CFrtaruId+K2PUYvXjDMUTSSDDuvpygi28P8aQMVwX7SiD6+xn
	 6G2vzgEw3B7LFzyTd5wAwMSDzF77I6q3+za/TAJ8p486KM4IqJeltH/AAVkvGifnrKLnn
	 6wKxKysrPxqAdWZTLPz7lemzF7ci9sIqg8F0vs60Z3Ab+NVYdZIRzbicN34y+u0B0dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270055;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4Cm5Hj6AX2bOx9FeJjSt60AwCDFLiBSACiP27rlh8gU=;
	b=0XGAQoCNHh8S92SCgvnmPXW/18wXt7KerDjrdmV/JL9npPSaJi2XiDYP13+mzZHQbG53
	 8ml7ywELLmV0LMJVhXhLmeCTxi4/a5RlTgkCFvHfA+gL3XUdJoeMK1Vx3yI6WUioy5OHb
	 lf4vSZ5f+M/bQoknFGEbBBEMmvS5xJ9JXECt6ltDcjdyFSggkAPuHCMMpRk108DETfT52
	 uDr+4SUn1AUZH5MgTulwD36LIqs7PVGt9HYXzveoCxQ0KN/fQcihtPB/xXBNWyOG4nPVa
	 GIR2GzAuhSSgMUuP735NPIwCxwdnjbBbNzMTEj9sy4U0iLhGWyCx8c9xrXUiA7dU41A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C7pDxVqD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B0hnl31A;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28B606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E28B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C7pDxVqD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B0hnl31A
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TA8VJj821239
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4Cm5Hj6AX2bOx9FeJjSt60
	AwCDFLiBSACiP27rlh8gU=; b=C7pDxVqDghSsiAGhH18CBuMUsJyLL5u85Q2NLM
	YTvcT2ppmA83duhNwjGakLyIfjFHfcM9D4QYNl+bfsxLQDzlY/GHdJpa8gYQ0IQ3
	OcTDb6NtFGQngG+LB5TocJsW9ieCiqMNAn39+QGrJ1qP5X5odHlrBxToUd960RTs
	D/+7XT10OJVaDxqwqvsdTU9jcNQ7oE06J7zUJBoPWTDuJLxgXtWmioZNDeAJ4XEo
	SGmWzdYAJY9v0Hv5GKQGN4Bif0Jg3MRIEHRn7Be8ppwjgwyrUoWd5Nwv+P7nqnrA
	/BKfSYTCXT7+SNrDPPT3CH9JRzh4vG64Lrf580vf1dev+kIA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q82xc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:14 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eac42e83e0so516729e0c.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793270053; x=1793874853; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4Cm5Hj6AX2bOx9FeJjSt60AwCDFLiBSACiP27rlh8gU=;
        b=B0hnl31Axo7uRbt9+iHBUpSyrmHHhzAzY41fsBgNWB14ZScKmJndzM/hka/zb9W8wQ
         8meWRdXkxAr2vv5sEaKgvccXgd6RSaawAiVBZvMoWfurd1jG+tqDBrCQB6eUJ3SRXeNw
         uqk9n6QnCswkaqoRrqZ7wt+iw7rv8rbRmSvxNZa3HC+GRx3bzo173QeWSqf/fiJgfff1
         pV4V6B3GO26fv5TH4bDS0fO3Xd1C2bkJe6qwEJnk/nduCOT5hTXvSg7P5u47L7OdQk2n
         vbfRouX+idKJSqqUxMh739S5Hx0WcNETHDtcuyy0LuEfx+kYE5qDQH8AiP7LzJGw0sf4
         2LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270053; x=1793874853;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4Cm5Hj6AX2bOx9FeJjSt60AwCDFLiBSACiP27rlh8gU=;
        b=lIO0vaSSMDEBOoG/q1czN3Gtfy2Zm7F/zkOWoS+N/8eVka46+G3HKyHKcE/TW1D9WP
         vpzpGPWptG87eZcpsBAmCSQtWqtLW+LJs5MPMQjk5ohLj4IiIPY/DPoqFKhsgCXxnTRk
         UqRtFka3KOdmQRM8HpAEjpXNxf/R2V2UT+4hjX9bvzqiwb1lN1V3tH83hRm2yd+RcFEj
         0T0ZFNpktA0Kdsux3eRnhEoKiawNTSO/QeaGqnRMRTeeiFfMlV/xBx8bA+9v+BXs9iyr
         JmPW8pHVJYP5DcbHMgJpsAKn02Dcjeq1APi46lxIS5HKASF3lF1IoOBVt2DaLKhrbu70
         DIJA==
X-Gm-Message-State: AFq9FYK/lreeZOqqAl0ur2WVh+VOim7rxujro9XxNKq5InaZhPfz/t8J
	Is1eXa0g7DfXZLyLBYcjgxKR9OIix0XGMbLjDncskHsADBXhbB5rrfTMV/K2uwqLXXfdSnqCp7F
	X4IHkO+yXrz9RW4133IAAmwF5Ie51iEMESZ+lZ/DoqTsiCXUDXkGx/zgNVvU=
X-Gm-Gg: AYBFou1FLcP45gnJkQqLpo3SfLK1EagULxxMqRcLwrr1TNGNqBNhuaq630xAhjNq5MB
	Xp7ZJ37SkJP36hA9iRZOGowryZNOa8aY6jEjk/7Beo6B+iLmTN96IFzueXJhIn+Y7clWVSuh4N4
	1Q7jHfFfAGYFK1wjFWr1bRn6Gb1yBv29scJ/9ImFvmfWtSbxJb4q7tM1WpUtGIKYA3w2zpgJSg2
	Gb5OsrOk0dRSAZGS1DJGpCbXRx2ve7CqfeQPvpXySwCBZLIhlbEuQEfE/ewU6OWQRZmcNq/Ptou
	qJum8phxt48umhefORq8K0LHsEepJFP7m/kUQNov/kVBi+aelwgx10lcwZpk61RvRfV3e7pd5lV
	Tcl6ODmZmQHjR8hBFcgbCZzPOu8zHeFftlZkVHcX1M5Zs0y6EhrpIPD5CiCgAdXbLox0fox41tK
	k6/px7k/heUrIBbCkJsUodDA==
X-Received: by 2002:a05:6102:3e8e:b0:7cc:9d46:ac88 with SMTP id ada2fe7eead31-7d03a56c4d8mr2223876137.18.1793270053149;
        Thu, 29 Oct 2026 03:34:13 -0700 (PDT)
X-Received: by 2002:a05:6102:3e8e:b0:7cc:9d46:ac88 with SMTP id ada2fe7eead31-7d03a56c4d8mr2223860137.18.1793270052618;
        Thu, 29 Oct 2026 03:34:12 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece13aasm31225069f8f.58.2026.10.29.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:34:10 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net v5 0/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Date: Thu, 29 Oct 2026 11:33:54 +0100
Message-Id: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3VNMQ7CMBD7SnUzV7UlAcrEP1CHkFxpJNJALlSgK
 n/n1J3BlmzL9gpMyRPDuVoh0eLZx1mE3lVgJzPfCb0TDV3THVoBcg7BWCTOOPoPMbZ7rY/kTub
 WNSC1Z6ItkNYVZsowiDl5zjF9t5tFbdH/xUVhg33fO2OVI6XGS2SuX2/zsDGEWgiGUsoPOiR7w
 bwAAAA=
X-Change-ID: 20261026-stmmac-est-fixes-13557ed8ab20
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX8EgwatIYxYBs
 yDScB5D+aM+y5DpUokPmLFlUl0Pcpt7vVdCIlyqIw/OilVBPZkTW8AUhcihaeQlvCB7JYzzaQhy
 jo63RtrSDzCLLvJkmu0XiX+bEhY3Q5c=
X-Proofpoint-ORIG-GUID: inXQhbJrYj4Hw45ceutr4ZEsQ-_MlfNJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX5vJ/FD+AwVz/
 43S1pPVNh1SOohMFu4wW+BHD6dwVITdLi/8oH9V4H2dcJhzWEhVDui91MRCmDETeZ/riqOTU7dP
 zK+ec/ara2O7Zo+KuTLQz13UR7G/QFIyEg8ZBDq6ZYlRATrkLnjLLmieYVPT6bKPH2E5/ULGnBU
 p8njGYPrNiBBg1M7qe85Kjo/tmyhvivlnUDjCx9SFmZ8z1l6/w7D58XeaEDZBZSmbL7Fo/2xfOT
 tr+ixqV5VsB/jclBTNszdVLR1ovGTX79C9RRo2O9IJ7r/nSSLSl8VA3U76YQsZ7JeSWYovCdpFy
 IMpOgt/EiVt82sOSCuip2Y7nM/rYN/f/pMPhBjuNwcH7yMUQWC9NWZLjP9XlWdyyMDOSMOdk/Kv
 BfUmJxm9RM1ULu1nP6Q3qDnSDNMrKpTBe3TSKW2dtql52rPzkYIwOyyWlzP34vN0NsZ6BifRt9U
 ssYCkRYNZjhY9TrTSMA==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae32126 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZioezP_FgeoBEakR8UIA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: inXQhbJrYj4Hw45ceutr4ZEsQ-_MlfNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290040

Reconfigure MTL_EST registers after sw reset in __stmmac_open().
Remove priv->est->enable dependency in est_configure().
Initialize est_lock at probe time.

Changes in v5:
- Reconfigure preemption_class in stmmac_setup_est().
- Bail out in stmmac_setup_est() if ptp is not enabled.
- Link to v4: https://lore.kernel.org/r/20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com

Changes in v4:
- Rebase on top of net main branch

Changes in v3:
- Guard priv->est.enable update using est_lock mutex.
- Embed stmmac_est in stmmac_priv struct.
- Rework locking in tc_taprio_configure().
- Fix possible divided by zero crash in tc_taprio_configure().
- Add missing reconfiguration during stmmac_resume().
- Honor ptp error code in __stmmac_open() and stmmac_resume().
- Link to v2: https://lore.kernel.org/r/20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com

Changes in v2:
- Rename stmmac_est_reconfigure() in stmmac_setup_est().
- Rely on stmmac_setup_est() in tc_taprio_configure().
- Link to v1: https://lore.kernel.org/r/20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com

---
Lorenzo Bianconi (3):
      net: stmmac: initialize est_lock at probe time
      net: stmmac: pass the desired EST enable state to est_configure()
      net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()

 drivers/net/ethernet/stmicro/stmmac/hwif.h        |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 61 ++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  8 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 46 +++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 94 ++++++++++++++---------
 7 files changed, 148 insertions(+), 77 deletions(-)
---
base-commit: d2bfe74a8fe219a86b86c1f126e1d722a5001790
change-id: 20261026-stmmac-est-fixes-13557ed8ab20

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033786;
	b=PXqI8Usg1ieWmlrsBPGmLnlyu8q8Mo7OSlIBFQGE60+RespUvfTZMI55RGNFTLDW29ZR
	 Vdbqzq821rx68Yd44raYu9Tjqj0umFP8UbPXXEX63NUCUzlysNhTmsiC9K4KB+LJMz59q
	 THBanTezFbfqhAu1uD2Nq9UI3W7MW6Vj5ef56Ph+GUZjUN2lGcAGiZ0mzj2d3CoJxzF9p
	 DXxYjMFBjs4PWLMA8fYcfQAyZsC4enUuUyCgq+oLrC7cRfMl2kZeni7BW/WW9hTjxutPP
	 4cDh8U1l/Njd8F5bLVTewtmrFUrEC5lRIHiD7nYdH9OQbP5MMgqg9Y5VEzeSC0Ei+pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033786;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tkzUKEtCzO5UO08cgKt/7yCSBIWF6848XalWEGzU7IQ=;
	b=UKJd+wS/rBIAkl0Rq3rKNSAQ9KIQmEEHfsRIWwN12eGf/JlpJA0zfMxj9dbsg3RMxnbc
	 UB6w4O7/fwS+FmC78Q48uHubnLtlhMmG7+gCtDprDrh5wtCPirZfoulVB6Z2FAuNTNpV/
	 nB2WceLiy+7vhulG2p9KA2apKXcGIyzydUgLBV7yWbY7Fba/zySh2J5BzaJW50j73O7cK
	 JaAH/G3T9J3JRjNFEEb7rHBn/3+QRPE3vi72VusTFOUYSzlhiuTHPO4OynBezTsGUc+Tr
	 mvQ6WsOjKH2T3rz2qBy8DqohiCNGG4BNiGt5iPzkXgzhCkQjJ9rUVa7TE9136XzuUhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="NYx0/A4k";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V+q2DUL1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04140606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04140606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NYx0/A4k;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V+q2DUL1
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvbvQ2544094
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tkzUKEtCzO5UO08cgKt/7y
	CSBIWF6848XalWEGzU7IQ=; b=NYx0/A4k3qsNe3Mffzj3VBX2lUiIAky7sUTbjT
	uv/wWx3YTPp1DfaQTMCK1A7BNFaK5Q4/OoV2HimHrpK7qBUDx/Tb9mZbaNY/bwt2
	RDqU9M/rvzcsV25ImfS0IhPxIZVRvYvpFFooDv61JRnZBXiYp6qTD0vc13QzCYMN
	cQNltZbc4j9wDpHlBBolGytNN2uIVv9itG6SdyajUYKeKU1an9VIVWF0CoKMPExr
	ZofA8o6VDrP1bBYdqiddOr3M9Al6cx8kQ5zQATDlA8xnCD54Z09CwtOELr6wT0Ep
	85b26QsDfNuD7VcRFf+PvyKyZBtAJ9lnH9ztCXtGk+FotdJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8smrjnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so828822785a.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793033779; x=1793638579; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tkzUKEtCzO5UO08cgKt/7yCSBIWF6848XalWEGzU7IQ=;
        b=V+q2DUL1MWboJ8yq/P+2ZvcP+SiuHSNMQJ0IionCSINDoPhWDHL3oeRi57jmGNgz27
         5Xv6tIGo/jWpD4lln8cdnJu2iNPEmEVZp5zWdqQCF2xThBWOtJpBhf8k5I/N01ZYnZ5I
         N4smeeVfmrOr/9Z62c8jS34PIxozkYR0xQ4YhKWsZNbcOeLFJa24MjzZbZxXghpIgBOj
         il06/JKR6CsDCokrM56J060nhLHQfL/k4sT54r5yleh7EwmTPewzwR0Vo4mW3btAYWyn
         rqETaXSb8gobqHKnGFBLT0joBddk1mE1XFcl9yHasE9xIKegMOQx6W2JwMQXWrTTHjXv
         /H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033779; x=1793638579;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tkzUKEtCzO5UO08cgKt/7yCSBIWF6848XalWEGzU7IQ=;
        b=1+MUvhNaAR+LAJHR2natnuVGaETcALacYYb2/C9h5jATM6g7/Chg69GWka4MkCE9Vq
         HjzLiytnGDVXSUZ4XyOWtiH3XzwRYcnBW6Y+tx4My2+h82fI9WbCfGa2X0O0/rJ1jhu3
         Beazwfcgco5upo9y5ydA9Cm8Xt25wagin+GloUuAxCs+WubTADsK9wHE8+AmSeRnefP+
         vsNcr+f52zGty3A7/FKlhzxcqKCAdsDAWtDFgccVQhhcSrji0zNgTW2W1HefTV8Zre9C
         3KG/HDuSXbNWH2lA8Zz/ImEqAnr0nJAZzEzyKaqJn/ZNVNZqz8S9y4s7+qgB8DO8td6J
         epJQ==
X-Gm-Message-State: AFq9FYIjII39FDo8pF98B6ZCnX/ECzho5X6dq8A9RIaYd5Q0A6gQPVsU
	SEbYANX+RSltnR+Ow1qTLxd8F2lvHuALYyZNPOe2EhclSYtiI/ch7i+ugYEsrR1OguvkSLLmUwd
	K3+jkHZsSsWtq7b9jaddFYZ8XqLbhnA6mNniGEydTmKPv/55/VS1gfXP3b54=
X-Gm-Gg: AYBFou3YatYouYmT36l5GsOYRF+vbE3o/58D8wp/jhlHkJLq7Y67W3aHElc6Z8xplfq
	oE9/5aOwx8lzt/m9WvPK95hosrqehP/bgTA+LLewzSWLKX2xplRrlx4NkBDfa25tUY/VNpKS1cy
	B1/lzhD44cV2TfRgmWx9OXrpIg3/7MwqMUKL5yo1iKKADX+kcCNBTRPNbJ7nKacgHlLaumrRSRG
	U+KTUHSAHQRBTEWcUcksDWlCMHX0FRegyKTLfE1TfAeQ+SLBLi53JqiN2HBLp+PU/+5Ov4/Y3oN
	awXzunV6lbY5IZ8+JtYdbJNwuSgtnW/027NrBiyeNhbTnnyP443qbqjxSnbyq+vtJ7JZDa9G59f
	rZLYvMc9j9KE=
X-Received: by 2002:a05:620a:458a:b0:93e:5ef8:c794 with SMTP id af79cd13be357-940ef8f03dcmr1103927285a.38.1793033778610;
        Mon, 26 Oct 2026 09:56:18 -0700 (PDT)
X-Received: by 2002:a05:620a:458a:b0:93e:5ef8:c794 with SMTP id af79cd13be357-940ef8f03dcmr1103921985a.38.1793033777993;
        Mon, 26 Oct 2026 09:56:17 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm18697489f8f.18.2026.10.26.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:56:17 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net v4 0/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Date: Mon, 26 Oct 2026 17:55:55 +0100
Message-Id: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2LwQqDMBAFf0X27EKMRqW/Ih5Sfa17MC3ZIIL47
 116mMMwzEWKLFB6VBdlHKLySSZdXdGyxfQGy2pO3vm+MVjLvseFoYVfckK5aUMYsI7x6R3Z9s3
 4B7smSig03/cPxR5v3mcAAAA=
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
X-Proofpoint-ORIG-GUID: lE5Bhnqt4G7Afinx168BePGdkSlDPsfr
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6adf8633 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kOJWhj_ZTKYB6xKoLZoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: lE5Bhnqt4G7Afinx168BePGdkSlDPsfr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NyBTYWx0ZWRfX0BCJ5pd/R83G
 MjsA1dc+phUTr45KDSJVcUPyrXab1OT1TXuAjJwaKSDM+VB8V0nPlB7R4coGThsXrBEygp7HDN9
 6IuY536DhqbcQDVRii5lCKuFS7jSk2A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NyBTYWx0ZWRfX088+26cYJ3CU
 zuEvIa6CdS8G5zT6OjqhXxOQopl7DVqrar0SWuvUQf3mvGstaHtECkKp1nBhbww+XgTOGQcx+pw
 GtqgfF6dCHozUFYNN1gORbwIuO9/uK1Fcf55Jb2leZqjvOMoyb8joIay+bmtxssGE5fpIroPuUJ
 GEpujaco2Q0WUJTll5QQApQARQlfHNOoTxNhKRfSpguZNMZ3Fnp2yhoxOHvJ7O8INOq0d4hcTjD
 dxByAr8aWLfXs1j4eX4ACG8PYoC1BP87VtETe533tkHP4Lar/vOY73QiU74g7pqda8e0EerKxFO
 Op2ApLqg07fUFA48QtFajWs3lqx0Y9/tN3L1vxGL6IPZej+KxoUZkOFuMexNV9u0NakfSa9QZ/G
 n+L4ZG4M56GVeb3GGdMAtBfdaGlFF4X3bWXVW3Nw76Y19dPrw4M9l39aMfYGj2KOL9Tl9CPNQY0
 ENOhP6bFHyAGE1+dsUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260067

Reconfigure MTL_EST registers after sw reset in __stmmac_open().
Remove priv->est->enable dependency in est_configure().
Initialize est_lock at probe time.

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
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 41 +++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  | 18 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 32 ++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 93 ++++++++++++++---------
 6 files changed, 131 insertions(+), 68 deletions(-)
---
base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
change-id: 20261026-stmmac-est-fixes-13557ed8ab20

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


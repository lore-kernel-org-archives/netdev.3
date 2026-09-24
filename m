Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182D47AF61
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246845; cv=none; b=E6S4GKaBjXvSt/8nRSFI1byIyKSCAwY8Aih42Fa7RM512yuNqYgzUcJun6PuPCjwImtIEPaOZkCG6JvrKaLdeANg/kEtddCd2JQ43yuHDIKg606ts1INK72E1gINsqupQd61Fp9mF5/MJgSKt327W+72i6mc0IU0YT9ZzMLR4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246845; c=relaxed/simple;
	bh=zk3nUHSZNGZVwkyBHbCfiN3EPEUTym7A+bTcJzqXCs8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q1njU0qxrbpySb7KHsh83tmczEvee49XPw2rB3kLgFdSfL8eH3nWrEqiGzMYB5HVF6yoXuoacE8itnFSISSNs9cVvY42VGNQLHq+kUqjTwdgBRkS3KLbnEHDjFdLyGxAzqn7rensx5cjcvKmugPAaX5FkXiki+JxQUa2ApYqUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J9lobaG5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C5n1kjyR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9lobaG5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C5n1kjyR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O9PNPC2919286
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1BYBocMOfeShm/OCiT4Isi
	tabOYUNDg/Bfw1ZPW2rVI=; b=J9lobaG5pKZPRamj8ztjsx8UlOLqsV0sZngUrf
	VT+NJ1dLmSzvR4mAbyirSQecWAf9ia7L+MTYRfuUQi2iZWBkE4o/a6434Z0ULPMV
	vYAom/xqNdNrEOX/osrym0goCWkeRrcKUH+SuaYI53sxhSBIIdy9BrOFIjvlp9EI
	xOp/ZAnUMJ3nyJiSnDdWlofz+e/nmsVORS/uZa9cNEh11UWVQBBSpjTcUF3oHVDa
	D8pElrNw+KgkYQdHj4vXY/DMF5pMdKRzuyW6MDHoSzMfe9Hz1i/nC0H8dnwAWSFv
	tdGFI7qA/E12UFkvbvLtE57F4p98psH5W2/izExYkKCladew==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvstuj57d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:47:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0312937eso229107385a.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790246842; x=1790851642; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1BYBocMOfeShm/OCiT4IsitabOYUNDg/Bfw1ZPW2rVI=;
        b=C5n1kjyRpUmGr6qZmQNfyOht8Jmf7P4mmU0k5OjLQP5BGnQSVY5zR7MKgh1sCoa/yu
         cY0az0GwQdI/GzxebBCx5WzmDnuPPnA5H9XIiFRRTyjUVWjy2TCGVx+iqc7CEN43XgDf
         NXui6kUuLB1zitOHm4Iouvlxgl1Lsned/BnITI2G4qBKm7c5gQ9nMgJdQiS3zUhrv45z
         T8kvg1cWBEpwYIhe4Msa2WssLZAlhTfCIgEOC0tCZ5JQCsyDxmUHEWfLdZhZ+OuHidzE
         j/FzzpUEEywdPBBTc+peRdoZ768uNIziuXEVtG1iInJCXDah/Pir4bIX2qopuT4gabwS
         GqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790246842; x=1790851642;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1BYBocMOfeShm/OCiT4IsitabOYUNDg/Bfw1ZPW2rVI=;
        b=OgVeAfsXfojfPpQrBibGF3aEfehqL8XTwR+VPX9GtdnVEByYOCrx5g1bZjK3udp+E+
         oNorE+//+xSDPzDBUqoiXONyofYT848EW9LvORGWz5DM8B9apUegT4bFXfiTWrliMO3s
         kZPhlHkf9u6gPkD6wjylMkrv7FpkUXimCDpv0Qfexazxki4C4310XIRVidYwUzVwxOIj
         DiMG4/eE45GxWMj7VEDkyDTq4FDrpkcNeEYJB+JNoXo+3/E4hspzMoK2WNQv+7Nkyvw5
         X9L5YErmoW1cR1anhjd1qaaOmbVSQLyLiznECLGDWZePQrfgceefyKgCnaBOX1GG0Ffq
         IhvA==
X-Forwarded-Encrypted: i=1; AKwUvBzjL4NjgbuV/wvvl4kaNb3lUIKN++dUrxSDQDO2rcjBaVNVeLejQ5FmPKOsKaV81vyIKi6bxRo=@vger.kernel.org
X-Gm-Message-State: AFuF++nGQV6FCBboWyb9g/zghgVFhEjEHCEZfH+7Qfv/+dATy8wI/iro
	Sx4mpt6Heb8+zUaM0vZbKFKhi1Az0FDGcT0dri6e61fF8tuAd4WcffB0MosWRtIBvURgV6Faf8u
	dKsTzgGRGDEsIsgmd2E4no0QWPWGjBu/UFfs1HKjhhoWGYiKtDibir1QOVRziB3gxIwc=
X-Gm-Gg: AYBFou0gknQzLQoguTmEvyvsY/5NlWbkN1YckvPr7qegoWKINQdwxhsh5Jh1xrGKpMM
	YpuD4n917UD399t9xiARA/Bw24wym57Uqttk5f15SguVZDn5UYZmRJInV9OtboD63gRL8oe+Sx/
	jSVoAVZcCO0yh1vzneoMeOiXQeJ3WuLRt1OjdgrSlqR0Q0Oowv8TWuKU1YHoLjyiX4uaTuIgXdr
	9KkK1+tTNNxqJbJnxofU3vuUEuQbYwDq//Nh5WFzJ9K5SWz7kfqs3WYKRB7CDKcaiwvHsgFgE2n
	J/U6MsydDJM83sGWQsoEUcqUu9rUkJzhoFQR8sv0t8TfLHjlwt2D3LP3dYnO43vPFL9hmM0aOvR
	z4vxXZ3w020Sujg==
X-Received: by 2002:a05:620a:4483:b0:93b:deb5:637c with SMTP id af79cd13be357-93c362a6f6dmr222313385a.21.1790246841555;
        Thu, 24 Sep 2026 03:47:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4483:b0:93b:deb5:637c with SMTP id af79cd13be357-93c362a6f6dmr222307385a.21.1790246840803;
        Thu, 24 Sep 2026 03:47:20 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868486408sm12472980f8f.9.2026.09.24.03.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:47:19 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v2 0/2] net: stmmac: Introduce hw queue priority
 offload
Date: Thu, 24 Sep 2026 12:47:00 +0200
Message-Id: <20260924-stmmac-mqprio-prio-offload-v2-0-fdd8b69efccf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NSwqDMBRFtyJv3CcmYk07ch/FQcynBkyiSSoWc
 e8NWUEnFw4Hzj0hqmBUhGd1QlC7ica7DPRWgZi5eys0MjPQht6bB2EYk7VcoN3WYDyW8Vovnkt
 sJaOS9bqfBIMcWIPS5ijxFziV0KkjwZjNbGLy4Vted1L8Pwc7QYJdSxnpei2mjg0+xnr78EV4a
 +s8MF7X9QMRsxj+1QAAAA==
X-Change-ID: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Davide Caratti <dcaratti@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfXwWZWv8Re6Q04
 1+HZhO0kZmv8lWm/AEPGTnJMn808SI5axiprPTEZtUIqp7x5SC+qrW9Ha7wYfcHxe5qLzYMFJ1O
 cRAVFCpMywUpA9nUVWG6DPlbdMfGEAI=
X-Proofpoint-ORIG-GUID: S6PptPhNoQiQMuqYqNVxCf3gYGGoN6i0
X-Proofpoint-GUID: S6PptPhNoQiQMuqYqNVxCf3gYGGoN6i0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfX6SRTfncSNWQl
 dicY+AFUo41CpRG8hoMWqj0mASxeuhsQ0vXxCCLtV6hoM9IqVeff71sShvUvEDF2zRSKMK7HVjL
 TOIvCzgJdR/+TIu2cG+L/mfcZVnUHkv8WECg9acY8l0doZrj4/dDOyKeP9sjfU63tlTXZ9K1Plk
 KDRwYIM6D/9Rc1RdPPlwAuG606ALJuAs8JoCQkP2MRTMUZC/lAa8cx3qumTq6ZSjwRa3D2HkkyF
 4FPvFxQLibBTEIiZDtEbJjLn8p1lRakD1mgZ/cp7gki4RCTWhU/E7nSwTGrAZJ1IsmLQVJnJEeZ
 ysM6myeAjHfaMLrkikn4DWHK/ykKcyFCAOkyx7kXpZ/dCQkIUKvZ28YiRsBVNDWlmobR3qCrSle
 8UKA8Y9R5j4SS3T24qG48KhZ9UnSoTEYqNC5/aIBMkfLJcPHGclqFqynJdWL6Lz98LoMBPVyHzv
 b1+EHeJvryi9JAfT2jA==
X-Authority-Analysis: v=2.4 cv=cKp1IVeN c=1 sm=1 tr=0 ts=6ab4ffba cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qGTJnaR_OStqIhYHjaMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240044

Implement the offload of the tc mqprio hw queue priority in the stmmac
driver. This feature requires the mqprio to be configured in channel
mode.
Do not overwrite real_num_tx_queues configured by the qdisc in
stmmac_hw_setup().

---
Changes in v2:
- Forbid cbs queue offload if mqprio is already enabled.
- SP requires 1:1 TC to TXQ map.
- Fix the real_num_tx_queue overwrite during device open.
- Require the qdisc to be configured in channel mode to enable hw queue
  priority offload in order to not introduce any regression in the
  previous driver behaviour.
- Link to v1: https://lore.kernel.org/r/20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58@oss.qualcomm.com

---
Lorenzo Bianconi (2):
      net: stmmac: add tc mqprio hw queue priority offload
      net: stmmac: align real_num_tx_queues to mqprio configuration

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   7 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  28 +++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 132 ++++++++++++++++++++--
 4 files changed, 146 insertions(+), 23 deletions(-)
---
base-commit: 6516ac5e6b164bf78fb34d36b4d84d495a07c844
change-id: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


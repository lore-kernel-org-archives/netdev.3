Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD83AAF60
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283602; cv=none; b=XmaSYBrPnZw1e90JUiOnTAZWFRydj2NdHW5Ieipt8Xdi1B39XNvWIBLdpIG5BHJNoyiCRpC3SEtfX4xpZ36+QtIX5QqbJ85Cun1W3vylD4WUE5nJAefGwBP+1JXUsZKlsOjPapn0AecL7js5W60+jCoGdmo1ZlCaNQSp4Nv1nw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283602; c=relaxed/simple;
	bh=PJ79FXd+GQIjugOtHHFp23jCt4n/B66JzooiXaWXFq8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OktVjLwcb3yb9GbgIkG3yMQ8704lgUZr42y4G5xFFQx9mjNNPL0/vnSp0B8vPaWTcnzFWFvWBeW4rhJ3/d9lpXwmUKLEwE7FkemSfD6qHR3ileYGTwBs6rO45AFGetTyIGxK2qfZ5oTpUxQoZ3W78HhB1MbxOZSTMQsdO9vO9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NVzLOLEm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L2GJJxZQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NVzLOLEm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L2GJJxZQ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696ARHin3929469
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 10:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qjdEUuDsrTf0VQLIFjJRwx
	hwQ8VeCQeKJmf+o5tGzMk=; b=NVzLOLEmeV3T+JyMO+9t2iUSNzdv4cqEJ3AdVE
	XP4arCNIPVfTtdHzX9Vest3hqmZduNdawznEf00RA+tFAtsVSYoUkikVO5augjR4
	kel2TT3/C0y1lqM/oa/4Wu5bc7qdvMa4/RGGvEA4SMznW9Fm8IWwO+a7FV7T/pOs
	um9rKWD62dqU2pIxH5OQibj6njn71LQb1VuZeW50nCrPetRJTulxXanNX9lqVCyl
	ENr8aKLLk3aiwSsvCEW8HMM7EVCQfnZJmcqaFB8geETutsb++AuOjkXUjrUVKny7
	AzGSGRyjC0DOHzaCRFIqThDtEEKuaidFDB5mQQu7Td7AMauQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4vmrrnyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:46:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cc359d9easo434154485a.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791283598; x=1791888398; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qjdEUuDsrTf0VQLIFjJRwxhwQ8VeCQeKJmf+o5tGzMk=;
        b=L2GJJxZQB1VVptEBtpgHQcmF819w9dN0lC7YNOs56bu6zXonYaAxs05q7zN52CYY9x
         PJPSjtQN1/pdPsn1eFdHIqLzj6c1mMjUs1np8ks4pw/u9xb9nV5UnDu/ZNaNBuGlnrQv
         Epuk1VBRLGyTWjL+5u9BzO+FDE9gokTBLth/YtY1WYaF5q8eIuDZLlNRbZ+cQxo9FRv2
         U41z7zsfG/oGnoyHaq1YiaHFC9N4c1pWiHXV3ILxDcu4JA1EjGmpYpbgzAWl9NJp1AEi
         I4uFLrG2Z0SvV0qjesJC9h0WjVQcB27IQo20NlLcXP/kVrtPUilcthndU9SSWPKH93Jf
         4zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283598; x=1791888398;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qjdEUuDsrTf0VQLIFjJRwxhwQ8VeCQeKJmf+o5tGzMk=;
        b=aVj00nmmo5V0OBprrGAQfDuMBtQRKVaMRyU4aotFfvXclgYxeXkhdAgD35nFxoYmgk
         d3cS0ucrZCrj2jIX65DjMaQbtWjm5q5N0q0J9HmqrI3AElx0v9KnY3OqFvBRKffqSu5W
         ZLtl/XpSm5UpIn9h2CqRTm2FVz3K0pdsXqC5iw5yOZLJg2jgZf+uK3VMaX0tyhyk5R92
         agWGWmCKGWO7hMbf2L8V1VEqduwviDLmojpon/ZOzniJnzDq2arALcU9EXozidPOvZND
         bjr1wbOPHfyqK8YETlvymU+0RQASRkfowLM0vJKhjgFErh0xo+I2JPEiPBZXuFB0/8gp
         sKkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZ9ir6THTrqpKiLQI2gkZtBuIPbeZGNXv4y7MBhChvg2I3yOYBUdpz7DosLeRdVDwO079usMo=@vger.kernel.org
X-Gm-Message-State: AFuF++kZmkx4IXkg0LVFADwt3ZC1tsvanT+6/Rnel9FheCE7rJ1JoseT
	YiFMA2PNS6A44qTmYgf6b1tO8oyCMfc+esvMHXKH0qOfmTw/UKKelV5dL75RIiCK/ZhbHbc2oCQ
	TDbyilxDOjfSqAHOKVLTxJKjMYrKqoHLcne5LogHZhbwVSg7PV8EMg5JpVQc=
X-Gm-Gg: AYBFou3cpBWhVIwjp0kEUwW1p4wFEi82GeF+ISeTklmjVkycmTOfkcojSnwbHenQug7
	/dpMKlCpgaRhH4tqxEY3UYxSl/01rtA3q6q2ThGAFdH8BhYOwrWq4LSF0UWIPExNHL+7dyDbyax
	X28ZWtviyibjjCCyv1iYvXG63rEQeC8yjqsOig9rkUrQLPqK8KZNOhEHlCI02d1DlkdmcyNNqyt
	J8Rn+J+kP9YLvP5zlE5IvckrQ+YRUkKDrO9Ekofc5DjfV0+NI+iFuki0riWkhu3MVN6WyOsoaLS
	kHTqtxE5i1rfIPBKdUTCytVJsBOUt4Sf8Q37jxCUxPjgOiPYqEN9r9ZeoOTAaIKoxMROiDKFj/S
	H7o++06cQWp51ig==
X-Received: by 2002:a05:620a:8805:b0:93e:653e:6981 with SMTP id af79cd13be357-93e8f20609amr163843285a.11.1791283598278;
        Tue, 06 Oct 2026 03:46:38 -0700 (PDT)
X-Received: by 2002:a05:620a:8805:b0:93e:653e:6981 with SMTP id af79cd13be357-93e8f20609amr163838585a.11.1791283597698;
        Tue, 06 Oct 2026 03:46:37 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db0929sm63762245e9.12.2026.10.06.03.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:46:36 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v5 0/3] net: stmmac: Introduce hw queue priority
 offload
Date: Tue, 06 Oct 2026 12:46:24 +0200
Message-Id: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Oz24CIRAG8FcxnDsGWBD01PdoPPBvKoksCuvGx
 uy7l3JoPNRNL18ymcnvmwepocRQyWHzICXMscY8tkG+bYg7mfEzQPRtJpzyHd0zDXVKyThI10u
 JGXpkxHM2HgavudcKlXWaNOBSAsZ7xz/IGCYYw30ix7Y5xTrl8tVbZ9b3/ymYGTCQA9dMKnRW6
 vdc6/Z6M2eXU9q26PrMn0QuVkUOFNB7bXf7gM7hC3F4Ftd/HJporA1MM5SUixei+BUZpWxVFD+
 iEu3QK2RB/iEuy/INrmltvMsBAAA=
X-Change-ID: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=XZ4cX455 c=1 sm=1 tr=0 ts=6ac4d18f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kCoPmbC7odpt6DihikQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: zMSfDr7JWcjciAexnVpg5PmdkYpEVn_P
X-Proofpoint-ORIG-GUID: zMSfDr7JWcjciAexnVpg5PmdkYpEVn_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX45ch6McudbuD
 2f+KnPjCM0gaGE+yHmFoP0T2Ac/I7OXQsyFVIvWMlRP7cCSTOYUDk8SvQii93xm1tGMb90Qerdo
 D1VR6OBVCR03Exbut1m+QOG6vfPoumwwuKtQcLwhqZwiBoRQtN3IGe2E5p2knvPetEoR5QcC1Mb
 fMpQOoHaLRNN5zD6UKrFIngy7h5Hx/0QkVt+xBx64+sUnX5zxvcR6/zlTw1HlTi5JEpjSAL9H8I
 RtLAm7+6ZzpRI9mHK2UBR+KiWwFxNgN268Y16AYLNXQes4Ajl5aA6ZqOR1NhYyYBCDnsF9q5BsO
 8gidjjsxNjdlNHlThZCh8I1nWD8hTs9BGtfT43FDCL1GFruE/Xi1MLFXGBvVpDiS/knBMktON2i
 vGmbrx57YBrzJphIx3jF0hu90GU2YsMRpTwn1XiM13coXydb5PtPQOVCXFTvmInuEiGvFJ0PPIx
 RPuvGHqL8j7ZRiIeKJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX0Xezt7TB9Q5X
 lkoDiJ0aOOJFMcCP3+vjhJKbd127iH8rDgS9NgtmtzXRuICxNGjA1EP66dnpHfCFkp9C4TRygeF
 oetL+DiUHR+yG5HJUkJRDvSPjcIjwkQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042

Implement the offload of the tc mqprio hw queue priority in the stmmac
driver. This feature requires the mqprio to be configured in channel
mode.
Do not overwrite real_num_tx_queues configured by the qdisc in
stmmac_hw_setup().

The misbehaviour has been reported by Shashank and the patch has been
tested on a Qualcomm RB3-Gen2 board.

---
Changes in v5:
- Move max num_tx_queue check from patch 3/3 to patch 2/3
- Check MTL_QUEUE_AVB queues in stmmac_reinit_queues().
- Update commit messages.
- Link to v4: https://lore.kernel.org/r/20261001-stmmac-mqprio-prio-offload-v4-0-a74610d7f1e5@oss.qualcomm.com

Changes in v4:
- Move real_num_tx_queues fix before mqprio offload patch in order to
  allow easy backporting.
- Add patch 'net: stmmac: set real_num_tx_queues from max(offset +
  count)' to fix the real_num_tx_queues configuration.
- Link to v3: https://lore.kernel.org/r/20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024@oss.qualcomm.com

Changes in v3:
- Fix cbs overwriting removing mqprio qdisc configured in dcb mode.
- Return an error in stmmac_reinit_queues() if configured number of tx
  queues is lower than xmit_qdisc.num_tx_queues and mqprio offloading is
  enabled.
- Link to v2: https://lore.kernel.org/r/20260924-stmmac-mqprio-prio-offload-v2-0-fdd8b69efccf@oss.qualcomm.com

Changes in v2:
- Forbid cbs queue offload if mqprio is already enabled.
- SP requires 1:1 TC to TXQ map.
- Fix the real_num_tx_queue overwrite during device open.
- Require the qdisc to be configured in channel mode to enable hw queue
  priority offload in order to not introduce any regression in the
  previous driver behaviour.
- Link to v1: https://lore.kernel.org/r/20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58@oss.qualcomm.com

---
Lorenzo Bianconi (3):
      net: stmmac: set real_num_tx_queues to max(offset + count)
      net: stmmac: align real_num_tx_queues to mqprio configuration
      net: stmmac: add tc mqprio hw queue priority offload

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   9 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  45 +++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 146 ++++++++++++++++++++--
 4 files changed, 178 insertions(+), 24 deletions(-)
---
base-commit: 8b4e7209c842d8cb9516f1f5ef0a88aa2d8831a6
change-id: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


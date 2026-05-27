Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322583B530A
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864854; cv=none; b=RLykE1gdJ3dDZMC1+ptMfUutEe1aZqOp5VAuAJ/NNTwEybJxASZUmCRe0IekfYgDOJpFlV/YzhUaEZRfUxgGduh4qu4SIDm2xJ0KQDTaTMPtzkX0+kWzeGwsmEzjK8l792bGznAp4sq5p1IjU/rMNvk1K71TMGlxXIv4SVLkQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864854; c=relaxed/simple;
	bh=fM0plX/kR+crc1qQ3d8WsQDEz8aR8g5fVoo0fYY4ctQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxgIFM3J9MJxPviALQPsoamNr2KzmdnWmt9Cbth9CbeUXW+LQUZLOJlW+W8/OzwbU6Zra718W4M1SNjCsVP4bn6h0ThPIJaU1/QzdGgi9/VuO7d88Z3S1d3hoij5vx7FyheHDRY8nIs0NJM2OIjKMSA5FekLf1RxRSMWlz19OI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ENoR0uQn; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ENoR0uQn"
X-UUID: d68b08c4599811f18dc8c9802ae25ab1-20260527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jEbJztk+qbvvYLEP8OOXK+yFkqyvTK/6EDpOPmk4xQ4=;
	b=ENoR0uQnw8bmHWoFDjokzPbubhmqiT1HoSuJLRUsjmh7FkszrvTIkmht6TpVu8OUuDyKW1mJff+T8uqCu+GlLQBuH0dy6nuEiQS3lKefTx7MFkrHP7xrNXj71G84K9aTZmQk+Yj51r5OAPMiA/G8Cupi7ZHwhOvX/IGKPpnpxfs=;
X-CID-CACHE: Type:Local,Time:202605271431+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:43c08214-008f-4a24-b939-cd2eb583c00b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:d3602710-8fbb-4218-97c8-12d4481fb991,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|836|865|888|898,TC:-5,
	Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d68b08c4599811f18dc8c9802ae25ab1-20260527
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jianyu.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1136049063; Wed, 27 May 2026 14:53:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 27 May 2026 14:53:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 27 May 2026 14:53:58 +0800
From: <jianyu.li@mediatek.com>
To: <kuniyu@google.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <black-ch.chen@mediatek.com>,
	<ivan.tseng@mediatek.com>, <jianyu.li@mediatek.com>
Subject: [PATCH net v1 2/2] af_unix: Add test for SCM_INQ on partial read
Date: Wed, 27 May 2026 14:53:42 +0800
Message-ID: <20260527065342.2463433-3-jianyu.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260527065342.2463433-1-jianyu.li@mediatek.com>
References: <20260527065342.2463433-1-jianyu.li@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Jianyu Li <jianyu.li@mediatek.com>

Add test to verify that when a skb is partially consumed,
unix_inq_len() return correct remaining byte count.

Before:

  #  RUN           scm_inq.stream.partial_read ...
  # scm_inq.c:165:partial_read:Expected remain (512) == *(int *)CMSG_DATA(cmsg) (768)
  # partial_read: Test terminated by assertion
  #          FAIL  scm_inq.stream.partial_read
  not ok 2 scm_inq.stream.partial_read

After:

  #  RUN           scm_inq.stream.partial_read ...
  #            OK  scm_inq.stream.partial_read
  ok 2 scm_inq.stream.partial_read

Signed-off-by: Jianyu Li <jianyu.li@mediatek.com>
---
 tools/testing/selftests/net/af_unix/scm_inq.c | 54 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/testing/selftests/net/af_unix/scm_inq.c
index 3a86be9bd..84a742e69 100644
--- a/tools/testing/selftests/net/af_unix/scm_inq.c
+++ b/tools/testing/selftests/net/af_unix/scm_inq.c
@@ -8,8 +8,9 @@
 
 #include "kselftest_harness.h"
 
-#define NR_CHUNKS	100
-#define MSG_LEN		256
+#define NR_CHUNKS			100
+#define MSG_LEN				256
+#define NR_PARTIAL_READS	3
 
 FIXTURE(scm_inq)
 {
@@ -120,4 +121,53 @@ TEST_F(scm_inq, basic)
 	recv_chunks(_metadata, self);
 }
 
+TEST_F(scm_inq, partial_read)
+{
+	char cmsg_buf[CMSG_SPACE(sizeof(int))];
+	char buf[MSG_LEN * NR_PARTIAL_READS] = {};
+	struct msghdr msg = {};
+	struct iovec iov = {};
+	struct cmsghdr *cmsg;
+	int err, inq, ret, i;
+	int remain;
+
+	err = setsockopt(self->fd[1], SOL_SOCKET, SO_INQ, &(int){1}, sizeof(int));
+	if (variant->type != SOCK_STREAM) {
+		ASSERT_EQ(-ENOPROTOOPT, -errno);
+		return;
+	}
+	ASSERT_EQ(0, err);
+
+	ret = send(self->fd[0], buf, sizeof(buf), 0);
+	ASSERT_EQ(sizeof(buf), ret);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	iov.iov_base = buf;
+	iov.iov_len = MSG_LEN;
+
+	for (i = 0; i < NR_PARTIAL_READS; i++) {
+		remain = MSG_LEN * (NR_PARTIAL_READS - 1 - i);
+
+		memset(buf, 0, MSG_LEN);
+		memset(cmsg_buf, 0, sizeof(cmsg_buf));
+		ret = recvmsg(self->fd[1], &msg, 0);
+		ASSERT_EQ(MSG_LEN, ret);
+
+		cmsg = CMSG_FIRSTHDR(&msg);
+		ASSERT_NE(NULL, cmsg);
+		ASSERT_EQ(CMSG_LEN(sizeof(int)), cmsg->cmsg_len);
+		ASSERT_EQ(SOL_SOCKET, cmsg->cmsg_level);
+		ASSERT_EQ(SCM_INQ, cmsg->cmsg_type);
+		ASSERT_EQ(remain, *(int *)CMSG_DATA(cmsg));
+
+		ret = ioctl(self->fd[1], SIOCINQ, &inq);
+		ASSERT_EQ(0, ret);
+		ASSERT_EQ(remain, inq);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.45.2


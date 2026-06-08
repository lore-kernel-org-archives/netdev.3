Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59293C061C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913109; cv=none; b=nAkgoG7Cg0p1Rha2+4QUuaTmzrYPNYsMxLGTrG6Bki1R/EMdNh4lE3R6cETHBROzFwgieCBLckHZubp/WICQXpK/5S7H0Ak3wgiJq8WHX3L977b/gtjD/HcUmVr8v9uqRg9KT8G7rVf77uRxx4qjFCP2aH1vChPaiu5TAXdjtOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913109; c=relaxed/simple;
	bh=0W94w6fs7viMhQbKSnlxjxu1MS9582Oqvi5JNJF5O30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y4L+mBF6z0b3rogpehoCmTgp1jewMdhq4Jyr9f/mPvUyT6jbLT/YTrAx9XFH9Qp85ybocUk07erU7q81GQuY+e+122k3e65wfeiAuQLrBLUuROnnWHumAP85sxzbepvPLGX3sJoFTNKQgIAl5ph+y09mfbYQ63uAaReiHVlgX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKP81Qz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKP81Qz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F99E1F00893;
	Mon,  8 Jun 2026 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780913108;
	bh=9U+5fldVYmBvwp/O/A3JCN0H2APJJgaD0mE9E0vl4vk=;
	h=From:Date:Subject:To:Cc;
	b=MKP81Qz8m1T/iFQMx245ifNkvXfpskLsBHqePTCT28Q6mvhDJNetcOvliMhSlWTgr
	 uRGeOcaANpRLIpFWfd6Evso0uHvyOX7EZotNKAnlZ/h4bNtuakgWFKe4hFBIMmYp+G
	 VzzctX9eAr01FpWzEv3jetpV9egmlUp8YWIpeoLxkxXWz9FWuTkPLFV8V0ViAEykqC
	 WH82cBvtbL5202KQ3fLkpWr/YQ1XnEd+RDpVrnpLm0TbBmkZempjh06iS+mjI9qSV8
	 nCgYSGx8tT0LsF3JntJGc6FtCt6Mt193UZuL/rFUhXBcV9cew6zz9cwLLpCXvSPQ3q
	 Be9Y0hE7tGI9A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 08 Jun 2026 12:04:40 +0200
Subject: [PATCH net] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-airoha_qdma_set_trtcm_param-retry-fix-v1-1-f07704f0d8c5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQrCMBAAv1L27EIMNBC/IhK2zdbuIWndLKKU/
 t3gceYwc0BjFW5wGw5QfkuTrXa4XgaYV6pPRsmdwTsfXHAjkui2UnrlQqmxJVObS9pJqaCy6Rc
 X+SDF7OMYpjj5BXprV+76/7lDZYPHef4ArEdXMXwAAAA=
X-Change-ID: 20260605-airoha_qdma_set_trtcm_param-retry-fix-a9d2956b9b2f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Brown Huang <brown.huang@airoha.com>
X-Mailer: b4 0.14.3

From: Brown Huang <brown.huang@airoha.com>

CPU accesses QDMA via the bus. When multiple modules are using the bus
simultaneously, CPU access to QDMA may encounter bus timeouts and fails,
resulting in QDMA configuration failures and potentially causing packet
transmission issues. In order to mitigate the issue, introduce a retry
mechanism to airoha_qdma_set_trtcm_param routine in order to ensure the
configuration is correctly applied to the hardware.

Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
Signed-off-by: Brown Huang <brown.huang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index eab6a98d62b9..aaf7d8c8ccd3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2493,14 +2493,23 @@ static int airoha_qdma_set_trtcm_param(struct airoha_qdma *qdma, int channel,
 		     FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
 		     FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
 		     FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
+	int i;
 
-	airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
-	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+	for (i = 0; i < 100; i++) {
+		u32 data;
 
-	return read_poll_timeout(airoha_qdma_rr, val,
-				 val & TRTCM_PARAM_RW_DONE_MASK,
-				 USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
-				 qdma, REG_TRTCM_CFG_PARAM(addr));
+		airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
+		wmb();
+		airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+		if (airoha_qdma_get_trtcm_param(qdma, channel, addr, param,
+						mode, &data, NULL))
+			continue;
+
+		if (data == val)
+			break;
+	}
+
+	return i == 100 ? -EBUSY : 0;
 }
 
 static int airoha_qdma_set_trtcm_config(struct airoha_qdma *qdma, int channel,

---
base-commit: 4aacf509e537a711fa71bca9f234e5eb6968850e
change-id: 20260605-airoha_qdma_set_trtcm_param-retry-fix-a9d2956b9b2f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


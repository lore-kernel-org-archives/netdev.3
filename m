Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001359;
	b=SdxOpIejT/HvQ5/iDYC6V7WGByL6+llMuLElrpbLtLLrMzk96RvS75znWtlNLVsTQwdE
	 j9DZf1RRWpCpAueMbRcWApxsy7oU0a74JyV1roQirG8hQZl+6LJLLukWT2HUwslsqQORN
	 D4AFzo2/51K1XcYGm8J3UcAYlYuWqrmtXxc4KFpAUMhK4g6ecV5nlm1LggTp8/BOA59Ww
	 2uFJpBNdtbzwszliWVkvKuAuQILRDAK8I61FaLBnphOFxGY27EFjyhboxCWtSfleSodXx
	 Stzg8+QcOEvB83RCpmc7P+SDiaO4QqIW8f6qq/VMiipICEGwD44ijSCqxUzBPvGaMTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001359;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Me1IHTGh7HaHL/Lp2GiEA8ohCBtZ5+Ph03H7s2kqLjo=;
	b=5dmxp1+LespzUFJw/hsandoMpIxfjzxMk6SZCfLl3XZrxJtjvxgi5n6B2OpYmNV0u7JS
	 D8dnDX2yljvkA1WHN9Xb7a5u0mdUelDitZ7W4aYEzehkq2mJ+fecorMQ8gcyRv/uui8KZ
	 d85siA4zOeOkvGyTI3GX67UIvK64OciISe/aMmWsv1mp5lz9jBLegkK2u7WKObOwDApue
	 bBIp3i3t8Lf44nE8AelYr+wSlfV53i0RmdnuArk9TfrPT7nE9dfUVGZiADf430NMrMk8P
	 e2ZmwBNZy/FwS03YB0q7WgmCcdcmYaDnuZYszNilBkLrro35TkbOwpMzRXeUHPPcYYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mucse.com;
	spf=pass smtp.mailfrom=mucse.com;
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8E606A31A;
	Mon, 26 Oct 2026 07:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F8E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1793001290tb456ae39
X-QQ-Originating-IP: iSu4K1cwzRODviiMBIePWVeQmAUrC3usdp+Obm7KSdQ=
Received: from nic-Precision-5820-Tower.tail7b ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 Oct 2026 15:54:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17866973158191589033
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net] net: rnpgbe: Accept link-down events without speed magic
Date: Mon, 26 Oct 2026 15:54:45 +0800
Message-ID: <C2DFBBF04F1DCFD2+20261026075445.920572-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NU4e3V92LJuQi/2w+WXj/grTUfD3Dc4ce6ext5jmL93DdEiXE9ECyIXi
	UJ534xj55WfZ8LJm5s/v8tAwJQNdxl5rMDiET1fRf74o/zobTfAzpPARXAedbu6uGvT41pI
	J1FD9qPNimlmu3By38z9wRnLJ65A2uDtP+qQOaDgyKtQhLY+zgoCsHDu83fPgPP4j55f33v
	pjjlSIhMwBMjNX+VXrLt7XZDhPjiSa00MBwLVtbBtcPntDMm7sST80nb2WEIz8c6PmRrp/6
	Y3h1NiNgGQ4ilgRA8ZxDBr+4LJJRM9/h4Ve5xsJaAe4YWOp+WHpAlYXgkHHibSGPKo+BIAN
	3V8Xlvae3nUqcOLCZZqR4thxJVAgxfCfxr/h6U9xWHwP4RglKQ+cJZuOhxmxRqbMpkfYRxh
	FDLZSigpU2ZBglzi14+YWKS/0zAX9M/08pV/j5NYwwZowmEGLntHRwQsZl5n2rd0NQD2UsL
	HvtZXKDJRt9oAklp+RGtxDLNVhuygYVIP22wZuEmjVm91Tv8HTK0CedztM5Xt9i1znAiO2U
	oNkcDJD5d2hD5O0viiVtRRDG3SizGZJnU9Qel42aFtFY0lvek7WSPOcdc8EarmSu2MCE4/N
	e8ScuYUIxV2B9q1AbOO5f6ojGJ+Tf3Ky1mEQH3ZA/qWy1TIs59dRUMr+Q1ra1RiaQy5NPtu
	aP5HYQg/IybXqoFpQlNiDJAr4b23tRMjYcRyn6HDi9/MDh1Bv7elRFzsGMEri4x5cDI4Hv8
	7eGjdyyTNAnTse0fJb+5ZCyRTdXCukaB4h8I6ug4ck1eCEesH1Y3osqGdW/loWswRhltBH3
	WK+T2DReOUYLIIe0mVI9BEILur6pfy6EgXjuIKb3lPOrMNeKumLHT6kMpgjV0Ru7kUaBnLu
	2h1E5js3UvlzixI4M8ReO8rAY18X5M8JKWwPXBYY8JMXWgyGZVxnSaVpGwQ6ogqsyr8LvSE
	sp0QLFCpNdQd6Ixq8v/bsmzsNMcfp5HqHaR5Out2dvM4kcSOL9A1IxWYD3cKmuVNv97uBRA
	VU4CS/F44GAV8i84pqPuQSSnQm9cMSice12b9A6SIHLJaACBTg
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

The interface can continue reporting carrier up after the link goes
down because the driver ignores the firmware's link-down notification.

Firmware reports link-down events with a zero port_magic and no
valid speed or duplex information. The driver requires ST_VALID_MAGIC
for every link event and returns before updating the cached link state
when this check fails. It also writes an invalid driver snapshot to
firmware instead of acknowledging the link-down state.

Validate the speed magic only for link-up events. This allows link-down
events to update the cached state, propagate carrier loss, and update
the snapshot exported to firmware. Keep the checks for invalid link-up
magic and unsupported speeds.

Fixes: 92a671d510a8 ("net: rnpgbe: Add link status handling support")
Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 683e0ea74113..c6ce9dbee3d0 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -392,8 +392,11 @@ static void mucse_mbx_fw_req_handler(struct mucse_hw *hw,
 		u16 speed = le16_to_cpu(req->link_stat.st.speed);
 
 		spin_lock_irqsave(&mucse->link_lock, flags);
-		if (magic != ST_VALID_MAGIC) {
-			/* Do not change the cached state for an invalid event.
+		/* Link-down events do not carry valid speed/duplex information
+		 * and may have a zero port_magic. Validate it only for link up.
+		 */
+		if (mucse_link_is_up(hw, req) && magic != ST_VALID_MAGIC) {
+			/* Keep the cached state for an invalid link-up event.
 			 * Use an invalid speed encoding to make firmware report
 			 * again.
 			 */
-- 
2.50.1


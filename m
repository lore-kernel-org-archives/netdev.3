Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA819644B
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932669; cv=none; b=SXmrHab6WG0zrwIwqERFOkDEe6EY1t/P8AZiARSfoT9GLYJnNtsisFRqS6Tz2/saoKpithKvTbkyregNioYr8db9ngH8qKXMlys21Wh3zVBzC3fUrad4A1bH0Rmga3Hwfl6kwTV0ztdjXp7E8CL9dhb6F6SQsDcLfouhXISANa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932669; c=relaxed/simple;
	bh=LZmYzSZHvSmK27C5FKFswe2I1n14E2yXo0OLJz3yogQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9LteLPCxtBUZdo7fSGaw4ut3B/fOIJmhAA5T3IKHkcZbvkYEAFeQDa5cMeqOnkaSm57Gi59jodQ/bzZ51xdNMPwctUKIpGhwT4aOQsIWerdUKsslPD++4tth8Ncz12hFsZkU86wgO8ssQo9ULmi9oPwV4N7y7NxavI3FUsplTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WbERo4Iv; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WbERo4Iv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783932665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XYaYW82p7wsV8E9db+1qghBp7beIn1ApUa8oU9ChvUM=;
	b=WbERo4IvAuB11DQOh4VbdujM8uekC7x9n0u74a61jH818R30RUUQShshZHtHNc/e4lvA1k
	0DWOWL2hfKODG3hsHL0NPYldo9sRDFcTaHq1K3/ycjJ/RslwbddUDydOCkJnegc8JXybzr
	x6+jumCaiQK4iw6k4wK5HagtRk8IpOA=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: chenguang.zhao@linux.dev,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net] net: txgbe: fix heap overflow when reading module EEPROM
Date: Mon, 13 Jul 2026 16:51:11 +0800
Message-Id: <20260713085111.1481884-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

txgbe_read_eeprom_hostif() always copies round_up(length, 4) bytes
into the caller buffer, which ethtool allocates with exactly 'length'
bytes. A non-4-aligned length therefore causes an out-of-bounds write.
Copy only the remaining bytes on the final dword instead.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index affea1a364ef..26d0cfc58ee2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -96,11 +96,13 @@ int txgbe_read_eeprom_hostif(struct wx *wx,
 	dword_len = round_up(length, 4) >> 2;
 
 	for (i = 0; i < dword_len; i++) {
+		u32 copy_len = min_t(u32, 4, length - i * 4);
+
 		value = rd32a(wx, WX_FW2SW_MBOX, i + offset);
 		le32_to_cpus(&value);
 
-		memcpy(data, &value, 4);
-		data += 4;
+		memcpy(data, &value, copy_len);
+		data += copy_len;
 	}
 
 	return 0;
-- 
2.25.1


Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8154349B6;
	Thu, 17 Sep 2026 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628244; cv=none; b=Yjgt3ZqVNRU971Y2pnGX+DeqwaYIuWowCfec8Mx/5YOFpdTkkh59eam55hdNdxaVcVwq2TxgOJvkpjF1MJzrIub1iSQmqIe6f7G8fhINQUHA2McrboU3EjYX3R5/G+nDKGjK0WOFzjQq38jiSdiKabRMctbaprCqgBUvjXlOB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628244; c=relaxed/simple;
	bh=iyl7FQ+Gv1NiI/BFBH6s9VKhEv8ZnqBqswxiyA5zNlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfSDtRZzAT8SwDhXzdy3b0sYfI+PLogczFHyvyTwtSwZ7NVRCPMDAM+R+pMRpA1QS82hlMqCnZR6qI3nn4N83AlGHZfeURjHRhwXVqgW8YV22V64m7Q4LE/f+QqXGHBh9PqY44RmTn2YHyM3Ia34pcLcuqcCg1Fvww86rj+pRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ovrsHTcz; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ovrsHTcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=W7
	QVInwog2OZRxOhpEnTpBcnqOtnYxTp6Qw+8w3MYWo=; b=ovrsHTczf1wDCRLPbL
	pj5zMbxRBCkQ8z2tCJKCIWKzDn9JGNNnJYCnFNAG6AvmNIhyKyD9jfHCKsjwFyzA
	kN96ClZwkSd2W+352Gbv4mabM3KR26ZLslU3PChxAWNdrmIufshm5zrcHAV0ITpo
	BulBxn2/cWMRn8SRmJ3PfidBI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3X7IAj6tqQTSDBQ--.47835S3;
	Thu, 17 Sep 2026 14:56:02 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jedrzej.jagielski@intel.com,
	kees@kernel.org,
	aleksandr.loktionov@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP reset timeout constant
Date: Thu, 17 Sep 2026 14:54:36 +0800
Message-Id: <20260917065436.1181073-2-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917065436.1181073-1-xiaolinkui@126.com>
References: <20260917065436.1181073-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7IAj6tqQTSDBQ--.47835S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1fCF47Cr18CryrGw15Jwb_yoW8XrW7pF
	WUXasakr1fJr4Iga40vay8AF9xW3WDKrW3KFWSy3y5u3Z8tr1DKrn5try3tryIyrZ5uF4x
	Xr1j9rZYya1fCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVMKtUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQJpQGqrjwLwgwAA39

From: Linkui Xiao <xiaolinkui@kylinos.cn>

IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC is misleading: the value counts 0.5 s
poll iterations, not seconds, as the comment right above it already
explains. Rename it to IXGBE_DEVLINK_RELOAD_MAX_ITER, which says what the
value actually is.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 781f13240a0d..15b14c5a7c4e 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct devlink *devlink,
 }
 
 /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a sec */
-#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
+#define IXGBE_DEVLINK_RELOAD_MAX_ITER	20
 
 /**
  * ixgbe_devlink_reload_empr_finish - finishes EMP reset
@@ -464,7 +464,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 
 		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
 
-		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
+		if (i++ >= IXGBE_DEVLINK_RELOAD_MAX_ITER)
 			return -ETIME;
 
 	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));
-- 
2.25.1


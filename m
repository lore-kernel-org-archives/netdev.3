Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163FE4418D7;
	Thu, 17 Sep 2026 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628247; cv=none; b=CJ10kx2mpopgCKYMrn+KMsylxkOF3mhD7Gm/nvfR9gtf+XDKkoo/RSWv4K/vZBg1+q+4e17KI4Wd5WWRePMOKOv4meiBC0o8yMGSjLHewE43wW+gTBGXiR7ADaYOGbKQoB9ENuf8I5KUSu36J9Gy8PYx1a5+GOYopjy+vVvqrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628247; c=relaxed/simple;
	bh=NDmjBfPXqUCwb0277MkB74yRPXjYVJcqmLzIrjedTz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gG/o2Xc9sP0gF6O7HZeWLLwgt5wTGMlRjhua5ckoJtZuExBD2gAql8aErFvG6CfdfRX9ftrBh63Dz4LHZOcXdorHjluFqCqbUOa6MNNMvJi344RSPSHN485rCd2yOCFoyQn6CYeNh5yUdM8wZ+j23VeCU+NbLSke0LGB7RiVF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Wq/xXMiK; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Wq/xXMiK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9+
	5aItjV8sXRWYQrSBqF5NevwNFZO4i/q6ItO4H3KNM=; b=Wq/xXMiKny4jxdC7cg
	EWDIOZIGCdT5CPUUUXVIvFNpCj8Kh6btEmSIoM6vfcHbmi8xgH5vgtLwVQNOGfHK
	Tbh1gSadALv11LCQxCLgQcDrRoeySgmtv0UeKOsG3t9lcQkBUnJEE0xXpyELlhaN
	lTIrVVuBKfWaU+1GE/8ER9Ijs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3X7IAj6tqQTSDBQ--.47835S2;
	Thu, 17 Sep 2026 14:56:00 +0800 (CST)
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
Subject: [Intel-wired-lan] [PATCH net v2 1/2] ixgbe: do not busy wait in ixgbe_devlink_reload_empr_finish()
Date: Thu, 17 Sep 2026 14:54:35 +0800
Message-Id: <20260917065436.1181073-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7IAj6tqQTSDBQ--.47835S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW7AryUuw13JF1rAryUGFg_yoW8Zr1DpF
	WUWF93Jw4xXr4Fg34jqa18uasxX3WYg3y5WFySkrZ5Z3ZYyr1Dtr1Utr1fKr1UArZ8Kr1S
	qFn09rsxAFs8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULVysUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQBpQGqrjwDwYgAA3c

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
so it always runs in process context with the devlink instance lock held.
Its polling loop delays with mdelay(500), i.e. it spins the CPU for half
a second per iteration and, because the loop bound is 20 iterations, for
up to ten seconds. That keeps a CPU fully occupied while the firmware
performs the EMP reset, and on CONFIG_PREEMPT_NONE it also makes the
loop non-preemptible for that whole window. The loop does not need to be
atomic and holds no spinlock.

Use msleep() instead.

Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
v1:https://lore.kernel.org/all/20260914092626.263886-1-xiaolinkui@126.com/

v2:
  - Reworded the commit message: mdelay() does not mask interrupts or
    disable preemption, and the ~10 s window is below the soft lockup /
    RCU stall thresholds.  State the actual rationale instead.
  - Split the macro rename into a separate patch.
  - The mdelay() -> msleep() change itself is unchanged, so the
    Reviewed-by tag is kept.

 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index cf8908b82f8a..781f13240a0d 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -460,7 +460,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 		 * may be not cleared yet, so begin the loop with the delay
 		 * in order to not check the not updated register.
 		 */
-		mdelay(500);
+		msleep(500);
 
 		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
 
-- 
2.25.1


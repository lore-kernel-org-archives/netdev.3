Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973113254A8;
	Wed, 24 Jun 2026 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280376; cv=none; b=Bbrk19Lt303kHHfB1AYJhLpmUi4SJT21LYxtTcPmhHUFrNWIOfLU9vHuBB0S89Dbj4XB52QUusVC40OWrAsxEnxqp5njiXbpjiqKTC6V/vAU1wNEQ6r766pfQD/Uxg+KEnN1LMHy9xDfmRVQ0qQagy4JPjGVaSBBkIjQYvapscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280376; c=relaxed/simple;
	bh=FmHpS9olMr6he6+VQDvEmg7wJbx43a9gRqfwPvOGIlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pF8NDmVsxfdIbCNmJx86lEwOptJPK/Jc/oCntGUhOOutEXjo6Sv13okbJ+k7UQso9rBrxU+XImEMRGsrb+twiBHLbVsfC9FpK1xyQgi8Ifyg9Ij1LOgK+03Esnh6MiUur5qIXJWbZ0XuzZ71d20XsGYmRG1tng7SZ/G/PjeSOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TC4Khvl/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TC4Khvl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bu
	2VSzJ80O7wdzuxBw4RVz0n056IVt5Cvv9rI6A1gr4=; b=TC4Khvl/GZWqWqfnRR
	t7wMP890zgU2OxIUX1RmBsF1smcycGZlDJiPPCvl01n+qF1So9Oi+VKxY/8Tvm2e
	ZcxG2z+n3JCuC4rAytneNbB5dm4GbbwQBsxVKeNSehMhqBTQOq+7rJjnNMDvA+vF
	UyJTrj62k5sq2gJsYjyBl9fr4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBHCopYcDtq8r4nFQ--.5279S2;
	Wed, 24 Jun 2026 13:51:22 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: madalin.bucur@nxp.com,
	sean.anderson@linux.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florinel.iordache@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net v2] fsl/fman: Free init resources on KeyGen failure in fman_init()
Date: Wed, 24 Jun 2026 13:51:19 +0800
Message-Id: <20260624055119.2776641-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHCopYcDtq8r4nFQ--.5279S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1rXryxCrWfKF45Kr43Awb_yoW8GrW8pr
	WxK3yakr48trW3G3ZrJw40yFyFkw4xKrWqgrnIgwnavw1ayr1jqF4xKrW8Wrn2qFZ7WF43
	tryjvr1akF98AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyxR3UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hqbCmo7cFo02AAA3y

fman_muram_alloc() allocates initialization resources before
initializing the KeyGen block. If keygen_init() fails, the
function returns -EINVAL directly and leaves those resources
allocated. Free the initialization resources before returning
from the KeyGen failure path.

While at it, drop the unused error check around enable(), which
always returns 0.

Fixes: 7472f4f281d0 ("fsl/fman: enable FMan Keygen")
Cc: stable@kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
Changes in v2:
 - Add "net" to patch title. Thanks, Pavan!
---
 drivers/net/ethernet/freescale/fman/fman.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..3a2a57207e55 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -1995,12 +1995,12 @@ static int fman_init(struct fman *fman)
 
 	/* Init KeyGen */
 	fman->keygen = keygen_init(fman->kg_regs);
-	if (!fman->keygen)
+	if (!fman->keygen) {
+		free_init_resources(fman);
 		return -EINVAL;
+	}
 
-	err = enable(fman, cfg);
-	if (err != 0)
-		return err;
+	enable(fman, cfg);
 
 	enable_time_stamp(fman);
 
-- 
2.25.1


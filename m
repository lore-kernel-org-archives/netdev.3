Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093E36404D;
	Mon,  9 Feb 2026 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630345; cv=none; b=FTiYDqEsnSAyrElFnwcAvyTxisbwVXF16JDiUl2ctxU3ID1vy18e5tD4mBnJuuJJ1XCpQWpXbYNk/abwCk+5Y2jUqnH20gl6EXOuYPivoSD/HUju72XuSeMgX1XKumrxUVPqcKkZuWMgbuMrXmaH8MS6uJkbO65U+g5+bEAEfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630345; c=relaxed/simple;
	bh=i/8Mu9hmje5sRBexZMI0XKnRJ7nL6x+GoD+jELt/CJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DmMNOeZ/vfWHp8tOV/ayZPmNX/sG70PZjW6EwebVWumWSiIj+M8En4WGInOeQrsKBQsvhRkQ0JF+YhY0YCpgSPOJJixyeB+HHw6qrJi/GIQ2TjEqMbVMNO9F18iJ8igfM+NupoRZ3U8jg9HReRXMDf2lUR76ZRpgzivzV/8vUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.16.96])
	by mtasvr (Coremail) with SMTP id _____wDX3eWyrIlpKe2XAA--.23715S3;
	Mon, 09 Feb 2026 17:45:23 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.16.96])
	by mail-app2 (Coremail) with SMTP id zC_KCgB3kESprIlpzoC+BQ--.23042S2;
	Mon, 09 Feb 2026 17:45:17 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: 3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaojijie@huawei.com,
	Duoming Zhou <duoming@zju.edu.cn>,
	stable@kernel.org
Subject: [PATCH net v3] atm: fore200e: fix use-after-free in tasklets during device removal
Date: Mon,  9 Feb 2026 17:45:12 +0800
Message-Id: <20260209094512.33847-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgB3kESprIlpzoC+BQ--.23042S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwYRAWmI5wcH0wALsL
X-CM-DELIVERINFO: =?B?fEFlVwXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR12qq1Zxbg26r1G9JjDbDDsSmmraU3VadI60SsWKFhc1LynJ8j/28Ljgx8w390ho8gFO0
	gSVuLjRNfJqzyRNjVj7U8JEoHXDz9JPxKFqx8qzYj+I4gNee8NhIhdO8gaJ3cg==
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr43Kw43XF15WF4UWFyUJwc_yoW8trWxp3
	yxGw47Cry8GrWj9w17Jw18uF18C3Z3XFWY9w4DK3y2qF1Yvry09r17tFWDWFWqk34xZF1v
	qr1ktFy3G34DAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU801v3UUUUU==

When the PCA-200E or SBA-200E adapter is being detached, the fore200e
is deallocated. However, the tx_tasklet or rx_tasklet may still be running
or pending, leading to use-after-free bug when the already freed fore200e
is accessed again in fore200e_tx_tasklet() or fore200e_rx_tasklet().

One of the race conditions can occur as follows:

CPU 0 (cleanup)           | CPU 1 (tasklet)
fore200e_pca_remove_one() | fore200e_interrupt()
  fore200e_shutdown()     |   tasklet_schedule()
    kfree(fore200e)       | fore200e_tx_tasklet()
                          |   fore200e-> // UAF

Fix this by ensuring tx_tasklet or rx_tasklet is properly canceled before
the fore200e is released. Add tasklet_kill() in fore200e_shutdown() to
synchronize with any pending or running tasklets. Moreover, since
fore200e_reset() could prevent further interrupts or data transfers,
the tasklet_kill() should be placed after fore200e_reset() to prevent
the tasklet from being rescheduled in fore200e_interrupt(). Finally,
it only needs to do tasklet_kill() when the fore200e state is greater
than or equal to FORE200E_STATE_IRQ, since tasklets are uninitialized
in earlier states.

This bug was identified through static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Suggested-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v3:
  - Only do tasklet_kill() when state >= FORE200E_STATE_IRQ.
  - Make the commit messages clearer.

 drivers/atm/fore200e.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index f62e3857144..eb386ec6b5e 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -363,7 +363,12 @@ fore200e_shutdown(struct fore200e* fore200e)
 	/* first, reset the board to prevent further interrupts or data transfers */
 	fore200e_reset(fore200e, 0);
     }
-    
+#ifdef FORE200E_USE_TASKLET
+	if (fore200e->state >= FORE200E_STATE_IRQ) {
+		tasklet_kill(&fore200e->tx_tasklet);
+		tasklet_kill(&fore200e->rx_tasklet);
+	}
+#endif
     /* then, release all allocated resources */
     switch(fore200e->state) {
 
-- 
2.34.1


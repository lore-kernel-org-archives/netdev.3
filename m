Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2351474D;
	Tue, 22 Sep 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071732; cv=none; b=PhpxgHXwxUuiLFbvKtcPvUfrsEaZBiJmZQMJH0K7c06Sed7DWeCPmZIQfcJkq3hThZFL01p/dwsPEbsy8tk5HCKoRxKA4Sirsf1giWZCNR89Qe4IowzM02zHiIrqkfV/Z9+duUsikvAwDs31tvQeeX1zNWN2PWGlE0LiBlZ7Uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071732; c=relaxed/simple;
	bh=8STIlNZoKvhpVzRyhtxCNrb/3AXbhjtmew2QEvEl5Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SJPMOAsJ95zCKITqmT0NlXtDUrvY9K0W2LS4SRr37Ej6dICmyqIgNPyShqatDQVHUb/hHjcgEFEanz3l9DiCE2VQh7koyvdP98r0K21O0hU0ZlmFC32caRM7jR/xsaUzfdmYwjLvH3754M+OEnjgmFa/Javke9QtEUFoeO7rqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 961d530ab66d11f19a56ed5b684f684d-20260922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:18b01b2a-661f-490e-90c2-7c03e692812d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:0e2c3a707044a0ea6fb057000e928f8d,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5|-100,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 961d530ab66d11f19a56ed5b684f684d-20260922
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1838313898; Tue, 22 Sep 2026 18:08:41 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksandr.loktionov@intel.com,
	leitao@debian.org,
	weirongguang@kylinos.cn,
	u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net: ngbe: fix error handling in resume and open paths
Date: Tue, 22 Sep 2026 18:08:34 +0800
Message-Id: <20260922100836.1147718-1-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two error-handling fixes for the ngbe PM/open paths.

ngbe_resume() declared err as u32 and returned 0 unconditionally, so a
failed ngbe_reset_hw(), wx_init_interrupt_scheme() or ngbe_open() left
the device in netif_device_detach() state with a broken interrupt
scheme while the PM core was told the resume succeeded; the reset task
bails out on the missing netif_device_present() check, so the device
cannot self-heal. Patch 1 fixes the type and propagates all of these
errors, making the whole tail of the resume path consistent with the
pci_enable_device_mem() failure path at the top, which already reports
its error.

ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit to tell the
management firmware the host has taken over the port, but no error
path cleared it, leaving the firmware owning a port whose rings and
IRQs are gone. Patch 2 rolls the bit back on all open error paths,
matching ngbe_close() and ngbe_dev_shutdown().

---
Changes in v2:
- also propagate the ngbe_reset_hw() failure, so the whole tail of
  ngbe_resume() reports errors to the PM core (Sashiko review);
- drop the inaccurate "device can be re-probed" claim: the PM core
  records and logs the failure, there is no re-probe (Sashiko review);
- patch 2/2 unchanged.

Link: https://lore.kernel.org/netdev/20260917090050.1927999-1-zhangyunfei1@kylinos.cn/T/#u/


Zhang Yunfei (2):
  net: ngbe: propagate resume errors to the PM core
  net: ngbe: clear DRV_LOAD bit when ngbe_open() fails

 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.25.1


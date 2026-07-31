Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775C1A6806;
	Fri, 31 Jul 2026 03:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785469908; cv=none; b=t/6HCfEy7ChQOug589LotMlWqssB7urtuk/IBgIUbarjezSx/R6IT1Dbvpi2Ank7BGOw21hVRKGeYQhbWdS/Sh7iWDFn/4Oo5EH9QK+WJ2E24AyShztlHgPAZKsnRDeo+aKKPBHd+hM9W6gaRomMYSJPlAvTXb7O/W+qHAif7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785469908; c=relaxed/simple;
	bh=fMaruSGeQ+Fh3s8pqvWvJtbymNokKVnm2xS2lfWhJwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q7mcXYNooc+NyoNeP3fF1+LqoZon2IYOCwZC0pRJ9HNhMccQV7WFIn/6wzbWCkMnWKoeccntFf3AAKQoh7LygXAS3jrnITDt9VfLXotn3+YzKOsuAdJpk7nXkXDpn360vLb4fnZiIsvLiuTvOWQTz2ZKHgyNM/J6LtU3LgPoRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2360344e8c9311f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:23e1fd6a-a138-4955-9914-e0adbbc43a12,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:491f4964259616a37a2e0251573a2e60,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	16|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2360344e8c9311f1aa26b74ffac11d73-20260731
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 594377333; Fri, 31 Jul 2026 11:51:40 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH net 0/2] Fix ref_tracker warnings at boot
Date: Fri, 31 Jul 2026 11:51:33 +0800
Message-Id: <20260731035135.3917308-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two ref_tracker warnings that appear at boot on
both TCG and KVM:

  WARNING: lib/ref_tracker.c:322 at ref_tracker_free
  WARNING: lib/ref_tracker.c:246 at ref_tracker_dir_exit

Patch 1 fixes the root cause: pending netdev_work is not canceled
during device unregistration, leaving a stale work_tracker.  When
netdev_work_proc() later runs during the RTNL release window of
netdev_wait_allrefs_any(), it triggers the double-free and leak
warnings.

Patch 2 is a defensive hardening: netdev_put() unconditionally calls
__dev_put() even when ref_tracker_free() returns -EINVAL (double-free),
over-decrementing the device refcount.  While patch 1 prevents the
double-free from occurring in the netdev_work path, patch 2 ensures
that any double-free from any source does not corrupt the refcount.

Tested on KVM (16 vCPU, 8 GB RAM) with KASAN/UBSAN/KFENCE enabled:
  Before: 2 ref_tracker WARNINGs, 80 UBSAN reports
  After:  0 WARNINGs, 53 UBSAN reports (23 network-related fixed)
          0 KASAN, 0 BUG, no regressions

Jiangshan Yi (2):
  net: cancel pending netdev_work on device unregistration
  net: guard refcount against tracker double-free

 include/linux/netdevice.h | 19 ++++++++++++-------
 net/core/dev.c            |  2 +-
 net/core/dev.h            |  2 ++
 net/core/netdev_work.c    | 10 ++++++++++
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.25.1

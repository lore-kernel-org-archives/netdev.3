Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877243B6F1
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446359; cv=none; b=BMTfzq/JiEmjAsNGOLHmkwAUVLrvOa2tLSBEi8ToAb8pI74ht8h5dZ0QLDY/WEMkXk8quMCTWwclFh2AVMrfwkSIJR8tu4rcZjyC/Usj20aDSwbd6rImMWnhBtF6ZGQulzlJCj+R621RIIdgrY6XUqrwcw7qmOBcTqMIUZ479Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446359; c=relaxed/simple;
	bh=xUUJWepE4lxAPI+JOTE5HZYht8I8kr+WakJhVunVXNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=cmIlN5TP/MKLFtupB1PEEBG83AF5Z8cUUC33ZxUVmv7qDpYrYyx+63NP4uKz/ru3RlW8zSmheL7k+a2Eq97DeE2sZZmPljCGGIRFlad+Nf3LW3L+BH+HRJMshEepFpWl18SfbMG4SZk22kEF/jWwU0DIMwvsLYvdx7LC0q9NX4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=se/0Ogn5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="se/0Ogn5"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174556euoutp02b0b8d991a10162e65b1cc48da0943225~AEwMM6ggQ1787917879euoutp02I
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:45:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260707174556euoutp02b0b8d991a10162e65b1cc48da0943225~AEwMM6ggQ1787917879euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446356;
	bh=WgQu9L7j9OBb7t7iHJoxCQB38xuGz728zo4Ep+7BnWw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=se/0Ogn5oNOEXZQx8AQFkm4+U8AuS8l9SYu8JX+QgNIu7r5Ro3bB3qFMtm1RQs6iX
	 R6U51xqYZZPvumwdzPupFz9o8j8Wt3agUP3fj7gRsAmtpnGt03TZf5toMoWG5sEZVq
	 pUwKhk3umqPCqnZTzhg80tY+3Ylrd0DecKa5Bl0c=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174555eucas1p231d122ef4cc791f59dd36cb78378954c~AEwLZVOtI2928229282eucas1p24;
	Tue,  7 Jul 2026 17:45:55 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174554eusmtip2eb6f48a3c36fb6ce749dd9fd23dd9ab7~AEwKvfykK1463414634eusmtip2Q;
	Tue,  7 Jul 2026 17:45:54 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v3 0/2] net/stmmac: Fix panic during interface shutdown
 & apply STMMAC_DOWN flag
Date: Tue,  7 Jul 2026 19:45:49 +0200
Message-Id: <20260707174551.1264558-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174555eucas1p231d122ef4cc791f59dd36cb78378954c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174555eucas1p231d122ef4cc791f59dd36cb78378954c
X-EPHeader: CA
X-CMS-RootMailID: 20260707174555eucas1p231d122ef4cc791f59dd36cb78378954c
References: <CGME20260707174555eucas1p231d122ef4cc791f59dd36cb78378954c@eucas1p2.samsung.com>

When testing interface shutdown during XDP operation using stmmac driver,
we have encountered kernel panics, either poison overwritten or wrong
memory access, caused by XDP processing data after shutting down NAPI.

To fix this problem:
- Add STMMAC_DOWN handling to all XDP paths
- Change location of synchronize_rcu() to proper place
- Apply STMMAC_DOWN flag on interface open()/release().
  This flag is used for XDP only and does improve handling in edge cases

Proper order of ensuring proper XDP shutdown is already present in functions
from stmmac_xdp.c during xdp_disable_pool(), since XDP can still have
data with NAPI disabled, as disabling NAPI does not ensure XDP finish.
synchronize_rcu() must be executed after IRQ's & DMA channels are disabled to
flush data.

---
Changes in v3:
- Discard almost all changes from v2.
  This was a mistake as napi_disable() does ensure napi_synchronize() and
  it didn't fix anything in the end.
- Return STMMAC_DOWN flag set/clear
- Create new function that executes synchronize_rcu() and call it from
  proper places
- Remove synchronize_rcu() from stmmac_disable_all_queues()
- Remove barren stmmac_disable_all_queues() and replace it with
  __stmmac_disable_all_queues()
- Fix memory leak in STMMAC_DOWN handling in modified XDP paths

Changes in v2:
- Split patch into two: one for XDP paths and second for general fix
- Change commit messages & title
- Fix all cases of NAPI release, not only XDP, via modyfying
  stmmac_disable_all_queues() instead of separate later call
- Drop setting/clearing of STMMAC_DOWN flag in release()/open()

Link to v2:
https://lore.kernel.org/all/20260601163258.554300-3-j.raczynski@samsung.com
Link to v1:
https://lore.kernel.org/all/20260511165045.3091475-1-j.raczynski@samsung.com


Jakub Raczynski (2):
  net/stmmac: Check for STMMAC_DOWN flag in all XDP paths
  net/stmmac: Fix free-after-use panic when interface goes does with XDP

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 40 ++++++++++++++-----
 1 file changed, 31 insertions(+), 9 deletions(-)

-- 
2.34.1


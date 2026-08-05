Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606A3E3147
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914503; cv=none; b=poLEMnsVpHy7vJHnymEDp7YAVVJob+c9OJ6QPWebxghvRKH64m0lQF8lCM/xgvllZ69eFJGUf/sv1zXIsvtdq58bIzoQ8rrMB0tHqzrTyZrvbP4pIw8f9OC0b3ClrevJj1PfUF+LRml/3qjPVd0h8r+TlZlpbyp77s0EilOF/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914503; c=relaxed/simple;
	bh=ZlA8LSDobdMOCzqmRTLb8ST15/7zxIwfojJD1cLqYX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EDgIMEgSicdSzfOIE11vWW+MECeTcjAweHawercgzOBkTrLGFGfsIGcnROWSUb5k+t0A3UnN6mLOCB4oNA9u4zAUzulX0Q08D6YGMA0xnoLjWjX2hLQHAIsgCZawTdzwKoR6YTW6XyyIfB2h8ndclk4xuqGpMA+GHzV2+OiQnxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MK6ZMjGZ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MK6ZMjGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SS
	RluatL0cxwpdmwlU4eXOqaUcZog9M6cqUmCM9H5ME=; b=MK6ZMjGZKP4A9gNLpV
	p+0DfU8trO80GuNG+eLML4rZ7iYZNN1Hg/ezx0j4mQm9JuyN1tCGCSvP/h+T0YkO
	NZKZwHRZ0tOJCfj3PghmH3Xa/n1M3qSoCDjlOShlC2mInfNS8cAyjoOJ7j1+gacu
	N35sLXb7oZoyGqq0gLIPUShM0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3y8R05HJqyJ5SMQ--.37442S2;
	Wed, 05 Aug 2026 15:21:24 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v1] tap: fix incorrect variable used for USO check in set_offload()
Date: Wed,  5 Aug 2026 15:21:21 +0800
Message-Id: <20260805072121.117472-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3y8R05HJqyJ5SMQ--.37442S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUGFW5AFy8tFy5uF4Uurg_yoWkAwbEkr
	1UXrn7C395WF9Fyr1Y9r90gry5Ka4j9a97CwnFvrW3Z3y8Cr18uFWI9r42qwnY9r15WF9x
	ZFn3Zry2yw13tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8aXdUUUUUU==
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4RSN+Gpy5HTPNwAA3w

From: Rongguang Wei <weirongguang@kylinos.cn>

The USO features in set_offload() incorrectly uses feature_mask
instead of arg argument.

TUN_F_USO4 and TUN_F_USO6 belong to the TUN_F_* flag, while feature_mask
belong to NETIF_F_* values (NETIF_F_HW_CSUM, NETIF_F_TSO, etc.) and
will never contain any TUN_F_* bits.

Fixes: 399e0827642f ("driver/net/tun: Added features for USO.")
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index fae115915c8e..ce25ebeeccf0 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -895,7 +895,7 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 	 * user-space will not receive TSO frames.
 	 */
 	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
-	    (feature_mask & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
+	    (arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
 		features |= RX_OFFLOADS;
 	else
 		features &= ~RX_OFFLOADS;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


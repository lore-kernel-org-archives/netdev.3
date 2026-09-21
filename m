Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28901503903
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017495; cv=none; b=iH9vPNRLOTH6Ag+IE9RU8iCNj0KGd2Pf7A9OLUS1pTa/0zx98RswpDTx4fj+EJaPZo5UAvXbtgGbR92rIo9cGr9crnDEkZjk1VfComUXU5WKh1JILA++l30aoGy9kP5eLSO5j3z0JgVcLJRgCRbo/ALpjY0D1djMTOku9K2vs98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017495; c=relaxed/simple;
	bh=nsKX17Plsc3y1VRBNPhDs2eLrURSR/gnVu1+mYgVx1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lftLv3UY/eYfSfKJlp440eDwhvZ8zmfYdKZcvO35gd1gxbCTDeGpzNB/HB84J32jlnPnGvtzPcvqSyRVq+wcJa98Iw0odAjppls4ZP5/AXiFskDRqp5/TbLizQLxle/ACdDfYJDQ9q2l+3VwBJyyTF8l/ah46/aVH8cDkEwRckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jabrsAPH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jabrsAPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA741F00899;
	Mon, 21 Sep 2026 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790017494;
	bh=VfnpRiZbk3qUYYHYmQ9lzvYT+LzMOTtCk+CIpwhKIYE=;
	h=From:To:Cc:Subject:Date;
	b=jabrsAPHbkjkBpDOuzU48Cjvb/Q+KTDlYaAcpEuqzOue0SZJS46j7doBae1R7bAWT
	 vUgBbrj5Nmiu2JXRyRXGVnzrr1zV0JAWCTd4ZA1bp7Ur+m5m69Fi+/0U2n94HHe8hu
	 b8dB6npoi0r2vYabHoPCLyVrIdZb00UwiIKIY6tMk1D2EJfCaVwBIBEHO7Au2s0jyn
	 C+Al4+CjH/QkWR494W+2aSDe0R/cfEVUBUL7H/PRJOOSgCYzZAwsrvEWHRSF4FtiTs
	 wHEbVaeerymq7cMLzlZ3NspoCk0j3EMsxGImKlvb0RQhcj+AqSDNP6kotIZHXkJ1gK
	 kQFJ5eD2S8f0A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2] net: opt loopback into instance locking
Date: Mon, 21 Sep 2026 12:04:52 -0700
Message-ID: <20260921190452.1467853-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev netlink iterates over devices when dumping queues/NAPIs/qstats
etc. and takes rtnl_lock or instance lock depending on the underlying
device. Currently even if all the "real" devices in the system are ops
locked we still have to take rtnl_lock for lo (only to find out
that it doesn't even have queues or NAPIs to report).
Opt loopback into having control path under the ops lock.

This is a pretty obvious thing to do, I've held back this
patch because we used to only apply ops locking on physical devices.
netkit queue leasing made a precedent for (far more complex)
SW devices enabling ops locking. Now adding it to lo should
not create much new bug surface.

I considered an alternative of adding a "predicate" to the iteration
primitive so that we can skip the devices which obviously don't
support given API (eg qstat) without any locking. But it's more
LoC and real_num_.x_queues is not currently WRITE_ONCE()ed so
it doesn't work too well for queues.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - move setting the request flag from gen_lo_setup() to loopback_setup()
   to avoid splats on the blackhole dev which we don't care about
v1: https://lore.kernel.org/20260918210419.4088201-1-kuba@kernel.org
---
 drivers/net/loopback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 1fb6ce6843ad..6187fcca82d7 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -201,6 +201,8 @@ static void loopback_setup(struct net_device *dev)
 {
 	gen_lo_setup(dev, (64 * 1024), &loopback_ethtool_ops, &eth_header_ops,
 		     &loopback_ops, loopback_dev_free);
+
+	dev->request_ops_lock	= true;
 }
 
 /* Setup and register the loopback device. */
-- 
2.55.0


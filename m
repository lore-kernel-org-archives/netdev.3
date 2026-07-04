Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71031E32A2
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783174913; cv=none; b=pGEBkFPOzORdFD5LAx5BvNIbt1ZflY5mZvl/1MVk6E3btrhIaJoh9yNX12ZjMZn+7sI+39Rhnq6FcBIVARos7z1OHnuu6UdtkwsVSnVlJu3kxHTD/fwgDPvYoZi1G1z2hB5fT7u36ztLa7AQRvs+JZz/q3ntl51hTbUqwkvOzno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783174913; c=relaxed/simple;
	bh=mORA4zjsxRpSHR9UQCNydGxZe6yKU6hERFkNGs6MMuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FPmkQSMwO3mwKk29QWUz1WDXB0I/azskO856rGVWKSN7ssyuhm5HyxeaN/qUC3Vx7dAVwprbzJ4To3rvLE6NMHExGikZ/3d+RyQUupzesSE6cEWzWC1ydGwun09wvhOjtIgJRZaUjgGyaX1AFSjaSwlp5hXfp9H1J+3+KrRW19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF4XiaXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF4XiaXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1991F000E9;
	Sat,  4 Jul 2026 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783174912;
	bh=gKSm7rIc5n9tWg7a0XJc9GGyaUYz7rX65FqoNZLGJqQ=;
	h=From:Date:Subject:To:Cc;
	b=mF4XiaXojCm4JUT+iUgovxPxOtZwrJUZJ/KN4x5HdunoTS2k5X5N6UhaZWfyrdRox
	 ZxMWjJqfjbnaa1zL5YgTuEEvkNvM9BXSHlaE87MHXgF4PkpBd1S/sHKWBQ7DOiLLFA
	 NDz/hnlCcgT/x9AialtNBhoH1N1SM/0vnxYHMM5OxumRHJUvajGc4mcp70/ZtMP7pP
	 /CRyLrbPRvrqLFagKdVQUHxWeMVT9mFBBlcGrNrF4imTNCUYq0Zuo5gXiyqHuO1yUu
	 qlyRQ95c5TSo5UIxJWZ7yk5OWafRCHIoLmUALBEVX7F89NBJC2mU92Sx/z0S21MXIM
	 W4XaxqIi7HGyw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 04 Jul 2026 16:21:38 +0200
Subject: [PATCH net] net: airoha: fix ETS channel derivation in
 airoha_tc_setup_qdisc_ets()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-airoha-ets-handle-fix-v1-1-42516b3549a1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqEMBAFrxJ6bUP80OJcZXARzFMbJA6JDILk7
 tPMsl7x6qGCrCj0cg9lfLXomQzaxtGyh7SBNRpT5zvxox84aD73wLgKm48HeNWbZWlFIvrYT0L
 2/WTY/O++KeGiudYfUjnaemwAAAA=
X-Change-ID: 20260704-airoha-ets-handle-fix-6c166de3d396
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3

Derive the hardware QoS channel from opt->parent instead of opt->handle
in airoha_tc_setup_qdisc_ets(). The ETS qdisc handle is either
user-specified or auto-allocated by qdisc_alloc_handle() and bears no
relation to the HTB leaf classid that identifies the hardware channel.
HTB derives the channel from TC_H_MIN(opt->classid), and ETS is always
attached as a child of an HTB leaf, so its opt->parent matches that
classid. Using opt->handle instead can cause two ETS qdiscs on different
HTB leaves to collide on the same hardware channel, corrupting scheduler
configuration and stats.

Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 59001fd4b6f7..fac2aaefffff 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2504,8 +2504,7 @@ static int airoha_tc_setup_qdisc_ets(struct net_device *dev,
 	if (opt->parent == TC_H_ROOT)
 		return -EINVAL;
 
-	channel = TC_H_MAJ(opt->handle) >> 16;
-	channel = channel % AIROHA_NUM_QOS_CHANNELS;
+	channel = TC_H_MIN(opt->parent) % AIROHA_NUM_QOS_CHANNELS;
 
 	switch (opt->command) {
 	case TC_ETS_REPLACE:

---
base-commit: d6456743424721a837e1509b912f362caaeecd97
change-id: 20260704-airoha-ets-handle-fix-6c166de3d396

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


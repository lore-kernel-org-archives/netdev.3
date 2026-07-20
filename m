Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329733B6D0
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546574; cv=none; b=pVkmyLpQwU15uS8IN1/0WJbbIW78GvDd+3XT74+4ICge1UygGDTXgw9JPha6y1G82Dy1tYElV6nnSYSPWMJzOvqWj750mWquUlU6kOCUuVRKMwnZLQCpoeSP1WkfFZ4YmEmmOCVuz5hImzfWSjdLJJDSoxThEu6SWRwcDfkOm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546574; c=relaxed/simple;
	bh=YqhyY/ghwTsbaPLgpnOaQ1gpVNV8cbaeNDEFz4MnpdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oJWbxMnMuWPpfx5y+rMMleBpgf7ekjpwVCuRYSx7kXLHYGXxTqiqU6yqDxt44t0re+Zbb2vN+KdvFRQacbBEwrYLm8Qxy/ns2/wa/eMhjbLORMYsVBurJsKZbY7ctY6WzSijMZo1bGp+mkF4+y7U2DBGKI7Ahe68zcd5mpwHEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5BvaQT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5BvaQT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911EB1F00A3A;
	Mon, 20 Jul 2026 11:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784546573;
	bh=E65nlaruGhJuqNuF8KB2HEMfPViqQyGyJYzghl3Alh4=;
	h=From:Date:Subject:To:Cc;
	b=P5BvaQT32kFKI2rNddOKq6FaDU16ICBtP4dbj+9EB5kQgKbUs0hLZ9WgGPlFStcHU
	 kOu7vSfXhzUQCxQdEt+izfksAeq8fdiuivFgkCjIAkiE94kFupDqQyrhFS/eL/A5yg
	 9HrYMLTbMYIKuAW5wn+RKzNS00EuuANqCCBOP9vV0om3A0vBN6HwlSPsesGXWKeMnK
	 F57HCVYJLLM7s+FBXQuK84MMeeCky+W5X2bkWsMteYXg/n4FKkfR1BAAID9d5ndEk1
	 i8zU4RvxwLySbBmvQvUhfPQdAKhZCexTcTI6E3c5XnwnrZoAP4gOAX5B0ITPnbqVlb
	 olLI3IH6JkUzQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 20 Jul 2026 13:22:28 +0200
Subject: [PATCH net v2] net: airoha: fix ETS channel derivation in
 airoha_tc_setup_qdisc_ets()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-airoha-ets-handle-fix-v2-1-6f7129ddc06f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0Jm7Rj6Qw2uvIdhUekIE0lrpoRoC
 He36QVcfu/lfW+HTMKU4drsILRx5hQL6FMD4+zjRMihMOhWu/bSWvQsafZIa8bSh4XwyR90o3I
 ukAmmd1C2b6ESV+8dIq0wlHDmvCb51q9N1eqPdlOo0OpOuYfpbO/V7UUSaTknmWA4juMHzs49t
 cAAAAA=
X-Change-ID: 20260704-airoha-ets-handle-fix-6c166de3d396
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Rebase on top of net main branch
- Link to v1: https://lore.kernel.org/r/20260704-airoha-ets-handle-fix-v1-1-42516b3549a1@kernel.org
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
base-commit: e13caf1c26587434f0b768193100440939c0fb91
change-id: 20260704-airoha-ets-handle-fix-6c166de3d396

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


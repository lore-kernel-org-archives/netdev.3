Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6A26FD97
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818006; cv=none; b=RECU6XU3FKGoAZYAIeBuiGIP3GNOOE9f0ZZGtcE7eqOHcO1OPSzGn5yeiSFN4NjmBahO0mwh/HObSMBbtr8Jn+EeW+iPOaSx2qzmEYpcM1cjIq6fwZi9axvsV8DPDmGTIhbEC25R3dOEiO2IZfkBskSDSs5vq4xZ0JjyFVxLK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818006; c=relaxed/simple;
	bh=F//IpAgMD3wDtKDNm1zPBSat3ZKLMdMOFyvhnFQCDnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJFuH/MqPoioyI81vIdrg5QyuOr1P4hgVnlEVgR2HOwMz7Xs0/gsMXmqvD2vYPC7HKi5CGp5muNFU/+yEpsfnNuz1eA2tHJ9cfCweRBaC+TveT7sBvpcS8dPlYxeyviIgTq+1BWsR8v3/7Ru/SsZfjia44RbpFa/FEIDB3rCrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1eE7yUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1eE7yUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9351F000FF;
	Thu,  1 Oct 2026 01:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790818001;
	bh=SPntWXyroGUo5ban7hzTgBfuLw7mUBHejVhD+njydoQ=;
	h=From:To:Cc:Subject:Date;
	b=g1eE7yUcKD9hTfQlvKqLM0p9D6bWhjg/1AgNb+M/I9C0Ev2HFwlwl7boSSTttHhx1
	 DdN9nfJX24rfVxDtxFYeK0qfncXNYyHFxfWS7gWpr9rOfUxBNSw4H/fT4NN+ZEpFgh
	 XuCC5qaI/Pnc8w45ZdLA7hMY0GC2Yt+lNH1F8laWSf8/zTgbELT5xHnvT9NlnzLSjm
	 Q7DFaH2a6TEFBvgEJKgRohpglOw+WKVQGGa7hrzIKELX+XbnCDPtil2bisT8fPVsZO
	 E/Trwu75qVTMAU22ItPLCYYXBrGPrJkqbyuOu02KXmNql1Uh9ZCiJe4VRRpJ4UFoiC
	 dVyFBYAubRnNg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jv@jvosburgh.net,
	joamaki@gmail.com,
	daniel@iogearbox.net
Subject: [PATCH net] bonding: fix the program leak when XDP is replaced
Date: Wed, 30 Sep 2026 18:26:39 -0700
Message-ID: <20261001012639.298690-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to release the reference on the old BPF prog, whether
we are going to no-prog, or replacing the prog with another.

Spotted by AI while running tests for the propagation series
(leaked programs were accumulating). Selftest will come in
the net-next series to avoid conflicts.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Fixes: 6d5f1ef83868 ("bonding: Fix negative jump label count on nested bonding")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jv@jvosburgh.net
CC: joamaki@gmail.com
CC: daniel@iogearbox.net
---
 drivers/net/bonding/bond_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index de2489c3d9bf..09aa45d71fab 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5732,12 +5732,12 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			bpf_prog_inc(prog);
 	}
 
-	if (prog) {
+	if (prog && !old_prog)
 		static_branch_inc(&bpf_master_redirect_enabled_key);
-	} else if (old_prog) {
-		bpf_prog_put(old_prog);
+	else if (!prog && old_prog)
 		static_branch_dec(&bpf_master_redirect_enabled_key);
-	}
+	if (old_prog)
+		bpf_prog_put(old_prog);
 
 	return 0;
 
-- 
2.55.0


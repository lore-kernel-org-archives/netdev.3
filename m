Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F53537F1
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405981; cv=none; b=ABFikfaVYXyGmxpn2kRpHCBgu7UObXDQYtznYhZ1/kTtheabs/vtGkS0Rb2NuWjnBnmYFqKsFkLrMDitffX3OPm1EvpoooIu7cvpGg9PmiB+i1iQvqukBzs0JwYdEhRjeVmPwoeqUoWSvRYLaxyC73EOVwWVAzv5h4lswCdNWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405981; c=relaxed/simple;
	bh=eKkbpZi/eGHJUWQ2IcR02A89wuXKV7oCeJORoxNvlAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPizHC63H4Pmcm0WkEgVxgsTgwoKFGK099GeFQYFVkda5bWCmSrXiqU4n9j2R8FlAtTpB2oFH0jlV0uAJq0X6n16VWqh99QBDXC8z8kn/vK8mpVRo2cyYKpllvCBEDJF4V1pSA6gJd9OmqrfTeYeoYxU+yLFjB0irQjn5ncUMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtFuyKZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtFuyKZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328AF1F00A3D;
	Thu,  3 Sep 2026 03:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788405980;
	bh=zf3NUGkWI2sExJobRIHXkOdMkqUpxw2HBS2UlEM2q3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AtFuyKZYun//DqqNj2iRXtjdtQ+3Z728Jcp13TF5RdQSas4RQv61oxnvZzdQmdpID
	 3ytESzvd4zBo1gSQroIHn27VySavMzosW6Npkv8yRqrfb+IMoz6VuAVQFOTdYQadT9
	 lN6L0IVSbP+U0qOS45HiGRGh0VCX7r7qIQvP3G6aSv0lWBVSLM8TKmfb088mrm73m5
	 gJdOK+ZPTFIVkunGkae7iovL+35lP3x7f0aBgysAvBpMxz/lCubm80VwrJ7kcP6yrP
	 z9FIQcGTykgIOGv+o1QAJMPfBgUo3aDqOJkYAYrGUhCkrQxTGljtSEvhl+1N/s3z8P
	 bZtvdV+F7HCwg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	leitao@debian.org,
	yinjun.zhang@corigine.com,
	louis.peens@corigine.com,
	oss-drivers@corigine.com
Subject: [PATCH net 3/5] eth: nfp: drop the replaced rule from the list when reprogramming fails
Date: Wed,  2 Sep 2026 20:26:09 -0700
Message-ID: <20260903032611.3000029-4-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903032611.3000029-1-kuba@kernel.org>
References: <20260903032611.3000029-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfp_net_fs_add() replaces an existing rule by deleting it from the
hardware, decrementing nn->fs.count and programming the new one.  If
nfp_net_fs_add_hw() fails the old entry stays on nn->fs.list - only the
success path reaches list_replace() - so the list is one longer than
nn->fs.count, and it advertises a rule whose hardware entry has already
been torn down.

nn->fs.count is what ETHTOOL_GRXCLSRLCNT reports, so userspace then sizes
its buffer one entry short of what the GRXCLSRLALL walk wants to write.
That used to overwrite one u32 past the allocation; since the walk is
bounded it is a permanent -EMSGSIZE instead, as nothing ever resyncs the
counter.

Fixes: 9eb03bb1c035 ("nfp: add ethtool flow steering callbacks")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: leitao@debian.org
CC: yinjun.zhang@corigine.com
CC: louis.peens@corigine.com
CC: oss-drivers@corigine.com
---
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index 9419e1ed8466..4e83637715e0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -1703,8 +1703,14 @@ static int nfp_net_fs_add(struct nfp_net *nn, struct ethtool_rxnfc *cmd)
 
 			nn->fs.count--;
 			err = nfp_net_fs_add_hw(nn, new);
-			if (err)
+			if (err) {
+				/* mbox broken, adding the old rule back will
+				 * likely also fail.
+				 */
+				list_del(&entry->node);
+				kfree(entry);
 				goto err;
+			}
 
 			nn->fs.count++;
 			list_replace(&entry->node, &new->node);
-- 
2.55.0


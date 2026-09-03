Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4D305667
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405981; cv=none; b=Ow18zvHZWpHzU7NxZoSFhXfKtMy7jEPKCcaCNnWWnD4VRTXdVpKxUOIZ4WsgwjCEoto9UxEbnBGPz7D6EIKXKzQZGFQU37+N9jf5s7Z3Q2afdSsPaC26VEmPLEmQn1laPUt9gOqWIxE36AZX+LK+mkD6G5AJ6Svd50CNcdCi2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405981; c=relaxed/simple;
	bh=smASU3rz2PKoeXdKk9oLfwMQGWXilquhpqMyMc8QjKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW9MrGOmn3GDVVTzjCBnHjw9+Q0k1f/7JeE7/c02/8hZdvJhw6pxVex6d3949khTN7KleXstia7kNYCQkuxUfMW6NnLlpcwgunyCOMQx6c4cg0Dqwf3ymfk7MzX93cHG87FKz9DB64Kt69XhR+L97GH4J6Z77a3m2dWaBY4dgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A467knjd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A467knjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989401F00A3F;
	Thu,  3 Sep 2026 03:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788405980;
	bh=RjsFjY50m/HWrDsQao+R5H+2D9knii56zxqD7/kA2P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A467knjd7X+PfhzJgfMEv7bIVjcwVEDPtbJFCYFRf4ly7L7cXJaXHpuIbqbEgUAtX
	 oLE/samxVrJvI9Ae5YPMs07IIvuaf4LMHF/tjaljTJ5Pu8EpDsgeG2cxk2UiRKBcbG
	 q8azI3pskuJHnk+y4vUpL0m7MwIJxBtbyPq2DKsGlVDzMHcuzajJG+F/xKTTuJwLDP
	 9PBUP9WoX7XU/WOaLxX8S7JsAf4nnB0/YcGZkNcMdGmLlFTw0PN+z1/FY4kpDYMV4H
	 WGwoilFZLXSFNsmEasWxqx+bDuFr/a6hE3hPHMpKZvKS4mEf7xfg2D4AELiFgxJnxa
	 KIxZ5O4ar8SAg==
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
	VEGA <vega@nebusec.ai>,
	leitao@debian.org,
	louis.peens@corigine.com,
	yinjun.zhang@corigine.com,
	oss-drivers@corigine.com
Subject: [PATCH net 2/5] eth: nfp: bound the ntuple rule dump by the caller's buffer size
Date: Wed,  2 Sep 2026 20:26:08 -0700
Message-ID: <20260903032611.3000029-3-kuba@kernel.org>
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

nfp_net_get_fs_loc() dumps every entry of nn->fs.list into rule_locs[]
without consulting cmd->rule_cnt, which is how many entries the caller
had room for.  ETHTOOL_GRXCLSRLALL requires no CAP_NET_ADMIN and the
ioctl sizes the buffer from the rule_cnt userspace passes in, so once an
admin has installed flow steering rules any user can ask for fewer slots
than there are rules and run off the end of the allocation.  A rule_cnt
of 0 leaves the buffer pointer NULL and the walk dereferences it.

Bail out with -EMSGSIZE when the buffer fills up, the way the other
ntuple capable drivers do, and report how many locations were filled so
a shrinking rule list does not leave the caller reading stale slots.

Reported-by: VEGA <vega@nebusec.ai>
Fixes: 9eb03bb1c035 ("nfp: add ethtool flow steering callbacks")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: leitao@debian.org
CC: louis.peens@corigine.com
CC: yinjun.zhang@corigine.com
CC: oss-drivers@corigine.com
---
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index a2a89d48e3ca..9419e1ed8466 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -1421,7 +1421,8 @@ static int nfp_net_get_fs_rule(struct nfp_net *nn, struct ethtool_rxnfc *cmd)
 	return -ENOENT;
 }
 
-static int nfp_net_get_fs_loc(struct nfp_net *nn, u32 *rule_locs)
+static int nfp_net_get_fs_loc(struct nfp_net *nn, struct ethtool_rxnfc *cmd,
+			      u32 *rule_locs)
 {
 	struct nfp_fs_entry *entry;
 	u32 count = 0;
@@ -1429,8 +1430,12 @@ static int nfp_net_get_fs_loc(struct nfp_net *nn, u32 *rule_locs)
 	if (!(nn->cap_w1 & NFP_NET_CFG_CTRL_FLOW_STEER))
 		return -EOPNOTSUPP;
 
-	list_for_each_entry(entry, &nn->fs.list, node)
+	list_for_each_entry(entry, &nn->fs.list, node) {
+		if (count == cmd->rule_cnt)
+			return -EMSGSIZE;
 		rule_locs[count++] = entry->loc;
+	}
+	cmd->rule_cnt = count;
 
 	return 0;
 }
@@ -1455,7 +1460,7 @@ static int nfp_net_get_rxnfc(struct net_device *netdev,
 		return nfp_net_get_fs_rule(nn, cmd);
 	case ETHTOOL_GRXCLSRLALL:
 		cmd->data = NFP_FS_MAX_ENTRY;
-		return nfp_net_get_fs_loc(nn, rule_locs);
+		return nfp_net_get_fs_loc(nn, cmd, rule_locs);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.55.0


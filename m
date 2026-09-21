Received: from mta1.migadu.com (out-243.mta1.migadu.com [95.215.58.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1152773E5
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960757; cv=none; b=sdnPbi4LBomw0ZKp2WWuoSv1RABQXaAUxefRr0njOzWX/U6ccwtNABnkft4EW+lusNZZko1b2GQeD3kBwgMKr1XNk0iJ2wEJemiXWEMFftGO3NAz2V5cIqZpleWrW6vgX+ND+BwGM14QgN5SFMRvIGtvl8uaYCyMy4D0z2QKojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960757; c=relaxed/simple;
	bh=nafX4fOFcVwD34oldbapBUQWZa4m9yYVFt7lnwjGmXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgDMu6S4RYv1S1l5lT/etS9BE+AuyCgwEBOEj9xVMSwb7pUK3++KjL9raeJIqufE/H5zIhZqWfaYw64bHrzJdUu9wR4aE0FGYGDoLFKl3N+oL6OEI2sSED4OFAc+2cC75eKs5PLnjLOdrJvmX+YXxzuRUTWbkmwInY4qsHRPMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YXBxiSCk; arc=none smtp.client-ip=95.215.58.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YXBxiSCk"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nafX4fOFcVwD34oldbapBUQWZa4m9yYVFt7lnwjGmXc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789960753; v=1; x=1790565553;
 b=YXBxiSCkZIObf07hHzsIDe5GfLXO0/ZN2oyj5LZ7vWQKFXyMk7L4cDg88wva7tSnnaR98Sc+
 VuXwqm8Y43sPKWp9Mf0hBvNE3PV/1UeXR8jdsVwLnHrOQUDbDX5IrtHEd+43dPBdN/V5W3SLiqy
 nuj2HABrgqxMCGtbh8IQGMHQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 402aac842757386e;
	Mon, 21 Sep 2026 03:19:13 +0000
X-Mizu-Trace-ID: 402aac842757386e
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tgraf@suug.ch,
	pshelar@nicira.com,
	linux-kernel@vger.kernel.org,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v2] ip_gre: Reject enabling collect metadata through changelink
Date: Mon, 21 Sep 2026 11:18:59 +0800
Message-ID: <20260921031859.9283-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

ipgre_netlink_parms() can enable collect_md on an existing GRE, GRETAP
or ERSPAN device. Unlike newlink, changelink does not enforce metadata
tunnel uniqueness. Converting a non-metadata device can therefore
replace the metadata receive entry for another device of the same type
in the same netns. Deleting either device then clears the shared entry,
breaking metadata receive lookup for the surviving device.

If parameter validation fails after collect_md is set, deleting the
modified device can also clear an entry it never owned.

Reject enabling metadata mode in both changelink callbacks before any
encapsulation or tunnel parameters are modified. Allow requests that
repeat the metadata attribute on an existing metadata device.

Fixes: 2e15ea390e6f ("ip_gre: Add support to collect tunnel metadata.")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
Changes:
v2:
  - Add an extack message when rejecting collect_md enablement in both
    changelink callbacks. (Ido Schimmel.)
  - Rebase onto the latest net/main.

v1: https://lore.kernel.org/all/20260917095016.71937-1-xuanqiang.luo@linux.dev/

The state change on failure can be reproduced without an existing
metadata tunnel (output abbreviated):

  # ip link add g1 type gre local 192.0.2.1 remote 192.0.2.2
  # ip -d link show g1
      link/gre 192.0.2.1 peer 192.0.2.2 ...
      gre remote 192.0.2.2 local 192.0.2.1 ...

  # ip link set g1 type gre external
  RTNETLINK answers: Invalid argument

  # ip -d link show g1
      link/none c0:00:02:01 peer c0:00:02:02 ...
      gre external remote 192.0.2.2 local 192.0.2.1 ...

  # ip link del g1

The request fails, but collect_md and the device type have already
changed.

If another metadata tunnel exists, deleting this device can clear its
collect_md_tun entry. A successful conversion can overwrite that entry.

 net/ipv4/ip_gre.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 82309efd417e0..e4878e9aa6367 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1464,6 +1464,12 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
 
+	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md) {
+		NL_SET_ERR_MSG(extack,
+			       "Enabling collect_md on an existing device is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
@@ -1496,6 +1502,12 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
 
+	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md) {
+		NL_SET_ERR_MSG(extack,
+			       "Enabling collect_md on an existing device is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;

base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.43.0


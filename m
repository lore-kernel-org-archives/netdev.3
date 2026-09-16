Received: from mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5736A004
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524947; cv=none; b=Il7uksMqiHwByp/t6kdVv4Tyd49gYEReaOfq1FKesIHvZ3aK7tinI59Dzo2up92yY9s+bABn1qCPjUs2MA50VkoLtN13twMZndxSFDBiiA0sso6mOx8FTSc6YlmstAhLHbv7QnEEyIDx+Uxil4+1bkDWbRWSCsahgF/lwE/2LD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524947; c=relaxed/simple;
	bh=AoqB6iH1VbyFxRickE+XE02detVh4zbD+pkrOIM8KZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CbMaJXa5fZFEK3VYZEsjYfHv/jme0NJDQ+V9CGnKf+RwlBO3nQFZCCEWijxmhaeqxvhivqljuB3rYHfI8uWuq9e9q2HggXSn/k2NXdpCY2glH64m5oiEvSNvko7EkzCTX5zLYXkopJ0RRVYDosUnJkHmDFxy+nNYtHfIPsI1aQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T8h1pEnd; arc=none smtp.client-ip=91.218.175.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T8h1pEnd"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AoqB6iH1VbyFxRickE+XE02detVh4zbD+pkrOIM8KZ8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789524935; v=1; x=1790129735;
 b=T8h1pEnde7mod1YXIydIdyabJN1Zi6ZBCi9O3sG9ncl2Dx0xEfePE3//8dWV3bArpJb/Mae6
 4HYzg8bwmpwRQ47u9xFzFdwjHSbJoJE341RVwpoGmCSvnCjaKlfjaenn+LTQefMDhYq1Kzzpj4/
 oWgNlpcHyMxLt/cPjmzMDFNk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 04c3db0f84c267eb;
	Wed, 16 Sep 2026 02:15:14 +0000
X-Mizu-Trace-ID: 04c3db0f84c267eb
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: [PATCH net] net: phy: allow phy_detach() before netdev registration
Date: Wed, 16 Sep 2026 10:15:05 +0800
Message-Id: <20260916021505.238990-1-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

phylink_connect_phy() may be called from probe without RTNL while the
net_device is still NETREG_UNINITIALIZED. If PHY bring-up fails,
phy_detach() uses rtnl_dereference(dev->hwprov) and lockdep reports
suspicious RCU usage.

hwprov cannot have been assigned before register_netdevice(). Relax the
RCU check for that state only; registered devices still require RTNL.

Fixes: 35f7cad1743e ("net: Add the possibility to support a selected hwtstamp in netdevice")
Reported-by: syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=694b49f41098a5df4fd7

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..acd8d658a29e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1941,7 +1941,9 @@ void phy_detach(struct phy_device *phydev)
 		/* hwprov may technically be protected by ops lock but
 		 * not for devices with a phydev, see phy_link_topo_add_phy()
 		 */
-		hwprov = rtnl_dereference(dev->hwprov);
+		hwprov = rcu_dereference_protected(dev->hwprov,
+						   lockdep_rtnl_is_held() ||
+						   dev->reg_state == NETREG_UNINITIALIZED);
 		/* Disable timestamp if it is the one selected */
 		if (hwprov && hwprov->phydev == phydev) {
 			rcu_assign_pointer(dev->hwprov, NULL);
-- 
2.25.1


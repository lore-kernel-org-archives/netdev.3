Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146C26F2B0;
	Wed, 22 Jul 2026 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679176; cv=none; b=sFispmvXefEobj1KkMRGvvRHyzlIhYVBzvifUcrd1XeHiLu9pOAnYgPYPhyLanFkbtoSctCPgyfZ+7CDyV+7aZzqp+9OJFXLJ+3fApoJTPJD5YD8Op0Uza+G91nkvtPw2WOoK4vIuvOafLwvWoH2Sb35MwAzENhu6dqQkRcWR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679176; c=relaxed/simple;
	bh=AG4YclKNZKvYsuVX2TCLn+goBzu2jaGy2e9X1W59INY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sHp7brDw2pG9LWSKodO0OfInaH5KLsqg3IDsX0010emQtkS02MiRGCxqP75glIc18q0n0CGCpm5rzDc82ApUeaswrTkl5xpnMIVrNDlyL4dwPj4clRN4wRVdUIROYgKOmiG7FnjvE4k5S8rFZVISCvxTRY0aCu4IZ+uYC1S8Ubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wmKZu-000000000hB-2DGM;
	Wed, 22 Jul 2026 00:12:50 +0000
Date: Wed, 22 Jul 2026 01:12:47 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: unsync host addresses when destroying
 user port
Message-ID: <34a027de7d860796d37de2f2108337eb82110144.1784679091.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a user port is destroyed while addresses are still synced to it,
e.g. multicast addresses synced by a bridge the port is a member of,
the host FDB/MDB entries these addresses installed on the CPU port are
never removed: the only removal path is dsa_user_unsync_uc()/_mc() via
ndo_set_rx_mode, and __dev_set_rx_mode() does not call the ndo on a
device which is down. By the time the bridge unsyncs its addresses in
del_nbp() during unregistration, the netdev has already been closed,
so the unsync never reaches DSA and the entries linger until
dsa_switch_release_ports() reports them:

  Cleaning up multicast address 33:33:00:00:00:01 vid 0 from port 9

This happens on every unbind of a DSA driver supporting host address
filtering while its ports are up.

Unsync the host addresses in dsa_user_destroy() before unregistering
the netdev, at a point where the driver can still process the
deletion, just like dsa_user_change_conduit() already does when
migrating host addresses to a new conduit.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 net/dsa/user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 03c7af6abe18..a7dabb645036 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2885,6 +2885,7 @@ void dsa_user_destroy(struct net_device *user_dev)
 
 	netif_carrier_off(user_dev);
 	rtnl_lock();
+	dsa_user_unsync_ha(user_dev);
 	netdev_upper_dev_unlink(conduit, user_dev);
 	unregister_netdevice(user_dev);
 	phylink_disconnect_phy(dp->pl);
-- 
2.55.0

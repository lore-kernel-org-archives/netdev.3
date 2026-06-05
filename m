Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78526E173
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619388; cv=none; b=O0XPYltp2lidVdCI4/leoYYlM6IAz1hgezg5apvmpnhcXivbeXD/ZovtipgzDuls0jJnEPvIpyk/3S+UqbC9SxaLgM6ewmlUrqQNDIacSl3cfAQBHMjERmVXFCWuucDgqilUBBCDD3prB0BU8IXhVhoo0Z2yiMiD5jwRZMh3mCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619388; c=relaxed/simple;
	bh=Cf/N1zvK1k2FuBPK7Fvx3R7iJEvHK3g/9gb41dDNYx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8RtZlgChOG6Fodai95RtltWAavr9oaa4pPd2QBy1dnTdeo7S9UrZGgCIah7V9QkTDmIkuFtMHNASm2/jhz5SyYFQYQtrOv7h+fN6aiBxk7y5kJ1bGO5cAmIYe9IIQmNQK0GySJ/svvAXJAb/2cOKP9R/dKuHoe112r+35rIlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7QJCkH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7QJCkH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5D91F00898;
	Fri,  5 Jun 2026 00:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619387;
	bh=XEqiLDpRGahY0GJ6J32/FBRA+G8TZe2KzBFHo1LnWQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d7QJCkH8rQAm7MDVrs+IXDS7lq4WLkH1jNoLjgJIu6makXHbFvFdDwC1PdFxyPAfE
	 VfcAQ84N8R/UNDC0HTccoAieg/AGtctyBpznlXO6Qi8uZERZgQTgEFEOZaruN85p1r
	 fsS2tbpRIrv5LMiAuYjPaaXnnqyIbfmNYRoFBdRXoffqvLAWL9ekRKbJupQY+TewDf
	 6ldNb8AY/1123AhxM+nqcaVunh2pmvRiruNIvyz5CHbtQMRJ9kVlL4zbIIR8/MzeAn
	 73QafUuOgNRlRE9Bf4Rn8McufVxrmowRH/Nddy2DYtTvqnaig7InXe6BK0OX8Q2pYS
	 SrXMfy+QY6U6w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	alexanderduyck@fb.com,
	willemb@google.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	sdf.kernel@gmail.com,
	jakub@cloudflare.com,
	nb@tipi-net.de,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 12/12] docs: net: ethtool: document ops-locked drivers and op_needs_rtnl
Date: Thu,  4 Jun 2026 17:29:12 -0700
Message-ID: <20260605002912.3456868-13-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Catch up various bits of documentation after the locking changes.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdev-features.rst |  7 +++++++
 Documentation/networking/netdevices.rst      | 17 ++++++++++-------
 include/linux/ethtool.h                      | 10 ++++++++--
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index 6293d47e5b09..f9e1f3921f53 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -76,6 +76,13 @@ netdev instance lock, that lock must be held as well. This should not be
 done from ndo_*_features callbacks. netdev->features should not be modified
 by driver except by means of ndo_fix_features callback.
 
+For "ops locked" drivers (see Documentation/networking/netdevices.rst),
+ethtool callbacks that may end up invoking netdev_update_features() must
+opt back into rtnl_lock by setting the matching ETHTOOL_OP_NEEDS_RTNL_*
+bit in ``ethtool_ops::op_needs_rtnl``. The ethtool core then keeps
+rtnl_lock held across those SET callbacks so the contract above still
+holds.
+
 ndo_features_check is called for each skb before that skb is passed to
 ndo_start_xmit. Driver may perform any non-trivial checks (e.g. exact
 header geometry / length) and withdraw features like HW_CSUM or TSO,
diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 8fc96975b3bd..fde601acd1d2 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -351,10 +351,6 @@ virtual and the physical device. To prevent deadlocks, the virtual device's
 lock must always be acquired before the physical device's (see
 ``netdev_nl_queue_create_doit``).
 
-In the future, there will be an option for individual
-drivers to opt out of using ``rtnl_lock`` and instead perform their control
-operations directly under the netdev instance lock.
-
 Device drivers are encouraged to rely on the instance lock where possible.
 
 For the (mostly software) drivers that need to interact with the core stack,
@@ -375,9 +371,16 @@ the instance lock.
 struct ethtool_ops
 ------------------
 
-Similarly to ``ndos`` the instance lock is only held for select drivers.
-For "ops locked" drivers all ethtool ops without exceptions should
-be called under the instance lock.
+For non-"ops locked" drivers ethtool_ops are executed under ``rtnl_lock``.
+
+For "ops locked" drivers, ``ethtool_ops``, unlike ``ndos``, run under
+the instance lock **only**. Drivers may request that ``rtnl_lock``
+is held around specific operations (both SET and GET) by setting
+appropriate bits in ``ethtool_ops::op_needs_rtnl`` (if the necessary
+``ETHTOOL_OP_NEEDS_RTNL_*`` bit doesn't exist, just add it).
+Commonly used core helpers which force drivers to selectively opt-in to
+``rtnl_lock`` protection include ``netdev_update_features()``,
+``netif_set_real_num_tx_queues()``, and phylink helpers.
 
 struct netdev_stat_ops
 ----------------------
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index da29017c757f..1b834e2a522e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1177,8 +1177,14 @@ struct kernel_ethtool_ts_info {
  * @get_mm_stats: Query the 802.3 MAC Merge layer statistics.
  *
  * All operations are optional (i.e. the function pointer may be set
- * to %NULL) and callers must take this into account.  Callers must
- * hold the RTNL lock or netdev instance lock (see @op_needs_rtnl).
+ * to %NULL) and callers must take this into account.
+ *
+ * For traditional drivers callers hold ``rtnl_lock`` across the call.
+ * For "ops locked" drivers (see Documentation/networking/netdevices.rst)
+ * callers instead hold the netdev instance lock (``netdev_lock_ops``);
+ * ``rtnl_lock`` is additionally held only for callbacks for which
+ * the driver opts in via the matching ``ETHTOOL_OP_NEEDS_RTNL_*`` bit
+ * in @op_needs_rtnl.
  *
  * See the structures used by these operations for further documentation.
  * Note that for all operations using a structure ending with a zero-
-- 
2.54.0


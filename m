Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF641F36F;
	Thu,  8 Oct 2026 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464728; cv=none; b=J9b8K2QgqSo5fdVw/RES9QwKOo8L7e4YzdU8rJEOsb4gcn8hdQNvwK0NLLpwFP5RZsgLRDqbRz+o/9ewRBJXzbps7nfsAI2TmS85rkFnSd1jeln+cpMOXG4M8dE9XnkejfQ5XIX5Tn2OidHmn4WY6fSFvXlbowEza9vFBfWWYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464728; c=relaxed/simple;
	bh=ZEoDTOObvnBCavRJv3gTO8TVHfDmiKVq0/1pDwH9Yng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdogE3yAW4so5oCJNhT+02nuEW3cBZJpwtcQInElWFU3pPgLnfWAUnos/mBAR2cRjdY8sTBPVtHmFII/DjT7iWLAWaEhYnuqA0D/8UNftI8GEajjH6HwNnU3Ohlax60svg1PRtajRfQXdOu6yQkFqU76fEQkSWMpDeklqTyhCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=I3NNF9k+; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="I3NNF9k+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sv
	9Nz32IunShNXMIlQPyrxK/eryKBOVBKQ/L3Je5vIg=; b=I3NNF9k+TpXz/MgOh6
	mZi8gBTJ1nwX+dtWMAiwb1vczdKrCfAVx+CeWMpiZD4BUNJt6R6JRp+QmVsvaQzE
	gKCFtNfqVbMtE6RrGa8EspgL96d0AZ/5fnBMiHdasPYSCsjeDNt+fzCfi2fTXx/H
	t8uvcoVa0uu03P6TUp8y1x0VA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8NWk8dqh6CpBA--.7046S2;
	Thu, 08 Oct 2026 20:57:58 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH iwl-net v3 0/3] ice: fix VF representor lock ordering and teardown error paths
Date: Thu,  8 Oct 2026 20:57:51 +0800
Message-Id: <20261008125754.3520773-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3v8NWk8dqh6CpBA--.7046S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFy7Cr17Gw1xKr45Zr4kCrg_yoW5uFW8pr
	ZYqw1rKr4kXFyIg3y3Zw18t3WF9a1rKFyUGr1jgrW5C3Z8Gry8Xr47K3y2934jyws3Aa4a
	vrs0qrykuFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRaGXWrHk1ZkYAAA3I

From: Linkui Xiao <xiaolinkui@kylinos.cn>

Patch 1 moves the ice_eswitch_detach_vf() and ice_eswitch_attach_vf()
calls in ice_free_vfs() and ice_reset_all_vfs() out of vf->cfg_lock.
Both take the devlink instance lock and RTNL through the representor
netdev, while ndo_set_vf_mac(), ndo_set_vf_vlan() and the representor's
ethtool reset take vf->cfg_lock with RTNL already held, so cfg_lock ->
RTNL against RTNL -> cfg_lock is an inversion; that is the AB-BA
Sashiko reported. The detach is preceded by a single cfg_lock
acquisition, which waits out a reset that is already inside the lock:
ICE_VF_DIS, raised before both loops, keeps later ones out but not one
that got in ahead of it, and that one can reach
ice_eswitch_update_repr() on a representor that is being freed with
free_netdev() + kfree(), with no RCU grace period in between.

Patch 2 does the same for the teardown loop in ice_start_vfs(), which
in addition never detaches the representors it attached before the
failure. That path does not set ICE_VF_DIS and the VFs it unwinds
already reached ICE_VF_STATE_INIT, so vf->cfg_lock is still needed
around ice_dis_vf_mappings() and ice_vf_vsi_release(): the
ice_check_vf_ready_for_cfg() test runs before the lock is taken and
cannot keep out "ip link set dev <pf> vf N ...". The patch marks the
VF disabled under cfg_lock before the detach, which also waits out an
ice_reset_vf() that is already inside the lock.

Patch 3 gives back the MSI-X window that ice_init_vf_vsi_res()
reserves and that none of its error paths releases.

Representors are created and destroyed only under pf->vfs.table_lock,
so the detach does not need vf->cfg_lock to stay safe against other PF
operations, and all three functions are called with that lock held.

The three issues were found by manual code inspection; none of them
was triggered at runtime, and the series is compile tested only, with
no hardware test.

Changes in v3:
- New patch 1: move the detach/attach calls in ice_free_vfs() and
  ice_reset_all_vfs() out of vf->cfg_lock, and take cfg_lock once before
  the detach so that a reset which is already inside it is waited out.
  (Przemek Kitszel)
- Patch 2: detach the representor outside vf->cfg_lock, and mark the VF
  disabled under cfg_lock before the detach.
  (Przemek Kitszel, Sashiko AI review)
- Patch 3: correct the Fixes: tag to 4d38cb44bd32, which replaced the
  computed first vector index with a reservation from the bitmap and left
  the error paths below it unchanged; commit a203163274a4 ("ice: simplify
  VF MSI-X managing") only renamed that helper.
- Add the information netdev-bot asked for to the commit messages.
- Drop the Reviewed-by tags from Tomasz Lichwala and Aleksandr Loktionov:
  patch 2 changed code again, and the hunk in patch 3's teardown loop
  moved inside vf->cfg_lock.

---
Link: https://lore.kernel.org/netdev/20260928065306.1514795-1-xiaolinkui@126.com/

Linkui Xiao (3):
  ice: attach and detach VF representors outside of vf->cfg_lock
  ice: detach the VF representor when ice_start_vfs() fails
  ice: free the VF MSI-X vectors when VF start fails

 drivers/net/ethernet/intel/ice/ice_sriov.c  | 42 ++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 16 +++++++-
 2 files changed, 54 insertions(+), 4 deletions(-)

-- 
2.25.1


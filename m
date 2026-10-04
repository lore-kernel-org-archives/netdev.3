Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1514478859
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791143052; cv=none; b=jRxkxmMTmwyV2PS6QE1PjcbYc8EPuGL9ffJw/fui5GopmKQ5McMfcsUXmAoV2D7GJqWwSTAIBDTexM7f9UcSWWmMw5FP9nIYmC7m7D6kbDeB/THqbmXsvNjQAC5g9PGwW4MLcP3VW88w1hUpmg9Xzz9fKEVrJoeJe9KkBddWTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791143052; c=relaxed/simple;
	bh=iIPofZjFH7femE9TkRfD3qKtbPAF+kCEnfJpJIGiC/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7cf+WaUHnw3jLG8Nkowt55DNHsnc2otSG/kdps+yvpcLorSqoktOMyengXW7aMZkLVnAJ6EkWNQgKs7CzYrGWxT2sx4JdUNtlvJ2POzjNaYaA86/Ix1ufhX+AGs0muaaAUUPGF5d9ToMnXKHBhq8phugEFyxPrPQo9wNlFe/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 807BB47980;
	Sun, 04 Oct 2026 21:44:01 +0200 (CEST)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Don Skidmore <donald.c.skidmore@intel.com>,
	Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Viacheslav Tyryshkin <s@tyryshkin.me>,
	Melissa Romanus <melissa.romanus@proton.me>
Subject: [PATCH iwl-net 0/2] ixgbe: fix MDD handling without VFs
Date: Sun,  4 Oct 2026 21:36:58 +0200
Message-ID: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791143040488

Since v6.17, X550 adapters without VFs can crash the host on an MDD
event, as reported by Melissa on netdev [0], by Viacheslav on
intel-wired-lan [1], and by Proxmox VE users [2].

Patch 1 fixes the NULL pointer dereference, and the out-of-bounds
vfinfo write for events on PF pools with SR-IOV enabled too. Patch 2
stops enabling MDD without VFs, which is how such setups get MDD events
at all. Why the hardware flags PF queues is still unclear to me, all
reports show tx:80000.

For completness sake, on E610, the tx hang path in
ixgbe_handle_mdd_event() looks like it can still reach vfinfo for pools
without a VF if VT mode is enabled without VFs, e.g. with macvlan
offload, that's not fixed here.

Tested on a Supermicro H11DSi-NT with its onboard X550: without this
series RDRXCTL.MDP_EN is set whenever the link is up, also without VFs
or after removing them again. With it, MDD is only enabled while VFs
exist.
Patch 1 is not tested in-depth yet though, as I have no reproducer for
the MDD events themselves, so any testing by the reporters would be more
than welcome.

[0] https://lore.kernel.org/netdev/bqzPMb-F5iRWe7S2DWkQDhsK8u9ZoIaK34sF2pHpAjP6WHFb70Weq3pc8ZIVUoIx2EbPHd6HLBzz1HHd3xb5rxRZ9F3w1L6TQAd87S18CPQ=@proton.me/
[1] https://lore.kernel.org/all/abc23ed3-f194-4546-bf99-7152464b93e2@intel.com/
[2] https://bugzilla.proxmox.com/show_bug.cgi?id=7874

Thomas Lamprecht (2):
  ixgbe: fix NULL pointer dereference on MDD event without VFs
  ixgbe: do not enable MDD without VFs

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)


base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
-- 
2.47.3



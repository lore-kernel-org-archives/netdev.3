Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63D2D249B
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776502902; cv=none; b=EBF9drdF9QY49LsHlCjoihzA4S9htoMshHTdrZvntXp5Q9hwO3rYrdmG0otXaiD3DtwoxgAI7msV8Qx7E9CN9r7XTcE4y6NlCHR7HNO0LmG/z3BA6vcbCkj0wj4XB4nPzpJFJs53fo95mw4WMck4hYxF0aXg0QBFD0Kd38qpVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776502902; c=relaxed/simple;
	bh=pu7cTTjPbEXNMgTY8jSZFsbq7LTBRGLvdh/UyI10zoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4FEt8H3Wwv9KfSMJydLZ+1FPmH88z3MiG8ZBpSjuLXlp0xXk0Jm99EarQ/xC0g1ruJub1CYxE5A1jqdcy32AaZkmqqlDRS5Nzi+/hbmIzCxKKClC5P0FsaVOaX5S2YrsLnr7FZCBiV2xo3rNEL/vIUy7chRpRSulq1lu3KeLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=L7wYo3hp; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="L7wYo3hp"
Received: from ms-a2 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63I91csh034081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 18 Apr 2026 18:01:38 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=SxGyo39sLn37ykZ1MyDgzsUgeOOQcYMpbjUuw3Tt9ms=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776502899; v=1;
        b=L7wYo3hpYw9vXC27in1/pj4EJZikMcyWN269KKsoZ7r8ATphDcfbC5d2uUdKDsFN
         NYlbM5ZqBAFotMmCCODVwhYGiRKQ0K8kbKSXOZsK2eJtXkMJLnH0vKw+alVIaaZ0
         nYnOdEhQeCPqbrgBV/33Yt2A+lRDrWfCzVZ6KCGMYTaUyeuljWgvNJ2H9amHMhi4
         00rBms2IksdBHuUK7dIbPvXEsFZJUa6s7r+rlwNW4SGE/ch7Df+iopMJVzJ+P7Pj
         kWSDhKEvIzhyJu/AQ7DlUmfhWRQ78IT1VTLD3VX8KOCAYzEK2oZ/0Q13qDJTMwtC
         nJPf5xqN37c+1EsE4bfH0g==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-net v1] ice: fix UAF/NULL deref when VSI rebuild and XDP attach race
Date: Sat, 18 Apr 2026 09:01:15 +0000
Message-ID: <20260418090137.411506-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_xdp_setup_prog() unconditionally hot-swaps xdp_prog when
ICE_VSI_REBUILD_PENDING is set. In the attach path, this can publish a
new rx_ring->xdp_prog before rx_ring->xdp_ring becomes valid while the
rebuild is pending. As a result, ice_clean_rx_irq() may dereference
rx_ring->xdp_ring too early.

With high-volume RX packets, running these commands in parallel
triggered a KASAN splat [1].
 # ethtool --reset $DEV irq dma filter offload
 # ip link set dev $DEV xdp {obj $OBJ sec xdp,off}

Fix this by rejecting XDP attach while rebuild is pending.
Keep XDP detach allowed in this window. Detach clears rx_ring->xdp_prog,
so the RX path will not attempt to access rx_ring->xdp_ring.

[1]
BUG: KASAN: slab-use-after-free in ice_napi_poll+0x3921/0x41a0
Read of size 2 at addr ffff88812475b880 by task ksoftirqd/1/23
[...]
Call Trace:
 <TASK>
 ice_napi_poll+0x3921/0x41a0
 __napi_poll+0x98/0x520
 net_rx_action+0x8f2/0xfa0
 handle_softirqs+0x1cb/0x7f0
[...]
 </TASK>

Allocated by task 7246:
 ice_prepare_xdp_rings+0x3de/0x12d0
 ice_xdp+0x61c/0xef0
 dev_xdp_install+0x3c4/0x840
 dev_xdp_attach+0x50a/0x10a0
 dev_change_xdp_fd+0x175/0x210
[...]

Freed by task 7251:
 __rcu_free_sheaf_prepare+0x5f/0x230
 rcu_free_sheaf+0x1a/0xf0
 rcu_core+0x567/0x1d80
 handle_softirqs+0x1cb/0x7f0

Fixes: 2504b8405768 ("ice: protect XDP configuration with a mutex")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d1f628f1c8ac..4681cbe193f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2912,12 +2912,21 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 	}
 
 	/* hot swap progs and avoid toggling link */
-	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
-	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
+	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
 		ice_vsi_assign_bpf_prog(vsi, prog);
 		return 0;
 	}
 
+	if (test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
+		if (prog) {
+			NL_SET_ERR_MSG_MOD(extack, "VSI rebuild is pending");
+			return -EAGAIN;
+		}
+
+		ice_vsi_assign_bpf_prog(vsi, NULL);
+		return 0;
+	}
+
 	if_running = netif_running(vsi->netdev) &&
 		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
 
-- 
2.51.0


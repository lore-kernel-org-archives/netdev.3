Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793508531;
	b=UsqyNiN+sECozgKTqDVFeUNyfyrIjwqTaeBbVNrU9c80MPladXaRQhAIsti8GU7XOJ8Y
	 NbqJMj3hoSc+dUmdPBfbxC0dyIXNvI4V3IP3WLOvdxPQpeZ2jZtoVkIqYiatLT8fKHsrQ
	 cjJfFIh/7VKlxGKUOhZraI0z2uvcv9ky2ps1k1bXHw5QA/fSreUuhvedVCEBirDPv6lg9
	 qAfKTq6UQ9u15ZHEJu8i+xcVcxdlougx4NWvqgfXmQB4/G/VHKqkSqs2zE4D6J5vFyTgR
	 LBDAMl04yZ16W0VxOX/WaefLB1k0tZAP+/22PUI6925uuDfbyC288sqQ11KB6HH2u/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793508531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QNvU5RCwGD7yT7rtU7WNdTuMkbHAjYhh78R8TjXDdfE=;
	b=pTOWrJ/pSeBwXiS1Yi76VVE2KgerHBXiIxAnGMRH472rqN2fE7c+7eCqe+9LzllweR1p
	 fQyClHQWXcR7L3j8zXK0+zIgtFq+QdKU/o/LR5DRQuUSXcnLgr+GJULtj2J5QFDRGEulv
	 OR1qw7FVNZ0D5PvJqRZ+9mamOuhJtLJHyd5WtGuj8WAqWmOJ36VZmvlcRx2gyzZ4E7HoT
	 4VgkQb+3t2nibkfhOtpO+JRBh5HPVyrlnDOKW2RcDA5obHtWIC2Z/7QYRSH9Fe4sk+kz8
	 3nH09zpYcxdeszapRyCu/9i/CarMVPyiLH/D2+quHCmHLSuCcjyqf3F+2OaG17h0Rtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=njDPbXHA;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D6606A326
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 04:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC0D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=njDPbXHA
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1775834c88.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 21:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793508530; x=1794113330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QNvU5RCwGD7yT7rtU7WNdTuMkbHAjYhh78R8TjXDdfE=;
        b=njDPbXHA3IIgBaijCrw0N/AruVQPCFx49GkwZCqU4Ktagua9qJ7nZBGqPRHsDlYZDF
         YBD8qgVBVNsVEqRPUVuLPSPrAgwsj4hRw5t/hty2nybqa5RbdhqKzyic7ztmpx7jxotB
         QFKLZ44oAZFGIpLAWgUsskpOvAQsEyaxPZXDtapNc/IPelK7qcUuSc/diMRKwU5OoGW1
         JbqY22Lh4pXIUtfE2PqgHN8is1dG7kTL6wSrL/vi6ArqT9Ut+EAJuaJxodc5gvaGOy6j
         rYE0f5K3s/0Vlin37QOFUI6QL1Oafjkt9qMmjXXotg1/99tdN5zakzh2tfcKgK8TK+gJ
         WpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793508530; x=1794113330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QNvU5RCwGD7yT7rtU7WNdTuMkbHAjYhh78R8TjXDdfE=;
        b=16BAykFf2jmii66OUegMT56LN7uIsZyn6YyNQcQLaoTbIXsOwBEWE9GdpzkPBM1fn6
         f9kVPrkwb55oKXbI8mTrPhplcemxVRrvdPlztasfhrmNYldJR20NXT3W7PDs9xWdxhCR
         kobxdrYWzIEP4CuW6U22vdG46K0YcelUdHvO5fZK44QzCG892QuQ27kuDZAqj7+75E3S
         30gXHgFxQ0Tnl8TPapFHZD3mNVpOxH39MccLfN4PFH6KC8dTooxCE80Y5aNRRrGTkmPp
         OtTRsad02OU+3cwc4DoOxg4PLuVESw8VyHMoUZ1qLN7IxNxDjwijjc6F/xeyhZtDXO0S
         20kw==
X-Forwarded-Encrypted: i=1; AKwUvByDRbD5OOPRtL5dqL0NbNcda4295RIqvGkz7wiw6XzrTPHDsfJFD/aq0WyiRo65iuS7W5Ybmi0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnRdJY4EmkGTW6RyVYVW1KmRUT8DVBmnhKlid1QEBreugQ/t8t
	Vf2CMCg5jUzZrzCTvDzUO74eja1gXIDV6OfXJMrTQF5AL/Lit+Zy+zQK
X-Gm-Gg: AYBFou28vx3VnIB+YY7eMfClnZ6td/pBVy2gAReC/eUQ2Hbw5frYj8Aqw18ZeiEiTrh
	02wOnvgXKMCpyDc79ukmeEq/lLnBBu2svcVvfakrvCwol+0ojz6EY0u1buPxfTUWAmWkSFdrLW6
	NqbvegsJjoJqy/xKJIkwA8yhPBJytjLtU8ULwDAZHjW+ZM4NpqX4I0dMwiuaFfRh+EGWfllG44h
	n+YF0jxmVLtSZry3cwQpw0cXhaqUvZpwDvDKBp6wUIhjATYrFEffVCOj5NYCxLljmM8dDQmQH67
	OPXTT/3rw28r608fBSmgtKN5vIjSwFntFSvAT0QzWUOoALRh0R7bc671AXrlpSDcxktWz0pPJJt
	iptbBOdup3/5V85qVrhENLaX0/YrYMRpmtLZmkcuf7rHQTOD0g5IAA5I9CMQFIdUJpVzNtIR/rh
	vAwCKIjqQ9Lc2g0HicOe2OZUH5FGoTaBSd83vP0HkXSEKt3kzsqKGKryURtVRijriF/9gZd7Y1i
	vJskMoLei9Rt1QpSVMZFThVHYTpF/LP0kCNCGOVrq3rO2siiP3mjC9QGLaWtzb/uZTbyR1uM9S9
	8dRjSYdtq07kMy/Bs+DUah3sp6c0jEwGP399XpIXxzgV93LkZweN/8df3xey5zMIUWxXNBOp0qQ
	4DkxSrekUKeMR
X-Received: by 2002:a05:7022:eb50:10b0:14d:baf5:c415 with SMTP id a92af1059eb24-1ac5a0b4324mr10594227c88.7.1793508528871;
        Sat, 31 Oct 2026 21:48:48 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm20843929c88.14.2026.10.31.21.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 21:48:48 -0700 (PDT)
From: xiaoblac <teel4res@gmail.com>
X-Google-Original-From: xiaoblac <1020691186@qq.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cheng Yongkang <teel4res@gmail.com>
Subject: [PATCH net v3] net: bridge: disable MRP ports before the FDB flush in del_nbp()
Date: Sat, 31 Oct 2026 21:48:40 -0700
Message-Id: <20261101044840.1595584-1-1020691186@qq.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Yongkang <teel4res@gmail.com>

del_nbp() flushes the port's FDB entries before it unregisters the RX
handler. For a normal port, br_stp_disable_port() moves the port to
BR_STATE_DISABLED before this cleanup.

That does not hold for an MRP ring port. br_set_state() ignores state
changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
the port state alone. br_mrp_port_del() then restores forwarding when
the bridge is up before clearing the bit. A frame received between
br_fdb_cleanup_by_dst() and netdev_rx_handler_unregister() can therefore
create a new FDB entry referencing the dying port. Nothing removes that
entry before destroy_nbp_rcu() frees the port, so a later frame to the
learned MAC can be forwarded through the freed port.

Remove the MRP and CFM instances before disabling the port, so that
br_stp_disable_port() actually transitions it to BR_STATE_DISABLED.
With CONFIG_BRIDGE_VLAN_FILTERING=y, synchronize_net() in
nbp_vlan_group_unpublish() also drains receive paths that could still
learn with the old state before the final FDB cleanup.

Found through an LLM-assisted source code analysis workflow and
reproduced on net with KASAN and CONFIG_BRIDGE_VLAN_FILTERING=y in QEMU.
A diagnostic switchdev module accepts MRP objects and delays the
NETDEV_CHANGEUPPER callback for 1.5 s, holding del_nbp() after the FDB
cleanup and before RX handler removal. The reproducer floods the MRP
port with rotating source MACs, waits for the port's RCU callback
through the module's rcu_barrier(), then sends frames to those MACs
from another port. The unpatched kernel reports:

  BUG: KASAN: slab-use-after-free in br_forward+0xb1/0x820
  Call Trace:
   <IRQ>
   br_forward+0xb1/0x820
   br_handle_frame_finish+0x148b/0x1e50
   br_handle_frame+0x90a/0x15c0

With this patch, three runs of six cycles each reach the delay without
a KASAN report.

Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/
Closes: https://lore.kernel.org/netdev/20261022090431.3641707-1-teel4res@gmail.com/
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
Tested on net cb284914e749 (clang 20, KASAN), with and without this
patch:
- the reproducer above: the unpatched kernel hits the UAF on the first
  cycle; the patched kernel completes all cycles without KASAN, WARN
  or BUG, and a ping / FDB learning / port detach / bridge delete check
  passes
- selftests/net: vlan_bridge_binding.sh, bridge_vlan_dump.sh,
  test_bridge_backup_port.sh and forwarding/bridge_vlan_unaware.sh,
  bridge_vlan_aware.sh, bridge_fdb_learning_limit.sh,
  bridge_sticky_fdb.sh, bridge_port_isolation.sh, bridge_locked_port.sh
  pass on both kernels; bridge_stp_mode.sh skips on both (iproute2
  without stp_mode support)
- W=1 build of net/bridge/ with allmodconfig: no warnings

v3:
- Re-test on current net (Ido).
- Update the FDB cleanup and VLAN group unpublish names for current net.
- Describe the FDB's reference to the port without the old dst == p
  expression.
- Remove the deprecated Assisted-by trailer and describe discovery and
  diagnostic instrumentation in plain text.
- Add the original report/reproducer link and links to v1 and v2.
- State the VLAN support prerequisite for the receive-path drain.

v2: https://lore.kernel.org/netdev/179333317814.2102764.8780283783548366593@gmail.com/
- Use Ido's MRP/CFM reorder instead of adding a second FDB flush.
- Validate the reorder with the v7.3 reproducer and custom regressions.

v1: https://lore.kernel.org/netdev/179268538303.70821.8213834342995341232@gmail.com/

 net/bridge/br_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 2c05ebc1299d..fb25ce3e5e64 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -341,13 +341,13 @@ static void del_nbp(struct net_bridge_port *p)
 
 	nbp_delete_promisc(p);
 
+	br_mrp_port_del(br, p);
+	br_cfm_port_del(br, p);
+
 	spin_lock_bh(&br->lock);
 	br_stp_disable_port(p);
 	spin_unlock_bh(&br->lock);
 
-	br_mrp_port_del(br, p);
-	br_cfm_port_del(br, p);
-
 	br_ifinfo_notify(RTM_DELLINK, NULL, p);
 
 	list_del_rcu(&p->list);

base-commit: cb284914e749388eef402938bdb3115fe1f6d337

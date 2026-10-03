Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330D15AADA
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790999422; cv=none; b=At7+MKNi3rMWS/H47n89B/h8/ItpQqYMk5BUq6uZtLQJPfNiWMz5jxkcTDalxmDyODpN1vp31+T5QJOd1rT8RCIMH73Dwpy+Usi3Hs4eHw3oFDGD1H4hRpqhLTTPoKwLDMgBtLWqCqThlXUnfS+WQ6i9cM5kklaYo7SI2VuH2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790999422; c=relaxed/simple;
	bh=lODAk/IUedJyfB07YrX7ahLPdEi6D5a1fF5vmhyUlus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPiFy+w6MaaNzPqVkoZ3OUIbIUUqOsChVfdFsN913KTwNkKDJfj/dCv2uuhAzaovcYG7jHQ37ujLXkNWFhUORxDBsh93PIxalRJHn4RVrRynAx5n2+mR8M5QA0uja/Yfm/aGFKIxoY4K+Jla17mfnh/yeNLUbSQODj3fcNaqd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwn9veqg; arc=none smtp.client-ip=74.125.231.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwn9veqg"
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-47bb3ddaaf6so69344fac.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 20:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790999420; x=1791604220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4c95XUlHP2n9aXvysG24zI7/Pk1AYs6dQ+z9WolM1mw=;
        b=Lwn9veqgQJz17Yk7UEg+ZI7Q5jZiAPy1i+ECejedepb4HnZv4p3PTFi3USivc2aMtY
         P61KII9LEbAUCmLheVF1nCRGNyYeMSOPJS2nBgmm7EHQI+rkXCkRndxAYRROQG/iX84+
         KSARHRGjHhUHP51hzZvFEIrgHpamjcuHbuQrXA33MaTtEjRRP4A4z3hsKdrimNW8QiVC
         wRRV2lZlVlBVyFPL+uQy6eKMaGhNIrSeAbPrbCYPf6CQ8bXdCbx81KXHt/x58lPyOxJA
         OEBVIpU5WKmj+GXKA1wcc7h1lF1DVW59KvZbnIP9iORsRjJOPcm8sQkfAcfR/aDhYSoq
         NL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790999420; x=1791604220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4c95XUlHP2n9aXvysG24zI7/Pk1AYs6dQ+z9WolM1mw=;
        b=2ELsoV4BeRNO3cXARfqLGXen+OEr4zIjYUD9O+45XY+rMKm9tRFnuh2Jd9Niqf0vBb
         2zI4YE4eaGT+cY1zE3nJxTW1p3jtA2y3EKrVWgV7FQ+6SVh3yqgXa4Tmfx2fvxu3NuCn
         NeziK+Kq3VS8byNx42GDxmHiI7YUguxBpDInzfzU34K3xcsuywvl8OMNRAIdtcxbzLg5
         Wo92fcW+TUtsO8D7cpwr90fdtbR5o7FQbnSds25qxqJFpJ05RflnnNe6+TypRgua5Vh8
         kklDGDsm/FbcZKQPEGUMoNcwNN62I/7JlYGyXDwBYTKTqPZYebq+Zw0S6IMb9kCBXr72
         UtWg==
X-Gm-Message-State: AFuF++kbn38pnYLP2COFNr/A6z0FS4jFcTnGi/7FBD7edzScThFUtziA
	AejhcNkvP9DTpDwOWRwbBs8RTV7o3iAdtYqfH3wgTZsJHzwKMPfA5J9r
X-Gm-Gg: AYBFou3xVykeD8+mXZ52S1acMLCbsMR+E8ksEIZnTPLcwOrxgzn2KDf39Uy4hRzLD+b
	G/yOWSK2FnRPSghEtVLrjHW52uLZ9Zg/gmsk5oDDzbGSagq7tb8kIek1mIrhBy1uCLMd+2C8qPz
	lu2E49hbYg8nZslz+CD/T7ujLhFP6EgcJEfvckHLegCXMllkBu60p8aX/sCfWMoqLsadUAP8LLH
	rbG5iCnkl+6YykrbZ+/b5Yb/YBqo1xvx+RuCfnvXsSXj7jSk+uqKSgHch+1k90G6zquQf8DmNeQ
	WIAHD96f0xLxCkFrwsJFggtz9CSkYKsgTYXdsSx6N84PCmx4TA0WqXfWq2L+aA6AiAglFVBCgQx
	ivnL8Hg7EWJbY/qI4N0dmlzYDKeSJ9wbDbE/0gT9k/T5+uKgDmYbxvPs8FybWVff3wKeczRLRLV
	NtjooCbwclY+yKOMVBjmRyu4O3BiVSyT4kclFTj/bbj2rtpPrd+6Gl9gn1dG06MmHcadwXkXbLL
	+uGYRZkxuzlPwjckiXEIFXvKXP16CnZB9IQC3VKrt1NJPrpO2bMkDu9YL2aPNw=
X-Received: by 2002:a05:6870:5b89:b0:48f:e107:3188 with SMTP id 586e51a60fabf-49e15df105emr4805815fac.40.1790999420063;
        Fri, 02 Oct 2026 20:50:20 -0700 (PDT)
Received: from DESKTOP-D4TFR33.tail0f6352.ts.net (cs244-86-dhcp.cs.colorado.edu. [128.138.244.86])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16d6b450sm3498096fac.3.2026.10.02.20.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 20:50:19 -0700 (PDT)
From: Yunpeng Tian <shionthanatos@gmail.com>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	gmwgg05@gmail.com,
	npczmd@qq.com,
	xiao-yu.zhou@connect.polyu.hk,
	jupmouse@gmail.com,
	shionthanatos@gmail.com
Subject: [PATCH net] tipc: bound the device MTU accepted for L2 bearers
Date: Fri,  2 Oct 2026 20:50:18 -0700
Message-ID: <20261003035018.397-1-shionthanatos@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct tipc_bearer keeps the bearer MTU in a u32 while struct tipc_link
keeps the link MTU in a u16.  tipc_enable_l2_media() and the
NETDEV_CHANGEMTU notifier both do b->mtu = dev->mtu, tipc_link_create()
assigns that into l->mtu, and tipc_link_set_queue_limits() divides by it:

	int max_bulk = TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE);

ITEM_SIZE is 20, so a device MTU of 65536 truncates to 0 and the
division faults.

tipc_mtu_bad() is the only check on either assignment and tests a lower
bound only.  The truncation defeats even that: a device MTU of 65556
passes it, yet the link comes out with l->mtu = 20, below the
TIPC_MIN_BEARER_MTU the check exists to enforce, and tipc_link_mss()
then evaluates 20 - INT_H_SIZE - EMSG_OVERHEAD as an int and stores it
in the u32 tipc_link_entry::mtu.  Read back over TIPC_NL_LINK_GET, every
device MTU above 65535 leaves the link with a wrong MTU: 20 at 65556,
464 at 66000, 32768 at 98304.

The bound added in commit 9f29cd8a8e79 ("tipc: fix u16 MTU truncation in
media and bearer MTU validation") applies to TIPC_NLA_PROP_MTU in
tipc_nl_prop_policy, which covers TIPC_NL_MEDIA_SET and
TIPC_NL_BEARER_SET.  A device MTU never passes through that policy.

dummy sets max_mtu to 0, and dev_validate_mtu() applies its ceiling only
when max_mtu is non-zero, so the device accepts 65536; a macvlan inherits
max_mtu from its lower device,
and two macvlans in bridge mode on one dummy carry each other's TIPC
discovery frames, so the bearer reaches tipc_node_check_dest() and
tipc_link_create() with b->mtu = 65536.  TIPC_NL_BEARER_ENABLE is
GENL_UNS_ADMIN_PERM, so an unprivileged user can do this in a user
namespace of their own, on a kernel that has TIPC loaded.

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:tipc_link_create (net/tipc/link.c:2531 net/tipc/link.c:520)
  Call Trace:
   <IRQ>
   tipc_node_check_dest (net/tipc/node.c:1284)
   tipc_disc_rcv (net/tipc/discover.c:252)
   tipc_rcv (net/tipc/node.c:2134)
   tipc_l2_rcv_msg (net/tipc/bearer.c:669)
   __netif_receive_skb_one_core (net/core/dev.c:6216)
   process_backlog (net/core/dev.c:6680)
   __napi_poll (net/core/dev.c:7739)
   net_rx_action (net/core/dev.c:7802)
   handle_softirqs (kernel/softirq.c:622)
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Give tipc_mtu_bad() the matching upper bound, so the limit sits next to
the existing minimum and one check covers both assignments.  A device
MTU of 65535 is still accepted and the link still comes up, with the
65532 that TIPC rounds it to.

The u32 max_pkt fields became u16 mtu and advertised_mtu in commit
ed193ece2649 ("tipc: simplify link mtu negotiation"), which also removed
link_init_max_pkt(); that had clamped the bearer MTU to MAX_MSG_SIZE
before it could reach this division.

Fixes: ed193ece2649 ("tipc: simplify link mtu negotiation")
Reported-by: Yunpeng Tian <shionthanatos@gmail.com>
Reported-by: Gongming Wang <gmwgg05@gmail.com>
Reported-by: Mingda Zhang <npczmd@qq.com>
Reported-by: Xiaoyu Zhou <xiao-yu.zhou@connect.polyu.hk>
Reported-by: Qinrun Dai <jupmouse@gmail.com>
Cc: stable@vger.kernel.org # v4.1
Signed-off-by: Yunpeng Tian <shionthanatos@gmail.com>
---
Reproduced on 7.2.0, with the net/tipc files byte-identical to mainline
as of 2026-10-02, both as an unprivileged user and as root, 3 runs of 3
at a device MTU of 65536.  At 131072 the low 16 bits are zero as well,
but the two nodes never completed discovery here, so that case was not
observed.  With the patch applied, 65536, 65555, 65556, 66000 and 98304
are all refused by tipc_mtu_bad() and TIPC_NL_BEARER_ENABLE returns
-EINVAL, while 65535 still brings the link up.

 net/tipc/bearer.h |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -63,6 +63,13 @@
 /* Minimum bearer MTU */
 #define TIPC_MIN_BEARER_MTU	(MAX_H_SIZE + INT_H_SIZE)
 
+/* Maximum bearer MTU
+ *
+ * struct tipc_link stores the link MTU in a u16, so a larger bearer MTU would
+ * be truncated when a link is created on the bearer.
+ */
+#define TIPC_MAX_BEARER_MTU	U16_MAX
+
 /* Identifiers for distinguishing between broadcast/multicast and replicast
  */
 #define TIPC_BROADCAST_SUPPORT  1
@@ -254,12 +261,13 @@
 		tipc_clone_to_loopback(net, pkts);
 }
 
-/* check if device MTU is too low for tipc headers */
+/* check if device MTU is usable for tipc bearers */
 static inline bool tipc_mtu_bad(struct net_device *dev)
 {
-	if (dev->mtu >= TIPC_MIN_BEARER_MTU)
+	if (dev->mtu >= TIPC_MIN_BEARER_MTU &&
+	    dev->mtu <= TIPC_MAX_BEARER_MTU)
 		return false;
-	netdev_warn(dev, "MTU too low for tipc bearer\n");
+	netdev_warn(dev, "MTU not usable for tipc bearer\n");
 	return true;
 }
 

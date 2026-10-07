Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D73CAE7F;
	Wed,  7 Oct 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363065; cv=none; b=Sw9WO5d+JPnWvruK42nXKfO6JiV5Kf7HkE2AagGaRmghF5F35RGS9B0bfI7PSQRnOR5y2KkRUE/xOVUdHg0Wuq0iTmN86QR17vKuggyb/9dAbsX9uYCotc452uRW/5MmoVVyFpbdTnH3t8fcOctRjdn2OuHYQk5bXOlOZlTMcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363065; c=relaxed/simple;
	bh=Sdm7fx+CqbHL0mnic7CuiQulX6tV0v32Bd0YOeucSqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpiJSMaa7ysPPM3iObhAGw32b8DOxoz6qByWT6vQFYCYBM5kAENC2gdir6QUVTrf1WHWIOu9z5OzZGJSMv3g7HzPeq1aRGyKTJe5TFEv7RYJ0q4VOke66VMWXmRgAAgPy3OHsrqx9SctSVMdcSYSt1gA+TefQUD4fcDMSBzLuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=c7BeIgB4; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="c7BeIgB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=c7BeIgB4RRp46rdiqS38xX0sl2s0tKmq8DMleOZFR8N6tmAoxCqbe/qwBj1kTSLtOFH1DNOWy8NG+
	 3Rcp3QJQ2e0d3Ntj27SG6GR/UqDylbAsjEHLRfQRr5ZuwtYhCwA+uoV2iKKTjUtRYcLnhQHWEmN57D
	 I0pu8FRw0vGLhTKk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46ac607ebb87-4ad88;
	Wed, 07 Oct 2026 16:50:52 +0800 (CST)
X-RM-TRANSID:2ee46ac607ebb87-4ad88
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03 (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36ac607df4de-dd28c;
	Wed, 07 Oct 2026 16:50:52 +0800 (CST)
X-RM-TRANSID:2ee36ac607df4de-dd28c
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net v3] net: fix NULL dereference in skb realloc fault injection devname filter
Date: Wed,  7 Oct 2026 08:41:58 +0800
Message-ID: <20261007004158.1266795-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device name filter is set in
/sys/kernel/debug/fail_skb_realloc/devname, should_fail_net_realloc_skb()
compares it with skb->dev->name without checking skb->dev first.

skb_might_realloc() is called from pskb_may_pull(), pskb_trim() and
pskb_trim_rcsum(), which also run on skbs that are not associated with
a device. One example is a netlink broadcast to a listener with a socket
filter attached, which goes through sk_filter_trim_cap(). With the
filter set, such an skb makes the kernel oops:

  KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
  pc : strncmp+0x50/0xf0
  lr : skb_might_realloc+0x58/0xa0
  Call trace:
   strncmp+0x50/0xf0 (P)
   skb_might_realloc+0x58/0xa0
   sk_filter_trim_cap+0x6a0/0x928
   do_one_broadcast+0x35c/0xb20
   netlink_broadcast_filtered+0x1a4/0x328
   netlink_sendmsg+0x724/0xa58

The fault is meant to be injected on network interfaces, so skip skbs
that are not associated with a device. Without a device name filter,
such skbs are no longer reallocated either.

Fixes: 12079a59ce52 ("net: Implement fault injection forcing skb reallocation")
Suggested-by: Breno Leitao <leitao@debian.org>
Assisted-by: LLM
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
v3:
- Fix the list of functions that call skb_might_realloc() in the commit
  message (Sashiko). No code change.
- Post as a new thread, v2 was sent as a reply to v1 by mistake.
v2: https://lore.kernel.org/netdev/20261001182813.353004-1-yanhaishuang@cmss.chinamobile.com/
- Return early for skbs without a device, as suggested by Breno. Such
  skbs are now skipped whether or not a device name filter is set.
- Tested on arm64 (QEMU) with KASAN: the netlink broadcast reproducer no
  longer oopses with devname set, the devname filter still injects on
  the selected device, and without a filter skbs without a device are
  skipped while skbs on a device are still reallocated.
v1: https://lore.kernel.org/netdev/20260930122013.110284-1-yanhaishuang@cmss.chinamobile.com/

 net/core/skb_fault_injection.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
index 4235db6bdfad..63a397f76113 100644
--- a/net/core/skb_fault_injection.c
+++ b/net/core/skb_fault_injection.c
@@ -18,6 +18,9 @@ static bool should_fail_net_realloc_skb(struct sk_buff *skb)
 {
 	struct net_device *net = skb->dev;
 
+	if (!net)
+		return false;
+
 	if (skb_realloc.filtered &&
 	    strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
 		/* device name filter set, but names do not match */
-- 
2.43.0




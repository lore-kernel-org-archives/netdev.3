Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D563803DA;
	Thu,  2 Apr 2026 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172433; cv=none; b=SFi4ygHxptGe6hN3CpF1uWTqq9tVgJN8T/BWFkBjbr5nyTS+tgSvnBAWzeN3CWNZFx758aIlrSrUCc7OIrbj+ASXlkKD3yup4ZmBH7ovPGxzeV/MARLzs+239GhsVhasTlHmnNA7ynF3tirmnzlqwRHFVEScMUh7UXzeG9K1zlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172433; c=relaxed/simple;
	bh=d0FCQBwWQcmetfvZotdvIkyZucvxpGqFc03v86p1wio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtgoUfTxxVu2FzZS9S1/OmWNrhTjbOGkjFRdLxt1frONDJT2RA8yOAWhvNdx2jmmh4bGbAj1aa9/RW0f4aEysgOd9DKbXTegmjklkIUAVqvMBZvFsjI82BIyqm5trLFBmOTq8YfSIGNzC2w6HJSbgolaxBRZKZzfIoQzB9aqb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=XIY/dR7M; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="XIY/dR7M"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3956a559c;
	Fri, 3 Apr 2026 00:37:22 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 5/6] net: add Rust reference driver for nlmon
Date: Thu,  2 Apr 2026 12:36:39 -0400
Message-Id: <20260402163640.1079056-6-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
References: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d4f0e7b4603a2kunm6754def456bf61
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUhOVh5IQ0oeT09JTUkYHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XIY/dR7MMs7qOrRoufyt5GJaJxx1M1V1MhmUy7v3PXBNK5kORbZCoW/sIbl0CJ9whQ0+86ucuCKp099KWq40Ou0Hf0L1l5YI4LlG6INtLkQj7a225NgNgBrDv2zQ11zOBrchRMUWPXN3zjhmEBxdS2LH6zbW6U7FwF1seACy4gs=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=MwU5JMyxAfcaZO4WV+hoTg6Dq0CRM52eh9oDblRZKtg=;
	h=date:mime-version:subject:message-id:from;

Implement nlmon as a small Rust reference driver on top of the new
networking abstractions.

nlmon is a good validation target because it is netlink-centric and
exercises rtnl registration, netdevice setup, tap lifecycle, and packet
stats without hardware dependencies.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 drivers/net/Kconfig       |  9 ++++
 drivers/net/Makefile      |  6 ++-
 drivers/net/nlmon_rust.rs | 93 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/nlmon_rust.rs

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 17108c359216..0eccd0af8b75 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -466,6 +466,15 @@ config NLMON
 	  diagnostics, etc. This is mostly intended for developers or support
 	  to debug netlink issues. If unsure, say N.
 
+config NLMON_RUST
+	bool "Rust implementation of nlmon"
+	depends on RUST && NLMON
+	help
+	  Select this option to build the Rust implementation of
+	  the nlmon driver instead of the original C version.
+	  This keeps a small reference driver available while the
+	  supporting Rust networking abstractions are reviewed.
+
 config NETKIT
 	bool "BPF-programmable network device"
 	depends on BPF_SYSCALL
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 5b01215f6829..5d3357d56cc8 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -38,7 +38,11 @@ obj-$(CONFIG_VXLAN) += vxlan/
 obj-$(CONFIG_GENEVE) += geneve.o
 obj-$(CONFIG_BAREUDP) += bareudp.o
 obj-$(CONFIG_GTP) += gtp.o
-obj-$(CONFIG_NLMON) += nlmon.o
+ifdef CONFIG_NLMON_RUST
+  obj-$(CONFIG_NLMON) += nlmon_rust.o
+else
+  obj-$(CONFIG_NLMON) += nlmon.o
+endif
 obj-$(CONFIG_PFCP) += pfcp.o
 obj-$(CONFIG_NET_VRF) += vrf.o
 obj-$(CONFIG_VSOCKMON) += vsockmon.o
diff --git a/drivers/net/nlmon_rust.rs b/drivers/net/nlmon_rust.rs
new file mode 100644
index 000000000000..d10e320c4635
--- /dev/null
+++ b/drivers/net/nlmon_rust.rs
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#![forbid(unsafe_code)]
+
+//! Rust netlink monitoring device.
+//!
+//! C version of this driver: [`drivers/net/nlmon.c`](./nlmon.c)
+
+use kernel::{
+    net::{netdevice, netlink_tap, rtnl, skbuff, stats},
+    prelude::*,
+};
+
+module! {
+    type: NlmonModule,
+    name: "nlmon_rust",
+    authors: [
+        "Daniel Borkmann <dborkman@redhat.com>",
+        "Mathieu Geli <geli@enseirb.fr>",
+    ],
+    description: "Rust netlink monitoring device",
+    license: "GPL v2",
+    alias: ["rtnl-link-nlmon"],
+}
+
+#[pin_data]
+struct NlmonModule {
+    #[pin]
+    registration: rtnl::Registration<NlmonDriver>,
+}
+
+impl kernel::InPlaceModule for NlmonModule {
+    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            registration <- rtnl::Registration::new(),
+        })
+    }
+}
+
+struct NlmonDriver;
+
+#[pin_data]
+#[derive(Zeroable)]
+#[repr(C)]
+struct NlmonPriv {
+    #[pin]
+    tap: netlink_tap::Tap,
+}
+
+impl netdevice::Operations for NlmonDriver {
+    type Private = NlmonPriv;
+
+    fn open(dev: &mut netdevice::Device, private: Pin<&mut Self::Private>) -> Result {
+        private.project().tap.add(dev, &THIS_MODULE)
+    }
+
+    fn stop(_dev: &mut netdevice::Device, private: Pin<&mut Self::Private>) -> Result {
+        private.project().tap.remove()
+    }
+
+    fn start_xmit(skb: skbuff::SkBuff, dev: &netdevice::Device) -> netdevice::TxOutcome {
+        stats::dev_lstats_add(dev, skb.len());
+        netdevice::TxOutcome::Ok
+    }
+}
+
+impl rtnl::Driver for NlmonDriver {
+    const KIND: &'static CStr = c"nlmon";
+
+    fn setup(dev: &mut netdevice::Device) {
+        let features = netdevice::features::SG
+            | netdevice::features::FRAGLIST
+            | netdevice::features::HIGHDMA;
+
+        dev.set_type(netdevice::device_type::NETLINK);
+        dev.add_priv_flag(netdevice::priv_flags::NO_QUEUE);
+        dev.set_lltx(true);
+        dev.set_needs_free_netdev(true);
+        dev.set_features(features);
+        dev.set_flags(netdevice::flags::NO_ARP);
+        dev.set_pcpu_stat_type(netdevice::pcpu_stat_type::LSTATS);
+        dev.set_mtu(netdevice::mtu::nlmsg_goodsize());
+        dev.set_min_mtu(netdevice::mtu::NLMSGHDR);
+    }
+
+    fn validate(ctx: &mut rtnl::ValidateContext<'_>) -> Result {
+        if ctx.has_link_attr(rtnl::LinkAttr::ADDRESS) {
+            return Err(EINVAL);
+        }
+
+        Ok(())
+    }
+}
-- 
2.34.1


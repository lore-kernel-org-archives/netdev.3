Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B737CD33;
	Fri, 18 Sep 2026 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695334; cv=none; b=l2U/Wlg3pSaDyE4t+1aIl3gNkN1250chmMDGCxnwUYRz/09l+rGluEHvtzt02HukvsmAbwYOCb6JsK1bMyOunT5zDJgzWU61t3EVo37mevLfZX+kkx30YyCHs94/IvJb2EgPmXjZ6IINma/dlhwndStEK5E+Hg+blh3jkb3jrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695334; c=relaxed/simple;
	bh=Lx6K893axtDTBhr7aU/rEDX7Jb6udyMRT7mxrsLT9+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H7uc3CcjI7l4vR/MTW66nvkjyI8wlyMX2wvURDxr8V5slqO+ph1uSDi1YzhMZyLsgf8Pd5joMTefDucpcP8oF0oY1xi88aGX4YpKHUffAYJjxLxFdMYZ7R7q8ADfVUdTq0YnRFpQ/luk8N09cYTWzVF3OTpH2QgDrpfJfhFL0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnvfFOlaxqU_1ECA--.12337S2;
	Fri, 18 Sep 2026 09:35:10 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: netdev@vger.kernel.org,
	Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] tipc: refuse to attach a second bearer to a netdevice
Date: Fri, 18 Sep 2026 01:35:09 +0000
Message-Id: <20260918013509.1853952-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnvfFOlaxqU_1ECA--.12337S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4DtF1rtFy8JrW8Gr17Jrb_yoW8ZFyfpw
	s3GF4SyrZ7GrZ0k3Z2qayIqa43ur4kAa1fKw18G3WF9ws5Xa4SyFy8XFyYgF10gr4kZan8
	ZrW2gFyfCrWUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F
	4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS
	5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAnYrUUUUU=
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

tipc_enable_l2_media() associates a bearer with a netdevice by
unconditionally overwriting dev->tipc_ptr.  The duplicate check in
tipc_enable_bearer() only compares full bearer names, so two bearers
of different media types over the same device (e.g. "eth:team0" and
"ib:team0") can both be enabled successfully.  The second one then
silently replaces dev->tipc_ptr.

Each successful enable holds one device reference obtained with
dev_get_by_name().  Since the device notifier tipc_l2_device_event()
only sees the bearer pointed to by dev->tipc_ptr, NETDEV_UNREGISTER
disables only the last attached bearer; the other bearer is never
disabled and its device reference is leaked for good.  The leaked
bearer keeps sending periodic discovery requests on the unregistered
device, producing endless "selects TX queue" warnings and stalling
the device teardown (unregister_netdevice: waiting for ... to become
free).  This was observed by syzkaller with team slaves.

Fix this by rejecting the enable with -EBUSY when the device already
has a bearer attached.  The caller tipc_enable_bearer() already rolls
the new bearer back on any enable_media() failure.

Fixes: 37cb0620073c ("tipc: remove TIPC usage of field af_packet_priv in struct net_device")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 net/tipc/bearer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887a..b15a67429fe5a 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -454,6 +454,13 @@ int tipc_enable_l2_media(struct net *net, struct tipc_bearer *b,
 		return -EINVAL;
 	}
 
+	/* Only one TIPC bearer may be attached to a device at a time */
+	if (rtnl_dereference(dev->tipc_ptr)) {
+		dev_put(dev);
+		pr_warn("Device %s already used by another bearer\n", dev->name);
+		return -EBUSY;
+	}
+
 	/* Associate TIPC bearer with L2 bearer */
 	rcu_assign_pointer(b->media_ptr, dev);
 	b->pt.dev = dev;
-- 
2.34.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55E33939D
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507851; cv=none; b=sUSv+56GeiUzi9Vn0TKjdrZDKnrhIKDFqHllg2X0sTSC5vViBaKmqzFthuiIQqMOZmi1O7Dm4BT2TN6sDIdhnJX7S+Yx/oMfRW6izie+7MAprHyIg3Y7IGpx2kV+A/hr6XeA6ifu0x7fXVgwc8bJoQfIyhmT3dgUJIotqzVQhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507851; c=relaxed/simple;
	bh=BM+ELWmqJQfhYhcWQ7buClZuQVBNII/Mqo/wTxK7yKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHls8EK3XciH8nqrgGCpGhUwtGfUAX6NEtQlk/5cGJaRrm+1PNmBW0Rz47xR9X6Zb/Z7SmAl9TzdRa45Cc7LUAQzhDsUbEcMNT3HaXjndqCKQRhWsYwXwxX/1kyCzf6DFmiCSbffwg56yrgpM1WUgfz6ecQzs+RNbvUGo8oeKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niwjGBi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niwjGBi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201271F000FF;
	Tue, 15 Sep 2026 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789507849;
	bh=LNLsOIZ7XNXZXt2qApOGXMJMWMauxBleg5lBqj9wRi4=;
	h=From:To:Cc:Subject:Date;
	b=niwjGBi6vyDD9cwr1OZwzggPsnW62jrauej+UqC/2CnrDvBa5fLcOSmZdLC8MyFJW
	 m9b1rGsA4Fq/ZbE4QefBCgG0CQcG8xiDH85fiGPHTyZP7XMCMT9EclwYcHVY229nrK
	 ifUHsRSHdCyWaRXJo8BYdy5ILiU6iSkyzZOijPx8LxbbPmONMxAFm/jpRoq4NZZWYH
	 O0G1jVIiHBwHQCBtfBcuYKnfECvswMDFSGncQfZsK8dGlIkIq/NQarjxLYkXTxa/7w
	 Ywb37vAt0Xl+hdZvPi2EEF2JC8voYLZkmb0QN/1/nTcV24r03nvy+tB97SffLnIeDN
	 nqT53TGOAGIsA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	milena.olech@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net] dpll: reject a reference sync pin which is not on the pin's dpll
Date: Tue, 15 Sep 2026 14:30:47 -0700
Message-ID: <20260915213047.1352286-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpll_pin_ref_sync_state_set() resolves the partner's driver private data
with dpll_pin_on_dpll_priv() and passes the result to ref_sync_get() and
ref_sync_set() without looking at it. The helper returns NULL when the
partner holds no ref on that dpll. Of the two drivers implementing the
feature only zl3073x dereferences the pointer (sync_pin->id); ice ignores
it, so ice cannot fault here.

The NULL is a teardown race, not a steady state - zl3073x registers every
input pin with every channel, so the partner is normally present on the
dpll the base pin resolves to. zl3073x_dev_stop() unregisters pins one at
a time, taking and dropping dpll_lock for each, and between the partner's
turn and the base pin's the partner is out of that dpll's pin_refs while
still registered with the channels not yet torn down, so
dpll_pin_available() keeps passing. That path is not only driver removal:
devlink reload and devlink dev flash both run zl3073x_dev_stop().

Reproduced by holding that state open with a mock dpll device, which is
where the frame name comes from:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:mock_ref_sync_get+0x5/0x30
 Call Trace:
  <TASK>
  dpll_pin_ref_sync_set+0x19f/0x4a0
  dpll_nl_pin_set_doit+0x17d/0x840
  genl_family_rcv_msg_doit+0xd6/0x130
  genl_rcv_msg+0x181/0x2b0
  netlink_rcv_skb+0x55/0x100
  genl_rcv+0x23/0x30
  netlink_unicast+0x24d/0x370
  netlink_sendmsg+0x1e2/0x420
  __sys_sendto+0x1db/0x1f0
  __x64_sys_sendto+0x1f/0x30
  do_syscall_64+0xe1/0x490

Commit d2e914a4a0d0 ("dpll: fix NULL pointer dereference in
dpll_msg_add_pin_ref_sync()") added the same guard to the read side, which
the kernel walks into by itself because the delete notification is emitted
from inside the unregister; the write side needs a pin-set to land in the
window and was left alone. Test the priv rather than look up pin_refs
directly, so that the two halves key off the same condition.

Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: vadim.fedorenko@linux.dev
CC: arkadiusz.kubalewski@intel.com
CC: jiri@resnulli.us
CC: ivecera@redhat.com
CC: milena.olech@intel.com
CC: przemyslaw.kitszel@intel.com
---
 drivers/dpll/dpll_netlink.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index d4f133ac9fea..9a90733b2da3 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1201,6 +1201,7 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin, u32 ref_sync_pin_id,
 			    const enum dpll_pin_state state,
 			    struct netlink_ext_ack *extack)
 {
+	void *pin_priv, *ref_sync_pin_priv;
 	const struct dpll_pin_ops *ops;
 	enum dpll_pin_state old_state;
 	struct dpll_pin *ref_sync_pin;
@@ -1228,9 +1229,15 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin, u32 ref_sync_pin_id,
 		return -EOPNOTSUPP;
 	}
 	dpll = ref->dpll;
-	ret = ops->ref_sync_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
-				ref_sync_pin,
-				dpll_pin_on_dpll_priv(dpll, ref_sync_pin),
+	pin_priv = dpll_pin_on_dpll_priv(dpll, pin);
+	ref_sync_pin_priv = dpll_pin_on_dpll_priv(dpll, ref_sync_pin);
+	/* Pin may have been unregistered from this dpll already */
+	if (!ref_sync_pin_priv) {
+		NL_SET_ERR_MSG(extack,
+			       "reference sync pin not registered with the dpll");
+		return -ENODEV;
+	}
+	ret = ops->ref_sync_get(pin, pin_priv, ref_sync_pin, ref_sync_pin_priv,
 				&old_state, extack);
 	if (ret) {
 		NL_SET_ERR_MSG(extack, "unable to get old reference sync state");
@@ -1239,9 +1246,7 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin, u32 ref_sync_pin_id,
 	if (state == old_state)
 		return 0;
 
-	ret = ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
-				ref_sync_pin,
-				dpll_pin_on_dpll_priv(dpll, ref_sync_pin),
+	ret = ops->ref_sync_set(pin, pin_priv, ref_sync_pin, ref_sync_pin_priv,
 				state, extack);
 	if (ret) {
 		NL_SET_ERR_MSG_FMT(extack,
-- 
2.55.0


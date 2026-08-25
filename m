Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB073D6461;
	Tue, 25 Aug 2026 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648564; cv=none; b=ZgVk9rDOoV84o46H+PLaaGkTlScVjmwP/SdNsT9AA8OIeH5tl/l4WZEicwn0VTWulr1mWL9MUn+dDqt/j8Tf7CICHNmoz9T1/FLqsfUl/cS3MSkqaUEBQZGSjEaDNV85yVCpZVwCDmKmqN/7l03TvMtKHn3aoqPprfcsB68Ietg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648564; c=relaxed/simple;
	bh=ceikmrp4PuoVjfBKyLj9IWYeFjcuj+0SapmTsotWv8o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BctZjuRUXTbcP3YjHdwme03QMq9hzTEKawPglSLv9YETnhrFm0joiL7r+AidCZe7EX77DMYSpRsB/IMkAeF5Sb0eKr9WFrNLnOZXCv74Cc34BzPbo22VMUID5yZYTsDRg4Qy6mIk2gO5AnYbuRYbmEDeGQaQ7zJnqLKvth89m28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aYxo3Ttk; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aYxo3Ttk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787648554; bh=ceikmrp4PuoVjfBKyLj9IWYeFjcuj+0SapmTsotWv8o=;
	h=Date:To:Cc:From:Subject;
	b=aYxo3TtkzbiilMyaWcU4tHToyLAmHsa/ABqDzTlrUyG5eOzmgEdCCjMpUYgjKTqaV
	 1PinUjZUscObEsK4wKHgMumkiueicTSyeDoC3uUzexrps8FcHJIr8FesEHGBuBQg5X
	 gJbn9xKzDfgCWjrEz4DB+M7B1WeWnJo7EGRXiNhw=
Received: from [192.168.255.10] ([111.206.145.19])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 9F0C875; Tue, 25 Aug 2026 17:02:31 +0800
X-QQ-mid: xmsmtpt1787648551tw6126cy3
Message-ID: <tencent_AFD4DC7BE2EC61C628B53A3BCF4B558C2105@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/7D1mn5+0obpbSba8rNBYpS+u7BDIdCdW1Fx51rKkew5xht/a+x
	 /9jtPiKMN0/nkzAHV+fKrV/XI0AVQwmG2gm3hM4BBHvCC7tGqLwG/c5I11koYB/TjYi3B4/HrEUq
	 OVZbNRkF8SqSnnesyl1cxv08RDL58q/B4Yz9wGgkxR/TKw5+KtmEj1MhzgPhPy8JzFRTbd+pP5E4
	 z3aIkgXk8KSJ/vHM2Zf7hES4V/tTXVYAA9swGxmmbsskD3BVV2EK9baQidji3Uncf5YdXpVSfEFP
	 OFYut6MGbOB78Is/OFB9jQEQJcNc+FrO01MtrSgY2Yjnilax01y9BLD4fooRnR9kTTY7V6DQTiIV
	 dhPO7xsSsPg3lIWbRRpoSl46ygCRgm+0Rqvse85u2vT1RUhxp+e9Nc+kC+wMAL54DgCnPvVQ5hDT
	 TFGq4qBBcbHvwUqa1A0rqPkviA6h8e3bWpfNBeuh6nwQCAqvLSP/YzgB8CH6M7viEj/iJ3TthTsc
	 Bsov1nOMVlBxkFpqOAt3/2IZlT39GzvDZEec+MErgfa8mixAEN3tzhy9GckjvQARyefcGZEuuFMy
	 cUIHRdact1/xNkuKlKH1H1RBq6l7XcsTjtooo1g2wBAmKbp0lYHYjOT21B9Gy1O+WB9jsdT9vZn+
	 TmwFTT62FhagjWzOsDCek4gz2NGU1c35puS1z3neAU0W5XF+tYdEsupbQv3hoHRf4DKxifb2Y8+w
	 AjYGKQeLa5YFEsFFa6VkfqPELv88jFPXF4xP5qe8AsOGJ/3wvJDtzSKkvFDy/F47kyq1L1kFGZIr
	 ck1YOLjHn/S9t697zHFmVJN2EIJo+vXPl31LvcdticdOuV5dqDH1CnX7Be00Rzr8sLUj6Wx5wFCP
	 C0tP4HOkWL4qH4PwQWTY0za/Eh1x1Lr4Xe9PMZGrGavyPoGW8YaCGXWaECqj9vGG/IdfZCOdAwKy
	 hClezAbHqy9wANuXRdzr8uOyPMsyiPIMgBfe/7YcD/ETUt3Sxp4DiDhLDXjgGddRjcYZTsDiHFV2
	 s+MHenTJMzpovH8GlmfIdwwLO5X9/XfY6GKMB56WcX+FRaFNR87tTZJnz/FhvP+pypPe9iajwfrj
	 S9srjS
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-OQ-MSGID: <c08b83d9-1cc3-4887-bda8-10bb53af887e@qq.com>
Date: Tue, 25 Aug 2026 17:02:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: justinlai0215@realtek.com, larry.chiu@realtek.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] net: rtase: Fix NULL pointer dereference in NAPI cleanup on
 probe failure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rtase_init_napi() (which adds the NAPI contexts and sets napi->dev) is
called after rtase_alloc_interrupt().  If interrupt allocation fails,
rtase_init_one() jumps to err_out_del_napi and calls netif_napi_del() on
NAPI contexts that were never added, so napi->dev is still NULL.
netif_napi_del() -> __netif_napi_del() -> netdev_lock(napi->dev)
dereferences that NULL pointer.

KASAN report:

    BUG: KASAN: null-ptr-deref in __mutex_lock_common kernel/locking/mutex.c:625 [inline]
    BUG: KASAN: null-ptr-deref in __mutex_lock+0x8f/0xce0 kernel/locking/mutex.c:820
    Read of size 8 at addr 0000000000000cd8 by task syz.0.1/1147

    __mutex_lock+0x8f/0xce0 kernel/locking/mutex.c:820
    netdev_lock include/linux/netdevice.h:2818 [inline] [rtase]
    __netif_napi_del include/linux/netdevice.h:2942 [inline] [rtase]
    netif_napi_del include/linux/netdevice.h:2961 [inline] [rtase]
    rtase_init_one+0x5c3d/0x5fd0 drivers/net/ethernet/realtek/rtase/rtase_main.c:2295 [rtase]

Only call netif_napi_del() on NAPI contexts that were actually added
(napi->dev != NULL), so the interrupt-allocation failure path skips them
while the post-napi-init failure paths still remove them.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index e3cd4f7c1380..b4d8828ca87d 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2493,9 +2493,14 @@ static int rtase_init_one(struct pci_dev *pdev,
     }
 
 err_out_del_napi:
+    /* rtase_init_napi() runs after rtase_alloc_interrupt(); if interrupt
+     * allocation failed the NAPI contexts were never added and napi->dev is
+     * still NULL, so netif_napi_del() must not be called on them.
+     */
     for (i = 0; i < tp->int_nums; i++) {
         ivec = &tp->int_vector[i];
-        netif_napi_del(&ivec->napi);
+        if (ivec->napi.dev)
+            netif_napi_del(&ivec->napi);
     }
 
 err_out_release_board:


Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1A222590
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786870019; cv=none; b=jr8De0N8ZvBI2gnCTDtlRf42mqZUGx9ETsG6Ha2kPCrRVwTuznClHVz0zi+PDhNvrVqPGaVs04B3rGpwPCxyIUFByeuaGqo1wQf+o7VXywJsLyZalAzNOoqu3W+2svA9s+m5NpBOt7cJ19Kpp+n42dbmcgzmsLHc6mx+cp1cQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786870019; c=relaxed/simple;
	bh=yhFY03Jf7Jc3gG0Hk2Ox6qqS7YLRstsfZeOM8h5oVnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ua9KB1bWWpPKN3/EYAd+r25IHfpi//jIcEVtFqDPrL/JLCN1TkDYGIA1OqTD5wgPapfX38fiQoVCzdlE9E/5n0k19kVfunWP7RO7hUzDk2jQJUjvDZIyWNyWWJF8qmDM8+7ziXTkFKYWvtF1jJeI86Ladeq7DC/vtplZbmlMsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVctS/5f; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVctS/5f"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso1836773a91.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786870017; x=1787474817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3O4EGPdm9ux4itALfuPLExBGtY87K4Q/kGgwV3Dhs0=;
        b=iVctS/5ffXTxZ7Jh6kBj53oFWr0+6FXA0z6UrUN583PttrNp/SEZYNXyKqEjj3nLxe
         SYlkiSDBwklN+6RXUoNXll8gHcgNvq5fJIGp+RlN66T3wg8n74IZpDp/DWxeRpAJzQqF
         hRLaHfBqGxNjaO0OBG2WLsHeGk4oDCjW/7eawe1LT/897AON79nkGdZqjLvEq+CFtvvx
         PNKd4WJw9TdCQSdg4t7PplpgDzP6Ggf4HyNzIWdSxNrgq8QZIyv/oRNwDQ8kUA/25LpR
         IMAlMdFYntDeQ7vG5M1vb8faz8A0PfXnRHuyFVzvmG0/fXIX8oXE9chxhCy0Go2+yYpb
         mlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786870017; x=1787474817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3O4EGPdm9ux4itALfuPLExBGtY87K4Q/kGgwV3Dhs0=;
        b=dpIXnqnWwrEzpWvL3TA/IMaNglN2yQiVjZ+s3LGRlQY9qApg58+e9b1bZEh2NTFHkR
         XpEvIY+CJ5LBDi/ZqoINHgUF4K4uX7WOjUaZcdyTeKv5jhKaRBe30UBlTW0udKkd+PTO
         8iRIzHut2UZyNA7GCIuNBlmPc0P4M0Hp7gN7X2cB9dKadrmgjnD5BsV8PX1t8vgP51nv
         EwlVErv6Eph8Yt0sbBDD6ui5dNoFbapI5GYVvuVfUppUn05oxzaYADUfEA45rk6r1RfD
         4mR824qxDNDJ/Kir2tBN12fJmUDk+KzpbFbelW4Vwf7VxrfQTH1dBaKOsqL2tU2h4HT9
         skLw==
X-Gm-Message-State: AOJu0YzjTRu2KT5FirBCzjP98AqFHqYrBJ5fWUEuOQBt6ve7Ei/WKE8s
	1JGO//EfXqokb7JiaXUzJ65T0oPoRSpCqNRq41NZ3K9QA/prTkuK7Wwv
X-Gm-Gg: AR+sD13GDaorI7IrE9EOwMtfjSONAlXjKmWo4KfYGIQSP0rNnuqYPf1JpEL8SHkBoLq
	Bs8ilzEt7S8ndeS6I3QAVXTQWZrCdMbEt+nMo8qP1b/j4VfQcUDpdm6eEG5ZZYQiKY1eCwgoQj+
	NQPf3c+5ph57UirGDZ9KYmK0usBTLPrN3F9mg5UdxRUnsNoSnglI/6njXhPGnE1hn1L2wtJL9tB
	I083uDSwQ+NuPKr3j/qa9eiackwvXVa5BYp5Hg8ZG4bKnQimkLwOPLR2T6S7zNEuQnUgjPK3PMP
	dmrTzZhweAMpu75ymcdJU3vvzxeVw2z4J2sUap2UMMtBnf4x/1z9EBNVMRThiz3EP1TGBaSj7nE
	OESaSxoKphJdGE3dOgiHpzVPvixhpmJeki9tUlQrMG59ly5hWt8u47Rt6ARBFXXuh8SlEQ7A0W3
	X3j6AdnCrKUky2HhSeBdsKvmUKn8SNoguzim3Ngo98CLsr6ZyQMGYdL/tKyvpdow2fML9R30la
X-Received: by 2002:a17:90b:1651:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-3933e633478mr17153157a91.15.1786870017044;
        Sun, 16 Aug 2026 01:46:57 -0700 (PDT)
Received: from MacBook-Pro ([163.125.147.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531fbc08bsm968494a91.12.2026.08.16.01.46.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 01:46:56 -0700 (PDT)
From: Hu EnZe <paulinsider@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	corvus@tencent.com,
	slamhu@tencent.com,
	paulinsider@gmail.com
Subject: [PATCH net v3] xfrm: hold state while flushing device GC list
Date: Sun, 16 Aug 2026 16:46:34 +0800
Message-ID: <20260816084642.76154-1-paulinsider@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hu EnZe <slamhu@tencent.com>

The device GC list does not hold a reference to the states it
contains. During netdevice teardown, xfrm_dev_state_flush() drops
xfrm_state_dev_gc_lock before calling xfrm_dev_state_free(), so the
regular GC worker can concurrently destroy and free the entire
xfrm_state. Subsequent access through the stale pointer can corrupt
memory and cause a kernel panic.

Pin live states with xfrm_state_hold_rcu() while holding the device GC
lock, and skip states whose reference count has already reached zero.
Drop the acquired reference after the device state cleanup completes.
Also use hlist_del_init() when removing dev_gclist so the node is
marked as unhashed after removal.

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: Codex:GPT-5.6-Sol
Signed-off-by: Hu EnZe <slamhu@tencent.com>
---
v3:
  - fix the outer email From name from "paulinsider" to "Hu EnZe"
  - no code changes

v2: https://lore.kernel.org/netdev/20260809081151.56774-1-paulinsider@gmail.com/
  - rebase onto the latest ipsec tree
  - use Hu EnZe <slamhu@tencent.com> for authorship and Signed-off-by
  - add the Assisted-by trailer for Codex
  - clarify the netdevice teardown trigger in the commit message
  - no code changes

v1: https://lore.kernel.org/netdev/20260801041340.92117-1-paulinsider@gmail.com/

 net/xfrm/xfrm_state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 36a4f6793ede..01138d3d1067 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -785,7 +785,7 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 	if (dev && dev->xfrmdev_ops) {
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		if (!hlist_unhashed(&x->dev_gclist))
-			hlist_del(&x->dev_gclist);
+			hlist_del_init(&x->dev_gclist);
 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
 
 		if (dev->xfrmdev_ops->xdo_dev_state_free)
@@ -1006,8 +1006,13 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 		xso = &x->xso;
 
 		if (xso->dev == dev) {
+			/* The device GC list does not hold a reference to x. */
+			if (!xfrm_state_hold_rcu(x))
+				continue;
+
 			spin_unlock_bh(&xfrm_state_dev_gc_lock);
 			xfrm_dev_state_free(x);
+			xfrm_state_put(x);
 			spin_lock_bh(&xfrm_state_dev_gc_lock);
 			goto restart_gc;
 		}

base-commit: c12cbf56320fb633484ee0ca1fb7d68d6b64b213
-- 
2.55.0


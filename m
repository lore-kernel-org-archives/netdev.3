Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA78B29D268
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472949; cv=none; b=nOeSq+p1HNfOf+sD4pipRJ7YQ5gB7/1s8bSal0bxWO/b206JbtlEtqojMYn//FqYU1gQGk4jMgOnAs13x5D+FwCWKm+pA2P4b48tObcTShyhinbAMU+2msHTuiGjjRdG5YMHyCOhqwWuukq8qKqBhAfufFJFAvEuDjehwXt/cZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472949; c=relaxed/simple;
	bh=n6F8WUYH4AuiviPuMeAEczkGQFpiX4BZvauaIbiIzPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtKsgmxj+KtXWBxrP8KiMvI+yro0EpyALf+rhsyaxUt1+RlClIMkyVLklD2aSOE4Vktt6nzJsPvP6Jb/Esajnu2VyYPWI7SSy288GKmjPFu3CEhk05Dl2rQc2jwfF0Al0kEktDmKe/hlqCjyEiXfj7WcbxIJ+CW8Tw9vaF7IsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qP75Kl7B; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP75Kl7B"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80dc4a68e4aso1432887b3.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786472946; x=1787077746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mwRd/A77xTdK5ROEQsw9/WGk2cP0ZmxVQLV+rhz0Xuk=;
        b=qP75Kl7BgrXIShjQXkj1ZVcAJyad0v8bqP5TcuCO0ZTsGT8eRtuepuOAwe/uAQNqaP
         sDRWNnj2zmvw33GEEHDMaKXxuQEsiE6Q61JmQpHShHJv+9HEUwQwsxwFGd+dtP07G140
         hEVBuAnUSrO/bSnYxTLdz53C/xC6FkeSLi7WTUTXEADD9GMYqPTpPoy44Jv65UTut5ue
         gMUz4nMcC+QZNIOnTfrLfyRCIdHz89/WXktVwj5k6osc84h5VGd/wtXKSDS+Lf9TyQnt
         TSVisyR8iZukTlDhvJ4i8XAiwf35s1987kJrMGXQ4gSt0/2Vo1D58G/s9RrT7vc1aSvl
         HHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786472946; x=1787077746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mwRd/A77xTdK5ROEQsw9/WGk2cP0ZmxVQLV+rhz0Xuk=;
        b=Pt48TXohXsz5vaJBe7DAvv+htNl/wKy4o1069aArHwJ+6WYzNwqFZ18D6OJC5VBYx6
         l/WSM4KaIkwXxNwOEjT+nX+t0ZVzRlVdkuWyhJU/HSwkg9p2CsO6yyHy9In+711n6D8C
         M7sBF3h6fAgXPnS44rwp+kS2EypCdCm+ZnXxK5vvuupV1we0Ybl9HlWkata4aHGtfsDy
         SBofYnWIumboKoAfs6gzaTG4vAX1ycRK0gQxztmShEAL8NsRn9MItEg+XtZyx2A8Xl/p
         ONoBi7IG+OUdcMcw11blZ/96jQSz1SR2vodpm2i1nnGIfCbslMLYaqCoYh4z1tiJN1XD
         JJtQ==
X-Gm-Message-State: AOJu0YwFqaW7V6Hy6ffanbzi6apa1IEIGhpEN61nKMpQIdXdllayplzD
	yGkyHPewBA3Opw/VsP5EjProDJMrcLZA6I6jCF8BWDNgfYH7XDaZwC/bMQ/M6Q==
X-Gm-Gg: AR+sD138Vai1JHGw/0T2Ckb4y4VTbSpt1orNpJrsv+n/9fCQUoqNst6HJqFA8hAPjhp
	KhZpoTTqMpjDPuFAmmuwnH7mUY5AkAo+/nW4jwsO54+0OSQNg0BXA0bEuIDtWmPuTltkeA/TFBH
	D2B6lxS7KFP851rV6SzWh04KBjtd8o6z4Jv2fpPv1sSNxgZ0cbePoVaCXjHno/KAVCNgY0lzWnH
	KEh72n9gVwaMLPnzabm+qs3S6GSSgFBxPxFtaWlvvLjYVaX+kHS9OnfmUu4vcOxoo2aVmkc6KDF
	2+eK6iLcH3NMeLSnb9wCcFeY2PURoUwQiIPt5Vn1FL90vJR+qZouKLxezLxKWjEDnZ6soYjq8vm
	qF68KHNnTP0hZP0O92kfBfM6nyJ3AFR4PAiOLKWyiqPvCnpOTPDodohn6EJX+kUEqXbGH04WS5q
	AoIrHe5zS8WYiOkoIZqF+yucd5JCqLLzkxmUwtXRjJhQJ790P1owx5PwIDbrVX8Vf1H1DIPmcAw
	Z267uDIsWPBnP0p0BSOhKMq1LNmzoqvS1Oj8+31QNDbxeVw0ZwGXOED6Aw=
X-Received: by 2002:a05:690c:698d:b0:81f:650c:98cd with SMTP id 00721157ae682-82f2dc957b4mr42072127b3.28.1786472946341;
        Tue, 11 Aug 2026 11:29:06 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830ab3716d1sm1371197b3.45.2026.08.11.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 11:29:05 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests: drv-net: so_txtime: fix qdisc replace with handle
Date: Tue, 11 Aug 2026 14:26:50 -0400
Message-ID: <20260811182856.2702163-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The blamed commit updated a tc replace command by adding a handle.

  -    tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
  +    tc(f"qdisc replace dev {ifname} root handle 1: {qdisc} {optargs}")

This breaks the test if the root qdisc already has that handle and is of
different kind, with

  "Invalid qdisc name: must match existing qdisc."

If no handle is asked, or the kind differs, tc replace removes the old
qdisc and grafts a new one.

If a handle is asked and exists, tc replace tries to change the qdisc
in place, for which the kind must be the same.

It does not trigger in all setups, like netdevsim or debian 13, which
do not have root handle 1:. But it is a common root handle.

Solve the bug by first deleting the existing root qdisc if one exists.

Wrap that command in a try block, because it will fail for default
qdiscs with handle 0: with

  "Error: Cannot delete qdisc with handle of zero."

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20260810183118.32d5c06a@kernel.org/
Fixes: ef3d6cca02c8 ("selftests: drv-net: so_txtime: only send test traffic to sch_etf")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/drivers/net/so_txtime.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index 9fbc0278d28b..a097fae0b335 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -12,6 +12,7 @@ import time
 from lib.py import ksft_exit, ksft_run, ksft_variants
 from lib.py import KsftNamedVariant, KsftSkipEx
 from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
+from lib.py import CmdExitFailure
 
 
 def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
@@ -45,6 +46,10 @@ def _qdisc_setup(ifname, qdisc, optargs=""):
     """
     orig = tc(f"qdisc show dev {ifname} root", json=True)[0].get("kind", None)
     defer(tc, f"qdisc replace dev {ifname} root {orig}")
+    try:
+        tc(f"qdisc del dev {ifname} root")
+    except CmdExitFailure:
+        pass
     tc(f"qdisc replace dev {ifname} root handle 1: {qdisc} {optargs}")
 
 
-- 
2.55.0.679.g6767b8d81c-goog


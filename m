Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CE30D41C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208249; cv=none; b=KTsh/IPheKVBqcHRgXD+XJUJbCoPku5YgRR/TQF5Z7DNxIoe5R/5oYInM+ItrlpYx+eYH0mTVQReHGgi5eroxuLkeLve8ocQHOHowrml8ndiJjsNhHnLCCL3RiYbWXSvdI9jSXBdhNgCN2FAbOlx7YXRf5TWzrS3YZFsNBOi7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208249; c=relaxed/simple;
	bh=yhNGWRNzzBA2r+LgfkXCcRNKW2f8IlyOr1yYUTmF9uI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HOq7kEUvDAQkoCSLiHZMtrAX+svNlpZXMVVtF30cf8lzXsCFVWNA4jiN0JvqCw17d9d3zciN/6KuGoifQiN1c5eNuxCIvw68Q5bJ4NEgvaePyg9vTD/mWniwiAQjntZ3C6w0A6zy+reMyOea+5mfrC6lYnmMRNDZX+Ar+vDP6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3UxTfw7; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3UxTfw7"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ec3146553so945774185a.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788208247; x=1788813047; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0wG3nyNBESh8C4kAeVv9EPrhNVRi4/LiTZeA5eveunw=;
        b=M3UxTfw7WwhDftLmTm9kcblXUUvXh/ju0YQ+qoVjkbrpSrSuz7Syn+p328pJ3DAFNj
         iQ6FacTBDejRfPRnMQP8RUMKsv4fdtrG0gA1ZJzDgvj2qa79HMUxfOEZQG1i33uJDpty
         0OTcwUGgzMXJnbCHapOG8BoQ99OrE0S0A7tyYOp2CWE6Hkf5dQ1cDdlpbz99A+3DCMHd
         VFmv1KF1jWOmxwJ8sKpZkOKbafBZ024bKTHKRbpi6ZhZgLGctOZLpBknxbivM2fMqByn
         DbRu95xfsgwK+tyH7h5niLEiGy/lqdpoVMuT7NuBB+8U5DQW2Z6o4chCmbWbI84NBejX
         mHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788208247; x=1788813047;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0wG3nyNBESh8C4kAeVv9EPrhNVRi4/LiTZeA5eveunw=;
        b=YckStHjd+Z2kwP0sky5B9Sfq7puGCMJ+MGWIXLc8okT1csEqMisRBH/RCHFcDKq9P9
         5Xa7rxEzcAsgACaevexChIXGAXcTKuI2603PSXUHB2ZD4WTFK/25l3ltJlGxdTV3wW+I
         aJs3a/ATnlS9Hdn9LKG1CakYemZGzWxFSWu1J0dq9MjS7daMhUc9oSnMbEZcenZWK+Ng
         y6pHgPbbUmn3VuNUzlOX6rsW0Umk0ajelL3kJ5mnReJkM19H7dLuoTYW9N7bgyFuyFcP
         yA8rYEDenzAS0hEJ1MvEKZ8anWIFQKkYfNrQqO+fBxIl7yH3LOkmnGmwp6FEdYOhnnfg
         0LlA==
X-Forwarded-Encrypted: i=1; AHgh+RpEIV7X9XZlICL8EMcKZnnnUESaP/+Boou1Ry0oJhfiBM5z3EInSm1VdQxPrubxYGUO4S7RCk0=@vger.kernel.org
X-Gm-Message-State: AFuF++l1iS40arEDxmJZoOI+8erY2pInCkVYnDsPoYdorG06rkQo1CFq
	pRdaRWPtm9IVxl8lVKp9a7vMn848+iRY1lho4374c1n7V8bmHZDxBhyakSkFg7E11VEHS+BLVX7
	2daMGa2en7o2PSQ==
X-Received: from qknrv15.prod.google.com ([2002:a05:620a:688f:b0:936:d90f:1c69])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:470b:b0:939:49f1:f975 with SMTP id af79cd13be357-93949f2048emr287095085a.43.1788208246539;
 Mon, 31 Aug 2026 13:30:46 -0700 (PDT)
Date: Mon, 31 Aug 2026 20:30:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260831203042.164466-1-edumazet@google.com>
Subject: [PATCH net] bonding: do not clear curr_active_slave prematurely when
 releasing all slaves
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>
Content-Type: text/plain; charset="UTF-8"

When releasing all slaves during bond destruction (all == true),
__bond_release_one() unconditionally clears bond->curr_active_slave to
NULL in every iteration.

If a backup slave is released before the active slave,
bond_alb_deinit_slave() triggers rlb_teach_disabled_mac_on_primary(),
which increments the active slave dev promiscuity counter and sets
bond_info->primary_is_promisc = 1.

Because bond->curr_active_slave was prematurely cleared to NULL when
releasing the backup slave, the subsequent iteration releasing the active
slave evaluates oldcurrent as NULL, so bond_change_active_slave(bond, NULL)
is skipped. Consequently, bond_alb_handle_active_change() is never called
to decrement the promiscuity counter, permanently leaking promiscuous
mode on the physical device after bond teardown.

When oldcurrent == slave, bond_change_active_slave(bond, NULL) already sets
bond->curr_active_slave to NULL. We only need to avoid selecting a new
active slave when all == true. Replace the if (all) branch with
if (!all && oldcurrent == slave).

Fixes: 0896341a44bf ("bonding: fix bond_release_all inconsistencies")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Jay Vosburgh <jv@jvosburgh.net>
---
 drivers/net/bonding/bond_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c23cf18a996a..1e5ab3454872 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2517,9 +2517,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		bond_alb_deinit_slave(bond, slave);
 	}
 
-	if (all) {
-		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
-	} else if (oldcurrent == slave) {
+	if (!all && oldcurrent == slave) {
 		/* Note that we hold RTNL over this sequence, so there
 		 * is no concern that another slave add/remove event
 		 * will interfere.
-- 
2.55.0.970.g62bdec98f9-goog


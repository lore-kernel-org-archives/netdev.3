Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2D3A3812
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473372; cv=none; b=hmJauEcl31SnHse3c6EYsZ6mS2p5MaXjRaW3rFRkvRK/KZRBmq6FcQJMBcJPWkMRj1tDZnP054S7LTXCox0XKdKOD7AqNYZRLtoI7oA6jeXL5ZC/9eWdKaKXjDDYkH/bAEoqYlnEcJPuNSZFJnDsX+nd9rAOQ1Eo1oj4bSXCzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473372; c=relaxed/simple;
	bh=eSbibO+xhCniUvMt1FIWRWvPjNpLGZrzkTdVYCwi9r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtQDTMocKGJjFSi5cx9T/SNMZaLWfZTHsCqmNsdY0honH+qiwAjtz6k4FsNMGPUjIEM5PUnAhZydzxXK2EWPHEyQj2OxvzWjPmLilKljUpiuRy5/3bikhDuDJFDpBvBIwo/44hhbwuwbrUvSjh6dClo2V82fe5OUNyygeny/HzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPeb39/v; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPeb39/v"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc7a269ca1so20415435ad.3
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784473370; x=1785078170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Min+DEzQsYXU48SJanwQaH6Js4T7CtgnWZ/eBINWIyc=;
        b=oPeb39/vmuPz8ATR95oqeqhHqYa1efqgj0nqND11IBU3Eqj528lhyFAl2josHR/GFJ
         1nYLhq8wo2VAFgnbKVPdA4wK7Cvo6/rhi+CFR3b4wEfiFwZk1ylJTNktjDsKX08Mo7fx
         Z5CT7XcMF1aaCc4XBOjUCeoNukSqjUskkuJW8H5WVaylpHazwKrITG6tjwkrHW3YJ6Py
         QuYmB+5egu7V3jdIxrPWKR+slyLDYWyiKwX5HBLfI5+uQOikVsjOPrcEdp2urtfXF4RT
         PdCQKKfD4yrxzzFWbX1YgpaZKkoz3sAyMM0UDqbtWPgAoANvG3a7ovsCU8wqxQ2HNUWA
         ZzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784473370; x=1785078170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Min+DEzQsYXU48SJanwQaH6Js4T7CtgnWZ/eBINWIyc=;
        b=pZjYWy8mXOwAMADt9fBXU+xmMtVr3YVh7JIE/lPzVzhdcxFY0bu/n+8Gg/AW8Psjng
         /9g3zqxgrNxLgRXDi8CPxzOEnT8LfP5llnR1Veh+sBIOjvCC053Md0tMf30z5sjkG5LH
         8SHxcIgQn/8bVDIgCLKtPYIDjmvabkDb01vfLavQwV+Su9ayDzhPwBHJ7riKQPnq3oLQ
         G8h6VO75ejH5f2BtAhicII+c0d5ZbGCUBr5bbGBFR/Uk2a0+Xt4vAZx/dxa6umr5ehDx
         PaPfmc6wb2o1jTeY3dKSZEt/vX/VB2r3qYvPXU58Sy0xjEpLxi093RPzPEUsteCqJnEE
         DQKw==
X-Gm-Message-State: AOJu0YyGV5j1t8rJpajyzdVfxmXCQPLY/dZtBm1JxZrRirB4p3wg/JaC
	5+QglixkFgZ5xPUOaFDM39+lh5GqlIhNH20+LyySHcfdb2mKyMr+ZrYQ
X-Gm-Gg: AfdE7cn79KyU9fk5Fp2rn1ISM6cUtKM/+w6N1neEuiylriPO99SlL/i/a7+GfWqckXx
	WimrSnW4R1IUt03wp+R9qFL+tZ6KXi7z9SFkL0vSM+M6jpfvRJFY+q2UtvFv4FJXVuhMXViJMuZ
	RFFlIuwt89lOymwQQyhpAaR441d72x/YlCh3ykxzvjbnWjGZGJxjQh1BAq/WVvpiLX6++CtljPP
	XgmZKSM+xPv9nlilMO8aqbd5K8X6ueS8W72bJ8+5mzrG0/hOhJ9qNpWBMF2yP9dXbsJH+dbOzTm
	SHbnxo8d3ZX4bSPuKjak2mmpsFc2egIUIaOFZi1E40KEiGG2HqVNKTv6venM5FniIY3FC+hWOLA
	bLfTH81IsDdu42bjFJsxk1wRdWzjSCatJ6l1o/7cFaMXf1vFqUZmrLlUyqpaVhcitXUmIYA+oe1
	SMCtxOSnl5usCGnmO/ghmYTtKxr55a84FXbrhDSpDVg/Z4/Q/NGh6Rkol6NZ0=
X-Received: by 2002:a17:902:ccd1:b0:2ca:d344:7743 with SMTP id d9443c01a7336-2cf34a05d6cmr90369635ad.7.1784473369952;
        Sun, 19 Jul 2026 08:02:49 -0700 (PDT)
Received: from localhost.localdomain ([14.218.106.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9b00sm42198945ad.53.2026.07.19.08.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:02:49 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Robert Olsson <robert.olsson@its.uu.se>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: pktgen: fix proc entry use-after-free
Date: Sun, 19 Jul 2026 22:57:40 +0800
Message-ID: <20260719145740.2888967-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pktgen_change_name() replaces pkt_dev->entry while holding t->if_lock.
pktgen_remove_device() removes the same entry before
_rem_dev_from_if_list() takes that lock.

This allows the following interleaving:

  CPU 0 (NETDEV_CHANGENAME)       CPU 1 (kpktgend)
  if_lock(t)
  proc_remove(pkt_dev->entry)
                                  proc_remove(pkt_dev->entry)
  pkt_dev->entry = proc_create_data(...)
  if_unlock(t)

The kthread can pass the stale proc_dir_entry to proc_remove() after the
rename path has freed it. A reproducer with a widened race window reports:

  BUG: KASAN: slab-use-after-free in proc_remove+0x78/0x80
  Read of size 8 at addr ffff8881478fea70 by task kpktgend_0/67
  Call Trace:
   proc_remove+0x78/0x80
   pktgen_remove_device.isra.0+0x11c/0x4c0
   pktgen_thread_worker+0x1214/0x6bc0
   kthread+0x2c6/0x3b0
  Allocated by task 95:
   __proc_create+0x204/0x790
   proc_create_data+0x72/0xe0
   pktgen_thread_write+0xd61/0x1510
  Freed by task 28:
   kmem_cache_free+0xcb/0x3d0
   proc_free_inode+0x5b/0x80
   rcu_core+0x50a/0x1850
  The buggy address belongs to the object at ffff8881478fea00
   which belongs to the cache proc_dir_entry of size 192

Move proc_remove() into the if_lock-protected list removal helper. Keep it
before list_del_rcu() to preserve the ordering required by add_device().
The rename path must then finish replacing the entry before removal, or
it observes that the device is no longer on the list.

Fixes: 39df232f1a9b ("[PKTGEN]: fix device name handling")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/core/pktgen.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 8e185b318288..ee64f3012321 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3972,6 +3972,7 @@ static void _rem_dev_from_if_list(struct pktgen_thread *t,
 	struct pktgen_dev *p;
 
 	if_lock(t);
+	proc_remove(pkt_dev->entry);
 	list_for_each_safe(q, n, &t->if_list) {
 		p = list_entry(q, struct pktgen_dev, list);
 		if (p == pkt_dev)
@@ -4001,9 +4002,6 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 	 * list to determine if interface already exist, avoid race
 	 * with proc_create_data()
 	 */
-	proc_remove(pkt_dev->entry);
-
-	/* And update the thread if_list */
 	_rem_dev_from_if_list(t, pkt_dev);
 
 #ifdef CONFIG_XFRM
-- 
2.43.0


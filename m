Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D539B94D
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786869879; cv=none; b=rDUCrYSQvoOxJ8j4LRR1z/DSQjGMhL0PPWvloYd78++k55L4CkmK5Tz89YF5AeidPKhrwO8X/TE6+DFpwMZaZc+wQXSXf65Eb7JD4OYsuBBBPONMM7UNWNh8UYTWTtpSBGJ+OB379X4KaKkS72qAvEyoXcZoDm9spaY9rC4JZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786869879; c=relaxed/simple;
	bh=/iYQGGN1R1WhZhfnva0aUcCOm8eZuA3BbF0fIq8U5Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFpCIGsiHzSK1t7PKJDhezvebfnM/wO5I8XLJw3tSbaNRuFl9aYrZtClM3AnYWc0bvCJ184dzk9lU6ddNea8cn8BlQFQkqvDhVvZqME5umCuEHkx/x5B+CZCYo2UGTz9YzHpFAdwxmJnUDVYmweVsohvrOmYfw8T87OTzBKgNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryuh8ryO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryuh8ryO"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so2873046a91.3
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786869868; x=1787474668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CsN4dw8i//8sAzgcBTjU66IDgck2BAt+XziZRHa7kYU=;
        b=ryuh8ryO+dPCCbfw4OROO9rRNdGRSsBRgoeGd8DEwywN80t1uGiQL5xixSdzzWANVp
         KZn+TdRGDbCfaUXGpXIjyEy9o02BlYUq001kRgkFtB+Qquh2OY6z10Y+z7/2a2HV8tOJ
         W5xoyUA80SStwGUxQJlqSzcn6OfqPip4XSIfWy/ibpLQb7hI2+GsN+4RxjRRYtQQSUMT
         zSGCcMk5iryRSRYcpm00al0VzqXrvSLQY+hJujUGwGy5jRBS+bsTi8coNgQezuClh+PW
         5GDrvEMVRDoaZGkTE0MHQiCaAXO49BWb74pAeTET4dnv2d2F4qoGzYdb7+j5ETaCLOIO
         8W1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786869868; x=1787474668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CsN4dw8i//8sAzgcBTjU66IDgck2BAt+XziZRHa7kYU=;
        b=NE9yb27k4L5RkoHDiJYt0bBZudUHEroRofujw7nV+yeD90b1zEhGACdtvU1+bRblMM
         pBG4b/bLUzYZ4BHYDRTc7hQMuN1Xhil6zdw0EpfZqcpat8iWZYqrY+rMH7K48DBhVSnS
         j1C0qJob1lWtIUaBqTf376sdPHgafcA87XLBjAXLO1F+cxgB4JmRFLYPjer38QP9XuBt
         xC5E0Xa/XLYW/WeoqZPsQyGDcAQiqK2BM7TaJPPw5BXWgDU0F+/C3GMMLP5XPAAavngU
         w6I5jCM6jKP/aGVRYNkgSv7sI5csurWoiWED4qJzEmnGWme4EEjIBS+ciiFRJcq7lHiD
         mpLQ==
X-Gm-Message-State: AOJu0YyPPNOdjCg56MLpq8eNr6n0tUbyR44RhJkEMSN6LvFQn0N0ihO8
	eunUkd4LtAj8gjW7QzvS6eHcVXWLeOvuCLAsvm6z6i/CSem6Z1Z5/uoBsk9bTQ==
X-Gm-Gg: AR+sD12u5ULBc972/93tEVpjJtCsN7XeqScYUEjvFa+kaEhjBM+gV3/rH8YNOJP7X35
	UeL8CnOgRmJOyICvj0kZjbNBEv711unSCbejH0tHDopkMig50cOz3HoLdNQ+JRQlEBcvO4cGwkx
	Gt7vN6F11b4AP1PqHQ/iwf3nlcWMpL9B2FEItBPWVBD5mItLZ690GplDnGR/tt7A08ohcllnRut
	lzO6vLhVBEeHXsyYyjvOxCYXz+4Y7JAf2uyt61IAHv/NsN6Ok6xvVMdjxUQ6BcW8QPPiZaQpkRx
	ey4RgPxQXI95CRWNWgbsvrqcRQmmmWfhcbklN8JZVe2HgbKuORszzpz/QIMOYaUDpytEmfeYIJv
	Porb22rB6qZ4mesdoVhXdv8hthh7FywFiza15Ns8tH+VW8K00wOSJky2Me4W9swkfn1MMP/m0M+
	5RMEbjGMWNRpvrH1bHcfW5vNrGNcHoFje5gbUSTtGH2X6nANptGXdcUDIT5cnYW+bO
X-Received: by 2002:a17:90b:2d4c:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-3933ed3fd54mr19739185a91.20.1786869868510;
        Sun, 16 Aug 2026 01:44:28 -0700 (PDT)
Received: from fedora ([2406:3003:2000:232d:8687:63a8:d931:9b81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387e49d3sm28796683c88.7.2026.08.16.01.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 01:44:28 -0700 (PDT)
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
To: netdev@vger.kernel.org
Cc: Wong Boon Jhee <wongboonjhee52@gmail.com>
Subject: [PATCH net v2] net/ncsi: Fix Use-After-Free in NCSI channel and package removal
Date: Sun, 16 Aug 2026 16:44:03 +0800
Message-ID: <20260816084403.295808-1-wongboonjhee52@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In net/ncsi/ncsi-manage.c, ncsi_remove_channel() and
ncsi_remove_package() remove objects from an RCU-protected linked list
using list_del_rcu() and immediately free them using kfree().

Because there is no call to synchronize_rcu() or kfree_rcu(), concurrent
readers traversing these lists under rcu_read_lock() (such as Netlink
dump handlers) can still hold a valid pointer to the object. When kfree()
executes, the reader is left holding a dangling pointer to freed memory,
resulting in a slab-use-after-free.

This patch fixes the issue by replacing kfree() with kfree_rcu(), which
defers the memory freeing until all pre-existing RCU readers have finished
their critical sections. To support this, a struct rcu_head has been
added to struct ncsi_channel, struct ncsi_package, and struct ncsi_dev_priv.

KASAN confirms the freed object belongs to the kmalloc-96 cache, and the
fix completely eliminates the crash.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>

---
Changes in v2:
- Rebased on the latest net tree as requested.
---
 net/ncsi/internal.h    | 2 ++
 net/ncsi/ncsi-manage.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..19785ca2392a 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -239,6 +239,7 @@ struct ncsi_channel {
 	} monitor;
 	struct list_head            node;
 	struct list_head            link;
+	struct rcu_head             rcu; /* RCU cleanup */ 
 };
 
 struct ncsi_package {
@@ -253,6 +254,7 @@ struct ncsi_package {
 	bool                 multi_channel; /* Enable multiple channels  */
 	u32                  channel_whitelist; /* Channels to configure */
 	struct ncsi_channel  *preferred_channel; /* Primary channel      */
+	struct rcu_head      rcu; /* RCU cleanup */ 
 };
 
 struct ncsi_request {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..368085627807 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -263,7 +263,7 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
 	np->channel_num--;
 	spin_unlock_irqrestore(&np->lock, flags);
 
-	kfree(nc);
+	kfree_rcu(nc, rcu);
 }
 
 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
@@ -326,7 +326,7 @@ void ncsi_remove_package(struct ncsi_package *np)
 	ndp->package_num--;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	kfree(np);
+	kfree_rcu(np, rcu);
 }
 
 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
-- 
2.55.0


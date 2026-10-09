Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013601E7C2E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531937; cv=none; b=AAj4E/QdgHn8a/CFD5y0yX1VDfauPLrmsM3su2UJF7S2e37DOesUEWWJ3+4Xexa/wOeGRya6LHkjhiUtwpICAKKLA3YWTLrM3bsYWeAlqyQx7ZBxQVOdYGAw1NHqp1J6gpbocGEV41lMWuIGySZJfs3ZPzD4pFL6Um/W8jBGvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531937; c=relaxed/simple;
	bh=ZwfTSJk9JG0mkL6vUHY4wYZ/zxFnLxRfeSs6ksDOhpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A49AFZjoHYpOWN/u6/JA0xCPhPC1exYuc+JlcqkMDOIAfeftCQp6q4c/j2NEA2+OLtfMF/4hf+5ICQvWAlO+DSkpM+L+bSlmedu9tFlvDu6MyJeezxzAizcJdHuPOaR7CSDeOes7OzuuM7ZFm0IYjGdlwfMQzo7uggsf5UH8djQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S95puc0R; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S95puc0R"
Received: by mail-oo2-f4.google.com with SMTP id 006d021491bc7-6df960a7c6eso2562863eaf.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791531935; x=1792136735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLXuH3kNk2vtVW5LR5Zl+GGZ0SinlHLiZHSL9eCZFA0=;
        b=S95puc0RLtS/vPtRVlKMYhIuNfW7fz6IXJGZYdNEoVXpNvL1b4UA1Jzy3SVRLOK+zE
         En60cMn55v7/hLPqrZR1OSMgcyKd0nyDkmgwXLZ3jT256GRx7R0KngzB9oTl8JG8czTL
         F7F0kekTy47AIPmPFk7EXsBa5Zk9ctd7re0fvFw+23UvCGy7gdyAqLpl8r5T1I9pd95p
         zmN0YSUPGpUAaIjl3xxsyMQY7ETsvQaELoSSEbKlmiIGRos0s50cQsUykbtJmEPjRq0g
         z2l2s+4NAq+8cTLMxN1QD2kAKHlWVzRuPkprNj26MFFd6XRSAxi6PFX5a86fiAPVJpSl
         Hr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531935; x=1792136735;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eLXuH3kNk2vtVW5LR5Zl+GGZ0SinlHLiZHSL9eCZFA0=;
        b=B0bgoLoyaKqnKHIqpGgPji4C00R+8P+E0yNBgPFjucwKwLd23a8Ne/qD8QuQujJzOm
         Ti+h0znHoyRQWNWKUQvzBInLj9fKfIZ2o93Q50PW7kWMewFsm41hGOvhfwPXfqRtorAQ
         NLh7eE3VXHgqM6CpafEso9ioKIVYw0xDgHhf5TjV9kl9WRwEnfMBp5/SppS7n3QuG4SS
         2BAnqr8CrIW1ZA1Q8q7oe71YuPPCF6+CAHuNOxO6URS83q0Rs7dMOEQY9wBjMk4rfGVd
         XAxaehgvZRAfE98JCN3iEtghfTwy0tHlzY78uRYecT7Z45B72qg2BH08XohszCKHyWkR
         e4Uw==
X-Gm-Message-State: AFuF++l86jytAwzj9S6f/1rxNiz9eDbV7Fvs5CSEXqn52//bDR8afccZ
	pnKpkjValK5QvlwBlTqORWrDI6fqXgZAWTeN2SzEuBrOMGFsj3aYz1Cg
X-Gm-Gg: AYBFou02V9sIBgkMBkQWJxiAtbmWZvi77jUm4+B3T1s+NsojZ5tbUAl7z7ed5oGMlxT
	CSuyn5IgGpVxEb+eyNEpWC8QtovgpK95YPUD3OAWAv/lNp+us7bfPH7AALwREkkSr22NPIkenT/
	9p9UuK3uWUNaEg1n/jHj8uOEFIY8CQzMhFwat5BFx2Si3J261uoBnI7PFyF7z30UdlX06EnREi7
	D277seDRiRYojI1Gk5FIVWuqVQyCKnMlwFi9D+g8zMsF37HRt/yTyH+3TAGjNmge+C8GawWThi/
	LR8wkRmfjdIsh8lmHcLDoW8we5hCu1f7TVbo/IJ6Gi0x32WKO8+zQnDHJeDnbgW0h7sflD1BG6e
	fn8R2c1gLVpNgMFMan9f0neJwNLrcxA/VllTDVXHaso1j9qdESSkirLPOQRNCM9Sxvi/stS1xnk
	1M+ok+ogwllUTbAt4v7TIozAphZmQBkFlgR6E2POWRt9l1lpkwTyOlD2xxzVPGs4QQFqYAlUEvV
	i3+Wscd5L1HMgpAChDDBt7eruhKSuTFhlUh
X-Received: by 2002:a05:6820:f004:b0:6c8:d1cc:38a9 with SMTP id 006d021491bc7-6ef08c7a67bmr886377eaf.8.1791531934819;
        Fri, 09 Oct 2026 00:45:34 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef01dba775sm1138539eaf.9.2026.10.09.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 00:45:33 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ipconfig: fix use-after-free of device list after ic_close_devs()
Date: Fri,  9 Oct 2026 15:45:20 +0800
Message-ID: <20261009074523.2747168-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ic_close_devs() kfree()s every ic_device node but leaves the static
ic_first_dev and ic_dev pointers dangling behind.  When a DHCP reply
consists of an OFFER that is never followed by an ACK (a misbehaving
or lossy DHCP server, or a network that drops the ACK), the boot-time
autoconfiguration loop becomes vulnerable:

  1. ic_bootp_recv() accepts the OFFER and records ic_dev = <list
     node> ("We have a winner!" state);
  2. the retransmit round times out in ic_dynamic(), so
     ic_close_devs() frees the whole list — node included;
  3. the dynamic retry path (try_try_again) runs ic_open_devs() and
     ic_dynamic() again; on failure it falls through ic_close_devs()
     once more, where the entry point evaluates

         struct net_device *selected_dev = ic_dev ? ic_dev->dev : NULL;

     — an 8-byte use-after-free read against the freed ic_device.

KASAN confirms (boot-time bootload, no userspace yet):

  BUG: KASAN: slab-use-after-free in ic_close_devs+0x214/0x220
  Read of size 8 by task swapper/0/1
   Call Trace:
    ic_close_devs+0x214/0x220
    ip_auto_config+0x172b/0x34e0
    do_one_initcall+0x9f/0x370
    kernel_init_freeable+0x432/0x760
    kernel_init+0x24/0x1f0
  Allocated by task 1:
    __kmalloc_cache_noprof+0x1b5/0x430 <- ip_auto_config+0x587/0x34e0
    (ic_open_devs' kmalloc_obj of the ic_device list node)
  Freed by task 1:
    kfree+0x166/0x450 <- ic_close_devs+0xcb/0x220
    (ic_close_devs freeing the same node at round end)

NULL both pointers after the free loop so subsequent retry rounds
take the clean empty-list path instead of acting on freed entries.

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ipv4/ipconfig.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 1b8585404a41..ac4851e59c3b 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -346,6 +346,13 @@ static void __init ic_close_devs(void)
 		kfree(d);
 	}
 	rtnl_unlock();
+
+	/* The whole ic_device list was just kfree()'d above; clear the
+	 * static pointers so retry rounds (e.g. dynamic retry after an
+	 * OFFER without ACK) don't dereference them (use-after-free).
+	 */
+	ic_first_dev = NULL;
+	ic_dev = NULL;
 }

 /*
--
2.43.7


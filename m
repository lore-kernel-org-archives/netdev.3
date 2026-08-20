Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD574345736
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191660; cv=none; b=cjjBt/kpK+EtmP+P78P0ojRjrbtK68NCK9cDTykFF0n+kAXRmRHDEAWrgE/qZJFAFYmGRakkorAyjciBxXOIURgI+iNlRKHb1inJ5ID43CHFYPOPBbMISVdiikDK9+Gb69e6YWZljBNU+1B2xMNQR60NLdmUBVJaqYcPrTWnGTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191660; c=relaxed/simple;
	bh=8z7PVI42mn2WVqzNpbyIUg7oPZyfo6P99lqt+Em5bE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MN8rURIBlFqsvCIpkhoul+9pMY1adio4OXbIdAz4SZ+HglJwvwN8OkOek1UJxZncMdkGLUE7rQYRhOkQAYz6/GzYhmhA/0WsTtWJuRHHXLYNHnYffizjO7ye+RUUQlM5oHKHVBp3T46ZYZ1D/qOBUIc4/7kpMQdnMmsArUzE9vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXj5fepF; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXj5fepF"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-836ccf53ef9so19190937b3.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 19:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787191658; x=1787796458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZXALN7AqQrJoBL0yRkSadiom91oJHrBe491klEQ3M8=;
        b=EXj5fepFZ0XIiP7aJYyAeZg8LCrmH4ZXTKPfDxcX0Xt423JxeWkpX5t9wYeOnnQYCt
         8c36euVlPc7kjLiEqmlWHeJZ2UNi6z8Busqad7vS1MFVdxpUVXUu1SDm1apdvs2LB2pU
         M1rxb14+ySq3kxRfpzrOlRKgzbZAHOL1h6zTxkgEalg74O9qb3m9FQ2QvtRP/B5kaivm
         2lgcq1PGWKD0qF16dqNgCDdxkll7thg2yEIqysbQRd6r1jAks87NslifdO5JOBSWGX7t
         zcGkTdu0oty8/yrmMzO/ntnVzmPpuz+VTSJfV+B6xd4wJunv5UZkt/gIK/KadFurxifN
         CmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787191658; x=1787796458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZXALN7AqQrJoBL0yRkSadiom91oJHrBe491klEQ3M8=;
        b=ZfmluC6/0c8SOtrGJ9e8zX+HTWvQKGF4IcJh/c7+XpWzalUL98R+W1t3Fdr/a+jOFk
         3TSowgzB+fiXvGcaxTbLpOuDs3UGFlhuWAvz75eiDcDVDOYTOJtwPwQytQW52NzB7US1
         rOzRIl788brGm7nQluoVHYdx8zHrK+YkuYLa5H5mh42FvumU6NB3p37bHgpfIxQtlt29
         /u5ats6ZY9sn4cagTDTwYqYhaOZ9Gv6RQqlogDlcS3lHDU9MZXB6uK8LFnZml3dOBoFP
         aIelrhBey9g/LdNIT+07lCJ9LhLH7XMCUwG8ilQsk7yGZk838ibl2KHtWA1tIm4wD7Jf
         93Qg==
X-Forwarded-Encrypted: i=1; AHgh+RpqIZ8l24UdqInlDIVQWN14ta78VjOItvQVEkJlYShi/39KEBi2cD2rAYww7YME8TblnDQNAQM=@vger.kernel.org
X-Gm-Message-State: AFuF++kaYWhadxDuTbO10bdpSGAYSzf6yQnRjaDkbBKpwxOnD8xYrnf5
	l1d1I+qJIRIXiWvX1tK2wGcON5+bUiqym6PaTvE1eTJAvpREczGrGma/
X-Gm-Gg: AR+sD11PoCLLs37s6WKzS8lUw616wwgNehdIidkWZ4tyzlbNFrwRUxOxK4BHYOvwUOm
	3FcsRVV2An8kv+pmSxvOY9J6Ct24h38EO4qjRhdc3mtLhs+V2d0vLeWlDuttRUmNWgZ6NkA/veu
	VepdJSN/FSErZmsWAnGIhrrPQLk3jdXXNuqmhVorEcz9JoeWYa34F7dN/qFo02rzJY0aorAL2fL
	VocHC3Yaremkyvc4yqXLAW5INN+UlaVnwvwwNa8UE1ik64fLd4e2Qr7aNAJXYdF+VcbfX51o9xa
	srU3FE60R1Zaq5uahrDbdZkjfN6elW8t/2F0r7qx1X2kKl/QvD8VCZzUrV/zT7qKwbyOavRbX/q
	4nkLPGOEFoA1hJbK+Ej+EKbHbpFWRfR3UcfRdN9MrE4uGxy0gbmLmmMPVcjbiFU5cI7EBerDUwd
	xK4HqkW5qpvhCYISjMnDk0YDs8qkRXGcQbL6qdhi1FO5dqfQC8o7f5+U1IZEV0n2WGJaMi1Q81Q
	UWgaQ==
X-Received: by 2002:a05:690c:660c:b0:81e:8e36:e98c with SMTP id 00721157ae682-844dc78ba17mr39333887b3.0.1787191657676;
        Wed, 19 Aug 2026 19:07:37 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-847ccd8b6cbsm2169427b3.27.2026.08.19.19.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:07:37 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: pablo@netfilter.org,
	laforge@gnumonks.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2] gtp: add synchronize_net() in gtp_newlink() error path to prevent use-after-free
Date: Wed, 19 Aug 2026 22:07:35 -0400
Message-ID: <20260820020735.59474-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gtp_newlink()'s error path frees tid_hash and addr_hash without
waiting for an RCU grace period after clearing sk_user_data. A
concurrent gtp_encap_recv() in softirq may still hold the gtp_dev
pointer obtained via rcu_dereference_sk_user_data() and access the
freed memory.

  BUG: KASAN: slab-use-after-free in gtp0_pdp_find+0x1f6/0x200 (gtp.c:152)
  Call Trace:
   <IRQ>
   gtp0_pdp_find+0x1f6/0x200
   gtp_encap_recv+0x527/0x24b0
   udp_queue_rcv_one_skb+0x75f/0xc10

Add synchronize_net() before the kfree calls in out_hashtable, which
covers all error paths from both gtp_encap_enable() and
gtp_create_sockets().

Fixes: 459aa660eb1d8ce6 ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2: Add the net tree subject prefix.

 drivers/net/gtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9a12cc53da00..f11bcc0c0ac4 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1543,6 +1543,8 @@ static int gtp_newlink(struct net_device *dev,
 out_encap:
 	gtp_encap_disable(gtp);
 out_hashtable:
+	/* Wait for RCU readers that may still reference this gtp_dev. */
+	synchronize_net();
 	kfree(gtp->addr_hash);
 	kfree(gtp->tid_hash);
 	return err;
-- 
2.52.0

Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFB33F5BF
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756147; cv=none; b=BWULYElsgt7zrKP0u8JX6lQs1sezsvOMGdo2gGGCSKJ3e9Iqrn0deXPc18vQi294agb1sPRJU6ZjNbLvZ2/Y4uAR+pPxMNGBAMtCHCz493S94YJCRGjE96adlpcTt4bYurmnd0i4oWIiKK294sh2dXMv7qoyJUH+LL9VUrVa0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756147; c=relaxed/simple;
	bh=6W557xLqArdcWkiDohCtb/I4i/bar7082VzDh3qj+dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoTiJrCP1vEo4ZzUW5MhfIgdRBD580LJusfKlTbXjz5skUbsVGevYDCiZXnXLC1iecDZzasYxcEn+tQADdWjO8NSergwRDQ/WWiOD21ZPV1sCGghzFCnJt/DzS5uO+n1r60P+6DpJ39fCCmMgEvuUm9WjCEGL/KauR5JhmdT6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=siD1nIt8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="siD1nIt8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2387790a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 04:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785756146; x=1786360946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fb0OHOarD05M63m15hKJQKilUjti/YDZmt0StI1IroM=;
        b=siD1nIt8cdGa+dqzjV1yWR7FdUNkzFy+EVKbZcQ9S1hKIQ8z8V2RMslyUIfH1a/g/3
         hB+DhlMJM9ddtOYNTDj3m3SzLzg62RMEsdg31CwuXY16o5Zd26avB6TzfNLpSYbqmyGV
         1bBErLAHTOZ2TeRFQlLzXlvLJOtsiM+VGmx2h/pJMyyjnvKmE0pIgLDcaSE4X9RF3gQ2
         XIVZSpR5EdX6CgysRhAVdirBPxRD/Et9K4q4CU0hfEZnZlFLLrcfqXBosbZRhyANHGiA
         zDR5u7BEw5HVXJxNxx8/2ivup5IqsQV7VdZwtLy75twjnx38mWG6bP1NEAD6n6CNpN+b
         fjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756146; x=1786360946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fb0OHOarD05M63m15hKJQKilUjti/YDZmt0StI1IroM=;
        b=Ide3Tfa4cBnmqPNHLeL5Sgn3xLqx0fW7buAWJ7OEwXy0XBMKPH7zx1KzCja+0ZEkHD
         WSZzM2F26/QZh5RZnzpS/H2NqcQfct6/TBI7aKGdDK+ZORSOk+Jh+XkeaNv8jTriI6ow
         vodtobfXrXlP1PTBkw4C3r56e4oQ0atz2D9pipwMVTr89RnkuoVs7jEZTwF5zsIh3XsH
         iTp+Zyd3B5DOg8EQ0SxHWcnfQD0p8bikFBh3fmFhwxK5B7KJwQ/NAtAGfa6M+ZsTXQKx
         xacY9z2fpzU4oD5C3H/lK08fT8W1mE97x87viPRTddiWQGUt4+w9a630VCOue0LL1GiI
         GcuA==
X-Gm-Message-State: AOJu0Yz1d5FWln8bozzW5eRggDE1WaUkux7H5ppv0vpKMguazYiyGVOJ
	FIKCHHnyMvohdBT5YI1W2Ucy1DVjQncMd5805BmzyDnmp2m1VNjL317V61bfrqm2LV6rSf3ATmi
	kt/TdZt6J3a2FiQ==
X-Gm-Gg: AR+sD11kBpy6ZnyDwgTq662agTd5u+yeSLj2E60mn1ODoipWgGMSl+8OQul0EM0E2YC
	4ZtLrQY3/W07Ex0zQIps9gnCOE2t5EA9uqwu8wyHpmH2BxS9SEpwoxBoudZjGADOoGVcHi2Mw8q
	mwKbhZE7nzOHAlf1LISvHuQWsfoRZ+GegYW/aJVDaJNJxjixoS878p5e921oGbuiZjS1ouPZZf6
	CvfNBSfia6cG36UrhPMW1ldrgumdPG/hnJcRksA13RBwMczSlenMJ+5wPZRpuBnLX6L1rKS+f7A
	VxNJzf/3W5YU81wBf5JM26/i5voUkRm3N8MaxNo0zdMLlM04xaJypLr1kRydJLJWNBcWH3IBqdi
	JSaG4OnaiNpvCFHZm+ST/2M07iCY8dDqPyo2p4dGxBvUUe5Rjb189nJKCTEo2dKXjhpP9r5LdO1
	9BZ9icxDwwB6Bdpgmb7viyG5Ei2y2H/EsZOybLaTSjqSniA4wqCTs0kcndfzkqg7gLiZDM5vM74
	HmNB+2uWsIrUNo5
X-Received: by 2002:a17:90b:1c91:b0:387:e0db:bc26 with SMTP id 98e67ed59e1d1-38fbc538106mr8171330a91.38.1785756145496;
        Mon, 03 Aug 2026 04:22:25 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2964c10sm3788309a91.4.2026.08.03.04.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:22:24 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] ipv6: flowlabel: enforce the per-socket lease cap on reused labels
Date: Mon,  3 Aug 2026 19:22:04 +0800
Message-ID: <cf4fdc79ae4dc46bd4eb7eeb57e5de2091c13cd3.1785746178.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785746178.git.zhilinz@nebusec.ai>
References: <cover.1785746178.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_flowlabel_get() lets a socket reacquire an existing flowlabel and
link another ipv6_fl_socklist entry through the recheck path.

mem_check() only counts socket leases after fl_size falls below
FL_MAX_SIZE - FL_MAX_PER_SOCK. Reusing an existing flowlabel does not
increase fl_size, so duplicate GET requests can keep taking the
recheck path and grow one socket's lease list without ever hitting the
FL_MAX_PER_SOCK limit.

Check the current socket lease count before linking a reused
flowlabel. This keeps the duplicate-acquisition path consistent with
the long-standing per-socket cap without changing the global budget
logic for new flowlabels.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv6/ip6_flowlabel.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 1ab5ad0dcf24f..e295f85bcc604 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -493,6 +493,24 @@ static int mem_check(struct sock *sk)
 	return 0;
 }
 
+static int mem_check_dup(struct sock *sk)
+{
+	struct ipv6_fl_socklist *sfl;
+	int count = 0;
+
+	lockdep_assert_held(&ip6_fl_lock);
+
+	rcu_read_lock();
+	for_each_sk_fl_rcu(sk, sfl)
+		count++;
+	rcu_read_unlock();
+
+	if (count >= FL_MAX_PER_SOCK && !capable(CAP_NET_ADMIN))
+		return -ENOBUFS;
+
+	return 0;
+}
+
 static inline void fl_link(struct sock *sk, struct ipv6_fl_socklist *sfl,
 			   struct ip6_flowlabel *fl)
 {
@@ -679,10 +697,17 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			err = -ENOMEM;
 			if (!sfl1)
 				goto release;
-			if (fl->linger > fl1->linger)
-				fl1->linger = fl->linger;
-			if ((long)(fl->expires - fl1->expires) > 0)
-				fl1->expires = fl->expires;
+			spin_lock_bh(&ip6_fl_lock);
+			err = mem_check_dup(sk);
+			if (err == 0) {
+				if (fl->linger > fl1->linger)
+					fl1->linger = fl->linger;
+				if ((long)(fl->expires - fl1->expires) > 0)
+					fl1->expires = fl->expires;
+			}
+			spin_unlock_bh(&ip6_fl_lock);
+			if (err != 0)
+				goto release;
 			fl_link(sk, sfl1, fl1);
 			fl_free(fl);
 			return 0;
-- 
2.43.0


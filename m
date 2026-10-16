Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56D27A462
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131010; cv=none; b=VKSqTJmMTTwvTf6XNOzh/T5Sf8KVXw6xBUdxdPPjybITmbDThlkSD7iWFDgSgNd98FsJ7nmVQEfu+49HpgWkdt+OUBmH+YoUgHHIsF2k5MBP/Zdow2Fdoo/bGsauRyCAYEwMwbtmU2GK/wS7zIbquiesIhFlIyQom7+Z1PjC9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131010; c=relaxed/simple;
	bh=oBBEDYoVBZtuJY69FsKWBiD2DNZT5QEbmq45iuoyTxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QipMb7JKKiaA8GYeSfszpJozfLh4ysm+4TGU1HrZK9PJFg5aGc15sw+oSGf1isZ0LdZ2btJPMkze/SpdurAZIK129ayTywXuVmo2oG715YwZpxt/Hx9VwdXR79+Lzs8GBIh3ny8leVdI2bkGrFF5bmuKu6ivKoNlKq3Cnxv5cR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8TCKSoE; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8TCKSoE"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35ef6b49813so3494277eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131009; x=1792735809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBPraKpKQkaoyQ92vsNpEY13vYFcSFQS5byJNd4kDPo=;
        b=Y8TCKSoEKYgQjhLixSqPqs7pOkTVmevaUa/BXKKCDrTVWa38JLBMKNupdMymTOD+Ti
         Ut+lybLYlpdpoZHgzBUaWKNAu5OvcqmNYCiuliOVHbm2UIJMZ8rlzPmVxO2xUC7hkI/T
         Kd1J3q80RCweQcskBDCbLJJrbqY6NhyI34bAKrJ6OPBfrK9mLAFG+2QkciMHXY/+GEtX
         KA+/gQtr7Dpf4gxLt9y2aMeEUdASO6OsTwOvFTojQixbwuQmGHavvwzWkk7hDl29HvNF
         Ez8DxBRWI7lXwVsyP4oly6JTU8axj0THbTOhAA1IvghL0XZvxGheq/eU5nn0JqjlW7C9
         MBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131009; x=1792735809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBPraKpKQkaoyQ92vsNpEY13vYFcSFQS5byJNd4kDPo=;
        b=hXFqcf6i2rSy8IQas4JWWtAOIwnjgNcbGdXrE8tIV0ztrTHHOFJakji2C/XpMOaW4j
         mqZ/aTIHRodOou7o2teuQW4SncfQRLkJDBhHdgE5mTeAw+jlPpLqa29Sb/e8n9Nj2yw2
         aNcxonUUsuiyIXCJRJQTXzRuZFWZWglSnpGtMjsiorMsA1JZbACiAKF87w+3rUH3KSYe
         1un6T2O0McYkeA73CGnYIM/C7YosDRqhcGXpyuCjsd2rlQoVIE2et0PJkUsn3speP1wd
         AGd67UxDKPJgtfuWsDUEWMpcu842bMytYQ+cnNlC88+dKJ9T2QL1OKtAc3NnlWRRMFsQ
         sZvg==
X-Forwarded-Encrypted: i=1; AKwUvBxyD24KIYFnF56Gs/1i3UuwLF5BSdkJJkyUhYY7EsV0cFskkT/lXVXxtm3jGqVhSW/wE18M0s4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJp5y2Qnf4svZqPYu8PwHo2C6NkH0QRB1EHe2M/5SaTzOpWTAeE
	OL1iaIacncLD+cUTnfaSOjulJ3oP7zFONunuZYzRu9Xe494GqC/m2c+y
X-Gm-Gg: AYBFou0qQhQePazR/s5JxFL4MnbhLtwYALxGGhVRM9AJbyCYfy0Hhkyyyg+XdfAWB0E
	h7jNThneWL1Adbk4w0MJYBFl6+1As/vNzL6NSVz4MA3q9/YV8BmUks8gRA0N+m0ygTuGqhpWlDv
	zV8bdQmWq5cZKuUJ9eedf9T/aJnyb47G+UCPPH/G8gltwUlp3bjfJHBhFslh/hex7xTxZakmCdD
	wMqlAZi1hoEq3LyucZv/mtyvvyuaXv60j3RKqerURHzbj4BR/zOKZR7YUl+9BCjpvnlwY8yFMBd
	2UNI0FCxKWQewT+SWblkHpM2NiogB9VsxXYgZSCXRLHn3zpkiBd1dj1UEGLt9XzlLJCT/KhLGmA
	EKUQABldu3d6b6lCUHhW40+Ok+/kF74Tpin0TATZkoMHU5cx3Gf0gGE3ENVWpKrNzDdNgBu0uDj
	ZLvWCbKTneBJYryf9/qRxymMcwqhqQg8oqVIVJRU9eKNaluS3Oid9TIY6H82EIEj4TgWA=
X-Received: by 2002:a05:7022:b052:20b0:152:9e88:daaa with SMTP id a92af1059eb24-16a62eaad21mr31386939c88.36.1792131008661;
        Thu, 15 Oct 2026 23:10:08 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm3309068c88.4.2026.10.15.23.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:10:07 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 16 Oct 2026 14:09:54 +0800
Subject: [PATCH net-next 2/3] ipv6: take fib6_sernum from a sequence shared
 by all netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-bug-net-netns-move-rcu-barrier-v1-2-4157d798658f@gmail.com>
References: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
In-Reply-To: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

A per-cpu IPv6 route of a nexthop object records fib6_sernum of the
netns it was created in, and rt6_is_valid() compares it with fib6_sernum
of the netns its device belongs to when the route is checked. Every netns
starts its fib6_sernum at 1 and increments it on each tree change, so
different netns often hold the same value.

When a device moves to another netns, such a route remains usable until
nexthop_free_rcu() releases it, and fib6_info_destroy_rcu() queues that
callback from inside an RCU callback, after the device has moved. If the
fib6_sernum of the new netns matches the cached one in that window,
ip6_dst_check() accepts the route and a socket in the old netns keeps
sending through a device that now belongs to another netns.

Take every fib6_sernum, including the initial one, from one global
sequence, so that a cached route never matches the fib6_sernum of
another netns.

A connected UDP socket in netns A caches a route through an IPv6 nexthop
object on a veth. The veth is moved to netns B and brought up with one
RTM_NEWLINK, then the socket sends 200000 datagrams. A route is added
to and removed from B 0 to 20 times before the move, 63 trials:

                                before     after
  trials sending after move          3         0
  datagrams sent after move       8187         0

Fixes: 8f34e53b60b3 ("ipv6: Use global sernum for dst validation with nexthop objects")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 net/ipv6/af_inet6.c |  1 -
 net/ipv6/ip6_fib.c  | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index a9b8b4b42a1af..db4cccfdc565c 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -945,7 +945,6 @@ static int __net_init inet6_net_init(struct net *net)
 	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
 	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
 	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
-	atomic_set(&net->ipv6.fib6_sernum, 1);
 
 	net->ipv6.sysctl.ioam6_id = IOAM6_DEFAULT_ID;
 	net->ipv6.sysctl.ioam6_id_wide = IOAM6_DEFAULT_ID_WIDE;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 0dc6ebee6e568..c66466be64451 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -89,13 +89,21 @@ static void fib6_walker_unlink(struct net *net, struct fib6_walker *w)
 	write_unlock_bh(&net->ipv6.fib6_walker_lock);
 }
 
+/*
+ * Draw every fib6_sernum from one sequence shared by all netns, so that a
+ * route cached against one netns never matches the sernum of another one,
+ * e.g. after its device moved.
+ */
+static atomic_t fib6_sernum_seq;
+
 static int fib6_new_sernum(struct net *net)
 {
-	int new, old = atomic_read(&net->ipv6.fib6_sernum);
+	int new, old = atomic_read(&fib6_sernum_seq);
 
 	do {
 		new = old < INT_MAX ? old + 1 : 1;
-	} while (!atomic_try_cmpxchg(&net->ipv6.fib6_sernum, &old, new));
+	} while (!atomic_try_cmpxchg(&fib6_sernum_seq, &old, new));
+	atomic_set(&net->ipv6.fib6_sernum, new);
 
 	return new;
 }
@@ -2466,6 +2474,8 @@ static int __net_init fib6_net_init(struct net *net)
 	size_t size = sizeof(struct hlist_head) * FIB6_TABLE_HASHSZ;
 	int err;
 
+	fib6_new_sernum(net);
+
 	err = fib6_notifier_init(net);
 	if (err)
 		return err;

-- 
2.43.0


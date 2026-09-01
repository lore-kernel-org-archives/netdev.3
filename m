Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763144B681
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298796; cv=none; b=IzlvGUyXwh//F5cAW75Lhk3Uj8hYsCYjqui96QgB9yhWX1Yqn6W9LL8lQzdAX6MkEBaA+Un1Zc2ac7mIf0733WEcMKyt/GLCttoVqEX0r/6lwZ8jJ5HVWU9vs+HXju7go2tRrYqHf8Sv6mHLQ2F7EbPKnX062vjpvI0p+KsZzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298796; c=relaxed/simple;
	bh=fEqpX1YFlaG71dlgtvG5gHc3G+sioNJbj80LXeaOzv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfQy3cRmx5e9FfMl2AG2Pmxgtz8oBpCW+x19xt5KkDitaEjaq6HtRvEtV7hGKwa5lWjyySgyvVYygnFR9fxWbFAyL3N6cfMobCYds0Anb0oy9DNbqbJqW4bDPZb9wYUDx2wmV1nULKkw43tcoibpDcEIB0+9exdEVaCdbjzInzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=scueyMvf; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="scueyMvf"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90cca401c89so4031296d6.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298794; x=1788903594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iIbELkdmTGo5vcok3ZLUE0b3wWbCoKDIr/HpB+ZPAzc=;
        b=scueyMvf/7NxpMz9WO2obBx0OKO0oWdpQl1qI7bYUaBNuDwyH3byg4OrN3hiCy9NOB
         8PQYRd+JZPzRYNr0ZuJ6ReEOiwDbEhivnYQHSj+xcXg8/pEuHkxJIl/eDJvoDZzyAWBb
         vjl/lE26lPpMCguPGfjIQAwc8Ob/5ouG4Bu48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298794; x=1788903594;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iIbELkdmTGo5vcok3ZLUE0b3wWbCoKDIr/HpB+ZPAzc=;
        b=K4sWihXd3HRqt2KlU1AoSSZSmotAh0SJLX/AtywP/QvA4KSjJ2kALHNFx+mK0IR+jd
         Yz255EqKP8g0+qSJRzfygdJslEdSt7om+cG8d7clxxiwyJzJFbX1xcPfs+cSmY/c+vks
         dE+WuJqR11Yc295xVm0UxTQrtc7/i84nMO3JVyAJy/es+31TMFA6AR0shP7YG3GriN3V
         21tuvUlBAz2rs3qp7+k06JgGH9reZYjP0u5ug4FFB/4MspKE/lkFTsOtkolP5Rd81Y2l
         /dF9BlZfvtouJ9X5qGqUHDrIv6eG9qm3UZZiXmOEAKJWOhCx0MmjLz85kaPsEpIRpnt0
         AslQ==
X-Gm-Message-State: AFuF++nfnMsJ7ZjFVl1dpRfQioBKdcRA4sJOqAH9MAr/zsFWl3ztvGtm
	sp9wFJ+5MPkkebmwYvQx4tMbu8s/TdbxBfjKOzyD1pE0owmjj3p4zI66x/zTqYKXPzVDArHI+hv
	VUcHBCQ==
X-Gm-Gg: AR+sD10NeucGum6IZwdE+LsVC8W9ENRgQn6Hd1jZtDTVjjfvZ5C2L/4q6SvutaV2Q3f
	Fl82i7LZLtR/abx32I6OyO/Zmzmg7uMjrMwybFuVnvH3zuv1pQ94xFhji/RIx2lJHUQtJD6OR7D
	I13M3XcPxMAVYhYRhlSv8ZVNZHnqVwqfasmwKLx6JUkiLIkWygqHTVAWu55a4E38IK6AZl+TH4K
	LBUiFhfeL8fQ7fazVGzc6oLdkNwgXRXb82eHOF9Q7qsMe0BlPaETu6Er1elug296tmveSmfG8PC
	ss8mkVKL3yoKvjij9JSXHWFEHVTK5OcGlYnCHhqrgFExTUxBCJ/7bZh/ocMd5RIK8794lVn3Ud9
	W1DWXOzLnlBJj25i8QvHrO0s28R6/vE/d8xYqA0gAFBCgRtd2lUFPmgMBjPNKIT5YI28WFFvE2d
	RDocSAUuYM1fv/s6Zq5/vhgzfH3+G7gQtMeG0WHdtujspdvmz/BYAqxXsMW6PAWuEWpTC8xGp5Y
	ZU/pTmkVrDaNWk3vi6uaB77LRk6rsBWzUksQA==
X-Received: by 2002:ad4:5f07:0:b0:90c:e3a5:3aab with SMTP id 6a1803df08f44-90ebabc8189mr9945016d6.26.1788298794060;
        Tue, 01 Sep 2026 14:39:54 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:52 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net v3 5/9] net/sched: dualpi2: clamp psched_mtu at all call sites
Date: Tue,  1 Sep 2026 17:39:26 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.6>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

dualpi2_calculate_c_protection(), must_drop(), and get_memory_limit()
call psched_mtu() with no clamp. A huge MTU makes (s32)psched_mtu()
overflow in the signed multiply for c_protection_init, and 2 *
psched_mtu() wraps in get_memory_limit(). With a crafted size table
qdisc_pkt_len reaches ~2 GiB, causing a soft lockup / denial of service.

Clamp psched_mtu() to [1, 1<<20] at all three call sites.

Conditions to recreate the bug:
  CONFIG_NET_SCH_DUALPI2=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root dualpi2
  tc qdisc change dev dummy0 root dualpi2 stab data 32768 size_log 15 cell_log 0

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_dualpi2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4f678d4ff10e..4947def7c49e 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -208,9 +208,11 @@ static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
 static void dualpi2_calculate_c_protection(struct Qdisc *sch,
 					   struct dualpi2_sched_data *q, u32 wc)
 {
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
+
 	q->c_protection_wc = wc;
 	q->c_protection_wl = MAX_WC - wc;
-	q->c_protection_init = (s32)psched_mtu(qdisc_dev(sch)) *
+	q->c_protection_init = (s32)mtu *
 		((int)q->c_protection_wc - (int)q->c_protection_wl);
 	dualpi2_reset_c_protection(q);
 }
@@ -285,8 +287,9 @@ static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
 	u64 local_l_prob;
 	bool overload;
 	u32 prob;
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 
-	if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
+	if (sch->qstats.backlog < 2 * mtu)
 		return false;
 
 	prob = READ_ONCE(q->pi2_prob);
@@ -712,7 +715,8 @@ static u32 get_memory_limit(struct Qdisc *sch, u32 limit)
 	/* Apply rule of thumb, i.e., doubling the packet length,
 	 * to further include per packet overhead in memory_limit.
 	 */
-	u64 memlim = mul_u32_u32(limit, 2 * psched_mtu(qdisc_dev(sch)));
+	u64 memlim = mul_u32_u32(limit, 2 * clamp_t(u32, psched_mtu(qdisc_dev(sch)),
+						     1, 1 << 20));
 
 	if (upper_32_bits(memlim))
 		return U32_MAX;
-- 
2.43.0


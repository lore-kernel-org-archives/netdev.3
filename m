Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71532D43C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521746; cv=none; b=CS7bpp7SKbUi+MiF74vCZeJkE9/3jCDuXXkXOCvT3wOlT1w2hr7pQqiDeUbNFQ1HaW+vLiH42yfmFmMBq9jzNhb270ops18bB/3hibtCZLfbtbVubMUaIfV2f5QBjWgUHEAhDeskJ+6TAwymnhkU078ZETujWrBoQhe1kAnhjUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521746; c=relaxed/simple;
	bh=5ZFXptKAxo1rTLpbIpgH6vO1joQz/kZ6CYrxrQfA61I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjjPPfM4sEwKz/raQCnSgkZg7eAAmvdfuRkyW8uj0cUcnRco7jAEIvrveWGpoXBodxhdJmL7QAH6GJatPxO1vEVx3jGq7rn817LmSstRLK05oKV7CP922iXtE20XEiEDfz9GX/75Y4GGPzPy4ckfp9YAh8QiXw6zLOLC+McLjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3yjBvvo; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3yjBvvo"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so869614a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521745; x=1787126545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tPoa6C0hj4HZJwKUSXTCx+irT5h4iMOM05qfW4+AIP0=;
        b=i3yjBvvoZdYfm7zYgKIzQt2ansYD/YAhtp9Gw/FMkFBODSriHyPohBWSZX+xspperH
         fzDNALcjCW2y+AjTkkES1LTwaEP7rzJcvFsZmUwrlSddMisD9fDi1AWuBA9dAeEz5Fb7
         YPB20+OcEHROMRzXvdwvUsQNPXoCew3siz1gT5qtIrYjGOrUTPzWmpd0/NclpWynqudh
         NrES/eEKVZp/b7dq7pvPRhM/iDNkSB7mLNnMtmLRlpE7uzpqoEefOWa3lhqJMbSX+BUo
         qhxaiZ7pFpFMI536cvpk8fpLD/flr5uyR171iPcdBYzvbC22RdIttdU6sXWLsJUsORpD
         ujTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521745; x=1787126545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tPoa6C0hj4HZJwKUSXTCx+irT5h4iMOM05qfW4+AIP0=;
        b=OkWWuH0O7VFLqa/oZu44crJBr8iOGBVE6e8tCtE5nYXVtfoPVjrrv5ten4ftC+Bxym
         gRKA7cmg/CvlqgUQEe5XO1yoOt62GeGwn0bWMllRTm/rrnH5qDKj9epKra+Ig8IkZkqN
         JUQK7HGWNMMhalTDUc7svOUHf0CPNRQsNLZEjXdbCSH0VyOXYLybnsk/PzSf0HzwEaog
         /iYGhO3xlnzi2PgEHuqT7y6AIQBQTXCozDw6gDp0zSWsFpBiKRkPkE+eU0OLoT3/LPGW
         QYPeNjOziOUC7aoxNiBBJ6Ppxqj5/BGhRzia3VHQ1zG5JwhcOURBfK+Q6ERtbmW4U6Su
         x3Xw==
X-Gm-Message-State: AOJu0YxfIP8wIu5SFVp1ZUWJVK/5tDpi1ul8tAkCoyxvEb7vhvzgqgME
	wxjZYG0KAPp1nD0EikbWvjjkOFDQbXYbkBm0m313pM9lBsAlDsy7YrZFsf3Jsy0Y
X-Gm-Gg: AR+sD13tb0DmG5VFmyo1qZjz7+QAktwhLS12ODq15HowdRe7PGyEsvYzA1a+LMWqbHq
	zQ93W06fci2MvGDUCU02oPkLDCdrlvIvYwOXJbOEcsGzyR3r96r6V+NvAPaVmWhkeN4IpA/kji2
	LMbIEtz7nSPFtaxXAvQ+eTL9CDTbN052WBWSO+JWZHHqowdy3cHQ6ZAVJVA5J75v2vRA2/iJKr/
	BZ3w5wVtHZprgEPZqkH7/qmn7Sb/DvOTfihrDR1JOxGcVelyvRc+MGtBIwMee3ai8Qjbtwxc1pp
	6vSzljATD+riizfSD0wqyJt4knqibP7inM26OpMXdEvmPG2djjkdgZvQD9w8Vw2uK+FK6ej8NS/
	NXABq22/TmuNOceNSkiln4FqV/YIk09Q1LoBEqQvgYRvvaZzYtEISt22qzVJMAy9KWHg576/lzE
	n70j2Wg+wyuYSncFGIYNsl97SPF/71uNYa/ukJYWFXkRAbyvESEvraRfGJfZ5PN+A/Rt6+Osdd
X-Received: by 2002:a17:90b:384f:b0:37c:6130:7a5b with SMTP id 98e67ed59e1d1-39301244f91mr2956794a91.8.1786521744856;
        Wed, 12 Aug 2026 01:02:24 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f908a82bsm2629752a91.0.2026.08.12.01.02.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 01:02:24 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jack Wang <163wangjack@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>,
	Elena Salomatkina <esalomatkina@ispras.ru>
Subject: [PATCH net v2] net/sched: cbs: perform rate conversions in signed 64-bit arithmetic
Date: Wed, 12 Aug 2026 16:02:04 +0800
Message-ID: <20260812080204.32373-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806155253.50252-1-163wangjack@gmail.com>
References: <20260806155253.50252-1-163wangjack@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cbs_set_port_rate() and cbs_change() multiply link rates and slope values
by BYTES_PER_KBIT, an unsigned long constant.  On 32-bit architectures,
the multiplications therefore take place in 32-bit unsigned arithmetic
before the results are assigned to s64 fields.

For port rates above approximately 34.36 Gbit/s this wraps port_rate.
The same conversion turns a negative sendslope into a large positive
value, reversing the CBS credit adjustment.  This affects software CBS;
port_rate is also refreshed on NETDEV_UP and NETDEV_CHANGE notifications.

Cast the first operand of each multiplication to s64 so all intermediate
operations use signed 64-bit arithmetic and preserve the value's sign on
every architecture

Also reject a non-positive idleslope. A negative idleslope can arm the
watchdog in the past and busy-loop.

Fixes: 585d763af09c ("net/sched: Introduce Credit Based Shaper (CBS) qdisc")
Fixes: 397006ba5d918 ("net/sched: cbs: Fix integer overflow in cbs_set_port_rate()")

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
v2:
  - Reject a non-positive idleslope to prevent scheduling the watchdog in
    the past.
  - Leave the pre-existing timediff_to_credits() overflow for a separate
    follow-up.

  v1: https://lore.kernel.org/netdev/20260806155253.50252-1-163wangjack@gmail.com/

 net/sched/sch_cbs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 1c93469c56e3..e960c8e01ef4 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -335,7 +335,7 @@ static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 		speed = ecmd.base.speed;
 
 skip:
-	port_rate = speed * 1000 * BYTES_PER_KBIT;
+	port_rate = (s64)speed * 1000 * BYTES_PER_KBIT;
 
 	atomic64_set(&q->port_rate, port_rate);
 	netdev_dbg(dev, "cbs: set %s's port_rate to: %lld, linkspeed: %d\n",
@@ -392,6 +392,10 @@ static int cbs_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	qopt = nla_data(tb[TCA_CBS_PARMS]);
+	if (qopt->idleslope <= 0) {
+		NL_SET_ERR_MSG(extack, "Idleslope must be greater than zero");
+		return -EINVAL;
+	}
 
 	if (!qopt->offload) {
 		cbs_set_port_rate(dev, q);
@@ -405,8 +409,8 @@ static int cbs_change(struct Qdisc *sch, struct nlattr *opt,
 	/* Everything went OK, save the parameters used. */
 	WRITE_ONCE(q->hicredit, qopt->hicredit);
 	WRITE_ONCE(q->locredit, qopt->locredit);
-	WRITE_ONCE(q->idleslope, qopt->idleslope * BYTES_PER_KBIT);
-	WRITE_ONCE(q->sendslope, qopt->sendslope * BYTES_PER_KBIT);
+	WRITE_ONCE(q->idleslope, (s64)qopt->idleslope * BYTES_PER_KBIT);
+	WRITE_ONCE(q->sendslope, (s64)qopt->sendslope * BYTES_PER_KBIT);
 	WRITE_ONCE(q->offload, qopt->offload);
 
 	return 0;

base-commit: 7b53449540502cb21b32bca62a6258e22cd97bbe
-- 
2.53.0


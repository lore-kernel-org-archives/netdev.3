Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5778361957
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600998; cv=none; b=mCJ4gtVuj8CtCASx/WOw/mJUAu39a/5zsJZQAYQ5STspZwxlr5kC+uZ+fbBpI7GmJwnI4x4S+SXAxXY6ftDQUeOcXhUFmaLp5q+/qAshJ4SGaAyFQ8EbHReIKH9o+QaVGIf4yGGxnkhfFDLwgenQyxnb+KW8LDvWXPT7K/jNqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600998; c=relaxed/simple;
	bh=k0IiTGCZPxaC6DbcUJgYzqOFviiZ29gLv8o0+WEHuhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nq6x0aUD05VIJJ/TYwrrF2WavrDPdkKe2KFPFEX8Ib5humecd2rIF4d/BnJXTpI38p39k46ftcqcase0zoJHnEsVqpgJBc24wipWZ+8lT63LJujsKOzbHmS0ozIWyBR+CZzTPdzaXDCzmJ+1gE1GZTyTforpFJswQnPUACNteYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS9JxpWm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS9JxpWm"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e533aacf2so97408585a.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786600995; x=1787205795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sox5TAGummL92plkwLvVOIoXFT28V3HCqptnK0dIWn0=;
        b=MS9JxpWmvLPueWLkAXxV5lcN5Njx7fm87mG4+3RIz754FTrfJnGee4v/pDz4oZrr/H
         GsG3DjY3zWXycrFCzDd78NX3cdukBAfDhiVv5DpE6ahoIDLe/6CRbUucA0441FJq/f7p
         u0pUv4CNyos+Qb9URzS2A5kLSlPaPlo5Ph0Lh8ueWbR3x7Dey0WfKAEwNAZbVDx1CHzO
         OZVMSv4Lze2sSH2xO8uxenhMSF3ZEEgKcdu6AOpsxcr+GhiVzVCxeVsriYZhxwI1CPM9
         VlVlq33T73zz9fxR78yy+OXPUZL6aLYmjp//HLSJYuKdvZiG5/cpMXwVHwBWBtfbu2Au
         gbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786600995; x=1787205795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sox5TAGummL92plkwLvVOIoXFT28V3HCqptnK0dIWn0=;
        b=Z6iGUtgjf1rJLZnWGDNr4hOHYnIZ9RowLBc5CUl5MmH/Vaa5ps8Pkmb4KGdraHoAI3
         zHvzOLgPMqvd+BUR5byzaVuQ1SMjMDTcWsUjV5ieSmArS03D6MW2VF4cjoEvm3QaxqnG
         mSE9xmXur8f7ecU/AmofWDDOQDKHPXZDgSLvbAR0G0y9Yufvi+SoRi0S/zhMG73sk5Er
         S5GCsDWTYAm/NOk0FE2TTwyvIWI/SvCbzlFTatHoUn/aHh7n0GBdnTKGaAmuWmMv8zyb
         2Z1teNKCNz3Sh5KZs5FwsAAKEwhqseRaRzRsT55b6P10QYVGCW46Yf6xbg/Rctnuo0Ny
         TXLQ==
X-Gm-Message-State: AOJu0Yy+gPcxbFfmCKS4T/ORuQj1CuZ0l+XeVh5M30Vqt1X/z1p3MjU+
	bnaiBOLHUp63VcrObE2IS4PKdIB9IsSo5T9ZTQrqCfeNPYP0jgPyIUqKoqNppTcYVpQ=
X-Gm-Gg: AR+sD12aVPpMvRynAV8+2DWXV+jslhYvpo82NxRPJjKWTBYqItjk5XzYvreCbisD7us
	FyOJeuCDnWNxtasIjnA4KawCJKT18BPRsBCh6QjwVlMJOaw9VjnBxy+bl2unPc6GzvlAdgsr+da
	qVqD4IqGxKHMf57EmqpLab5+1h140T8QM/l8ilGHCWKQbHsBqXKsyoPTY4OHIt5D98SHwfcMXnO
	WC1/dg0kM7fdGkGxEe/9/hZMeFHZLAfn8muS5u1cITvwgQs6g2GuM0qZLIlncfm68HHyTBwLKu2
	3X9HnPtpCx9RHXHnRSKDpBw7Ar0jo3TuEmGT68WDP9uDEf/0AsG7oEzUqV/g2UieEbrEVFUujhd
	t13lloJWfTY3w0XSubrB90YPOhz4JpJqi9tB92xpQ0AwlJhPPs+mf+XsY28uxtJAVo6niw/QunE
	FbXHsEHiGaEYKGm103z0QyoMw0+21gnugMABFZa3uwZmNUyvm8n2KLqSPyFmNZ9elWslDbBC4N
X-Received: by 2002:a05:620a:3d06:b0:92e:7cc9:a888 with SMTP id af79cd13be357-936bf9637femr228866885a.2.1786600995425;
        Wed, 12 Aug 2026 23:03:15 -0700 (PDT)
Received: from localhost.localdomain ([38.91.104.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b4d57asm76880785a.35.2026.08.12.23.03.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 23:03:14 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Elena Salomatkina <esalomatkina@ispras.ru>
Subject: [PATCH net v3] net/sched: cbs: perform rate conversions in signed 64-bit arithmetic
Date: Thu, 13 Aug 2026 14:02:56 +0800
Message-ID: <20260813060256.28748-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Also reject a negative idleslope. A negative idleslope can arm the
watchdog in the past and busy-loop.

Fixes: 585d763af09c ("net/sched: Introduce Credit Based Shaper (CBS) qdisc")
Fixes: 397006ba5d918 ("net/sched: cbs: Fix integer overflow in cbs_set_port_rate()")

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
v3:
- Reject only negative idleslope values.
- Keep idleslope 0 accepted for compatibility with existing tc-testing
  defaults, fixing test 1820 regression reported by Victor.
- Keep the timediff_to_credits() overflow out of this series as a separate
  follow-up.

v2:
- Reject non-positive idleslope values to prevent scheduling the watchdog
  in the past.

v1: https://lore.kernel.org/netdev/20260806155253.50252-1-163wangjack@gmail.com/

 net/sched/sch_cbs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 1c93469c56e3..8db98d7c98a8 100644
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
+	if (qopt->idleslope < 0) {
+		NL_SET_ERR_MSG(extack, "Idleslope must not be negative");
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

Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B030EF8F
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528868; cv=none; b=CgZHHeBe5CCb0AZlFp9TidVpaWMEfXoGGrnfdAVxRKw0tDGWzXqxVfqNcMwyVbszR642QlNTttvDtWIoBdgkI9ZUosEspbuTCQDYMTr3TP5UbomqQhz7GXMOPMBFYjhPnVu7WryYYv9jhn1f40AQC6OzkEjYpRSN4CO9xViOq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528868; c=relaxed/simple;
	bh=5ZFXptKAxo1rTLpbIpgH6vO1joQz/kZ6CYrxrQfA61I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNJscbvscAsGVz+SY/3e91lwwzP7/fTnFCZEWCa+O59eiYdmZgp9LJNkVXfmNzfbBp5SXd0brLS5BSTI9EV+CqyJlg+lbNGhhzHg7Zcgew6V1Yp4UjuGEjPOw9F9Bsv8ZQtbVqJESiMt3Gf0+1nsind7ghQdo9v6RzxumiklKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgUf4LoM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgUf4LoM"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso936469b3a.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786528866; x=1787133666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tPoa6C0hj4HZJwKUSXTCx+irT5h4iMOM05qfW4+AIP0=;
        b=sgUf4LoMpha0hRJxYh1Jpm1t4CtdNGGl6MHItbAsNq/jHxgLh5hGFXsTjT7Rz520Gp
         9QWkFXYtzkof+OCLbAKIRiDImRWQ1HVJMxSNcXJRd+n7eLC0bX4CoV9l5RYqsXoC3kn1
         +nAW4Kk4gSilkshvWkDKspcmm7ANpQWx7TNujJUVcS4mI8cWjhWH2+8l2KnJgcKhJxdV
         BfwcuR3e7PJEuAbYlBX8MVuuWS4AIt6C6B1pQHxMnaYbSnmXO/iVjAJUO2UtmTE1bPCw
         HVKNdckxLGoLuoxEyCO1aa0wb+IsLJNEZmDobwJumMuGZRggg2sloN7rga5atsLdyflj
         0Ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528866; x=1787133666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tPoa6C0hj4HZJwKUSXTCx+irT5h4iMOM05qfW4+AIP0=;
        b=SMBzPVABRUO54+sYL9Wb8tUrdVxJZI8RTmHGHLI0/Hp7O9qfbTgS1LdK2k7RqOBFz6
         EZg9MK3rH7KwDjGjja791cDn+64cK7xLy5jqT9bcCdqpytPUyaiKy7ZCr7pp6NDgkwnK
         g7+QcgrLNiVBN2a07DIB/2DJiZvCJVEY+v/j8pB6iYPi++GczyVTjPJ6xhk1wAVuwi0f
         xM0fAcvbdu9aSic9t7wvToAsObuv4Tvu627DuJ+/7LGKF4bbprEcKjN6FY3WaFmuMPul
         uh4NS0OlsKwe3pToscVqua7xrnm27YfVBEuuHpdoj/wD4SGs9FK1ImYiFMHdYThtZJsb
         KJ/A==
X-Gm-Message-State: AOJu0Ywo+zEe+LOTym+p3C3XPT5ZrqA9i9DJeMf0/pwoMTIlvEZQ+G69
	70SJHVSgGNHk90y1R9LWh6n+vbJrm9Dlhljvg3+SAqyVqcnr8SukSRfvhsTti3aA
X-Gm-Gg: AR+sD13ismMRlXHuSuIw0+R/JfoaJDPLdDzr1UeEv4/yIPSMtf+Dno1Rk2vP/o7A7jr
	TAKsfIMfy9dR9W8OqkJI0IwiBPAQfNThBp9geiVChe7et96CoD5xTXmdEN5fts2fe792F1o7vwd
	f4J9tIV8j2jpu2uCwNSF8D76wm+NIg77DL1ETLKXFQE68CGJaiun4p8CCo8JnWcPe0HuDPE7uuB
	q/BhP4HBEE4Gb6Wlzr3SJpbXAsGDgi+IM+WZcwczFHfZDJgjVJkN+sudANk3pEmD4YVyGzjGZwF
	yudYM7OwI/nEoHDZPyDvfX8OIl+tf8fZYcsKc5auR1wXpARk0tiBvmy0l07ETeAbfh75Vfc/4Kr
	bBVDBAOmXI8W9/RkXCpVxkQoNluoYp4JKkwAHUGWQz+8RsroG8qZDfKgXkI9X0M+ZFVNkduYyX9
	kBmydclWQyZj6owUQyrOJo6CmwSGDCZGONX7jbaPgkycuVq22zLcmJz92jmSGypxd5k8LVGcJ3
X-Received: by 2002:a05:6a00:288e:b0:847:9aa8:d3bb with SMTP id d2e1a72fcca58-84fb540aa72mr4180855b3a.12.1786528865974;
        Wed, 12 Aug 2026 03:01:05 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1d250f9sm820838b3a.17.2026.08.12.03.01.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 03:01:05 -0700 (PDT)
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
	Elena Salomatkina <esalomatkina@ispras.ru>,
	Jack Wang <163wangjack@gmail.com>
Subject: [PATCH net v2] net/sched: cbs: perform rate conversions in signed 64-bit arithmetic
Date: Wed, 12 Aug 2026 18:00:44 +0800
Message-ID: <20260812100044.38040-1-163wangjack@gmail.com>
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


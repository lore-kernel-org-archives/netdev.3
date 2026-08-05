Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0A3E49EA
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925518; cv=none; b=tCldaP4RvSe0v024DlenSMPE383hnHDHpKRiIj4kTgzTSb+5jumFrNQK/asz+VyV1XQBMzUavpheh6oFQKoZZdGAD4R1J+tfUzi6DzaF0T8fFJme6DuPPClbWE/xbju6TAPSmtU3Q+dCRGUzZD9H3nebc1PcHp2otkjIXM7Uflw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925518; c=relaxed/simple;
	bh=Ar2VSFfOX9Y3NHy+gCdt76XnYbYIFnThMiDcS2J/SHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fehi0yU+oAEL/5XEG/+uRnyeG/fS9ylrz5foFIZAkUay6sqMPNb8oJanKBsgMkXz1eJ3mljdVFRofqULYxs82rM/D65xOC3Ava6sEt77lEwbYhGzKd+HnHAGrCDrqLsRLbWfU/gNT48bycL6dafd9BvfDS8mgSy7CUFtfnHuvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=PYhp1sGQ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="PYhp1sGQ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930f618435cso48924085a.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785925516; x=1786530316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBFdOOeUVBY1Qp0eWq07UF7DoGLXPhkRtG5vT8+QMKs=;
        b=PYhp1sGQtJ3DEZAoUlztW08B9vnfubJCd4+6Uw5GxN94Zb2T/0rsk+HrCnReeRS302
         Jp13zLSDGFi+R3Ua69l2YBHPbg3ZEKsVAng9BmiRHhu2aGh05ExLiHNQSd8Pbpe5W6ry
         bPGSoTTi2ceGQDr3l1tbeA0xQNrKDmdMSdyQs6hLHI9b5ePICr7HHshkeicBiZvLhL/f
         uUpjv6UH3ge0AIwZgJ1tQitF0C7Z6gbAO0t7s7EpCNGFQSpRH9zuuKtkkEFJq5Gida6w
         MeOw/shCCIKK8zK62+N/+mDR/8bD9yMfpr/GqvwKDVMNvIhBu4Vrd8ycLMq71zdlJhT4
         lS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925516; x=1786530316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBFdOOeUVBY1Qp0eWq07UF7DoGLXPhkRtG5vT8+QMKs=;
        b=dgj4dyiKm4Cou7n0E2oVZlbl/b9XifpmXAqDDpZdS6Iat3cVtHBCn9nJl25++1anqb
         McEhJtBYty/Q+Rzc/EnQME0IsMP79N2MCsoUBbfOll10TPO5j+e4u+T+2r8atrz8UK6r
         6lLxC8GDsbrBoNt4sqNKLM9Ib0afu1GGcEPSCku1Nk3BUu5Tp6wDNRU0+ACXOax21w8X
         CsvKFkw+otC8bjgT9S009oILxj20y6z8WPd5jBN+Q7lf74w0sV/4kuxIynq+ObCYwRcI
         yTTWf2w5mW6Jddv3PtVSyB+ek5QjbCDz/2d99UobcejQ9TRZQOOA2+wXejXfWdFZ86ak
         vA7w==
X-Forwarded-Encrypted: i=1; AHgh+RoyAu0olvDgno6TQntKybUsJTb2SWd1JBam1szo7ylWliIOjsvDbDzQz6o4TGShxWb/mZ3IMGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2Tl5xf9tBLA/lqHQCH3oivSCP1xF2LSRmI/l9hLiD/XiXBlA
	OVqDkZn3S4Wja0xt9Whir2DiSwKhg4XTHnmJpfmibzc0fMibYHS/wOP27PZ3xrKiSkQ=
X-Gm-Gg: AR+sD120q5IRChXgaP7QPmIFHCcoExVTaO55YEGpiWlzlii2qvgr5lRUxBGnvXhefen
	HT300UG2acbqbu6N07nRCb5s0OR8av6TYFF/nQ2JccOznar3cWEptvXXQaJ62ChgoPxfkbB89R+
	v3/ixC6rg1Cb0dDUfjb7NJi5z+qEecy/7xCgTg8w+WAjhh5uc3kxNq9PNSmRKGdqjLvGqgsXHd8
	FrR/7egjOQU2JvCW+P0dpWJut7mUutw8qxcwspHOvBFS/Evs36/x3er1Q1xVemsoD2ms7Gbn/Ao
	eP++9OqrmDEz+Izo6y6BzD2s6U5ljlYk2wClJtmcodPlWrmaJwZeuEvIXujww9BTohmgKYUk472
	3D4uAe/HD3y8Z/349W37v+t1LjEdgEqJOdHayn7D+rsPhJDxMSN2NEzM53hYNMeYqjyRSsWpXAo
	C0SAH9IJRxem7ExHu+89q3dhldhkc/eiU//A6WVpRkHHk4arhU7N3zxykGSQKa4PNX/A==
X-Received: by 2002:a05:620a:a003:b0:932:fd59:3e57 with SMTP id af79cd13be357-93649148855mr447772285a.41.1785925516159;
        Wed, 05 Aug 2026 03:25:16 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9364a597e2asm119983285a.43.2026.08.05.03.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 03:25:15 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net] net/sched: sch_taprio: do not requeue a deactivated qdisc
Date: Wed,  5 Aug 2026 10:25:14 +0000
Message-ID: <20260805102514.740834-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

Root qdisc replacement and deletion call dev_deactivate() without
resetting the old qdisc. This marks the qdisc deactivated and waits for
existing runs to finish, but leaves TAPRIO's private hrtimer active.
advance_sched() can therefore requeue the old root after the final busy
check, allowing a new run to overlap reset and destruction.

Do not schedule TAPRIO after its root has been deactivated. Keep the
test in the existing RCU read-side critical section so that it pairs
with the synchronize_net() in dev_deactivate_many(): a callback which
observes an active qdisc must finish before the final busy check, while
a later callback observes the deactivated state and skips the requeue.

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

The supplied v7.2-rc3 trace contains a KASAN use-after-free. The
reproducer did not trigger a sanitizer report in the current v7.2-rc5
campaign and can be shared if needed.

 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 299234a5f..2cf76df43 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -990,7 +990,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	hrtimer_set_expires(&q->advance_timer, end_time);
 
 	rcu_read_lock();
-	__netif_schedule(sch);
+	if (!test_bit(__QDISC_STATE_DEACTIVATED, &sch->state))
+		__netif_schedule(sch);
 	rcu_read_unlock();
 
 	return HRTIMER_RESTART;
-- 
2.53.0

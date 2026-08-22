Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78455367B61
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428531; cv=none; b=KWWr7EyM0JKbGElnTlt7ZqvwvnpC8S2XlIUln6AmXneU5FfWzhUzCay1BF+k/1ihm70HtWqpfzXG7f8fqp+i9rKNUXFHFfgfgR4o6AxH8pt2KVMpMgJ+tGl1sj+Cwb17FNC+8PbW0dpeUaokq+i20kOogB56RMG+/g/a5hqQiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428531; c=relaxed/simple;
	bh=Ork20gjEQOn288yqxNrf6dVpwI5OlsU02o9Ttam94bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGJJPHx8ed5IpkyX9v6/eHBXWe/nEWVeNdJQ493C/QMGhs1YzcYk0Kz5KJy6XSE/rYdLoojiy9/hQrCv4ti239oIqckJz0k/5Oji+KFLTToxDXy035JqPg8MdEzqi69zgu2ykhrujztM0RH8iySKrY/4J39bF+7sRMdbimJMOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=eApwlkUU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="eApwlkUU"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9371bcf1f8fso93878185a.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428527; x=1788033327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDlmITuUrdcrFWmFMMERDH8nQErt5aUJfnzyC9EWVzU=;
        b=eApwlkUU9vBGySmfLEXRSXV0oM1Q51i9hyVtDUgUT5Q2aYfM2OjYPyXaalel2ERVKp
         bpnJ8fMCqJTZZcAHSCdT+HsiCQa0EG/rmF7gC4QwI8L41GuB3lMvpqkxHISEe3zNNC35
         f4nOfocOOfC6jXKo9DD71ucLm2dJa4014gnjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428527; x=1788033327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDlmITuUrdcrFWmFMMERDH8nQErt5aUJfnzyC9EWVzU=;
        b=SPu3jr4kwCbhmYgvrWoegKzYv7bDdyIVBtgpafz0EdvD0EAGD5TjoqeltmAw+NeIoH
         NUFl3c/LcKpzn87WWYrvvHpm0nzFJVdvZeu2gMAluTTUKbareh3U5h/GXRTphOYL4foT
         J77Cv1RzEbxUxe9bRVR4OtAIlNdPUXw7KfnwAxW+e3eS5Oy4jYiQWclNTrP4l9CrYpd4
         Smodbl9C5AOytTjr7mpm4GjTmaEfrYs86p74R0dpwl+g4tBrvOfZLGvxtTijI+iKIcG9
         /aPm1z3WnQVnw5xn0ouED1xXm15X20Wmmfdsd4WvTCHTsdCBibFrHQAQOE7uSzvB22sm
         EcQw==
X-Gm-Message-State: AFuF++m37GIIgvLHCfR8DC+MAcvHxjMRd0gfyxIe+S/3a/RPtbrNiXZX
	1456ORHC40HhOHmqfg+aKNuy8TTeT3w8ltWSH9q7G6NMh20RNTlNetcv1/eeaOO+CCHY9dgZk73
	DHJLr1g==
X-Gm-Gg: AR+sD13iPzyjeZbH7uR+kQNssbcGztnPw6IcynmfbqO01hqJNGJcmmHXuesW0mw8Tsa
	aGha/oswivCYlKuqpb4LJjTqlAE7Wy6GYHS4B5zasMTeQ1eqGgqLbFMyEC/bL70hr//fgbeD1sM
	yovjEKart0CLzfruzXslS624CFwZUPcKyN47kjs+/83n58IFey9ayIIKaLh0IjUc1RKbzARWYpx
	AGig4abuz4DWxcx9FawFj2PwQBuVYbLh4eL94BG5P8z9S0zL4Y7+kY/0AmcRBAEG1nw3rdH+naf
	aBbnBU+bPF1Z52iTfqV+6+wfOGZk//4vH87NNdPpFVqRveEU+YMbmk6xS5pb97DdWLr7f7LC38S
	EwQXQ4uiFpfAH3gdiW6BFZJF9AIihIpsGbbXO51Gy9r1hC5lcAQBcBMDWjiAq8MeMZMhHkUEnbG
	6sXQMID3AtUiX02U7QgUo6ksRVCCr+Ow9gkhUyugN1ySgj7ebNnSeF
X-Received: by 2002:a05:620a:4115:b0:92e:d7c7:7de9 with SMTP id af79cd13be357-937468531e3mr661718185a.8.1787428527395;
        Sat, 22 Aug 2026 12:55:27 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:26 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 1/6] net/sched: fq: add overflow bounds to quantum and initial quantum
Date: Sat, 22 Aug 2026 15:55:04 -0400
Message-Id: <20260822195509.112717-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822195509.112717-1-jhs@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fq_init() computes quantum = 2 * psched_mtu() and initial_quantum = 10 *
psched_mtu() with no overflow check. A device with a huge MTU (e.g. dummy
with max_mtu == 0 accepting MTU 2147483634) makes psched_mtu() return
0x80000000; the 2 * and 10 * multiplications wrap to 0 in 32-bit
arithmetic, so q->quantum == 0. Then in fq_dequeue() the credit-refill
loop adds 0 to f->credit (which stays <= 0) and goto begin loops
forever under the qdisc lock, creating a soft lockup.

Clamp psched_mtu() to [1, 1 << 20] before multiplying so the product
cannot wrap, then cap the result at 1 << 20, matching the bound already
enforced on TCA_FQ_QUANTUM in fq_change().

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) is large enough that 2 * psched_mtu() wraps (e.g. a
dummy device with max_mtu == 0 accepting MTU 2147483634). Requires
CAP_NET_ADMIN in a user namespace.

Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..8a071c35b869 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1222,12 +1222,14 @@ static int fq_init(struct Qdisc *sch, struct nlattr *opt,
 		   struct netlink_ext_ack *extack)
 {
 	struct fq_sched_data *q = qdisc_priv(sch);
+	u32 mtu;
 	int i, err;
 
 	sch->limit		= 10000;
 	q->flow_plimit		= 100;
-	q->quantum		= 2 * psched_mtu(qdisc_dev(sch));
-	q->initial_quantum	= 10 * psched_mtu(qdisc_dev(sch));
+	mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
+	q->quantum		= min_t(u32, 2 * mtu, 1 << 20);
+	q->initial_quantum	= min_t(u32, 10 * mtu, 1 << 20);
 	q->flow_refill_delay	= msecs_to_jiffies(40);
 	q->flow_max_rate	= ~0UL;
 	q->time_next_delayed_flow = ~0ULL;
-- 
2.43.0


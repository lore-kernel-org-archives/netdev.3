Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7435B657
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445818; cv=none; b=XjNc1IakWRY4fIViVE1V2dKYsrh0GP/a4CSxHEEscQ2dyZS4HLsgYDRL1m1b076hgW23sEiY84oer9h3e/X0vbSYJjPVBZger/huVOG0Vn8boYn/5MmAjwGcMUQJof3B3B5y7LDXllcdMCPd5LUAa+QTie0Gqn5eWZJqa5ioyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445818; c=relaxed/simple;
	bh=A6MKKcZ2lNiZvXNq5PkYTD7DsVUwX+uRataPSCZvpdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b99QKb8XzhwSWum5czb8aE+TyX5754tk9pM+h4TCnwS3bofW6CRX8llpD/eEai+8K2LMN+7ydqBLkY8uoSy5Xin/I0tVeVHUQvyDxoSE1hbdc0EpF/t7HY5r4e2+QFUVLqkyhnjY20mTDdtiuxDNBUoMViVC9rywxVq/9ATRMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=p1o0kGgX; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="p1o0kGgX"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfd70b08cso232841185a.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790445816; x=1791050616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBgdKLuzKgWAaoR8Y6PUwk1rrOWCUPoeZN2aw/TlYks=;
        b=p1o0kGgXlAiGvERbJsyiPgZ93CAwmMgAHqo/ZoCc+NxPUz3IYNgHpsYTaEG2fYKJCb
         0iIlt3/2ddnpAQq1eRlvMzYOHqrVr0AF7nRlyVS46wVyZN4kLvvNI+BAPAMYd2v/vZ6S
         b4jvqQW2Aa7tcPyKTv/5UJJSvfBDgpLIagnEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790445816; x=1791050616;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBgdKLuzKgWAaoR8Y6PUwk1rrOWCUPoeZN2aw/TlYks=;
        b=OrKEwEyufHcNCz2t0OlrlaJI/Mp7/yOFNeSeovWIKOAunMeU+1UF5R3w5+kTDl/4nR
         muOABgkAi+VK84C5LiKGWEx0FfIRZzaxHuYaq5XcQ/Wox5xzqBee/qQw1nFRIUDpT+dC
         6zvzdSX5NYNpxBI3vLVgsWizB1lu9yEyR4kOd0kFWgZX+11iZ6AMybFL7JchpEN8Mzsx
         6pXz3l2Cn93l+uB3CH3Cd6XM2uUcTiSYgeEkDmkHCYUOmFuRB0mz7C+r8eNzKcVpYKAA
         03BJpXUK4RTjvqfRnLSOoZeVWQLd3bZrsewqoh+TwUylMBwDGFR0isFesOHtu3yj9wiG
         2jBQ==
X-Gm-Message-State: AFuF++lHrZNueRFKNflOdwXGqF66ArGtd3YBP77FBmfXN4ba8wSMweUM
	ap8qOiszeD06FUunsLw/85dYzGmiJRT5KwQtrAbNLtdXTntrvHAdDBg4zgqu0nW/FGAYQ0RbLEs
	1pC2eKg==
X-Gm-Gg: AYBFou33OGm5ptLkbaRA/g15h/KyQ7dw/ckBY1d5bcSI0SG22twPhx4MJhNjirEcDST
	d493khHVszaIWuDnQ3EB7MXCxmk/M3nGzjjb4q0464R7pYSgx2jG3hxzXkb46T7rM1sp3T1QOQz
	X+IcO6vaH2BdgIKMDpOa2dqW9pHYoqKg3HDltSMooFpgxy9RLlXU2hvqsr1mMFtljXNjLCAqMZn
	j4PcpFGrZNAdtXosexi8IkCmP8spdbMfhOGuAr89N5wTvsrHEYQpLmtI4dhViUJOKTWuPjSFiaq
	q5JE8XEBUAYNaOogboS8n9z/pMobW9z4ykTWIoiUMrWo1nOrGAFYE+ji9JlHigyOpl484SOc9vo
	pey/gMoUJrTqzy10wblGF8zCtYbSfd5FHqdkxf3/DFPwc6d8SmlYoIz6tssGHM5nUbVuUSs5r5O
	cVJXQ+p6jqFX7NYMopLCTYCXVVLKhHsBwK9ycoWkO9VjGxjirKzcdhsX+tUZB+38y64HTXjivP+
	PdOFTWBBytIRpfCGo2TA0lhshOIXTqlvUgtaXlqjPuljDGu5lZhGuK+sc7r1Is3qID2yaA=
X-Received: by 2002:a05:620a:4809:b0:93b:d7a1:ba12 with SMTP id af79cd13be357-93c47558b31mr1011764985a.61.1790445815734;
        Sat, 26 Sep 2026 11:03:35 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4499c06csm459288885a.46.2026.09.26.11.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:03:34 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2] net/sched: sch_codel: match the no-drop threshold to the packet size
Date: Sat, 26 Sep 2026 14:03:28 -0400
Message-Id: <QDISC-34MS.v1.20260925165535@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-34MS.v1.20260925165535@mojatatu.com>
References: <QDISC-34MS.v1.20260925165535@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 6439461f1618 ("net/sched: sch_codel: clamp default mtu to avoid
disabling CoDel") clamped q->params.mtu to [256, 1 << 20]. The value is
the CoDel no-drop threshold (codel_impl.h "*backlog <= params->mtu"), so
on a link whose maximum transmitted packet size is below 256 the floor
extends CoDel's minimum-backlog exemption beyond one packet and delays
drop or mark eligibility by several small packets.

Keep the upper bound that guards the original overflow (psched_mtu()
wrapping to ~2 GiB on a huge-MTU device) but drop the 256 floor, so the
threshold tracks the real device packet size.

Conditions to recreate the bug: attach a codel qdisc on a link whose
MTU plus hard_header_len is below 256 (e.g. a CAN interface). At that
MTU the no-drop threshold must equal the device MTU plus its
hard-header length; before this patch it was forced to 256.
Requires CAP_NET_ADMIN in a user namespace.

Fixes: 6439461f1618 ("net/sched: sch_codel: clamp default mtu to avoid disabling CoDel")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260819143136.57350-1-jhs@mojatatu.com
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_codel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 6aa5829d6961..a1ba2e355f2d 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -205,7 +205,7 @@ static int codel_init(struct Qdisc *sch, struct nlattr *opt,
 	codel_params_init(&q->params);
 	codel_vars_init(&q->vars);
 	codel_stats_init(&q->stats);
-	q->params.mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
+	q->params.mtu = min_t(u32, psched_mtu(qdisc_dev(sch)), 1 << 20);
 
 	if (opt) {
 		int err = codel_change(sch, opt, extack);
-- 
2.43.0


Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF61309F1B
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777809106; cv=none; b=qcEXEjZggFILgNJxtKPm7j1JK72O6KPoV+/QKol55j7M+jw/dzqgy80kAKyq0wASBYROzBZb00CVsGxXi+Bf96X0YtHIthqiPYOoBvWFqYkr5K3cartITkWt6cmLqmBEGlQit64DXR2hlIt/4m0oPNan/T+C5ZQkwySfN1IxdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777809106; c=relaxed/simple;
	bh=HXTtQjteeRHU/rYJLZjzhGZRRXH0l5tiFealhtqUsFc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J5R6uj+6NQzyPHCRJmffguLs3Oy48vx/2Qf8bjEJqXPeNASdaF7up2ZrzjkCeIuDPUrVYE8frvIi4++iHOkexQ8NsbG3s0v41dKZnfO3DhHVj2K/T7p4a8qG+aSX3CWfYZsdchVXt3VqbLvFdO+TMxh5VhBQloORxjgnlkLBgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e39d0c5f; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e39d0c5f"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8eb55e55394so717177785a.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777809104; x=1778413904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XdZ4SmzuGrB7ESUZbSVxVaIhreRoCNyMLZutx2R8Ju0=;
        b=e39d0c5fdTM0Mh3rW7ZBd8XOVxx+lvuHNsx7qI6hGDqmgjzxjJYhppEajYAgD89aub
         V/q7Tlu4VSBHOgo2wH3uVi45LXqltp80+mVj9nKQEsgtMr76et3IuuBuBjE9bVHYLbZD
         4/dsXeCYCJxrsInnk9uo4yqWpFMfvr9qABcKbGXjQURXx5KzSlGzj9TCwPBB+f8oVy3E
         B03RktUpJGxvWzIKoVO0XNJLg/27VPaRGlzBJMx0pkXq7zyY+RjfkEWQNBCkyg8ejhUZ
         iRaADYyca59rNB7LFQDQTiqzAIOORvti8rHIRfAYB3RHGhERy+CEL9tJlrkv6ZH5/HNC
         nHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777809104; x=1778413904;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdZ4SmzuGrB7ESUZbSVxVaIhreRoCNyMLZutx2R8Ju0=;
        b=WguAs4wfb4SVSne75+k9jCN3FVdC7j8uhpHSVCn6MRs9lvQAZbltm9iIgMoKREui48
         KAu8h1P/53Uz7j3wtPecTUNvSLWg/D8mLbsIEwwWig+a8XDj8iMr33Ftb2sbJHIFOnUq
         me3Ggq34A+rR4dO/4C6hCqbqQ8gYpWWOR+x+cRXXYQMNsu5mVdO138nVVKQ1FEGYFzdL
         RGhpZoZDHpVxzDe3rI5WM4PgMUF5hHW7qTEMIMoRHwGDS06WN/ddsgbIHfvcyVEBoIky
         so1HxarxceM0swO0ENtM9+zytMBDdmQ+mbCxcboP3hfZcOOr5q2Q3kU+ZX1hiZeYXyCW
         Agbw==
X-Forwarded-Encrypted: i=1; AFNElJ9I+8Cyg80xw7/cIeOp/y6zUMzNSJRtLWW8ujS4KEJELBExDf5czv+H2Tak8JMBGdqq6Ugdzxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuAuEvi7wS+EzbJR3/EEkQMNhtwksruEm83Cv34eWzAQrYgwLs
	w05TgbDyH4ZT+O0Ik9NglGePWuAgqqPU9s6OHvPIiUqJEWCoToH/ll1OxcBg78DwJS45dz5fbpi
	3eWxFKOJphisC+g==
X-Received: from qkbbi7.prod.google.com ([2002:a05:620a:3187:b0:8ee:7c1c:c4f2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4543:b0:8cf:db04:8a1e with SMTP id af79cd13be357-8fd162cb1abmr830920785a.23.1777809103921;
 Sun, 03 May 2026 04:51:43 -0700 (PDT)
Date: Sun,  3 May 2026 11:51:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503115138.2467123-1-edumazet@google.com>
Subject: [PATCH iproute2-next] tc: qdisc: provide tcm_handle and tcm_parent to
 kernel dump requests
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"

linux-7.2 can filter "tc qdisc show ..." on tcm_handle / tcm_parent and
reduce dump costs.

Old kernels ignore these values.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
---
 tc/tc_qdisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
index b3c395b65c2f6b47abbcb6aa37b7dc1f080032e8..7c3e7cb36b4830bca9f2785a58b38d319ec4b563 100644
--- a/tc/tc_qdisc.c
+++ b/tc/tc_qdisc.c
@@ -408,6 +408,9 @@ static int tc_qdisc_list(int argc, char **argv)
 		argc--; argv++;
 	}
 
+	/* Recent kernels (7.2+) can filter on tcm_parent/tcm_handle */
+	req.t.tcm_parent = filter_parent;
+	req.t.tcm_handle = filter_handle;
 
 	if (d[0]) {
 		req.t.tcm_ifindex = ll_name_to_index(d);
-- 
2.54.0.545.g6539524ca2-goog


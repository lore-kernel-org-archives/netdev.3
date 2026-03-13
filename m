Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752D372ED0
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436636; cv=none; b=H9x5COsiFhYLj3xBAFFzdfcdIgpfd0lrMts7HiCPnpi6JjrYeYfgcJa/XzsYBIpG9E62HTIMIVOprUvTW0EG3ZYL4a5vLjwN8EoZjnQUkGE0X+Z++Xw9sOZMC4BUCetVfe6zSH9/clE0bpKLpgLWq3KKvjdmVQu9Bnw8AdzBpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436636; c=relaxed/simple;
	bh=mi+OPjEJTrwbo7nqkxoeiRUL7H9QbH4Am1EsnDxrork=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrScL2RH8YzvnDRrAqTuLxhVUvjtMgQ9tU17cjYLNEzFrkCwEufmwFJFR7L3cexa2jySK+Jjpb0OZkOv7IitPO7bL0KFTL5LbeWeVL1AGPwEnd2JnWAJgBYB8WDrnn3YNgs9+I/4QSbEBu3VSlLoyN/kICCQIFV44iaTrBx4q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=RAJVQ5Ry; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="RAJVQ5Ry"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c73a12af63cso1577524a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436634; x=1774041434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpeFDKYyMjnBciRFJqpsUYDqJs3fcTG1vhqpApyp93g=;
        b=RAJVQ5RyhmZCEjPMDbZEPFwW/z9+NG4GAXYPnBFlED9lbRg/ajiD0AShTipUg3TQe6
         71jeO6/3u7CyP6YOYaLJO3coWytRDpsTmsnkB+Hk6VeBuHuKxsjf7Fyuxnfnu9eh1Ewk
         +ftI3Xijl3qbXMhFhw1DJ2Z+6JbD6MZeX4qdTsmUVIpGBfjtcD2F+dy8DGaG1a/mjlNB
         Tq5M1c66nzWd0v4O6B8yg+O2xYbX0IEaeQpvr4gz3c9g6GFhbET9Z61yb8kpjfTeM3YQ
         sEm1+h8Jn0kU08zeKciCQBKTyKLepFIqUUTzOgr0Cnpz+bhLIMzp2ug5XSFP8+9qlD4h
         4UqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436634; x=1774041434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rpeFDKYyMjnBciRFJqpsUYDqJs3fcTG1vhqpApyp93g=;
        b=EevAZJ1yAfNu0bZK/UK5wHca3OxVs+PRxGqpp2BrJeg8XpghdVmjZg+qoU5wMz7RiW
         5dUP5IUoJWQ4hAVrryjNcEcl1nt6bGIBdzinGtYmoNJDXnaNEjGXZRfruh6qPpSUs/AJ
         NXSnFqYuJ6THf/L3CCj37FbHAlGpDYMgvHCo2zFRTaCYpOpBfPpXYUBHCxfg3fu5V04g
         9UDTWpgIUjWrVxnpOuZQN+TlGvTjyqKXWYrHeStjwK03P/QduSqdfC3aQrBBVirgs4nk
         LYCuOEnkpFYgbqfHAV5bnHZOhJLhF2mD4KDDI3Vr9IvDnItX/wZxbTK30lh8imvWE5SE
         4tDw==
X-Gm-Message-State: AOJu0YzAmFO5NfXk8SOgBqJTMyd+5ILy0k5CNtpfy4wGBip1wZlcDb8n
	TzQHjL7g5uwsfzlK8g4m4Zi3NaK1tBDZCoR9xUc/E/AdhkGYZSRzzjuGMp+E6htR3zAE3658Upb
	SqSbP0uM=
X-Gm-Gg: ATEYQzytXOVe+ZErduXUxgeTDcyAa9bMd7C2EAqXzEvUl+L+z2Gf2Y1rmUbVuspXYpM
	QPncJSDVWvSBySX0VUz7aMAfHo4w7JGGINBdFhLJclKMtROuwPpY+0/AMf8iseiIBmB1D+2Zt/D
	nw5Jt96T/w/iCXxoCX0buPdoYnfTSKIOX+gRSpkNh7ATvGy4zXcpKiA5bMByi9Axyoe/fpiG1AD
	Khb/HnhFwRgggHjwLXDw3dNrnjDMH442VZnEkmuIT3hHAbRqn2pYCEZ7g7Cu3mH0L4Th52xbkpv
	f/sqR6lq5cVmt9ivhqBfMYxWawRbH9EsxNMI92ZhwMKG12EnnlvjeNu2TQz2es0ClQZWkMH95tD
	qAilVfddhSn/H7qQuPpN1Rwq2NGCplcRM/J2edpqCu+gfjkBGMzdx4hzGyZz00l1qVfE6yKxpqB
	qCB84h9R55SmL/UVKe4/Xlp8emTo66blzF
X-Received: by 2002:a17:903:3905:b0:2ae:593c:48fe with SMTP id d9443c01a7336-2aeca9f8ddcmr50636015ad.13.1773436634363;
        Fri, 13 Mar 2026 14:17:14 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 07/12] net/sched: netem: fix queue limit check to include reordered packets
Date: Fri, 13 Mar 2026 14:15:07 -0700
Message-ID: <20260313211646.12549-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The queue limit check in netem_enqueue() uses q->t_len which only
counts packets in the internal tfifo. Packets placed in sch->q by
the reorder path (__qdisc_enqueue_head) are not counted, allowing
the total queue occupancy to exceed sch->limit under reordering.

Include sch->q.qlen in the limit check.

Fixes: 50612537e9ab ("netem: fix classful handling")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index afb89d318f41..df9049816623 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -542,7 +542,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			1<<get_random_u32_below(8);
 	}
 
-	if (unlikely(q->t_len >= sch->limit)) {
+	if (unlikely(sch->q.qlen >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-- 
2.51.0


Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45B308F26
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785591779; cv=none; b=ZacldoXePi9stVCCYTd8HJg4GCj6BO3yQZhvpB28O6oSG1YZzoti5wtDE4r2M7VQ9ixlGwos+z0TSh+FMSjnf0QASeyQUW+g2NzlNpY/Ixzd3/NiP4hQPnD1/qn7j8Vi0BJtqjgajw4NpvIUg5uBjAj7+sBQSqBKTuxQhxT3BsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785591779; c=relaxed/simple;
	bh=7oZpUAI64myintFN5P3mwkl+kh7M5jFwqp1ttfu5Aas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg0s4t6QVG6xFnwwqnbZNQ58PodEdP+kWox3p/DGVDHYZr93a2IAunsJAP/lDgTGZ+CHWNOUvKUpUmDH+uFezv+igIwTucTEQB6LRiqLSFTDJww9sm32+DNl9mDClw2SvMWBMv4vZlR/739YqT6/rgeqw+NwihYovAL1KX9NwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWpjD7HN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWpjD7HN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caf228a910so14101395ad.2
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 06:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785591778; x=1786196578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jtGDI9BCziEtTlla0MY6NVjGHkp8vq0UbFBjp9Cujkk=;
        b=dWpjD7HNEUS3q0o+pKmD79/04YOGK9ebHoZXUjasDJSpgpQM1BkoMCuSsAMGE2nI/R
         rHlLE8XIo45hjEZZi85226sCnLwtW994EwTrFiwo1+L8z/oZlMI/KPM+hokBqOSFjzyV
         svvfennsuKReqPsmKZwGk/5i9dD0kbCAMGbbcMuOLx+E/cV8BIa0UwzoxARHE5qu+2z3
         HWk71kVKIkihGoGjYV+DvkvnjG7PvtJSKphcO2ae71W6JX8crMeSEA+9GGcHYsgccc+9
         sKI7N3geCA1YfLj3boAQvlSwopAf7p658lYFqcUPCJ9m/5N1sxQmb4bADSQALydIX/kP
         QU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785591778; x=1786196578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jtGDI9BCziEtTlla0MY6NVjGHkp8vq0UbFBjp9Cujkk=;
        b=khYm++75qmoGRHJA4MkCjvgIV5SSGfSD/lgs8i7GmWwseFaysZFEk/PBDP7dmhyQEE
         dg0cLmY+NocyhQAYqeckGVxDtRZ8NWxLKHb/jHxz5Gpdby4LIrBya1arDMVn+MNZV7JP
         MpjjCTqnYTnPCn4jIS7MOsf+N6hxsWhxecMosTToFEhUjvQ/czF8xdLnZMsOcAqcoGsy
         3+OenYdASA/506VhCewFIsXvGPk2GjQ6segQ6WjK4JMiNgz98JCK0L8IDkUpw+IIwMCk
         wc75IbGXkM7HZr4uHtiz0RFp8h3XCZ8vuV35h0GdmGDB1sUJTyJzXt0iuBtDDosHf+mH
         MT7A==
X-Gm-Message-State: AOJu0YwFkB6n8AV4+Y0zP5WHEZ2MOYm9IhKGKuSs/GHyjs+mLkNsT8/8
	Ae/HlKbWt6piLbkU4HNAQhzKkLNyicvlNqQIGklfWN4vZNPwYkLSjyIWoZDnU1Fp
X-Gm-Gg: AR+sD12WDBJS84UT3lKcyiABAQT/nOfk889wCf17678Sm0FepOTd3DHNK1w9mjkgUOQ
	8GkRqRgHk6cjtSb4SSzzWMXIeIoIMrdTo3C3XAxJHa3RiJi69HiBTiOWTeOL37X/4uLpcxQwC4b
	pUS2QmJcWjsSlDJb1jh8zq1eKRYR06SW8JSGbX6nZvzT9YdIA7otu15RsgLK2DrmXUP6rIc3HOY
	mYpQVz3stW54f40rbxYE2lxQLaSgVSGCBMOYXjhsvp4WlaOulw8eY3mflPBDohZb2XGE3UX2oIZ
	moZqVCxahmMSBgi0VXFR+QQdUWeOjkogJthrRgf7u+WBopPMgBwdQ0cIu50ZheNcXn3EX9Ae5HT
	7uM8BjPcpni56koNxYUz512p3q8I8sG67eR/zZDSrlpcPXvJO71d1EFP2nGP3aXUcRA1iklbuTN
	W/BvT82/hJkn1DgFhWx/QnqSz6vFiD+BcEhLGjHtkV6V0IkFa/+8d7oGGBRGs/oFwUFN39kVG+L
	MNx
X-Received: by 2002:a05:6a21:510:b0:398:7ed3:a001 with SMTP id adf61e73a8af0-3c92a543d1dmr3175828637.2.1785591777858;
        Sat, 01 Aug 2026 06:42:57 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e5b0sm16077652eec.1.2026.08.01.06.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 06:42:57 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	vega@nebusec.ai,
	milkory@outlook.com,
	enjou1224z@gmail.com
Subject: [PATCH net v2 1/2] net/sched: reject overly deep qdisc hierarchies
Date: Sat,  1 Aug 2026 21:42:33 +0800
Message-ID: <1e9ab39597423fd5d13cfaaf52279b8ee3d9fc3c.1785434373.git.milkory@outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785434373.git.milkory@outlook.com>
References: <cover.1785434373.git.milkory@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijie Huang <milkory@outlook.com>

Deep qdisc hierarchies can lead to excessive recursion in qdisc tree
walkers and exhaust the kernel stack. The existing loop check does not
cover the create-and-graft path, so a hierarchy can still be extended by
creating a new child qdisc below an already deep parent.

Store the hierarchy depth in struct Qdisc and update it when qdiscs are
grafted. Reject new child qdiscs once the parent is already at the maximum
allowed depth.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zijie Huang <milkory@outlook.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
changes in v2:
  - Store the qdisc hierarchy depth in struct Qdisc and update it from
    qdisc_graft(), instead of walking the parent chain.
  - Move the depth check to qdisc_graft() so it is applied at the actual
    attach point.
  - Add tdc tests for the maximum allowed depth and rejection above it.
  - v1 Link: https://lore.kernel.org/all/cover.1785304107.git.milkory@outlook.com/


 include/net/sch_generic.h | 1 +
 net/sched/sch_api.c       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 45a1e8c78222..cbc248776511 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -99,6 +99,7 @@ struct Qdisc {
 	struct hlist_node       hash;
 	u32			handle;
 	u32			parent;
+	int			depth;
 
 	struct netdev_queue	*dev_queue;
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 668bcd60d183..65b35528d125 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1114,6 +1114,9 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		unsigned int i, num_q, ingress;
 		struct netdev_queue *dev_queue;
 
+		if (new)
+			new->depth = 0;
+
 		ingress = 0;
 		num_q = dev->num_tx_queues;
 		if ((q && q->flags & TCQ_F_INGRESS) ||
@@ -1211,9 +1214,15 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 			NL_SET_ERR_MSG(extack, "STAB not supported on a non root");
 			return -EINVAL;
 		}
+		if (new && parent->depth >= 7) {
+			NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep");
+			return -E2BIG;
+		}
 		err = cops->graft(parent, cl, new, &old, extack);
 		if (err)
 			return err;
+		if (new)
+			new->depth = parent->depth + 1;
 		notify_and_destroy(net, skb, n, classid, old, new, extack);
 	}
 	return 0;
-- 
2.47.2


Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF063630AD
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619510; cv=none; b=u1QO1gLSp0o1YoLHfaINI6+VgBv/XHfGFKzAXX/3s8wV8TV4P/cHT5vH7OWwv+vGSPQMKVQkC5e/y7NYae7afkf1xNSY47hvOR/g/CDQn6y0+7YjSkT1i4RXg79dsEVTDnMwp6fklCqcH/Vy96FKfPpEIOwPy59ZRjegzgojLSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619510; c=relaxed/simple;
	bh=X2XXRuA9n7iqYtl9UrrDX4fwoK7KSO6NbygIBSgC/Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cho33BpdWoYWRKYJenXAnQWJhaf2Wwvl6cO7IWKQ5MCYKrOa+7k+e0+r1ST6tOWH3fiPPQZuB3A0jfTOTuEQTb2vMbjLg+FUBYjiENVx2jsE8e3ic3vKIXrJtxsSdrTXZusrZMJACySAqf1mbSR61Keglcjjod9emoq0orjaNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TClANp8L; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TClANp8L"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1889823a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619498; x=1787224298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/qk6w1x0YNe1+kTmusGuXa4669G4+AgKgk9XUdFhAb8=;
        b=TClANp8LCuX2jcGdFJ6F3RLM9d2+Q+1YcYo+Vb3SaZRpQM+GhIrnJegrqe3no1+nn0
         3/PKeV4HLW4YLCmKGTgpBIApbHbXdz3eUbMvJ5UtiRi05fq0orpxkX5uq6YDqRrKyLQB
         MlK2kIQn7sqEV1aPf4yxjGCb/dlskmzX6HQuDaCsalqdWSElBi+QxEtwO5zJY3sof4Vp
         F2WMd2xmluZe9WbTAarmCE9j44WrQGiNKlJ9pIgIwWXhv0ZrJZCyYXQRT7GB3PrxIr5k
         7NlYuoB5VPuT7KGpOTeRg5l6AckdQul7ky6PMTN43SPq0zrsV8rS1fmDbWUW6nLoCSTO
         RuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619498; x=1787224298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/qk6w1x0YNe1+kTmusGuXa4669G4+AgKgk9XUdFhAb8=;
        b=YWcW9ZehYmnbwIOABA+gd/Ki8cwEZ5hVCAYNn0dNEBx3xb9ALghhZ02W0jpwLJKwWL
         7YrgB4Y3wYqKrqwMBlXHpUgBRSqHyrVfGx6r7QxgxObSImXegKzZRvtz4ed6UgRoBoiN
         G4ePQsz5yBgHYwuKlttql5Hf15Vu+fqFzKFRyM//xUTh0NgA6rqK2eUFj8gq/P7OemDy
         XZ5H0eQ1dkXcvfqSTeHCoiGBIxkF0KwTwwM3Bp7thkGDvPkm7GeSN+PITkur+Jqu7yQ1
         wjAoBAgdclQpnZBsuCeR1g7cgyWrLrdKpVzl8Tyqx9Oer88qH2fPc5v+CkJ4Hi3j23XY
         edrQ==
X-Gm-Message-State: AOJu0YwyGfkvFbatizcr4yGmgCJHjgNjWHxG0G/IAFLUnBV8Sm7Uo6JI
	NDSkuxK4/DPSTce7HNFidArBp79Po8xgDN02CnfmSDji/S2rtJqGHUCK
X-Gm-Gg: AR+sD13o0nBhOO8gULFGvot3QGRjRARgF4rUC9cmbtMl910PXoXI/dCfaSboXxOUabR
	teQKUQSfVMPt2itaAYLzjgSY4lkBPVyFXXZsR+xVxZ7vqaM7ltP45hwImcPQyWkTTUszEgDl4AI
	I5jv/ksuYxBz5XkGbAeXpzwlN8w++QAHFiuT/mXtmWhWNntK+X3DDTBzFHdOfEMzn5v1BSeVC1G
	4FPNcaIM4ncrH/HPZrD2wVzVJyAXADhA00qPJr5bTI4WtinfHClV2pln2aADaVVoE5XLnaAxWfI
	pVHk7Hw+pajRLH7uR9B/uOFXqPL9Ed253N5Km3Qs14oUqGrp23gBGi4LMuz+0RSwejhbqS7X1eJ
	otzmsz87PLb2D7n22tYW46KU9SkIUBP2CKN+ErL/VksoprnZbTfoJm7+H1bGqw4+h6I8iaxU1mO
	GGPorXvu+Y3lOYdWS6OvG2XbIcbAY0sO4/jNqWGdf8k1eCNmhzV/T5byZ0DEp0HFddYO+wsDDgO
	2j1qKukxZ9ETC8uM9DMcWn/MXS7CpzNsTT8EeqUcUZ8PkViZkHClJAptfBNZR7pOQKEbVp/l20m
	c9Z9Jic=
X-Received: by 2002:a17:90b:48c1:b0:393:1cd6:643a with SMTP id 98e67ed59e1d1-3931e2cf85dmr5828192a91.18.1786619498342;
        Thu, 13 Aug 2026 04:11:38 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412d81b220sm8616483c88.0.2026.08.13.04.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:11:38 -0700 (PDT)
From: Manush Prajwal <manushprajwal555@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] net: ethernet: renesas: rswitch: fix device_node refcount leak in rswitch_get_port_node()
Date: Thu, 13 Aug 2026 16:41:21 +0530
Message-ID: <20260813111121.1672-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On an of_property_read_u32() failure, rswitch_get_port_node() sets
port to NULL and jumps to the out label before releasing the
reference the for_each_available_child_of_node() iterator was holding
on it. Once port is overwritten with NULL, that reference can never be
released since out: only puts "ports", the parent node. Call
of_node_put(port) before clearing it.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
 drivers/net/ethernet/renesas/rswitch_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 6fe9648163..ffdc42f430 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -1315,6 +1315,7 @@ static struct device_node *rswitch_get_port_node(struct rswitch_device *rdev)
 	for_each_available_child_of_node(ports, port) {
 		err = of_property_read_u32(port, "reg", &index);
 		if (err < 0) {
+			of_node_put(port);
 			port = NULL;
 			goto out;
 		}
-- 
2.46.2.windows.1


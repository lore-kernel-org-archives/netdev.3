Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C54A260F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872766; cv=none; b=Fhyy+FuzPhXqtqSjCOYkZXNiqadqG5kW/utnChp0eu4Q8Sh5OZzKKpcJlVq1F1USvIVpcWdzvLKsZXuG1GH2VVPFH0LDiuQ4r+iclJKSlUgRZgACwMLtB9Au5ZTWOJ+y2H+fPrQtq6CwsFIwPy4iAtV+AI9PxG7el1j/TKwgsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872766; c=relaxed/simple;
	bh=iJKqaHq0Hyi1dwRzicToNHsSN2TXdceoWQwgAEZjUtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BKd+Y0AW/QRW2U0kearVzX+q3UfX3dszwHvnTI+qWAFHqWqwmYhchxioXYC7NdF2mrbCdh62w+zgq/nE2RanGMyrBUkydX0mZImyMEC5A2xUxPvpGEwV68hD2xwKEPovUB/8mteFxs+EcKs3ymFWqHJhhCM1mjjDl0FX9JDjKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ofWREvZZ; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofWREvZZ"
Received: by mail-oo2-f36.google.com with SMTP id 46e09a7af769-82067e86a89so1276269a34.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872764; x=1791477564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgo5FwnDqxd8ZjCJLuyh6GkRISOMT279GXhU4H/zTL0=;
        b=ofWREvZZr6Mj0sQXes1W7DNxtp6UG+sfCFmh18az0ZniGP7+q2fkyt8cf+0bkAMT/E
         RYCCX3AiFwguq3sDZ5aptXpUI4XjrYllAoq+OD0g+sKJllXBivuiDlynFxrjwI4Z8ut2
         NYko238h0/rh3X2oBoDKvm1YkUNohW3Opkm+1meHDB3EcdOifKOB37i15M0THZkg5qoD
         0Cj6QMqIKyhLReUhBaFHwiRunqRxBz2qnKNLSJadgs2UikFVQN/klU03+1ZllSTmI74C
         NTYx5Y+XggWvIuE5eKgWqpaodaohvgN5jTrXW4XolqBMAyXwF67xGzPyEhi5csbROn3z
         2s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872764; x=1791477564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgo5FwnDqxd8ZjCJLuyh6GkRISOMT279GXhU4H/zTL0=;
        b=xuxMLXUcj9dTVnvivV1JfoezCAaz3k6XVOr0ihnWxIhJFGZXSXWLMDSc2yjZEX6uGN
         M/FT0aFgpzrW8z6d9nO4FmwgPuX21o8lcB4CVttPZXXjkjjro+TLigxand6Yc3VUwGZo
         kt/XqVTafOuZcQDtMpXCJmn/XYjt6JwdPk3mZR7mdBZppcJG78oCrOp3zpUe7BbtkcGY
         3h7zns76oIy2ZCeZYm2NxsOGJ8ZeuABoXkfNLwzT51yo9jv6WynEKodJyCSKffUT9Qj1
         6zIR7BroJ5ksNl/+998nFOkOpVP06kptO3lX7ZvQA0XO25Gt4XDHAllBs1dBiItwchZt
         5hgQ==
X-Gm-Message-State: AFuF++nltyYrKJf0hNDI83hAwSyB+XGw5eL3r5MLa/M6CykdNZk/xqwQ
	9P59pP1AEVU9ovYLSjv4yyLJpXhXw4xWfHrSsDrfxC2hf9SuLGQ5Qov8TgMoUtFC
X-Gm-Gg: AYBFou2z780mtHE8p+A51mE6Qj6OmoUu2K76XUJ4G+OUJ3evx2iBqkzYWmZpNSKgZ/o
	73H42j4YkdkmfP44C2khHWXc5YmuI7oRUzRZvwEh3YDcYgv/RN8A4tQVVa9hWUrxOyiWpktDY6y
	7uUScvY9I++TyW/P3LUd5eaHZTNoZlpPwwMhU05KhD9HesXd1+b52JgyxGg7358ndA/+SElP6wQ
	lhgKHGYlJ+x6AKCtU9S+08Evaet6VWVtkGKPw0MalV3hL7hnzLGfRgKXMjGz+tSzBb83MtqWsYz
	GkwRNhZfhga+KKGrJdHp7/sS2p7QQ++6rcEnCgQ1gJpDkySwPtakY8HLTK4T5QMr6Q5LsLf8zKm
	z0RurkiuqNoht4Cv4PKJQKBSZXoq75fm+fEi2IyDFARJduvLbOuI63aOLGLIlZtp4JLZ5kYKZVo
	1Bot/AErgik3PSshIELIXB8X++lCQr0oPOcYGOJYEniSSKTr92WHNb8Z93hCuYbZn5e8s=
X-Received: by 2002:a05:6808:13c2:b0:4f5:98d:d1ae with SMTP id 5614622812f47-4f5099d178bmr60184b6e.55.1790872763618;
        Thu, 01 Oct 2026 09:39:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f34d0859bcsm2822362b6e.16.2026.10.01.09.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:39:22 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 01 Oct 2026 09:39:00 -0700
Subject: [PATCH net-next 3/4] eth: mpnic: set Rx buffer minimums using page
 size and mtu
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-linux-mpnic-v1-3-6422ee74233a@gmail.com>
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
In-Reply-To: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

Set buffer based drop thresholds in the Rx path based on page size and
the max MTU supported. The device will drop packets if it does not have
at least the minimum number of completely unused buffer descriptors
available.

These thresholds are currently set to 17 BDs for both HPQ and PPQ. These
are overly conservative. With our current max MTU of 9742B, the settings
we should target are:

4KiB page size: 1 HPQ, 3 PPQ
64KiB page size: 1 HPQ, 1 PPQ

The HPQ and PPQ rings are always given PAGE_SIZE sized buffers.

The RDE_CTL register encodes the thresholds as one less than the number
of BDs needed.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_init.c | 13 +++++++++----
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h |  6 ++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_init.c b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
index 2daed458f5fc..ace4124158fb 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_init.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
@@ -10,6 +10,7 @@
 #include <linux/sizes.h>
 
 #include "mpnic.h"
+#include "mpnic_txrx.h"
 
 #define MPNIC_MEM_INIT_POLL_US		500
 #define MPNIC_MEM_INIT_TO_US		5000
@@ -272,10 +273,14 @@ static void mpnic_rxglb_init(struct mpnic_dev *mpd)
 	 * the per-queue prefetch FIFO.
 	 */
 	mpnic_wr64(mpd, MPNIC_RDE_CTL,
-		   FIELD_PREP(MPNIC_RDE_CTL_HPQ_DROP_THRESHOLD, 16) |
-		   FIELD_PREP(MPNIC_RDE_CTL_PPQ_DROP_THRESHOLD, 16) |
-		   FIELD_PREP(MPNIC_RDE_CTL_HPQ_LOCAL_DROP_THRESHOLD, 16) |
-		   FIELD_PREP(MPNIC_RDE_CTL_PPQ_LOCAL_DROP_THRESHOLD, 16));
+		   FIELD_PREP(MPNIC_RDE_CTL_HPQ_DROP_THRESHOLD,
+			      MPNIC_RX_HPQ_DROP_THRS - 1) |
+		   FIELD_PREP(MPNIC_RDE_CTL_PPQ_DROP_THRESHOLD,
+			      MPNIC_RX_PPQ_DROP_THRS - 1) |
+		   FIELD_PREP(MPNIC_RDE_CTL_HPQ_LOCAL_DROP_THRESHOLD,
+			      MPNIC_RX_HPQ_DROP_THRS - 1) |
+		   FIELD_PREP(MPNIC_RDE_CTL_PPQ_LOCAL_DROP_THRESHOLD,
+			      MPNIC_RX_PPQ_DROP_THRS - 1));
 
 	/* Receive side coalescing is not supported yet */
 	mpnic_wr64(mpd, MPNIC_RSC_GLOBAL_CONF,
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 834eb9bfffd1..9397010557eb 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -58,6 +58,12 @@ struct mpnic_net;
 
 #define MPNIC_MAX_JUMBO_FRAME_SIZE	9742
 
+#define MPNIC_RX_HPQ_DROP_THRS \
+	DIV_ROUND_UP(MPNIC_RX_HROOM + MPNIC_RX_MAX_HDR + MPNIC_RX_TROOM, \
+		     PAGE_SIZE)
+#define MPNIC_RX_PPQ_DROP_THRS \
+	DIV_ROUND_UP(MPNIC_MAX_JUMBO_FRAME_SIZE, PAGE_SIZE)
+
 /* The page a buffer descriptor queue is currently handing out. Records
  * how many of the references taken on it are still unused.
  */

-- 
2.52.0


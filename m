Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B83E123C
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542166; cv=none; b=fXcQnpZ2AXQjqviuGDwHV+WcoJTTwjgdpQ3eaoW0ABVaHBnvWtzpB7PPDR12IYv2aA0GxjxsVJRgtgJSWZV5C1D+w6pZcb6k8D5HPObxShNh9yXE5TK6qZXMyU9JWdusbaBHiDu5fefrpPghISMPni3FziGsmS7SzP7kTbzHeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542166; c=relaxed/simple;
	bh=MzHFCd0Tz4e+Edg/Bq9oVoskUFiz7gl+EF8d1HofN4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6mBwonahK9/MDOtp7jTnthKG+ivGUvZ5zpCaCcwqwffUb5uCuULnuQm7mVk6XMAHm+G7pF5L5K2eHfRsLHIphNdt4xXtBTilfu3W0f8fjF0cMLi8FZtqYjjXIIx4Koj78v1M+6i1yQqAmFI0qkJgMdTreZLPXf/370wpeISwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HzSbCXiR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HzSbCXiR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954aff6088so17557325e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784542155; x=1785146955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oPb++nNOUKaZMzssqqTK7VRW9BEodDg7l0QT3ply1Lg=;
        b=HzSbCXiR/0+5O2iVMSZn8xWF1x7z3Cu4IKN9ikzzP/nQoO4pY1ga8e/BjEiMIBaupT
         7CVDdIU6TsbsaE0SGipppwOy2yGQhYIX+CgVV3VWXtqFn8dIxECujxDS64a5OdImlF3w
         Hq8hWfjPHDzLf/cQUlk4xLyBK0oEhGscNH1rZX/bGccCK5aiEsN/2U/JY+2bpE7lRUVN
         2a9+vhKx7VP+pUG0j0jalylNVOZR+GdykJrggr/qRClpdRld/NwdawE7yysqqNbr86Tc
         roChDyDuG9yAyTp7nF4gevTPFnLzDQdKvDrDkGb99Tw57DyJBJlIuL8Fshv9+ti6qnv+
         qE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542155; x=1785146955;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPb++nNOUKaZMzssqqTK7VRW9BEodDg7l0QT3ply1Lg=;
        b=RNa59dAKFVjFe4WZ/Sbg+1Wn6Xf+tp3DlpgRByD5Bv9V1bJJSlWVrc3+Jk6pDRuMlW
         yiWZAtYzwHzYor9Y/FdxvYKtjPXA0515rgI7TjksdU29a70ufnoUl9w3OGUFz8rB+KXV
         qBrsvfqDaj8W94ltjk3cL/OhaQG7bcoVHpBSd/Jgkoe3I1zrvJKXt/ZVHruCft/RrfrZ
         S+64kGq7bakdb/kqC0r/mCJcDu0NatNKl4z5AmATv4YzVBXqplCKXB67nn+D0A1k8ZOa
         yCG7+vdUm8nGFyQCTo8Pt5i4fxdSgIiG6TeP3uruTIHlbiHYPJhk8ovTy0eoO5SrOORK
         4WWQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRuDxPlhM6t0c+vgmjalKP2ZPxO1K0Ck7oTm/6m3btSfc2rK+RVHKm+w62yOl9+of6ZHR6vIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/LccFRTrbe0ZKor3CSg4Ybu5JzZvhmLNjCVnnn//zjNwXIrTb
	AlhQKyX7gYE36SIa3Iz7GVbxoIatxiGlWP6N2XVvvPn4F+5R9g66OJ0NQHsbQCzd9DI=
X-Gm-Gg: AfdE7cmzRPFWAj2f3vwsDqsUQzQ+nMUvZTXCr7GMv8WIyjTNs69Bd7AZRRPk2sZq43Q
	noYH34saSPsrBMA21otlQmsohzSd+1Y87FqgDZygp8grklKcQxz7VtUlKGnaB6E4djElDQZKbf6
	VgLqYy7F8BLMcK/SS3Lx7/bODMhi1WqbURw7aYP2qHJr5itw3/bKRGQhY99jJldCmsXllxTDw33
	xmXnpWY9JQbHXQqibaG5PdR9t92JgBItlVsWqDPo3qNQFbMVj/oJEz/o/LaRbPUjauIgZXmsDHu
	m73IUrc1R+Hhsyn5tkuvLxGx0YcDxxucXVuR7Bw053u+hs2p+RXaT6rwLi1LpQaZxoMDWDqmaUb
	lWFaCkqMlIEE18lQbzY9uP3fyt+ZOu9G/f6XicufKGO1J4gwjMq9ovFscfWRn+UlL3+8IYGr2jF
	WeJSKa9Oq8L9qH6UVn18Wu5ZOzJg==
X-Received: by 2002:a05:600c:4ed0:b0:493:c634:952 with SMTP id 5b1f17b1804b1-4954a3d0872mr146603125e9.7.1784542155280;
        Mon, 20 Jul 2026 03:09:15 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2504sm294792995e9.2.2026.07.20.03.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:09:15 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v3 net-next 4/6] net: thunderbolt: Move long delayed work on system_dfl_long_wq
Date: Mon, 20 Jul 2026 12:08:54 +0200
Message-ID: <20260720100902.155605-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720100902.155605-1-marco.crivellari@suse.com>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: Mika Westerberg <westeri@kernel.org>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Acked-by: Mika Westerberg <westeri@kernel.org>
---
 drivers/net/thunderbolt/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 02a91650561a..be27972bed18 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -316,7 +316,7 @@ static void start_login(struct tbnet *net)
 	net->login_received = false;
 	mutex_unlock(&net->connection_lock);
 
-	queue_delayed_work(system_long_wq, &net->login_work,
+	queue_delayed_work(system_dfl_long_wq, &net->login_work,
 			   msecs_to_jiffies(1000));
 }
 
@@ -460,7 +460,7 @@ static int tbnet_handle_packet(const void *buf, size_t size, void *data)
 			if (net->login_retries >= TBNET_LOGIN_RETRIES ||
 			    !net->login_sent) {
 				net->login_retries = 0;
-				queue_delayed_work(system_long_wq,
+				queue_delayed_work(system_dfl_long_wq,
 						   &net->login_work, 0);
 			}
 			mutex_unlock(&net->connection_lock);
@@ -700,7 +700,8 @@ static void tbnet_login_work(struct work_struct *work)
 		netdev_dbg(net->dev, "sending login request failed, ret=%d\n",
 			   ret);
 		if (net->login_retries++ < TBNET_LOGIN_RETRIES) {
-			queue_delayed_work(system_long_wq, &net->login_work,
+			queue_delayed_work(system_dfl_long_wq,
+					   &net->login_work,
 					   delay);
 		} else {
 			netdev_info(net->dev, "ThunderboltIP login timed out\n");
-- 
2.54.0


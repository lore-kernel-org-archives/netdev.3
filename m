Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD503BC668
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798915; cv=none; b=SScYiShFN8XU9G0l1zTWPoHEsOkfroMDnv6eiSiH65fhLew61x6yZtdmdREdZiZVKnT/SJwP5aozByC1bqwnZTIbYnyI0SeWvGRkmmxX7WnpULYSFhq+WYaDQE8fCv1KK+J1qfdflTWp0sYg04cv9ins6gZdhMqmrjKduc6BOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798915; c=relaxed/simple;
	bh=Amk8uD3HNfuuztl7q0RyRF92LjutyVBvE3JyMlDZ8Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9xTo6iar1+J5stRQI0JDJg0z0q7R8UGJypigA9uS2IdHoK3a8xwwHse7GHwW+IQvBUMAVSzBztJfU6m4gL+bbOcU4kBphvDtqrxVy74L60/RjcQUDb1sHy2tlZaYuWl9HkRTgHM8CMEImsUBDA7RTr5GFvbyr2RUirw1QcJ38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kg5QErhB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kg5QErhB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b042c0759so1213936f8f.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791798908; x=1792403708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kVFVSCKYu4LMX2OyBp2Sx2+yDSioFsB6HDpmMFcR8pE=;
        b=Kg5QErhBsDRv7M7FGg+n0K+CPIswYEEbpLKbRmc9qYGEWeRI0zW8BiLTYyNN4iqwY/
         Ci0+rkdqARj6dgW7W7bHyd6yDK64GRosR8U9GCOkqwPQQIOWgzxwr6wC/tc7h3kFv/Zt
         757kWpgj3ZMEva2cnZCDDGGjrHpOmSATwRhREarnFmpcoGztgHY3+dKY8c83DE20fdA0
         y++Fc5UXIV5lPy86N4S86+693h0tT+Zgr/z7LLU1A3QbKQJwrxQotdEJWutItPfiVfpJ
         qUwMYM9KTcqoloIDSTaikoMUOXxqWxZsVvrPIpQnTt5NTJSAaYt2oTeFlIJQA1EV/NXi
         3uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798908; x=1792403708;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVFVSCKYu4LMX2OyBp2Sx2+yDSioFsB6HDpmMFcR8pE=;
        b=Ay4xRxJCONk1iRM3xUsrg+Ysi3h2psXCe4pqPwxYaixaOh6e0M4UGbYAxtEguJ5sUl
         bMQqwY+hgK/FSszLmyhdwr7wVecmjd/ZCgCjFs0t5PQYzIwT1YedZo8pkHYS27n7ULYF
         0HXSXZoeeVTuVKrYnI5jMxZ2E3caG72R/qZxxgElQNSea9QOvFg3OXgaNrNKpxOtmaK3
         wI1lpyE9CfU5KV+tERz77lXJeXVtqhpgb7yPEEIiv/JTaFjM2ex+v5FCQGdcdUjUHfZr
         JFobFBDWXw7yG3vR67N7ZenbaAzxUYzXdgb8CQJvW/xJ4tqq3Cim30zhGY7jYdluF0Em
         Ldzg==
X-Forwarded-Encrypted: i=1; AKwUvBzmUCQWt4OyoLpPqnrkFFJERBA0QSZVEt/GzYsNO/Pffpw1VZAwoMaosiUMEVJZgbXavq0HtIQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlZnNvVKNuQgPELD+48DsiRRfQesIBNV5G04o+XNUxV9MrHg76
	wgHWHWype/Ia+GrT/8ba9d1uSIteiCqVW34A+mXwYqWXy/dxcDAJvCstVGKTgKa/6Tk=
X-Gm-Gg: AYBFou3C+vO5ZABRGwyQTBzNgEzFdsOWSQ1bevG2EyuHB7/Gn58xN953BJr/F1nIpKA
	u7FMv6yArhO78TmKqVBDiWX4BmLbv8T2q4+Mv8C4VjfWv4z7IgEBUc5njMq5hlv2TOaaGq2SYqA
	UDmZwwKY3EIOIvRiUgwHMk+t/rCavCqOOPeSooQ8GpTusDalo63TziLRDY91vZkxBqOESBdj2Sk
	mOgUSj7C2TydBcuN/Niy3JWyRQG6gpLM1+MyH6qEfvy4BxqMmGRB7jERsKuZlxsqqc0fhgcCLdd
	/r+ib1gsPb6bHNBsjaTh+qUqmG5yRp9AW7DPc4KV+UGsgJwQS3xCtJDiG2crWGXPWJvtq/qXyY8
	0IioOso2cF4cHWPp5DInsQA8xOTYjtI06yPg9exs8OwmDo38rtNmSKkwrENJyRiONvQbKZpvJtz
	yhw69AZBVb9f9nxGrhKhXK4m5OYNeoWDl1NDb5M4xyp+kfk7xA52LNI1zra247bhLc6CEgO9igb
	YBUhxGNhsWAdksAsctAYA==
X-Received: by 2002:a05:6000:2505:b0:485:8a47:5b91 with SMTP id ffacd0b85a97d-48dbacf6fc4mr14133924f8f.46.1791798907696;
        Mon, 12 Oct 2026 02:55:07 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c2800sm18539103f8f.26.2026.10.12.02.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:55:06 -0700 (PDT)
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
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH net-next v4 2/6] net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
Date: Mon, 12 Oct 2026 11:54:41 +0200
Message-ID: <20261012095452.135828-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012095452.135828-1-marco.crivellari@suse.com>
References: <20261012095452.135828-1-marco.crivellari@suse.com>
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

Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/net/ethernet/ti/icssg/icssg_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155c..7d6d6692d819 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -69,7 +69,7 @@ void icssg_stats_work_handler(struct work_struct *work)
 						stats_work.work);
 	emac_update_hardware_stats(emac);
 
-	queue_delayed_work(system_long_wq, &emac->stats_work,
+	queue_delayed_work(system_dfl_long_wq, &emac->stats_work,
 			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
 }
 EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
-- 
2.55.0


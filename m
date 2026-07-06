Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CB3749F2
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345246; cv=none; b=NX1k+xI4fQHM2Jd3lKjhW4gqmhBFFsgEfuPRX0xCGO0qU4TakuTlIHeJk1DR8y0q+JuAezvj7lb19travRG/WvWahwPTUpguEVh+tG8S4k4qJGuPU77OGcx7cng4qEfHQVH58x/0egrBmPx/FsO/EqNGkjH0IDTooiriG6GCSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345246; c=relaxed/simple;
	bh=Rv9DeY3sVQADSDinNUAIAVGb1zyRUZLjDXTC9l8OOCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqSdnniiZpCsUmJI++QT7B03LQ4HuZSkViIAmbnoUOE2fIocEaWdumtMY8wWcgmA5Bhu3p9CgfxS0EGHML1EgIgD6flbfPyuCeSdiwXaR5Wnw83tNJghTDZvupDGAnfEzxQrctwkkJe04YYa9cFg1mSkoYQuO+I83V32dorqP7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TKDanMyO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TKDanMyO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c19bad03so28295785e9.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783345243; x=1783950043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6RbzNK+eNCezcWvhoJEyPH0JtE0jxe26kaL9SwOJjI=;
        b=TKDanMyONnjydayose6ATzVlsnWaCbW2zOk945/mK2qEzVYOGIl80RFZ44vc835i84
         teCQc1zzmWWOoLhBAufnNHNsUMCSnPhWXc48uZHaF8lMfL2XX6YtUhF0ZEMBNQFCXa87
         1OeaDQw2rvTZMcZBxX3o32Bo4vADF103lM6WOybexuWGZFfW/pPGcWBYiJeam98F42EF
         Ekhs/L/Pqc9BYT2VJC5r0kv7QjWouoGcInUb2p/kqF4qSam+oilP0ZadZE+TkchP4ajh
         4snKkcz/cbBOQgigWibbR4LdDj+wRbUA7TqXhF3tM/klI/BDtRMwCtIY1m2Tab0J1HhI
         kStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345243; x=1783950043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m6RbzNK+eNCezcWvhoJEyPH0JtE0jxe26kaL9SwOJjI=;
        b=R9sNSLcupLf4cGh7q0JEd5Mb46Ej9AZt8i6LNZDnScKCEYXh4SRy3wDa88fmuR99e7
         h1vWTYoxwryxCPN9spvmfPV5BLhPnxEjvreYX/YYuyzT7gkku8/PC0hUvzMKM2ioyCaa
         JOHfXbsohhxT3xTkatX0w6GOns+NEEtTbyPpmS6IaOXvhsA3OI1ic4n5bp8+adeppf7N
         FQBFyoAqT1Tx8O/FPGz98jC0WafwawfkbzBUwA4Q756M01MpLFx1JPd1Fhff3CIcATzQ
         TTNM68FYIuk8rzB2I8ucWJjIOlKi+ITXs9tJk6AUzE4GOL6bzUS/+EZkvFr9X4jp8wdf
         O+vw==
X-Forwarded-Encrypted: i=1; AHgh+RqeDniKn4vsjsCI0SnuPweX01qxH2S+4Dzl7CvPiRBZeOh+PBCdP7WYVNzxNkmRt5h2BU1WKS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7hKLJkGNWLe7nIW3bPEJHqcoxibgxWwBMuKyxTH6+QMGkJJA
	GIkEjG7DUT379MtteqMz7wgJxxIn2hFGtGk6/FTxNF5sVVP81Xlp6T5vH0mxIY9GGgY=
X-Gm-Gg: AfdE7ckzrvHN7Pwrb1wKSIjNNBwVaAXSHZztliRWckEdnthCPep97bTs1htbXi6NmUj
	u31arAzQ+qtz8OoaBqH6oS/tcUg4ErV4ERwlZpHjOs0NoOeymcyxb18t7EujMbau+cZrBzKfbcv
	ECA1S80Upnq32QMl5A1vDpUtQXBf29c5pyeweADasOyE3UluuMoKUL0xCL85JRw+kQDXQPBS1Zf
	fdKTnf6dIQMMNoJ10D4ywMCoJQWgrhUUSuKhUNm5tlx056zYUZ4lAEiqR8Xz3dH/0qdQQ3dEAf/
	aKE4JbOMsEJKohDuWq3ls2hAtmhqKdXQTVOBn4iG3ng7XvZTMHhHjEQcpKwcCgWhS8eCXqnyo1J
	GPIN4Lm7BmLN6pQOYA3xxbb9GJHmFhSMrUXveR6NnZG31B6R+7dfe0n9oQ4FK2U2RkZtTZ8Fa3Z
	KvbMGsjCD7CrOfkeFy9LV///qsU8I4A3BqEmM=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id 5b1f17b1804b1-493df06e943mr6108015e9.25.1783345243589;
        Mon, 06 Jul 2026 06:40:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm24424868f8f.33.2026.07.06.06.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:40:43 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/5] net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
Date: Mon,  6 Jul 2026 15:40:25 +0200
Message-ID: <20260706134033.244295-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706134033.244295-1-marco.crivellari@suse.com>
References: <20260706134033.244295-1-marco.crivellari@suse.com>
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
2.54.0


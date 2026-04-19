Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03186329
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776634947; cv=none; b=d0AJnXSXAUCFCmZ0GgXQzy/WHeqhccPeJsUEU7cmeiYL/obFONPkokvbDebhm8AK96ofVRA1I+NaJvdp/vCFxzqvEmp85/ubtlAOg2JieHLaqxJlsTQ2m2JsVZUjxXYYia7pe5fw5jmOhNVp5jj23Ymx0Ym+2JdCSD4chtv7o10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776634947; c=relaxed/simple;
	bh=gw6s3vnIxJ9uTCmH8z6pU2gzLZpggQukHai+xXAmDWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qd9BMyBtRXxUTBdhB7tU8w1QBbJyzBQNwt1M9G+f+jQKcq8y09nBqPmmKVKNJDipOB48SoKhE7p072QzFg15DUXfEwNcHMbKYFyCBo5z/fiYV59MQFJx92CmTI62vMqlsVI4tYM6KbZaWxA1nWNt8Z1CJt18vSO1WrnlnsA42/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=tughlEy5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="tughlEy5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so3222035a12.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1776634944; x=1777239744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J280H++whneAEaFqspPJ2mzFXuoS+YNva5vD0t3AK0=;
        b=tughlEy5MJ6YK5EUYyoQVyywKz5mDB5zZjcFYfQE/iQHtdeQTium+ZDLe6uoNVUQiW
         KVfnWui7IFQpBkRjiVKu69Q5NazgoH9GfeOv+SXeUGdj/REL6dfQ6eNfCrc7TAKIgaUc
         DJDUX/bLDLAO/tY3A6QvhlfJosgYBpM5t7zpAMxDrEHnZbqMFtCbBlbY/g5asxQSC8lX
         TWkTNovrEf+fgcDZ3bpTSC17Ugi2n+0/95gaDghLiieI0bOYfIJ3zk/VBF34pNyIqi7M
         CImqxAeQHJ4e4A81H4O9sdEihj+MluhNVm7gFOcdWbzj5qaWXhWNyZtG5TWOn7PERDWq
         GTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776634944; x=1777239744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J280H++whneAEaFqspPJ2mzFXuoS+YNva5vD0t3AK0=;
        b=P14AL6biu3IXv/IlVKFCwvaH/dqT2kxfIyrTE/1o6IGhxoXfUu3wxuaNwfNfEYR++e
         O8UgFMrrtSBMvAO4C/EoGCAiUviSwHf3QB+UClcEUI/PSsj5w3S3oXXRk1ktexACOH1s
         PY4E88W1n+9WSD6fAVzSxoO5RB9rEkpyU+x8gLoLCqiWVPKd3BmFx/7oFbdA3AycRPWX
         r6u4bB4hQ1iFIFh0eDUXKsVrcHBJ4/jWl5GY3QDa0Kz0mSaiPizj6C6ffQmZjTdSq4n9
         dGjEZMJ497m5ES89VRhcD1APvJqZb8OIRVq98AtvrTRHbWFc2eBtib34nrhV3fAYMTgN
         c/Lg==
X-Gm-Message-State: AOJu0YxFYs1ClAT+V6t3fvLr1d0yIlPg67BjQ26t4lLJBiVIDRftV3Dm
	fAu2lK+M1ynHQBVc/KE3XYfM5852UVo2YsWPsh33Pq2/j4a5VbMUtDCtNW3FcmL1P8M=
X-Gm-Gg: AeBDietlgzLrL0bkjY/+AgbfdzyYR4AYiM+7xQT5a36j/d3N7zsoxGSSnsyUQDsxjBx
	yPkYKWjVdst6hN4K+ljAGS8H3SQLuW0l+R5LfQXNe5/4ZAhdcrIhzlBMSDLE2wnqdSPyUy7LKgR
	98u7UB2R8o99TFah5W3wOwxor0EdsSAUSJA9xlpCPUPwk8ziFo+oQe7IEYs4iFumOM/BAcTE87f
	K48xULc/4vbRTbBOTUcVV74VqwIUj5gyEEibVN+/1nxJM52Hon/3jjS2VwKEFO0yX8RYr3xpttl
	8B7JB7YLE+lnio4dBizDx70Ewpc8VapqicCy7dKIyjNNsbD2g85T0G1Y5O+ogfz7ZM5EGGmbdjo
	ODTA6Rp+wItX2SlOhPkhTixHOtfUbA40jnKHct0ChROfUI638jw1raJXpwQ3mZa+WCVN2awLO+w
	9RV0Fv2XfihK/H+X3AuDWo1yzFKCOHnQ==
X-Received: by 2002:a17:907:868c:b0:b98:6a8f:7916 with SMTP id a640c23a62f3a-ba419557e44mr546980466b.15.1776634944439;
        Sun, 19 Apr 2026 14:42:24 -0700 (PDT)
Received: from airbuntu.. ([185.253.98.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45504441bsm279225366b.45.2026.04.19.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:42:24 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	John Stultz <jstultz@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] connector/Kconfig: Enable CONFIG_CONNECTOR by default
Date: Sun, 19 Apr 2026 22:42:17 +0100
Message-Id: <20260419214217.108901-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make new tools that depend on it like schedqos [1] more reliable, it
is important to ensure users can find it by default on all system.

[1] https://lore.kernel.org/lkml/20260415000910.2h5misvwc45bdumu@airbuntu/

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 drivers/connector/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/connector/Kconfig b/drivers/connector/Kconfig
index 0c2d2aa82d8c..bad247d47146 100644
--- a/drivers/connector/Kconfig
+++ b/drivers/connector/Kconfig
@@ -3,6 +3,7 @@
 menuconfig CONNECTOR
 	tristate "Connector - unified userspace <-> kernelspace linker"
 	depends on NET
+	default y
 	help
 	  This is unified userspace <-> kernelspace connector working on top
 	  of the netlink socket protocol.
-- 
2.34.1


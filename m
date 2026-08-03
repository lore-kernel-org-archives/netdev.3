Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D942F6E2
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781148; cv=none; b=civnTGrTEz3teNixTRo4BExRcsotlPma/tklTWKQT0bJ8t341IMIMfUaBr15ExXoWCs8QOEAWJUX6WmwqSNrcJ1xFPCyoRmF1H7BFYldYa+I9bKNwX07uMNHPLpe3RK8Ay1qXohRo1W5u0SnL+zwJN9u5QnDggierFR69zz20xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781148; c=relaxed/simple;
	bh=raK8shwkaaPHW/yd1zlOipdRHT+xg/2FiiC1Ujgc/1Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KXw24qDRrR+YVdfeLVEJwOqrNlbRB5cVXFVbXv5S4FxPFBT7YXt4BAvx+WLmEnhWvex3N5FEzPuoEA1QPxS7jzfQdHpVIiqf1m6XjNHdwsDGd7aESJDPMUTB+5SX75OdLPqvOuok2IFBGyS+aw6WAjTpfk7fTAuglubWisO7stA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZN3ePKFP; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZN3ePKFP"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so4842711a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785781147; x=1786385947; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rk/ZaDQXy7W4s45i7JxVik8cU26Hiqezbm85GUMkrUE=;
        b=ZN3ePKFP0I9K68dC4/VkSXwoSj2u9n+VKh5NIUoalA3aMheDeVXBUvz6CgH4adm76/
         De07cky7qvFCxWbZkHNJb9/fpucsRpUr70jcAT2HPhOjVjxcP0liorNIW6LFJ6WPs1Yg
         mO4N5fQpw19Uv9++9tNokeN+lT/+n9nSdHiyp4NftmeTJjZtBssSRSbXZmi8KBw84xSh
         saTmhusjB+a73izSBAm7GqkLYxVAo8BKy1NpFriOJ90uEu4Xst/zNHxyj3MjfA6J5oaM
         MqSSJSHKkrU1S/BoKb80lIOOKVQ4oPoiV3u8CexTgE6vOMv8gxl1G3nArWQ5Kp5pqXz2
         O6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781147; x=1786385947;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rk/ZaDQXy7W4s45i7JxVik8cU26Hiqezbm85GUMkrUE=;
        b=kfrrn3udINRrX4sV2gOqGn4fuOVkBsryX7pfSyJzSh1zFVIprHOExzQetGkSWkFGW/
         Ako4Pb34hHlKHj7xkkMNlDWAA3w3LoEzBHNlQxO3PCet1RIQu5urvEB1iya6gvJeqpf3
         MC4ayMoLcrVWOBnK9wCY/dQnu5SwUQP27IyM1SYAajzG+p1w0jkCCmzkApgqBG5YiwP6
         wGxEsXgodGrVTRAaV95Qx6ui04my4KTOdyzOJXv23EVu9iNd2oqEwSLxpoHBW1V77J8V
         nB+FGHgeEdK2LYy1b7LzbUoIrmPEV2cCE2R8QiCGBX64h05eFBFXfNLUx4ah38oVk4Mx
         pwEQ==
X-Gm-Message-State: AOJu0YwHbnuGhaIg0ZqTD7/UrogxKp6CXV/W2oh8JsDQ+NT03MNtBHXT
	POYGI7zKoGcjJRWY0hLcI9l8MJHbr606uRNjKROoEj1heTrjtHpEFUxjgc3tF7wVBBVjdSDC47/
	XIO4+vVRSMMrWV1y3HpZ4q3rQLWoT4jcDj+tH+11M/hKqnJM+2mX9Olnu6lkraPtKp/gUB1dtAs
	EWSRsAHUrTJFpu3/n7DuisJfO4XSTe0ta1AsoZo62bVZNtEhyu58qmXspg5P5KS0Y=
X-Received: from dycnn12.prod.google.com ([2002:a05:7301:140c:b0:311:6a48:9c0f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7d0c:b0:3bb:2200:f67b with SMTP id adf61e73a8af0-3c92a8139e7mr11604873637.40.1785781146359;
 Mon, 03 Aug 2026 11:19:06 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:18:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803181852.491437-1-almasrymina@google.com>
Subject: [PATCH net-next v2 1/2] selftests: drv-net: devmem: fix 5-tuple flow steering
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"

When configuring traffic for the devmem tests, 5-tuple flow steering may
be required if the environment does not provide network namespaces.
Pass the correct remote address parameter and fall back to 5-tuple flow
steering if netns is not available.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/drivers/net/hw/devmem_lib.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
index 0921ff03eb81c..3ede6fd426929 100644
--- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
@@ -111,7 +111,7 @@ def ncdevmem_tx(cfg, port, chunk_size=0):
     else:
         ifname = cfg.ifname
         addr = cfg.remote_addr
-        extras = []
+        extras = [f"-c {cfg.addr}"]
 
     if chunk_size:
         extras.append(f"-z {chunk_size}")
@@ -212,7 +212,7 @@ def run_rx_hds(cfg):
         port = rand_port()
 
         listen_cmd = ncdevmem_rx(cfg, port, verify=False,
-                                 fail_on_linear=True)
+                                 fail_on_linear=True, flow_steer=not hasattr(cfg, 'netns'))
         socat = socat_send(cfg, port, buf_size=size)
 
         with bkg(listen_cmd, exit_wait=True, ns=netns) as ncdevmem:

base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.55.0.571.g244d577d93-goog


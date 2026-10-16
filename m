Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D224A482B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154769; cv=none; b=SqXfjkEvhs15JnoKuZj9qYgD87Hq2XzjVwwQ+XtGXn4IDfZ9ReqqJgXnghXAEi/rhedFFB8HRnwLyikpVhfsgJ6CLuQSwTHwxSaj4caT24rybm99Ey9Ye7pk3iqNnrA2eAjo6w+BdS2zvosUkIkgb70oKYnA5i256K9nxyLQBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154769; c=relaxed/simple;
	bh=lKAkidrvbBJ/vTXYNpqVpCG9VNbWjHMk4s8lEayu9QY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8hZ+Qb8vjovJ4P3+9oZr2QMY46vKw+Wgq0MyYOT2lEBo8suGZ6wg6dU/UdYhbe5KNLA8rBkCvBlnX4/Hvi4KkXfym6C2HOudiQkMXHnqx8C2O8FVdpmerDVXS62hj9/mNxC6TihhWpKzLL+3pe9yRspb55AWd9oXdYxIrgz0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boDcVw12; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boDcVw12"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab98332238so3766295a91.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792154767; x=1792759567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TrslgNHse2Dg20EAEUVpp54Hl92z5vT+wdBvkKVG3Qo=;
        b=boDcVw12UrVWhMkX6Y79s5SYBhSnNzOYML/hJzXJsU7wbdaUQYiv9Kfl2zjUzvuZL2
         tc6Ijo4lF9PJiXKns5vs1ctbNfcC41qzmYtWwg6WhPWjS49NaQCtB3+YfI0YuF9sEOB/
         mxNeY5YMajRUhe2cePGZPfXmhgijhEfAI+2boCtjKLpXCr6QH+97Ps4dyjaMULOLhcfw
         wg6wpT4O8OzJaHHrQucvw5kfjXnCKbwcfjGM6G3LXvSEqDLGP95zMcX+qPXawzuUCAiK
         fQRPIpN/x41dYlp14jtKhUwph1eQy6t1o63dVhOQObxCFHJd6Q1Xzct0zCjrAkcvAmje
         ypNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154767; x=1792759567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TrslgNHse2Dg20EAEUVpp54Hl92z5vT+wdBvkKVG3Qo=;
        b=IOCmrGyOQMKAnq0lJPX+MusN/I9gAD6/AP6v2qL8o7CuVmFTSHFrcWpshsANHue+SC
         IuKaQEqlb+xKoBF2QWHf2eHSXNwtQTLQ9Wx3mbyV977RIEpAYYp5ZR+xjtyFCm5bPoKl
         EF+af4KrhZS2CiqFrUQKC4d5i/e6bs6e9bVS9/DjWppXkyN9fS+bnk1V9LlLxUg3Wa9v
         l5bwB8Gjw252WpDq0tPCDFTj0x5CqAtACyLgKJTKX4DaeMz+2AMAtxhclsa9MWoUzWG0
         4TokyrISjK3qg47K5CT3g2vNJxhpjnDjGzKZLghVQiJVOTkokUGSR8eH2+QaNlXy7jA2
         ZzGg==
X-Forwarded-Encrypted: i=1; AKwUvByD/HU66AjdVdsKn2dufx6ehIJx2BnyBiRQNqXVZ2vui3EtuX4czaO+j+lsQCk4ZQimenzBiLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8C2AeFTNMvibYjciT4aujpI6e2sYgl5xJwTnoTLHsekDlYr7W
	q84LcgzlXetHxrEkMdDyso/bd0VJfk0yQy2uFve99zaavRH31NoLf5aX
X-Gm-Gg: AYBFou3Vze5AIZCf/VzYJSPKE/6i6dfG6DK7svVLmppNpeGYn4R6Oixnc0oG1dKm3J/
	Q6rBnLBHHfRcfmksf6/pykYwlW9j/qc29054pbF6ZR1yE9F6FB77rka9I1wk6Cmu43vK3ujGZeZ
	krclZeBczCoD2dcGq2fJLkVNQVZRQ6qzrAbfjbdBNjAr1PJXF+22nz4Hf60Pw4x5kdKIdf5+rkU
	GwFEdCv7C6HmZ+PVBBWj/RBRPLx12A9MtHMdjhgLO1VBASe5KO9D+53P8veGKdMWJ+Ylv6Ya+Xw
	HtrcxWwCwWQcEZSsY3AOVmXqhHoow7Sl0dO2ficWBxQ/yoP6axAZtlQemtRdZaMI14YGni42WrN
	+kYyW6TtqnEzdrKLtFuhJguDU3kHSQmHxpLZlaM98sDw9+6GunX9aoyzPxt/alTIztXB68p8NFq
	53eqO/qeaB6Ip2te1h/UMdBywWCAbPSii9vW71BE1WoogOP7aLA3LJZRheqNnmSj4kxDTcIVZ+Q
	i+wRWlXwaezVQ==
X-Received: by 2002:a17:90a:d604:b0:3ac:8af9:4a6a with SMTP id 98e67ed59e1d1-3ac8af94f17mr5664608a91.42.1792154767359;
        Fri, 16 Oct 2026 05:46:07 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ace34c8d9asm753751a91.5.2026.10.16.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:46:06 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: mani@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
Date: Fri, 16 Oct 2026 21:45:59 +0900
Message-ID: <20261016124600.31-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
register"), qrtr_node_enqueue() returns -EAGAIN for every packet but
HELLO until our HELLO has gone out to the node. The HELLO is retried,
but the NEW_SERVER announcements sent in reply to the remote's HELLO
are not, so a service registered before the remote came up is never
announced to it.

On Kaanapali the modem sends its HELLO before it accepts ours. With
rmtfs started first, the modem never learns about rmtfs and its
watchdog resets the SoC about 40 s later.

Retry each announcement for up to 10 s while it fails with -EAGAIN.
announce_servers() runs from the name service worker, which can sleep.

Fixes: 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint register")
Cc: stable@vger.kernel.org
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
Tested on a Lenovo Legion Tab Y700 Gen 5 (out-of-tree board support)
with rmtfs started before the modem: without this patch the SoC resets;
with it the announcement goes out on the first retry and the modem
stays up. Starting rmtfs after the modem avoids the problem, but
distribution units start rmtfs first and let it boot the modem.

 net/qrtr/ns.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index bcb090ee79d4..33a9c4449d6f 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020, Linaro Ltd.
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/qrtr.h>
 #include <linux/workqueue.h>
@@ -226,7 +227,13 @@ static int announce_servers(struct sockaddr_qrtr *sq)
 
 	/* Announce the list of servers registered in this node */
 	xa_for_each(&node->servers, index, srv) {
+		unsigned long timeout = jiffies + 10 * HZ;
+
 		ret = service_announce_new(sq, srv);
+		while (ret == -EAGAIN && time_before(jiffies, timeout)) {
+			msleep(100);
+			ret = service_announce_new(sq, srv);
+		}
 		if (ret < 0) {
 			if (ret == -ENODEV)
 				continue;
-- 
2.43.0


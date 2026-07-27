Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54C3FE36D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157092; cv=none; b=Y5olGw7GcMC2DfM+dw8Z2BLh2+QXDyAYjhVMbLrBUGgNX8CS8B7Z3jQS+5ollyfQet5d47Vc4QNEsD4j8YTalKkTmj0PGXfOZjws9uIx3CzftWYy0eRd47Mw0Ch5q5d61qnMk7uaALpYNpb80Y0H7xSh4QnQeesHNXkjl8+5r2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157092; c=relaxed/simple;
	bh=4S9VrnkVk/Jnnwkw9WnKREUKwo6wJLcjp2BdxtYkgVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSJxBdFElD1hChpdaZXJiIpXWoAamPr/DDSzixhjOg1aC5/eCvW9tXmZnkDF7RVdl6Gw1Mg6z3QlNYkMr+UsiQPYyryjvvSF8jvm6Lmbu+a2PaiZowPV+LRwTRW87oEQjJ4gIkjST9ofhNR8YMFl8j5Lo7BUo8IBZfOtXeuyZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=yENEnbiv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="yENEnbiv"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso2638614b3a.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785157086; x=1785761886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WT7tHWse3W4hfBtv2lPecVh078HRIciCJdRTk6IvWWs=;
        b=yENEnbivviQI6o9KtaNG3nr3tX9R7vjH3SKAhVjcZK54XQ3lVGIMI6RTbeV63UO94v
         bz2X9wVckUQ++sxVTyGLpjb3sEmNSJnE+/WTmwfPKmEwq1evyjS10Ji40uGCfmK2IAS5
         KJpEpPENwgQNPASx2/2lVO1GscGEIChFuPBppVv3JSJMWz8FrS6xPXicO067iT/CDhCV
         r3T7FUBL17x8AtyS1k0Pcl66bTtUX+Z9wsXxFQvZPTPDf6uKwr0nG3Y/bJSFl9DyEhym
         5qZ/a6jvkVhZyzk7qdHz9pYwmQxfcjc4kA83Ayx8UL/F5vwqLywINYooyfMT9s668LlJ
         BjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157086; x=1785761886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WT7tHWse3W4hfBtv2lPecVh078HRIciCJdRTk6IvWWs=;
        b=UDY/OhNTcIajMQhG/efQ5yPt2nZWmdJ7qROVXVJZQ59JXNGVscdPrq+jT8/c96BfW/
         /umizATJLfioEQmbCfw1+dk5nzcjlRZ34rLfKLStv2zmPFZAl39+KRh1ok5orScSdSys
         5RLl4RVw7MudRt7JYJbX15majxU/QyBPvz1z8+g7SzCnrODcQFqRtFRampVPP7SnAkRR
         8yv6sCFCf+wISANRQGkt1IBrwqFYez2QD8UzK3uj3U+DiZsE4ZVFlr++kFeXd/0Lhwep
         mPapuAhyJ4zxwfD8HWDqq0iZFUV4VNoqOqJFxW288t6ZQYw4gULYk5isBAlVJ688Lx4J
         eRoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7+Lr+yjPT42a64HsPoPme+xcU1WUKOeQKK+auP38esjggNj+kTsathbhxFKKKNIizeDkeFoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFo3qkfNv41LYTTLxWRPwL4dc9q0NU842LTm4E1tyJeDKwwyl
	bA4ANTJW56YdI49F7ydj2V4/ETjyIqappbDirV3zNsUYXy5JsWQ9uoebkX6/wZOL84Y=
X-Gm-Gg: AR+sD10E9x9vaTWC4sS9zgvej853pBlsTw+qt7O7nAoBXBcbcQOubkf53mPQWPUGwbf
	QKk5ViWWR3XWRNeD9Fd8+jitsxGOIQZqa2RpPtpf4UHFVhoMEkCiofpsls0LHdVPZwwFbB7OD+u
	3P2lDEQNkJ8fPzc8GJmwtGxNsUiWthI218hsd+OSCjfLprWBWAYFx9w2uy+pLFD4OZjztgdv9Yg
	oorx3MU1TsydsUVTJF2V+xEaoIwQD6jfWjYsRw+6wkoA91ElpcFHO1w1A1MvP5UMNLP23KS2jw4
	oXhByV2UQKqRa+rXVwtFSibrn2Lz4UFhkeRlpvy88IH/84SsX7LOaxhybHVBgPq1HCYsH8zHqJl
	YYsktA+9dsWNfmLiq18el0AVxgm0J4NUVQKJn4k74MCOWqYEal29jcjvOvoCI3txY6NGyHT5TPb
	VegIvNltew+O66meOR/a5nPiuS04/GOKnuHgf6JoQq0AChSzw6AkWRCI2WxuYIbEd6fez6X8VMj
	ERGfgeGwaTbTY0htaAufw2pNSiea7AN
X-Received: by 2002:a05:6a20:728d:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3c67da7cfeemr8478040637.27.1785157086058;
        Mon, 27 Jul 2026 05:58:06 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13d2eb01aa0sm44088627c88.3.2026.07.27.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:58:05 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Steen.Hegelund@microchip.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: microchip: vcap api: Fix possible memory leak in vcap_decode_rule()
Date: Mon, 27 Jul 2026 18:27:55 +0530
Message-ID: <20260727125757.134611-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for struct vcap_rule_internal, keyfields and
actionfields inside vcap_dup_rule() are not freed in some of the error
paths in vcap_decode_rule(). Fix that by calling vcap_free_rule().

Fixes: 610c32b2ce66 ("net: microchip: vcap: Add vcap_get_rule")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/ethernet/microchip/vcap/vcap_api.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index ff86cde11a32..0cc0db7b641b 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -2427,18 +2427,21 @@ struct vcap_rule *vcap_decode_rule(struct vcap_rule_internal *elem)
 
 	err = vcap_read_rule(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err;
 
 	err = vcap_decode_keyset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err;
 
 	err = vcap_decode_actionset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err;
 
 out:
 	return &ri->data;
+err:
+	vcap_free_rule(&ri->data);
+	return ERR_PTR(err);
 }
 
 struct vcap_rule *vcap_get_rule(struct vcap_control *vctrl, u32 id)
-- 
2.43.0


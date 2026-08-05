Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF93C3C16
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899384; cv=none; b=kX0ezRFwcLv6+tLQFLb/30CtpGp0wsInnIrLF9K/PEQndPoHoBpZ5lsWp2ghPf61wHD+IFVg/on0vRR3ct/Drn0Nyl8pY5yuwanhdjkU77YgWtl4FGuMOnvApGuqmHSm1Bcr7EyLUL6Go7w2lIe5pLybqGfXZqXBzWReZzAd46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899384; c=relaxed/simple;
	bh=bFLblOr7/KRtDWGaNUQ/oxXl5YkPdtI2jyGgXHP9qko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8FIcxHdz5h9aJDq9Z5Qaj0xHBpG8NQPjZd1tNlU5QwIplnlPPN/bWRumK52MA/CZhHRkI0A7SjshF0mJ3z4LLfhLSirRmTpKrmzqvtZuZrTEsjRTDb/+dpYWNpCwy4e2rWjBLI0Ka1Xxpgt5t4w/AaSjpHNKZYfHEpYg0do5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rO+WoNmf; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rO+WoNmf"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso399713a34.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899382; x=1786504182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtqhiQPtfLx478uCqIbccXvcoISzUjC+Hx+PXZFH8QM=;
        b=rO+WoNmfbg0eSFcqarVT07ZnGLu6pD6yC1N0OTL/t0F3Y7jdtHE0In3ZtCtdToQO4P
         KQXJOiuep2BUB0C/a0TWfV5+ZIgyLbq2qlWKCD6Da3sYkZWgysGzj++RuX4OSMtHLxjD
         3SlsVzmiFm7FGjN4v4BVY1l3KdXLpCVe1C0iaVmEtB2cRwyVPQxSmU+bYwJwLSyJmKb3
         3y1XgzI8eCQHC90I7kGHygNGyx/N5H4FSczJaBt4rh8fHK99PdoQlVSdAl3OMKi/XJJB
         kO/zdJ6rllJeOFL8QVFmkt7POl9/Ngx0m68ETKxeKHR+c9/fAhH4XxQeSTT+M9W7mzdg
         gF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899382; x=1786504182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtqhiQPtfLx478uCqIbccXvcoISzUjC+Hx+PXZFH8QM=;
        b=lulFA2FwikqSHyIa2zY0XsJ+s2GJ57gOmZcWZxZNl5B5fJPxytsI3PfhN60A5w+6i/
         4xrLs81Ktimkh44HSVIQwxpL/dRgWMv4rwYXc9SAUHd1mY1GSTDCvWJYSJHoT5YORqhP
         wqw0MIZ1NoAvZIJdvlElzrvXXexH2P/iO8MdWWpohj42FDZrIsLb2XrhFyYFa9lZmqh2
         QtlV+CRhF6JLmFXNfGAiwLGNM13bFFh69uEgn2fqnzGn+ReALUo286Vu9Kfk5CzqPWQR
         Ed/+twiCB4e0j49uCSW4HHi/iTfoAdcXaVv+YSD2EGw57pfGvpJDshuaG0Wi19lL5RwS
         tZyA==
X-Gm-Message-State: AOJu0YzLRZ81R9OknLl8nZp/QnrL2R3pbZCxZKT6gXXTR+20851r48rS
	GFWrlPA0NbXqSJgdt3IlD+UYYWBvtKOt7DEqrBrL/OlXm6AYl2mAKBfZrAyUEtdB
X-Gm-Gg: AR+sD12PHIrIy0S0aoutciCuuLbyQvS/C3resR9NmIC+rQzTOuAmjQIXEf8c2nVyjUP
	CgbgF9WmkWSwiBIQCmOWatwbGBWxCkgGIutqyOG2K6E/fJ/JczyNEc+1vfJEtwSEkLuUqxqh8Aw
	PjVX5OmbjDgrKrczfz/0MXA+tPabc0gYVsOPB7ZFmMAFy+63G9kWfAAW16vui1ZJ0nSN32SQ/1y
	7RimBe9HUH0S7mRmU51ftWewiJnAhs/iOQJLkW2ByxSbCTpwit8lBAyIplTwslIbiGDsi1BDRId
	/u2OC+00a70+pXSe7bovKpVUR27kBhuZ55JiLuLoKYKgSyYcX2VrCFKrJIi+8hBjr6f51B7ejMm
	CwcnpyUfH5OkMGEtcBhymfOVb9iQKfaGCNEorjwEOtOBSWsd9pkV8TxrIvxtE9X/CACtyVWuu2U
	TYuHJXSUkfVjwRVa+K8bY4KIFBuICChNybk05RxV2rF1y7E1dxUk4Ux7L9
X-Received: by 2002:a05:6830:2116:b0:7d7:ed69:81b2 with SMTP id 46e09a7af769-7f1e5d0f2e8mr2759082a34.5.1785899382203;
        Tue, 04 Aug 2026 20:09:42 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df2fd11dsm2032300a34.5.2026.08.04.20.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:09:41 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	alexander.duyck@gmail.com
Subject: [PATCH net-next 01/14] selftests: net: shaper: Drop redundant command timeouts
Date: Tue,  4 Aug 2026 20:09:23 -0700
Message-ID: <20260805030936.1092907-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805030936.1092907-1-mohsin.bashr@gmail.com>
References: <20260805030936.1092907-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <hmohsin@meta.com>

Commit 57bb59ab6fa3 ("selftests: net: bump default cmd() timeout to 20
seconds") raised the default cmd() timeout to 20 seconds, so the explicit
timeout=10 passed to the ethtool channel commands in queue_update() is
now redundant and, in fact, shorter than the default. Drop it and rely
on the default timeout.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 tools/testing/selftests/drivers/net/shaper.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index e39d270e688d..c80a4bf8cc05 100755
--- a/tools/testing/selftests/drivers/net/shaper.py
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -388,7 +388,7 @@ def queue_update(cfg, nl_shaper) -> None:
                        'bw-max': (i + 1) * 1000})
     # Delete a channel, with no shapers configured on top of the related
     # queue: no changes expected
-    cmd(f"ethtool -L {cfg.dev['ifname']} {cfg.rx_type} 3", timeout=10)
+    cmd(f"ethtool -L {cfg.dev['ifname']} {cfg.rx_type} 3")
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
     ksft_eq(shapers, [{'ifindex': cfg.ifindex,
                        'parent': {'scope': 'netdev'},
@@ -408,7 +408,7 @@ def queue_update(cfg, nl_shaper) -> None:
 
     # Delete a channel, with a shaper configured on top of the related
     # queue: the shaper must be deleted, too
-    cmd(f"ethtool -L {cfg.dev['ifname']} {cfg.rx_type} 2", timeout=10)
+    cmd(f"ethtool -L {cfg.dev['ifname']} {cfg.rx_type} 2")
 
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
     ksft_eq(shapers, [{'ifindex': cfg.ifindex,
@@ -423,7 +423,7 @@ def queue_update(cfg, nl_shaper) -> None:
                        'bw-max': 2000}])
 
     # Restore the original channels number, no expected changes
-    cmd(f"ethtool -L {cfg.dev['ifname']} {cfg.rx_type} {cfg.nr_queues}", timeout=10)
+    cmd(f"ethtool -L {cfg.dev['ifname']} {cfg.rx_type} {cfg.nr_queues}")
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
     ksft_eq(shapers, [{'ifindex': cfg.ifindex,
                        'parent': {'scope': 'netdev'},
-- 
2.53.0-Meta


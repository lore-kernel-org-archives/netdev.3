Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50C9176FB1
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365790; cv=none; b=epgRxqIxDv+PRWflDm1nmRgJebhl4j5YB5Qhca6f0fN2I1fppV3oeDEj7ZYKMv/JCkG+ATL1MFwJ6xXfW3pmlz/4tv2dJrmfZAfZoM3L4kLda4RmTovQybDPCh8ZFGEB8zo6Z504q1SJPoyoDcPWB6zAtyN5DPMKjSVuTdILFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365790; c=relaxed/simple;
	bh=y9WA6GoIt1DmAJpAcsIoCrbQt4m5dvn73N6b/TcwLfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pt66lusyCMDCM/MVxVeyNlbveKvMWa1QL/6MTD1quDJuMhuBlnGQicwdKhy2KDAncsLplOyeSF6jf5Fmgt58V5ZRksy9gsG7rh5F1lrQZSV2hk9P5h4KEv+zWsDUsKoOctCcX0gjIr+1Fbv/xnd2Pz4E1SLzdrFURR3GUM3AKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI1B6ehu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI1B6ehu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cace91f112so86786565ad.0
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784365789; x=1784970589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQvkeIae8/A1/cDiRMAjndHiYuA/eJ8gWOsY71fIfHM=;
        b=aI1B6ehuZL/9f5ZTAgoOX96qLjCssqiEerWLqvXmsNTm3Um8pZ5JkikhwY8X/FDpXr
         mAZjYVUn0i1bwxlbL9PDFMr63eBBgdhHDEz8nU6GsKv+3xZSlJNGnKGNIC1FDtY7789z
         6s4KH9XlgIXzqJD9ne1QvkyF1Z6roXbz8i428j2TyB7tic8eETvB2CyysnLs6SA8OCit
         1v00yfY9zFQCiQ4UlEy6WzXhPA/Z0drbeKJqYjT0afS3vzNlyIqF3GmPj8byidjikIKf
         wtbErp8SiWndtRMolRD4sJ8w5sGvSBfnIKcERdK0puRoB8+aAZ6+YaT6FNBkvC4xa3qB
         BaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784365789; x=1784970589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQvkeIae8/A1/cDiRMAjndHiYuA/eJ8gWOsY71fIfHM=;
        b=J0VcRT9JqZivptf7fPcndPC9L/Tq8WsoFeWLG6HKHZlCQZCLAhwlvpNKrBUxS/nVDL
         JqQhbNjozGw8rf99A6KXNqGcQPz316wsbFPw028R6l8SWqTrOJbdAu0VQDcgpruN3aLe
         Fnpv1n9imxBYXeK1VcuartOzCjpnBQ929o8y6Cy2bMt4c7Dt5FFNiG73VoZ9wtayvEwC
         /lu6Hx7qKcvMRC5MC3+rWB2MOPXRxcHqoZJ6j3OXTE6CFgkSRVs/NQnYlAYIyFATivHf
         ITRTqsNcylcOMqRC7gpnheMCw2av6+3hAigfNDlBI7dkftLHM1J1JaWGOwbaCSZzJlMB
         Z6CA==
X-Forwarded-Encrypted: i=1; AHgh+RqHFgAjIMyD+FhUH1h9oIapKgXq1Sa7fpuAitvLcOlv9yzRiCZzOih1J5MJoOCfJE2OtVnFM6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhsFwwIoftQh4czciXvAZAYeUlFxWOD0/SaQRGkRAr4z+v5R5
	1ibgKy4564w0kBXWNpc/bsnj8fUEDgAfM+xoPBn1Kd8zFyR5c9HLtmSO
X-Gm-Gg: AfdE7cm6BLRjw3gP3oXaLFrTIHo9rwga/wSLaeudgXItagq0MDzRLEhsdigywbU/yJG
	KxChMr4utXreTEVU6iUKODTAFGSf07I8qINBD6ur7FxNXimaxDzKXVE6NNGuIQXqZQh3pOtasyl
	RbYhpKnf+gRn1PYFiR7heYzvI66QzCggLraQR0Wo2zGxctJyrXX6n2FlS9UqBJY5DKeIGW5pWAS
	5fL7Xf3sg07mTTrAsEfSW5eUxeguKqNxdZ4ilw53Zex2sDIY1Ys5BpGXyuP7WPhMrnGQQ1tRmxL
	kZNLOyjXHkxJpvUSFCeuffop+gnueJ5dO00IXW4l2jEYbBhHeDD8YiYGDQu7QugzQ0DBg8DtDGp
	swb6/UvXsbsjMBP1gQANZqExvwPta7G1ad8pp/yCXGyvNGMssTE57CpTdB2PV0RxIYIsFn+Rr4U
	b5Iq5Kk+C3P6+jg+vyYStXUOlyo0BjDRhcTcndyVU=
X-Received: by 2002:a17:902:e548:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2cf348546c2mr69152485ad.13.1784365788827;
        Sat, 18 Jul 2026 02:09:48 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.236.164.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm24285495ad.80.2026.07.18.02.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:09:48 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v7 0/3] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Sat, 18 Jul 2026 17:09:27 +0800
Message-ID: <20260718090931.724303-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the fix for the NULL dereference in
tipc_named_node_up() on an empty publication list.

Patch 1/3 carries Tung Nguyen's defer-to-workqueue approach, suggested
by Jon Maloy on the thread as the replacement for the item-less bulk
from v2. Tung's RFC only exists as an inline diff in the thread, so I
folded it into this series, keeping his Signed-off-by. I tested it in
our two-node QEMU setup (veth pair, UDP bearers, node-id addressing),
both with an unprivileged user namespace and as root: the unpatched
kernel panics on the first run of the same reproducer, the patched one
distributes normally with a non-empty list.

While testing we found two residual issues in the approach, fixed by
patches 2/3 and 3/3.

Patch 2/3: tipc_net_finalize() does not check the return value of
tipc_nametbl_publish(). If the publish fails, for example on a
GFP_ATOMIC allocation failure, the node is finalized but cluster_scope
stays empty. The deferred worker then calls named_distribute() with
an empty list and hits the same NULL dereference, this time on the
workqueue. With this patch the worker re-checks the list and skips
cleanly, no crash and no link flap. The tail stamp in
named_distribute() also gets an empty-queue guard.

Patch 3/3: a repeated NODE_UP while the bulk work is pending takes a
node reference that is never dropped, because schedule_work() returns
false when the work is already queued. Found by flapping the bearer
during the defer window. One reference is leaked per repeated
NODE_UP.

Changes in v7:
 - Patch 1/3: add the missing kernel-doc description for the new work
   member of struct tipc_node, fixing the W=1 build warning reported
   by the kernel test robot. No code change.

Changes in v6:
 - Make the series self-contained: fold Tung Nguyen's base patch into
   the series (1/3), keeping his Signed-off-by. The version sent as
   v5 only carried the two follow-ups and depended on his patch from
   the thread; the code changes in 2/3 and 3/3 are unchanged from
   that version.

Changes in v5:
 - Replace the item-less bulk approach with Tung Nguyen's
   defer-to-workqueue RFC, which fixes the reported bug in our
   testing.
 - Fix two residual issues found during testing (patches 2/3, 3/3).

Weiming Shi (3):
  tipc: fix NULL deref in tipc_named_node_up() on empty publication list
  tipc: fix NULL deref in deferred bulk distribution on publish failure
  tipc: fix node reference leak when defer work is already pending

 net/tipc/core.c       |  1 +
 net/tipc/core.h       |  2 ++
 net/tipc/name_distr.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++----
 net/tipc/name_distr.h |  3 ++-
 net/tipc/net.c        |  5 ++++-
 net/tipc/node.c       | 35 ++++++++++++++++++++++++++++++--
 6 files changed, 97 insertions(+), 8 deletions(-)

-- 
2.43.0


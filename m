Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3743830F523
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366754; cv=none; b=WZkQQ+mV9Ed3SZGbrg+W2W8T2vgkJrR3T5VgEF7bEGsCDmgD2v7tyN8Y3kexuNnPtwLTjT8UDd4Qshw3B0InTBZSlLNpLwDPbf96pQgLWvyzREoOAMkm6WvZDIyWYSrdquLM9xNivN5w5Hv3R6fZrunaAznnTaz6DbtGuI1E9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366754; c=relaxed/simple;
	bh=+sJPKt7pW08KnxMq7tu1+zhi1rl/EGUdv22KeWqghh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiFIvFfevaGPByJnvg0fa6jJk4uk2EGDRws5q+aXTb3Aee6yuRD/KqD6GF8uw8eLqwxODS1MZOlDm4jH1JluPsrPyVGVhkTVjL/1s+tHsDGneBvO4X7SaY6tIYu1diAeKxj/krTlMAYUMbx+cszCUXm0bGLwwaBSXIQKMhNVc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsSDGB2j; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsSDGB2j"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a2dcede83so7330933b3a.3
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784366752; x=1784971552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QHZnjg91utK8BGYhfQO75hBoR3TI4daE1MVYFf48JX4=;
        b=LsSDGB2jKyWOw5LF2X2FbUsRWljvXloioRTYlq7qMg/jnApyEp3/pmA3KrcgpdBBRs
         hQ4lklFpp1OfhQQgjFwcK1d0MxaqIvz4Hnc9mQg8a/Pd8IaA32PPQMg79Ix9aT8w2yIo
         vpoLftckagjPIS5BAfDv2pV2GhiIyp//x565HGLkyu2EbfQFuVJ9P2bCHNOMNxRdP9Eh
         pkbe6k1UipaSPLNC3PIkklJs0Rf5J1xZuGDon8qSItmBu+FCFJJ/Vy9XVmHmiO+dDs7n
         kA/u1M3FrtKM7diG3pKk4t83VNU5nsL1xM2kR0r/bhtMIMr80BGDMjhFUo5QUTCeqzfe
         YANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784366752; x=1784971552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QHZnjg91utK8BGYhfQO75hBoR3TI4daE1MVYFf48JX4=;
        b=oK+0wOshFQcCc8Qg9x6afge+9XRsuEWfyY3w4Mc41DWtu++sO/0o2wfb2lDQfxwJit
         /ZoeIV2/NlLFylkNbebecuqQ8s6WA9tF0L317KdSl79LfJ6aM4/v+7lgwYAPVsC2v1U1
         LXfzXNiXuf4qSZIeb8NOgEeOezKxs7MPicLYmxTXdr3hLy4y6wJWbgQjo5Or4U8dAaeC
         K4BHzSbOmT9RE+dtXpi0805VkiHXM77PyBd105mmEGiIGjOiOXiNv/4Vih8X324QM0oI
         vTaOoKd35Ln8zcTPURY3OuBeC25lF7VK8z7QikGgCEFvT+ev0mUPeaBmS/fvghBLXOdR
         5iNA==
X-Forwarded-Encrypted: i=1; AHgh+Roymh0vysKXfJW2TWgtafwldra0WDKOfY4ZImkMtz4+LfPARkvO/dn5fQTnTlWqcGER3CchqXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2dwGDiZScjaQTba8SArUHBqi1NPqkoN/8ZbRGQTdoraTXnbj
	QbDZ6sgH7X+lRPdqtD3oLU2qwJDGPOnDZjMmlWfGA3qu/2y8D4XZYGI6
X-Gm-Gg: AfdE7clhC9tkzqLvLqsNmujobjlV7UbPiyK/6KY1LAAwXbPCsaE8Bi/dlgsl2Dzg6g6
	tRiFmYNBi5N/+zcygbQvdGi4knoKhxaYRRIPfV4wPYdqL7ibK1KrVsZFeh9xb4ldyXgcz/rJp7M
	W6VFJvVZx2ELGMbSwHcM8FVvuyCC0Vx7p7+mO65AyP19xJlb4TrJBH4bn49l3VXP3lPNt+aSHWb
	IYI3crCop7JKpz2peu33tAkIrTx99l3ANEHk7PswsJ7rbIwqIMYXHIXl/0A+m1f+G3IYX5eHxLP
	uBKCKdbOZ5FWvHNfZAGAOIDUybGnNCjrV8OhrgxlwvWqbEHN6HM2yoUPABM0Zz5XeJ0/UgAZSM+
	u1+aUfXU0Wj4k5zY4kTcebUcIz0IuHwrzLSUgYAaI4gnCcpOX45l3KpU3uyry1QUCXh1tZbt3lE
	cP2p2POIxJn9esyDNZKFAu1NEzbqxqsfDb3io1u5WZJBJ1tZQm
X-Received: by 2002:a05:6a00:3c91:b0:848:6c4e:59a0 with SMTP id d2e1a72fcca58-84c294d4e41mr6426357b3a.40.1784366752505;
        Sat, 18 Jul 2026 02:25:52 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.84.186.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c30fb62fesm1950464b3a.29.2026.07.18.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:25:51 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v8 0/3] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Sat, 18 Jul 2026 17:25:40 +0800
Message-ID: <20260718092544.785289-1-bestswngs@gmail.com>
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

Patch 1/3 carries Tung Nguyen's defer-to-workqueue approach, which
he posted on the thread as the replacement for the item-less bulk
from v2 and asked us to test. Tung's RFC only exists as an inline
diff in the thread, so I folded it into this series, keeping his
Signed-off-by. I tested it in our two-node QEMU setup (veth pair,
UDP bearers, node-id addressing), both with an unprivileged user
namespace and as root: the unpatched kernel panics on the first run
of the same reproducer, the patched one distributes normally with a
non-empty list.

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

Changes in v8:
 - Attribution text fix only, no code changes. The defer approach
   is Tung Nguyen's work; earlier versions wrongly credited
   Jon Maloy.

Changes in v7:
 - Patch 1/3: add the missing kernel-doc description for the new work
   member of struct tipc_node, fixing the W=1 build warning reported
   by the kernel test robot. No code change.
 - https://lore.kernel.org/all/20260718090931.724303-1-bestswngs@gmail.com/

Changes in v6:
 - Make the series self-contained: fold Tung Nguyen's base patch into
   the series (1/3), keeping his Signed-off-by. The version sent as
   v5 only carried the two follow-ups and depended on his patch from
   the thread; the code changes in 2/3 and 3/3 are unchanged from
   that version.
 - https://lore.kernel.org/all/20260717185701.2828080-1-bestswngs@gmail.com/

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


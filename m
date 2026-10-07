Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399247D935
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368988; cv=none; b=b/UBmABQgegVuyhZKBmwuYdcTVNgFA1UopEFLcsFnMTm2UHZaVgK6SdxCP4HrGLwnFSVNd+3Uea6zESDB7cCzfO6OiKx/KAQOc9FY1eP6JFezsLOaD9MZXtgSFmJPT8xv7sGTMfQEsBFPtIEC0H0n48WnUUdFUZ5ezaS54tpWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368988; c=relaxed/simple;
	bh=utY0NTU6Wkxtr6hzS9keP2WAk7ZRMx3po7aIUjshAE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thxEPdZq6xuAog5iTL3CvDH0ltU/XOEbhVfkI0SbouWZTjcQJA6pyHpc2MG/6YvcAuTgucLvlQtoVu463B27p8TWZlCKjS6DFnZ8M138jwQkhx+bS5NvFuqCYemuEB2OgpEWW9Tn3RgdJ0xo5ThJnMK1b9Pq0A4K5rGcJWsfitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=CoEisdO1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="CoEisdO1"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5339381b46eso13781991cf.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 03:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791368975; x=1791973775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTX/52fndCXsxhd9DvLKFsg/PpzCLhPHnvp9fZAz5gk=;
        b=CoEisdO1ICZ9/7xB3y/pp2vmrmvHa334tn8L7UN/8v8DZ59K2fWzrhSlWC4b8GftOP
         /6iKcgW7NHa68pBaFX/iIoqASiAhwWp61nK1D28biiGsySp+kbY5jbP3u9QXsZ+RdtB4
         ciELufA2GwmsHyamaNDnSOEgaYdoY+E41V+Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791368975; x=1791973775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTX/52fndCXsxhd9DvLKFsg/PpzCLhPHnvp9fZAz5gk=;
        b=I+LV68brLJbrnWpMvPNRhUd9Y/sbHNPa5IvXIScaD7qYMvVfih2e5X3SWsV7XONud7
         npmANLFPWdNYqjtoEZoYof6p/zM4G0kF6pzchWY+BkQEkf8LLgnJ8h/fq/6pyEKNIUjR
         RdPlvQ+kZ8wUJTgkedN/rJHBrkyrVqTU7Y5euHJqS0aZVaQN6DbxRrfgmC4JGcUmiVqj
         Y98LYdj7HIbso8zW1x5zk+M2DjMgzCnVMyG7YnHQCLDS29fPtFre1qmNQ7rLR9rKBqKP
         tjsNLUb+RIfC9Rea7DWH7iwz46w4T59hWj0EkTov9eG9iJYpF3uNoZoYELRR8YushX+a
         xOSw==
X-Gm-Message-State: AFuF++kcZwHDD9SLlBlPQIOLW/2xpTv5pE8Nfal8tqeGPMsOMFFcK/12
	uxvaNKfgvQoAbQ5j9MByGm5ApBtGBLn7Owk6gHesSKtD5M5tWOhl+FHtCrMvOxYR7XKXw56QkP7
	NmvA=
X-Gm-Gg: AYBFou1l/leccDikovybKSN1g/c1ebkyrLf1YHPdMR3y2iUnmcM8Ttfr036bVY8HW48
	O8251LDxXRd5X63va/D8sI41O1dTqfci5IU/8craeewb1YC+n8IyoHu85c98bNz/bwR4I8JrVIM
	h7pB/2lug6g19eiWcS79Vv7uoZyYxWFrQppSO0+9s6bZcueY9VsedApj2SPuOYuYAar8fBxqu11
	W2dYeTVdbonoGdUye9kde/4uXP/E6WnnAlNy7M4LtceQ5GnEGGXJZlVSCe+tENfyG5EU9uzz7rc
	dX4nC6mVkiXXe3gJNFpX26f/A1mhzeR4G16eVEsWBbwApdDaTU/7fn75TnEI0ckZbW0lcy8XmQ9
	M3e1slkroJtDY52IsLH0JNHCh2BeZcWYCkKfmF/gQ392cdL2Ybt25B50wdOPloOqsScjLzIiiwZ
	Aiz4mlRt0L6hOyajTmebBarIFZU2xBYyOQGCSrIawsx1d2Q4JMbMIncJQf6MYm4CF5qoeRR3PQr
	E9Vd/pLN2Dwa+4IvK0lvgdD6nYE1z/uMsIgdPRG4NcjZEqR/X9gVP2QwYjr
X-Received: by 2002:a05:622a:38d:b0:535:2c94:a86e with SMTP id d75a77b69052e-5357531f680mr27061531cf.10.1791368974533;
        Wed, 07 Oct 2026 03:29:34 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357209e26csm16986311cf.8.2026.10.07.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 03:29:33 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Paul Moses <p@1g4.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Davide Caratti <dcaratti@redhat.com>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 0/2] net/sched: act_gate: reject oversized dumps and cap entry count
Date: Wed,  7 Oct 2026 06:29:29 -0400
Message-Id: <QDISC-H19Z.v2.20261007062551@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An action dump is carried inside nested netlink attributes whose lengths
are u16. When a single action's dump does not fit, a plain nla_nest_end()
writes a wrapped length and the kernel hands userspace a corrupt reply; on
the classifier path the -EMSGSIZE this produces is mistaken for socket
buffer exhaustion and retried in a loop that can never succeed.

Patch 1 makes every nest an action dump can be carried in fail cleanly
(-EMSGSIZE) instead of wrapping, and bounds the tfilter_notify_prep()
retry. Patch 2 caps the number of gate scheduling entries at 1024,
rejected with -E2BIG and an extack message.

This patchset is a retarget from net to net-next of the previous posting:
https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/
The wrapped-nla_len corruption this series addresses is not a regression of
commit cfa165cbfbed ("net/sched: act_gate: budget the per-entry list in
get_fill_size"): the enclosing action and filter nests antedate it and a
plain nla_nest_end() has always written the wrapped length at U16_MAX.
Under Linus's post-merge-window rule a [PATCH net] must be a regression or
critical, so this is hardening for net-next:

  https://lore.kernel.org/netdev/CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com/

Changes since the first posting:
  - Retarget to net-next and drop Fixes:/Cc: stable, as it is hardening
    rather than a regression.
  - Add the entry-count cap into the series as patch 2/2, as the parent
    commit promised for net-next.  The cap value is 1024, grounded in the
    SJA1105 schedule-table capacity and the 16-bit netlink TLV boundary.
  - Patch 1: add seven additional action-capable classifier
    TCA_OPTIONS closes  and correct the Conditions Kconfig name.
  - Sashiko review of that posting:
    https://sashiko.dev/#/patchset/QDISC-H19Z.v1.20261001053234%40mojatatu.com

Jamal Hadi Salim (2):
  net/sched: act_gate: reject oversized dumps instead of wrapping them
  net/sched: act_gate: cap the number of scheduling entries

 net/sched/act_api.c      | 10 +++++++---
 net/sched/act_gate.c     | 22 +++++++++++++++++++++-
 net/sched/cls_api.c      | 40 ++++++++++++++++++++++++++++++----------
 net/sched/cls_basic.c    |  3 ++-
 net/sched/cls_bpf.c      |  3 ++-
 net/sched/cls_cgroup.c   |  3 ++-
 net/sched/cls_flow.c     |  3 ++-
 net/sched/cls_flower.c   |  6 ++++--
 net/sched/cls_fw.c       |  3 ++-
 net/sched/cls_matchall.c |  3 ++-
 net/sched/cls_route.c    |  3 ++-
 net/sched/cls_u32.c      |  3 ++-
 12 files changed, 78 insertions(+), 24 deletions(-)

-- 
2.43.0


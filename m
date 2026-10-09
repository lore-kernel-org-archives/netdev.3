Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E73DDDD2
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.60.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791523189; cv=none; b=ZcyQDNTF32MW75XeuHsvUP4XPk/Pn6vrXM5rcJaWh1GKXdv1nr4suSnMMRuVFhu5JrsY6hg2cY14iCItOB+ZzFsbvrZtGrl8Hz4bdCDzpK+7X8H3FYMsSP7UvxTe14XxvMjz5PLljVMFt3vCl3O/Xepkdui3i4KsVCBH8TsCSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791523189; c=relaxed/simple;
	bh=Oab/fDKDmcieLlNRkjWNrwJWxYb9aVvIg9iAAVgwYzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0dLGNW6TWSmQW/CU0d73yikRgGf+FkyBg5qaJw4uEcU/KlU+UkBv35iII5PMOhQ3JZCfPezefp2NfIqw7kXh5rHdbXAqFQm8LDJwPYgjjW1CMGOCYvTVrOdinMYf4qJb21drCXlQFkmuapPPDkmJDj4U8cYF3hGAZkbvH9V4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr; spf=pass smtp.mailfrom=corp.free.fr; dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b=o3lZKCdi; arc=none smtp.client-ip=212.27.60.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b="o3lZKCdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1791523178; bh=Oab/fDKDmcieLlNRkjWNrwJWxYb9aVvIg9iAAVgwYzY=;
	h=From:To:Cc:Subject:Date:From;
	b=o3lZKCdiG12Efv+acc0Z7uicMkExicLgu4GcptUsVDnlalFNT+E5d+dLqtjVVaP4D
	 BaZw4wd+kmwuSyZxSagRTdtgHlw6BUgZ0pb7i9iPjst3DEPIbQF3keCpcdftkheEuQ
	 eQEF/c4WKtDebq0aAe2yx7tgxCyOG541QQNz06RvTgNyrTa9F7JrXhC3nZUEuNMkmi
	 gfeIGbZ8PHkc89zOcULtPlbwf3+/81O4y9oMHBS0+TU6R1CXxumV8wwn4WZtm2FPdG
	 jw6XCob3tW3tzh5XKJYuwidU83dwa2nziVHRsKdJbRsGbnfwGUCUKltxOsi7cz+12h
	 H0naxDRIQq26g==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id D368944C0145;
	Fri,  9 Oct 2026 07:19:37 +0200 (CEST)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] net/sched: let hardware only actions drop per CPU stats
Date: Fri,  9 Oct 2026 07:19:27 +0200
Message-ID: <20261009051930.3619697-1-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets hardware only actions drop their per CPU stats:

- skbedit, police, mpls and sample honor TCA_ACT_FLAGS_NO_PERCPU_STATS.
- tunnel_key skips the dst cache for skip_sw actions.

With no_percpu set, the first four count like gact and mirred but also
share their race with hardware stats updates when an offloaded action
also runs in software. A separate net patch fixes that race:
"net/sched: act_api: take tcfa_lock for hardware stats updates".

Alexandre Cassen (2):
  net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions
  net/sched: act_tunnel_key: skip dst cache for skip_sw actions

 net/sched/act_mpls.c       |  8 ++++----
 net/sched/act_police.c     | 10 +++++-----
 net/sched/act_sample.c     |  6 +++---
 net/sched/act_skbedit.c    |  9 +++++----
 net/sched/act_tunnel_key.c | 10 +++++++---
 5 files changed, 24 insertions(+), 19 deletions(-)

-- 
2.43.0


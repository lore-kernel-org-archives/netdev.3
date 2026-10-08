Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D63BCD20
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445649; cv=none; b=IwbDLVlfj96AnVs1v47UVg7cbDg4olo7SrEsCOhl9FgUARHF1/AJ+H7Fl3LwyiFS5ioaYyfHvaSI/QR8/Na2Vuj5hGU4KgV8k/cXLSrU5hvtXrtdws7o5iopR0ObRxE+49SQdY+OWV4bl1oNJAI3TvlYXGoVISr2Oc88Mcq3yMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445649; c=relaxed/simple;
	bh=DIgcsq7P3eZ1Zya7mMAQnHJvPn97VbVOugUdCmf9Gf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qs96AA3SsjtPZjSbgOjDoBK5QqPYz1RhvARV2RDz0ZwG+5oO2dgXzuDNQ/WC2JJtmEqCownirG6z3UOQfG4O/ZjvTMl/UBplz57u6lRPO5Tw6tnqc5Qz4GaCSLvY1/s6u2FWp5zbQcVGKU5u0GvHCjWFme61MkczU7Phi3vSQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=RyX1r+Ep; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="RyX1r+Ep"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53391786e55so37086931cf.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791445646; x=1792050446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwXYbtbP0rsT/5VE/hMx/9ZCnE8bQ7naz2qj5NwTE8Q=;
        b=RyX1r+Ep/dyMn51oeSGgYcVIr9bf2uCc+NXX5/XjOKbiHGgDyXjpDvVTiD3UO5HNeQ
         dEzDRqvriFsSEQJQ4L5PtWvPnHKDgh30u44/nboGcjgktCw1d5E5EdzWTQQfppFCwgsm
         wJhj2uu/GLY/pmioTlZL7Nt/rZB8LC0sLfzFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445646; x=1792050446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwXYbtbP0rsT/5VE/hMx/9ZCnE8bQ7naz2qj5NwTE8Q=;
        b=R7Lb+JqAxiONolLHEsrNaMA7IRRHuMHxUR/DhfDe8BN4a8qc5lMx8+ayhktyRbwMmx
         5vSN28SV5fCfUb00RZZvvBgYyJN9JV9kVFuJXXAxwh42kFzM+6EpOYY94hh4nJhz8FgL
         aKJ7SULYo8lDTBSDGrYeqYqo1o6qeYTM94Z5YCrWpbKCQsrMmtD2/7ju/ZGkJwiuLu2b
         sMSA+dNw1J1X5gEmUpIUvnyD1cabU5/5X+J1tga85LI7SlC5ILmv63sBYzLHHBmMV4Q3
         ZJf+z5+j0c/Bt1U9f+ifQjW6g3I6V0JD0ocpNKG/0YB5TyS/0hsGOVy2FsgRxjhV2J+x
         P1PA==
X-Gm-Message-State: AFuF++l2PUbYSv8zaSB12CHu9V1lE2dcrN/vSScgqH4UaKkcsuQIQA3A
	svDywpmOuUP9RTvxeYYaOQgfJJMuUVF4g9dRnE4Q+WJtXc/Y3LVk5kAjAfOy8w6pxgVjB9hblS7
	sVsnT5Q==
X-Gm-Gg: AYBFou27wkNdrbRur0H33rYr+wQEQH2tzh10hwdk5t507vSPyKxhL8w1gMirsRZWuDb
	6zT5MQYYQomblqrqxC3g5FDrsueeydFb663K7uE27NsqbbkSbNdBJcfBXBmnslYTCdzi9wdB7tT
	RGC5OwtyslvaaiMeTeayGJZN2VkWQsdsaZOedn0wL6pEla0KAtlN1CuVvBlSDnL0Wxo0/HqtwOg
	TzqEgmIVg6p2vXJzAtZGOvqP+mmfd3eTtmSCFPodVwl+A4n8pXLITLQSje+rtixE99PJZzxGBKT
	clAV8Pt9PD5rvb9469gj3Rekw5UtK1Kxm3wZa1WL2QrbPMM4lv4Wvs6FLZLxHTFlPcnWacjNuVj
	M7FFnkf3BvII25fpaIAt5ugBNC2jowN5PRMLKAoOoH3EEt5hu2do9etSOmE9txJRKl+hpLesCwd
	TF3zVlmQ+iG6eNasxTBm6HYJsXcHT02CAoum8oD5VDvKErTiD4UCJJPS+yUW/GYqdJszxbichfd
	BMnFjXbX6OgwSj+Y7vljQIdV96fXudg23SCN1nU+1CIEU8ygQ==
X-Received: by 2002:a05:622a:30e:b0:532:9f90:3f71 with SMTP id d75a77b69052e-53574c96022mr80233171cf.0.1791445646290;
        Thu, 08 Oct 2026 00:47:26 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357213f3dcsm38253961cf.17.2026.10.08.00.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:47:25 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	Victor Nogueira <victor@mojatatu.com>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 0/4] net/sched: sch_cake: fixes for accounting and reconfiguration
Date: Thu,  8 Oct 2026 03:47:08 -0400
Message-Id: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four independent fixes in the CAKE qdisc.  Three are follow-ups to the
autorate reconfiguration work around commit 7cbfb180945c ("net/sched:
sch_cake: fix autorate reconfiguration throttling") and the 32-bit
admission-counter wraps fixed in gred/bfifo/plug by commit 4c660ee8c809
("net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue");
the fourth is a dead-code cleanup found while auditing the dump path.

Patch 1 serializes a 'tc qdisc change' with the datapath's autorate
update under the qdisc lock, so the netlink writer and the autorate
writer can no longer lose the configured rate; rate_bps becomes
atomic64_t so the 64-bit store is atomic on 32-bit machines too.

Patch 2 propagates the backlog reduction of the reconfigure-time tin
purge to classful parents, so a CAKE leaf under HTB no longer leaves the
purged packets in the parent's qlen/backlog forever.

Patch 3 widens buffer_used and buffer_max_used to u64.  The u32
accumulator wraps once the resident truesize passes 2^32, bypassing the
over-limit drop loop while the configured limit is a u32 attribute.

Patch 4 drops an unreachable 'nla_nest_end() < 0' error check: the
helper never returns a negative value.

All four are hardening for net-next (no Fixes:, no Cc: stable): the
counter wrap, the missing parent-backlog propagation and the
reconfiguration race all predate any contract we could anchor a
regression on.  Patches 1-2 were reported by Sashiko (gemini) and patch
3 comes from the gred 32-bit-wrap family; patch 4 is a static cleanup.

Jamal Hadi Salim (4):
  net/sched: sch_cake: serialize reconfiguration with the datapath
  net/sched: sch_cake: reduce parent backlog when clearing a tin
  net/sched: sch_cake: widen buffer_used to u64
  net/sched: sch_cake: drop dead nla_nest_end() error check

 net/sched/sch_cake.c | 60 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

-- 
2.43.0


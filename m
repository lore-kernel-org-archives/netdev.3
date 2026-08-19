Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09C2DF12F
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172155; cv=none; b=N0bRAAYc79lE1oxvxJNVkuTJlJHUn/RD9xjKXoArbo7VuL11JC+4oa0V/66xL+7EsPAbCVzmfP7g9LGvIpLE89kzrc6kpM1O9ZoVC+6rRpj3OXi5tGSQn2cWeRMPMwU+UPNFXxgpJld+7+kOdWNzWQllR+ufsM7IOK6lGPyq5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172155; c=relaxed/simple;
	bh=U6CUc4UFgcN3WOtkrkSwIpOMrXzMvfi0W3CrIsSZkZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfqi96ur8HZsHBxLETmH6yu6/CPIHPyrGf6E2yXb4CUFNnrSn0k154HynjYiGvVGaomWMaV1wZSMid62SYX40Ko5jA/K+ataW4EH2R+Z76HsVFwTme6hKaDQZZhLw0bcYAUoHxR+n0dhkSJ2zqwlIyWiY0Pb12Rq31oYiGxHWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 705626035B; Wed, 19 Aug 2026 22:42:30 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net 0/4] net/sched: reset conntrack after packet munging
Date: Wed, 19 Aug 2026 22:42:06 +0200
Message-ID: <20260819204210.23722-1-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes skb <-> conntrack mapping after pedit
altered l3 and/or l4 headers.  See patch 2 for all the details.

First patch makes tdc.py work for me, second patch is the actual
fix, third patch has test cases. Last patch also removes the mapping
in act_nat.

Florian Westphal (4):
  selftests/tc-testing: pass mp_pm via initialiser
  net/sched: act_pedit: drop conntrack on network/transport header changes
  selftests: tc-testing: add act_ct test for ct reset handling
  net/sched: act_nat: discard any conntrack entry post modification

 net/sched/act_nat.c                           |   1 +
 net/sched/act_pedit.c                         |  21 ++-
 .../tc-testing/tc-tests/actions/ct.json       | 168 ++++++++++++++++++
 tools/testing/selftests/tc-testing/tdc.py     |  27 ++-
 4 files changed, 208 insertions(+), 9 deletions(-)

-- 
2.54.0


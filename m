Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF873E40E0
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854206; cv=none; b=FMKqepa8zfXFnqrMMQJ4FFCnRjhWFN05z5DR/HNZpI6lH/nSuP2VK+gJ6g6/Efzhm2Sf4VSZSGhU2SWFislClTcO3682q4Cfwb/Jf/7LgljYavwRAQjf4zLIcAwGlroOS98AX5yVBZppMeB4gBTsL71/tClijEMl5xCXfToBk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854206; c=relaxed/simple;
	bh=644WdXrcQKKFsq7AhDiX9d2BThhTqk+Juqvr2NrcL4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pro65OXtTXqjxuHzZl6neMi0QJATPHW1aQUZJCnGjv5JSKYn0Ya6182a9fCrC03vs87f/7CQfnfeBLHGbY/MZpiIw3h1QiDq89lgq50OcHSrPm4/NZAcrZ/UaDeeROQyChx9exsbhVna5TaG6ASOB3le2FgyJYn3amIlevHr1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=btSd0vQ6; arc=none smtp.client-ip=95.215.58.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="btSd0vQ6"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=644WdXrcQKKFsq7AhDiX9d2BThhTqk+Juqvr2NrcL4o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790854196; v=1; x=1791458996;
 b=btSd0vQ6ZNh3/DqnKBC0bLnkYskP5Spkzkfaq+oP6X5UHYSZS8mvJc5s4vSOXtOtQ5TIkyr+
 pE07edSwfY7ayGWuJzzzfRCRXkcW5elcLc70AEfo+4ypMGcRsmXoaZGf5D88NMDRalXvDcNZZ5H
 DawojIiQFkHNZtM+1RD0tiwE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7b2e7b37e7a3a569;
	Thu, 01 Oct 2026 11:29:56 +0000
X-Mizu-Trace-ID: 7b2e7b37e7a3a569
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] tcp: fix a few divide-by-zero in congestion control modules
Date: Thu,  1 Oct 2026 19:29:40 +0800
Message-ID: <20261001112948.322463-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 and 2 were reported by VEGA <vega@nebusec.ai>.

Patch 3 was found while reviewing the other TCP congestion control
modules for the same kind of divide-by-zero on module parameters.

v1 -> v2:
- Patch 3: rework as suggested by Eric.
- Patch 1 and 2: add Eric's Reviewed-by.
v1: https://lore.kernel.org/netdev/20260930100937.206377-1-jiayuan.chen@linux.dev/

Jiayuan Chen (3):
  tcp_bic: fix divide by zero on max_increment == 0
  tcp_hybla: fix divide by zero on rtt0 == 0
  tcp_cubic: fix divide by zero and endless loop on bad module params

 net/ipv4/tcp_bic.c   | 14 ++++++++++++--
 net/ipv4/tcp_cubic.c |  9 +++++++++
 net/ipv4/tcp_hybla.c | 16 ++++++++++++++--
 3 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.43.0


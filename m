Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10847DD62;
	Wed,  1 Apr 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069979; cv=none; b=Rhejrmmi+Y2VZARUOC7w6rbbkLCebFEbEJxzquyLM2Q2AR9Hd6q3pgPffjKGFr6bNf4tikO8qnUEFW2re1ALtsCBOuxMbo0fM+17foiy6wJ4tr45WoIN6xtCZuOxMdEW+NLcsM8GEn6LPAVYSEVlbtLWX6WfGEmuJAlzw94p664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069979; c=relaxed/simple;
	bh=SM0fvzn4S6HAB8T61tEjwA1SlkfahF1Ssp/acPacSBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mIwL0lV1h7bWJtIkbIIjwNmV/PFcugmMbwxMFrZ6n5vpIXcPDZYAYoYn4fQokbTkFbj0839CnVpM46yi003TaaZk7s4gpJeYlfdwSUczYX4c1IBIuctb9IHTfP+hPOrz9FU65gjuejuqoTZWQh0Axsf2UNcYs68m+LSzIZw1Ltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 631Ix8mh029079;
	Wed, 1 Apr 2026 20:59:14 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
        david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net v2 0/2] seg6: fix dst_cache sharing in seg6 lwtunnel
Date: Wed,  1 Apr 2026 20:57:53 +0200
Message-Id: <20260401185755.29813-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

The seg6 lwtunnel encap uses a single per-route dst_cache shared
between seg6_input_core() and seg6_output_core(). These two paths
can perform the post-encap SID lookup in different routing contexts
(e.g., ip rules matching on the ingress interface, or VRF table
separation). Whichever path runs first populates the cache, and the
other reuses it blindly, bypassing its own lookup.

Patch 1 fixes this by splitting the cache into cache_input and
cache_output. Patch 2 adds a selftest that validates the isolation.

Changes v1 -> v2:
 - Patch 2: fix SKIP message wording (Nicolas)

Andrea Mayer (2):
  seg6: separate dst_cache for input and output paths in seg6 lwtunnel
  selftests: seg6: add test for dst_cache isolation in seg6 lwtunnel

 net/ipv6/seg6_iptunnel.c                      |  34 ++--
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/srv6_iptunnel_cache.sh      | 177 ++++++++++++++++++
 3 files changed, 201 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/srv6_iptunnel_cache.sh

-- 
2.43.0


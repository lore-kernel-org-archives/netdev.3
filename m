Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400D25A655;
	Sat,  4 Apr 2026 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775263506; cv=none; b=T+7NOpIP27v2ungDw0eAaVgInNlL1Il3G5RZqy9h1P/0qHYnRv4UHmY6EpYK5absWL12ko1rdc/5ZKRawz3tzeueJ9s0P6aG/owNRnYslB2cqYEMVZekqXfDt+qdM26qXnsYOvMq392cRJJ5VmIoaZCSqiYAI0+cTVaNxj6Chqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775263506; c=relaxed/simple;
	bh=yzbPoeeHHDwulpbumKyKCjqaSbxGUmPqE6/UL4HMRSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nD77YOTkR5kiXh08foLbVBrQwxsuvPqE+6+2y0nuFhG2hfsbSOLDLlVesm9n4LhEuo7OeG4CoH6X9BzyjTB+XQXDh9w9r+XDqmS26ByzvOuHo0W46/Ecy22ayuRJjBya3FPLwGBMOSAorKnoPN9VGz5VU58MfgPf4zj2A/bdcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6340iYLD026118;
	Sat, 4 Apr 2026 02:44:39 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
        david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it, nicolas.dichtel@6wind.com,
        justin.iurman@gmail.com, linux-kernel@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net v3 0/2] seg6: fix dst_cache sharing in seg6 lwtunnel
Date: Sat,  4 Apr 2026 02:44:03 +0200
Message-Id: <20260404004405.4057-1-andrea.mayer@uniroma2.it>
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

Changes v2 -> v3:
 - Patch 2: add root privilege check (Justin)
 - Patch 2: extend prerequisite tool checks and use ping instead
   of ping6 for consistency with other srv6 selftests

Changes v1 -> v2:
 - Patch 2: fix SKIP message wording (Nicolas)

Andrea Mayer (2):
  seg6: separate dst_cache for input and output paths in seg6 lwtunnel
  selftests: seg6: add test for dst_cache isolation in seg6 lwtunnel

 net/ipv6/seg6_iptunnel.c                      |  34 ++-
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/srv6_iptunnel_cache.sh      | 197 ++++++++++++++++++
 3 files changed, 221 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/srv6_iptunnel_cache.sh

-- 
2.43.0


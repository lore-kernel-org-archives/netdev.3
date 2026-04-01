Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF73BBA1D
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035431; cv=none; b=IJbE6PelsIkyql8AgTTBnmtx6LqRorx1Kl+h+2utc4WseDKQba91bupOl/ve92H3hTIVIOO83jqHmOdkR0Kxj8EvpeKEM56n6e0hxybW5w+AfQS3ltwZkhM8mhTeaLEe+NYnclY5n4huLvDVlmQE7yOL5FNGG+SaB0vt+bdYzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035431; c=relaxed/simple;
	bh=rPPx5WkBU9Jvqt81h7Y1Ix6AVdkAzhYYixTLHgOtStg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZq/uzOQmkqpf5pxePJ7Slhp9pSTF+d5qE9DZd8aKk5rIFc5AnuajuSBylxBhPBj/ZaXQ7mRQEvAIc3Sib2AEXClNH1/wzNntgEWqSpobnf23hkLUSrXaPYvTDV+ISr4bA7LcAJtnTXjWOC/Oxd3SJ5oUkaxv7rL6tkosVVbG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HxJ8I3Y0; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HxJ8I3Y0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775035428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Hzvzw3XsDopvM0mKzRMgGwQFxynYJ9646hbuSOHwZ8=;
	b=HxJ8I3Y0xkYw2KsuYAeFIC/s1z1KnEJsgQj5oRBuJ57pDm++U4QlVzJwtpmOha6G8KE3fm
	8KQHsRGGkpVYx6RJrdlPrfj5rKKqPKA0OUz5PSxCZLAL9e0hkha4xY4gLKkTkaA5YBI/Wy
	7EaaZCgRgUi9GDBxOjwM5vb+hEMCYMo=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v4 0/2] net: hsr: strict supervision TLV validation
Date: Wed,  1 Apr 2026 11:23:21 +0200
Message-ID: <20260401092324.52266-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

This series improves the robustness of HSR supervision frame parsing. 
It enforces strict supervision frame TLV validation and improves Netlink
error reporting for invalid interlink attributes.

These were previously part of a 4-patch set. The first two patches 
(fixes) have been sent separately to the 'net' tree.

Changes in v4:
 - Split from a 4-patch series into 'net' and 'net-next' as requested.
 - Implemented a TLV walker in Patch 1 to correctly handle extension
   TLVs and avoid regressions on paged frames/non-linearized skbs.
 - Corrected pskb_may_pull() logic to include the TLV header size.

History of pre-separation series (v1-v3):
Changes in v3:
 - addressed Felix review feedback in the VLAN add unwind fix
 - removed the superfluous empty line

Changes in v2:
 - picked up Reviewed-by tags on patches 1, 3 and 4
 - changes in patch 2 per advice of Felix Maurer

Luka Gejak (2):
  net: hsr: require valid EOT supervision TLV
  net: hsr: reject unresolved interlink ifindex

 net/hsr/hsr_forward.c | 41 ++++++++++++++++++++++-------------------
 net/hsr/hsr_netlink.c |  7 ++++++-
 2 files changed, 28 insertions(+), 20 deletions(-)

-- 
2.53.0


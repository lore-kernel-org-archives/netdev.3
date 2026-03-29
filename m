Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDF1EF09B
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783419; cv=none; b=bWb3jCxgJA5ClDiV0gfICYB22r2yPgsC91KFQ2d8q3fgyL+LCh8H+vZyFldQq0FJLO/prYiUAwEvzBYOYpmLLr3TfmZeCBRmMYIKqtpUHKyI/4R8KOCELtDS6cgdUUPzmYHpcafI75VC1Lz9aByagcwhRB+6ugDfRl3mQKWyQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783419; c=relaxed/simple;
	bh=3vK9/tBbRSldHkPs25YpfNuwM2slJNpwAvZdy8f51+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k16BPMvcHVlnOIIMh7w2iAbAJkf1VeCh69ZxAIZneCE8ldU7q/i4jtseXZ2TIkCPUDO8caF2kxazKS8AjesGy/UIcWpSsXB7Zmxr73GkbU6WNbdhUKhilzC2Um7VncumkznfeRwsz1WbNrDM2cne0i7ZjrlZPJd3X90A1pEBJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G5W1ULz3; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G5W1ULz3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774783414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iiblowTcFud3mo8vGOdHH4Nz2g6KancUksIrQIRD5eU=;
	b=G5W1ULz311CmkDuQZlS0xlUPQZ2Q7WiwZAGlpGNEShsaKi9fV2c8hf9U4LfB22Gc8YZktf
	eIDQdTf/ci2rQf2AIGGJ7Td618RDyPsK6EOtXeIb3CVLJJPiSO4xAyW/gpkNsorj6cQS1j
	/6BC9BaddqP0P1RaqwjZQK1iYu9u+aA=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v3 0/4] net: hsr: address functional and concurrency bugs
Date: Sun, 29 Mar 2026 13:23:09 +0200
Message-ID: <20260329112313.17164-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

Changes in v3:
 - addressed Felix review feedback in the VLAN add unwind fix
 - removed the superfluous empty line

Changes in v2:
 - picked up Reviewed-by tags on patches 1, 3 and 4
 - changes in patch 2 per advice of Felix Maurer

This series addresses four logic bugs in the HSR/PRP implementation 
identified during a protocol audit.

The primary change resolves a race condition in the node merging path by
implementing address-based lock ordering. This ensures that concurrent
mutations of sequence blocks do not lead to state corruption or  
deadlocks.

Additional fixes include correcting asymmetric VLAN error unwinding,
enforcing strict supervision frame TLV validation, and improving Netlink
error reporting for invalid interlink attributes.

Luka Gejak (4):
  net: hsr: serialize seq_blocks merge across nodes
  net: hsr: fix VLAN add unwind on slave errors
  net: hsr: require valid EOT supervision TLV
  net: hsr: reject unresolved interlink ifindex

 net/hsr/hsr_device.c   | 32 +++++++++++++++++---------------
 net/hsr/hsr_forward.c  |  2 +-
 net/hsr/hsr_framereg.c | 38 ++++++++++++++++++++++++++++++++++++--
 net/hsr/hsr_netlink.c  |  7 ++++++-
 4 files changed, 60 insertions(+), 19 deletions(-)

-- 
2.53.0


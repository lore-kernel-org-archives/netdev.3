Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2279E33998
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035395; cv=none; b=dD5gJHaeMKmFrroTAa+gQ4xJnoc2DVp/vvXg72l8rpECjbngshDAJeWINVxYJL+jO/JO1EVo3NWElx/WbtzcAIi5JQ5HWc86dlMUMgsWp8VRwVKjcqBq8kpQXGE9EHFo8U+nE1lWwGLam70KoXwNbk143nreKyfE9DRE5Tw7590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035395; c=relaxed/simple;
	bh=z4vIv6mkwIazQdR/7Ot4o0gUBujHHzJhifqzTTdAMuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4/gg0cvhxFY1p4izOzkJ7RoX6gJxBKE6LSEGUwPSAFJkJDlLbca+BXPZWvWt/CkHlOjRbpKueCrCg6joo/x6A5pApODzM/6kq9kwMjTuVumdVf1bH8wSP/ETFtqqKb+SmlfXujvPxFmSkosWkBAfBhES++j3PZKMRzM+47d/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=psQ4Sp3Z; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="psQ4Sp3Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775035391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wuMi7n6y3fyd4CXjKFyGGiHfgNYLPb1anwOJBuevvgM=;
	b=psQ4Sp3ZH6lSnMgEhMA7P5VgU8YD0Me3SkRaouN7hHScoUQ5U/piBviQksASJFXt1sTBjy
	+PhSsawy++VRtTU5eKNdkWfPYjMMibZMdasBaZr/V1P1CkOeMLz5dmtpxsOsMMhvaYcyDr
	A8IImKt7bkrnnIQrH+ZwQXsBCKleZ5Y=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	bigeasy@linutronix.de,
	m-karicheri2@ti.com,
	luka.gejak@linux.dev
Subject: [PATCH net v4 0/2] net: hsr: fixes for PRP duplication and VLAN unwind
Date: Wed,  1 Apr 2026 11:22:41 +0200
Message-ID: <20260401092243.52121-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

This series addresses two logic bugs in the HSR/PRP implementation 
identified during a protocol audit. These are targeted for the 'net' 
tree as they fix potential memory corruption and state inconsistency.

The primary change resolves a race condition in the node merging path by
implementing address-based lock ordering. This ensures that concurrent
mutations of sequence blocks do not lead to state corruption or 
deadlocks.

An additional fix corrects asymmetric VLAN error unwinding by 
implementing a centralized unwind path on slave errors.

Changes in v4:
 - Split from a 4-patch series into 'net' and 'net-next' as requested.
 - Added Fixes: tags to both patches to facilitate stable backporting.
 - No logic changes to these patches since v3.

History of pre-separation series (v1-v3):
Changes in v3:
 - addressed Felix review feedback in the VLAN add unwind fix
 - removed the superfluous empty line

Changes in v2:
 - picked up Reviewed-by tags on patches 1, 3 and 4
 - changes in patch 2 per advice of Felix Maurer

Luka Gejak (2):
  net: hsr: serialize seq_blocks merge across nodes
  net: hsr: fix VLAN add unwind on slave errors

 net/hsr/hsr_device.c   | 32 +++++++++++++++++---------------
 net/hsr/hsr_framereg.c | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 17 deletions(-)

-- 
2.53.0


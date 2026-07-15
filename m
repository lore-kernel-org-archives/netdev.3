Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8F3CAA51
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104040; cv=none; b=VsSFILn3e8EchS/q3viIGQH5WsLKMcCdX0vFeeMe2gvATK1zdJCCygjiykBfs1oq4jAmU5Ok5VMDNYxlJqOQGEWE3FGqMwVFj+CDZH8FCTEUWscOmTfPO+J0YGaBZIT1T91ig7umJr9WFjtNyX4WVJJqCJ1wXeV4dbHJ5GF0Bcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104040; c=relaxed/simple;
	bh=BnL9n5nc1HHvkHTyWo8BziebfQkfqWKCqTNLPrakQ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAmIwU180pohn/mmTrBgoG3QSSKm5EUSlPyta+IherSyGA0V/b0mvqEMMxw5e04Do1LNZrV3i7uQGZ312lx0JKlv3tmuvQzyRHdxWa+wKVeolZ27dhO7Ecc59CoJDNxncxh3jEV0a7yWX3Iqw8v1MkKVwzHtp61TrOpIA3peB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L6OFFdD7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L6OFFdD7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784104036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IQvzwDlyfedqq++oUVQVScJTnk4XMFNZlSdaiPo68EA=;
	b=L6OFFdD7xzHaeR1tD7FeX03tM5T3O+Y5ZtrOyr43D0CkdPnVb+Ckm9dYV00naJW8zMgszr
	SxJfLf0ECh5latFnHck1c1OcM9bv8tu3YyRkgYUs4UKmj/STg5miOLT0R1O81vRMmQ0tg9
	bNWS9DyBHbWnEu75e19EtxqkEp6AKSQ=
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jagielski,
	Jedrzej <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH iwl-net v2 0/2] iavf: fix two memory leaks
Date: Wed, 15 Jul 2026 16:25:46 +0800
Message-ID: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

This series fixes two memory leaks found by inspection in iavf. Release
the ASQ command buffer when initialization fails and the QoS capabilities
buffer when the device is removed.

---
Changes:
v2:
  Patch1:
  - Move the ASQ command buffer cleanup into iavf_free_adminq_asq() to
    pair it with iavf_alloc_adminq_asq_ring(). (Suggested by Jedrzej.)

v1: https://lore.kernel.org/all/20260715061131.34420-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (2):
  iavf: fix ASQ command buffer leak on init failure
  iavf: fix QoS capabilities memory leak

 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 1 +
 2 files changed, 2 insertions(+)


base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.43.0

Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EC3909B9
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095987; cv=none; b=quQxiUtbBe+uM8JY1nuQgoMnxSMtblCZX/odCXLiMsAV5CUyp55USe7w+fuDR6EGq6mWhOe+1zJwATlIR8QXCJ43e/fnrtREm8b7GxiPadXo8iUtI4X7KqK02iGpxh7z7aAJY+XNSOY3zLYT0TaBHZtnehEcv8H4k6gHJGL7fvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095987; c=relaxed/simple;
	bh=3s/qCey1Oq93zdllqNccu7JHWUZm5oKkLoh8sy2O434=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KV/kcDMC4N+6k3zTAp5U3nzetovcmn7QzjZP7uD4RVxkevOl38bvANDJG/1EIkGyHtewr0WYBs9y+Bu33GS0urc7Cnvnaxx/t97llCRxygiFzaBMLrHBFevruguZ/dyTHlx4NJZ3wDD1MuDffyM47GEVGc0oIBP+mSH/PdOhw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=koTyQ5rO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="koTyQ5rO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784095983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RWpJTHJ8TyXGkDWqsB7xYyZHeqa3pjiQY10iz6i5Vhg=;
	b=koTyQ5rODfYlsV3CszwR0yZKArLEfwxG/IevGon6Bq25lCYwM5e+ehyL8vIXm0qwyLmbWN
	Nhbb7dCPR7giThL5KIzUTOsVo1VYia+rvnwVX1KkZ3/h6lEDvBTKQ0gomvHOeGaX9B28HJ
	wIvmlStPK4t3wI+/wv/xKEYpDL6tJCM=
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH iwl-net v1 0/2] iavf: fix two memory leaks
Date: Wed, 15 Jul 2026 14:11:29 +0800
Message-ID: <20260715061131.34420-1-xuanqiang.luo@linux.dev>
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

Xuanqiang Luo (2):
  iavf: fix ASQ command buffer leak on init failure
  iavf: fix QoS capabilities memory leak

 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 1 +
 2 files changed, 2 insertions(+)


base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.43.0

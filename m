Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2C40D591
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778491; cv=none; b=S1qaQhIvY1JS9Y/8xZk9rCRjHTAijfHrp6B9ot0caVNhIGWrbRX7G1G6NEdhThu8dZ9GPk4weim+OyA7aRLpHg2TM15qgX4YzaM28Nz7qIQLk/1+F/ZVCJ+gcFUq3Z0P7+7TWg8/gOjwB3oTIo/F7OmJPnDzfYU1QNiS2Y5w9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778491; c=relaxed/simple;
	bh=wzgklKqTT/oXdLvAuwCRYA0niHjTjIrl3LWTdhCoAGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcEK51yCpOFjnK/eVT7NlZYrQsnrCtYLOyLUDjuL/u+/AIJTD2RCC/8FDZd2m16D3dBNKUgZkz6cefc0lmRLzfE5PJUYACDLRKuVdRWC/kYccCoTmSq1u5xJR2Omt3ESx/4bjeXdww2YQO7ZA2kdotDBoIadjuuMCsl36hRIGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc3FbIfR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc3FbIfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1071F000E9;
	Tue, 30 Jun 2026 00:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782778490;
	bh=4Sz8NDRrP7lGuiro/kMVJOZ5950TZHeBzEKf8Emf5ho=;
	h=From:To:Cc:Subject:Date;
	b=Oc3FbIfRLe+9B7XAxlSrmbg05opfQIXXDO+HlzGZTtLdQNnHxsAja8TazKgeS1qZ2
	 HpldPGaBk/+d8yocMpPvt6T47O53/g58l9sfzKk5n/3LT4k9SZBzzjaSbSU8tLuo0M
	 PI0F4Wo+GAWgazkajDCdo7AbntgHoSbjXOkUeN91lgaRYgbBCwNaOVBb6povlrDa5k
	 kLvJ/mYuJDjiuRVOAPQcD0sZNF0p06UHksiaJJyKKyHQK3z0NKL8hJLNNcSs98bUb+
	 CbDj52ELg0mxpSzUfsuT5lc9ksNDX6AdKfQ9LlgHBCfb3flIukBDhptP3W/DUMqE4T
	 OiH8Z0HLJZWIw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	gal@nvidia.com,
	jstancek@redhat.com,
	ast@fiberby.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] tools: ynl: pyynl: minor library ease of use improvements
Date: Mon, 29 Jun 2026 17:14:30 -0700
Message-ID: <20260630001432.2204298-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of improvements for using pyynl. I was writing some scripts
to check / set up things in NIPA over the merge window, and wished
pyynl was easier to bootstrap.

Jakub Kicinski (2):
  tools: ynl: pyynl: re-export the library API from the package root
  tools: ynl: pyynl: pull the --family resolution logic into the lib

 tools/net/ynl/pyynl/__init__.py     |  9 +++++
 tools/net/ynl/pyynl/cli.py          | 53 +++++------------------------
 tools/net/ynl/pyynl/lib/__init__.py |  3 +-
 tools/net/ynl/pyynl/lib/nlspec.py   | 14 +++++++-
 tools/net/ynl/pyynl/lib/specdir.py  | 51 +++++++++++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py      | 19 +++++++++--
 6 files changed, 100 insertions(+), 49 deletions(-)
 create mode 100644 tools/net/ynl/pyynl/lib/specdir.py

-- 
2.54.0


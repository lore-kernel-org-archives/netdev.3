Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6232741B6;
	Sat, 13 Jun 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781369969; cv=none; b=fEMcTBBF3eisCwmYlCuvT4Mml7TC79GRA9HL0ODmeWlMsgYwTk47ZPOdbDq0GLSAwDcRmNyEddGh/tTTLdWwGc/OJkJlPJTdRafS8v/tX5Yc0xl9IjBAbLkH4KqRsn/BcYO65p/zHUIgpHHXS22ywNEBiOlxnQB4iEoFZ74qRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781369969; c=relaxed/simple;
	bh=4a3q9ydzCsI+mJ+XHypy7eVRmpYtzzBfYD+oHnzQqpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryfoNi4RylOxC5VICjbxuIFb8F5W+15gbVJYwPMQOkpoM5l9oF4YjFUyLmUztXfZi64PQ/EvfesWwGp1OUpNuvjVb1+X5rZXYvCNFagQpkRhJry0tlBfeVzlLnb3PA4WA3o1ZyiZSsNQF3oHZlL65S0fSUQUsLdek3BX/HJgISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izerWIml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izerWIml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1261E1F000E9;
	Sat, 13 Jun 2026 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781369968;
	bh=I2NFA2mXsonOx3IjoKjZ4grfhjDTs5aTYbYOrdpQ7+0=;
	h=From:To:Cc:Subject:Date;
	b=izerWImlTBo6nmI/r5c9bNc3t5Fl0BsCoZgXiQjzGJceGQHSQoEOv1mbquGNoLB0r
	 23MA8d9al1UGj6MHB8WItrNj4E5DxBaBilLlCGK/R7QI6Sejjyeuqwn0nKV+Z9w85U
	 tvXMIZYvGxv0YUkpmIEPBhYgAsGMA0mSZVBV53WB9wcDlDnHibiXIa5qLXrODGj/1U
	 lizByype+4Wrf/tLafdtF6NXz3n6B+zm4qF0ArFs+5FLIMnMe7Vsg/8AvHApd7EG+I
	 XGgVx/5ZkyvDkewpfHQ+vN4idxubR9Q7JVSTE4TlVyIBSaayrZc/mnxWSxvWecXIjV
	 qfFjvg3E9n3Dg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] docs: net: more adjustments to docs
Date: Sat, 13 Jun 2026 09:58:43 -0700
Message-ID: <20260613165846.2913092-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few small updates to the docs.
This is trying to prepare docs for getting fed directly
into AI reviews.

v2:
 - fixes in the tls offload patch
 - add the strparser patch in place of the already applied XDP md one
v1: https://lore.kernel.org/20260609201224.1191391-1-kuba@kernel.org

Jakub Kicinski (3):
  docs: net: tls-offload: document tls_dev_del, tls_dev_resync, and
    rekey
  docs: net: fix minor issues with devlink docs
  docs: net: fix minor issues with strparser docs

 .../networking/devlink/devlink-health.rst     | 12 +++--
 .../networking/devlink/devlink-params.rst     |  2 +-
 .../networking/devlink/devlink-port.rst       |  5 ++-
 .../networking/devlink/devlink-trap.rst       |  8 ++--
 Documentation/networking/devlink/index.rst    | 10 ++---
 Documentation/networking/strparser.rst        | 22 ++++-----
 Documentation/networking/tls-offload.rst      | 45 ++++++++++++++++---
 7 files changed, 72 insertions(+), 32 deletions(-)

-- 
2.54.0


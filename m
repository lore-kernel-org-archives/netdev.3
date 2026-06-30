Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092E8462
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778491; cv=none; b=PHfvNpkjpJWA9wKARFpxhZVdjkM07D5tRKnS7a8yNdlD42EpN2rJ5W+SJXpQw1FOzekYHouLNvxQnmYDZ7QoBmrJF7Tfyy4ZTGzvHzODLuTB6HyM0mhcGQgPQSHrxNUYaNoeknEQULGWIMB2KB09GAiLBXmpGs/RWX8AHBZGiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778491; c=relaxed/simple;
	bh=v5+29Kpbc5bupIvYUIlTV/DfeXd6RiV8cyZNS8sAvfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFrDUM0AEOyJaEuJIGg07uV1M/QwmWjAlO7bFfS3OlsPd7ZwpFIApVFNZNxhcThGHmvn+H4RruL7blkGaQDqz2v4DPgBl4qvYeE8YtYNzLmTuA2Eab2kDgJK1WiJrwk/62DSuSyLg6dYMXax+uhyT2jpRB42cgtd4JwQdR9xEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlXCCqXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlXCCqXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8C11F00A3A;
	Tue, 30 Jun 2026 00:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782778490;
	bh=2v7zZIQ3vK72RFYzgeIOBtJHph9CkJ/baNkQ3QrMYlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PlXCCqXkOYZOk9dE/MDajl7H7D5g5vl5WVa+p33kHsuxgjv6Wb408peH94iBxFzDL
	 l0dPLbyHSO2v24OFGcS+qZljeJpluRPL+C97DFJ0ZxooTkImarAl9XLCQUPWTFtaf6
	 HK/ZtnlR3ZYGPiLxAbyzu0cHsNjBdegiBqcLNS3huH2S3wWrdIprAp1vEeOIJhvLfh
	 8efE+biqsf6JhXl7xAEDEdWQAi5cgyYqqbpIoVlXYIrksPzGkh9GI8SZBtgV8K/8Tv
	 Dp9x0OXL57hQZBL3VGRI7lWA1fniXce4r2oX4tSfCiqflCoW2icM+O6zBI0YsHBOcu
	 iKY7Am5Lvk5KA==
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
Subject: [PATCH net-next 1/2] tools: ynl: pyynl: re-export the library API from the package root
Date: Mon, 29 Jun 2026 17:14:31 -0700
Message-ID: <20260630001432.2204298-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630001432.2204298-1-kuba@kernel.org>
References: <20260630001432.2204298-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The public classes live in pyynl.lib, so users had to spell out

  from pyynl.lib import YnlFamily

which I forget at least once a month. Re-export lib's API from
the package __init__ so that

  from pyynl import YnlFamily

works as well. I don't think there was a real reason not to do
this?

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/__init__.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/net/ynl/pyynl/__init__.py b/tools/net/ynl/pyynl/__init__.py
index e69de29bb2d1..d8f59c132ab7 100644
--- a/tools/net/ynl/pyynl/__init__.py
+++ b/tools/net/ynl/pyynl/__init__.py
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+""" Python YNL (YAML Netlink) library. """
+
+# Re-export the public library API so it can be imported straight from the
+# package, e.g. `from pyynl import YnlFamily`.
+# pylint: disable=wildcard-import,unused-wildcard-import
+from .lib import *
+from .lib import __all__
-- 
2.54.0


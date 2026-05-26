Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C0638E5DE;
	Tue, 26 May 2026 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811052; cv=none; b=CVG521LGtJy5nIp8yiQsMHc2wmJ5Qx/k26wofBu+03Aqu0nrXxGU0yN8v/Z+KKqKmDkDQL9K82K0T5a8XsvpbBgnuxRGafLM7TBzfbD2Nb889HPxs4HA8YbvCv3g1YqhD5b+TFrFGC5UR2ojwY+NvvXw9KzDtADFEZbtIWeoI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811052; c=relaxed/simple;
	bh=35P5ihs62d+8XuLSFRE194a4DoNxFDAiihBX4nTgms8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgKwlu3VWaHi/ttIpN7ysUTQtwJeelZpxzLPPNw0o3snP5C/X7FBG0cdas+IAAEhYJN9N9NzH38RpE0iq24FwtwZBOlTozBSlIVJn4eWAYZ9R/PRigGvIc6VebaZdAxxS0m0+TAlPCnBh1/ToNaf51oZNUzhhsaN8oZ/syBfPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/fwzVk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/fwzVk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856F11F000E9;
	Tue, 26 May 2026 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811051;
	bh=11mCCtQpMU2T/iL799+eV5Hyo+Wjyfzw/iY1pN7ROms=;
	h=From:To:Cc:Subject:Date;
	b=c/fwzVk7UcQBrw3pFvvCdOsQCYYVOZk+DloGXX0a8wcz0b4XFuUffcDMyBzWV2KE2
	 I38luRI+J+EiAIzzDvCSqlKK+ngMooqAQFbc1LpIGQ7u9qpK4RMDSrtxVG0RiZtSNi
	 dZwRISt06mGi+RFkXABNpf9AdgkPKMrdi4Ryf4AAUaEvkF9TBOjyRZa9YoabhXHfLi
	 +3NLGePddljH5TCgOVYjND4l/bJ77Ou2JpkWKpe5AQvN+U2iDEsl1x+tQuvpAF3oYE
	 SARQ9JZB+b33TqbkS+cW7sM1BwXmuQfDIHRsyPjOgfpenQoOS6iG2JDdAFlb/Iu08d
	 9OQxCmlWYU4Cw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	linux-doc@vger.kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] docs: page_pool: tweaks and updates
Date: Tue, 26 May 2026 08:57:18 -0700
Message-ID: <20260526155722.2790742-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm hoping to start feeding our docs into the AI review tools, instead
of maintaining a separate repo with review prompts. To experiment with
that we have to refresh the docs a little bit.

This set exclusively focuses on the page pool API. First patch is
a straightforward fix for information which is now out of date.
Second one attempts to clarify the NAPI linking requirements.
Third drops the dedicated section about the stats; the document
is primarily developer-facing and the stats should require no
development effort in most cases. Last but not least minor
API cleanup.

Jakub Kicinski (4):
  docs: net: page_pool: drop reference to removed PP_FLAG_PAGE_FRAG
  docs: clarify page pool NAPI consumer requirement
  docs: page_pool: drop the mention of the legacy stats API
  net: make page_pool_get_stats() void

 Documentation/networking/page_pool.rst        | 60 +++++++------------
 include/net/page_pool/helpers.h               |  2 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  3 +-
 net/core/page_pool.c                          | 10 ++--
 net/core/page_pool_user.c                     |  3 +-
 5 files changed, 28 insertions(+), 50 deletions(-)

-- 
2.54.0


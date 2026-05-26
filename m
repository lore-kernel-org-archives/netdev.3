Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD0390219;
	Tue, 26 May 2026 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811052; cv=none; b=ZQMH0U5urLT7mNHUEzcCcgIBy8wDrpAbdbbD3gNqi5Tlfjwlopz0A+CGTi4UpNFYouMeoouqXBlMcegDejYqmgJBETmbdIvwIGNfVbDc+0bxl2f3t9X6mvKaMgTIlHQzpC6ChmDxmduAD7iltId266MTXU2BgRVz497++FdeHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811052; c=relaxed/simple;
	bh=vRIwvHxG+joqjqpEPE7ZvbFsoxMA5MVccnWb+6K29pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcCaBI5ceSqAIMK6hjxx8yj0LykFeDPtzeeNVlWFkO5IfAtax5vvq9Q5ac+kPvgFpXkGnG+bGWdAv556nfhFY5sx4g+tUU8LPsbml8zpmcU6M7PVTAE3zoW33RXJYpK78GfsExN0B0Mmv8mbYjBFTAq3talWo2zez2DMk60tKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP6X2i17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP6X2i17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB8E1F00A3A;
	Tue, 26 May 2026 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811051;
	bh=1Q3RoikXtECR93KxeOa1YwX+EhS1rkjHWqhPH/lOn40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XP6X2i17Rc8i3almstGKl7VP9v7obIeisCefS3kfebPvg1YNlaBVsv6+/VJZCM8Gy
	 5lMEemJcZfzElrVQTWcljkbGRP/xHrIu6Suj+DkEcC2h/vpiIwcm/3Us/A8xckXyb/
	 WKgguprVYqUQb0NiimqvheXpO04i+2hFQ6XlTlC5/ph4WwrTAoJXVMBMRixi5fjH6T
	 NTItDx41ngRTqWWNrzboltYUnPwUCybieYxvosIcZNa88n4EPR7ve1haxGJwhPGIH0
	 hM6qPkFV06b6jeOvAxGhRLsriiqCgRk2IXQGFBBtPMakJ1iATB39J4KdihiJjpqmVj
	 GGEAIAgbLFRKA==
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
Subject: [PATCH net-next 1/4] docs: net: page_pool: drop reference to removed PP_FLAG_PAGE_FRAG
Date: Tue, 26 May 2026 08:57:19 -0700
Message-ID: <20260526155722.2790742-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526155722.2790742-1-kuba@kernel.org>
References: <20260526155722.2790742-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag was removed in commit 09d96ee5674a ("page_pool: remove
PP_FLAG_PAGE_FRAG"), but the documentation still mentions it when
describing fragment usage. Drop the stale reference; the fragment
API does not require any opt-in flag.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/page_pool.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 9d958128a57c..6e43e1953218 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -98,9 +98,8 @@ If in doubt set ``offset`` to 0, ``max_len`` to ``PAGE_SIZE`` and
 pass -1 as ``dma_sync_size``. That combination of arguments is always
 correct.
 
-Note that the syncing parameters are for the entire page.
-This is important to remember when using fragments (``PP_FLAG_PAGE_FRAG``),
-where allocated buffers may be smaller than a full page.
+Note that the syncing parameters are for the **entire page**, even if
+the driver allocates fragments (e.g. via ``page_pool_dev_alloc_frag()``).
 Unless the driver author really understands page pool internals
 it's recommended to always use ``offset = 0``, ``max_len = PAGE_SIZE``
 with fragmented page pools.
-- 
2.54.0


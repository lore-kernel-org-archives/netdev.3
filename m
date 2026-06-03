Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE0326927
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511911; cv=none; b=Qlfsq+QBfjXTaLKsjOjduH+8Yz1KrzW1fWqFTqTwhnlyBUcf8uUVdvmX795np8MTsH7Ze5vp5IxEhZEVCA0D9Qva4ZoxvzqXWtElmptdSktwxIk+KXvwpMhI/DQUuMhw9sI74pKUaZlKmXi1xVXoTis5fPrZNk8QyTmfG8kVlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511911; c=relaxed/simple;
	bh=AFPRxEWbMPypR0ccmvJKhioTJazqOhSC4iwZMZnrDWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DX1arJhxHSDjc80akGqCsh6egu6l7SWzuJHFMvivzmeUWoUOftpvIdAghJGJ8YDPb2rjJOftha6vzdEq9erVtc85mFKGfuiezinCdmQsPSaHpINWp/VbT3G4UMv1dBfXIh9axvuEs+akzJf+7LXXO5ZB7RtZSXWHh9dkVQS5agc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkFhc+qS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkFhc+qS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3411F00893;
	Wed,  3 Jun 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780511910;
	bh=JgdD/bGirLCH7vTqPwyby1f5UDTFPCRJING/UqnDSUU=;
	h=From:To:Cc:Subject:Date;
	b=mkFhc+qSAe2eZeM0IJ2OXfR1maFb+j6weerQuqdGufdC5yjN/D7XkVYBIVJK9R2BQ
	 5fsPBwPeCJGfx2a2mPqrDrJqRXMLh6Uxbo9HhNYkqwl3yNYjgaaa8QSqh03SgURCi5
	 yWL6Yk0QgvA22MAgOhLAj5dSaIAsQ+IhH9nIJlfaWfnr09A6nfprgomxzgZs2HAUVF
	 seWcDCI+JpKy4NO/UkbunsMkDhGiCM8p3fWkvlMMoMVNaFxrTu6KPt54uPqRkDaXi1
	 O9CIpB5LzBVcxs5tXV+x9AH15MeMgTcU0hSNaqRHlfr5QNykmKUOQy3/tLU77psVTW
	 5B6Gq4318FEIA==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [RFC] docs: netdev: suggest that it's okay to rewrite AI generated patches
Date: Wed,  3 Jun 2026 11:38:26 -0700
Message-ID: <20260603183826.2521491-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has been on my mind. Not sure if anyone actually has the cycles
to rewrite patches, but I'm slightly worried that maintainers may
feel frustrated when dealing with people who just feed their review
to an LLM. Should we make it clear that it's okay to take over?
Or is this already obvious to everyone?

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/process/maintainer-netdev.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index cc4b5fa3b5c1..907403a4f638 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -311,6 +311,16 @@ OK with that, then perhaps consider mailing security@kernel.org or
 reading about http://oss-security.openwall.org/wiki/mailing-lists/distros
 as possible alternative mechanisms.
 
+AI-generated fixes
+~~~~~~~~~~~~~~~~~~
+
+AI-generated fixes should carry the ``Assisted-by:`` tag.
+
+Maintainers should treat AI-generated fixes as equivalent to a bug report.
+Taking over and submitting an alternative fix is normally frowned upon.
+It is okay to do so for AI-generated fixes, however, if the posted patch
+is far from the desired implementation. The original reporter must be
+acknowledged with a ``Reported-by:`` tag in those cases.
 
 Co-posting changes to user space components
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.54.0


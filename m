Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211421;
	b=YA70wxB1HvXnPVUif+eA3MyB+4qOgC3bpXh8XnsZrwAlLeoPZH4qFcse2//zJvU4EScT
	 VLBxHylmuxiNrIRQhCSl3d/yFZWQN/Q0L2/v+GMdrdsgLd8RxPgY56HGvARXgCSeiqgbd
	 ZJ7a7R8OjhyfdkA75jBfxjPN3J6weFpBUFKkOc1E+AbkE1xOJ/g4vryMoyuzgJQJmMkjE
	 YU3cL6mo4QjDd5u7XP5cJDOjUEkaIfvImN14lfktN5ZWqzuk3sUTPMrbxYS9xje8gosg3
	 gkin7MWSX2l/3JzhvnPakuL1t/DLm0IMmx9bWVb69YftuYwOB5dbmyYvGpRvCkt8i5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211421;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OxeUOVtKsetsphxGDMJs8PJRhMZ9AqwAedSw7oZd+VY=;
	b=PaEFAtQ9MEFbYaQW8rS5dI6tB50fP0hVOJAVyFgbfxMO/5UI/KLBWpNZ3V5Pb5cMDQ+b
	 YQw0359eX2Fdp8hk1Tc32GOlL6vMKGdhvEhWk3Wx+98zHn5pxKFm7tymFiR+7AmuT1Aql
	 XcbxqCeXx2MKXAyFl7HIiVAhFIQk7n0eoM0pZrVIvhw+gnjZXWLJ8qoCIyx0qC13NldvV
	 YyxvPN5fHEIkrdF+GR9QQxd4gqFCY+lZuTNdjZuj1TCsHEzsKgLP9q883ZaQsCEKcIi9n
	 i07XQITJEv9eDSGze0q2E1PL8W3LZB/qxdYvDTKSdQsu2EkkjKaLDc9oRBJyNkdno+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=pHEycA5r;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839C606D83D;
	Mon,  9 Nov 2026 08:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2839C606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=pHEycA5r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=OxeUOVtKsetsphxGDMJs8PJRhMZ9AqwAedSw7oZd+VY=;
	h=From:Message-ID:From;
	b=pHEycA5rs/S9jmCpua8ZIaBjZUk6jouvVhxIASun9dOicjtjmr1u1h0vFSnh0cEb6
	 u+5bhdCiiB9CU2ys1XOgRt8wuU4zz3gtFfpQJbB+IRykl9R+1xjs8RFkGiXDGVD9S3
	 xJ0LiacFT39HFn32xe0T6XCkOCnT333J3W04vp+A=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id C1918C0968;
	Mon, 09 Nov 2026 09:03:34 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 14/14] docs: netdev: align the security fixes section with security-bugs.rst
Date: Mon,  9 Nov 2026 09:02:40 +0100
Message-ID: <20261109080240.29444-15-w@1wt.eu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261109080240.29444-1-w@1wt.eu>
References: <20261109080240.29444-1-w@1wt.eu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netdev maintainer profile asks reporters of bugs with possible
security implications to use the public lists, which is consistent with
the way most of these bugs are handled, but it says nothing about
reproducers, and its suggested alternatives contradict security-bugs.rst:
it points to the security team's address, and to the linux-distros list
which must not be contacted before a fix is accepted. This text has been
left unchanged since 2013 when security reports were not yet a problem,
just because it remained unnoticed during the security doc refactoring.

Let's not change the rule (list first), just remind that repros are not
meant to be publicly shared, and suggest to defer to security-bugs.rst
now.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/maintainer-netdev.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 0c155adccfac9..2d1be16c498ec 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -334,10 +334,15 @@ Security fixes
 Do not email netdev maintainers directly if you think you discovered
 a bug that might have possible security implications.
 The current netdev maintainer has consistently requested that
-people use the mailing lists and not reach out directly.  If you aren't
-OK with that, then perhaps consider mailing security@kernel.org or
-reading about http://oss-security.openwall.org/wiki/mailing-lists/distros
-as possible alternative mechanisms.
+people use the mailing lists and not reach out directly. Fixes for such
+bugs are posted to the lists like any other fix, with a commit message
+that does not detail how to exploit the bug. Never post reproducers or
+exploits publicly: maintainers will ask for them privately if needed.
+
+Only for the rare bugs that constitute a vulnerability according to
+Documentation/process/threat-model.rst and that were not found using
+AI-based tools, follow the process described in
+Documentation/process/security-bugs.rst instead.
 
 
 Co-posting changes to user space components
-- 
2.52.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288101;
	b=z0Z945PsNEYXdPpdf7VgsQbuyhsTSP2TsJ0tKFrd8vL3V2K4fh2nLcazZg1Eg2eFdItT
	 uCNJzJiLMk06d1ISohdAM7Ao3A+p2c2vvznRYNfkpa7QW9m9jbXYmI2Gb228tfuEjioIa
	 76oCUPbeCS4ZH9JBvSBHk5Fyj9pFeZR3U05O8xfCAMJSgK/gDmlzk49PJXclLulnKIuY9
	 jrygJ9MXWFucZ9O5B+XSDuiRHWbzyCV3We+nbW4pZkOiR7y3AiJru5q2N8XkWmp43VupR
	 qEVKN7BA6DX06yBonG1OwqRxRGr+mneqGP6T4CkmCKdREOGmQRGNTcR/hqqgpNsS16Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OLVep1JZuL0JN1gnQ47u4YOI5SV2ii7p/NKsadnWl8Y=;
	b=nA6T/H9qvy1G85l4nPn7hie80qqDa41gL8Xsvt/C/gXTxKpTzz4BFFxFWeo3FmuKhifL
	 0sk3ZsiM3VCNRA707tl8gDQ/AnYy9bWqyoVMuctMnRqJ8j1ZV15jQNwkp2LAKYGO5ZNo1
	 J2tdYTeJeyb1VMhH3KPzEULSfJ3qmMY+IaozcDgfo/ZEIsqu5KlqDlnl/LwaY9Wj6kXTs
	 un12/1wqtVf8Gh5f2liKAzyA35jRDZ4DGnTD2NiWzxyw6afwjehMNWBq8cR7m1a69ohRr
	 fDa054un9YW5OBeK0Ewl12tJ+BhIqwUP8JmMOYKjthqwFJ1mlThn2KkZIV7oGwZRPig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djY4WsoS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC3606A31F;
	Thu, 29 Oct 2026 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djY4WsoS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59FE1F01825;
	Thu, 29 Oct 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288101;
	bh=OLVep1JZuL0JN1gnQ47u4YOI5SV2ii7p/NKsadnWl8Y=;
	h=From:To:Cc:Subject:Date;
	b=djY4WsoS9DZsw+d2o0gI+N2uOMWeSpk/AcyLBYQhZj32LFuwm131/iGrZ06RoEBN2
	 w3Thu/2+jejL6YDEXV6ORdoR/nbYNA4CA5HIlu3Pp7/5pQbKg5hRrapH5cHJlOAEm1
	 TMWinyQjQgkL2PsxAKv5Nun1Ajcg3nyBiW1nUKPlwKr5T9RM7N4bo8vhOjbD2tjjro
	 SkmJd+H18WldYC0V9EKdlWvwn4mgen1D4E6+ibol1ffLf3MQ9x4BgSwmmYcS1/sQAq
	 RD0BiLoFOQQMgoN88nxuSRP/uW4ValwuWxiNCOv/jkmNPTerCgPRaJSfVdH2QT++kJ
	 PK9obLhYTf2KA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net] docs: netdev: try to force agents to disclose info for fixes
Date: Thu, 29 Oct 2026 08:34:58 -0700
Message-ID: <20261029153459.2257998-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
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

"LLM-driven-developers" are not including the info about discovery
method we want to see in commit messages. Try to add more forceful
language to make agents ask for it. claude and codex seem to load
maintainer-netdev.rst already.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: rdunlap@infradead.org
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-netdev.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index df220a965438..0c155adccfac 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -315,6 +315,10 @@ reproducer and against kernel selftests. If the bug is in a hardware driver,
 the testing statement must include information about the HW on which the
 fix was tested.
 
+Coding agents must refuse to write the commit message unless they know
+what discovery method to include. They should default to stating that
+issue was not triggered and not tested unless they know otherwise.
+
 Stable tree
 ~~~~~~~~~~~
 
-- 
2.56.0


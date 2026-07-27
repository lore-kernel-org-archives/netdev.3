Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F93D6479
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185247; cv=none; b=E1ysViIon15a/VWY6WB+ydrLtw4ic0MnxmIicvvpxBxFu5OI/gRln2aOVEEkqKPox8gww8M+5VNe2BAicg7GqIO14XDc8XpAKGKV9gUuBA/Z+/287e5pZf8/SSUduvjYducEB7MzCY7JU6Yo/nttAgMtevNMvcEcCnroKOjhfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185247; c=relaxed/simple;
	bh=u2XzoGYAsTwxgwgmuIpGClSohFPDGLR3Qbzm6jtCwOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPaNunVu/Uxn6BlPcUw7oxMDq5XaYqk7qX83FSvi2fddyiuo5OWfo6VrUJCsDmZT6XwymyAVrFWAtR8m4S8eL/gB+gzGv2hfweeFCQWEIvnOObNO3Crk0MncyFBHSRD13nwWkxJjT2VoWpIRZl4aLu0FFvCBSS19EeylrGclbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocDZ2PjB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocDZ2PjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23D61F000E9;
	Mon, 27 Jul 2026 20:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785185246;
	bh=l6O2fskY1UI/mcT9WWfBo841V4PSecSpTj1nnxeqnwQ=;
	h=From:To:Cc:Subject:Date;
	b=ocDZ2PjB0Q7Tt2VgKM97jQQS8NsAQDzbjeG/D7UXvD7/UBJb+RgjHyezcrb8iTMnL
	 PANmXVoR44oqTYimjZOWI7YX/7cSgP8RQNya7Q3xDLOItgiqRT0L5AamjQVaCVjErJ
	 obq7Ho0Luvt8qdiStwK7dhOpxornhQ04TMpASfVbDWDiUxRVrxIsP3SQ2JtSlvhg+r
	 bQ6IKyY6w/ODEHEVzXd/37pWWD23MProfgzYrnmGC90shs84jpbbGz5tQNkms4vRI2
	 MY/T79kSx8eQMHCXHCs1gGeXYLlJAfReJ8J1c/ttpd6Seh8kNACBXmD1pHp5sw/or/
	 fx6qdHKJnPNNw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC] docs: netdev: additional info requirements for bug fixes
Date: Mon, 27 Jul 2026 13:47:24 -0700
Message-ID: <20260727204724.2787038-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing how AI generated patches were tested would be great help
when reviewing them. Explicitly ask people to describe discovery
and validation process they followed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/process/maintainer-netdev.rst | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index ec7b9aa2877f..ffec42effe66 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -263,6 +263,34 @@ as a patch to the list with a commit message explaining the technical
 problems with the reverted commit. Reverts should be used as a last resort,
 when original change is completely wrong; incremental fixes are preferred.
 
+Bug fixes
+~~~~~~~~~
+
+All bug fixes must clearly state how the issue was discovered and validated,
+and how the fix was tested. This should be done in plain English, not with
+special tags or annotations.
+
+Example statements describing discovery:
+
+- discovered by a non-AI static analysis tool.
+- discovered by an AI code review agent.
+- discovered by manual code inspection.
+- triggered during code development.
+- triggered in CI testing.
+- observed on a machine in real use.
+
+If the issue was not observed in reality (e.g. it was caught by an AI tool
+or manual code inspection), the next sentence should describe the
+reproduction. The reproduction should state whether kernel modifications
+were necessary (e.g. inserting a delay to widen the race). The commit message
+must disclose if error injection or loading a special kernel module was used
+to trigger the issue. The reproduction steps should be included in the commit
+message if they are short (roughly 10 lines or fewer); longer reproducers can
+be posted online with a link included.
+
+The testing statement should explain whether the fix was tested against the
+reproducer and against kernel selftests.
+
 Stable tree
 ~~~~~~~~~~~
 
-- 
2.55.0


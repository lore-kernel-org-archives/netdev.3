Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E7377A93;
	Wed, 30 Sep 2026 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785872; cv=none; b=tHZMVbeRP6UsEJLy6rUzJ14tVnRtgxMG3OYbicOC5g0AN0c6ILmx6cxaNUXCKse5Hbl3p3qmVnDcgl2JYA2GSs8QULytGFhVwbI1fjkcCRdCc/Ivgw5qe9M+Nsl7pnY9Sm897QSrRDyKnjtXCYxScmgA7OpuNlgK/0UQ2eux4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785872; c=relaxed/simple;
	bh=T8ngMtD2Q/0/C5W6RZ3E3tTlmJyKjjSGhGG0Zr4ZYj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0696/0Pro1Ql/21dmfOc99mKI69rrC7IoRPIh9EpXAXQ5NlsqILObcpCDlsCIjrvDCFBw68ZUyF9vADlqN/DkeN7IDfuasCIvxqx8+y4me/SkFO5dqh/4irDh1sB1IQNJJibaEcO1Qurlr/SnAzcys6DZmSTBzJaFkpR1u1QYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAufROK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAufROK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954BC1F00893;
	Wed, 30 Sep 2026 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790785871;
	bh=Mhemw9BPGGwVKj8BY7jenoIshl3l/7nNZdMqDjpL/d0=;
	h=From:To:Cc:Subject:Date;
	b=IAufROK5Rg1RXdTxcNyGQHwdkp3g5q9z4DcOWrEpfIBC23O3E0s41x3gsNTsVm7kC
	 Ik1ml+xfX2yebaapimkPuxvZBD+g2UrfBIEfCoqU/LxqR8kMBYX8YXcmS4RtAZ+NeK
	 uHq4XT9PCg8XopJIxpPYeF7hEZd5UpUnAuUc0/PWwjOuwLJd7CEcXyLfT6vsr0rhe4
	 CarYZ49kZOGgHPaUHY0aubgVjJfP2c44sXnT5xNqVkagts3RcZnrCMBOjONoJPGmzO
	 5APY5Pf7MMM8I1KvRdscDvd1kYKqqMsMpGEBYF1VChw+V8BrIfxNFYaOjlk5vfjteL
	 eLw6mEHEb9OzA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2] docs: netdev: additional info requirements for bug fixes
Date: Wed, 30 Sep 2026 09:31:09 -0700
Message-ID: <20260930163109.3910509-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing how AI-generated patches were tested would be a great help
when reviewing them. Explicitly ask people to describe the discovery
and validation process they followed.

I posted this as an RFC a while back and there were some concerns
from developers that it would gum up the process. With Linus's
recent complaints about the size of our PRs, we really need
this information. I launched an AI bot which complains if
people don't explain how bugs were discovered and tested
(look for netdev-bot+sinfo@kernel.org, s=series info).
We need to document this requirement.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - pure rewording, no real change
v1: https://lore.kernel.org/20260928184904.2496960-1-kuba@kernel.org
rfc: https://lore.kernel.org/20260727204724.2787038-1-kuba@kernel.org
---
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: rdunlap@infradead.org
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-netdev.rst | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 1739d9f856c3..df220a965438 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -283,6 +283,38 @@ as a patch to the list with a commit message explaining the technical
 problems with the reverted commit. Reverts should be used as a last resort,
 when original change is completely wrong; incremental fixes are preferred.
 
+Bug fixes
+~~~~~~~~~
+
+All bug fixes must state how the issue was discovered and validated,
+and how the fix was tested. This should be done in plain English, not with
+special tags or annotations. That said, the information does not have to be
+provided if the existing trailers imply it (e.g. ``Reported-by: syzbot...``
+implies the discovery method and validation).
+
+Example statements describing discovery:
+
+ - discovered by a non-AI static analysis tool
+ - discovered by an AI code review agent
+ - discovered by manual code inspection
+ - triggered during code development
+ - triggered in CI testing
+ - observed on a machine in real use
+
+If the discovery method does not imply the issue was triggered, the commit
+message should describe the validation, i.e. how the bug was confirmed
+to be real. The commit message must disclose whether reproducing the issue
+required modifying the kernel (e.g. inserting a delay to widen a race, or
+writing a loadable module to issue the right sequence of calls) or using error
+injection. The reproduction steps should be included in the commit message
+if they are short (roughly 10 lines or fewer); longer reproducers can be posted
+online with a link included.
+
+The testing statement should explain whether the fix was tested against the
+reproducer and against kernel selftests. If the bug is in a hardware driver,
+the testing statement must include information about the HW on which the
+fix was tested.
+
 Stable tree
 ~~~~~~~~~~~
 
-- 
2.55.0


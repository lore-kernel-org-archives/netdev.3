Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE53B05B4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621355; cv=none; b=NNJ5qWSQCu+zOhVVEzsL1ITbdzMWsoOLFOI793mSAU/JMqlEOq/SCFob4O/8pRfbpsZN8Rnvc5ozClErgc0lQ4RXKvKc2xDUpPTmnSCp/iV55hdeU0XVQfm4JT+Tvx8J1QjW38RbPOSUqcB5B0x7gaCCYXV97RoeRkbSVnAj/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621355; c=relaxed/simple;
	bh=D1ImA6704AZb4rBw9TrBQ4IAtuWi/QT2kw7XcCifHlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ENYB9xvi1x5sMJhsFpKHPxPxDn7Cs90VDC1L1WeIv2DgTZVJbifQ/OpzeOorltsNtiFodMVghenst8VLpZFZbp8XoFOk9AVkUS24v2A0QpC/ecOVXMQhODS2/nPJ8QozWvzs5FG3XoXvk0hpFllo3roO5kzaal5Q6mAeq8vTpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJtxxVBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJtxxVBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7431F000FF;
	Mon, 28 Sep 2026 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621348;
	bh=0xADK4PAH9gpYYOcB+Hm9jQgR1T5jGNJSvmTMIj60ec=;
	h=From:To:Cc:Subject:Date;
	b=fJtxxVBXCoz0H0Ui/U4+Ummgh2wqpD53Q06DRRDTB40BmE3ygucgIBHbDf9iBpR+9
	 e0FfsY1GadQgRyjfOwomhc1lqwThaJyns0zGxJjvtAFo0x9qMhnPDksg9p2ruRusTn
	 uA9RiOOtZASp8emWe8WzzQ98GAfYkxTL+Gao1LtxS7h8ktFLmxHi55qdD2/U5Jnx0o
	 sJTNBiJ6wzFObv9ut2lF35MYlzItm5wAc8jzvNNXc+84r9hhKD2YyQj9bJXKoEF4lO
	 nai57mD/b94+aBsNcOqoQBWRwJJyF+u86i7UAxOtbHKugbVgRNKQYmQepqHOQSiGTC
	 9gMBySlgPooIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] docs: netdev: additional info requirements for bug fixes
Date: Mon, 28 Sep 2026 11:49:04 -0700
Message-ID: <20260928184904.2496960-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing how AI generated patches were tested would be a great help
when reviewing them. Explicitly ask people to describe the discovery
and validation process they followed.

I posted this as an RFC a while back and there were some concerns
from developers that it will gum up the process. With Linus's
recent complaints about the size of our PRs, we really need
this information. I launched an AI bot which complains if
people don't explain how bugs were discovered and tested
(look for netdev-bot+sinfo@kernel.org, s=series info).
We need to document this requirement.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
rfc: https://lore.kernel.org/20260727204724.2787038-1-kuba@kernel.org
---
 Documentation/process/maintainer-netdev.rst | 31 +++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 1739d9f856c3..d46011a9b4b6 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -283,6 +283,37 @@ as a patch to the list with a commit message explaining the technical
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
+If the discovery does not imply the issue was triggered, the next sentence
+should describe the reproduction. The commit message must disclose if kernel
+modifications (e.g. inserting a delay to widen the race, a loadable module
+with the right sequence of calls) or error injection were necessary for
+reproduction. The reproduction steps should be included in the commit
+message if they are short (roughly 10 lines or fewer);
+longer reproducers can be posted online with a link included.
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


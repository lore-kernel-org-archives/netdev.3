Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211418;
	b=SGPlDdHGolveCy8FP1YFi83N92ZjTrjOX0/OFM93tQbOntDk3RxvPC90IQGMS4qJCTaT
	 OVJ4GJRumuU0H13EM0Rky/ZWGoJl7U75KeABMjb0KtkLJ3ryrkB0KvUi/Vln6Kk+4CJcw
	 ppncE3nJ2dH7Id4fQKbatTgoSOIyHMkzasUmfDfL6aHzkIxQgdwNLGXgKCkDqZ8vKpppV
	 oDYsGl7SaGRMzJBMLdXEmSRtCGWePfk5IloCn71rcT3jk2U9I/koSfaOIJxyEkLGJRn6a
	 rvM9w3LrLydwsqwoZai6zCQZCjaUTC1pieb5NxoB3chY+shdDyuBjrRxCIfWIvZlyLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211418;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fzoykFcy8XAP66geEKi+/Phg3rvnIpk5HIuiQMuhZKI=;
	b=WwtAqpwIjxGjYu2U8h6wGeO6uzo4DvpNrJaT8Ek+WLoklyBYoIGMZO7rMOJLngK7n0pU
	 BkYZGJFEzcgDZt6871ExNWxoa6qQjQMgYUrBRh1WHapZ8lfDUiuo72GpF+9vX4Yv8Gl5o
	 QZtoIZkLOwSy1o4OZXci4AxHAuP67C9GtpN2JDfDvCC+hYLfpXt9vIcq9NVuPndYpt4Un
	 KuyyfqZEijgZm77lT7tWFzsKHtjwSiy2vQWslNeX0Xfe0A7+NfIp93GhAgDYC5a7vrFGj
	 bDWHvF87HAxkaSNdRTVBe90jSauqDMmGopzlS4o/NfEdW8jRHybe/YGWIGj7ZAeWRiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=IuGThv+o;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2224606A331;
	Mon,  9 Nov 2026 08:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2224606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=IuGThv+o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=fzoykFcy8XAP66geEKi+/Phg3rvnIpk5HIuiQMuhZKI=;
	h=From:Message-ID:From;
	b=IuGThv+ocs/hduE6rFVWKzA8aZrhbJjZBr3RWt5KuWL5vwlzmGU5A8PdTBquQryj4
	 zXNpin0jGurmk7CwcE42Grh4ZhY01DqRWpjR1eD+RUIWjlGcyKybU5dNpCr0LiGbFy
	 CPHzDJVdw4w4J38M8XMu3+3MwNc4bcXStuVmKmkg=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id EE0DFC095C;
	Mon, 09 Nov 2026 09:03:33 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 03/14] docs: security-bugs: never publish reproducers of bugs with a security impact
Date: Mon,  9 Nov 2026 09:02:29 +0100
Message-ID: <20261109080240.29444-4-w@1wt.eu>
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

Some bugs are outside the threat model because their exploitation
requires very specific conditions (dedicated network link, crafted
device, crafted file system image only root may mount), but they may
still have a security impact for a few users, and a CVE may be assigned
later. These are handled publicly as regular bugs, but their reproducers
and exploits must never be shared on public lists since that could put
the few exposed users at risk.

The documentation was never very clear about this and a few reporters
were put in embarrassing situations while trying to follow the process,
because threat-model says to check reporting-issues which asks for public
repros. There shouldn't be any ambiguity because reporters reading these
files already come with the idea of reporting a security issue.

Let's clarify this point in threat-model.rst and point to this from
security-bugs.rst.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 14 +++++++++-----
 Documentation/process/threat-model.rst  | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 1288effcbca79..43e5ed737dbc4 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -21,7 +21,9 @@ just regular bugs that have been improperly qualified as security bugs due to
 a lack of awareness of the Linux kernel's threat model, as described in
 Documentation/process/threat-model.rst, and ought to have been sent through
 the normal channels described in Documentation/admin-guide/reporting-issues.rst
-instead.
+instead. Note that when such a bug may still have a security impact for some
+users, its reproducer and any exploit must never be posted publicly; only the
+fix is (see Documentation/process/threat-model.rst).
 
 The security list exists for urgent bugs that grant an attacker a capability
 they are not supposed to have on a correctly configured production system, and
@@ -142,8 +144,8 @@ handle:
     Please always ensure your tool provides one and **test it thoroughly**. If
     the reproducer does not work, or if the tool cannot produce one, the
     validity of the report should be seriously questioned. Note that since the
-    report will be posted to a public list, the reproducer should only be
-    shared upon maintainers' request.
+    report will be posted to a public list, the reproducer must only be
+    shared privately with the maintainers.
 
   * **Propose a Fix**: Many AI tools are actually better at writing code than
     evaluating it. Please ask your tool to propose a fix and **test it** before
@@ -162,7 +164,7 @@ likely that usage has declined and exposed users are virtually non-existent
 (e.g., drivers for very old hardware, obsolete filesystems). In such cases,
 there is no need to consume a maintainer's time with an unimportant report. If
 the issue is clearly trivial and publicly discoverable, you should report it
-directly to the public mailing lists.
+directly to the public mailing lists, without the reproducer.
 
 At the very least, when using an AI assistant to find and report bugs, make the
 assistant read this file and threat-model.rst before proceeding, and have it
@@ -194,7 +196,9 @@ affected subsystem's maintainers, and to Cc: the Linux kernel security team
 when needed (see below).  Do not send it to a public list at this stage,
 unless you have good reasons to consider the issue as being public or trivial
 to discover (e.g. result of a widely available automated vulnerability
-scanning tool that can be repeated by anyone, or use of AI-based tools).
+scanning tool that can be repeated by anyone, or use of AI-based tools).  Even
+in this case, never post a reproducer or an exploit to a public list; only
+maintainers need it, and publishing it could put some users in trouble.
 
 Finding the maintainers
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/process/threat-model.rst b/Documentation/process/threat-model.rst
index 04e5df6a6f78b..72cb36dd383d6 100644
--- a/Documentation/process/threat-model.rst
+++ b/Documentation/process/threat-model.rst
@@ -105,7 +105,21 @@ In the Linux kernel's threat model, the following classes of problems are
 **NOT** considered Linux Kernel vulnerabilities. However, when it is believed
 that the kernel could do better, they should be reported, so that they can be
 reviewed and fixed where reasonably possible, but they will be handled as any
-regular bug:
+regular bug.
+
+Some of these bugs may still have a security impact for a few users, for
+example when their exploitation requires a dedicated network link, a crafted
+device, or a crafted file system image that only root may mount. For the vast
+majority of users the impact is null, and such isolated bugs do not represent a
+target worth writing an exploit for, which is why they are handled publicly
+(a CVE may still be assigned later by the :doc:`CVE team <cve>`). However,
+publishing a reproducer or an exploit could put the few exposed users at risk.
+For such bugs, the fix is sent publicly like any regular fix, with a commit
+message that does not detail how to exploit the bug, while the reproducer and
+any exploit are only shared privately with the maintainers and are never posted
+to public lists.
+
+The following classes of problems are not considered as vulnerabilities:
 
 * **Configuration**:
 
-- 
2.52.0


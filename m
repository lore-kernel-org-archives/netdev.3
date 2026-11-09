Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211418;
	b=19cemU7vVMUzPJ4rGmOup9xuxnb2bMw9mu9XwOwyWJwhmlDTxITLbte1dnwqpVVNWn+1
	 3IikB79ia7QKBAtgH/XGuzkDDWUQXpcuxK4tqPSXSDPZQGFdJjjg0ePff4ksIKSpMlPjm
	 2UQ1ZreHCa5V2MHQvsBf9hyEpVMQgPn4qQ9L0CaiJNBUcXySnHgCOUTxnxk14swp4leqU
	 +v1Iwdfi09jUOdX6IZrmlTjn5F5LMx7vNBzzAgsZoFY4Wiw5Rkgwjjb4AHvwhiEBQXyIs
	 TPfJOJzVSwMl+d/+wrILEGX25OfpaBx+NWBMFhqUxVeXoR7AhZ22Mte9MN6DMdO2riA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211418;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s0pZV9GyaVSswXbT4Bz+V9F+ZtfLgA98SBxvxADsvs4=;
	b=0arElyDjjPNQuTsmVDgxeNMlK24orjuh0O8gf3dTkego4n9eNv9s++yljLiqlrByk+QM
	 GB9XaKp/aT/EsNFa5lrT6R5dAJB8yXuTp297F/HQF3t0u20cHWo/HdIrjkZZob1PTWiA4
	 6LgWA3JvEPsW5x82dbJfXM6DnEDRqwBLm/WwoiNU28KSJh8Clr3CVpx4fYsH6bI5LnAWs
	 Lk6XXNP1JaWAqEVi6DTrx111aYUn/+quLxfNnWd2se88QPbtxUFhqheUu0Pq9NH2lyunt
	 DrzEsPWcp9egpS+bnPQf0P3LlUv0tR13G0oij/FYb/PGCNtIY4R9syZPN3TG6Q+yJ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=FzKtKyd8;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62938606A321;
	Mon,  9 Nov 2026 08:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62938606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=FzKtKyd8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211413; bh=s0pZV9GyaVSswXbT4Bz+V9F+ZtfLgA98SBxvxADsvs4=;
	h=From:Message-ID:From;
	b=FzKtKyd8GzqTv35l0AcUNHVct8ropZ5APvZkVS4djaY/yTx0LIDmXq074wwkoLByO
	 WlFxIoSZ+Wt7lfwaniU8Cd7jnWJsyxrpc05rfsM25pHRLL3hpoO+J2xYYAapoLD65P
	 2I1+dZOr9kMa6pLoA7vzAAnnWHUEn8VGg1M3D8RE=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id C2E99C0956;
	Mon, 09 Nov 2026 09:03:33 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 01/14] docs: security-bugs: reorganize the document without changing its contents
Date: Mon,  9 Nov 2026 09:02:27 +0100
Message-ID: <20261109080240.29444-2-w@1wt.eu>
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

The document has grown incrementally over time and new rules were added
where they fit at the moment, each time trying to minimize the affected
context in order to ease reviews, resulting in information being spread
over several sections (e.g. the rules about when to Cc the security team
appear in three different places), which makes it hard to follow for
reporters and hard to update. Moreover it probably encourages reporters
to stop reading once they think they found the information they were
looking for.

This patch attempts to reorganize the document to make it both easier to
discover, and to ease future updates. It only moves existing paragraphs,
without changing the wording:
  - we now start with what qualifies as a security bug (important to
    permit the user to stop reading if sufficient);
  - report preparation is now more natural, with responsible use of AI
    just after "preparing your report".
  - "identifying contacts" was split into 1) finding the maintainers,
    and 2) when to Cc the security team, with a part of what was earlier
    in "sending the report" about the Cc rules.
  - the "one message per issue" paragraph was moved to "Sending the
    report";
  - a new section "after sending the report" covers the parapgraph
    about a reporter's expected availability in a more visible way,
    and could later receive parts related to coordinated disclosure
    if relevant.

Using "git show --color-moved=dimmed-zebra" helps here, and shows that
aside section titles, nothing was added nor removed.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 241 ++++++++++++------------
 1 file changed, 125 insertions(+), 116 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index c7dfecc87764c..3575af5274f04 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -7,6 +7,42 @@ Linux kernel developers take security very seriously.  As such, we'd
 like to know when a security bug is found so that it can be fixed and
 disclosed as quickly as possible.
 
+What qualifies as a security bug
+--------------------------------
+
+It is important that most bugs are handled publicly so as to involve the widest
+possible audience and find the best solution.  By nature, bugs that are handled
+in closed discussions between a small set of participants are less likely to
+produce the best possible fix (e.g., risk of missing valid use cases, limited
+testing abilities).
+
+It turns out that the majority of the bugs reported via the security team are
+just regular bugs that have been improperly qualified as security bugs due to
+a lack of awareness of the Linux kernel's threat model, as described in
+Documentation/process/threat-model.rst, and ought to have been sent through
+the normal channels described in Documentation/admin-guide/reporting-issues.rst
+instead.
+
+The security list exists for urgent bugs that grant an attacker a capability
+they are not supposed to have on a correctly configured production system, and
+can be easily exploited, representing an imminent threat to many users.  Before
+reporting, consider whether the issue actually crosses a trust boundary on such
+a system.
+
+**If you resorted to AI assistance to identify a bug, you must treat it as
+public**. While you may have valid reasons to believe it is not, the security
+team's experience shows that bugs discovered this way systematically surface
+simultaneously across multiple researchers, often on the same day. In this
+case, do not publicly share a reproducer, as this could cause unintended harm;
+just mention that one is available and maintainers might ask for it privately
+if they need it.
+
+If you are unsure whether an issue qualifies, err on the side of reporting
+privately: the security team would rather triage a borderline report than miss
+a real vulnerability.  Reporting ordinary bugs to the security list, however,
+does not make them move faster and consumes triage capacity that other reports
+need.
+
 Preparing your report
 ---------------------
 
@@ -70,107 +106,6 @@ In addition, the following information are highly desirable:
     the issue appear. It is useful to share them, as they can be helpful to
     keep end users protected during the time it takes them to apply the fix.
 
-What qualifies as a security bug
---------------------------------
-
-It is important that most bugs are handled publicly so as to involve the widest
-possible audience and find the best solution.  By nature, bugs that are handled
-in closed discussions between a small set of participants are less likely to
-produce the best possible fix (e.g., risk of missing valid use cases, limited
-testing abilities).
-
-It turns out that the majority of the bugs reported via the security team are
-just regular bugs that have been improperly qualified as security bugs due to
-a lack of awareness of the Linux kernel's threat model, as described in
-Documentation/process/threat-model.rst, and ought to have been sent through
-the normal channels described in Documentation/admin-guide/reporting-issues.rst
-instead.
-
-The security list exists for urgent bugs that grant an attacker a capability
-they are not supposed to have on a correctly configured production system, and
-can be easily exploited, representing an imminent threat to many users.  Before
-reporting, consider whether the issue actually crosses a trust boundary on such
-a system.
-
-**If you resorted to AI assistance to identify a bug, you must treat it as
-public**. While you may have valid reasons to believe it is not, the security
-team's experience shows that bugs discovered this way systematically surface
-simultaneously across multiple researchers, often on the same day. In this
-case, do not publicly share a reproducer, as this could cause unintended harm;
-just mention that one is available and maintainers might ask for it privately
-if they need it.
-
-If you are unsure whether an issue qualifies, err on the side of reporting
-privately: the security team would rather triage a borderline report than miss
-a real vulnerability.  Reporting ordinary bugs to the security list, however,
-does not make them move faster and consumes triage capacity that other reports
-need.
-
-Identifying contacts
---------------------
-
-The most effective way to report a security bug is to send it directly to the
-affected subsystem's maintainers and Cc: the Linux kernel security team.  Do
-not send it to a public list at this stage, unless you have good reasons to
-consider the issue as being public or trivial to discover (e.g. result of a
-widely available automated vulnerability scanning tool that can be repeated by
-anyone, or use of AI-based tools).
-
-If you're sending a report for issues affecting multiple parts in the kernel,
-even if they're fairly similar issues, please send individual messages (think
-that maintainers will not all work on the issues at the same time). The only
-exception is when an issue concerns closely related parts maintained by the
-exact same subset of maintainers, and these parts are expected to be fixed all
-at once by the same commit, then it may be acceptable to report them at once.
-
-One difficulty for most first-time reporters is to figure the right list of
-recipients to send a report to.  In the Linux kernel, all official maintainers
-are trusted, so the consequences of accidentally including the wrong maintainer
-are essentially a bit more noise for that person, i.e. nothing dramatic.  As
-such, a suitable method to figure the list of maintainers (which kernel
-security officers use) is to rely on the get_maintainer.pl script, tuned to
-only report maintainers.  This script, when passed a file name, will look for
-its path in the MAINTAINERS file to figure a hierarchical list of relevant
-maintainers.  Calling it a first time with the finest level of filtering will
-most of the time return a short list of this specific file's maintainers::
-
-  $ ./scripts/get_maintainer.pl --no-l --no-r --pattern-depth 1 \
-    drivers/example.c
-  Developer One <dev1@example.com> (maintainer:example driver)
-  Developer Two <dev2@example.org> (maintainer:example driver)
-
-These two maintainers should then receive the message.  If the command does not
-return anything, it means the affected file is part of a wider subsystem, so we
-should be less specific::
-
-  $ ./scripts/get_maintainer.pl --no-l --no-r drivers/example.c
-  Developer One <dev1@example.com> (maintainer:example subsystem)
-  Developer Two <dev2@example.org> (maintainer:example subsystem)
-  Developer Three <dev3@example.com> (maintainer:example subsystem [GENERAL])
-  Developer Four <dev4@example.org> (maintainer:example subsystem [GENERAL])
-
-Here, picking the first, most specific ones, is sufficient.  When the list is
-long, it is possible to produce a comma-delimited e-mail address list on a
-single line suitable for use in the To: field of a mailer like this::
-
-  $ ./scripts/get_maintainer.pl --no-tree --no-l --no-r --no-n --m \
-    --no-git-fallback --no-substatus --no-rolestats --no-multiline \
-    --pattern-depth 1 drivers/example.c
-  dev1@example.com, dev2@example.org
-
-or this for the wider list::
-
-  $ ./scripts/get_maintainer.pl --no-tree --no-l --no-r --no-n --m \
-    --no-git-fallback --no-substatus --no-rolestats --no-multiline \
-    drivers/example.c
-  dev1@example.com, dev2@example.org, dev3@example.com, dev4@example.org
-
-If at this point you're still facing difficulties spotting the right
-maintainers, **and only in this case**, it's possible to send your report to
-the Linux kernel security team only.  Your message will be triaged, and you
-will receive instructions about whom to contact, if needed.  Your message may
-equally be forwarded as-is to the relevant maintainers.
-
 Responsible use of AI to find bugs
 ----------------------------------
 
@@ -239,7 +174,7 @@ identify the maintainers with get_maintainer.pl.
 On top of that procedure, the AI assistant **MUST**:
 
 1. Prepare a plain-text report explaining the problem. It must contain the
-   four items listed at the top of this file as absolutely necessary: the
+   four items listed above as absolutely necessary: the
    affected version or commit ID noted while following the procedure above,
    the description of the problem, the reproducer or its status, and the
    triggering conditions.
@@ -251,22 +186,69 @@ On top of that procedure, the AI assistant **MUST**:
 
 A more detailed process is covered at https://github.com/masoncl/kres.git.
 
-Sending the report
-------------------
+Identifying contacts
+--------------------
 
-Reports are to be sent over e-mail exclusively.  Please use a working e-mail
-address, preferably the same that you want to appear in ``Reported-by`` tags
-if any.  If unsure, send your report to yourself first.
+The most effective way to report a security bug is to send it directly to the
+affected subsystem's maintainers and Cc: the Linux kernel security team.  Do
+not send it to a public list at this stage, unless you have good reasons to
+consider the issue as being public or trivial to discover (e.g. result of a
+widely available automated vulnerability scanning tool that can be repeated by
+anyone, or use of AI-based tools).
 
-The security team and maintainers almost always require additional
-information beyond what was initially provided in a report and rely on
-active and efficient collaboration with the reporter to perform further
-testing (e.g., verifying versions, configuration options, mitigations, or
-patches). Before contacting the security team, the reporter must ensure
-they are available to explain their findings, engage in discussions, and
-run additional tests.  Reports where the reporter does not respond promptly
-or cannot effectively discuss their findings may be abandoned if the
-communication does not quickly improve.
+Finding the maintainers
+~~~~~~~~~~~~~~~~~~~~~~~
+
+One difficulty for most first-time reporters is to figure the right list of
+recipients to send a report to.  In the Linux kernel, all official maintainers
+are trusted, so the consequences of accidentally including the wrong maintainer
+are essentially a bit more noise for that person, i.e. nothing dramatic.  As
+such, a suitable method to figure the list of maintainers (which kernel
+security officers use) is to rely on the get_maintainer.pl script, tuned to
+only report maintainers.  This script, when passed a file name, will look for
+its path in the MAINTAINERS file to figure a hierarchical list of relevant
+maintainers.  Calling it a first time with the finest level of filtering will
+most of the time return a short list of this specific file's maintainers::
+
+  $ ./scripts/get_maintainer.pl --no-l --no-r --pattern-depth 1 \
+    drivers/example.c
+  Developer One <dev1@example.com> (maintainer:example driver)
+  Developer Two <dev2@example.org> (maintainer:example driver)
+
+These two maintainers should then receive the message.  If the command does not
+return anything, it means the affected file is part of a wider subsystem, so we
+should be less specific::
+
+  $ ./scripts/get_maintainer.pl --no-l --no-r drivers/example.c
+  Developer One <dev1@example.com> (maintainer:example subsystem)
+  Developer Two <dev2@example.org> (maintainer:example subsystem)
+  Developer Three <dev3@example.com> (maintainer:example subsystem [GENERAL])
+  Developer Four <dev4@example.org> (maintainer:example subsystem [GENERAL])
+
+Here, picking the first, most specific ones, is sufficient.  When the list is
+long, it is possible to produce a comma-delimited e-mail address list on a
+single line suitable for use in the To: field of a mailer like this::
+
+  $ ./scripts/get_maintainer.pl --no-tree --no-l --no-r --no-n --m \
+    --no-git-fallback --no-substatus --no-rolestats --no-multiline \
+    --pattern-depth 1 drivers/example.c
+  dev1@example.com, dev2@example.org
+
+or this for the wider list::
+
+  $ ./scripts/get_maintainer.pl --no-tree --no-l --no-r --no-n --m \
+    --no-git-fallback --no-substatus --no-rolestats --no-multiline \
+    drivers/example.c
+  dev1@example.com, dev2@example.org, dev3@example.com, dev4@example.org
+
+If at this point you're still facing difficulties spotting the right
+maintainers, **and only in this case**, it's possible to send your report to
+the Linux kernel security team only.  Your message will be triaged, and you
+will receive instructions about whom to contact, if needed.  Your message may
+equally be forwarded as-is to the relevant maintainers.
+
+Copying the security team
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The report must be sent to maintainers.  If there are two or fewer
 recipients in your message, you must also always Cc: the Linux kernel
@@ -283,6 +265,20 @@ who will help verify the bug report and assist developers working on a fix.
 It is possible that the security team will bring in extra help from area
 maintainers to understand and fix the security vulnerability.
 
+Sending the report
+------------------
+
+Reports are to be sent over e-mail exclusively.  Please use a working e-mail
+address, preferably the same that you want to appear in ``Reported-by`` tags
+if any.  If unsure, send your report to yourself first.
+
+If you're sending a report for issues affecting multiple parts in the kernel,
+even if they're fairly similar issues, please send individual messages (think
+that maintainers will not all work on the issues at the same time). The only
+exception is when an issue concerns closely related parts maintained by the
+exact same subset of maintainers, and these parts are expected to be fixed all
+at once by the same commit, then it may be acceptable to report them at once.
+
 Please send **plain text** emails without attachments where possible.
 It is much harder to have a context-quoted discussion about a complex
 issue if all the details are hidden away in attachments.  Think of it like a
@@ -296,6 +292,19 @@ security report. Note that some mailers tend to mangle formatting of plain
 text by default, please consult Documentation/process/email-clients.rst for
 more info.
 
+After sending the report
+------------------------
+
+The security team and maintainers almost always require additional
+information beyond what was initially provided in a report and rely on
+active and efficient collaboration with the reporter to perform further
+testing (e.g., verifying versions, configuration options, mitigations, or
+patches). Before contacting the security team, the reporter must ensure
+they are available to explain their findings, engage in discussions, and
+run additional tests.  Reports where the reporter does not respond promptly
+or cannot effectively discuss their findings may be abandoned if the
+communication does not quickly improve.
+
 Disclosure and embargoed information
 ------------------------------------
 
-- 
2.52.0


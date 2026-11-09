Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211421;
	b=gHjHKMYWCP0QvvffpAECLKVu85NX/F/5QAieV7g/2qStViZL5VZSsl5K0Y4SXeIN2Ioh
	 jwmZIieMilazxHbY4qMJ0sYVn4FFa0kXbqiQK4G7rml62iwUQvkOgjJ10E5nHhI2hY1MY
	 6pbvnWggknDqsMQRpEkO4qJwr+URPFWx5eFUd1maRYKNXZEDyeMVaA5ff2HpWvW6AY9Xk
	 kts6391pZ9CdSimkXTKQyrII5nlC6ulOUwTOTqBNAH/4lzicZSTO560AD8vAeXmNmUc+U
	 wmgmT0gydqE5qErzS5NjgGUqAF0MTfDds0Whc/K30RfYxYEim8TrCzv5DesirxGv9vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211421;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I55+dGkuKDXOR4BfNZ0UGOlravZoEiT0iCNfM03+mag=;
	b=Z9fUvmosx02PKUwAUiLJdMQQxopCI0/LWye7JqRUriJJueIIcZqx44fhRRjibcp5hw90
	 2pCSudQJUKzhe7Y/GGlje+6tg8Sau05s6rM9tW3p1iduvJteYwFZayKsKh31KVL1znb4+
	 mLJCqYJk/blHQTiy4CeKQy5C8bob+YoebkoHrnK/BGOrkfC5ElJXBjCbyisbuZ8nlAe1q
	 0hJLuDNqGfNOcuoNpETA16ok1d6kObq2aR8LPMNRqW781IVkUeFw8KmTfIgKdE1y7jNtO
	 i072IVNnBdzxosdIeV/TNylNUr66ETQ87RcnzYKdJYQENxgTz7z7XGdypcbJVHtY69w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=MI2R0LGG;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1C606EE92;
	Mon,  9 Nov 2026 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF1C606EE92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=MI2R0LGG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=I55+dGkuKDXOR4BfNZ0UGOlravZoEiT0iCNfM03+mag=;
	h=From:Message-ID:From;
	b=MI2R0LGGjOtwUmhWHUpTEN7s51HFLh7q6YWFVXVafU3a8eql3qAFxw7HjmUVjXi8e
	 zZ1nimDjrweGZtMvM6yPgG5KQdEakUh7isAXruGK8D6bQjRdoz2Jo9yR4m7kXfHiJm
	 qpwQe3QDFEj5CUaelnpKRSqo5Eq+kLxCbnvpvYjo=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 3D8C1C0960;
	Mon, 09 Nov 2026 09:03:34 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 12/14] docs: security-bugs: explain why AI-found bugs are handled publicly
Date: Mon,  9 Nov 2026 09:02:38 +0100
Message-ID: <20261109080240.29444-13-w@1wt.eu>
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

Many reporters of bugs found using AI do not follow the instructions to
treat them as public, likely because they're worried to be blamed for
disclosing it.

The security team constantly receives duplicate reports within a very
short time, which makes it clear that when an LLM finds a bug, others
find it at the same time, and some may already be working on exploiting
it. Keeping it private then protects nobody, while handling it publicly
lets everyone fix it quickly without a needless embargo.

Let's clarify these points and also reword a sentence about AI reports
that could be read as "do not send them to us".

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 69dbc47f54625..72f9b8e45052e 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -42,10 +42,16 @@ a system.
 **If you resorted to AI assistance to identify a bug, you must treat it as
 public**. While you may have valid reasons to believe it is not, the security
 team's experience shows that bugs discovered this way systematically surface
-simultaneously across multiple researchers, often on the same day. In this
-case, do not publicly share a reproducer, as this could cause unintended harm;
-just mention that one is available and maintainers might ask for it privately
-if they need it.
+simultaneously across multiple researchers, often on the same day. Others are
+then likely to be already working on exploiting the same bug, so keeping it
+private would protect nobody, while handling it publicly lets everyone fix it
+quickly without wasting time in a needless embargo. This applies even when the
+bug falls within the threat model: only the fix and its description are made
+public, and reporters following this procedure will never be blamed for it. In
+any case, do not publicly share a reproducer, as this could cause unintended
+harm; just mention that one is available and maintainers might ask for it
+privately if they need it, or better, send it upfront in a separate message to
+maintainers only.
 
 If you are unsure whether an issue qualifies, err on the side of reporting
 privately: the security team would rather triage a borderline report than miss
@@ -169,10 +175,10 @@ ignored.
 Use common sense when evaluating the report. If the affected file has not been
 touched for more than one year and is maintained by a single individual, it is
 likely that usage has declined and exposed users are virtually non-existent
-(e.g., drivers for very old hardware, obsolete filesystems). In such cases,
-there is no need to consume a maintainer's time with an unimportant report. If
-the issue is clearly trivial and publicly discoverable, you should report it
-directly to the public mailing lists, without the reproducer.
+(e.g., drivers for very old hardware, obsolete filesystems). In such cases, as
+well as when the issue is clearly trivial and publicly discoverable, there is
+no need to consume a maintainer's time with a private security report: just
+send the fix publicly like any regular bug fix, without the reproducer.
 
 At the very least, when using an AI assistant to find and report bugs, make the
 assistant read this file and threat-model.rst before proceeding, and have it
-- 
2.52.0


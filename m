Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211420;
	b=O/lOgqjceEigB0FTMycL3pFQHhlIN3g0SdOhKEfOei/sEN4JBc78b5lfd1dS0rM0szcF
	 F7WnsEqeWDs6CQGB75LMK5cdOKji/yd5rLiFfVIjbFYUQ1kcxEwOCkkH8E3TzzNCo+vF1
	 1i22jCJJJu+vezFb8IkRo8FCwtCbGcVsCFsNbtmn0b6gMo1qb9t/vAXmHZUH0Eeej+v39
	 14WKJN6UNcw3zuSAt2893+9bjq8zh9Oq/KG/+2OtA+23V715/jPaa5gRtRYsC3kZVi4gK
	 3dsz5JWksV41m1n/QrlsL1xN5jM34YoSQfDxkt+j2KkY9TwOQ5fY7YclAAJvQLXR54g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211420;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ymBHKkh/7311Wew6Y2XIMeYWSUqBJNNugEpNopnlV5A=;
	b=DxpqUjocHHuelaC/h67qMwSd0PJwZygTLyFdXUR4Vc2GdaTrH5yGjf27tlNn9yPskYf1
	 +8BLc0BL/1RRuJsgOru7mQm9RUGKJWk1GBtWFPxphe3aGcaKeXZNZt3APzBcH9FZQTZ58
	 sCh4HxAnRjsZQamaVshTZLCyQv6bYBVjZayQ9gy4k3ifhlAWhSwi8vmI8CPQFlyOmEM4q
	 RB+u8Yz9B3LSv/4jl0j9mPG0Cqlm25JrNjCxS9TBgvLm+Yy8EzbriVQCCLONLHQNTkxKt
	 eDPZEx+CRvRwYqkkRCKLpZASTaHlM2fqFR8pDNOt+Ofzf9YZLNLqgkJzOoAjscZuZRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=h7j1YXLn;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28380606D839;
	Mon,  9 Nov 2026 08:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28380606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=h7j1YXLn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=ymBHKkh/7311Wew6Y2XIMeYWSUqBJNNugEpNopnlV5A=;
	h=From:Message-ID:From;
	b=h7j1YXLnAovCd73J/Ym0CWLF446dTK9x0BnJORx3uzbSBWU7Dsd7aN90xJOMe3oqZ
	 BnIEggT586edXz1NGCjmNbfri+8wPA1cvKjJNkrxxcM8Bwbsif5ZoY5VSasaWSjF/A
	 cXC/QJuZ1kh2L6vag5c8wR//EgOyzP+VZSRV/BHs=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id BFA9DC0967;
	Mon, 09 Nov 2026 09:03:34 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 13/14] docs: submitting-patches: defer to security-bugs.rst for security fixes
Date: Mon,  9 Nov 2026 09:02:39 +0100
Message-ID: <20261109080240.29444-14-w@1wt.eu>
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

Despite recent improvements, the security team continues to receive
non-compliant reports clearly indicating that the author had not read
the documentation. It turns out that submitting-patches.rst asks to
send such reports to list's address in a short paragraph, so it's very
likely that some reports only find this one and do not read the rest!
Let's replace this with an invitation to read the security doc instead.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/submitting-patches.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index f271d7413f72c..ac7d0d8f5be56 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -253,11 +253,11 @@ He gets a lot of e-mail, and, at this point, very few patches go through
 Linus directly, so typically you should do your best to -avoid-
 sending him e-mail.
 
-If you have a patch that fixes an exploitable security bug, send that patch
-to security@kernel.org.  For severe bugs, a short embargo may be considered
-to allow distributors to get the patch out to users; in such cases,
-obviously, the patch should not be sent to any public lists. See also
-Documentation/process/security-bugs.rst.
+If you have a patch that fixes a bug with possible security implications, you
+need to read Documentation/process/security-bugs.rst first: it explains which
+bugs need to be handled privately, and whom to send them to.  Most such fixes
+are posted publicly like any other fix, but their reproducers and exploits must
+never be posted publicly.
 
 Patches that fix a severe bug in a released kernel should be directed
 toward the stable maintainers by putting a line like this::
-- 
2.52.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211420;
	b=plIGBXmsJC/Nm35Z8XpxaA7vz7t6kfY31f2I4eKPInXd4jwr6AHKwwZGMWO1WYva7Crq
	 LYZA2N7oenVluRT1dTDksk+faDMyaHN/Fh40BBdtaXnYFxapLnPr9bT+EWLd2bRQYJbCN
	 FkRFzA13gvQs5ZZy9KxpCggbL9tYI6nSxkhEcpr9G1segwNYKdNrCjYIfFR4KnXsRdjCW
	 U/XbGb/yYwp9kJfFymysIKSSyvUk4/Kk/OEq53fY9dwRAfq7iXxh4ReFXxiSE66YMUe3n
	 pc6+z55yLOKt1yhfpufmpj0IZzAOA5OfPKI4vzZWqFAtWpLxyLHBseRhIsTBA4AdbEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211420;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L/COrqM9/qDfE6gPPXToBY2+migu9psVH73FcSMbq4g=;
	b=HsEo3l0ml+1sEn4la5agVcZBiHKpFOZHiOlANPHV2MZ+FLKQA5XqMzkOEDrocuNlxS1c
	 aicGHvKewqXMs78YkCcvPR1FCVQGXkz2jTLONr/YfemJA6MyDsqy+7GB57hwJuKSd39SV
	 5L7oWAg827ttad9pxr6eKF8PXszAO3hp6wf3NTz+D8TV9/y1hVwVWkIkbwy6iLpIRMskG
	 EMMy6ydR0wgaBd92/YIRl3C5Vk1nyN4Y58mjfTwxdXMrE83NE/mghb+WOh7oDWKjfDLV1
	 W2bSHICjnFR5MIEGLXeGnK9vLnOM+FYsIiQjEXD+1BsutdTmEAYe3v+H4HtQXHDomsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=dzsowNNp;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF5606EE90;
	Mon,  9 Nov 2026 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6CF5606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=dzsowNNp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=L/COrqM9/qDfE6gPPXToBY2+migu9psVH73FcSMbq4g=;
	h=From:Message-ID:From;
	b=dzsowNNpRbbfC8cNb+vDaxNeHPyeqS3JxtEIc1feTJzkrN2OxeU8JcXDmoGmiYGHB
	 iLgqfHBaVM84u1MtwLL5wbJW/SHeZrNPu6vlBeayWbsITZisALI5E19YMlHL4STgpe
	 YcCrAzu+/QRvQVxv86bPx8mHXFpBmB5e2Dhs5pig=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 6CEBCC0962;
	Mon, 09 Nov 2026 09:03:34 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 10/14] docs: security-bugs: add a section for maintainers receiving reports
Date: Mon,  9 Nov 2026 09:02:36 +0100
Message-ID: <20261109080240.29444-11-w@1wt.eu>
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

Now that reports are expected to be more commonly sent directly to
maintainers, some of them will receive security reports for the first
time and may not know what to do with them, or worry about having to
deal with them alone.

Let's add a short section reminding them that they are not alone, and
that they are welcome to ask the security team for help at any time.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index f19c712bc8e7b..280f7f3a94603 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -5,7 +5,8 @@ Security bugs
 
 Linux kernel developers take security very seriously.  As such, we'd
 like to know when a security bug is found so that it can be fixed and
-disclosed as quickly as possible.
+disclosed as quickly as possible. If you are a maintainer and received
+a report, there is a section dedicated to you below.
 
 What qualifies as a security bug
 --------------------------------
@@ -404,6 +405,24 @@ do not ask for proper receipt before this delay. This will not make your report
 be processed faster, will add extra load on maintainers and all you risk is
 your future messages being ignored.
 
+For maintainers receiving a report
+----------------------------------
+
+If you maintain some code in the kernel and received a security report, don't
+panic, you're not alone! The wording of AI-generated reports these days tends
+to sound scary, but just stick to technical facts and proceed like you would
+with any other bug report. Feel free to share the report with other maintainers
+who you think can help you, telling them upfront that the report is private.
+Many other reports are being handled by other maintainers at any instant, do
+not start to worry that the security of the whole kernel suddenly depends on
+your ability to provide a quick fix. Do not let reporters dictate conditions
+that are not compatible with what this document describes. If you have any
+question or doubt, be it about the validity of the report, its impact, the
+process to follow, difficult interactions with a reporter, or even if you've
+mistakenly leaked part of the report to a public list (yes, this happens), just
+ask the security team for help, for example by replying to the report with the
+security team in Cc:, or by forwarding it to them if you're seeking advice.
+
 Disclosure and embargoed information
 ------------------------------------
 
-- 
2.52.0


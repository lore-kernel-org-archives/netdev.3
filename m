Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211421;
	b=KdtxrDzRMaalfPxnRj1ZBObL0tl8PaqK//83X3RzHCESHLH8WN/JOwIkIa7/PL7V7kB2
	 EI04LPaLDbUJMVtbc474qsr6kpw68R4+KwANQnO91G4G5qf9oywIOAgPLJklDXq9prDvz
	 BvBY3peXdq2bXCa81z73EhU/kQxTpflqHlh58Y0dOpyLbFGy+8kRNtiCj7j5j3at9ingb
	 ur7UGtr1cEsH5tzBLaJg5VrL4qw6gt2XhraFqd+h/UWAimR7fgF2CkcZLgExZMWtSAGWD
	 DoyKzQW4x50EV5W7NpT8pgWCFsULQndbMVuw6CQLQubYSAMWybnuwr/ZzO6tz9XTADg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211421;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vhQYZB6JMwF8v4yxPvQd0flWkw0L9P4IR4WJBq2CuYE=;
	b=Ohb2hocxyqoEM1NKk2sWvE7F9UJUNcjXRU+iR5qZ8MIyaqHBcAUbWTXgERDdIBHzX9DN
	 7B5ui4mor1sQpYilPMxMGpAHzXPzfoE3wOKvo/DJrzn9rrSkVDY78e+03QLBibqlnKUYt
	 yKzrAHzt0F/hDyjp91PLxYQZBZwzOLw8GphGvnFwSYJKlDPoGZzd1ctawQHvxYD9UAqL0
	 CbaNbWgfbGB/kmoyBmjfQbYcbUCXrA98JXebF7V1R1bM0gRDv/34rPKdOONgX9cATR96i
	 DZI+WsfsMXAjVpKg2vKy3W8I4li3JuMewKyCbifQ/iDsANAzdtHGz5Nrlf6Y1PRc1lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=ium4Q270;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D73606A33A;
	Mon,  9 Nov 2026 08:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D73606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=ium4Q270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=vhQYZB6JMwF8v4yxPvQd0flWkw0L9P4IR4WJBq2CuYE=;
	h=From:Message-ID:From;
	b=ium4Q270F8Za+94YeebDq+qVoQNW4jr5CEB2oZHAlEOKprsPs7f14g/YreySfWpLg
	 UQiK/9zFtznxe/ULiDiYkeYrL6E8GamH+pbEKgXDcG09/CZr1Ptta1zEEJfJhLZmZG
	 RQDU4e6MAJM0BTAgnrtXa8BAo7EJMxe/pZjnCVUs=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id C2EFBC096A;
	Mon, 09 Nov 2026 09:03:34 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 07/14] docs: security-bugs: first-time reporters must send a single report first
Date: Mon,  9 Nov 2026 09:02:33 +0100
Message-ID: <20261109080240.29444-8-w@1wt.eu>
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

The security team regularly receives series of reports from first-time
reporters, all of them suffering from the same issues (missing fix,
wrong format, missing information), which need to be addressed one at a
time and put unneeded pressure on maintainers. Worse, the security team
ends up having to respond to each one of these messages so that CCed
maintainers know about the problem.

Let's ask first-time reporters to send only one report, and to wait for
confirmation that it is in the expected form before sending the other
ones. Also make it clear that violating this rule shows that the
reporter did not read the doc, and that such reporters should be
prepared not to receive any response.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index ac4409d3b27b2..6f5b5e492ed3d 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -304,6 +304,15 @@ exception is when an issue concerns closely related parts maintained by the
 exact same subset of maintainers, and these parts are expected to be fixed all
 at once by the same commit, then it may be acceptable to report them at once.
 
+If this is your first report, send only one, and wait for confirmation that it
+is in the expected form before sending the other ones as individual messages.
+The vast majority of first reports need to be adjusted, and otherwise the same
+mistakes are repeated in all of them, putting needless pressure on the
+maintainers and on the security team.  Violating this rule is a clear
+indication that the reporter did not read this document, and such reporters
+should be prepared not to receive any response at all, as maintainers and the
+security team have better things to do than to repeat what is written here.
+
 Please send **plain text** emails without attachments where possible.
 It is much harder to have a context-quoted discussion about a complex
 issue if all the details are hidden away in attachments. Archives (zip, tar,
-- 
2.52.0


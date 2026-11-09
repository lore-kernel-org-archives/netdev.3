Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211421;
	b=JprpZ1xc8TZBBk+zj39Vq7Zp82+p1OkeD3GqUlWAOHcCtAnnV+Sl0wUC0/OMMJjlfNpO
	 E9sarAS0UE1VihYOX3/5k+LW8IRkvMsh0517S46t1uO6CVl9RgSOpjZCepIO52WWTxiIE
	 2TOh4kX9nBRfWgJAAnc4FXAStIPuvl26ptL0fd1syQ2Eal9wBGAuzYz/9hht9aZN8UUhd
	 gbc8suIKzh+pVMtsBAEcqeHP3MpV1OjUnALVpRnp8M1QoIa0Yy8C09+RxFsc2uIVUAdkf
	 yZM4TxiMIXOdEixWh3B3qDPmjzQcgGinOoSmMaHnYPhr3ZQCBzFfGp4hcVBxYejPdFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211421;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g21g1SgC2lsboaklyi/U39vgMWKBEXvTbZhb7gM0hYw=;
	b=ipvJovdTXYpZREtLjrTX9ovWHfIevc9q9Li7bomXevYllDcXxE3g2GcI09pGfUDLhYoy
	 6uAW1CJKxV5Jo57VsmXfh3LzBQaBbm7jsmq1U1GlhrqfgjAh/nige/4tYapcDqZErWWIj
	 F+lBvpdIZT3jU3lMJWfvsFcVKocc5f2MFtDcQ5GQ7SpIrjQ7c9Gvjn+LiZiJceL1XAuOq
	 67fr6Sgq+TfU0Zwu2ti5MjpC+GJrYl0SyKctaM8D/jliLJamPvv/ba/S6DdlacS2SutYd
	 gk0X7DUZm2pOszZkZZIQ9Kcbg5bziBhiZJQrSkhV02GsBFfUWIBgbuvO/J3EQR8m5uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=DgK2pnT2;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F12606EE8F;
	Mon,  9 Nov 2026 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5F12606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=DgK2pnT2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=g21g1SgC2lsboaklyi/U39vgMWKBEXvTbZhb7gM0hYw=;
	h=From:Message-ID:From;
	b=DgK2pnT2ZP14Qx0jm+cVf5x2A+M51hHw21qIEsT1u8fesfQs/vX43N4Fi6qXlo6sZ
	 bOpLK7VoIwCH8EwyiNnvZU64C1fQoKHH2GSC/WjMvdsDngOwogcKXcQs7MPvMh6ttR
	 XkqRWc3TXfErV60G7COlUmLTXd67oBviBYql5Z7g=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 52109C0961;
	Mon, 09 Nov 2026 09:03:34 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 06/14] docs: security-bugs: do not send archives or binary attachments
Date: Mon,  9 Nov 2026 09:02:32 +0100
Message-ID: <20261109080240.29444-7-w@1wt.eu>
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

Many reports still come with zip files or other archives attached, which
are a pain to deal with, may be blocked by filtering on some maintainers'
end, and that also encourage recipients to adopt risky practices of
opening binary files. The doc only used to say to avoid attachments
"where possible".

Let's clarify that archives, binary files and documents are never
acceptable, that large reproducers should be attached as plain text
source files, and that scripts generating the required files (e.g. file
system images) are a better solution.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index e0fb7058a999e..ac4409d3b27b2 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -306,7 +306,11 @@ at once by the same commit, then it may be acceptable to report them at once.
 
 Please send **plain text** emails without attachments where possible.
 It is much harder to have a context-quoted discussion about a complex
-issue if all the details are hidden away in attachments.  Think of it like a
+issue if all the details are hidden away in attachments. Archives (zip, tar,
+etc.), binary files and documents (PDF, etc.) are never acceptable: when a
+reproducer is too large to be placed in the message, attach its source files
+as plain text, and provide scripts that generate the required files (e.g. file
+system images) instead of the files themselves. Think of it like a
 :doc:`regular patch submission <../process/submitting-patches>`
 (even if you don't have a patch yet): describe the problem and impact, and
 list reproduction steps, all in plain text, then provide a proposed fix as
-- 
2.52.0


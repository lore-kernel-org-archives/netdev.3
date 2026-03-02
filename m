Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5AA175A6E
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487354; cv=none; b=PzxwrRJ6uS2tkp3cla1NjD0dVfwvFq8Frgv/izZI4IRBVBEvpytk2XA+Wnqf5/iR7jJktNqJHo+lZe/OvwbWiDX+HegxK7WjKYgomuMDBtqQq0Omnz9sTbHB2FwfVefZ3Rx4u5MPmHD3OEsbuM3cdz4aBZDn3aq/V5/RlIKCBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487354; c=relaxed/simple;
	bh=VQFSb0/E+dZ13xnXchY6MONmQU1NrWG1Nsmw3KlwiXM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtOKuPZALZ87uCtyANYxMTrKdIaDV3huNx2jEl7gAdUm3Jb7dy1n+C27oQ6jUKqaXyrMDVD2C2VD9Dm7OOByBLq4NPXrfI0far70HPNCJCRtlZVEZ80IENoHFZKpp8n8HCvY+pQzDx8hVmfq3KIw38DJ8qprMf3EGuH32CABu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1vxAZj-0000000A0Pi-0vGH
	for netdev@vger.kernel.org;
	Mon, 02 Mar 2026 22:13:11 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.99.1)
	(envelope-from <joerg@jo-so.de>)
	id 1vxAZi-00000001LGB-2ADp
	for netdev@vger.kernel.org;
	Mon, 02 Mar 2026 22:13:10 +0100
From: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>
To: netdev@vger.kernel.org
Subject: [PATCH] doc/ip-sysctl: tcp_timestamps is per src-dst not connection
Date: Mon,  2 Mar 2026 22:13:10 +0100
Message-ID: <d206f3f708dbc81af07bd71b19e94894181dafc3.1772485990.git.joerg@jo-so.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 28ee1b746f493b7c62347d714f58fbf4f70df4f0 (secure_seq: downgrade to
per-host timestamp offsets) the random offset for TCP timestamps is the same
for all connections between a same source and destination addresses; the
port does not matter.

Signed-off-by: Jörg Sommer <joerg@jo-so.de>
---
 Documentation/networking/ip-sysctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 6921d8594b84..0d74f8d8a79e 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1071,7 +1071,7 @@ tcp_timestamps - INTEGER
 
 	- 0: Disabled.
 	- 1: Enable timestamps as defined in RFC1323 and use random offset for
-	  each connection rather than only using the current time.
+	  each pair (src-addr, dst-addr) rather than only using the current time.
 	- 2: Like 1, but without random offsets.
 
 	Default: 1
-- 
2.51.0


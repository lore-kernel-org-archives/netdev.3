Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBBD371069
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142644; cv=none; b=ssj3SoJTi327rmJimL44vUj/qR1KX21c5sGZWiCC6H8hesrwcewTvN6stcJMRdr3dkENIeLPDH1MA3ko+cPDI8H/bvy1nESjs16byy8OV/Pnexx6+Z66vUSE/G7e6BXhGYkkh9/3Crhr++/tSxAxcM1261JrEbRacR76PvQFs4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142644; c=relaxed/simple;
	bh=CSV+m72mnmToW621YIZp9bVTf9rkjaYunWFtN8HQugQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shlrix5bvxIH2myU4PxjMJIZ67k4Gh5B2k3RpBAKj6MVUcWy6GgX2tEPeyly+Fx6ipoDgWnmSPCZpqy3MhEClV/R+iN4ZjrmTwTsSwB+iNDdzyoAxNnmmSyVSxlga5Npuw07IDOBzR8Psxyj13CG84Wt0jFwZvJEfCo5Vc0A+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pr0erWDl; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pr0erWDl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772142640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m/VMPk7L7XpjPfDSURdzShzsddu6apjP5T3tDOQx7t8=;
	b=pr0erWDlUPPP+oGucNUxBaN2jRJPc47A5aB15bfRuRvzvyQtS30XpoNR0muDG1Rc3itcmh
	vKFRONKkXHzSTG0J9GS/p4Btu1zWYMsZ9ItPLStDysoGlvXLLmrfb8GAXyd8cnR3789rQu
	XuQRYxsRJmxzI9K1BAplD8gJmmAS3R8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] keys, dns: Use kmalloc_flex to improve dns_resolver_preparse
Date: Thu, 26 Feb 2026 22:49:29 +0100
Message-ID: <20260226214930.785423-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use kmalloc_flex() when allocating a new 'struct user_key_payload' in
dns_resolver_preparse() to replace the open-coded size arithmetic.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/dns_resolver/dns_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index c42ddd85ff1f..891287a86979 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -215,7 +215,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 	kdebug("store result");
 	prep->quotalen = result_len;
 
-	upayload = kmalloc(sizeof(*upayload) + result_len + 1, GFP_KERNEL);
+	upayload = kmalloc_flex(*upayload, data, result_len + 1);
 	if (!upayload) {
 		kleave(" = -ENOMEM");
 		return -ENOMEM;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


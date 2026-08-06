Received: from out-189.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C4494805
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046777; cv=none; b=owBbRuw1QIh/YktLij3/UUcetaToFJr9FUYzl0eOtp0qhojnGNAPceOWO2Tsmu0PohNsghpAmGqxpnUQ5DrLMxpjXzRbDSF3D6bV7IF8FCS/DPQesbTs0jMp5AOTSPQBNGciBhbhFsKDA4RQGTR8De8c3T0jtX+YhnIh6kUV3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046777; c=relaxed/simple;
	bh=/ru28ls5Ob9An0DGNn71eBrPlRAIK6ScDMc3dBMET14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DB7gSYKGl/buI5tw0RMpDD3MXIy2G7C9KtE8MxmF4NuKZYpRm2UvnGpIu/LLZ++Mklry5W1ZSozOm8d/bhLWZ9X6Wv7OtKDDLs6N4lyevKbr97nht/Q0a374asR4IB6b/9DKoRBme5XFMGimbM0THYvU4FlJj8KF6/EEcZ21DAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tOMvjkWq; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tOMvjkWq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786046765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DPZ6EhoGAQBMxKtS/LkhnDGi/nKr3/3ZLpLq4Cr8mik=;
	b=tOMvjkWqthDUKFnGvG44QsM9RJ1u+rSJcf/RZm32xH5/JAE0Qx/r/U99VxE5ovV3vm4nIL
	71VbWZ3NgwJHpXGZtTTS6T42VeQp9ZHisbzY9VGIMS9WErxOuvGiTGMW1qWJRCh5jwJfgj
	njzow7IOQpytnbzk2TYPkCW0UpNLBOE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Tim Bird <tim.bird@sony.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] keys, dns: Drop unused NUL terminator from upayload->data
Date: Thu,  6 Aug 2026 22:04:54 +0200
Message-ID: <20260806200454.245444-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=thorsten.blum@linux.dev; h=from:subject; bh=/ru28ls5Ob9An0DGNn71eBrPlRAIK6ScDMc3dBMET14=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFklL55N3LZ/yz4JrqMTLFYaHN8S/CX+9+nn7ne2sKveq Wquj/mW1VHKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATCVJi+J/VI1qwxLdXYOrb Y1ue+yi2Wiv90C/47q/x1aXnz/9JbxMYGZZ6xOud/fwudGnjyZmrFvZeUb625vyJr2oam3s/lOm cdGADAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

upayload->data includes an extra NUL terminator even though it is never
used as a C string. In-tree users access only the first
upayload->datalen bytes.

Remove the redundant NUL terminator and allocate one byte less for
upayload->data in dns_resolver_preparse().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v4:
- Drop patch 2/2 from the series and submit 1/2 as a standalone patch
- Reword subject and patch description
- v3: https://lore.kernel.org/r/20260427114422.313356-3-thorsten.blum@linux.dev/

Changes in v3:
- Update commit message
- v2: https://lore.kernel.org/r/20260409225703.158552-4-thorsten.blum@linux.dev/

Changes in v2:
- No changes in patch 1/2
- v1: https://lore.kernel.org/r/20260406175810.1018681-3-thorsten.blum@linux.dev/
---
 net/dns_resolver/dns_key.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index c3c8c3240ef9..451247864a63 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -203,7 +203,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 	kdebug("store result");
 	prep->quotalen = result_len;
 
-	upayload = kmalloc_flex(*upayload, data, result_len + 1);
+	upayload = kmalloc_flex(*upayload, data, result_len);
 	if (!upayload) {
 		kleave(" = -ENOMEM");
 		return -ENOMEM;
@@ -211,7 +211,6 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 
 	upayload->datalen = result_len;
 	memcpy(upayload->data, data, result_len);
-	upayload->data[result_len] = '\0';
 
 	prep->payload.data[dns_key_data] = upayload;
 	kleave(" = 0");

Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A94EE848;
	Wed, 16 Sep 2026 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562176; cv=none; b=oGuagpcwtfWt0hb54pGosbCoC7IVkaPzW3RJkhCj+r7Ch+RM1bq8rRdAPj7JgPZZzrABnecrEz7W1++5L9tnzWSeTaEz3871wu75W4cmAT0lvgSO65VX/gfBGrZIDO2Y+WZuXRNhrmjq7F1tdbthu4OlHZOOoA5N5mbUo1ZESdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562176; c=relaxed/simple;
	bh=QU9IAVqywW400GmV/zV9qTNeweXx01s9kYEBp7fZ66M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fw8qYv9FMoHInujTRtTIlFwUoBkg6zX5QYUxhZfNWgYNfpyw0lHUB52FmgvPCB8Gq1yeCY5twl9Pqxus/zsviJRCYUK/f9LFIRizDhDjBDWwzTbyweqxcihELJ8s/G4T4aGMQ2OBnlQnPUB5hxV4opvu01DOqGKPvuP83zHl62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yjXcrMvz; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FnzxiFX7; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yjXcrMvz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FnzxiFX7"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hlJK82bNczKmV8;
	Wed, 16 Sep 2026 14:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789562172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AnPLKquphtJCTcBC3ijRrpP9eX9WDpmhtvZD8a2CXyk=;
	b=yjXcrMvzLLdMo1IPsneRfSjAZkWK4C2BA7z38YJxBXmHPl3woobPOJGRut0odZCJpGiSBo
	S5nWdzxUJwNbSHKR/Z0BKnOONMATUdZIISj6Wyi625GrYErlxU+xr+lkH2HU5K2ihLPIE8
	ldq7tFdaoc8V3bzVmdjJelSUtcnl1nctxnxawXuBR06YbcmfzoH9N8vLmdgSNu1XGyoriN
	04EEzAOoEci/IVqwK8wWCYqJu4JJGH5dA7uMhZ4fmxqhDyeer9aLx4sjWrFrG65i7qPGKz
	Eho1mjiwWhb38pJcjwVqtKifDJ2ZC1nWh3CsHZhN/X0JG1pRvRDHo1bRi7OIpQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789562170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AnPLKquphtJCTcBC3ijRrpP9eX9WDpmhtvZD8a2CXyk=;
	b=FnzxiFX7piC5r4GOUWprjJJqv48y5fl2/J4hCW4O5Ox6L3SiD1GvY3adBD6xSYjQV3Ul60
	m6ntg4+GIHe3Y15sW9h9PnZicZrKZaPaIVTDby1hUCJ8K07DdV2Tbx1A4l67Mkp2cq39ii
	JEA0heDTA9WPgGsXyH1UqGHTdjZ5pk7u/ApfEYwXciAS7SsFnD4Sh/bac8liXG84AWCFUc
	eBvs9pB5ML1PepJ5SXarT/3AbLmSDNXyCez4eCDjNEEiiVU/nwfKT1SGimG3zJvdq9Lmjg
	UfKLYL8L/ebRQzHOqszMtMLjBbbEp1hq3ZxKZxNracRK7V+3EhQ3LuPHbh7sWw==
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: net: dsa: Fix bracket
Date: Wed, 16 Sep 2026 14:34:52 +0200
Message-ID: <20260916123458.314458-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 16613bd12224130ace7
X-MBO-RS-META: d44r85ki6n6x13byd3mpmisardatq6ke

Add missing ')'.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/networking/dsa/dsa.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 42a99f5df..7edfdd555 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -864,7 +864,7 @@ The drivers which act upon the ``dsa_db`` argument in ``port_fdb_add``,
 DSA associates each offloaded bridge and each offloaded LAG with a one-based ID
 (``struct dsa_bridge :: num``, ``struct dsa_lag :: id``) for the purposes of
 refcounting addresses on shared ports. Drivers may piggyback on DSA's numbering
-scheme (the ID is readable through ``db->bridge.num`` and ``db->lag.id`` or may
+scheme (the ID is readable through ``db->bridge.num`` and ``db->lag.id``) or may
 implement their own.
 
 Only the drivers which declare support for FDB isolation are notified of FDB
-- 
2.55.0


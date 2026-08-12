Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA23403E8D
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571634; cv=none; b=lL+K8gXmQ8fvCY1M4adJdgA1Ulj0B2204BEvgfrFcOJwQaqv4GuwF5+B9S4TDda4yqjwyA5dBEAFwJEdOVuBUNopmWZqH+dQDPVjgapSK86U0mhozxsZyHZTjmNg9u06BleeaXX4f74UxhEHHcMSsj/AkarhNAm/8hTNNA8NZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571634; c=relaxed/simple;
	bh=NbuI1J9IP7noyKzuVPrlIzVZcUbUYEUIqvws0vDEKTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IE2OEsLG6JlevyKmpeuJeMV0CrjLrugYMnnuouirW862wyXtaxCQlpiMIixRqtIUziDnOrklllTIohfveDuXwqePSNcQWmeySc4NCBmq1hV//ZOm3EZVEdodZ4mRvdG8WLVlOkCRfxGmtuSYFVW6mMS2iZrxMbJtfN/u8hPxUfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=eQUPJjyp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="eQUPJjyp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc61541f8cso5014235ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786571632; x=1787176432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8LoBPhnL22x/EjK2WdlXIQmpvcgjinHL/ADzBX0WZkE=;
        b=eQUPJjypiY47AzIUOJmOdrxkhwTX8nDIA4GMEW3BNszVDbmwLKbwKMFAkPr4tmgfcw
         10Qi0T2MS1dMU2bbEHX1ar1kWYAW0U/37zI8gOXGK+HkjXB2l/jKKbp+WDwajFUnaL84
         3oHfPLUDZATlUk7mK9monU7JAYoCdSrDBqrXnX+A8n8Keij07bGerm72eGP3b8GJemqg
         PfJz4B2/94wjdaTW5AxuBeYOx1q7PBPEB9u6aILXPhQuSBIx8R6PMtO/S/pexZwPWGAN
         HXGvwhRJ9dhLK1LN4cQbe+FxWrEUwG8mPqwRmiUrw6Qr13BXhoCWrHbgzhHCgY3JBk/Z
         9JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786571632; x=1787176432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8LoBPhnL22x/EjK2WdlXIQmpvcgjinHL/ADzBX0WZkE=;
        b=mjNMY8hqgWE56gA7G7CylufTznbnmff/RLq1qxVJBsqxvcdCZUjAHAX3SJ7MmGuSa/
         gRu66czmWlpn6vH2Ern+aSrGYWNCL0rCKMd3+5c6fVrF+1GEVL48pICu9mWWw1X6i7Ww
         xhC1GxaOeggLFX0nR2TpJDMDIZX9rhqj198UuIZC1gEwDmYtFarUcacalmRjVU66QsDX
         rKL38NCAPO5hqAq7pIoTWGsqf77JzAXZtjZclQLObE94ksbFYE20jgByROUPX/6tLV0n
         i1e9wj/GC9JBTOSYpV2p/JJtaIFvsbu+K1Cc25ojGoEMEXGPxNar7qXudB6N8PXpGhKM
         qrOA==
X-Gm-Message-State: AOJu0YysIXwj8wIXc+fCjSUn0wLNn9U4DxLssCam17uZTH3KMySa5K3O
	9Bx89BL0ziQG2iJWRBlb1AbrHWRAT8MPQiZJZFeASQgjpDqGtnRi1Qyam3rAtzc7Kg==
X-Gm-Gg: AR+sD11YyLbMecSSydQ6ox35tZoBO9qgZ8rXYHIdErtFQb0gn40gXDxljs0tWBsMBgk
	bRh306OxMWhXvzHEeaZuOeFOIQjO07a75HnDq+p8yFL36vNMk9WtJ3jWPn5/pNcckoMunT6ZQT0
	9KCm9f9QALWzBn5M0FpXwWRjy1L+Rz4ghxoUpJIWWZEwwhcZ+W6UxenZeW1jtY93anNw0XRuyHX
	PQj69vwJJwLNSuejEKvHvMYExwKAjyjSFTx1u5lSmhjpOiDxjzXuuxvnsFpzd6Dv8E5OUVte5by
	QSxl5p3PWqOnrT75bAh0LKvHSFKwCyNZWtCRu/VOSgqwc7D7fMUZYXs4wouBiexYpdy55wmKDKq
	EfIsE53Sk4N+x/mCEPSpTeQ50RMCFzj8GdEZoxxk8ev6zelD8URRCZ8aaHwt6KiXh5vttdc3gVh
	TSMYeFK7JnuJQtaUoMIZ1lsSrlyPVswXRWIr7K21Se0xC9k/KaFCkuVFBkzPaEoHEqqmB5iQ==
X-Received: by 2002:a17:90b:264c:b0:369:7491:7b24 with SMTP id 98e67ed59e1d1-3931f47d73bmr492696a91.6.1786571631907;
        Wed, 12 Aug 2026 14:53:51 -0700 (PDT)
Received: from p1.. (209-147-138-29.nat.asu.edu. [209.147.138.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412d964443sm1242178c88.9.2026.08.12.14.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:53:51 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Machata <petrm@nvidia.com>,
	Andy Roulin <aroulin@nvidia.com>,
	David Yang <mmyangfl@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net RESEND] vxlan: vnifilter: enforce exact length of GROUP/GROUP6 attributes
Date: Wed, 12 Aug 2026 14:53:41 -0700
Message-ID: <20260812215341.763123-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VXLAN VNI filter entry policy declares the GROUP/GROUP6 address
attributes as NLA_BINARY with only a maximum length, so validate_nla()
accepts a payload shorter than the address. The GROUP consumer reads it
with nla_get_in_addr(), an unconditional 4-byte load, so a short
attribute over-reads up to 3 bytes of uninitialised slab data, which are
stored into remote_ip and echoed back via RTM_GETTUNNEL, disclosing
kernel memory.

Switch both entries to NLA_POLICY_EXACT_LEN() so the validator rejects
any GROUP/GROUP6 that is not exactly 4 / 16 bytes; a valid address is
always sent at full width.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
  resend: resend since netdev patch queue has overflown
  https://lore.kernel.org/all/20260704222254.914567-1-xmei5%40asu.edu/

 drivers/net/vxlan/vxlan_vnifilter.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 3e76f4e21094..dd94085e0886 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -462,10 +462,8 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
 static const struct nla_policy vni_filter_entry_policy[VXLAN_VNIFILTER_ENTRY_MAX + 1] = {
 	[VXLAN_VNIFILTER_ENTRY_START] = { .type = NLA_U32 },
 	[VXLAN_VNIFILTER_ENTRY_END] = { .type = NLA_U32 },
-	[VXLAN_VNIFILTER_ENTRY_GROUP]	= { .type = NLA_BINARY,
-					    .len = sizeof_field(struct iphdr, daddr) },
-	[VXLAN_VNIFILTER_ENTRY_GROUP6]	= { .type = NLA_BINARY,
-					    .len = sizeof(struct in6_addr) },
+	[VXLAN_VNIFILTER_ENTRY_GROUP]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, daddr)),
+	[VXLAN_VNIFILTER_ENTRY_GROUP6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
 
 static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
-- 
2.43.0


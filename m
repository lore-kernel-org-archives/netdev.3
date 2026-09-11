Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33EE4C7544;
	Fri, 11 Sep 2026 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162974; cv=none; b=TQMyWeRYfrBZcwbrURKmRbBL7hGD1G+tkWVHjjlLxvwxnBPnLNIK20U0NjBy7EBkDOIYCd2L5cCQD5RDiaEh/8f3tBVhlONKCITlv0eaDDJs8ln9zuCzAjZk9l2QKJzahI4IduZUmRMyZb5DbcgmzTVpqGjKZJp5XbhSloQoiy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162974; c=relaxed/simple;
	bh=gXTP5ckf0D7YJRO9dAV6JU8rkAjt4h+E7syxRtcp//Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyHzhmPbUpWcxpnlMN8eLn1OQDCDIjtmNfhhg8ROEGzLG9mpj0JqR4ECPtEVbxU8uoqNTIz1dYONTuD4AlZz+eAiLir3aMN/cbFI7efShPtrItEAp9OelUSEbke4KVNbsQou+7fyX8aiepiMZXyW2yIaWg1pEf9Ju00SqRQkOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KopSP5pS; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KopSP5pS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162970;
	bh=gXTP5ckf0D7YJRO9dAV6JU8rkAjt4h+E7syxRtcp//Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KopSP5pSTXczK8qrpodF/Ke3PdC0b1WLACF5J8z6+vQ7gE0irtMbMCULA1t3yuiIb
	 K2QzZzFnEZMRtvaVMqCV+GhdLTobdtQSUFDqAQq5k3ufPWvegRsOamsakb+qOO5xDp
	 M99KxUxNPBb3lYlSuVx3t4obHbhww13/3EpjShOe/5nhsin3TRYWPKL9HJSBX1zw0V
	 i19iwBG0A3WyhhIMjild9zw0ib366BybojW8tYkvEXetaPS9+DzLkZ/4WcrwBs9Glp
	 nVIKrPWXlsLPFndVTZXDDafXd/MQ5S8xQZ903A11A27ULEpyF2wkFKyknU82bj/unj
	 UQRg3XFBIiMTg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D42296010A;
	Fri, 11 Sep 2026 21:42:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id CBDAA202113; Fri, 11 Sep 2026 21:42:04 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Subject: [PATCH net-next 06/10] netlink: specs: ethtool: re-align c33-pse-ext-state
Date: Fri, 11 Sep 2026 21:41:32 +0000
Message-ID: <20260911214148.1184806-7-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911214148.1184806-1-ast@fiberby.net>
References: <20260911214148.1184806-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

enum ethtool_c33_pse_ext_state is mis-aligned with YNL:

- ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED is 6.
- ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE is 7 (not in YNL).
- ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE is 8, not 7.
- ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED is 9, not 8.

In commit c8149739af86 ("netlink: specs: Expand the PSE netlink command
with C33 new features") the PD_DLL_POWER_TYPE enum member was skipped,
leading incorrect values for power-not-available and short-detected.

As PD_DLL_POWER_TYPE is not used, then skip it, but set the value for
power-not-available to 8.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
CC: Andrew Lunn <andrew@lunn.ch>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..439bf24e7c33 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -89,6 +89,7 @@ definitions:
       -
         name: power-not-available
         doc: Group of power_not_available states
+        value: 8
       -
         name: short-detected
         doc: Group of short_detected states
-- 
2.55.0


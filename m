Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70124C7545;
	Fri, 11 Sep 2026 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162975; cv=none; b=i8T8TzAWiYL1nO3VdtXckR2mYs5Fu34p8xwrElJMCajuSH6JMXxecLvrPZUX+qOnSnKv0EkKy25uNnAjGgW5bmoX3zepbduR8EeAOvzh/Tmc1nzJTigMKeMQ1zset7zy83bF8fZwR1KbE7IVSdehZSJZuNpfSmhXbVwCeAo/eos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162975; c=relaxed/simple;
	bh=QJNacRZxQSqHT7njaG33zbUTweGbUTU41FW/3xDy/m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rin8gMvwe15NucpFVHU96tvNe62EG9vtIZ8N443+C+uXSX1n8k5kg+616rESTU/R6xUFIIva5tgJIdJY1i18pJ6OPQC/LOmIjFkIGP9H2mUTRpu2Dmba4UWXaqHob2fFvrT1Em5MCr5gXRApppkr7mWp2LGhSon5Jlw5KiRw+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=r+WaFGXX; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="r+WaFGXX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162970;
	bh=QJNacRZxQSqHT7njaG33zbUTweGbUTU41FW/3xDy/m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+WaFGXXM6+pEZkXLrfPzcD39Lvzt7LICyzmncvo0ZMfur27FqCNy5Hz1witzs6rK
	 p3aIymP3DD79VG4q/xc7tfbWWKytithfKK89Ss9DSnQcqm9Gp+Uzdpoo+VJmTpp5P0
	 c2EjVHF9KT6sWfMoQWl/C6yr4BYQPZG7VpeMcoe+VGwc0GUde0Tr1avEEYRYXP0khl
	 X8N9NW7Wnjb6GnqcrjIwO2m3wQuYQ2h4tP9X9G08U8Kuoo/jNypxM8eLW44qfCwvXz
	 caMXxANgxa8wqZJ03UIdgVd3dl9ptnsA4wzj9xh+oYU2WFV1GTZ4Gz5nSsFljq3jU0
	 6BvDLBf5DTHUA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E28FD60130;
	Fri, 11 Sep 2026 21:42:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 6EDEB2022C6; Fri, 11 Sep 2026 21:42:05 +0000 (UTC)
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
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 07/10] netlink: specs: ethtool: re-align module-fw-flash-status
Date: Fri, 11 Sep 2026 21:41:33 +0000
Message-ID: <20260911214148.1184806-8-ast@fiberby.net>
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

Correct the values for enum ethtool_module_fw_flash_status:

- ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED is 1, not 0.
- ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS is 2, not 1.
- ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED is 3, not 2.
- ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR is 4, not 3.

Re-align the YNL spec by explicitly setting the first value to 1.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
CC: Andrew Lunn <andrew@lunn.ch>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/netlink/specs/ethtool.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 439bf24e7c33..6868eb473478 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -47,6 +47,7 @@ definitions:
       -
         name: started
         doc: The firmware flashing process has started.
+        value: 1
       -
         name: in-progress
         doc: The firmware flashing process is in progress.
-- 
2.55.0


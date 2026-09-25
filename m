Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45284FECC6;
	Fri, 25 Sep 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372411; cv=none; b=PAbhTgo41Uh/+uoSwBC1c1FgvwqxkceYITsKMlsJCAI6+u5WKYsQhG5FegJ6MQPZzEZgC6aXteblvY9hDwk1goBGHmXnjJs2rR7FDNYMOTffsdPEW9jVESR/d5liRDU3vRLOb/DqyO0a8ERGKWkfrwmXrfsCheki3ksoDJsUNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372411; c=relaxed/simple;
	bh=4OMhJ8PUoDtj/9FP7ksMj+MruyC0v3flVFVkmYImT7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REuOPCU4lFrMYQITpB8U96I+vv2HiXLEjie74jYrK/JP6v18FpYjcWcsNsMpAuGqZeo3tZ/pV9C1nYiOqejC97GMZmsNGWSW6J6OncmV88XlQ/c7ji/gUjxS0nfim5QEIj6RXy23hWkARuBfNbwxouEgqrD/wIEYqrMufR1A7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=aDe8QS4Q; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="aDe8QS4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372389;
	bh=4OMhJ8PUoDtj/9FP7ksMj+MruyC0v3flVFVkmYImT7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDe8QS4QUdd5x6i8vI8wHsBfVwUzRnVAXXWmi7Ku+BCd+IJ37DEiJVeeDGyAD/eEE
	 UWcmez0E+TRCwy6DEucXj+nnXjY2WqcvBvX2Z2Ps5HUVe6/32vduJXYvqRMXq9I6rg
	 c7rcv6KadiJ0HO4f2Lled4ZU0oY6lqRTCKm6NnBAC+eFKHZNY7R8HVa8yc3GvKgmpb
	 2+bwfheHCCSmW9OHumifdWZuQTdZ0qYzf+/g6v0hGSgJaSjINCbqkf5zWNqHydfhUr
	 vsD7RgrS11GcMqGIX0sminoVgzQWft7LMA9LzzeZQxY/Wlw0RC9iNimWnSsr3O8KrF
	 /OJvZqWObvgHw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 407956010D;
	Fri, 25 Sep 2026 21:39:49 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 363EA201C1E; Fri, 25 Sep 2026 21:39:21 +0000 (UTC)
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
Subject: [PATCH net-next v2 6/9] netlink: specs: ethtool: re-align module-fw-flash-status
Date: Fri, 25 Sep 2026 21:39:09 +0000
Message-ID: <20260925213918.204767-7-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925213918.204767-1-ast@fiberby.net>
References: <20260925213918.204767-1-ast@fiberby.net>
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

CC: Andrew Lunn <andrew@lunn.ch>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.

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


Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137564FDE7D;
	Fri, 25 Sep 2026 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372408; cv=none; b=iYmaJgJi7fEDD6/uibrOM8eKKWQF0znMdnOnxOs64oBCXJqYaFH0gfFNWNMTov/OsjGxSQAqg3k+yoBpamDYb5ckiToJtXddKYcMCslzfaMfpC6a272inEETgX8lARRwvn1U8J3dGMIPdMUwkf0JTUE359da7DZIUG/WtHESOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372408; c=relaxed/simple;
	bh=ql/lNNVL4y6i2YRqXy6X5n2banIhc0M/BtwsKbJbxzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8PEwW2KSbOcqJd2Wq8KtinGg+CroZWGlETfSqMjPUunW0eyJn0uPUTfVEJLGiyH+bkZbl7Ym2vfcjVKRBajkkkqgebXCBAe1FC4T4RQziRYwS+p2e2oNKIkeHXldLFyAk+pkDni0Hxk8lUZYs/h3+xCZXIUHhhYLyrnplZXkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Tg1GM8IM; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Tg1GM8IM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372389;
	bh=ql/lNNVL4y6i2YRqXy6X5n2banIhc0M/BtwsKbJbxzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tg1GM8IMIqNggcqaGajCxktq9RG7//49SP1aVwFW4fuVLBtdkU78LI+vcRekA25Z+
	 DpW0HKL+cvdjKMRiSnjIJTYDgVNwEQenw3AAoGD7xKy3xbAW9PxtNIUrLfA1pK2krw
	 8d1xdeMWLNWMlOg56qaNjJldnuHDZ1O0J6EgFjcQpUQzwEDC5wktERRLmlFJ8nLJtp
	 JgP4wHJG+XXQjhjmlOw3XOyhYVGOdvVKmMwuZrs8CpnSdHqOhF+iSHljXGHJKY9HPp
	 ZhAuxjYQ3VUJ+cft/zLh4avM2di/2SB08XHNlVxkBKAmcnKiPQcKkDcXBf9ojUIX/p
	 XRm+K8iW1JOAA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 504106010F;
	Fri, 25 Sep 2026 21:39:49 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 2C09A201C12; Fri, 25 Sep 2026 21:39:21 +0000 (UTC)
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
	Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v2 5/9] netlink: specs: ethtool: re-align c33-pse-ext-state
Date: Fri, 25 Sep 2026 21:39:08 +0000
Message-ID: <20260925213918.204767-6-ast@fiberby.net>
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

enum ethtool_c33_pse_ext_state is misaligned with YNL:

- ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED is 6.
- ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE is 7 (not in YNL).
- ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE is 8, not 7.
- ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED is 9, not 8.

In commit c8149739af86 ("netlink: specs: Expand the PSE netlink command
with C33 new features") the PD_DLL_POWER_TYPE enum member was skipped,
leading incorrect values for power-not-available and short-detected.

As PD_DLL_POWER_TYPE is not used, then skip it, but set the value for
power-not-available to 8.

CC: Andrew Lunn <andrew@lunn.ch>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.

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


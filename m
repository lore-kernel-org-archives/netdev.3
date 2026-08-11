Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368942D75E
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440552; cv=none; b=DJYJqF/0mt8oxY7zt7v/I4QzTReh1o8U06TOPOFDAUKd7T6I1XjgC0n+oyDmxR7vXe46mkqz5CldG4QAOn0gaSSGC1s3r03qcJo8YArFmxhP0NElM4sEMqiq5IpkljzOrpdjHoThEdhBAOOBBGR0dVIYV4tAZNMNiW55vI63/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440552; c=relaxed/simple;
	bh=uxeJVrns8QwyjSHCN9EiUaTLmLVR3PlKWthj3ETOI48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XblSCV8dpFSvTjcDUjcBXAwBq6+L4kUWGpR/aYC0lDzgi6Hryl9m4Mz43hNHayFP4mZPPu/xo2IEd7Wf5bgb12gz0aSBRc254dXdYmwaG+cMs08p6OnuIzXgzWPxBTA8c8KAeb7SP0gd2P+M7JwsWe4xMIDCCdVZYWTj1AMd2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUvm0aTQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUvm0aTQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-472326ca506so408937f8f.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440548; x=1787045348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SDVkGCf+wZIAIn3ijo+C35M8x1Ew0hMLzqVjwMb8SL4=;
        b=bUvm0aTQzetSDcof3XZfIue6q6esK5KkZYVlKTZg+smkGWNvAL8q9am28VIHgd/hV7
         GoXXUeIFWPlurb+PwPRc6qHB0DxSsC6VnV4iQKQJttWheE8H+rQJ23vZOaMbJkh7DIM2
         tAHZmlqywQ1HJY718a6BWAd5vBOUomJgPROxkRshGXoZWv4YfRg8e6bmHrMcdhSKXDXZ
         sNMeHrxm9XJpDpaWvb7mTHxp9qE4bMgqzkL9LhKnLbgQxc7Y64krWJJd8MLERiFUFSrZ
         U1SBXPllOZmQga+eVAwHLR6AzYuHf1HC3n3uBpH3DlsaEdaBuiEIUGndyF6tjobfiTZW
         CAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440548; x=1787045348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SDVkGCf+wZIAIn3ijo+C35M8x1Ew0hMLzqVjwMb8SL4=;
        b=AWp5VZieRlZ9RBDu+jOTX/fAsjmg77Ku+ylIuLdAEfPzTkioG/lk36/ne5oFTo3v3a
         VO+ZtMoi2ZKLWkqm891Zcdzlnh4FLZUhl+MvrRhhcTawxVBeApxRoUteB4fAFDgXiqyJ
         WbyC8iB3pb69PheaJYYgi4f46M7LaaSm3m76TdOHwgMiow9jp82Aqx7CQrknOB+Xd5Z5
         I7mFskRAM8qCNrMnfZ+qohWWs+aITlouOdMWqtlTdGJIJZjJOuDIOg9tfVtjZpJ7c5gC
         gMdHii8QYjTnitPKLr9Bok9msOusY498W9u+vEXElvvVWDWFrlH6vlFqpry08NZkeIUb
         pZKQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7yESeB7bhUnP3Pk891Fh8fsvbj9nBg0FgpJi8OJw+UbFRaFHcpU082FPBVM/cOxA9Iy4rpfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH9UdzegQKAsmduRsP3bZrkJIoad55oiKSJOSnGIH+unLVF+7X
	RUkTuz1RZsVVatbirPgWPtsYrwhBBQEc2fLNkIuSkcVtkWZmnaCM9GXk
X-Gm-Gg: AR+sD10bDH/c6Eyz8pWjuImGGMQzfWYRPXsj0EIhqWNYvyeuhE1wo+tBzuqMeiGKYal
	s3bY9Qu/s6uMBmzo7bwsgzqWrIL9kCrnYU0OGRWvdOYD+jTuRg050rQ99PkEc45NY+LgEIbaCf+
	t51sLyT/NXY41xs3KkoyWl967Hps6rgBz1hUAVIWuGNCEKQZpUxnKPQFb3ggYqWYOfokWhrlZX7
	9gcIOfBxvG4er1od8PfbnQZca8RGlhqVJYkp7ha8c0EWpSMUZMSp4ENPv5XJbDwsBQ6tg9u42vu
	nFoZXUoOCfgCUzZQNujG8wxQtAUqzFq7HbcVu3FFqQrajuwb92kXSal0hVNXOo3jlhvU/kez1p0
	c0TbHs3Jk4UY5qTYP6mSgHnsyxJ0vo5CM5pcb4M8C0p3Wf55cglqUB3lWKyLre/ol1PjF4zN6tL
	zQKG6jLe3FPqxpLTsTpezmmz4LQ1LPkBWooYTMLXI63Qv08UfL3Fz+jWJt/EyfBbbVdi4Fj8DRf
	3VjfkQJ5/WJzZF3o5njfb7kJcZLMlhSpAYf+Qt+1dEk3q6WGA==
X-Received: by 2002:a05:600c:4695:b0:499:726a:117c with SMTP id 5b1f17b1804b1-49978494f70mr24088285e9.19.1786440547839;
        Tue, 11 Aug 2026 02:29:07 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997402a89bsm56135735e9.0.2026.08.11.02.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v13 04/12] net: phylink: save phylink instance fwnode on phylink_create
Date: Tue, 11 Aug 2026 11:28:29 +0200
Message-ID: <20260811092843.673837-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811092843.673837-1-ansuelsmth@gmail.com>
References: <20260811092843.673837-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware node associated with the phylink instance might differ from
the device firmware node passed in phylink_config as such device can
reference the parent switch or other platform peripherals.

Some function might need to reference this firmware node after
phylink_create so add a dedicated fwnode entry in phylink internal struct
and save it on phylink_create().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b69050f22717..b9a5cd123775 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -44,6 +44,7 @@ struct phylink {
 	const struct phylink_mac_ops *mac_ops;
 	struct phylink_config *config;
 	struct phylink_pcs *pcs;
+	struct fwnode_handle *fwnode;
 	struct device *dev;
 	unsigned int old_link_state:1;
 
@@ -1993,6 +1994,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	INIT_LIST_HEAD(&pl->pcs_list);
 
 	pl->config = config;
+	pl->fwnode = fwnode_handle_get((struct fwnode_handle *)fwnode);
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
 		netif_carrier_off(pl->netdev);
@@ -2077,6 +2079,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 		pcs->phylink = NULL;
 	}
 free_pl:
+	fwnode_handle_put(pl->fwnode);
 	kfree(pl);
 	return ERR_PTR(ret);
 }
@@ -2107,6 +2110,8 @@ void phylink_destroy(struct phylink *pl)
 		list_del(&pcs->list);
 	}
 
+	fwnode_handle_put(pl->fwnode);
+
 	kfree(pl);
 }
 EXPORT_SYMBOL_GPL(phylink_destroy);
-- 
2.53.0


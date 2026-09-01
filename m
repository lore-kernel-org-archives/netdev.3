Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AC47208D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251428; cv=none; b=N0XwjolF+d6QmG5o7tjyie/47KTqxxwjhTJmQGfPe+srOn4TRUv3UExlwDa+rSiK8I4sRoIyJssI11rnJFZ3ZZw19I90JJ6jiC7INvi1cRtIhB0GvpKkFIRscCXjYONb2YJDBFAA7gcl/mKf22rn2iBBFR2CiwpHGS3RxDltUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251428; c=relaxed/simple;
	bh=QkfsO9iIXWwWqn2LLgm3fPfnrSGchfrNPnJ7yZr1hKw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anuNfEciaCEvgMMeSd1Y5RPb8zu1IhiZe7a6xQMtbIdUq5PY5AG+tv1VD4zQvRQ9004MQfCrDyPbgA/0Hh/JIcwcdKw6IIix12dl2mfRUdcMjmmxBrgz0OgEddrwMiZ9vV6b0G/ilnhCkmAso6sTr0Qjt9nZ4MroyyyK6MuXmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPP5AhIT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPP5AhIT"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so30796785e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788251424; x=1788856224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4Go8JUbpoOJsxHq3SuM6SXORIBsWItiVTBm2QkGFiCE=;
        b=BPP5AhITsB5ekQI+qVkeySJghnZ+NyqZ6+QcizNHbYn3ZpQL2jDnsyRoZfPeQfjq84
         /3B+oe+Qh/EcQYSS0ngjZyku61Rwu5lWm0uIYfVsm/idRicRTmZo/2RaRfKrYkI0OW9o
         okPxe+l4uDgjp8K0MxsIcsrhOD6jC0BoInSYsCVFDnuYgfFSUiAGNB2hfw+9GEUNHDxs
         tDEQ0czGOkC6t8SVnCzDHk35/65JPPZE6QA8zU1vk9mxwGGpWLdGPggsIWi5KZ2HwtOI
         U8DKRtUtlqTip7RojD9YqgmVND8df6TmVuKjUtUcRSljYBpduo/eZ/WRsaG12kgejNGn
         2ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788251424; x=1788856224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4Go8JUbpoOJsxHq3SuM6SXORIBsWItiVTBm2QkGFiCE=;
        b=ZvzCYvN8MBl+Wae+k7/Ge4gO9C2qaHfAYdKQTJ2IsfWRf7NEo3+bVReKnQFUXSAyX9
         5Uc+4mbxAkoqAEGDoX6e6yyX6JHNgqgmRyy/+lJkUf7cuL/J5ycDwoWfV7nylk/1gaMG
         pWXd8O6R+/RuEtC00FNIBnxcSEUxGvURJu4zAOm+Fsav0PQKnG80TUTXP2aMEQY9VWsy
         2sk/aMBc4AgQnWIStaOxGEpuJ+nh2EUY7qncErqO5srRVqyE6HwDlKF1aT8hXJRnl7uZ
         cmidTerI8fbiaVsIPziaTSrYLTeCkpoUl1dU9a6EQzHg6CDbXj7AuQnSeFclmyswqFjG
         uz+g==
X-Forwarded-Encrypted: i=1; AHgh+RoVSBGhYsUvWgwDoO3FXQIJwHuankP5jHEfWn8vwTReemw5tWvUqV3MzpbKmJzhiQbHtkfvUcA=@vger.kernel.org
X-Gm-Message-State: AFuF++kAzT2st//+NNYyostnRUvBj6MipdpcwQx+YWu3VPRGHtdKR4xa
	UzcGcQ9AtanTJscglLAB0ZuxVhkKjN5ApqEAcAzvOGjxWE8pBhuXJ2rY
X-Gm-Gg: AR+sD12qG4htygV4s+eUpHISDZSV71CvklnNrvUNUnlqd8I9Qqwd6zVkGdShBgTuRjZ
	FnhMDGqlJA+sqGtM35NkmrEiBSNCb0xEoI40n+ehnF4+5Thjs5ZyklrFIYWHn/Gk0FbN4xvId7J
	hWk2Qj11vnRGEeVA1hrDttp8kcs00iPTO9tkQmw4p4Ip1nm530lmW04YlnaxWjqbK5vt32sM3Q2
	RGUrKQ1+79Avqt/qEbXfK3XZ6EizXaoVI2aHRB6HLBIanLp5f9MQW1z+h0VXL00TI6+T9tuDfzG
	rm2UW9bOHdJ+zy1aFM251obJ17f7lTUarBBem5UFoCMG5ZnGu9D8mDoaEFYDOsfSferHa2Glyo7
	TmE5ua4ebl6FoHQjSWyesnR9iR0Bfd8iwpSSUXitx3ybkr9a7jWFJjvUSZg2E3NsB6PA3SybuAn
	gKx9tuWDHDMDmhG8/ebNlB4OSMfAe/PUbOoaPkqzQlxeDRbkRlfmNFUMdmOBoaeCtenO+H6x2bl
	U5CSHkce7HUO/hqD+ZXx5A/GH7z30DUSmh4QPr9RxC1b9e1KbNN
X-Received: by 2002:a05:600c:4453:b0:499:8777:ccba with SMTP id 5b1f17b1804b1-49b91c486abmr438008405e9.12.1788251423887;
        Tue, 01 Sep 2026 01:30:23 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49cdce08862sm51459635e9.1.2026.09.01.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:30:23 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH net-next v15 04/12] net: phylink: save phylink instance fwnode on phylink_create
Date: Tue,  1 Sep 2026 10:29:19 +0200
Message-ID: <20260901083001.8044-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901083001.8044-1-ansuelsmth@gmail.com>
References: <20260901083001.8044-1-ansuelsmth@gmail.com>
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
index d7391a60f01f..96f72eb5a6fa 100644
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


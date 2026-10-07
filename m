Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24305269D18;
	Wed,  7 Oct 2026 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791342937; cv=pass; b=BrLRMPXFCtaqDKvboFsWzjKuo+HF0Qp6iailE75hTujzgzJLvS0b8WmRfvgvR2lgMnar64IoxdfFET3ymnZYP5KNYFNO11u57T2TOsRi7wzT6Fy6N+R3cdhl4ApnjX5GxivbbyAk0C+B9fEZmW2f4pOQE7kbNsPWsqmxRzZk5XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791342937; c=relaxed/simple;
	bh=q7D7WpDCbImKpQqxBSUIOAhLbxXZB3RnxB+GWCOduKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlAdzar6zrzxsoNlK46c0hkldFmRMAicHywlKE2YP4gBjGWs5Mc5hmQjxsqN1Y/v65FrQPa+1I0iTlPiXQbCJ/SizW3WwrTjQy7vnUdAjsBb0PfXTPWCtyS27W2BGZq5mNh45ECDgneFDH7+8374C1Jur7tAZaj73wU+WgPs5S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=Twb77/tv; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="Twb77/tv"
ARC-Seal: i=1; a=rsa-sha256; t=1791342923; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hV8ENv8285mWR0PF4esA5UgGQR0g3NiEG9H3orQCFCYv0//BUU7tclp8dxdVnAh9hyrPJohouZXGd4ae0vA6nbr6IgK71idAP4MTnIHW2QKmw5Y9TypEfmo3hmc6ukfgLsJYuCnqz1xEaDoR4Q51MlRas5aTamkmb6pqeo+6qkA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791342923; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q7D7WpDCbImKpQqxBSUIOAhLbxXZB3RnxB+GWCOduKE=; 
	b=YPn/zHusY9U/WOxwqIojAXyHVbvaSZrrPVog7r97kj2XvVIPuD1pfqh5ROLWYKAsbI4QbFYrGnW4pNkxMON9BIXRLS0en4inWXDrV6vrny8PB75/pG6hObolzb2nbEPhCAQpg2kEbxtWOSk3RV4UHbv+r+i9zwLdTia+jbcgD3M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791342923;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=q7D7WpDCbImKpQqxBSUIOAhLbxXZB3RnxB+GWCOduKE=;
	b=Twb77/tvv2BVhZGrrCMq6ZAYGcxAgGd9l/wTvAHR+z10tmbo5aCNaBTV/UIIz7Bl
	3CiNfc2l1wPfBj5l24fQGz4MpADmncHZh3bTjYooYOhZnZcElMSesFi96kWcXaZ89Bx
	2TKcfsg921ojhZNaiVcFXZsCePJulYf+YVy90r8g=
Received: by smtp.zoho.eu with SMTPS id 1791342921326482.96938224495386;
	Wed, 7 Oct 2026 05:15:21 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: netdev-bot+sashiko@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: mask the MAC interrupt while resume resets the MAC
Date: Wed,  7 Oct 2026 06:15:19 +0300
Message-ID: <20261007031520.3183462-1-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179126208779.434549.13501536895517522673@kernel.org>
References: <20261002043558.1302590-1-iav@iav.lv> <179126208779.434549.13501536895517522673@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All three are right. v3 disables the line only around stmmac_hw_setup(),
under rtnl_lock() and priv->lock: the reset task takes rtnl too, so it
cannot run between the disable and the enable, and no sharer is held off
through rtnl or the glue resume. If stmmac_hw_setup() fails, v3 masks the
core interrupts before enabling the line. A GMAC_INT_MASK dump on
Helios64 (dwmac-rk) and ODROID-HC4 (dwmac-meson8b) showed the glue resume
leaves the mask intact, so the narrow window is enough there.

pw-bot: cr

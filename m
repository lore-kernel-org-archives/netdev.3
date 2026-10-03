Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BF2F260C;
	Sat,  3 Oct 2026 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059748; cv=pass; b=FJFTzk8ANdFpXunLFNzP/s96Cy0ERPkUZ0PC0OKnVHgUgazrYhfAbzs9FM6oiiQfzRliZJRUx/OuvjEQaCsX3fG2kWu3EOGBmJ99QZlLjIB8ThgkCvC3W3nw9e/FKtHEX2VYPUA8bb3O9ZZ7z0dXN92zq6e0kdO7ZCIdxhm0gzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059748; c=relaxed/simple;
	bh=GiCgBUtgy+E5D7f673fbwf2jKfppEXPOAp8LyoaOecA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxaxVWkFS9YCTFPWTw4uNUa6ovH2/jAqvIpf1AIf01CIst7Atv4rK9AQwdWvWmMKEtralxfeem5dnqlW3V1siNVuFbiGBwpItL7UjICULQ34kDQaLz1yvw0R70eSoaPJlt7hs6CamEYXqxT6OEAXkctVNREB2aAksiKP7Hjsci4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=YsDuOndV; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="YsDuOndV"
ARC-Seal: i=1; a=rsa-sha256; t=1791059717; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PCNYxd8HGbJRCVSIgdCcSI9+lzgSJl13n1bJ0/D1O+kVZLm+g0G7ry09fbUMDtUQzyfc3JhU4CG6Lm5XuRIq+wlaO6u40iwkgOlE1aJdG5pSDBSe6z8OMYp21qDIdXYbCg2IMAqvv2FtqVZwRB/cyXPj+LQXlp6opGSoZ+FcMmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791059717; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GiCgBUtgy+E5D7f673fbwf2jKfppEXPOAp8LyoaOecA=; 
	b=i3W9kmuVs6OO1CuISoAiCxDIYNFZXbT9sJGTd0GlBua7PChO8jz3xERKFP4cI35jBPnsleehqit3sc9NJZJqFm9FkqSvMb1uMU3NrFxL/RFgXacYd3/E5k3RKZjX2qat0YGmrvGZ827Z3tYVOgEaKmyUj9AZfrotvVJUPVuz2x8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791059717;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GiCgBUtgy+E5D7f673fbwf2jKfppEXPOAp8LyoaOecA=;
	b=YsDuOndVzH3E18i2CITMdo4mv+n/IffWTZYbwOIngM/1RGhJkN+uQrpJCP8fqwA8
	OuiGCz1TN7EbwSi53jqx/1qzc98TD7IjgQcUYtG6QVaWZVBBJNUd4IfQXS8pRKRuP3e
	O1KQRNwbbvA0RvecXdTu2e+zZS7AYvoNPYuoMDzs=
Received: by smtp.zoho.eu with SMTPS id 1791059716369342.6028882372773;
	Sat, 3 Oct 2026 22:35:16 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Date: Sat, 03 Oct 2026 23:35:09 +0300
Message-ID: <20261003233509.cc-rafael.257220@iav.lv>
In-Reply-To: <20261002043548.1302145-1-iav@iav.lv>
References: <20261002043548.1302145-1-iav@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding Rafael, who acked 1758bde2e4aa from the Fixes: tag; I missed him in Cc.

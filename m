Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93334E3259;
	Fri,  2 Oct 2026 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961928; cv=pass; b=qYdyiLfLYRMiZ+zKbN1NUchpOG98K+F18ry/DxldO/Mc7+S+oGaOOtv0VGLx7KTBCzLKVsF9AhGzxOsE6d/p3XwAz4bo/o7p3rdgSe/e0Q7YI/JnREtlswQC1iLkLfzl+cRdp3OUMbwNTEDLgNV+qTe+kRFErXOGE2mvoGw3Lgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961928; c=relaxed/simple;
	bh=S/V6mHmp95Pew1JPsVwzbDdGIlnmgUUSr8a4ChnIOFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJQ+eMEa//OONOHUC3jObsgojTxGj8mmd61Czp0Ujs0u27LNte3OZ4fWxhiU1cNoJh13s9ePOjsN6fgbuNp5GXF6epf8BbzIoN6UtMfNK/jpajug8xj+zyi06GDe0FhHoDTyXIW4Yxujy2vJhR44i6Ea7C0ql2wk3Vk8bmklvtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=Fk/Ox3Oh; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="Fk/Ox3Oh"
ARC-Seal: i=1; a=rsa-sha256; t=1790961901; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Y2xcMUfPg3sgY5z6IGZd6olrC0iznrzDNv7C1536rA1QoP/4bkx7wbEWUNdytdYtxAGkpmQk8zmUtkgvi7r3ytryqfyPkthUPrRx3/+VzwRrajoR91WMMvlOUJtv7hsdjnEfxNFRzKFfigfdWmgslXTTGZCvlH6DAgF2C0BYoJM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1790961901; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZvFYpHruR5l36T2T4B3+C6Dn0tBYh7BsYEg7s8cKIek=; 
	b=cnxXqhmDABd8+Cd/xKpTHOWM5BMnrKYxC26HX9W49SJKIus3UsEHGI9VMn2QrzEtiO6Q1WtBtHHRuweSSUQyGYmuCNgTu3su+9o4jqN+VKragDtm1n+dwt+5ve/EsnsiRBC5NVgLlTz9T55SgFsH/xEBRGL5/Q2XKgLngmL5RT0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790961901;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZvFYpHruR5l36T2T4B3+C6Dn0tBYh7BsYEg7s8cKIek=;
	b=Fk/Ox3OhH88+tRnQLkAiYvatM5qB0Z57tnhSstGJX3X/1ir3kWwgy0rnNsIWyakE
	nkCfnfMKujnwjvpq6pKoJTbOPtuChjm5G3DQdG39dkHYCwDfHJ9GzenfjfOnDFsjEli
	2s3tJZXMyDx9D/DTj4NfmeiUd+fHMSyooqc30dDw=
Received: by smtp.zoho.eu with SMTPS id 1790961899502973.5896102991785;
	Fri, 2 Oct 2026 19:24:59 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: mask the MAC interrupt while resume resets the MAC
Date: Fri,  2 Oct 2026 20:24:57 +0300
Message-ID: <20261002172457.1717818-1-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002043558.1302590-1-iav@iav.lv>
References: <20261002043558.1302590-1-iav@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This conflicts with net-next commit 8181678a92f0 ("net: stmmac:
propagate PTP init failures in __stmmac_open() and stmmac_resume()").
The success path has to jump to out:, or the MAC IRQ stays disabled
after every resume and the build does not catch it. Resolution, built
with W=1 on net-next 071876fd5048:

diff --cc drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0c381ae0d0ff,b275b6234b55..000000000000
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@@ -8467,15 -8403,10 +8477,19 @@@ init_coalesce
  
  	netif_device_attach(ndev);
  
- 	return 0;
+ 	ret = 0;
++	goto out;
 +
 +error_stop_dma:
 +	stmmac_stop_all_dma(priv);
 +	stmmac_mac_set(priv, priv->ioaddr, false);
 +error_unlock:
 +	stmmac_legacy_serdes_power_down(priv);
 +	mutex_unlock(&priv->lock);
 +	rtnl_unlock();
+ out:
+ 	if (irq_off)
+ 		enable_irq(ndev->irq);
  
  	return ret;
  }

+Cc Lorenzo.

--
Igor Velkov

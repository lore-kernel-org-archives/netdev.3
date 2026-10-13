Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0FB4499B3;
	Tue, 13 Oct 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885641; cv=none; b=CWgofwO1zOb/rCarB50Mt9oNoaM5ULkGshIGNGBPq59hRLVcTVC/wZFgsNr0u/g3rQjaqkD8F+Oc/q6BXcWVcCsJVZ62s2iqyXhtJyKHBONopvp61jD7DzUkyM1i+/nDWQIIeVBkPKUDmKeUSPPQEkQRYJPGKq17QdOKvUlCpQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885641; c=relaxed/simple;
	bh=Orzo4DJcYYI2spnkXpXjRTTyvi0UlI3KeBa1yFjlz6o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8KfIcECeSC5GDpLkfqvFigq79SpMyEFo1qPyzRThT9cXd9EpsRdl9+GsWftrdKs2tr6XayrU3oic1PZG3t2YTbE/af0Hfa/OwaccCmj57IGqsQuKlc4K3oE9PBjtKRCjagigFuL7Lj9T0TzIGlYRHIrLEVJ/spWKkqZL9QRlhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ckMEhlUs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ckMEhlUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791885640; x=1823421640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Orzo4DJcYYI2spnkXpXjRTTyvi0UlI3KeBa1yFjlz6o=;
  b=ckMEhlUsYuGNnHMWo+wcAy/7p01s2xmxJ0KUiq3iCiJ9DWl/S5Yk1jiG
   3fIxd6rL0ZBaoJNYgPtvdZloq6Sp/rYb/x/RpdEQsbMY5xO9Rje0xhQwX
   aYee5KOgpO5qnRLftJL39zbCImXg3HdcNjjsH8Y8qrNwexjxdzr54ZXbT
   guA8fF6qkWcM/mfDEWLpyXK2+abJe7uI+dVUU80geCCrSAWedvmf1jz0f
   NcCq3B5/FnZLsAra9T5si97jJa/gSf7PUxQuMnqchnDoW1ih4qBw9t+Tq
   7/LgDt3ifgp2ETbW2tSgc+vtpAK4CPP8FZr7YESraEdHTS7W4jPHnJPnk
   Q==;
X-CSE-ConnectionGUID: vyBioCqxSrC8sgW/zGtOTg==
X-CSE-MsgGUID: IAXSG8jWS5mLAUqtaGbmvA==
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="296366019"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:00:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 03:00:36 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 03:00:34 -0700
Date: Tue, 13 Oct 2026 12:00:34 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: David Yang <mmyangfl@gmail.com>
CC: <netdev@vger.kernel.org>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Nicolai Buchwitz <nb@tipi-net.de>, Jacob Keller
	<jacob.e.keller@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 05/10] net: mv643xx: move setting of netops to fix
 crash
Message-ID: <20261013100034.hjhj2kuzglpgsgi5@DEN-DL-M70577.microsemi.net>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-6-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008022656.3592191-6-mmyangfl@gmail.com>

> mv643xx_eth_probe() connects the PHY before dev->netdev_ops is
> assigned. phy_attach_direct() -> phy_link_topo_add_phy() reads
> dev->netdev_ops through netdev_need_ops_lock() since the commit in
> question, so probing crashes with a NULL pointer dereference when
> CONFIG_NET_SHAPER is enabled.
> 
> Assign netdev_ops before the PHY attach, as was done for emac in commit
> 7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

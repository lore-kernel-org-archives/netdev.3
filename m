Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958117;
	b=0KVOXFOkrUqSzdJ8WgAluyz8lsUUay3RGD+EEjhz2VuzbgsAbX8vzoOKQ4cl0jKWOzgL
	 sdMcoPhvesGpxUNmX/QHwOIyUT+dexQnahutEYt1BHZW+0lm39UpinvdYfqO6zyPmd+Si
	 p5MzFpke4PpulDmOvgeyHtMyJjEjH++cxdaqfOc48sQwzSy0R8BfpyBJd6bf0TboS9I49
	 goqT7HHnlvUeGNMPg6u2IQx2JHCzZSshettV6eFKRRf14FGkTyUFTpMkVB1J9K3OzvTvj
	 MXExWb2zzD7CbV8Rzgn/HfDlQTN+zkolZ4prH919iIy5ganKFuK1sjD3QDB+aVcXNLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958117;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lCawnOJcbgzt1rN15dF55jHmS46Dvgon9dL0FUuEV6Y=;
	b=qKIMXM1Fu8h97pNyVbEhTD9V6cThbFE7c8oGzN/7Pxbf/jeZm/BOUDTMwqMg0S0cHBn4
	 RnI3hbTUF45IHlNG1zsvfk2Y9RBEie/gqz2yDk/i9Cvdva2FaHaYcdWhVbxE9SxWxXahL
	 g9q6cb7bTyhzQPPqQHSTYFI59DICmodsgOXSyDyT7wS0c7sR/FY/zi6HMEwE31mJPY+KY
	 dhzDZyCP0n7yy74IXpeufWp42muXafuajRwyhGelwBmSflIyi+oqMIFilQYUKw/T5TzGw
	 Io/J4me5+V+g9eU61hM3Rba+3AN261b+FJBH1iQlbtn6Q1RFXtyrVTlimFc6RmAyGIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=GDijFx2F;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E0606D60D;
	Fri,  6 Nov 2026 09:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 928E0606D60D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=GDijFx2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793958116; x=1825494116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jf5yfpH0QjsX/QOuGrJE+o+MKRjT1wDvEtcENC9kCDE=;
  b=GDijFx2FsxAsZNZy00ZyN7abhWIb2RyiLW+fhReQS5UxOpMhZdKKtlUp
   ZWbtXQbfb1ek5vC8C1DaGgPAtVmoIxnhA70PB9WT1XeiGHtKfU/B/xnNA
   ecO1qljDLWWlK9B81xASSHz9rsIn7iuKfYYJZsMvHQr+vx3WpmD2hiGCj
   wx9pc/H4yVr8sRJQUSeajtRQD/Vie+RMovt/VfD/dyCZqPFuBrQCVpvNy
   aKTaeaiNv4JaK8kcS4LUk8VXGJkLSLRsDld95MqKTwK1xzM5f8Cho6ALZ
   zZY4hTwTUnUkyvAjfD3XiZRmzi+xSx9heP/T6gpdWbo5cP3imMI3gOB55
   A==;
X-CSE-ConnectionGUID: LjBg6mXqSA2/dE5dOY3tag==
X-CSE-MsgGUID: jowz7dmVSQK9AbWQTDFWag==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="65162335"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2026 02:41:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 6 Nov 2026 02:41:55 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 6 Nov 2026 02:41:53 -0700
Date: Fri, 6 Nov 2026 10:41:52 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>, <macro@orcam.me.uk>
Subject: Re: [PATCH net-next 3/3] net: sb1250-mac: Add ethtool
 autonegotiation restart support
Message-ID: <20261106094152.k7jdxnwtsvoa6uys@DEN-DL-M70577>
References: <20261105193435.2050321-1-f.fainelli@gmail.com>
 <20261105193435.2050321-4-f.fainelli@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261105193435.2050321-4-f.fainelli@gmail.com>

> Wire up the nway_reset callback to phy_ethtool_nway_reset() so that
> ethtool -r can restart PHY autonegotiation. The phylib helper handles
> PHY locking and returns -ENODEV when the interface has no attached PHY.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

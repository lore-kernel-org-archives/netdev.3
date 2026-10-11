Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156335C681;
	Sun, 11 Oct 2026 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791708596; cv=none; b=CT5GYKudKMas883iwfHWdaa3K0g30xrlz+RInKxx0q+0UXm58num+zvEMRQ6xY9JNao0X2VxspqrYX4RHWcTU1UMjnmck3H/VLqptpYvuHKFJWBXCMox03tkEF/FXxR2ERhcgS1JxAIp4A2aGRzp5lQnGuuohjfUoXtryGghWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791708596; c=relaxed/simple;
	bh=fbdGQvIZTTJ+cGdICpGAjpYVrurxNjtVfB+sgKtUk18=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biVUx8EDSXFYZ28GdHGDMo53iRRKyW5/ygCquGLNaFhKleoTPPYJTPn+ZqYZo59P3a5pUq5ot1f/zoAWJvNrLx0QPKBYQeypU5LPZVGabXxpyK4hRpKo1G6CRmpSTBPRyWnpppTEEWAca7yO5Z661qxBHNJ+hG52CQUPXM4yJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S2J9IksP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S2J9IksP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791708601; x=1823244601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fbdGQvIZTTJ+cGdICpGAjpYVrurxNjtVfB+sgKtUk18=;
  b=S2J9IksPeBBRqpQEZFgwroiF3N6PUXDWBJVslwJ28f7UYCuQvGungq6b
   yGSt11njJo3qOPr9qF2VaZraaH6Fj5bFM+QpHeeMwWzd7BjhnTNVRO1mp
   yRo8VqHGeSVNaHJ9mC8Ccf7Oimw5v1pMHhHW5mwyULuhbnP5Tr9IaYQqr
   UR7So1b/jiuNChIZezLBk1jBFAfYQ35qamIuGxt+h2hcMR6mRHVAZz4kd
   T4YeYQcIXypCaVrTlpGhWtxdU93ZPMummWxUjPYAasjAM4tvNu/fE61GB
   lCDF8Hn+VTGvTQtn5ad15u+Pe5ugIRU6B9GH4enNEgxpkLE+90PJ4uMr+
   w==;
X-CSE-ConnectionGUID: /tE3cj15TaqruC9OfmkCVA==
X-CSE-MsgGUID: CYEBNaqUQJSDsAj5swi0Kg==
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="64863238"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2026 01:50:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 11 Oct 2026 01:49:54 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 11 Oct 2026 01:49:52 -0700
Date: Sun, 11 Oct 2026 10:49:51 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Stefano Munari <stefanomunari.sm@gmail.com>
CC: <netdev@vger.kernel.org>, Thangaraj Samynathan
	<Thangaraj.S@microchip.com>, <UNGLinuxDriver@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Nisar Sayed <Nisar.Sayed@microchip.com>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: usb: lan78xx: reject invalid EEPROM write
 requests
Message-ID: <20261011084951.kkf324me45fxlc74@DEN-DL-M70577.microsemi.net>
References: <20261010213248.15938-1-stefanomunari.sm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261010213248.15938-1-stefanomunari.sm@gmail.com>

> The runtime PM handling removed the -EINVAL return for invalid
> EEPROM/OTP write requests. These requests now return zero from a
> successful usb_autopm_get_interface() call, even though no data is
> written.
> 
> Set ret to -EINVAL for invalid requests while preserving the runtime
> PM reference release.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

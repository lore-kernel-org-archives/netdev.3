Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F973D3485
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833286; cv=none; b=MjPO2LbLyG5byVLiBVJc/mWksAm7KVV5QBob9hl/YBoGdKMbNVNm0dURVLiTrrnEjFZBASqUr7WdbShG1oITHkIrisnWcFO6tGiC1Pf7PHtHoQYXkxMKrwYsdQuqF+4JLMCNyEcdtHr/w4XNCf2DsrrNH7/dNNDGYPQGXaMf8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833286; c=relaxed/simple;
	bh=REt+6vRS275U9OKczJ7GB5OY81lns/DlV7W5J5RclUs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQMMOu/Tmqwf9Hc5KX/pXDPIc3lH6aJo+I7OmKh/8oyotdjpxzVmvQl/K72ziaCVfCFAD6hn/6/cpsyxNUuWy24euBL09yPNsmvk1i49DJpOaY2V7jKB5TY4I8bCvLogmBH6pFtAIedzH+tAGYYswU2hI9U8AYWcB8aE33BV91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YJA0/et/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YJA0/et/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784833278; x=1816369278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=REt+6vRS275U9OKczJ7GB5OY81lns/DlV7W5J5RclUs=;
  b=YJA0/et/gY/rTrjsr7A1ur8nMzAHv2+OsuhPX3Jc8ETtwYdlZzBh5VbQ
   JBaOoUMSdckpTclfnwPAlXBDcVuvKpiGEWw7gQtQFYd8+F6uJHvnXdSQv
   e8CDgRYGQT+XNemdw+G8nGaMv5w62mNNvfjCM9dtuoCklxMHMiIImmBPw
   FUcWiPJl6cIKBIilmgzBSEj/cfewU1+Cl2loEudCsxl9ytialQH0YxyDH
   Mppx098vDH31BHdLoXhV54OE+9YaauO41qIZfp9QsE26I0qI+oJeNNghi
   yUgE+pL9EJ2LP5DI5urtuM10HUUOBbPmRKg1sbjIwf0fC57LbZb5PivK2
   Q==;
X-CSE-ConnectionGUID: 7J4WhVY0S+eprd1yaluLJw==
X-CSE-MsgGUID: viGolIAuQd+2fZD6CzFfPQ==
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="60220299"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2026 12:01:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 23 Jul 2026 12:01:16 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 23 Jul 2026 12:01:16 -0700
Date: Thu, 23 Jul 2026 12:01:15 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
CC: <netdev@vger.kernel.org>, <theo.lebrun@bootlin.com>,
	<conor.dooley@microchip.com>, <charles.perry@microchip.com>, <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 0/2] net: macb: Updated patches for
 1000BASE-X support
Message-ID: <amJk+0Yew01OV6lz@bby-cbu-swbuild03.eng.microchip.com>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
 <20260721180158.13014-1-nwhitehorn@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260721180158.13014-1-nwhitehorn@pa.msu.edu>

On Tue, Jul 21, 2026 at 01:56:00PM -0400, Nathan Whitehorn wrote:
> This series adds support for 1000BASE-X autonegotiation to the Cadence macb driver
> when using the MAC-internal PCS. The existing driver code is oriented toward the PCS
> being used with an on-board SGMII PHY, so uses Cisco SGMII-style autonegotiation
> exclusively and does not anticipate e.g. link state changes arising from fiber
> attach/detach events. The first patch changes the driver to monitor the PCS's
> link; the second extends the existing SGMII autonegotiation code to also support
> 1000BASE-X autonegotiation.
> 

Your first version of the patch mentioned that this was tested on a
Polarfire SoC. This is some useful info that you can put in the cover
letter. I'd also be interested in knowing if you tested with a copper or
fiber SFP.

Also you shouldn't post newer versions of a patch set as a reply to the
previous version.

Thanks,
Charles

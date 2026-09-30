Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744F51C34D;
	Wed, 30 Sep 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793696; cv=none; b=cNv1g8k8fGklDy9vfwDtRGohEcgSiYbfGL+YBus2gQjlocUQkaBrmY+la9bttgjO0S1UPWeOu4D2Fj85heLMBsa04kPYFCWrjH+ChrTiFZFa9e5YJYIJbeweoXHPRJkti3rlB2NlWM+OV0qyt2N48aAM4GLDD81MegC4FiY55/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793696; c=relaxed/simple;
	bh=JPBLddgMUAgMoxbfEADil0cH8zquZgAGo3+9stQm6GM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY14nYMQyRZ02+U+qSfq93LuUZRlff84Dh9zPswyZoCKAPmdfHyVw4n/pDG+sOJw83DDVWOZkCeL+vbGbE6inZvfvqlYX4VbCxlqv0ZFdjZ4IdxDY494WZOFt7ftNm8/jengCPz6Ea0g/B1bdPu5BQYmXcQ3q+OVrLL7fSHoISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=l8J2WmdH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="l8J2WmdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790793694; x=1822329694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JPBLddgMUAgMoxbfEADil0cH8zquZgAGo3+9stQm6GM=;
  b=l8J2WmdHRFD6bpyomCpIqnxLvf25/z/VRMZgwtC7kTOROhHlY+G85vQg
   mCSd8pAH5NHsp4sRERW8Uem7M7bdu2mp5ClAqbNccKIi3wmXIK50dMb9m
   5J9UIs/0ZH8hZyzulYkFFtNaqYYI1RDagJgiIccwJAaA73BuA2rU3OBg9
   4t8YvWL4oe8xorj0zKpCWo8nJ+uRDSWfF2pMSBcR9etYmNtqpuC/6VLQR
   3NI9b8FGrV9LwNOjnEx/fl9ME6wA/FaJ8vRqCWIitpUuMAHM+85m1Noan
   FWkGxsMGc98k6V3CYPNjKCydq8Ywql9SeAwuq08UEPr35iCxIoLmmoaqQ
   A==;
X-CSE-ConnectionGUID: we0tvhQWR7CZPnkshB0Uyg==
X-CSE-MsgGUID: Qyq+JkDtRBiTTaFgpHGeVQ==
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="64681246"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 11:41:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 11:41:26 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 11:41:24 -0700
Date: Wed, 30 Sep 2026 20:41:23 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>, Nicolai
 Buchwitz <nb@tipi-net.de>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <workflows@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v2] docs: netdev: additional info requirements
 for bug fixes
Message-ID: <20260930184123.ix4saaidpo566oxf@DEN-DL-M70577>
References: <20260930163109.3910509-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930163109.3910509-1-kuba@kernel.org>

> Knowing how AI-generated patches were tested would be a great help
> when reviewing them. Explicitly ask people to describe the discovery
> and validation process they followed.
> 
> I posted this as an RFC a while back and there were some concerns
> from developers that it would gum up the process. With Linus's
> recent complaints about the size of our PRs, we really need
> this information. I launched an AI bot which complains if
> people don't explain how bugs were discovered and tested
> (look for netdev-bot+sinfo@kernel.org, s=series info).
> We need to document this requirement.
> 

Acked-by: Daniel Machon <daniel.machon@microchip.com>


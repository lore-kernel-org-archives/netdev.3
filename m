Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B23E3C5F;
	Fri, 25 Sep 2026 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333883; cv=none; b=XaZpu6NZNN63YRiLXmHURPm8du16pHazQ6PWCAJq/3TDKKK2jqhw3cVEKmgFgBYszQUFOvAjY/fXoahwhSoTvSQL6z1hRl8LOfhiWaYimS2qLXWVQq3ti+e3sZf8ECVtlRkGK8wQbShO/hQmIsx4TS7I+0TSUzZY8UetIw75aJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333883; c=relaxed/simple;
	bh=EsXuJvrag4cCZG26K0M6VMGyD+DGrBG97o19/JayE/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pnZSTU+x/pQ2LASk/ZOgaOxei/gYr57pQLqNZZ6N1G17fl0Q5wuM0T6rwSZjPbQF9mVDK+bcjJWcLFfanZ+YonUGqUW1a15X7Z8UYiK34Mffvo7xIyAXwQkh0EVwF2KhQM1DxmgZpSnGAJBOZAwG5PT9Z0IrBu9acQ1njAa9fPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JFAez4TZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JFAez4TZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790333882; x=1821869882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EsXuJvrag4cCZG26K0M6VMGyD+DGrBG97o19/JayE/Q=;
  b=JFAez4TZBbKFvtofkZqotBA9xoKE+ujKqDKeYlPfkOkB/J2R7ig+EQxR
   25ZP9la0fHo/yVcCbr9frbYlxPGx2ctKqoQ7/SFeawGp8t0CFoXBJ6cyk
   Fd5pa5l+1aNQbUcvKjGhKUfpP4mph+S+Y03N2H4baT3AKZE57PrR7XsEH
   kZXrS0m9+2akOApP9JbFqNS6g/Jwa3cV2suJ/8iyNnlLRK3PvL7tB8UWE
   Xu+ZkevQ3wfUUMbeF4+wDGfZhv0lHupTD+YVaeYLuZQD4VvE+11w2sjo+
   WkJCn2kpk8W2fkryRWshbSW1veql75iw4+ZppMT192ec72vhixYkpNypU
   Q==;
X-CSE-ConnectionGUID: cv1aykm7QqicWM6ReoVZkQ==
X-CSE-MsgGUID: YqmcZRtlSMyLZbYhcI80Rg==
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="64445385"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2026 03:58:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 25 Sep 2026 03:58:00 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 25 Sep 2026 03:57:57 -0700
Message-ID: <599985f5-219c-4158-b547-5b9c01ade449@microchip.com>
Date: Fri, 25 Sep 2026 16:27:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/4] net: microchip_t1s: fix collision
 detection on PLCA status change
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
References: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
 <20260924083355.5e839290@kernel.org>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <20260924083355.5e839290@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 24/09/26 9:03 pm, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 18 Sep 2026 20:02:58 +0530 Parthiban Veerasooran wrote:
>> In a 10BASE-T1S multidrop network, the PHY autonomously transitions
>> between PLCA mode and CSMA/CD mode based on BEACON availability. The
>> existing collision detection logic only adjusted on explicit ethtool
>> PLCA changes, leaving it in the wrong state across these autonomous
>> transitions.
> 
> I'm going to assume at least one of the High or Medium severity
> findings is correct, please respond to the AI feedback in timely
> fashion, even if it's just to agree / tell us that v4 is coming.

Apologies for the delay. I had a quick look through the AI review 
feedback across all the patches, and it appears that some of the 
findings are valid and need to be addressed.

I am currently going through each comment and working on the necessary 
fixes. I will address all the valid review comments in v4 and submit the 
updated version as soon as possible.

Thank you for your patience.

Best regards,
Parthiban V> --
> pw-bot: cr


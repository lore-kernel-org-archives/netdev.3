Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA553806C5
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846165; cv=none; b=tGR0MQfXBuyAfVhp1ziV4pqPl/oy7+6o6/rdE9ARWvbZiFgrP5e3mayFuLWmF9iCFTqsBMTUZrPzO1JDgHnmMBV5DQrV2VBKWzhXL+KH08BKtynjKOIEibL9nL5o4Ar/jtAYeYxQ00BCY8Si4fDcKBRb3qaFH9CvTdjVXbZMJNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846165; c=relaxed/simple;
	bh=HDdc361YZptc9J7r0dmK4ZJDtCMMqGTHwIekVcaLbXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTWBU4CJhDzOLbkNgkqsOE0V4LxCMAkBOVU/TM0K2kP4Te/P91cevVBKNVtFjfTwPV5KElM6P2stHSX8rgOCvyPXEbpwJ3ureYWi1fD46jmi15AbrFbDRmV0TEu5W9gW5KiOkvcA79Daa99vDNOtmtysavdvolHme6pK6swCDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOfd3drQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOfd3drQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1C61F000E9;
	Thu, 27 Aug 2026 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846164;
	bh=F1dskDq3YlfPUTs7ZBROt0XFP+E3XiVYxZsEvgT9oZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jOfd3drQ5PBY8tSHtB1/izAzUxw9nBElKnaXqF9PLLsuL7DDFwzYw+BTCLpUX5rys
	 PjFFvpYNgVycjq4YFrqykFgdglsOlOZF4lTnnr5thKqnY0bwQTTuBo99fX29xNz7qh
	 y325KdtceIcibBi8tGrhXj43oD5plYUpdQUmJKk3Ue9X8Q/ioPOX403G/Sm9mz3M9V
	 gOboBSOlCuLxaLE1hhu4562BAdHhQyjLxZqDNbYdLzMJ/1m/OB4uVAyybEfJCrxyg+
	 ye+LlJDnJBrfUQMIrWMPkxPtMdHAAC+k1gJGPmqCVdyhvlZpCsxtaG/wTEPVmTRo04
	 4Xg93L/d+KB8g==
Date: Thu, 27 Aug 2026 08:56:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: manushprajwal <manushprajwal555@gmail.com>
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] net: thunder_bgx: fix fwnode leak in
 bgx_init_of_phy()
Message-ID: <20260827085603.2d37835f@kernel.org>
In-Reply-To: <20260823111231.372-1-manushprajwal555@gmail.com>
References: <20260823111231.372-1-manushprajwal555@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 16:42:31 +0530 manushprajwal wrote:
> Subject: [PATCH 1/2] net: thunder_bgx: fix fwnode leak in bgx_init_of_phy()

We never saw patch 2/2, you need to repost it as standalone or send
both to netdev.
-- 
pw-bot: cr

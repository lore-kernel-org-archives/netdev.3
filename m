Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C0303A32
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160441; cv=none; b=lZrIzycL4rX9CLRtVRrMMK/WWC1wKubETiy4o3deSd1OF1KcByC5VciYMvITSZ5nOO5sbW9EAeTzss/mwu7i06LYHLtvTqV8PwFVqJFhx+rAvUVwjxxIxqSoCZO/0gCBdKSkwFeQDBZYnqW1Tw/iZMV3tmSleHL1Lrp0B2+8OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160441; c=relaxed/simple;
	bh=pnozHAu5um8aElu5YBlscoAHncbZsDdf4Y/7avuRxAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdACAgtVdc2YTzN58Audw6WGnZOBjZ4Rnha2NgxYSCy7x37i2AU2S2CZMoQLeJIz7acB6H+CRxyUVhNGOz67Hvb3u76KOBtoRB+9vLldWoNwmP+79G4KmyKgkQ/BW0xwEF+TSMRlTRIbxIZlfBIEsD53gvRwZz+akfXahZYPCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FJFzLqgJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FJFzLqgJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9d7QB9xDc8rz/bPiIbkfq7vPbbB2ty+zoX6QKTewx0U=; b=FJFzLqgJAapQ8COdDXY8kcyFnP
	1/DCKPIWKKncvBPWsMRf7jRyoEjoseqBJNyZz0GtpKCEO5GWHlwK3VpFLpmw7bBgQShXWbrMDfwV+
	nKJiy6VQ5XxR78qgJOG69unvNm5ZZRCuOs3c2gmcMrsTDpqiwpM7kWf7NJwrboTVnJ8Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKyA3-001oRL-Nn; Thu, 07 May 2026 14:49:03 +0200
Date: Thu, 7 May 2026 14:49:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Message-ID: <9a25bf08-9c13-49de-b15d-dc8ae464bdfd@lunn.ch>
References: <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <7778cd41-cf36-4524-a347-408a8fb0bde0@lunn.ch>
 <f9b8840d-94ba-4bde-9ace-fb81eb733ff9@bootlin.com>
 <eba96f21-78e6-42bf-938a-6d4037d0a305@lunn.ch>
 <BEZP281MB22457317618130F28E84E3B4D93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <24815161-68ff-4f3e-b0e1-286871b9686a@lunn.ch>
 <BEZP281MB2245BB0FC7DA18B285BD564CD93C2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEZP281MB2245BB0FC7DA18B285BD564CD93C2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>

> I think it is worth doing a patch on this also?
> I am not that experienced in sending kernel patches but I could try...

Please try, and i will help you.

A good place to start is:

https://docs.kernel.org/process/submitting-patches.html

and

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

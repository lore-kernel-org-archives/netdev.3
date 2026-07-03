Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79C3C1F5E
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086096; cv=none; b=ux0yvSNEJJ7+T6fbFwemcbcPc7uznn7ijaIznAEoNzAHvoR6JKW2N0lulxS4jeC9jkyCI2w0Fo98+INhtf23QXUQ6xKeP9Bgj+2158prVKt6H+NQW8HmqOMn8ssaq5aB64xQXqVSWvwUyqh4vyKlou1Mvdy/5zkWt7KRwaeyb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086096; c=relaxed/simple;
	bh=JwtuV1N0wOol4eHLHsUAzHqiB8pAkCLqE8Mqcp8fHEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JobZ3XMzn8cHMxwcReFVlcAJVXb16Pagx0Mv6eHLzqDjQ1GJFkTtgwb/B1IBgqUx+VyVvh3KXY+47QSVlKTiGYq1aL6JtfrZ6pFEmqd2/NYomu2ee04r0AiLkzBuK3D2xq+XqF1AHLk4Iz1dgcwdj6YoSSQwpG7MB2b2WoyjLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v+ILzM0u; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v+ILzM0u"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9753BC49F56;
	Fri,  3 Jul 2026 13:41:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A582660300;
	Fri,  3 Jul 2026 13:41:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EB31104C9464;
	Fri,  3 Jul 2026 15:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783086092; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=t7WM5o1v2RpROf710V6fmGLpZwc2P9aBh6psKVNOfVo=;
	b=v+ILzM0u6OnYr8mGnLJ+VP81JS8KguaBP1Lj3D3pwfMn+uHoO4n3oV7m1puDT5T/0PSZO5
	WvyRA3635ccQQnmn6AEOUGxJ8onPu30EPpSgnsaQdMhXpl0PjEYDIhtFYRV1Qol87GuahJ
	CZT8R5QjvSdUqLbf2mchDWPMMoCEG65HBWp2Icqp28u1KBgwZWS66mLUsj9GTcBe+/z9yV
	BpaWnuY9F3/Ap00sugmX0+v///JeGlqjQbdfPi5OTtiCPl7HgmQ/27Gb42F+CFYX7+3oF4
	LrGE0dbNF645KnIqmSeFMEm011DiB3V7LwPIJT7Tp1Yf20uNu0JO7zSP6rJe8g==
Message-ID: <ab448209-a9df-49f0-a685-db76db03608d@bootlin.com>
Date: Fri, 3 Jul 2026 15:41:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ethtool] man: ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
To: Siddaraju DH <siddaraju.dh@intel.com>, Michal Kubecek <mkubecek@suse.cz>,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Cc: Shubham Das <Shubham.Das@intel.com>,
 Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
 Vijay Srinivasan <vijay.srinivasan@intel.com>,
 Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
 Niklas Damberg <niklas.damberg@ericsson.com>,
 Jonas Wirandi <jonas.wirandi@ericsson.com>,
 Siddaraju DH <siddarajudh@gmail.com>
References: <20260703102004.1111597-1-siddaraju.dh@intel.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260703102004.1111597-1-siddaraju.dh@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/3/26 12:20, Siddaraju DH wrote:
> Annotate the 10000baseCR entry in the advertise mask table so users
> understand what physical media this mode it actually represents.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.
> 
> Link: https://lore.kernel.org/r/SN7PR11MB69003D33489DB1D6B17EF72A9AF52@SN7PR11MB6900.namprd11.prod.outlook.com
> 
> Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>

Looks like you're missing Andrew's review tag :(

Maxime


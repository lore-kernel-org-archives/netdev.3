Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF047CA6D
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202432; cv=none; b=fMD14tlThhhJfsXA6UiMmnpVjhYMFV3A5ct1UIZXmZhv0JjYHRyZS+x0yJyPCrciDXAQwUmjyKR2LyPfkHK6l+v+7y0cHe2i/qTgkfYJMzQwSuOz7dTNZZAxZkXcSy57Yoy4OqtzhOS8p5q/DNHlHKwW6WgBE0I1Bd6jLmy2dcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202432; c=relaxed/simple;
	bh=OTIsihwJh/wzB/P/Iqrg/6NXagb1SJ69Aw4dFCYb9AY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=r4vBJhQu2X3RT2xVXElFdvoQtZ+gIU6xHBhPFXcP4uCFkUrqvWKFKGbOE/aydV2hW4BqbQcc1uPIqTRa8G7dpgnujyUgkURKPW7qqojj3up42DQKJPuIR71yWxdWNADh+KgHJwem/RpPvlZTuogWOeHwMwI7V+6rIObjQze5wNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TuiU0ram; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TuiU0ram"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261005121348euoutp012ce7722a32f6d4788bc8e7f8d959eb69~boR5Fst-V1153911539euoutp01b
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:13:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261005121348euoutp012ce7722a32f6d4788bc8e7f8d959eb69~boR5Fst-V1153911539euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791202428;
	bh=5N0rAphdQXhDeG2zN0j4OieVC6GDsi8gQbUz5rLVie4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TuiU0ram3YbY8naFnqfZKQbJfMuevcAcyMYEKyKNdhlBv8uSnCVjUy6/PyrjduNq+
	 wgdRMXIgKzXkC+ttW4jto42/xRGU7rOXwL9vtzQHjAKijd4iwc2+a67PMlBXqfh9uE
	 CnWQDyrC7tWfNjEk3F0U1hROf2v7wBX+7EGD75E4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261005121347eucas1p29ebae14955b2b55cc73f268a624a87f0~boR4abyA70900509005eucas1p2J;
	Mon,  5 Oct 2026 12:13:47 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261005121346eusmtip2fa11e9da7308eaff681eeb34682f9a23~boR3ssy-E0502805028eusmtip2V;
	Mon,  5 Oct 2026 12:13:46 +0000 (GMT)
Date: Mon, 5 Oct 2026 14:13:43 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org, k.domagalski@samsung.com,
	k.tegowski@samsung.com, cs0617.lee@samsung.com, Abhishek Chauhan
	<abhishek.chauhan@oss.qualcomm.com>, maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v2 2/3] net/stmmac/dwxgmac: Extend MTL/DMA
 support to 16 queues
Message-ID: <asOUd4j4VWS2Svla@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1d814431-c01d-4730-ac22-c41f47f93b0e@oss.qualcomm.com>
X-CMS-MailID: 20261005121347eucas1p29ebae14955b2b55cc73f268a624a87f0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----6Yzir0.DT2R1UiBbNh0_rPWXcRyD2CU8yss_stBlwropLZCy=_112415_"
X-RootMTR: 20260601162618eucas1p14be36902c4948647448160da08aaebc5
X-EPHeader: CA
X-CMS-RootMailID: 20260601162618eucas1p14be36902c4948647448160da08aaebc5
References: <20260601162537.553512-1-j.raczynski@samsung.com>
	<CGME20260601162618eucas1p14be36902c4948647448160da08aaebc5@eucas1p1.samsung.com>
	<20260601162537.553512-3-j.raczynski@samsung.com>
	<1d814431-c01d-4730-ac22-c41f47f93b0e@oss.qualcomm.com>

------6Yzir0.DT2R1UiBbNh0_rPWXcRyD2CU8yss_stBlwropLZCy=_112415_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Oct 02, 2026 at 11:40:19AM -0700, Sagar Cheluvegowda wrote:
> On 6/1/2026 9:25 AM, Jakub Raczynski wrote:
> > New datasheets for XGMAC (3.20a and 3.40a, depending on product) support up to
> > 16 MTL/DMA queues. Before we increase max amount through macro,
> > prepare dwxgmac functions to handle that.
> 
> Hi Jakub,
> 
> We are interested in this change as well. We carry an equivalent
> change downstream for a Qualcomm XGMAC-based controller that
> implements 12 MTL/DMA queues (MAP0..MAP2), and would be glad to see
> this land upstream.
> 
> Could you share what the next steps are for this series? Is a v3
> planned?
> 

Hi Sagar,

Sadly not for foreseeable or borderline never, for few reasons:
- Increasing number of DMA channels without providing hardware DTS
  configuration for that is quite an useless feature,
  and there are 'issues' with me providing DTS for our hardware.
  Cannot say much, but generally won't happen for very long.
- This has lowest priority and doing other projects, won't be able to
  continue within reasonable amount of time.

I will be very glad if you would continue this patch,
as I will not be able to contribute that.

BTW. Adding Maxime to CC, since he will be most interested in this as
newest stmmac maintainer. Apologies for missing you earlier.

BR
Jakub Raczynski

------6Yzir0.DT2R1UiBbNh0_rPWXcRyD2CU8yss_stBlwropLZCy=_112415_
Content-Type: text/plain; charset="utf-8"


------6Yzir0.DT2R1UiBbNh0_rPWXcRyD2CU8yss_stBlwropLZCy=_112415_--

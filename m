Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455A3DBD4E
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968792; cv=none; b=bjTxB23F3NdGy6tvR5kCMFUcD1C2VOXSyOpQ1b3vVUurpHeN47SyHs0Fcq5x42kx7ZJA4HmNU76u0RTgkp5vgM1jOvsUx9qPjelgQzujqR+1pC+eAAYaX30yxLkkCbOakn/M5rTRhvJw8qApDuKG4DQVyi4oYEl/iCZ0qBgKhAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968792; c=relaxed/simple;
	bh=4neTvefs129BqKrkGxhtRbrAm1SI9RNhQXVgNGUlEhs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLAjBqb9WCxO+TlbuvZ17CjbRL4boEy4g9BRiaU5ZdnPGxIwjb5RpFst5/naA95iokdQ6YhMvemThnmCIt/65p9Pf3h37RuWm7BUr8RbNdBlg2oKH9gOsq4gtLwdIj8U5Kq/sF0RTRNmDR0e7kc257zoCPbp+bpm2A0XJTXNYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=p4G04396; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="p4G04396"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 30044201E5;
	Mon, 17 Aug 2026 14:13:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJdHTB_e9ply; Mon, 17 Aug 2026 14:13:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4200F201A7;
	Mon, 17 Aug 2026 14:13:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4200F201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1786968786;
	bh=ikXXEnr9nnpWqJaR754M9ViNer9+xJbdcD/NgLjauis=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=p4G0439614sgp9IspzePmSWi5BZ8ijdASNzaQ4L0r7ju2zhjhLjl4E312JsseSFI3
	 itld5/Q45tHJmd4TI9DbdMPdnpEx6UtKV2ZwoSM45moJxp4FZbPmhNAC3b7q6PWWD/
	 eptwAB972Yjcn/zFeM83xEGUy4572kTpLw7ORB4DgMUAe8E1ex3prZm8OPDwjmmlU7
	 pnYYvOXWDgrkrTHn3GTTPe4C1ChYqheiHC9JC7idyMXwam0ZtSuD93ZNzX5VXRFZw3
	 mJxTXN1z3ZV/BNavrf/I3OS+BdheCJzXsT51U1/nqMQRAec43QEevciLptE1hqrlKO
	 E1FTM1fYwCn9Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 17 Aug
 2026 14:13:05 +0200
Received: (nullmailer pid 2597399 invoked by uid 1000);
	Mon, 17 Aug 2026 12:13:05 -0000
Date: Mon, 17 Aug 2026 14:13:05 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: maher azz <maherazz04@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/8] esp: do not unref managed frag pages in
 esp_ssg_unref()
Message-ID: <aoL60d6utaU0vkRQ@secunet.com>
References: <20260729065035.1591985-3-steffen.klassert@secunet.com>
 <20260731021544.789075-1-kuba@kernel.org>
 <anDIQ9-8Sf_6StfZ@secunet.com>
 <aoK8Xl8uTm4MW2Mr@secunet.com>
 <CAFQ-Uc8abYE4ZuzEa0bZNmEw5Bx7DE7qv+gRxUJvUM26Ceyknw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFQ-Uc8abYE4ZuzEa0bZNmEw5Bx7DE7qv+gRxUJvUM26Ceyknw@mail.gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Aug 17, 2026 at 12:50:07PM +0100, maher azz wrote:
> Hello,
> 
> what should be fixed?

I forwarded the review to you again.

> can someone submit a fix please just keep the
> reported by Maher Azzouzi?

You did already most of the work, so it would help
a lot if you can fix it yourself.

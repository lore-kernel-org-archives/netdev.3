Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B4402427;
	Wed,  3 Jun 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485022; cv=none; b=C40rk6+AtC0Bej2Z/hFvQVa8THwFRSmsDiQwRjCbLlBwJYD5WaehAEUPaa++4hnGDFMT+OSmnnYv6HmqbXOWyRKjs/iChI/4HAPYluGefuP7IAG4E3IZs4U01cBlq1QcpehLRtXISaLdWcYW7mApoGmmAIf3GftY5IskNxbfmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485022; c=relaxed/simple;
	bh=B36P7iXGQkB+ohaaJ/k+ZwKyWHHtdSU5AtkoHuNCNGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG6k0Pe9Y3XZitlpMVV0gHbmBNTGVSLqOlPwXSIdZ7Z5/qbyo8uF39fE/xSEFlF58ciaD/+Q+clOWbVwF6FqWPrnvbeUwzvx9MGfmk60czhu2cY2ZpecTt3mhymixAQQcu65jU3Tyj1G4xmlID1+bELJX+xuNWc8NIpTu+tvfVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Sc3G+lnI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Sc3G+lnI"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CCB23206D2;
	Wed,  3 Jun 2026 13:10:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgpu2YHX90Q9; Wed,  3 Jun 2026 13:10:18 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 57C71206BC;
	Wed,  3 Jun 2026 13:10:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 57C71206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780485018;
	bh=B36P7iXGQkB+ohaaJ/k+ZwKyWHHtdSU5AtkoHuNCNGI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Sc3G+lnI8gsBMNgZYMS4Oe4CEVJwm11khuhkeWWNy1KkhamPJYmQmAvMM1kdARBSH
	 EYy950xsMnfO/iir30VZBqyA3bZPa0T1FSvjpu+HINoPXA9XcVYoVKjPUYVIMUkjl1
	 1AUJLCA6R1EiwocKObkDUe+i1IjydaqYq+XPnALt6qNjMiwt8x0dxjEb8iTjHQnfvO
	 NNLfTSEtxjITC21AE5PcdS8uMJLv0BuveAoNuyUplzTxDB1phPBNreB4+zy0ZyF0Z3
	 sA2pYdSmaT3pxNYYuzC+QpfVBJziIgblRtYsHN+6FRlqL5j4RQKT2LNrGdRu3YgNiT
	 INVVEyUMbwoXw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 13:10:17 +0200
Received: (nullmailer pid 1869479 invoked by uid 1000);
	Wed, 03 Jun 2026 11:10:17 -0000
Date: Wed, 3 Jun 2026 13:10:17 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec] esp: fix page frag reference leak on skb_to_sgvec
 failure
Message-ID: <aiALmb4vqswoHGLI@secunet.com>
References: <20260601134526.82-1-7991aleschino@gmail.com>
 <aiAIvUX8a43ci-DF@secunet.com>
 <CABNe9nMY+npo8uTourxOSDZobbGoWmH8qgTuKxxW+hFeFag-Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABNe9nMY+npo8uTourxOSDZobbGoWmH8qgTuKxxW+hFeFag-Sw@mail.gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Jun 03, 2026 at 01:06:40PM +0200, Alessandro Schino wrote:
> Hi!
> Yes understood! Do you want me to format the code and send another patch?

Yes, please.

And version your patches like this:

[PATCH ipsec v2]

This makes it clear that it is not a duplicate.


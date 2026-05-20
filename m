Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBDC1E51E0;
	Wed, 20 May 2026 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259875; cv=none; b=tiVXc+lrEVnQQzRWpTgGz/MOsjzdqQaDqttXKgH90GlhoAC8zjMqLr6UR9/p35VlTdcUmQXHOvsrSmUHclRLvcmWn7PF14+cHYRn18dc9OY4TgyCpT0zlYEVVhAcNSjGXB35q/10I2StGBTnbsdrl7mOiKjhV/F0307BRAD1Y0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259875; c=relaxed/simple;
	bh=ND8kbuIVBSkCZgoXqR/WoD8dHGWbu0FC3i/yvI9gkrQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzB+95GKiHLchT6rDIoKdwQGu2WTdm6OZLWJ+C4vGEZqhw4ntPxh9cbs+JNxpRHT+TtG5HjvcogumV5KS1kxFaN8aYIAtleJjF6EYkYjdslhcWcgsrd5DgsdbJMSDVXW+q9Nm8uHpmEhbQXaiMAHoxvjt6qzjS7U1x3QvSyRcfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=coirRY3M; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="coirRY3M"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 28ADD207B0;
	Wed, 20 May 2026 08:51:12 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ZP1EmhL3nWy; Wed, 20 May 2026 08:51:11 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A39F620184;
	Wed, 20 May 2026 08:51:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A39F620184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779259871;
	bh=bf52P203YyUk/5Ce0Svchn25/+VN6OGb10VcsgHSZfk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=coirRY3Mahz8WlYgUGe2E+7k9fXTBl/KZsgVZoLoOnyrKuZ1Tu4mMSCYl3CulwTBg
	 Uhet26Me93r8057WX7G0B61oTcwTdyJolNMMZp9NHjgd3mcnr2HlZ8DZJtUY21IClf
	 Rmk65/FBzcJS4jiWVA6/PQypsmfICBv7wbMJpgnEiUfzL7Nmc5RC6gQlpMHuoON1PF
	 ODRparwQKhQVPBSqBwEV7UN5M/Fsn2tXtABMDCA/sfyasv2ZFirRu+hi8u/KB2rYCi
	 Nf3Ie2XSu10NNEEgljPUtPgC56+PJu3Psp4AR8deQkQ/HJ7qIJiCZDz7LFMARl7mj7
	 CGThsnJBW3HCw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 08:51:11 +0200
Received: (nullmailer pid 1140913 invoked by uid 1000);
	Wed, 20 May 2026 06:51:10 -0000
Date: Wed, 20 May 2026 08:51:10 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: =?iso-8859-1?Q?G=FCnther?= Muller <gunther.muller2008@gmail.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xfrm: fix missing headroom check in
 xfrm_dev_direct_output
Message-ID: <ag1Z3halPB-km3Sn@secunet.com>
References: <20260517111940.8987-1-gunther.muller2008@gmail.com>
 <20260518080410.11119-1-gunther.muller2008@gmail.com>
 <20260518123054.GS33515@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518123054.GS33515@unreal>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, May 18, 2026 at 03:30:54PM +0300, Leon Romanovsky wrote:
> On Mon, May 18, 2026 at 10:04:09AM +0200, Günther Muller wrote:
> > Ensure the skb has enough headroom for the hardware offload device's
> > hard_header_len. If the headroom is insufficient (e.g., when routing
> > through certain virtual or tunnel devices), __skb_push() underflows
> > skb->data below skb->head, causing silent memory corruption.
> 
> Could you please provide the steps required to reproduce the issue?

Please answer Leons question.

Thanks!

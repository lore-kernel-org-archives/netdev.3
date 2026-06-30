Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486F377010
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828227; cv=none; b=l1OXuf1Ymed6Rsz5rgP9XeNtkVY1zQNKqC4mdka78UdO8/VfdzH1xglLNLSO7KqYBz9vjJlyuKX8FTkHGcXg+VvSvV0HGCHh08brta2221t1WtLyCtWeoEXHOXSVg1cwSfSBsA5+W0v2GTASR5gDVvw3sfLW1FMnMIjy2MRPPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828227; c=relaxed/simple;
	bh=mlHdGYMet4ugXAP3QOHY/WNYdWQUyQiiRMOCc4V+vvw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBZi1+iIzAkX9Ms85gI9SjKOngUfJp9bsWA4N6vAtkfiulMjfmnXVmew62W6S1dW4cQHYmBW8lSskb1h4kaEjvKHh6chIm3gg5pBNU4+FrbInW379Agl4jDXNAbp4EtNEmKrwc/5S12YIKFCt7aMavozsZkoXYBAxfEyT8dASEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=txCZ5kho; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="txCZ5kho"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 455B720844;
	Tue, 30 Jun 2026 16:03:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkY0NSsW56KD; Tue, 30 Jun 2026 16:03:41 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 05F8B20719;
	Tue, 30 Jun 2026 16:03:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 05F8B20719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782828221;
	bh=WgpzmFEZSFC/xyyvqFfKSg8chY6dfQCbtMNV0rShAOY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=txCZ5khoiCPi3RuEGlJSKAN2L9kyT4Lw2CcAct6d1q42iPIBtInl9hRBUdSPEvyVC
	 WEr61Szjs/rzla3yOgXJ4zm8XKXV1uUbvqJaok92cJdytQFCzaUhVDcJslBxWESyua
	 HS+0nnFcUuMb4SsU2z/YApYrJSeiQTir7YRgHGoSjnupb4hl1yxL05/S7hndsNAu5i
	 DGN4Y+TkmeLpImNAsRRMSqwRAS8TyF8KMSaxsfrbGwOfQwblLNamtuGLs/+nNyP2u0
	 AwM4nLYtkiK2zStRlzJMyFUoGRnbHJjkkTEtGdKGBD2OsJVK+O0uH/Sl2pMeF3OcUj
	 2IsTzSWGKvNqw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 16:03:40 +0200
Received: (nullmailer pid 1133296 invoked by uid 1000);
	Tue, 30 Jun 2026 14:03:39 -0000
Date: Tue, 30 Jun 2026 16:03:39 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eyal Birger <eyal.birger@gmail.com>
CC: Ren Wei <n05ec@lzu.edu.cn>, <netdev@vger.kernel.org>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <yuantan098@gmail.com>,
	<bird@lzu.edu.cn>, <qianyuluo3@gmail.com>
Subject: Re: [PATCH v2 1/1] xfrm: nat_keepalive: avoid double free on send
 error
Message-ID: <akPMu8LwZN7Sz0HO@secunet.com>
References: <20260625055513.1841167-1-n05ec@lzu.edu.cn>
 <CAHsH6Gupn_PVjZjOWPRLWL6LCL=-p8Gde6_BruGdetn+eP3NMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6Gupn_PVjZjOWPRLWL6LCL=-p8Gde6_BruGdetn+eP3NMQ@mail.gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Sun, Jun 28, 2026 at 06:42:44AM -0700, Eyal Birger wrote:
> On Wed, Jun 24, 2026 at 10:55 PM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Qianyu Luo <qianyuluo3@gmail.com>
> >
> > nat_keepalive_send() frees the keepalive skb whenever the IPv4 or IPv6
> > send helper reports an error.
> >
> > That cleanup is only correct before the skb is handed to the output
> > path. Once ip_build_and_send_pkt() or ip6_xmit() takes ownership, the
> > networking stack may already have consumed the skb before returning an
> > error, so freeing it again is unsafe.
> >
> > Handle the pre-handoff failure cases inside nat_keepalive_send_ipv4()
> > and nat_keepalive_send_ipv6(), where the caller still owns the skb, and
> > keep nat_keepalive_send() responsible only for family dispatch and the
> > unsupported-family cleanup path.
> >
> > Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
> 
> Thanks for the fix!
> 
> Reviewed-by: Eyal Birger <eyal.birger@gmail.com>

Applied, thanks everyone!

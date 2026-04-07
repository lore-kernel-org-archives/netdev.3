Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C138AC9D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549739; cv=none; b=sQmLGm0i4sP71yrUMjv/0i69HXp1h5Vt5SvcfZlL9nBvUIkrLSn54Dn/Y5ANwaGUAlv2W1xJSB4KhRfkfGVn9STif0Q10DJfSvEBj/2NRddFMpJGDX23K+xSDlvBENcAppVh34qHVJPsCIQcrh/fUaaP0g7hmxeUX/Yk6dk6oWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549739; c=relaxed/simple;
	bh=5gMStqwTMeRYtxZ4GSzhuI6m+53lNT/XYFfkGB9qI6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsSltdADeSYgCxov1kgIVClAbGxLm+XuLe9Qhqmnn3EulG8JGqdxH59qndbChMiHTuDOUCd5jThhmPZLa6xt7W7s0YboENwr/bnQeaLY6zobhF0ZZcDSCB/jM/P9RtzDN5ENCQmYS6hrLG5ulmYD/bQtbidtEa8xByiDWpZWj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BgkC6lSB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BgkC6lSB"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9F993206B0;
	Tue,  7 Apr 2026 10:15:27 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DLdhpX58QxDl; Tue,  7 Apr 2026 10:15:27 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A8BBE20190;
	Tue,  7 Apr 2026 10:15:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A8BBE20190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775549726;
	bh=7WtQF7VD/R251478CG5H7Himh0AuDUSXdU5gP2lXrWk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=BgkC6lSB4nDDFYgFMGefhI0KVznucASYwiwZgl3WZVPFvCu2siVMVQgj/CrIqKTVA
	 bIOV1rWFE2LEc3aFI9CqwHi/3SdzExK6YW3Qa4SnqAly2J6+YYxrzunv/3JeSJoN67
	 SX/W3axq9a+g7yY7ONeCwfCYfVpnP2X5nIiM3Ui+Mtouj4ayMXtfORfPPhP5MUh710
	 k/suCgH++MMWLDjVKoT9gdAi8oVRBiKmodwideYvSPitxwgINEunaIr5u6zZgGfjec
	 xli7fcb4pUSO6v67egTXbBiG/WghZx1hgKd5xgazy7nV6NICKfQ+tZNYju1SoHFbLe
	 Q8PSMk+5H5H7Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 10:15:25 +0200
Received: (nullmailer pid 1487808 invoked by uid 1000);
	Tue, 07 Apr 2026 08:15:24 -0000
Date: Tue, 7 Apr 2026 10:15:24 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
CC: <nicholas@carlini.com>, <netdev@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	Milad Nasr <srxzr@anthropic.com>
Subject: Re: [PATCH v2] xfrm6: fix slab-out-of-bounds write in
 xfrm6_input_addr()
Message-ID: <adS9HIMGWPI7R5uk@secunet.com>
References: <act8zZGYpN9DJ4-w@secunet.com>
 <20260401045652.1807999-1-nicholas@carlini.com>
 <CAPrAcgNbbcLrJDBs03=CQU0VzbqaEGi_h4gsrWY693ERsuTE1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPrAcgNbbcLrJDBs03=CQU0VzbqaEGi_h4gsrWY693ERsuTE1A@mail.gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Apr 01, 2026 at 09:56:40PM +0530, I Viswanath wrote:
> On Wed, 1 Apr 2026 at 10:26, <nicholas@carlini.com> wrote:
> 
> > -       if (1 + sp->len == XFRM_MAX_DEPTH) {
> > +       if (1 + sp->len >= XFRM_MAX_DEPTH) {
> >                 XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
> >                 goto drop;
> >         }
> 
> If you look at other places where sp->len is incremented, you will
> notice the guard condition is always (sp->len == XFRM_MAX_DEPTH). This
> bug exists because in xfrm6_input.c, the greatest valid index is taken
> to be XFRM_MAX_DEPTH - 2 when it should be XFRM_MAX_DEPTH - 1.
> Therefore, The correct fix should be using the common guard not
> changing the guard to use >=
> 
> On a tangential note, There is no guard present before the increment
> in xfrm_output.c which is probably another OOB bug

Nicholas, please have a look if you can update your patch based
on these comments.

Thanks!

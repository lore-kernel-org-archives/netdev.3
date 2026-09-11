Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9293E171B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106673; cv=none; b=gbNf9tuC2c9TO1vKhkQRlWgrwo9KB6oGz7SevBOdmSHTrecnjPuNK8xcMz3OcXCqF3KvT19GpMYxzbhGt8AgufOlOcR4eHeMDZVeG6iLYNpNbmpw2ekvbiqcJffiSQ1jWzF7ycRGpo2tckGOgr2rl71n7sRvqIRURGWpvVo96VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106673; c=relaxed/simple;
	bh=FcF2ZaKXe2vK8LXo9RNb7lYZGr2ciuor51jPnqQR8R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cffj4+ZrIpGisYJe5GB9cCS5cQZ2qgw0wTcjfAHnhhPi3ySIfu4DYva3BI+Z9feQmwiCAYDwkX8oHkt8C0MNKbm0srka9Jd7gvdDoPSzrdBAFkHJTfVMQw8QIY1Smxl0qOcza2i30o1nNZCC+dv9ZLYifln5eabdjAvLBJ/Af+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=K8pPuN+S; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="K8pPuN+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1789106663; bh=ekj0YdfCJTodFKDkYfZhfP5DayyVnznNcv7Mn/m0EcA=;
	h=From:Message-ID:From;
	b=K8pPuN+S2+Kw6IbfqRnybusN2+pUOw6Prt8jPnGEk7jCsnSU1RmKO3TUhckFFPTYl
	 jyhr8lVkAmpI+kekO74VKQwnmlkkzUfO9TN+VXpl4YtLmNwc53fIhdorEe7y7Vi+RI
	 GiBjYurZRAYdz0QPIA6gmGreXR0yblKtUJNh81rk=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 20FECC0483;
	Fri, 11 Sep 2026 08:04:23 +0200 (CEST)
Date: Fri, 11 Sep 2026 08:04:22 +0200
From: Willy Tarreau <w@1wt.eu>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: liqiang35@xiaomi.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net/sched: taprio: fix infinite loop in
 taprio_dequeue_tc_priority()
Message-ID: <aqOZ5sJS26RrH_md@1wt.eu>
References: <997210f347bf47b8b2644df8c4331594@xiaomi.com>
 <aqOXRLr98GPdeNVB@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqOXRLr98GPdeNVB@fedora>

On Fri, Sep 11, 2026 at 01:53:08PM +0800, Hangbin Liu wrote:
> Hi Li Qiang,
> 
> Please use scripts/get_maintainer.pl to Cc all the needed maintainers.

Also, no need to Cc security@ when posting to public lists (now moved
to Bcc).

thanks,
willy

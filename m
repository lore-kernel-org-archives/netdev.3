Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0E296BCD;
	Thu, 13 Aug 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642771; cv=none; b=c3On6bi9wLs1AnFab5PeUYU9RAyk0nHQAcpSYC5eC7quzJbsEG6RdkPpro+l6u9wPPjdu1MnYKUfzvoVqwinXnbV4I+6vUFVdERaB1pTyIihrMlu11+JgLYanKskX6ASpGMD1vWoxezQcL1IEWEOYvjBlJzxgJOjYw3qInJHg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642771; c=relaxed/simple;
	bh=tMIjejHM7pyyCtRNhgIaNAjE+SOXudBnIv+xBrtHDhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aepMjVHloqH5X/xn3/jEKmlv9Je2O/ZZTYEiqSJZh1mA8hudRVdnumyo11RbF8WiJkkd/py2Cosl6wNn6vLZTyeQ0mmpkYKTh6/AsI8XquPAB2m2NVzgVsSBUe/HU0KrJD/JbRKuaFgWCGxz8Zx0NxdlcjA1Lr8x92iMQunf0+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=PZVFr53R; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="PZVFr53R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1786642766;
	bh=qTlDH7HooEcck27CSoQNxQqyXbRyMSfmpNPiN7hI7Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZVFr53RMVXGex5/9XxG7sGRu0KNhtA6W+XYuVQKXw8C5VnqJG/367hTKQiW7Kkyg
	 SaPPapdPIazZG1XniQrVIMXtF05Cwa3L2YzL9BFFApf7SuzkLcXTKVNArX0+rWJmbH
	 SDTuBFsw54UV2DMBgiWDeMaCP24o/I6bJN5t8u92aeEqd90agahvITaHdFlELTgYL3
	 xR9kSJnwxZAvg7x7MRB/nGEECqR0nVjlnoBgJ2JERdIR+MtkyI9VFlufM8rvBIDQr+
	 aJGGp9Hny3he6rYP1ROfRS0YXFfw+6xa7tBURn/VBwd6isIgzQo/7RHGIAptSUix5K
	 hCyWTEOl17fxg==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C949B6007A;
	Thu, 13 Aug 2026 19:39:26 +0200 (CEST)
Date: Thu, 13 Aug 2026 19:39:23 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ming Qing <a0yami@mailbox.org>
Cc: Harald Welte <laforge@gnumonks.org>, horms@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] gtp: serialize PDP context updates
Message-ID: <an4BS0kOJaS1BlXC@chamomile>
References: <20260811022012.5416-1-a0yami@mailbox.org>
 <anrpdUa_ngVKH6NR@chamomile>
 <2125081283.36735.1786638719082@app.mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2125081283.36735.1786638719082@app.mailbox.org>

On Fri, Aug 14, 2026 at 12:31:59AM +0800, Ming Qing wrote:
> 
> > 在 2026/08/11 17:20 CST Pablo Neira Ayuso <pablo@netfilter.org> 写道:
> > This can go away too, for gtp_genl_del_pdp(), the mutex replaces this
> > incorrect rcu read size lock.
> > 
> > Thanks.
> > 
> > > +	mutex_unlock(&gtp_pdp_lock);
> > >  	return err;
> > >  }
> > >  
> > > -- 
> > > 2.53.0
> > >
> 
> gtp_find_pdp() calls gtp_find_dev(), which uses 
> dev_get_by_index_rcu(). Should I keep a narrow RCU read-side section 
> around gtp_find_pdp(), while using the mutex to protect the PDP context?

Indeed, I forgot about gtp_dev uses rcu. Thanks for explaining.

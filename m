Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAD2F616A
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490275; cv=none; b=l8Dm0QvHo5a40cP2oF3mVJ3+Fi2d0NFikz05qitA0sZi9hq1uc/fAEPITKrjIIF2i1zjLXnboP8TqaC87wsaeQ10hQLG+0cgjSAqeVySr9JohvICtOyl+B9j0xZT2IY8mWAQ44Va7bBgLWWMBolB+CFBQO9L2l2p8oQ/8iER1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490275; c=relaxed/simple;
	bh=vdGaUdggAPupRZgcX4LyxUHq1HA5A3+qHr4t4ldTgOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeQw256bqZHm1xoRS6BeZXZLagdcZHDmj0VN7dXyy7DDTm4XAS50S84gTVYhYB9IUfcYOeNpeu/Pzgj6JtSXYr/Y3dCHFWl13wblDzibd5udkPq5JShFUKQ4U+8yLAofEGvoaEtGyrSLU90m7k/Hrg0MXrksrogakWkKYlE39M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nBY0oHZg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nBY0oHZg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OufDbxVnnurdLAWAicmVP80yEgGEP+1/KhYJ9EWxP0I=; b=nBY0oHZgfX1qUGadjq4qBq6us4
	Q732JJzflC6drV0Z1YLOvENsT9YoqwUJw8MPwfnCdUuotctxFDTIhwomMDgduXr9NE9+sg5celWq7
	Cq5WDyJIKv4Oa9tNqU3Er0PT/ETz/QKWyuUZnMe8Vjva4s3gbFDrLMR8kbfl2vobHKEDFb7L1eFqe
	fLJ1FoLnqD15woF/DJOkFW32lR9mPHWCIy82qF37Qdhb/Oy+AqPsevZxK5DdovitPf0QPYNjogUx2
	PwuhJAIIyUCnvjgDZITqgatmP7GeYgFT3VSvPiMlCG6nL6/hAKCaRZCQADoe6qH2tkmk+F5HWsIBY
	4wrXkzNg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpja2-009ulG-1N;
	Fri, 31 Jul 2026 09:31:02 +0000
Date: Fri, 31 Jul 2026 02:30:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, 'Mengyuan Lou' <mengyuanlou@net-swift.com>, 
	'Andrew Lunn' <andrew+netdev@lunn.ch>, "'David S. Miller'" <davem@davemloft.net>, 
	'Eric Dumazet' <edumazet@google.com>, 'Jakub Kicinski' <kuba@kernel.org>, 
	'Paolo Abeni' <pabeni@redhat.com>, 'Richard Cochran' <richardcochran@gmail.com>, 
	'Russell King' <linux@armlinux.org.uk>, 'Aleksandr Loktionov' <aleksandr.loktionov@intel.com>, 
	'Jacob Keller' <jacob.e.keller@intel.com>, 'Simon Horman' <horms@kernel.org>, 'Kees Cook' <kees@kernel.org>, 
	'Rongguang Wei' <weirongguang@kylinos.cn>, 
	'Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>, 'Joe Damato' <joe@dama.to>, 
	'Larysa Zaremba' <larysa.zaremba@intel.com>, 'Chenguang Zhao' <zhaochenguang@kylinos.cn>, 
	'Fabio Baltieri' <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v13 2/5] net: wangxun: add Tx timeout process
Message-ID: <amxrL9y6Nab35KVI@gmail.com>
References: <20260731061837.12672-1-jiawenwu@trustnetic.com>
 <20260731061837.12672-3-jiawenwu@trustnetic.com>
 <amxjZX1eShpKD1V8@gmail.com>
 <04f701dd20ce$d21842a0$7648c7e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04f701dd20ce$d21842a0$7648c7e0$@trustnetic.com>
X-Debian-User: leitao

On Fri, Jul 31, 2026 at 05:27:34PM +0800, Jiawen Wu wrote:
> On Fri, Jul 31, 2026 5:01 PM, Breno Leitao wrote:
> > On Fri, Jul 31, 2026 at 02:18:34PM +0800, Jiawen Wu wrote:
> > > @@ -1275,6 +1288,7 @@ enum wx_pf_flags {
> > >  	WX_FLAG_NEED_DO_RESET,
> > >  	WX_FLAG_RX_MERGE_ENABLED,
> > >  	WX_FLAG_TXHEAD_WB_ENABLED,
> > > +	WX_FLAG_NEED_PF_RESET,
> > >  	WX_PF_FLAGS_NBITS               /* must be last */
> > >  };
> > 
> > You need WX_FLAG_NEED_PF_RESET and also WX_FLAG_NEED_DO_RESET? isn't one
> > of them enough?
> 
> Sorry I didn't notice flag WX_FLAG_NEED_DO_RESET introduced by VF driver here.
> I'll fix to reuse it in the next version.

Right, WX_FLAG_NEED_DO_RESET might be enough for you here.

> But I think 'wx_pf_flags' needs to be renamed to 'wx_flags', since VF is also used.

Agreed!

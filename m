Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F76403AE1
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503670; cv=none; b=RMAjRdGDR2CXEYFKsTVHRs3dbKzdWkiszXn5WAn5Z1j6vLpw6hFgWRxTIVX73uS+amOJBmBcZYQeK0AJtB4xfzVyrRg1ouDDpK3tW5HxOuP5k7lH8lm5EnGRd5o9jKgLN67uljSxleJ+4qsQcDYN/epi9bGsoTO+SdKxoYG8nMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503670; c=relaxed/simple;
	bh=jHheFd9XIaa23q7/M3lu1dU8y6vuAr5OBV3yUAXJ1Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktHBorTkdJcUdrlVhsD1uXYGaEARkNom/rYDQ6hKg1gkfmTIL2l9kBmK+/Yed7Jrk/qSytAfmkvZ5nX6/Mdq3lyXaAgr6kTpVuws4rJuurHHE1qZVPLe50nxUvHYwMmHScs/kECa81EEHi+HQLGALrSt1VZC1OKKRaf18tW9UYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lDgO8QzN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="lDgO8QzN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=DW4rEPsHQBN2pkNuDapLFmgiqL/ajKkBCko7FFMbgXo=; b=lDgO8QzNi7XuO3jmg4KIoyIOMS
	r160oqv5qG5J6JMWglqINqKstV/70YJGxjijOcU5DBBgTaLrr72OTiRDYljp2IszmvY7wN62Wvaz2
	CgoXrxhcjbDSE5VfQXiUMXWh4U+Td7gfI4Hr6sYsX6H8vNeru5rxU1d9NAY3KbQD8dwnQ+jofXLfG
	MGJvEqHF9L7IY9tXV1BfCcDAXJtBbaJR9c9oVrBZ99+b/pmlwASdkD+XflUnxhACGeJ+w8ILoxEzG
	4nSY1R2TslhCX+Zy65Fpew1oeQyUtb85YjNzos5s4I9qDgCkI+Et0hVnb8GBakUkrNn4sJM2ZOvHL
	A5lEAZCQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpn43-00A2O5-2q;
	Fri, 31 Jul 2026 13:14:16 +0000
Date: Fri, 31 Jul 2026 06:14:10 -0700
From: Breno Leitao <leitao@debian.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, 
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 5/5] net: wangxun: add ndo_get_stats64 support
Message-ID: <amyfgDYpSwj1cyQf@gmail.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
 <20260731074958.19333-6-mengyuanlou@net-swift.com>
 <amxh3Ef6FnHNnZQ5@gmail.com>
 <3F8CB138-3F3C-42A2-986E-36E33B0B4F3A@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F8CB138-3F3C-42A2-986E-36E33B0B4F3A@net-swift.com>
X-Debian-User: leitao

On Fri, Jul 31, 2026 at 05:41:33PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2026年7月31日 16:52，Breno Leitao <leitao@debian.org> 写道：
> > 
> > On Fri, Jul 31, 2026 at 03:49:58PM +0800, Mengyuan Lou wrote:
> >> Expose network statistics for Wangxun VF drivers by registering the
> >>  callback.
> >> 
> >> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> >> ---
> >> drivers/net/ethernet/wangxun/libwx/wx_lib.c         | 2 ++
> >> drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c   | 1 +
> >> drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c | 1 +
> >> 3 files changed, 4 insertions(+)
> >> 
> >> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> >> index ae20733c703d..a4ca01c18c6a 100644
> >> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> >> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> >> @@ -3092,6 +3092,8 @@ void wx_get_stats64(struct net_device *netdev,
> >> }
> >> 
> >> rcu_read_unlock();
> >> + if (wx->pdev->is_virtfn)
> >> + return;
> > 
> > Why you don't want to populate the other entries?
> 
> The hardware does not provide the err counts on the vf.

Right, but hwstats fields will be zero, right?

Does this early return buys us anything?

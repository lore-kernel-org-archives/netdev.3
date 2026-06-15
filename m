Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE121F09A5;
	Mon, 15 Jun 2026 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553659; cv=none; b=XUasv5p6UNFJ03sN+uxTjTN74Qib/LFNTXCK8hCcWWysYPq870kvO3VocAFZWZ4aggrEQFHHoKR1fRgrr4oWVuhMby1PZg/ACVt7GHg1RPOZFsNmW22Zociy9Y2tZrhdgtpC82KnHNo5la7eWJHyaixPe5IBVNLICnHWB1GpEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553659; c=relaxed/simple;
	bh=SjppnqlhpDI03qRsh2Nei1Rj9w6bJbdgHEPZwT1LQmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdNZltjKDE5aEHDhkfFZus+9C+ukN0bYu3UgOdzCYkGNu19svN8AOEvM4YS4hkFSkYVGGnsSdz8Z4Blw6PgT/TlMnqQP8QYYEHgpEMFabKu6Ea+1ct98kqFtAhZHb5l6WUv5URPgdTMN7+stxhLd5XzTCgPDP9wRrHGLh95v+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPoeqkFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPoeqkFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4580A1F000E9;
	Mon, 15 Jun 2026 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553657;
	bh=uBmhK5GRzfQc88RjWt4z4d5+i8/Z9kF0dewVd4Uu3tY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YPoeqkFzrQozZwHoi9UukFeLmDhdVMF7G6poMoFhkdC2xNuEGEKGlA7UYAD1IwlCl
	 QBnvL9U6mBkkKpEpiThJ9Hwp1n69HPFhc2Hn5+6ViJugk2Sln4yErQZgGU5EI22GYB
	 ufkq5viuO2p5cAOaD+k6lOP4eftoSELRzPMghoZxdCk2dJHI41qxtCC4zhaFrdECYi
	 U4qaXuHClDFnlp/2uHtMARZgpN9rz+0DUSDGkoSWBwdmuhJQ5aEf8YrRxd+bMurNZm
	 gzAp9mB9Kv1ySsjo67dC5VMqo1dE248PonMZmC9lIitG9KrdW27lIv2zcqj5NRc2hP
	 Feg52namxe3hQ==
Date: Mon, 15 Jun 2026 13:00:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Jens Axboe
 <axboe@kernel.dk>, Yael Chemla <ychemla@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] netdev: expose io_uring rx_page_order
 order via netlink
Message-ID: <20260615130056.028c5ed4@kernel.org>
In-Reply-To: <a773d177-82f3-4046-866d-852d0d83e08b@gmail.com>
References: <20260612211709.1456966-2-dtatulea@nvidia.com>
	<20260612211709.1456966-3-dtatulea@nvidia.com>
	<d0401fab-61c5-43e7-93ae-d4757433eb7a@gmail.com>
	<b581d253-135b-4c75-a50d-2049c6d6e249@nvidia.com>
	<20260613170232.6f9e72ba@kernel.org>
	<a773d177-82f3-4046-866d-852d0d83e08b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 12:16:47 +0100 Pavel Begunkov wrote:
> On 6/14/26 01:02, Jakub Kicinski wrote:
> > On Sat, 13 Jun 2026 16:09:03 +0200 Dragos Tatulea wrote:  
> >> In io_pp_nl_fill() or in page_pool_nl_fill() as it was done in v1 for order?  
> > 
> > It's fine. We decided to make the "page size" a memory provider
> > property, now we're going back to making it a queue level param?
> > Like my RFC had that everyone hated so much? Sigh.  
> 
> TBH, I never cared much how nl would show it, so not opposing either
> version. My idea is that even without plumbing in per-queue non-mp size
> configuration, it'd be nice to have a common way to check it b/w
> providers.
> 
>  From the semantics and observability perspective, zcrx is probably not
> that interesting as the parameter is basically just a hint with no affect
> on uapi, and I'd assume people would rather see the page pool size or even
> the NIC's page size. But I guess it depends on what Dragos is really after
> with this patch.

Not sure what Dragos's use case is but IMO it's useful as system admin
/ vendor to be able to peek at the important params when user reports
bad perf. The netlink MP info is meant for system observability.

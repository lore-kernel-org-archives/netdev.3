Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB4385D7F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142728; cv=none; b=Gw1MloMoAO+qedgPOtXpLCbTpXAKOVwfbl8EYVAcn2m7U85pVE7IoksKhsQBA4j0mC/NZB8H3fvOMcpUucBBPPi2LPopmTqozpCGFUtJiaPMT6WYTYPHfwwE9bdMzs0D+uib8aTeW323z9JckmhcW5qDQQ/5CzDmmKlASBTgxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142728; c=relaxed/simple;
	bh=FPaHBYG3UU1x8PQaEsQjb00YifLzVUa4qMBaLc5PF7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLvna/FXAx9gR0/ONONQYqODmCjTa8G+ONYK/JtGEXNi6/r+kaO0AVhNb6mzXzM1M00vTPi4Tgce/A4AFUlaX8rRYzt42zQAl397b9wQAcasOUCcaXjYJsiqYjldhT7vtiWqZXO67/R2bPiTEcxCvcpZ3oBJTVALpUATIITQ5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhqI8gfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhqI8gfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9DA1F000E9;
	Fri,  7 Aug 2026 22:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142726;
	bh=l8f02emCS+LlY4hfoDFcRNgK6jVWis248OyY+7ATumw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NhqI8gfpaL2itgZTo7K1ipm+Sjw2maL3Fj6DX71L0CKdW3oQHOFys6cOcAIPxjByh
	 uyPp2Dz4KMvwJkr+jmh58fEGMMFZuQj9Fjy4Z3l+p6u7LJlg0isArITL11cB+fH+oM
	 IyOidZ9lo3sGp3lYyhMjbvborCJaqitx4nDC+iu3gbmsqYjj1aP3qVlL06L1s/HlDs
	 EVuT6PzCvJHIR81O6KREovsJ3TKEitO8wwn6Url2l3drR88Bvr69cuwN+JftRE05s2
	 GebL1lZLvO2cunJAGZElw5vdIUkDqt9zOi4gTBVmKHGVDaamQD8mIqdqACg2x3xDoH
	 UBMPF8QTPZKsQ==
Date: Fri, 7 Aug 2026 15:45:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net] selftests: drv-net: so_txtime: only send test
 traffic to sch_etf
Message-ID: <20260807154525.7a970468@kernel.org>
In-Reply-To: <20260806173702.3857148-1-willemdebruijn.kernel@gmail.com>
References: <20260806173702.3857148-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 13:36:57 -0400 Willem de Bruijn wrote:
> Subject: [PATCH net] selftests: drv-net: so_txtime: only send test traffic to sch_etf

This should probably go to net-next - where it does not apply.
I'm not sure if we documented this but selftests should not be treated
as fixes, unless they are packaged with a kernel fix. Or you _really_
need them in the current kernel version, but then you have to explain
why it matters specifically to you.
-- 
pw-bot: cr

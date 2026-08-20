Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98F439F7D
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226274; cv=none; b=gPwo4N5berA/OhiwoA464UGt7Ac6SF7GxtgC2NjqVOY9BjfoLiPvYkqUGpeNZv5zPvnHP83iAD2QcUFF4SjLWkftpg/TMt+uWBFqq2dWvHS5Ox2tWDFxqPPNR5+u75Ya74FZ66k8LgLkDka225GXkfluxxdXzg9IYOmGAesq9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226274; c=relaxed/simple;
	bh=TSh7YwwIWCPjwRVgW5ShiqHUgASfxk4WlN/Bv8g1Pjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2CNJ1qd8LosBYRJdEHLQbBOsV6lOsGhD1RbIgnjGQn9SuKf9AhLWHOmt8PyUzt/2/FlXASYr12Hey/H+3kQ/l9lXOGTUiIvGHbdjt/gDfXcK2+oIpcs2ror72gk3oFKnZ09FOXsEYmNyJCK6Y2dmRyGR1EAy/fD+xY+nBQdor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 248BC60225; Thu, 20 Aug 2026 13:44:30 +0200 (CEST)
Date: Thu, 20 Aug 2026 13:44:29 +0200
From: Florian Westphal <fw@strlen.de>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
Message-ID: <aobonf659MB1Rc3c@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
 <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
 <CAM0EoMmaXyX+SMMLzE=6pka3p8a1EFatDX+L171XE6qGfTP+kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMmaXyX+SMMLzE=6pka3p8a1EFatDX+L171XE6qGfTP+kQ@mail.gmail.com>

Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> sorry, my brain wouldnt let it go: nf_confirm() looks very promising.
> I was tempted to create a patch and test it but i dont have time right now..

nf_confirm is the last hook in the conntrack pipeline, so not useful for
this -- all of the exposed code runs before this.

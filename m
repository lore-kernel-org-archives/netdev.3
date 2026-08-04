Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A046AF1B
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853043; cv=none; b=duUqqLHLWbk2ERWGHXe15peZxqKGzXSkMybmAyGg5p2hHuKaV5LspnVf5IEFeoig5kRYPJdxgEANvmnJJaXHPa28365qXP5RjVAX8gR/LQsf641N2zEa/eTdbhI24MBW+3anTuUv3+3TA+csv+vyKdr9JW4RgKxpZp4GMBvNZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853043; c=relaxed/simple;
	bh=A5gba81OejbE/9Nj9qSphyZYNx9etrAlfFUx6XHIVF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+jP12xboR9+qC3Abgg3hGn5oFkIXbspnOQ4IR3sumMrTESSqAK6i3YlZ/Glrcdg+cxjn8EEo9OBP5lC+3oh7BNPKqMsqhqqpWzm8SkgVFfBbozE6OdxnyB2vOUtA113J8lGWk/oh+mUnQHdubZ7UE6f+29Osg2R6zSMw/kvrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KynGviCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KynGviCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A464F1F000E9;
	Tue,  4 Aug 2026 14:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785853019;
	bh=MoN2dW1ZOtdpOKtAj1/P+7YlvCADCaNubDVISfmUlB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KynGviChGpKkH5BGaUjFuGYljb7RNDsX0JF94vDaAwK0OynxqgFMAWizWmaERnZ5R
	 HnEW/VomF2T56TrJUNS4apcRUqQ+DqAYfjONipMO3U9gTTTGcGP0iSNEfEXda/d5zh
	 +m/Sp0CQZLrFMHqNDo76JKCS/vP4DXxujO7kyptoBC10Ls77qINa7z3objI0Jv8WzW
	 FXj490osJwzLVdOljl5iEpUlNiU0DrdvavKT54AcjoqrTLeqhQjsH91VTOClgIIX3S
	 2a4L1sOXJkZj7PrsDB4fDwHFQrzmnbq8ozUBjjN0d1jMhBQh6z60QxdknXQN+AUB3a
	 I4Th1MyXsmHeg==
Date: Tue, 4 Aug 2026 07:16:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, Eric
 Dumazet <edumazet@google.com>, pabeni@redhat.com, horms@kernel.org, Willem
 de Bruijn <willemb@google.com>, Max Yuan <maxyuan@google.com>, Pin-yen Lin
 <treapking@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Joshua Washington <joshwash@google.com>, Danny Gonzalez
 <digonzal@google.com>, David Decotigny <decot@google.com>, Brian Vazquez
 <brianvv@google.com>
Subject: Re: [ANN] Google's Netdev-CI for IDPF and GVE
Message-ID: <20260804071657.03263c97@kernel.org>
In-Reply-To: <CADWJPTus-1pXZZeYfGqJ1=OR_RPZ5Wq=H2tc1S0_tGi1fGFNEQ@mail.gmail.com>
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
	<20260619115905.051eb340@kernel.org>
	<CADWJPTus-1pXZZeYfGqJ1=OR_RPZ5Wq=H2tc1S0_tGi1fGFNEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 16:15:35 -0700 Sheena Mohan wrote:
> Thank you Jakub. Just wanted to share that we are working on exposing
> devlink info for both GVE and IDPF drivers.

Hm, but please don't expose kernel version as running.
It will spam the aggregations which compare "platform changes"
with a different version every week for no real reason.

We know exactly which kernel was run for each test, 
so it's also useless info.

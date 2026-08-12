Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23516345CAB
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574627; cv=none; b=dvTOm0JiLxFkb5sXOz3WZl3tEskbPokzWwNQFueuR9RsWvtQdQMMl1WdFyDGf+VI9BYYZu8zauPeB/wDGiVaT/Zlm8lZ4ogxTVxmf+RMhp/OUw+APfxNwwbNEDa25r4+4f6OV1VGXT1KASiArDfxIGZNCD5UkLMTKDZQ8shEq0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574627; c=relaxed/simple;
	bh=q2o/wgcIC/ToBULEvnjoqe2fliTTvkZv2AhrJ2l0g8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCPiIxdkleMyqmnKt6wLoTWQ8lkT5SWEvvKpNwFhlsuJan96R2lMek1wLdjuGL8ipM7uWK/Dnql3q8phyrZ823Knh2a9FiOFIRViV2R0CBEwfme+Y0Ntf82d5YUSAsVYgSMpkrr0xYPh1UKKBAm63VcMJwyjBJYAWMbvJ+mKsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjZJDECU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjZJDECU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D1F1F000E9;
	Wed, 12 Aug 2026 22:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786574625;
	bh=SyVD2D2bZVenWK5yd2bftaX/9VKWlPh7NnIafS/kPgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MjZJDECUnZ6ZVSiI8ImWZqDUfO+Nf3HhrgD6rpx8V90cYJXvyxf3IqlTavgLie843
	 f+uStMKVZO0K+FHQgJp1s+WtE8vIe9zkxQKTXQCQTXH32FlF69lhm4lUsdR0pkPtOg
	 8l4V93uSaOS8WiU+NApAE+flw9/bR2/nNJPFKJgXQS9FcRcf+BDch0feH7w1RnDf56
	 XncC0XMPnh8t/aSm6S19ldRkYcnp4bLeCVGId4y8n6GK9R9ahn+fnspceLDMz+cWna
	 o2kcNex8hI3wJX+bbFNuZWdf7o+Q8HZta/PDOGlncEdYZxNklscAvuFzqCCy+sfW6P
	 z+yB3DiXW9fVw==
Date: Wed, 12 Aug 2026 15:43:44 -0700
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
Message-ID: <20260812154344.39afcf7f@kernel.org>
In-Reply-To: <20260812145422.049f49fb@kernel.org>
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
	<20260619115905.051eb340@kernel.org>
	<CADWJPTus-1pXZZeYfGqJ1=OR_RPZ5Wq=H2tc1S0_tGi1fGFNEQ@mail.gmail.com>
	<20260804071657.03263c97@kernel.org>
	<CADWJPTu9=k5y5WmEfdFiemhg+sRA0ZW5e5J_W_Wazrt+JKpMyg@mail.gmail.com>
	<20260812145422.049f49fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 14:54:22 -0700 Jakub Kicinski wrote:
> BTW I noted that the branches tested are a bit spotty.
> The gve manifest only has results for around 33% of the branches 
> over the last 3 days. Some of the results are nul so the run hasn't
> completed.

To be clear -- some of the results are nul, but majority of the missing
branches are completely missing.

> idpf runner looks better but is also missing around one branch a day.
> 
> Is this something you're tracking?

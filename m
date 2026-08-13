Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78006184;
	Thu, 13 Aug 2026 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584168; cv=none; b=MZa9lYdUzmoxTkx2CBRYkEdRNQR6Ejy0KuxDqoFm5+owbGHcBfctCG7hpE7LuhLX6O6zKBqNaKr86CX5beS7FAURykXLY7ttEQeSc6HU3E7VHs4JohveG56ElXTpDDFwD/G0Ih+pJbIgiuhVdjaRUqYjryxzToav/iMG7PmRKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584168; c=relaxed/simple;
	bh=F+N/icf3Zx9v/uIFkHOpMsOvGdFgx+Vyq8CpSpowaSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yl0R9nixQkjUVBsufiThCSgr5wmynnrkTKYH+DCzNL2X2W0MYjjDpAJBkEvhX7UejOJ4P6rk6M47W+Sm2nymdBnbjWDMRHYQ0PH4WcsAwlniFVkwGwkd2kG+UqsltjED+onVEKjoAfzzIvSpnaNgOwP0FBu3Vz7qvpHovK5qCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeYlKCl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeYlKCl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF141F000E9;
	Thu, 13 Aug 2026 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786584167;
	bh=Oaavj3S2pTTQyahi0XJZwVFn0hNLdLFTWFv18+RPZOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EeYlKCl4QBitrD+/YJen/zq9BU72qZbFn3q9SQWlNpEImok0rogHgjpav+X7SAvkb
	 EL6AQ34WkZ2SmhSxC/0LYLeSc7cE4rSrNlPjh0rkmKeUFisZV+e3mwINu79szFC7qn
	 tLWXDtfB7lgufYMCfk1AupdY/B0iNrjjJK/24l7p2/K5xjPG74VzNuV4p0Za8sAHkU
	 N/nGh0tOpXsCKJdlr3yh1dRovmQABQNAbBZV19Su/O7LWYLXdtJHn+hCSSHYZ4af6W
	 8L5qAuRvBTj4egrIbOuUzR7Rgk8IsA6LonvRAAmO3+KmQqCcFc1J0JfHpAmNWRSYki
	 bH0Qn2e1ZkymQ==
Date: Wed, 12 Aug 2026 18:22:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Lee <david.lee@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, Kyle Zeng
 <kylebot@openai.com>, "Dominik 'Disconnect3d' Czarnota"
 <dominik.czarnota@trailofbits.com>, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: defer qdisc freeing after failed
 creation
Message-ID: <20260812182246.3df00681@kernel.org>
In-Reply-To: <CAC_etQEByQLf5pMWzbyVfT3xtzereqEgu+XZYmwDjyvpRCzxjg@mail.gmail.com>
References: <20260805102505.740806-1-david.lee@trailofbits.com>
	<CAM0EoMkMcpE4JZdroYvVuPRzUC8Xwbwv3p4+qkABj=Qk55kWvg@mail.gmail.com>
	<CAC_etQEByQLf5pMWzbyVfT3xtzereqEgu+XZYmwDjyvpRCzxjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 00:58:27 +0900 David Lee wrote:
> [  230.057740] ipip: IPv4 and MPLS over IPv4 tunneling driver
> [  231.667279]
> ==================================================================
> [  231.667738] BUG: KASAN: stack-out-of-bounds in
> __ip_options_echo+0xdf7/0x1860

I'm struggling to see how this is a repro for the qdisc lifecycle bug

In any case -- if the fix is really correct and there's some real repro
shared off list - I think you're deleting the last caller of
qdisc_free() so you should inline it into qdisc_free_cb()

So patch as is needs to be refactored. But please don't repost just
to refactor, we need a convincing repro first.

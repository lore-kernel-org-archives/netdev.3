Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5717262E;
	Wed,  6 May 2026 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778026819; cv=none; b=J8oH6BPjLOcs2urHu/RjkgTDINVdbG+ZZRnwDiDOfWwMOrdIbTTl9V7tQ54YhDIlxUmLt/AyW0TsMtT1KPJJ5rEDsduFr3pjz9H7idA1K6bO6bmphbBu00qCsLn0cQC+WLRpmLVBwABDnNuUu68QO0gsJW8yIfLBDzR+8L4haE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778026819; c=relaxed/simple;
	bh=vYax8JSZ0er4C7oSsAtrxOvM9sWuGJ0NNDFrdh9Hbq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVwW2L4rwoSOSRuAs3z23HV8zeEB/GE9SMpdUhZEwFZV9HypJpI1gYnUw52ALmYcVRKve59Ubsb80elf7kbm8vjRlZa+9RP2y0YC4/VPVwusU4p+smhwDqYmYXPb6FeayMx2FqXb7zMMmJ1VvXz+ezz7Qo4R5iiG61/oK17WxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhP8M1a+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhP8M1a+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669EAC2BCB4;
	Wed,  6 May 2026 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778026819;
	bh=vYax8JSZ0er4C7oSsAtrxOvM9sWuGJ0NNDFrdh9Hbq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YhP8M1a+9928xQWiO3gXJPrLYm1pVeIm8DDYtGoQ5ASM2eo6NKiow1lTV/0wiEmx8
	 VZz5MPes/YaBH3ocnwoygvkFPL8aYKLlOmNgF0r4TyVsjOH+bvxE2Ivp4hPF+jEj6k
	 g68a4S2L6kvAC24YZfsq1wrz1keViHAipbOmf+BKxRAP7G8b/5hPceWPVs/G97L13V
	 EbdPHN6oG0PpHwiWYlftk1A9xQEDHx8sss6Qjev8DCo3FN5rcj75S56hXVBUC8UMN9
	 0H+pCH7NCNnCeTYlDnr7A5yk07GCqdpe4ikABvD2/iz5uxbsbsSms468z9X1/L/1K+
	 +HuzmhVNllnbQ==
Date: Tue, 5 May 2026 17:20:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <marek.lindner@mailbox.org>, Simon Wunderlich
 <sw@simonwunderlich.de>, Antonio Quartulli <antonio@mandelbit.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie
 <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu
 <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>, Ruide Cao
 <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>, Yifan Wu
 <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>, stable@kernel.org
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Message-ID: <20260505172017.6caf7347@kernel.org>
In-Reply-To: <5990011.DvuYhMxLoT@sven-l14>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
	<20260504171051.2b3e47ef@kernel.org>
	<5990011.DvuYhMxLoT@sven-l14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 06:46:11 +0200 Sven Eckelmann wrote:
> On Tuesday, 5 May 2026 02:10:51 CEST Jakub Kicinski wrote:
> > On Sun, 03 May 2026 14:22:33 +0200 Sven Eckelmann wrote:  
> > > While reviewing the fixes submitted to batman-adv in the recent weeks,
> > > further problems in similar or adjecent code was identified. This was either
> > > noticed in the manual review or reported by sashiko.dev.  
> > 
> > Are you CCing netdev to get this reviewed by Sashiko?
> > Please don't..
> > We delegate code to sub-sub-systems to lower the patch volume :(
> 
> Because of `b4 prep --auto-to-cc`. Will now manually remove you.

Ah, I see. I was asking because I don't recall us getting much batadv
patches CCed to netdev. Maybe it's simply because there wasn't that
many of them to begin with.

If the rate keeps up let's add an X: to MAINTAINERS to avoid
netdev@ being CCed. IDK if that's what X is supposed to be used for 
but we use it for wireless and bluetooth already. The PRs still
flow thru networking tree, but there's no need for netdev to be CCed
on 99% of the patch submissions.

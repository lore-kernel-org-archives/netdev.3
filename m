Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FD3346B4
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961882; cv=none; b=enFx6fC30ixkQfTMhvjYnHnJTvcc+trvjdt0Tzf+9EbuamqZMp91UkP94PAhibVB8cOFhQeJFefU5llMP3spY4EnU+lgLnISh2wPKZSlwLKf9pkzMOTmWlbFHU7jielZgJK3ihGLo93neioLnnLHjay+v603Q5/vUgBUzjLryVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961882; c=relaxed/simple;
	bh=FoYu4eYuBWDOUZqS3KLzzsScoQ+SdhA47tR8aCITXjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYFcTBEK/e3k95pWHmFXg69hw+DBZx1g34Cux/zcAZVjy+VLMDEU1RT8SEgXpfD7+bAEQiBr+eVaPRYZSjK0SqBRQvjmk7cEfve0XjEvNZ6BJW5tOLPvexwwJ227SkZ1oTm9L5q2TI0ZmawG0NW6wnYIV2Rf41VIyoxqtVCKS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du2gL1Oo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du2gL1Oo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3791F00893;
	Fri,  2 Oct 2026 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790961877;
	bh=6FUf54KXhlKri5xVMrzeAnLxbKhsLu+bP+o0JGi4sp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Du2gL1OoyIzcfx5DcjYYjB+GutCSLzSnNXztLzr19LHDX45pDsxLPVEhGxQBTJGJf
	 RFSnYFA6xRNFTkdkUN4QvIkCAfHVEIli3uJREa2DtmSVKjHr42WqCnNX/wF1R0MQ2M
	 oln7jH1pMIidH9xbTkokLUJr/1YplyHXrRk5cOOfl2wBWXl9nPd4smis3754L4ub1H
	 hBMQXgaqYgBx3JTUpXyZfddbl3DrXzFoZ3cniFPPtNVHURdYOFU1Bl0f9mJ9KFy44Z
	 E5dZLjDbSW+ausVboxHjr/uwecDI93EtMNssNXUW6Ym6wFn59iCUPFa8ZQVmaJZRYa
	 l7EIQhiSqdphg==
Date: Fri, 2 Oct 2026 10:24:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev-bot+sinfo@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, joe@dama.to
Subject: Re: [PATCH net v2 0/9] bnxt_en: Bug fixes
Message-ID: <20261002102436.574d16b8@kernel.org>
In-Reply-To: <CACKFLimaQ93kqXsKn=VhaByUfsi51HEqjVmteNyPA0z4uj-4Og@mail.gmail.com>
References: <20260928041712.3467803-1-michael.chan@broadcom.com>
	<179056950861.31693.11019543022435274443@kernel.org>
	<CACKFLimaQ93kqXsKn=VhaByUfsi51HEqjVmteNyPA0z4uj-4Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 12:22:38 -0700 Michael Chan wrote:
> kTLS needs to use the new MPC rings, so the ring accounting logic is
> touched, exposing the issues to Sashiko.  These are pre-existing bugs
> that affect normal RX/TX rings when FW is running short on rings.  The
> issues are real, but not likely unless many VFs cause ring shortages.
> Patches 7, 8, 9 are real issues found in the lab or by partners.
> 
> >
> >  - What hardware the change was tested on. For driver fixes please
> >    mention the device (and if relevant firmware version) used for
> >    testing, or say that the change was not tested on real hardware.
> >  
> 
> The changes were regression tested on the 5760X and 5750X chips (the 2
> latest chip generations) using production FW (237.x.x.x).

Ah, and to be clear, when you repost, you can just put this sort of
info in the cover letter. Doesn't have to be repeated in each patch

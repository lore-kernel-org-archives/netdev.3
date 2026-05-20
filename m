Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084293BF665
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320043; cv=none; b=h6wXj09yx8g0djYSvkJ38OxeGTuDOJisb8h50SJgZ0mAQyxHGTLqkNcJqgv+8xWtgOqq1EaVzBPQoPZIIAg8YchV7h3oq4EsxJ918bkqlq8kL4pVT+Sq0CuRjEt/4StN5EqruH+uxu9MXT2YnCqmubxTGTFYGqwZWv0KolDtsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320043; c=relaxed/simple;
	bh=3ihbkgf/GRMLNZARgg66/Us3ArMauzPsIerUR9v6piM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyg5sMK3aYMPUA+sXxLXYTsjD1n7jqQnaL/Hrrm9tv6Sf/rqCApel//K4wqOMYfHKQ/hciKaTEWyVMl02KD5xsG2z1wDEVOxCRjbu+EFpoLKHZDO6sMffJgHUNp1r4z4o/9v1p0rE0Z033ODNoGb53ZAaGe8ImxhkQFjD+B+PpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNbtxols; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNbtxols"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0C71F000E9;
	Wed, 20 May 2026 23:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320041;
	bh=0shzrTknhkac4cyolV3ejF0Sew8mao+ZQFoxNbH24D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aNbtxolsc+AF7FtqMjYXqrnygFGco5gcihV91/JI99EdyzvrRnetvO+OvN5BUc0+u
	 YxY566v76KzBgdfkP5whnff0VJmaGYAGT12T+/WQRt5NLFdOHlDKifiTdGabf3xcLO
	 E6YtNv0NxgsPaatDK97i+NIGiY5Ekdj6jubBo4ZZrduKQaWXO2XuWfKnHjS1SD8xDT
	 VX/odqjYfZY1ln7wL/DE2BQ+VZgmBgzF3W9vXX5qWy8SPVem68H5sFMZDudIuBdnkN
	 7QADLdy/Q2tGU8rZqdaUHaHzaAzripI7sfymLorO02N6DbC1VE12UqDrb2wFnnUNeH
	 TgIBkk34/GEXg==
Date: Wed, 20 May 2026 16:34:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hmohsin@meta.com
Subject: Re: [PATCH net 0/2] net: shaper: fix VALID confusion even more
Message-ID: <20260520163400.72c24ef7@kernel.org>
In-Reply-To: <20260520195428.GA1506108@horms.kernel.org>
References: <20260515221325.1685455-1-kuba@kernel.org>
	<20260520195428.GA1506108@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 20:54:28 +0100 Simon Horman wrote:
> On Fri, May 15, 2026 at 03:13:23PM -0700, Jakub Kicinski wrote:
> > Sashiko reported another pre-exising issue in the previous
> > batch of fixes:
> > https://sashiko.dev/#/patchset/20260510192904.3987113-7-kuba@kernel.org
> > 
> > Turns out I over-esitmated the guarantees of the XArray flags.
> > Stop using them completely.
> 
> Sashiko suggests updating the wording of the VALID flag
> comment in net_shaper_pre_insert as part of the second patch.
> But, TBH, I don't feel strongly about that.

It's very picky about these comments.
IMHO the word "mark" is not reserved to exclusively mean xa_mark
in case no xa_mark is used by the code any more.

> For the series:
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks!


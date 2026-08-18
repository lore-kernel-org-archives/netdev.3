Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490243563CD
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093155; cv=none; b=ezVxYGiN1008YWP8CCBq/iGMQjrqEsP1MWMFrDmT9fcus7mtILUGIxF4GbBnI8JyEs9wDrAd1zS/c26jzTbAifVg2Sr89wg2YUS+ra7dU50Prf0j09fv9XzltOj2LqtC1Nv0/jmZ/zK3xAlHd84qOYHX57aA3b9AiKt0BmWbrxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093155; c=relaxed/simple;
	bh=NVSWY9CyZXcaIY9RnzL6ndJ3jHJCpP5qHw71/MRr7R0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDtO/gVtjOb+D5w7Gc5oq7Rbi0hiCtvw74nlawslI1jGDgZSVJtbxmo32hhZCHXhtokphR3XJmTeFe25nziygsBMXGbvv8jw/y3LAMmkVzXHZGgyacldpFL0ug5XkqdNjjY9bjFMKHIOUce6fJbFrFmOCXCvQ+/CteGGrvNL/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkl2cjwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkl2cjwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B091F000E9;
	Tue, 18 Aug 2026 22:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787093154;
	bh=aoar5mkvyGgCGTX6ouCF5fz6h0wFUfaX3XV4w7Mtzgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mkl2cjwD2doHk6+E/OJgdyR1gZujhzFb8Bi3vIsSy3T83lJ0dlBV9gH1nOtlviI06
	 HT2CMwIDJR1SDuDoIzn4aTXEXt4IlrwJH7XZOrtoKVFwi2VVyoCrvqkqL3QB+553Rc
	 SGJ9r3WtRqBN0W4VfnnjZHcueBExGucKlIWsu2H+PzmruqeTEiXrNaxWQyf+kr/Jff
	 d1G8CNiZNxdx+ybiPM+8+Qe4muLGGpgxKoPilFTZaHXEEmiBned+8RK5rGgmTuiJkl
	 ieN7KXX3yVzS9VGeQi7mWZIj5SwOGx0n+6nR9XmFVcJHxnI/MTynBC5QkW/W/vDrRe
	 5Xbne/jQtueog==
Date: Tue, 18 Aug 2026 15:45:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v10 net-next 0/3] Implement PTP support in netdevsim
Message-ID: <20260818154552.3f68781e@kernel.org>
In-Reply-To: <20260815063148.2952-1-maciek@machnikowski.net>
References: <20260815063148.2952-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 08:31:45 +0200 Maciek Machnikowski wrote:
> This patchset adds support to the PTP HW timestamping emulation in the
> netdevsim. It uses existing binding between netdevsim and ptp_mock
> driver to generate transmit and receive timestamps.
> 
> It also adds the selftest to verify the hw timestamping functionality
> running over netdevsim.

FTR I held this off because I wanted to check if it passes on any HW 
we have in NIPA. First there was a bug in NIPA itself:
https://github.com/linux-netdev/nipa/commit/459e2575ec36bbc47659db8a455a1b2eebde59b3
then we were missing linuxptp on the runners.

Next run will hopefully tell.

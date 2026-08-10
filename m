Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E744605E;
	Mon, 10 Aug 2026 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395155; cv=none; b=lRs0V8WuAWpIgiIGYtcuKxH7L62N1rfMZ7afzaZ14Vx3UUudyvg3lXC6VgBT+G73y+LWfhdAcu8Jz1SIxB7MWuiNYtSZBrMFOX/bMrbljJ3TL6irSx94i4aLdxNOTLbtwE81l2Phue90aQlCMwdHlsuqFeytoN0IUWgCpUTjeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395155; c=relaxed/simple;
	bh=QCqGnaALgJuRMuCTxKBp8OOCmLa+70KR6YCDU9sJfWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVrDeUwdf0kCuwRIX5Y8vC2jXCMJ+DoznxPxFlZs3l8Hpjjq32146r9yLzI4aCIgKBj1KCgyq5JIr+lXSJxR4SBoO0raQ1BlZHdjKn6AoH11hr01AenKoYTNjDjFpRWXena8PF1Ydb4n94cGsN+xdiyg+XpPcEDjKKBPACp5Rsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI8RfS9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI8RfS9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CDF1F000E9;
	Mon, 10 Aug 2026 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786395154;
	bh=chea9XqHSl9lBchZUjHYsJGSn/igtumN2iWPUR2WquY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MI8RfS9aD1z71W/kUyLQ1EBzCiK9GvRZYV/SfaUFloNNfWhftY3rl6RDvZZq2BD/u
	 ol3/EoMSl3bgt4ZNfgpZOZjhWU0HpkIOhk/UEx9xFxdHNLdu8Xlq/zstIl4Q84reLg
	 Za2O78iq+cNlM+gbGGiYk/igowJkKK09Z5CxPHKzT6zFCBrG+xmKv3XcUmnrybN0zO
	 uzrBLfQWtOr89yWIWYU8St2VI7coPJuCHJLEvGwP0DueTi0ZD3GxrtO8PNuVDnPAqc
	 8JQHqDWEuCl/bozo/odgnVQFCo3nd5xnfp4Ghl/EGT2UEqlR9PlLlg1qO2aX9LoUUa
	 BgnpMDRbsUQjQ==
Date: Mon, 10 Aug 2026 13:52:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, github@szelinsky.de,
 o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: pse-pd: guard regulator ops against
 freed PI data during unregister
Message-ID: <20260810135233.4be3dc5d@kernel.org>
In-Reply-To: <20260810154327.21e71ae9@kmaincent-XPS-13-7390>
References: <20260711121611.1639086-3-github@szelinsky.de>
	<20260717111042.446842-2-horms@kernel.org>
	<20260810154327.21e71ae9@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 15:43:27 +0200 Kory Maincent wrote:
> It would be nice to have it accepted to move forward on your PSE notifier
> series.
> 
> Jakub what do you think?

It'd be great if we can figure out the safe lifetime rules for pse-pd
from all entry points. Specifically the sysfs complaint on patch 1
(assuming it's real) makes the series seem like a bit of of a see-saw.

Let's get it reposted and take it from there? We have made significant
changes to our netdev *shiko instance, the new models should squash the
false positives (known on wood).

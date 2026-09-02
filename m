Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AC4A92E1
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363485; cv=none; b=YZc9Qp71b595WBCRjZH4A4Aoc3K+vFV+DfhqEtG5UP26i7E70CieRm8QowlW1X0zR6oFFpDUM0gQxrAhWlhBQ92SauMSLP+Iw6fA1CRLX6UFFcHQiTJ7Gd+XRS1O1q+vh3DEGCgo9kaX1sFnqHrNzRSbrhJkF1jgt+IMZSJtEpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363485; c=relaxed/simple;
	bh=uXX+d2SnUuAIfMrBHrm/jE4suqBh6IcP73BNUp6tSh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZS5qwMBWYKCP+vYf0slxxKxfp8Cl+dGMYV5RJsM4P2Xrh5WrVrSOJnbjGNx4msft8qa3SCHMq0qShvyPSDJq6iAjMyknQejyf4CMLMFMTC2iU+r6NPOO2GiDoq8/bM4Msg8C7E3qaTuZTcw22aX0XW6Ih/tXYnANiV0Px/p4GIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 42A9010042D1E8; Wed, 02 Sep 2026 17:37:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 406A91100AF010;
	Wed, 02 Sep 2026 17:37:45 +0200 (CEST)
Date: Wed, 2 Sep 2026 17:37:45 +0200 (CEST)
From: Jan Engelhardt <ej@inai.de>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] man: remove libnetlink man page
In-Reply-To: <20260427172827.300214-1-stephen@networkplumber.org>
Message-ID: <00pr87n0-6234-r200-osnn-npr6o662snn8@vanv.qr>
References: <20260427172827.300214-1-stephen@networkplumber.org>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Monday 2026-04-27 19:28, Stephen Hemminger wrote:

>The iproute2 libnetlink is not a public and stable API.
>Having a man page encourages users to think it is available.
>---
> man/Makefile          |   2 +-
> man/man3/Makefile     |  18 ----
> man/man3/libnetlink.3 | 200 ------------------------------------------

If it is not public, why are the header files and static library still
getting copied on `make install`? (What's the "secret" user of this library,
if any?)

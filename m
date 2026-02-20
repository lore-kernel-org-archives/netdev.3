Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673322DCC03
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631819; cv=none; b=Pkm1zZARpAiMF9kJO6IftcwJxmrmsMAzQ/bi8vFpqIHjdvy+mUFRAzZsmYAK4ykkaikBdSxUWBRi1EXcJBzoDAM6sPX5vLxo2kr+P9ozBok/Mm9fQS9CMAdbe2CK5aDxGWHEqvMbo+WM1aydKlHnfaaj7HoLiRqqagebkInIgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631819; c=relaxed/simple;
	bh=LKxC9G4UYXLTZYebYqLWaIJRz21m9bJ64d7X8EA0544=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLn0Bx6ey9rymDGpvI+vnSIy31iY7s8PvYzsfnGB6tl7lkihfv3bNfdDxZPpKYaLaATdUzZmuTI/S9a1HNBFp6WF3RPGDHywNDbQhNB8W4tUNZHp4QVtR+wn09d3rFPWcoSjgEHh1xR7Lf0HmbxpYArthdMgV52wizEQd9R8JFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6pqJ8as; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6pqJ8as"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E51C116C6;
	Fri, 20 Feb 2026 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771631819;
	bh=LKxC9G4UYXLTZYebYqLWaIJRz21m9bJ64d7X8EA0544=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l6pqJ8asxoGF34+i/VYeWW0+aBjqxBwcSXQKV4KhaDkNC9oW2lOPaxlOLtDDM0zo3
	 kJ6/fobIrwXlvrn4V8CkFQNos8NRp9I+cUdnNaf4jJVDFfFg9uNB432qpoFeELldtQ
	 P/92n/kxfWPxYWzVJXzikoGBAflzKYifGxZCyogW77GT5zKcWxbmuFLINShtp3KzjU
	 HxpL3PGSjwbPwQk8SiLKmU76CaSxUB81MN074+bXxlltSZog+PE0bY1SmnPJXVEkcX
	 98tYOkwELvpYJM9Spdauj9ChH3XRWajQ5U62NbirNEyz0kBysR08k4W/9AJ5TtEukD
	 2+jzloqxMC5sg==
Date: Fri, 20 Feb 2026 15:56:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: satishkh@cisco.com, netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update enic and usnic maintainers
Message-ID: <20260220155657.45c0575b@kernel.org>
In-Reply-To: <20260220082157.GD10607@unreal>
References: <20260219-enic-maintainers-update-v2-v1-1-c58aa11c2ea8@cisco.com>
	<20260220082157.GD10607@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 10:21:57 +0200 Leon Romanovsky wrote:
> Jakub,
> 
> I assume you will handle this; is that ok?

Can do, thanks for the ack!

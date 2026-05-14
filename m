Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF41FBC8C;
	Thu, 14 May 2026 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717909; cv=none; b=aEA8R3KzDbKFdg1FVn1I6OCdThFcu4upAzFxhwNk5WuzcLJz/7BIUamSkPa/n8bDi8mBF2OLEzRQeh/xx1TsBGTX7SwFCLl2GX2xvaKAMFreH4W8tds3W3uSpP7IkyutotWXrmOeH8d8Snu7d6AhCT0C+vzLtEIWn8X2an6Q4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717909; c=relaxed/simple;
	bh=pORE/oc1FI1GuRbtX19cTKcFDlc1G5qJJa0C0hy1l9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nz6hFMS9wLMwplb3yBAlLlsr8T380XlOZNyKvOF3scCAU08aQA4RNY0pcweEPJgaLRoWjQXGjMv1NjEsRTNFAczL8IgyUEY8aZ9Uv1t923sJgkNjiodOcLUbDQNRb7jNmw0ojKse2LLw+jC7YyzRzrqMJPIIkd4unmUTbXkrsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMOuiSvB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMOuiSvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D80C19425;
	Thu, 14 May 2026 00:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717908;
	bh=pORE/oc1FI1GuRbtX19cTKcFDlc1G5qJJa0C0hy1l9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMOuiSvBD10Zi1+F2qWALX9QlnB6gFs9w4sxZjvPWa1m/NLDyQdcQ9vXie4FYFYr7
	 QJw8e1LJQSgYUOzT2oJK7PkUBOvV06NPwNaqQCG5tW6VyBLD/tJ9H3krcff4x4jZcb
	 3i0H7aBCAPG3ujWYfGSju7T6I5B0Imk+5Cz0SbwWqtLRxAQoPwLHO5dmO0EVOo242L
	 Fh0ceHE8Ssv+VS8LLEuJNUIwYZ3U7NfnhgAA/LmfSU4ygKxGhOJF8mVlhp9Gke4fxS
	 ed5yMM7jfwon2KWlQqjNB6VwU9f6lS43UYNdxZYwNgAtypW77kez+ehfhtz6d9YqUF
	 ad0z99VSKlLVw==
Date: Wed, 13 May 2026 17:18:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] FDDI: defza: Sanitise the reset safety timer
Message-ID: <20260513171827.034a4045@kernel.org>
In-Reply-To: <alpine.DEB.2.21.2605131524010.46195@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605061216430.46195@angie.orcam.me.uk>
	<20260512180631.7c50adff@kernel.org>
	<alpine.DEB.2.21.2605131524010.46195@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 16:29:37 +0100 (BST) Maciej W. Rozycki wrote:
>  I guess it got lost in the lengthy commit description:

Indeed :) Thanks for re-explaining 

> > [...]  For the transition 
> > to the uninitialised state switch to timer_delete_sync_try() instead, so 
> > that a timer isn't deleted that's just been rearmed by the timer handler 
> > and needs to watch for the device to come out of reset again (again, an 
> > SMP scenario only). 

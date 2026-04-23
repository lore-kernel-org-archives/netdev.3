Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793411E89C;
	Thu, 23 Apr 2026 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776910097; cv=none; b=P0t1qrOKw6+0IbIQ3o4YxFVNDfdhqXP7GXUnNc+OtJTTcVNWp5a48vtxmGxVa+ZbcH0lCQRdRs/7Jtc8rpxuljamTjftIeQEQJUOVPIQvVMsfMLfckUpmzq2wAKcX5xq3AknV20hgTsoqWKqtDBM4X7cbmvgPFeGKGiUUw22XpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776910097; c=relaxed/simple;
	bh=p+OgDUIpCkl+jhXsDz8GorMNIQCQGargERqzgVxIdFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvhC0A5ID5EA0C4veiOEJ0++ryN/mgczC33X/8VV9LkbOW5vvaOK2AJJnn8/Mo7lB7002PAPvzHl8JTOdtzVmxCwjrMz2UIKQYMj+hC3UXtYc/Ble3pWopJIBc+2fTOLgbCg+N0SoypFRIjpiG0NSPvfomyO0KIPJw0nYnrzq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3jS/UUT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3jS/UUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08AEC19425;
	Thu, 23 Apr 2026 02:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776910097;
	bh=p+OgDUIpCkl+jhXsDz8GorMNIQCQGargERqzgVxIdFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3jS/UUT1OHTaOqRftSz2f8Ihn21LIkTLlbV6RWycUDjJCSQfISCXtg4YnE6DJ1Fo
	 HXrxpwYNA8rqtgAetjpAS+1e1KIz/stCgGQI1sXzBYznMsyDtd257gdp9ywL2GijvY
	 w3ljPDNk6UV3+5+d5UjHjNkjd7elS3UDacMt2TduJZcjgU3ifhswC37l+JJdg6wBwz
	 xFpA54i9aWHAtMjMQEkOUEV5WNiPKbNDIIPzzdQphqPePnaug6zp5dlhPitY+7i9wJ
	 4X55SAghGYJYRCyh8zEB4M8LbjwUlPzjNJ1hCO0xkrPna0Hcsy2Ze+wIFAn9wRHfON
	 z20vNnh3vRx1Q==
Date: Wed, 22 Apr 2026 19:08:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chuck Lever" <cel@kernel.org>
Cc: john.fastabend@gmail.com, "Sabrina Dubroca" <sd@queasysnail.net>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, "Chuck Lever"
 <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>, "Alistair
 Francis" <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v7 0/5] TLS read_sock performance scalability
Message-ID: <20260422190815.7f678ad6@kernel.org>
In-Reply-To: <3fc31ab1-23de-4381-b85c-5faa39169ad9@app.fastmail.com>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
	<3fc31ab1-23de-4381-b85c-5faa39169ad9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 12:41:43 -0400 Chuck Lever wrote:
> I see that this series is currently not in v7.1. What is left to do?

It's marked as Changes requested in patchwork, possibly due to
mis-reading of the discussion on patch 4. We process patches within 
few days (well, we used to before the AI swarm) so if in doubt you
should ask sooner :S

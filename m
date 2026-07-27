Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62F376BD9;
	Mon, 27 Jul 2026 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186202; cv=none; b=aggQgUvmYSSLbKMmJe0LIBj/V4blyMVyA9iwAZzS3/aWz2ZV4T3rq1FhsYr4oebNDlenUP3FTz26NMAGo1OMHYCYzk8fu3xdmM3uEDHm1MsRoxxVSuTvXv44ngmIVaIiHSWfb6MIAOjGUvJXWOat8OQHoK4KJ94t2QfwnkHJsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186202; c=relaxed/simple;
	bh=WUyvuxN/QNNZRhlm9podEWh9pL0UMmDY77NwxqF32PU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2dXFqK3f6ZhqIhuHZ0SP+lJVgIoPLn94BoqemPkvPBX0mzbFx6rXRmwVhdmmSi0S26B3zLrpa/kGSjC/ZiTsq7XlgnNzpbW1NCsFRBopMn8xveZ/s1lUbnYKn32tvKMDI8eVlIBcz4ZEa7ofzXwZ2e0vIuDmyPRT06c32iWWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFuyWC9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFuyWC9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA771F000E9;
	Mon, 27 Jul 2026 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186201;
	bh=/hvDCLN9yaanqanw3N57Y1lgkunH0X8W61CfDT4KCXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EFuyWC9gqpsAVGaHbTB3fs3+GAXnIRTz1PMv3HmQTo3s8VahQl/lnjJClAlmH8huU
	 PrMiG4XsZR0zoAf7JctUxGenhLzAEmUdeIWaJ5SRbLk3uYjU6lkAXeU1lw5wR3oyVG
	 I0J97N6EXUUuIQndZS1xq4hUrs/vWlMjxgyvdFgWNGyTXSTn2V8KIb0g6M5dCdXqRT
	 IdVBmIcjBmdYzPQ1nxmXiJLsO+uK7bArrqkKaOY2CPra/jGjSMzFT0pdbIgLPXMnDG
	 SJq6vrNBX98FThLCJISXg4wxNfN2U77JwSZBy8jmITB+9I6mmj3ONy+LX8Ug1hv397
	 ZUpSJG9ERpfXA==
Date: Mon, 27 Jul 2026 14:03:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Message-ID: <20260727140320.54185eb8@kernel.org>
In-Reply-To: <118da808-b9e0-4e5a-9094-9c6dc3740ff4@linux.dev>
References: <20260723143908.4019-1-maimon.sagi@gmail.com>
	<118da808-b9e0-4e5a-9094-9c6dc3740ff4@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 12:02:53 +0100 Vadim Fedorenko wrote:
> I don't like the idea of having a buffer in a global structure. And it
> doesn't look like you can actually serialize access. Imaging 2 processes
> manipulating this i2c bus. I can be that mutex will put them like:
> 
> 1. process1 -> write cmd
> 2. process2 -> write cmd
> 3. process1 -> read result
> 
> That means the data will be a mess.
> 
> That's why it is a really bad thing to allow direct access from the user
> space. Is it possible to add a property per command?

At a glance - adding I2C support via 2 magic files in sysfs is rather
odd. Either expose a real i2c bus or make the driver sends the
appropriate commands. We are opposed to raw device write interfaces in
netdev.

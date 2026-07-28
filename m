Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB54734FB;
	Tue, 28 Jul 2026 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277573; cv=none; b=AlSqib9g2RI4XfVKx9eVnwwG8LT+VAiDKRws+3UVpHyyM7d+js65wQsuVqpjcxNXhaNikL+I5bWj5AKPr2Tk7WDzPNFfKlDhN6Bb/c2V23YyR/FDYyFLp7NyImIGSpoYhTn26D5+L25jY6EGCaeSCxNz9GHpmzwf7FOR1CP+tLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277573; c=relaxed/simple;
	bh=g5n2+Mz+QSu+p3rsJ2zuiYYcRm6P+CCvZkxVGFQbR1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0An58jvo2TV9qdd7czePyBbfSzMQ1xygs6I6g6u4mS2YQfmeGWQwmlv+E7iiKpMtw4fCJFWfNg0PlxSvFBzn+Etklt7kLRnmTE2mjWKM1JMtPda0Oxndi5jMY8jDn8LAaZheetA8u/QLnmoqRZ9dxoyNV0hjgjQkVN8iWnubx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvraqWgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvraqWgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514F01F000E9;
	Tue, 28 Jul 2026 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277570;
	bh=K7uF+wYRo3Ivc/3M6nwc+kiDyxoC3kKE8HyN7z161j0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XvraqWgJhdgIxSJfh9I3rc+/RdFbeKffxtTwShSCVy7kYOysC7S0u1Gy48FgA+U/Z
	 KZOCIt+ojaTGPjz79PWXxZtELMwYmWHoHEEbkrgyU3g53HZIoFxiGlg98BoTwwgtuY
	 kJzaTEPS073IjwJkTekmb9m5QGoUrJAecJCaIRxPCPSIv0CYLVWS2erhGb9JrXVzAQ
	 ZBx3LDqA52G2EXivcOzK8X5mjCunITvtDxuMduIg7cxT/2h1dw0lFDRKdHP8rx0YpF
	 iRi/hL2xGLWdqxLzUur2yqz6FeqrK/F3dfHuG3P1ofD5cjfc3/6sa9fpwnb4dvMMly
	 I0lH1KQWqEJ/Q==
Date: Tue, 28 Jul 2026 15:26:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Message-ID: <20260728152609.10b4c647@kernel.org>
In-Reply-To: <CAMuE1bHMe3BHz6YoAgXXtP+TpBEos6jaHFpBNPYjFHXKVxd4_g@mail.gmail.com>
References: <20260723143908.4019-1-maimon.sagi@gmail.com>
	<118da808-b9e0-4e5a-9094-9c6dc3740ff4@linux.dev>
	<20260727140320.54185eb8@kernel.org>
	<CAMuE1bHMe3BHz6YoAgXXtP+TpBEos6jaHFpBNPYjFHXKVxd4_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 09:09:33 +0300 Sagi Maimon wrote:
> Thanks for the feedback.
> 
> My initial implementation actually exposed a real I2C bus to user
> space. However, following Vadim Fedorenko's review comments:
> 
> https://lore.kernel.org/all/c6aff5f7-e087-4bd9-b159-7adeb82e19f4@linux.dev/
> 
> I changed the design and switched to a sysfs-based interface for the
> ADVA device only.
> 
> From your comment, it sounds like neither of these approaches is
> acceptable in its current form. Could you please clarify what
> implementation you would consider appropriate for this use case?
> 
> Specifically, would you prefer:
> 
> exposing a proper I2C adapter/bus to user space, or
> implementing the required device operations directly in the driver and
> exposing only higher-level controls?
> 
> I'd like to understand the expected direction before respinning the patch.

Reminder: please don't top post.

I'm not sure what hangs on that bus. The commit message seemed 
to go into the topology but not into the "why" of the patch.

Assuming this is a fixed function bus within the device sysfs
attributes dedicated to what the user wants to do are likely
best. Again, hard to say for sure since I don't know what sits
on that bus.

Exposing what is effectively raw write over a custom attribute
is the worst possible choice. Neither does it use the standard i2c
infra, nor does it avoid raw access and per-vendor tooling.

Ideally you'd add dedicated attributes that are human-readable/writable
and have the driver translate the user intent into transactions on 
the bus. I'd assume this is what Vadim expected in the email you quoted.

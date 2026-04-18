Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48DE25F994
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776534213; cv=none; b=gxAobhY8r/JtYhzV382xnqZ9I/TeHXh/hTcBi8esDBPb/MK8noAUHB1hjF4jiCwrIPjgvrvGzCjG0CXyhYc1S3qaUvkoTXhQ6LrIq5v643ygeq/aRdd7ovmyzYv5iwlC2wEq77VnnTcc7qq6TXbloevUUIfxhFZOpjwf7tMsdwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776534213; c=relaxed/simple;
	bh=eHroLjO3dgQkPLgH1zxeZH1aoD6sBKgAM9uNfd8LV8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vr9I7wKyyhZ34P4BGBQILqk9mNGArK14XVyhHcWsCpCKbrUB3rBJRTCdMRo2ZXwlRoyhz+guZ1kClnXzYCnuftDWhWB8HRGLEajdraMOz30ymQxyKGAbW6l+ipfyp13hy2AOH+y24ffRc9HtazAjkiwMcw2FaoEqkwwWmoASEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7lQRVKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7lQRVKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066FEC19424;
	Sat, 18 Apr 2026 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776534212;
	bh=eHroLjO3dgQkPLgH1zxeZH1aoD6sBKgAM9uNfd8LV8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T7lQRVKzSBpBlqq3gQJtiDlTV2ZXa47LIQuTXLnJSk4lPrhzP8atiFzyrMaoH+EiM
	 N2x8p9m+Gx/8v0m7harB2bUO4T4AnaRZnq5TBB6Ls7t8IegUVNL6Isrk5+C3ztXqFV
	 OFV6/40vtIWuhMjZBK0H65nwh9Puksm1eK5S4LDgvngJzlYYOY4dxGM+xzlCsYx/je
	 VbDC1jrnoCNycCjSrUODfjJTpNwtQxPbaK1Ac76D2DfYNh8ZDgDd+CMgiD2cjyLfay
	 hdNMxySdSTnuiL/5lS4AYcYEpkpu3KQRxmkOg+37tYxM7U+U3sRkCqewmlIXy+J+RU
	 MVSkVETY3UVsw==
Date: Sat, 18 Apr 2026 10:43:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wei Wang
 <weibunny@fb.com>
Subject: Re: [PATCH v12 net-next 0/5] psp: Add support for
 dev-assoc/disassoc
Message-ID: <20260418104331.34706c86@kernel.org>
In-Reply-To: <20260418170056.3490525-1-weibunny.kernel@gmail.com>
References: <20260418170056.3490525-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 10:00:50 -0700 Wei Wang wrote:
> The main purpose of this feature is to associate virtual devices like
> veth or netkit with a real PSP device, so we could provide PSP
> functionality to the application running with virtual devices.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.1,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 27th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


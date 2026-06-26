Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCD37AA83;
	Fri, 26 Jun 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487417; cv=none; b=RqQ6ucoIIhUEnWRoVAqjsvFWtbIiFoH4ckjANSbeGjx5px/6E0TkhKEXwIPPTxFaaQTaE7LDg9/FOCYqUWP6Q1n+7tbmLWN+2RjovUdssARIdUf6BvXvmNo5hY0Fr/S6mu7vHiHk90+erl3+wMq9FrWjyabeuEZSO55D3cuVOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487417; c=relaxed/simple;
	bh=bmOVwBc7W6hG2k4uI94bIn7gWV6EYU3fzxRLNlMRZq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEjD5lOkrn3KVTU6vfR0RiqU/hhY8m1LPxjNzMEiu3cSXxsA9zO/tb6Oykkx3i5vKTmuE+XwivM7bOYTvgVfTEduFUx8Qomf4whxpjS3SLB4qzUhZwNdZpqWt/VL1IXmnjxUsUUJ8kPrYo4fmm4sxhNj97UPnDbuwZVdHCVsq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQDQlJkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQDQlJkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1A41F000E9;
	Fri, 26 Jun 2026 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782487416;
	bh=bmOVwBc7W6hG2k4uI94bIn7gWV6EYU3fzxRLNlMRZq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bQDQlJkjp6johkW7EbQcEFV5PE37jpMgJqZuUtq93ZFNtT39wmWmDmwbtaPL5KByv
	 znz9mfj/t33i/OZloSnl5K8mVR173hmquzqV/NTGefgs2/ZxwnjNyobX+qZCs/yh/p
	 txeYDptuNmRgXfdloDvyRCQJWTROiKO9XyqokBdw5uA8HBYRDWJnJ4Y9VMqd7Ya8Tk
	 bqf33XLb3ujxgvR+g2T/UCdMZheVb8MBZYOn749RZTom6opdsPl3SPWqywTQxVkiIO
	 iqz5Pjkz4wyvrJok+5k0kXopK2wODz9Itw5WSlZVdBqRmxaLcqtwAMX3CspotjX/04
	 Zta7N6BuMqbjw==
Date: Fri, 26 Jun 2026 16:23:32 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, afleming@freescale.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: gianfar: use of_irq_get()
Message-ID: <20260626152332.GD1310988@horms.kernel.org>
References: <20260624032122.986986-1-rosenp@gmail.com>
 <20260625093630.1173136-1-horms@kernel.org>
 <CAKxU2N__hbPOrPe3JUeTLF6d6+=uN+p5ez78rVg6cnrekkvQPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N__hbPOrPe3JUeTLF6d6+=uN+p5ez78rVg6cnrekkvQPw@mail.gmail.com>

On Thu, Jun 25, 2026 at 05:42:05PM -0700, Rosen Penev wrote:
> On Thu, Jun 25, 2026 at 2:36 AM Simon Horman <horms@kernel.org> wrote:

...

> Meh I'll submit to net-next. This is way too messy to fix for net.

Thanks. Be aware that net-next is currently closed for the merge window.
I expect it will repoen next week.

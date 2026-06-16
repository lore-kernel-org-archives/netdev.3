Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060EE388E58;
	Tue, 16 Jun 2026 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575337; cv=none; b=tA3FHsxxqZLU0F7ccm5Mp7Uc2yjrvZ+dSezD9x6sKQ78Iu1bstWG76hoMSNqoBSb/blqHKwRmLw7763KONd/x+kV+CeTlOec5w+DBZWT+TDx+t1Gq8S6FZ0HPehkmgu+3BzlPjFYvC6NPkudJVHayIIuIm7xlf2piAwP/wCjd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575337; c=relaxed/simple;
	bh=glN3gUbIroHgl1xmkeUxAV1yHZf4FQBNnaShQM/1wDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbwbb0BMUEjvehbKQS3qpEKkC7qoWM1HUZVjVoTDXkDCx2f8Xg7OJ23SjtC7K+CT/2XLNzd4GqjGjwBEPJDJ64FWqj9fHcrA/yCRySD7OeibSGFncsgFIpLcdDZdxI8lbiCoepR3DAp6SWjq3Bh7LlIuyrYOetwIvO5MEqDpM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmDevPWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmDevPWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C581F000E9;
	Tue, 16 Jun 2026 02:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575336;
	bh=r7qNL+NtjraRsKOCvnZJ+XexRKqmKoNW1JLCDALEOQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KmDevPWgGNjR+vtYQ0BIS0Kqv5RCnKAhpLNKFYqBloM2eo0oHyOL5flG35dgwPo11
	 h5dhZC+PkR7yEu81aeXypwZuC1SSIPkhiGqvnwNxK2OmUdSaO+CLiShOvXFCqZYBah
	 mO8P0hxx8ow5ljukOgnNmjwq5t1Jj3trn/s9nxs60PAz8yY1D4qpdUevLbArsfai0u
	 swVjnbHcsNCm7Qz07FjkHvZaRPyeEzFbzDJgyE9OUK/4vipmgUywkEgE6Ry0x2bKqr
	 RywvfD57GVJDi0zVa5KsjGt14wkotspiYmRyEaqopgeVOz/6Ejhqj723Obg2pip/vZ
	 D5dUrFddjxwRw==
Date: Mon, 15 Jun 2026 19:02:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 0/7] r8169: add RSS support for RTL8127
Message-ID: <20260615190215.28707461@kernel.org>
In-Reply-To: <20260615031345.548-1-javen_xu@realsil.com.cn>
References: <20260615031345.548-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 11:13:38 +0800 javen wrote:
> This patch series adds RSS (Receive Side Scaling) support for the r8169
> ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).
> 
> RSS enables packet distribution across multiple receive queues, which can
> significantly improve network throughput on multi-core systems by allowing
> parallel processing of incoming packets.

net-next is closed for the duration of the merge window.
Please see: https://netdev.bots.linux.dev/net-next.html
And of course:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

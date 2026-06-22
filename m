Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422E27B32C;
	Mon, 22 Jun 2026 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167784; cv=none; b=WMXsDIYKrsPCEsOs9o/y4gobDNXNw0nvgD0LHJ+xY1mJLhGY1I5FSfIAYRX/GdM+PNuLcBmJ5BEdGu0MwhZpbEZ1mqT6+6O4ad7UM8MyPLevxy1jhLfp1Mqm5W2qZOUwZcsh55Bt16XBtdDDNojzCv6XSJd/252kDzXKu7rray0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167784; c=relaxed/simple;
	bh=RLGF1yeAWSeVmieduDBbFcSnR4ndTRbl1hoZPbe9SbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhofnHXJKBJoITYRvj6gZbErMS/cocOSP+jaMVLM6IvQW/ECjCHLaR7ubCLxILx0uaXAd8loPH+utdelbmFhiB0fP5k/oQdJEMM6oTKjL97enp2bCjxaZ9kwV5isC1tth8rUTebud/6n73VQv/SlX5OwA/EKbBAKrsrWEisqGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g53CH0g8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g53CH0g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317C91F000E9;
	Mon, 22 Jun 2026 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782167783;
	bh=4wAb8ZCFUVH/IHXTidrcFkcBUFz0IgRXgy2Dtd5BR8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g53CH0g8XcytwkIlpD35uURDRdYxK7SXIY8yTdI7azR9Bx/4zXxYKTqkYr5csjmAX
	 lHZAn7fQipoHLAyTZ/fOfS++XTeidE3GpeY15VTeDqNycwuijBj0oVak0zQwLj1uYX
	 V5tQ44iol89Ijrw2zEH0u8C6gk2pb2WphOgGtcUlnVYeIHuaRHQ1g+7UcUWBA7C0KU
	 S9MsjXzUWNVfViVXaQ+3bciKSLC+lguJmkVrs3s/cT3znrEqqA3nuHUqWrIpu4gCKe
	 RUGb1sFS0HPvrEmCWfi3JZqIigseDD9MK1LNAEt0zFQ+U/lqtZjB8OINRkkADBTDRl
	 TRx+a1iuNizsg==
Date: Mon, 22 Jun 2026 15:36:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Wells Lu <wellslutw@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net v2 2/2] net: ethernet: sunplus: spl2sw: fix multiple
 of_node refcount leaks in probe
Message-ID: <20260622153622.6f9d4891@kernel.org>
In-Reply-To: <fe9cbe90adf4bb6fe5f2f7b7f267075e603d84cb.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
References: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
	<fe9cbe90adf4bb6fe5f2f7b7f267075e603d84cb.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 01:20:32 +0530 Shitalkumar Gandhi wrote:
> +	struct device_node *eth_ports_np __free(device_node) = NULL;

Please don't use __free() in networking code
-- 
pw-bot: cr

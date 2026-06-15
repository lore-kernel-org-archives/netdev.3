Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A832D97AA;
	Mon, 15 Jun 2026 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560464; cv=none; b=fjdfMSPEKgxrnhR8elABfW+aBJhxKbCWMiqFRigOoDMLoQRubqK6K/v5Et1qaP6fszdKKoOQxEOiNRYgW0JynNy/0SfIl/pWgzqipPk3U3Rss1vP8l8MEbaHIvi68vdS41ci0MZ413s0ETho3OvuHlRH5UIXBt9qLlTu1mCEfgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560464; c=relaxed/simple;
	bh=dGUZgZKDHQu9OM7SGJzTWBBy12hBRxcPvhvbvmNirYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qU4XpvSm7fdyMyhQIQvIC6xfuznGWqNnljIpnqqjB8NbMCb8viVoe1JVjcWO9LJCjWWf2g1KFB0LveZ5Z63pThJWqKaAKDhoeumAUr1dhi8ZD78GDzPXvP+Yf6zeodiPws2aqyk5ptLhd+aRrbs7HAVQhnfca5oBxfjshuwVrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsrDoBPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsrDoBPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FD41F000E9;
	Mon, 15 Jun 2026 21:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560463;
	bh=lYDGmaekj1IBJIPvLpQzQ7ZfcvZY46l4TfM8ED1ZMi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dsrDoBPqKbV7auOhykYfRrzEIIb464xnRsqpIKusGDWBRgMQjy371AJyNUQn+xXHM
	 iOQ1cEh8UN6MXCFJdkBLpoYNfgC4tbZ3lx5QpNY8dmSkxiA3ZoykwrrK27w/Xl3lZ8
	 63FJ7IacF7HtgpBO/fHooEXsqV610Xq3qL84ELvlSnUXKL7vw6UFMRNp4rGSpzmGcL
	 Ed01owCAIeGZCiD8Q9xM2LPe4xTQIRFo16dFEQbu5LBe7GVkSKtXrYe9fnrgUc5sEi
	 K796Hp1774HE0A7CGRTrCPF1/y/9eGoDWb+9MW75VChX4qXBK+pmHyF5dsZWS+1iLX
	 tavvi66i2mYlQ==
Date: Mon, 15 Jun 2026 14:54:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v18 net-next 00/11] nbl driver for Nebulamatrix NICs
Message-ID: <20260615145422.0bb17248@kernel.org>
In-Reply-To: <20260611044916.2383-1-illusion.wang@nebula-matrix.com>
References: <20260611044916.2383-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 12:48:59 +0800 illusion.wang wrote:
> This patch series represents the first phase. We plan to integrate it in
> two phases: the first phase covers mailbox and chip configuration,
> while the second phase involves net dev configuration.
> Together, they will provide basic PF-based Ethernet port transmission and
> reception capabilities.

7.1 has been tagged and the merge window for 7.2 has started.
It's a bit late to be adding drivers, so please repost this
after 7.2-rc1 has been tagged and net-next re-opened:
https://netdev.bots.linux.dev/net-next.html
-- 
pw-bot: cr

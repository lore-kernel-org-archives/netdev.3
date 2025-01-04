Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8041C01;
	Sat,  4 Jan 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736009328; cv=none; b=NrgVlhmZyrbUrQQudWFBgoQ92TPXo3LD3oriQKGtNHj2e31NSb2xLog5mbcbxtCONfcUxZg48tMmq4nn0iLa0ndc3SAtXKSesRYEWkSCwTFfXvwlVrgijsRqNK2Z0R7GmILBVrHqT0yqmqjKkaY8KSAcGiN4it8usqOtvRhGcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736009328; c=relaxed/simple;
	bh=YG+HE+5SUJVdKAF7re/W7k+jrto776dXKEVx3Cj8bRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrLDJpK74OxDUNZyeCLaFpq12tLyuOM/I+A8BiiZ6ajyyEvXebATTgLGSNF15b0/57H6iyLtzO9VV80UYto4TRTWgG3GgwjDjcynKFRrBNFC0KOX3ZEFQ48tEQR9CWa+dafpMMgTDl8eIthb0PqLx7n9zLfEvWJN2AmMPCBLPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPWy/0MJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPWy/0MJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C8FC4CED1;
	Sat,  4 Jan 2025 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736009327;
	bh=YG+HE+5SUJVdKAF7re/W7k+jrto776dXKEVx3Cj8bRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TPWy/0MJe6+B3FgMTxhEiyVrx/ncE/Ccg8XMNGrX+ghe9SR1+JJ952RhajJzgbBag
	 sZydyJ1J0CIZQ3hT7G//aTA4j7PeQPXtCvFLuiQIk4krVWpKpyl5Lsj5MyvvMkgFBb
	 s3Xxq1jv7VrbomsXnZPDW6JK47EH0BcZqrIN/8o1DyTEr9fUcrkAYJMflul/8a9thc
	 IzYwcijeEBKiOV2F0DmUbI9GmlrrmzmfSO8PkM03fET0EGyidqLCIf2kl0wWbKjgSJ
	 3rKv4j8veu2UIoYxj6xL1PlrxCjPT84ZmR/4y0y5KY9EW3RElNWNOKBCyOPGnVL60G
	 LP8jupbZqhlxg==
Date: Sat, 4 Jan 2025 08:48:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: M Chetan Kumar <m.chetan.kumar@intel.com>, Loic Poulain
 <loic.poulain@linaro.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
Message-ID: <20250104084846.300455d4@kernel.org>
In-Reply-To: <ea5c805559e842077734a6c7695dd60467c1ef12.1735490770.git.mail@maciej.szmigiero.name>
References: <8b19125a825f9dcdd81c667c1e5c48ba28d505a6.1735490770.git.mail@maciej.szmigiero.name>
	<ea5c805559e842077734a6c7695dd60467c1ef12.1735490770.git.mail@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Dec 2024 17:46:59 +0100 Maciej S. Szmigiero wrote:
> +	if (pci_registered)
> +		pci_unregister_driver(&iosm_ipc_driver);
> +
> +	unregister_pm_notifier(&pm_notifier);

The ordering here should be inverted so that you're sure notifier can't
run in parallel.

But I think the notifier is an overkill, there's gotta be an op that
runs. pci_driver::shutdown ? dev_pm_ops::freeze / thaw ?

If you repost please make sure to CC the PCI list, folks there will
know how hibernation is supposed to be handled for sure. Note that
patch 1 is already in Linus's tree so repost just patch 2.

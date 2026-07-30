Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DB2DEA68;
	Thu, 30 Jul 2026 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785378049; cv=none; b=u9nfTnrL8R66t6W17e7/fzmVNExFUH7Q5nouBaAHYENXY7ArfY0uf16HSIh02FCNMDP37rGF6zcWIMq0+5rdURQ9cDtUvt3TIuLmnq0AfMj6FkpdQ6uj5ul8yq3Cz1VFjunJ3p2NoeOo22JlTCJEDwItF3krEnW9fngTvluWFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785378049; c=relaxed/simple;
	bh=p3ysLYDSVIKvFivWvnWU3P1+UgxBWGVHeeLPacgpy44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S9pwTT1sJXrq5Rnq5DIUjIICcmrwNtoLlQL+v3XDVtfNKwB94/UYWkDXhwmjJrQPOKK258b6akxe7qX/6yZj9vjgn41RTWG+vzfPDRk9T/L4gE48GvVVP7El1CJyx7ijMbi/CcNlGS8ziiNpMwmew+exXfvrBiaWkDsm8dT1MdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+NlSEAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+NlSEAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BA61F000E9;
	Thu, 30 Jul 2026 02:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785378047;
	bh=h2Nr+7XkpE/Tol0SM5/QQa6PfI2500i/nKvHyoi74/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h+NlSEAe1RfMP4MB4BZ++BB2h+vwUwFZ7SA1MyLC+qEOKUt03hmYcXfx2vjDQBwcv
	 sATsLAXNVghXjonmLv8sdTmsKA5YkGLRO6kOHqlJ6ZRin8BCE7At8/rUoH6a/9R/3v
	 bc9ERIVkfjJInXSTgwuIRYflrLS9PBdP0oYV0VNuI190fdloqX/kQYPY+eM7RfN5Si
	 1pS+RjAhlC+BKYGNDcVC4pycd4slVPkK0wwtj/fagjfcOJCGs+I8TlCI3ixFHQEDe9
	 h6u5nnemRpGkBFEcEmg9dw+UNz70xdszdwhuBZ4vHZmkrJ/1y9aAjeIoQhtAiZPr/J
	 XJdgolsBlIZMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC2380DBEC;
	Thu, 30 Jul 2026 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] net: dsa: realtek: use devm_mutex_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537801146.3325894.11590642723292261438.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 02:20:11 +0000
References: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
In-Reply-To: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mir@bang-olufsen.dk, f.fainelli@gmail.com,
 namiltd@yahoo.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Jul 2026 22:56:07 -0300 you wrote:
> This series fixes mutex teardown in the Realtek DSA drivers.
> 
> With CONFIG_DEBUG_MUTEXES enabled, mutex_destroy() must be called before
> the mutex is discarded. Using devm_mutex_init() lets the driver core
> handle that automatically.
> 
> The changes are split into individual commits based on the feature that
> introduced each lock to allow proper backports to stable trees.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] net: dsa: realtek: rtl8365mb: use devm_mutex_init for mib_lock
    https://git.kernel.org/netdev/net/c/70fd0cf29bc4
  - [net,v2,2/4] net: dsa: realtek: use devm_mutex_init for regmap lock
    https://git.kernel.org/netdev/net/c/050e07f8765d
  - [net,v2,3/4] net: dsa: realtek: use devm_mutex_init for vlan_lock
    https://git.kernel.org/netdev/net/c/a95f3e9b8985
  - [net,v2,4/4] net: dsa: realtek: use devm_mutex_init for l2_lock
    https://git.kernel.org/netdev/net/c/442ecdc83d00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EE2BD587
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554913; cv=none; b=Fx7YYHeBoMNYcoSs8n/fBu3c6fxY9ZXfUV94pQBq5Hg9Dwh4fL9RkWIftaN8IaHF6xuKo8gn4S9a4F0Wsr8MPCERXKsuDQz0T6VvmpNljKR/Uwk3SYZsCwQTLWJQJepQ9BrgAqoRpD7n0Jf3fEh9X7gMgXSvqbyu1/IA0o4jByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554913; c=relaxed/simple;
	bh=yZ57dPc8ald3eVcheuwHAeJf/+vARzOefcZydvCfYpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL/F0lA7RO7g9OXFMQgtEpGjDRk3pGJZ6/DRWNjfSp+3rGJeysSsMYaR7oC4BDDS/VWOKF8gdSJxzZxTx38/nLXiJys6DeLqXO77qG225UU8+Hdo9Rfub+XPl9Fm5CZIORnRYb5VO2Qt2weMBG0T6Qz1iVePL96Zlr4dkcjXrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q65vhY+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q65vhY+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E52C116C6;
	Thu, 26 Mar 2026 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774554913;
	bh=yZ57dPc8ald3eVcheuwHAeJf/+vARzOefcZydvCfYpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q65vhY+EdhRwjhUoa3BVFIUEABRfSy+3osiXwBklfL9E+rNdrxY6L3+BgcT3AQywT
	 BpOeeDniWjnjMCZkfQ/ANxq+rQU5SDRDPRzW/b2lIdWaCb56ELo/8mh94769MpwU6X
	 S1n/ZzcyKsyeoRjyiCejKcOGVueb64WBDJUxItvvFC+8bKrCMMrBIb3qPVvf0FPpLW
	 SKG1wOMNbqYABYWG4IPF91X4M5f9zcwkE5ibsRAPVwOf0iFJLf38q8pXP2AadAtxvG
	 bzZ8tU+dxfxRDCJHPAkYryT+eqfZ3oDQcZ+oqcofLBhTEv1lQvnPzJf7U/QwaYGJ/n
	 dH8yapRn5iDjA==
Date: Thu, 26 Mar 2026 12:55:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, j.koeppeler@tu-berlin.de, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 5/5] selftests: net: add veth BQL stress test
Message-ID: <20260326125511.7bbbf3e0@kernel.org>
In-Reply-To: <f1263c70-ef11-4622-93bf-a5f5acaf735c@kernel.org>
References: <20260324174719.1224337-1-hawk@kernel.org>
	<20260324174719.1224337-7-hawk@kernel.org>
	<f1263c70-ef11-4622-93bf-a5f5acaf735c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 13:19:18 +0100 Jesper Dangaard Brouer wrote:
> The netdev/shellcheck [0][1] had some review comments.
> I will work on addressing these.
> 
> [0] 
> https://netdev-ctrl.bots.linux.dev/logs/build/1071815/14493217/shellcheck/stdout
> [1] https://www.shellcheck.net/
> 
> pw-bot: changes-requested

And it's not included in the makefile

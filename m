Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472EC41A50B
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069526; cv=none; b=uJ03u6UceeL+nC6r0oy/U/wpQ2IohwGRwtvuaFM7z18bGFrrjK9ZyrnfzQqdbqigtZneloBrGoyd3WLeOpco60QQK8fT8nq+gfZjISz+XpQ3R6kDtVFKEEhVSE7rDxTV9f7TTNYrHbaxinDhzYjhoE2s0l1YWUhOOi+wg50I5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069526; c=relaxed/simple;
	bh=pdLCutZZr4OGkDhwP7FmnlO4gX1aJK0hhcVFptXopmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1mZ1Xow5NRhQEu7CFRxdN8YQ44lcBumo+NPS8AlPv7HZASLWzDdbvZMrvoABFxXnWk+PhBij3PqfmqfH1HAtBqsVcYfrMv3YddzVFoxUTOGnnTdIOIHQcZEy8tyAeeP96BeONhHMw9VpUNElBONd/Vp2+ds8OOgknSuOt6wGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPmjn5Hj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPmjn5Hj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD1E1F000E9;
	Tue, 18 Aug 2026 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069524;
	bh=7LhMlAjcq277gOFISCnp4DVvyEx1G1dd4z9juE5tk6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BPmjn5HjKX2sYCZyL4wH83uatnGP5gIn0ZUyJmO2NOTBRvmPSktsgie1Frov889/b
	 WjawvIIDq5FKgsnOmdForD/jfCpTzI+yV3qPwjntC5ETanOYmfqeX70VOVyj6rh/MK
	 8YQblx8FTmYU5+kpniDv4y4dPow2c/TnuiE4lD8I4v1gdwkzBtj/OavBDOJRMALIaP
	 rJe5REhPWa5ifT0M7GRScj2IT870YAejIJ5M/YlGQVlBDmxcr6K0/z43KmqwwZUsVW
	 p4ZKAUGHSC4B4LSl3q8Oa2S9d9fqn2FGvdOBMnDPeuWlqNPfVCmZfbsigtZQMPQGqa
	 oPv2pC3suTf9w==
Date: Tue, 18 Aug 2026 09:12:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ren Wei <weir@nebusec.ai>, edumazet@google.com, ncardwell@google.com,
 netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, edragain@163.com
Subject: Re: [PATCH net RESEND 1/1] ipv4: reject RTAX_ADVMSS values below
 TCP_MIN_MSS
Message-ID: <20260818091203.4a4e1ccf@kernel.org>
In-Reply-To: <20260817095015.75fc2f44@kernel.org>
References: <cover.1786610865.git.edragain@163.com>
	<2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain@163.com>
	<20260817082803.GA242453@shredder>
	<20260817095015.75fc2f44@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 09:50:15 -0700 Jakub Kicinski wrote:
> On Mon, 17 Aug 2026 11:28:03 +0300 Ido Schimmel wrote:
> > Given the above and the "We assume here that mss >= 1. This MUST be
> > enforced by all callers" comment above tcp_select_initial_window(), do
> > you prefer to fix this in TCP by enforcing a minimum MSS value?
> > Something like [3].  
> 
> Should we still take the patch as posted?
> Maybe not as a fix but to let the user know the value is out of bounds?

I'll assume not
-- 
pw-bot: reject

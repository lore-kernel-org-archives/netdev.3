Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56472580E1
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153741; cv=none; b=KaaJEE8mPQW/w0o3CZgZnwWiEdvZC1xptZCO/sBv1Fktuze65Eutu0K9+PU4TCbWdE9yZh/bddX7AAZWFUPCPPgCk/fENM1iVbbhlcCZH1Fz0S9sxZnCSX7ZtaLhMKbxLBQi+KXBdwZDPHY1/J7CI9I/BwUz0N01B5Prj/1Owgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153741; c=relaxed/simple;
	bh=sLsNnJZFXcD4gAXfpCkEW2LT8k91fwRchcwDJgkPzX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6ov6Ww6Yxhawcsq3lMQ2Dg1i4ClOjX3REKEAaelBjdjlBMOXdRfYIhRQkeBfWWSr0dohXj6Nf/podUfsfiepstfmyVHJLpR0dlnd5SHi5fYLOOxGV2+lt0kxXTmYN+HzGjTltfu18iw7Mzabig8O3aFpXT9EcpXL4DGv9wgPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7UQX1KW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7UQX1KW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1989EC2BCB8;
	Tue, 19 May 2026 01:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779153741;
	bh=sLsNnJZFXcD4gAXfpCkEW2LT8k91fwRchcwDJgkPzX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A7UQX1KW0PPa1q/72P162bzH0l+01oR/rCh2h2k8WyL3LBpvdKjZ+aA1EW/GlkhHV
	 l9KOLMih7nnqMY2cqyQMYNRIsvy1qOePts+iFmvB39hlBWmYilaHDxKKLp1opw1UA/
	 gCO9P9v1o0UlczvqiY2matWhZEH9ZErXDFlSnhmuprpY54W3rZVixlr3Z+cqbQ9VUV
	 UmvoO5rik4Lhy0p/QHqTF0D9S/SP+v4eFt7DVZWsIcBrLVH20ivBfZRnekl1q9hRSJ
	 MQhZLG3zNk6QIDRUt0noov5fkdAUBpqAJgGgpKScinLC8LFiAdta/I5BUDbbx9FxYn
	 +k+LstiLlqXAg==
Date: Mon, 18 May 2026 18:22:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH 4/7] net: arcnet: expand unnecessary I/O abstraction
 macros
Message-ID: <20260518182220.78a9ae80@kernel.org>
In-Reply-To: <20260518010739.80979-5-enelsonmoore@gmail.com>
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
	<20260518010739.80979-5-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 18:07:24 -0700 Ethan Nelson-Moore wrote:
> Now that the BUS_ALIGN variable has been removed, the
> arcnet_in/out/read/write* macros behave identically to the functions
> they wrap. Expand them and remove their definitions to make the code
> easier to maintain.

This one reportedly transiently breaks the build.

Also the cover letter did not arrive on the ML.

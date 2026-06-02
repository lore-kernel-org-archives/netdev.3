Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71095368D48
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425276; cv=none; b=AWVpexqGI6YbVUhZUSFB5KadxJ91oIZqEvSkuY1wwdqJFYwEyWOjLfu5N1RyHnApB5U69ezbRYy/I/bHA8x/7cGOMoN2JN5PIjkBUN/SFP9i+Zm4+DjbB5OfRYwnQ2YuvHgVPZdxPywLXilPb2dCrCFL9kxW8uoPkeAZDZ2mzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425276; c=relaxed/simple;
	bh=FMFohVegby0EGmIa4LDMenBHl6w24dHK/77N6pNKziU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYXOmWn4Bq7emUyDLLSc0hWxTQfs5b7W6EdKhxycocd0rehKlVy4Rdcm3KzqwHby1Gk3pY4GV57dTZhRbUJv5nFKtmqSjke6Fve2ry1+BpRIOWw0gFV3tPVDespiQKTzddWUBCXIB18cHB3VU2nGJX27qPRAkOIMDdV75lNaBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCa4gLfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCa4gLfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D968B1F00893;
	Tue,  2 Jun 2026 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780425275;
	bh=FMFohVegby0EGmIa4LDMenBHl6w24dHK/77N6pNKziU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SCa4gLfDiH81yA+T7Jmj4LwuBGAayK4TikRg8pu1Aji7RL4JqxL95mWRU5hkaDvau
	 CjoEwUuOeXzXzrboQvenP91DXTKA1MhDjYYSLpGYKXN/3/WSLYavrUGl/a+v84u1jH
	 tyhv8DD6cU/0I0ZEJbJZ8EysyHwmVlNTe1sVA08jYE0Zd9mx5dUrVktSwkmS1Wls2j
	 0w6mH7XC3jk09KwpHSnbg6IVvGhpkflmSqnVddGzRKIl08XTsmGTcNUxlNNIdtZhdy
	 Xyr14YAgZm99wfSS/pK8se8mJmL5F8W06mTwv2tdwPvMNoPQqqI6GLXEKaJf03N4I4
	 rsdioaTjfrRkQ==
Date: Tue, 2 Jun 2026 11:34:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew@lunn.ch
Subject: Re: [PATCH net] pcnet32: stop holding device spin lock during
 napi_complete_done
Message-ID: <20260602113434.5898517e@kernel.org>
In-Reply-To: <20260602164158-oscmaes92@gmail.com>
References: <20260528140320.5556-1-oscmaes92@gmail.com>
	<20260602024428.1664921-1-kuba@kernel.org>
	<20260602164158-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 18:41:58 +0200 Oscar Maes wrote:
> The suggested race condition is impossible, even after
> calling napi_complete_done all pcnet32 interrupts are masked via CSR3.
> pcnet32_interrupt would never be called until the second locked
> section in pcnet32_poll, which unmasks the interrupts.

Not very clear to me that pcnet32_interrupt() will not trigger until we
unmask, but okay, not worth the effort..

Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5013DA7D3
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279161; cv=none; b=ZFVAsdTf5Et9gMguGOnpI0M3r4KNEuZabGEbjMTBUO7L8vuHSUlwF8VHl2FPvV9LIunMpLw6l0C2NQkNEHDgCjIGz2lsN3DZ22Xj7YjuDpYFYNugIVARJH/FpQLHXVmol2XlfbqLuH0gXvkM7MyX1UtL3F+DO9XA1Q0ThXIFs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279161; c=relaxed/simple;
	bh=Uz4PAqVs5Df9QRZ+YHX786KF+UyiqrlI7D18FFnqoP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK4RuTHK6FcmAjaFE0sYpdh3eiDB5GlCVfT9hTpf3wZboS+9Lw2i1NxgtCt5eTttTtqJAei6qeTsO7i448KmpRsih/LPD6RDaLg1Tm2pWw20RYw6Vk840xh2NS/9BsUqSwv+nGwJKNlAqeZ1o0y5tIad47qCgcfI7K5q4nkEAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4+xzZPQU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4+xzZPQU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tqh2ZxlwdhS7B6XKuGyBIQ4AW8YGAUsvmTTSS2SU60A=; b=4+xzZPQU+nZGAeu+ZWsrRBnhYM
	6vKvdaOLxijDJ2FAqz64+EatB/o4Ffn8IiQ6jQhZbHDrEA/OOddUF4PydeeUvW1XmIPny7L5G8CPw
	BEhaaP9FMSPE05BCwgxznuMQYNoen2Iudgaec6U6KDf+6MUkXzESrKkElvEDtOpik9wI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPfmw-003pXE-1q; Wed, 20 May 2026 14:12:38 +0200
Date: Wed, 20 May 2026 14:12:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 1/2] pcnet32: stop holding device spin lock
 during napi_complete_done
Message-ID: <b9df0c7c-188b-4bfa-8f5b-8322747f90ed@lunn.ch>
References: <20260520063329.6387-1-oscmaes92@gmail.com>
 <20260520063329.6387-2-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520063329.6387-2-oscmaes92@gmail.com>

On Wed, May 20, 2026 at 08:33:28AM +0200, Oscar Maes wrote:
> napi_complete_done may call gro_flush_normal (though not currently, as GRO
> is unsupported at the moment), which may result in packet TX. This will
> eventually result in calling pcnet32_start_xmit - resulting in a deadlock
> while trying to re-acquire the already locked spin lock.

Please continue to commit message with something like:

  It is safe to release the spinlock, because it is protecting X,
  which is not modified during the time the spinlock is released.

You need to convince us this is safe.


    Andrew

---
pw-bot: cr

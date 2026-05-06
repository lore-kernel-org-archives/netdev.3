Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8D3932C0;
	Wed,  6 May 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075520; cv=none; b=WgNJdYTIZKQwAISrEeqCg3UZoXdDQ+Oh3kPlQJdEta9wSurQu9RSiYBXH5gEN8HK7+xPRYFO5msG5D97FNdlpew/w5a+A25tJgEnZv9OFM2LFnO0dRoGUy1dM3Ca/txxsipi5UsgIqGiT76JDxPI1Btk65jY5UJTZpKybrPRKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075520; c=relaxed/simple;
	bh=f4Ht2lDZ5sYdEuOj7Ib5vuXz6VOhqpk1/bOxBYLX2Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw+CTcqDW2EyCDRlmzy2Eyy3cITyIXJfNzFedx/3Q96gjH4FADvPL0mn8miozocIjkQYjXya1bAC4HndhaDQjE861srftvsG87qJCVXK/6kR8wc41wxAfqWqePXXUOgvCr098WqKoDVdzLoRfPgJtIY4Qy6nUkdwQ1ufk2A6jeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EohbphO+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EohbphO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE11BC2BCB0;
	Wed,  6 May 2026 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778075519;
	bh=f4Ht2lDZ5sYdEuOj7Ib5vuXz6VOhqpk1/bOxBYLX2Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EohbphO+NlF3U6DR6tgfgYb025+1pxep8jzjxFMWa+VNnkrR26rm14MHJmyL66jvp
	 h9DcwnoE9ryddEqbPr58KbwK5OkbqFjr5UWAca+j45V1lcAa7ajih389RDRIqM7Cy6
	 V+xomAZ8/exp398UYasA0qBipNshPvvviTbA/MFN8LNXGbC4GEv6asEE0Gk5z6hvHI
	 37AcLCPwKzESrE33QZALY0XN701CJWASsdsMYWiJWIxvLglPSWtXwevRA7OKHhQA9+
	 ZUoD813BKs8vmpl2MEx4hM3g22ayHtiQVZ1RGF32NvAMngRxRWBYTgx+jUDF42RPwX
	 EOD+eT1e4bUaw==
Date: Wed, 6 May 2026 14:51:54 +0100
From: Lee Jones <lee@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Jakub Kicinski <kuba@kernel.org>, David Heidelberg <david+nfc@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
	Junxi Qian <qjx1298677004@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nfc: llcp: Fix use-after-free in llcp_sock_release()
Message-ID: <20260506135154.GC305027@google.com>
References: <20260429134115.3558604-1-lee@kernel.org>
 <20260501162759.06ef164b@kernel.org>
 <20260506081145.GA305027@google.com>
 <F9112727-E4DF-4884-807A-015809EA5DC7@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F9112727-E4DF-4884-807A-015809EA5DC7@ixit.cz>

On Wed, 06 May 2026, David Heidelberg wrote:

> Hello Lee.
> 
> Yeah, I think today these should hit the linux-next integration tree, and I need to setup the Thank you email to work in `b4 review` :)

Thanks David.  And thanks for picking up the new role.

BTW, you may want to configure your mailer too. :)

> -------- Original Message --------
> From: Lee Jones <lee@kernel.org>
> Sent: 6 May 2026 08:11:45 UTC
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: David Heidelberg <david+nfc@ixit.cz>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>, Junxi Qian <qjx1298677004@gmail.com>, Ingo Molnar <mingo@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] nfc: llcp: Fix use-after-free in llcp_sock_release()
> 
> On Fri, 01 May 2026, Jakub Kicinski wrote:
> 
> > On Wed, 29 Apr 2026 13:40:41 +0000 Lee Jones wrote:
> > > llcp_sock_release() unconditionally unlinks the socket from the local
> > > sockets list.  However, if the socket is still in connecting state, it
> > > is on the connecting list.
> > > 
> > > Fix this by checking the socket state and unlinking from the correct list.
> > > 
> > > Fixes: b4011239a08e ("NFC: llcp: Fix non blocking sockets connections")
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > 
> > Adding David H and dropping from netdev's patchwork..
> 
> Is anyone looking at these please?
> 
> These are pretty important.
> 

-- 
Lee Jones

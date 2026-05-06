Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511A165F16
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111511; cv=none; b=hYG29SbE87Pws9GfmkTz4ncckMppB5rysGCoksPOJI8JtmUDtBD6XlmaaysQXCAwNfTIJ7up32unAKCzo+yJVGldq+bFATealrJoGNEJpYz0FB+v/DUEJfVJoK6HE1jZmUwW2Bk6jNsxeuk67kO063uw33bOHB4VaKVl8XduXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111511; c=relaxed/simple;
	bh=hyQLGen8q2uChWv5opZmMGG4mSc79kGERIvGMC5Oe3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyxZ+GtFFPJdgVpk0q1VYkYzOsq+UlJ4wBkEJgPsy5bv52m0IWLLqzihWn3aqXOzqkK0B1lYtQeaypmk9sUkmyqiw0zl/IJg1sF12sdX20yE6aHDaHsMqtQHaqxoK9I+x0bJVHatjzS7S2Dj7jtfNQCqiLG7nTeyez8KQ9pPOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tI8VX2Fc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tI8VX2Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64242C2BCB0;
	Wed,  6 May 2026 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778111510;
	bh=hyQLGen8q2uChWv5opZmMGG4mSc79kGERIvGMC5Oe3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tI8VX2FcbnSz8LcxHbnAsVfYTWM1MAE5b3B/4ACbEzylS6r/Isujv+eYvymp1JjtQ
	 AHXMUZOO78HvfzKxpZhxD1Zc8f3VD/VKpWb/qTjrSP/IJVDkuKlz10tvuUUGQiDFU5
	 Nn62MGFvnbkYop9i31SBMWRB/D3lUwf0zgXOAtMKu7Fa/AZojatqXI5JqnTz352JzH
	 7K4lphCCe4D7/zmthfOd6KiBkWscaKVevJHW+AxiwGU3EgJ9BpN8yHyEXDL8BFoDL+
	 +Gequ0eW2rVeZ9OUwAMFJ3DIZhz39svCmqDptuet6vT8biraVW8Jb5YSBpOK7DyL9O
	 qTUfT4G/jFI4g==
Date: Wed, 6 May 2026 16:51:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/8] pull request (net): ipsec 2026-05-05
Message-ID: <20260506165149.12e30102@kernel.org>
In-Reply-To: <20260506165035.61964333@kernel.org>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
	<20260506165035.61964333@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 16:50:35 -0700 Jakub Kicinski wrote:
> On Tue, 5 May 2026 15:22:56 +0200 Steffen Klassert wrote:
> > 5. Harden __xfrm_state_delete() against repeated or inconsistent unhashing
> >    of state list nodes by keying the removal on actual list membership and
> >    using delete-and-init helpers. From Michal Kosiorek.  
> 
> Sashiko seems to have extra comments for this but I suspect follow up
> is the way to go there.

I should have made it clear - Claude-shiko:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260505132326.1362733-4-steffen.klassert@secunet.com

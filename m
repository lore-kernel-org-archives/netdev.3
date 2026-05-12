Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77A4963A2
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574645; cv=none; b=EJp/LlFJ4iRYPKuAlnxc1oRtCEkys9LGMjI9k9fyX7OppbKQEDF/uiWpKidJO3ljat1u+HrZSu5VslJaJqmFuZkcfZ8qYG77H3fvJTcwyT8LTMA2EY022KTT1uZJqVPOhvXE78KhtZjCCfTK2DgQmoveCz/sv9EKERHZTfeC9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574645; c=relaxed/simple;
	bh=19uuXv4pdoyTiWt0tFxHqabbMaASusFxj4gnMjn9RGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ1pmY95qPCq0ipdGtz/aVcDPlqt0+kX+ok1Ji0FJ5Ad4/6dB5TWbK2Lx/nCity9ieotKv4dyKstt3A/abD5ZoMV9h5eTDRZyTeJ0wkw7t5GiA5uj2ymvmipgo8cQiBPmfXJNLlSI0At4W5Sl29UvnSnSDdCQsEAXCDcEUW+bUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sewt19bA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sewt19bA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C511C2BCB0;
	Tue, 12 May 2026 08:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778574644;
	bh=19uuXv4pdoyTiWt0tFxHqabbMaASusFxj4gnMjn9RGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sewt19bAtR5FgkB5KExPONXLTnGPJQ26nHWeKtWYMGN6hEnRlg38ay+pvSmtFjI1R
	 W4xkIc56LPaQ2JfgbnBDz07XDYwoBbLAkcQbGAFzxc2J373ICJetHzd9wV2wYKp8Sh
	 S1fVTgYfhsMOW9q3MgrGutGb9sBZaIDjApHLL/1E0v81rKDyRuztq5z7zCbm0nF5aG
	 wcbKBj4kkT33rlKTybLVgzV8ZO0Rsw9vXFHCdGa9pbwZg4lPtfHIV1ag/hYNDKd87i
	 FrX7+YmZfk+De57ZQ6NKWN+SX8vi1lawS/TiBkxp2EGThosWNkg+c5lAStwIzhw3ET
	 IHVPtF1QFxixw==
Date: Tue, 12 May 2026 09:30:39 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Wei Wang <weibunny@fb.com>
Subject: Re: [PATCH v14 net-next 0/5] psp: Add support for dev-assoc/disassoc
Message-ID: <20260512083039.GG27589@horms.kernel.org>
References: <20260508042611.130945-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508042611.130945-1-weibunny.kernel@gmail.com>

On Thu, May 07, 2026 at 09:26:05PM -0700, Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
> 
> The main purpose of this feature is to associate virtual devices like
> veth or netkit with a real PSP device, so we could provide PSP
> functionality to the application running with virtual devices.

Hi,

There are AI-generated reviews of this patchset available on
https://netdev-ai.bots.linux.dev and https://sashiko.dev
with some overlap between them. I would appreciate it if
you could look over these and address issues that are
either introduced by or effect the functionality of this patch-set.
I suggest leaving other pre-existing issues as follow-up
so as not to expand the scope of this patch-set.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0812BFC60;
	Sat,  2 May 2026 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680029; cv=none; b=Upo6Y3mQgD6BfNJlKeZRcj/3ya8D0KiNhWoCJfrmWID9OUYBaX87COAFgCUacpT/0vQeKJzLmMej61luDCW3eG/6dsI+ojKPswRVicQZ4H6XF0kBT2k950b6MjKBBIpc0uvE+KjvCwND4pZl361eVsPfS+coXn1n5vgrPTBzPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680029; c=relaxed/simple;
	bh=EKoHZzA+zQAMhXC+YozWh1Hk1ILV33sRj7TP+xz0HCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzAG0vQbcCPGfcSBOvqYhQj1U0/xT+BT/VuWmo0Qx43Qb/tF/fjIyPDme5Uyo/BktKtXT0ojWESlSLXhFib1wJttZOrPWvc8Zf8X1CyTCLo0p5zjyhDMA2q1lIVz1PMNSi0LfCEc6DcRvGCpc+LnK94IfzpmeJk/IksL7hXXeh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbeGw7X/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbeGw7X/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AC8C2BCB4;
	Sat,  2 May 2026 00:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680028;
	bh=EKoHZzA+zQAMhXC+YozWh1Hk1ILV33sRj7TP+xz0HCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gbeGw7X/e+03Vf7TKS7+w89zUYT/SWF25BtVsPh8m6IEjMOpnvEOBW/b90IlOzM2U
	 2dkwbF3YkD2BZ4hYkCghUtMxK52mLihSL+YjccwbNyFueBTL6zDJEoi6q4XYPs0pw3
	 hFUUT1IKsdJ3oFvxodgnrgrbjUY/ay7wHDDdHkjvLxrBr4wYjf4ZGpccWZYXBHCYs2
	 6kml2ZkDoUijknBd9SAr2QHbtSvrTRw+qTc5gKi9gc1RMFIwq/BXMUrHiMUEnutqol
	 8AzW2rT/AIJxRR9+XaaEWYR3342pa6u0DaqugDxxUXXPg7lqCsrlWHjjJJJuEP43dn
	 cW6tcqmaE2Gfg==
Date: Fri, 1 May 2026 17:00:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: David Carlier <devnexen@gmail.com>, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, raeds@nvidia.com, kees@kernel.org, cratiu@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] psp: strip variable-length PSP header in
 psp_dev_rcv()
Message-ID: <20260501170027.55516142@kernel.org>
In-Reply-To: <ba78786c-881e-4cf4-91d1-7e9d21194454@gmail.com>
References: <20260430062033.20428-1-devnexen@gmail.com>
	<20260501130046.16008-1-devnexen@gmail.com>
	<ba78786c-881e-4cf4-91d1-7e9d21194454@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 May 2026 10:13:52 -0400 Daniel Zahka wrote:
> nit: int psp_hlen might be more consistent with the types/names of the 
> other local vars.

Ah. :)

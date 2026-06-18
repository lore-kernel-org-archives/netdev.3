Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1B1C862D;
	Thu, 18 Jun 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794207; cv=none; b=bx6e80NnhG/qb/40+j+t+IlW2IJx4erQTJrArs1X4h5wEx1DaMVP4lorIONwDl9VUkL74F46OdyIPgghYFMBsJlRhDUpr+4W+jLB191RbpGjpT/TcNUYtljYMyV/GLVxpdaOuvwgTzSHhom/cDHniBuj/m4XMI5jNZxcM9HdD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794207; c=relaxed/simple;
	bh=QropFuLMDqwmcyurb7Uzg/VNt3P//s2S6GkId7BQbKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtcArso4+1SAVrs043reXrl+ygOJM01Y8f2j75kTdJlOIU1ZTZFAoHXw6CWa7QGfDhKCSMZZPBphavSFK7Wwq+3JA6YjIhQ7kPvQQu7TIO+LBXZQqEkiL2CYp/WGxTkjTx7gu4rmTZ52FOhANO+w81iGclT8ZLFKCs/l1DXjmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Iu7dFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Iu7dFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CD71F000E9;
	Thu, 18 Jun 2026 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781794205;
	bh=pMGEAPs4siYakXlozfGJBNocBA6wcs+7bJ+WQbraQgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B9Iu7dFEkbztnX2/fwYdeUBQD/CkmxjusWb/ozVGmnl6PsIlRKZMVEs0kpZf5+45Z
	 IfsC3nUU68B0DTnWclibn8amMWOeMFuFoB2mgedx94Rz1gAPRgepxLFTXKewF/XozK
	 rdn4b5D8qQCm4Ps9iAORtSxQRoNfEKwhpRmz6uXTnroA7vnRLEarhXhXaLAiVVJgaI
	 LM4FZ3qEtbVrIZbLLuXsk7Ea+shv37OPG/BbaDcFeM+mx3Eb0pBNrGhokMOsj6kZwu
	 fr5bDQOjApUH6ZzEPUbG04asho5q2yWBfntzV8dDOKvVdtqw8MRL98WvyBxVbp1MnF
	 qFY8KkNcMBPvQ==
Date: Thu, 18 Jun 2026 15:50:01 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Sanman Pradhan <sanmanpradhan@meta.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] eth: fbnic: take netif_addr_lock_bh() around rx mode
 address programming
Message-ID: <20260618145001.GQ827683@horms.kernel.org>
References: <20260617-linux-fbnic-hwaddr-v1-1-3f9f5dee7f99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-linux-fbnic-hwaddr-v1-1-3f9f5dee7f99@gmail.com>

On Wed, Jun 17, 2026 at 03:39:49AM -0700, Daniel Zahka wrote:
> When __fbnic_set_rx_mode() is called from contexts other than
> .ndo_set_rx_mode_async(), the uc and mc addr lists are accessed
> without the addr lock that __hw_addr_sync_dev() and
> __hw_addr_unsync_dev() require. Wrap these unprotected accesses with
> netif_addr_lock_bh(). fbnic_clear_rx_mode() has similar issues.
> 
> Fixes: eb690ef8d1c2 ("eth: fbnic: Add L2 address programming")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


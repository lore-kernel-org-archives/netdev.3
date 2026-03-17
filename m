Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3725776;
	Tue, 17 Mar 2026 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708684; cv=none; b=smuM8VjhhTi5uv7w5VrruE2QF9Qjn9zn3DFKmBZNEuUfynefKZ7wbO+T9G+GwVPHl83o7iTDOwmErPAhg5qq6Xle0wqUqzZSzW2hIGQMlGzDdKq0DsS4PyYV8L5kqtued1U3upzpGsACnMiTwW5//DnOW8FV23m2lCD/AgaedLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708684; c=relaxed/simple;
	bh=hKq5urP/wixznfIbLvze0TCe2a9t/Iql70l/e4Wb/yU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAo/p6JC0RRAu03EKIVnk2xncqlLDTOI/dFXYQF2g3aJ3AkkNhIvFNTb4rTGyisJcEiFwZu4DfN8qUPDFdse7h92gZ/ByOZm2XsgSlq6XMpLdT2zUMdQEbaiQZ3EYQG8JAT9zn60Buhzh32VCkP/QO1WraYP8IW6OFctRoj1xt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa7q8dhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa7q8dhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E53EC2BC9E;
	Tue, 17 Mar 2026 00:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773708684;
	bh=hKq5urP/wixznfIbLvze0TCe2a9t/Iql70l/e4Wb/yU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wa7q8dhwyyYWWXW4nx/4Mm8XDl18aWJh7bSlHM/GO6TBWlBH0G57AQMwE9t7vgB2w
	 AMklwHAxyo6DwwLBOLbUUXMC0jzynOZq1vDAAhbutI3bG5KM92bbQH7RYBVNoARkrb
	 BPIONQhmzwpAc9Co2LPAtLtFyMeN3ZtHHkZazkkgkJ1W2IzTpsBrFAZ/8IndNha1su
	 x/eGCoE8ilw2UNmC877Xe116JXCpMBwBbZY8/v1pRtfgvy5+W6pn6qHVUDD47uY5LW
	 cMUPTZqJp3rhOqBW7ojOj/cpeMvQC3Fm7JTR2xAleNtWLd7GrS1+J+XD2kXPprK+Uw
	 +2Q32eRFSMEtw==
Date: Mon, 16 Mar 2026 17:51:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] r8152: Add support for RTL8157 RX/TX
 descriptor format
Message-ID: <20260316175123.45b8d6e1@kernel.org>
In-Reply-To: <20260314-rtl8157_next-v1-1-9ba77b428afd@birger-koblitz.de>
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
	<20260314-rtl8157_next-v1-1-9ba77b428afd@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 10:31:37 +0100 Birger Koblitz wrote:
> The RTL8157 uses a different packet descriptor format compared to the
> previous generation of chips. Add support for this format by adding a
> descriptor format structure into the r8152 structure and corresponding
> desc_ops functions which abstract the vlan-tag, tx/rx len and
> tx/rx checksum algorithms.
> 
> Adapt the previous functions for the first chip generation to support
> abstraction and add additional functions for the second generation.
> 
> Replace all calls to the descriptor functions with abstracted functions.

drivers/net/usb/r8152.c:9646:12: warning: unused function 'r8157_desc_init' [-Wunused-function]
 9646 | static int r8157_desc_init(struct r8152 *tp)
      |            ^~~~~~~~~~~~~~~
-- 
pw-bot: cr

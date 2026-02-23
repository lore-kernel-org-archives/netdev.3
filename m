Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D955695;
	Mon, 23 Feb 2026 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887491; cv=none; b=HryZjCvotTXlLjg1T9V0ED3Cg+98kJnEbKCEgYOjjQnwkT0Aw/fAXSDBGZMazUenZM8c31nvPniRrKo+WPHEI6x3crhLIn51cJVfJ6gllaYo0RWmv+UtMt0avhWlsp+YQ1CriRe4xacpGMReOA009BIVjSM1ay3w+cSDLakdLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887491; c=relaxed/simple;
	bh=tUqvefmi8CDcdF8Vy4DDRRBlk0IzlDcg6OEUzW1Xh9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvwjKN5Y+BAGcYpxkTLcEiihk9ynzqx5KY9JXXsRotMVGNTP6q+6EPVyWTKfdTzX/2bVL7BE0Pvo40f5ZNxyWwSVwxSIAy6MwGRRK3JOrsnf9W1YABi/37c6s8TEQ6HRc6WIx5Z2dui3OU+6ouRt5DNLJaWT4eJpQt/GZ7m7fPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcRnVQMG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcRnVQMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604E6C116C6;
	Mon, 23 Feb 2026 22:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887490;
	bh=tUqvefmi8CDcdF8Vy4DDRRBlk0IzlDcg6OEUzW1Xh9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcRnVQMGwtHaC0ENicTpRocT2ZVi4jC24aST2/zQmMKa/55d7Aeq5LL1HlQbHD6qq
	 0Vofi0DVLg8kOGRXGai6M6fZ6+ZSle8A0CufSAxVQQmuLzT8RJ+muz3fEwwnlCw3lc
	 Y4VSlIkH8BOqfX+Ty4EHULKh81xNwR7D/lmtFrHC03FalGpMUB2G9f775EeCAX9HeM
	 2HSuGQA00e3pLJbwCX6sAJtK0o+bSBwuZ0QkJ1IcQt3F4pFPsXjGRYAAzMcAvSJrlP
	 AZJdFm86iyHONWxjpRSzvj1hTqwYcMyGpcnc2npB3R31xdzIJtZiReI1db5TEgiCDi
	 nQQkJBhy/vEFQ==
Date: Mon, 23 Feb 2026 14:58:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Message-ID: <20260223145809.2369117c@kernel.org>
In-Reply-To: <zevfldlqbbprujyld3v3jdl7jlifbmn7ixhrdcpyj34eepv7m4@j55q7mptwqyt>
References: <20260219162200.510325-1-g.goller@proxmox.com>
	<zevfldlqbbprujyld3v3jdl7jlifbmn7ixhrdcpyj34eepv7m4@j55q7mptwqyt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 11:23:29 +0100 Gabriel Goller wrote:
> Superseded by:
> - [PATCH net-next v2] docs: net: document neigh gc_stale_time sysctl
>   https://lore.kernel.org/netdev/20260223101257.47563-1-g.goller@proxmox.com/
> 
> --
> pw-bot: superseded

Where did you get the idea to send this email??

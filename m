Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D13A2543;
	Wed,  5 Aug 2026 01:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894907; cv=none; b=TP60kEEf8kZ3szVr2F0y1dtHHpcB5IP6tGStmDFEfFI/0pKvAYVNy1+OzhaO+jCpV0sZ4M3YjypiVekMDgdQ4w27AIVoIqGU7JMgGgTaT2oMotx+aT46UqSp8g6MgJ+quTUbZUG3UldyfkGsQRnjmPWNdRx0gE4VyvKHXQXq+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894907; c=relaxed/simple;
	bh=m8hoBr4X7GLT++iMYi6Nz1HbIbdpei0miK7qPOL4kCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3a3QGOALAxI4+Iuag8VwQD7festF7RmvjpRn2oIkS6GdPRey6gRyeoVlXi0qsORabapilsZ2kuG6l3TGN1iL9uSEpRbT7ht4psEjqAb5WmxDshC47HnfJA53eo+477cfe34Q4JHURRpmbwJzWjywqgZFcUbbq8ozp7OlBK55+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3AvGIS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3AvGIS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007DC1F000E9;
	Wed,  5 Aug 2026 01:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785894905;
	bh=m8hoBr4X7GLT++iMYi6Nz1HbIbdpei0miK7qPOL4kCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L3AvGIS4lDUvRq5vwWwR3q4Xsk5XaVXdHsg0U9VwDKHURdwx2PWOnHA1Hpem83dWu
	 dTBLOBO9sVjD00YGTk8xt4BZ/OcfpslLBqWjXsn7Dg2qfJQ5CEQamJbrmpPXcXZDY8
	 38klbp4SSO3YbCLGVyQatlwS6gCfzgRZO5dLfBjXKh4VsqagZjusgpq/Xd84+iwjsw
	 EE8AOL5WCMUW5wnH3mPVRUgXZ9Ts0HSPdP/UyK9Evedp5AAFmXcm3NQyG4tRdzYWr1
	 mMeK76LEbdNpX3cxKtD7XOMuCAMRbBBpO7su46/eInkkOYMzIkC5/DPN/hhFDd/w6R
	 AEIkOVotaN0rQ==
Date: Tue, 4 Aug 2026 18:55:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Minhong He <heminhong@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: vrf: check register_netdevice_notifier() error
 in vrf_init_module()
Message-ID: <20260804185504.270ab5e7@kernel.org>
In-Reply-To: <f8b967f3-238e-4402-89a3-95d8ac0bbe3f@kernel.org>
References: <20260803090002.142453-1-heminhong@kylinos.cn>
	<f8b967f3-238e-4402-89a3-95d8ac0bbe3f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 10:59:47 -0600 David Ahern wrote:
> Fixes: 193125dbd8eb ("net: Introduce VRF device driver")

Thanks for the tag and the review!

In this case I'm going to skip and take this via net-next
'cause register_netdevice_notifier() is guaranteed not
to fail today.

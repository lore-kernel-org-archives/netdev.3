Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAE2848BA;
	Tue,  2 Jun 2026 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366433; cv=none; b=A7jhbW8MFoP3MVX4HcJjBLtHpOrkWA6iJVGFBPVs0YMuahH2tLPIbCRvb8z8cAjZkrAcvVUpWHEblftlxh6HvITNBsd7M1PJNniuLdEecoUUJGcXhGkl0kErL47qKG4hXPNP1kaqIwzPFDIL3QuIqMgW+cXIw1vD1f7vP2MMa0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366433; c=relaxed/simple;
	bh=5Y9pkQPVClNpD8iGFOjZmSyHYRo5y+lB5En9MiNG9vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfH4ZJCjQ7sWDtYCtu4oZp6NQdifA7iBAwLt0tpeCVkeoLxono3OtTK3W2M8faxO3FvGGUKV/9bVtjlJvVLOjGHB+7VqrARgXE8uojBoLxjLmTAXcyrJMPIFD9+8rWxiwUKDUNpigZEWnLZDtdvq6+Va/cabukez74h6Hd+wAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+CX1cNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+CX1cNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A43F1F00893;
	Tue,  2 Jun 2026 02:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780366432;
	bh=5Y9pkQPVClNpD8iGFOjZmSyHYRo5y+lB5En9MiNG9vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K+CX1cNX5nkEoI3pmQ9KIIh7+FBEQ9AnbhnFohBhlUl95yNMrQOg9CvJVG8waRDy3
	 NJRgtdSqNHLZU5zfawuPfLoxxAENkxY/+lcmMs//QqlmE7a01Q7U2cc8JZZD04qRUy
	 XKdvoiTRC0Mf7w/mvhRUbpbE/C3lKcKj3SMu/sPX9r83nNy0emloWJusqeP65Ks4Hq
	 bcgM3j2H0TnZSK3mTs2bhSeWRClARjeEluqmriyAfx33/XBayPD/AvCUoULdGFNEPp
	 etrdTWLbPAzA85Vx7QoyS+9GxkyZk7u7DclrUd/ksa4dGj6TBnHgZfNwavOIynTPwG
	 5lK8qgn+Xah1A==
Date: Mon, 1 Jun 2026 19:13:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <marek.behun@nic.cz>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thomas Eckerman
 <thomas.eckerman.ext@ericsson.com>
Subject: Re: [PATCH net-next v3 2/3] mv88e6xxx: Refactor 6352's serdes
 functions
Message-ID: <20260601191351.31e2b09e@kernel.org>
In-Reply-To: <20260528210310.1365858-3-fidan.aliyeva.ext@ericsson.com>
References: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
	<20260528210310.1365858-3-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 23:03:09 +0200 Fidan Aliyeva wrote:
> 1. Replace serdes check by mv88e6352_g2_scratch_port_has_serdes in
> mv88e6352_pcs_init function by mv88e6xxx_serdes_get_lane function making it
> more generic.
> 2. Replace serdes checks in mv88e6352_serdes_get_* functions with
> mv88e6xxx_serdes_get_lane making them more generic.
> 3. Add lane argument to mv88e6352_serdes_read so it can be reused later for
> 6321.

For the future -- if you're making a list in the commit message your
should rethink whether the commit should be split into multiple
individual changes..

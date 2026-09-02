Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BD1D514E;
	Wed,  2 Sep 2026 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310618; cv=none; b=SnmJrsIFXnI/UztCon2BXUyunncd7MqswC7OX0lIu04Ag6yxpbwlClcbbdqQF6dM07aBLGAedwO2JWDrelriRrfRLFxLW6qFkeIOdkZe+Jn25hbCgfGlDtHglbGo6LHDCuuRUp6uP2hmSMTQY2V70DtmgDJ5Kl/6B6TfsVneVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310618; c=relaxed/simple;
	bh=fIatQWxM3v7VSh3G5nJLnjLwP3qZHbI5lmkxisrmbws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiD4iJwiSOuDXnwIgAmPpxd03V7Dv2yAoYYj5ZCmKC1oeklVdEz+FZzY9qnC02jfP0YJrsw8el+D6CvOZKODEpiogBEhEgURQn7v30hwcp6faEZNhz3+QU3zttoBj6gMHDlEdqx3QBbKQZXIIdbrT52pcANHcTTRGTV5GmPBZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGewAYNn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGewAYNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280DF1F000E9;
	Wed,  2 Sep 2026 00:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788310617;
	bh=v9hQkrTQpCdYUWcRlq59ZR3rOHISlSIspCpZ0zoWqv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VGewAYNn7VfuFOGsiFqBhdik2wtJu7Bk/uhavck+qZCGfQb89FV963AE8s/TKGeaf
	 x6NQwCjd5me1LkMADGj/MqGGsTAqRCyNTa+CY+qW43B7YGsFjtH+0zS9uT8Az0V6gy
	 KjDvdzSWiwEtnXim4HSw26eT43Q/FqjdMYLi4+d6XTbZ5T6i/obSr6HI8Ie/wwgcR9
	 B8TIZTg11Jg6R4+qfU0EDSqmJw3ScJehcNz9p5JeGAK+4gN6EgadWvmR+gtdZnYHmE
	 E+eQIJ33o1nqAXxyNzFjWiSVDbE8WOvFHA4WpvePrMPI35UVehD+ovFuV7TktepQwb
	 QYTKzd0IxYq+w==
Date: Tue, 1 Sep 2026 17:56:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 1/5] net: dsa: yt921x: Check lock status
 with lockdep_assert_held_once()
Message-ID: <20260901175656.346e6262@kernel.org>
In-Reply-To: <20260831044818.4103477-2-mmyangfl@gmail.com>
References: <20260831044818.4103477-1-mmyangfl@gmail.com>
	<20260831044818.4103477-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 12:38:54 +0800 David Yang wrote:
> mutex_is_locked() was used to check the lock status. While it should not
> be triggered unless a bug is introduced, it does not warn on lock being
> held by another thread. Fix it with lockdep helpers.
> 
> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

If you're reposting please drop this Fixes tag.
Either it's a bug that needs to go to net or it's a net-next
improvement which doesn't need a Fixes tag.

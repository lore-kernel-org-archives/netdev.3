Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C829CE1;
	Wed, 20 May 2026 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241856; cv=none; b=d7QfZdMzY/RbSOccNWRvHkwEnIm1S/xZ3rbCpi1AlXQdM8pW5LKJYnXqLZYaVj+Ry2lqlG44JQn06TKFE6Nnqt8MniS5EXqgl9MLVk6+gzIXTBDBCd0yi0eiidcvb2iubJPZtfGRvfvD0/Ji/ef7VVeqs3t8I5pcpYa+dCv067I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241856; c=relaxed/simple;
	bh=oEFF7oAJXNifLYzg4xO/zk3mwpOiZUNhWFuX0LM5zy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DT354nsLQq6hyGqz5Aane9UFKTw5uUXIdmsraZQ+cEBug2Iq5GteJqdanwHj4nhTeGRckp9XXNVpLbOjLZt1LWw2TowIXqKYeSg9+hMGskCzk46yq6sgjI+bWBZCRnOn7oheuLeYKZejohxxS4jN0gAj/yH1krh/luiaLvtBgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuyv7KDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuyv7KDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5011F000E9;
	Wed, 20 May 2026 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779241855;
	bh=1aJnMeJio2cos278iuIZCIWNeb0Zyn4tRzJL6f0ZCP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fuyv7KDuxqo3IQ26HXLikhtqD9FZzGFW+FP3mAWMPVWD42uc9iIg9qvNPAnivenrO
	 Z+mMjMUKW57voTRNmo8qfnNN1jV7jmQO8n5KBiAbgkmxlC4vR3wWzq3LUDeq7+H+AJ
	 yv2qANqz5J8vLf8k2HrgkxsYjx/CuElrw9mAB4L5lMBjkl1ajTPoyIKUdJb4b6olaf
	 lquaYTdHc8/oEgS7hVpEvypriiB2QoM55TjUPGrq/kFoUze7S3Bs3nIHg3ptQPfQ6d
	 yjdxs6FgytehSZ0RuHBcAT7EMRPSqeLf8sB9JqcjJjNzcOzw4Y5PQm9Wd+JOAvQPHx
	 Z1VbRl458R/6A==
Date: Tue, 19 May 2026 18:50:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <marek.behun@nic.cz>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thomas Eckerman
 <thomas.eckerman.ext@ericsson.com>
Subject: Re: [PATCH net-next 2/4] mv88e6xxx: Cache scratch config3 of 6352
Message-ID: <20260519185054.4f8fe637@kernel.org>
In-Reply-To: <20260515223707.1026325-3-fidan.aliyeva.ext@ericsson.com>
References: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
	<20260515223707.1026325-1-fidan.aliyeva.ext@ericsson.com>
	<20260515223707.1026325-3-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 00:37:05 +0200 Fidan Aliyeva wrote:
> +/**
> + * mv88e6352_g2_cache_global_scratch_config3 - caches G2 CONFIG3 value
> + * @chip: chip private data
> + *
> + * Reads and stores config3 value of global2 scratch registers, which
> + * can be used to determine if the port is attached to a serdes. The
> + * value does not change once the switch is released from reset and
> + * represents the value of the pin strapping. Returns negative error
> + * number if the register read fails; otherwise, 0
> + */

The documentation of the return value has to follow the kdoc format.

 * Returns: ...
-- 
pw-bot: cr

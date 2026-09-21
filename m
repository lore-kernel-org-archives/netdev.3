Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E60423A72;
	Mon, 21 Sep 2026 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032368; cv=none; b=rpHrRdiHfgwVToXaEnnbQXZ2d+vY/yp4+b2iy/SHDj1NP+JS4qtPg7ZGp2a/lwi1d46HjWzMmS2EU+WS5IloJdYWqD3PuqGh2OM0YAhgwWKsG9taj77aX2gBKpIfmHXvhV3oVluP4i2WybsuINDsusKF2FETza303G0owVTRKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032368; c=relaxed/simple;
	bh=8bmo6rME6ZO+fpjk9bMmruyHxVq8PEsU9d81TXH5aU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJBD8UwMIVlKdLjqNT19+t8Qkx/ko7tIGZJoMz2v7X625zbw3NclQfSFxH5MVizIbhJegJbk8nPFyVoYCIumc+FYO8rmKfJPz26qQjgLuQoowzLknneoX13DqH6cpm5hNiISVe1V9CYmynAMOCEFJyzN6qOrm5EUn3w8hQE3fF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFsfygKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFsfygKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6371F000FF;
	Mon, 21 Sep 2026 23:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032366;
	bh=TzsqyVxFGovRsQqLM0aksXwwYMwWK+mbmw974hkYZZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aFsfygKckNTllnVd2Thy5OKqD4HLS+HaZ0sApdLD5Hh8ZLUHK5lvaMBQKewlzKnZe
	 q5uhw7DCYHJvvKFm1DcDShApHynO0eV/7gL7jfhT4zWyLuUWR6RQiKa3kFwZFy6EGO
	 8HV0tXlRRPOeAsIvQiFtTik0sDrZLZRjvhZ7SbTJHH8nPvcbvXarDAPBM9twbovHeY
	 FERCn4imiP1SiXUCakw54Jg7epadHvWu0QUuM+l7Sb8F3GXC6euj+y6vZHgBreUZha
	 bGH6mnMszgEf3Jyy97axUGuMHmGZbm7/ct7zPFhoGRKb5OxQuKpOVKN5y9Aj0q5ojA
	 MwbK3qPChhRZA==
Date: Mon, 21 Sep 2026 16:12:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Sagi Maimon
 <sagi.maimon@adtran.com>
Subject: Re: [PATCH net-next v15 0/4] ptp: ocp: add TAP CPLD support for
 ADVA TimeCard X1
Message-ID: <20260921161245.7ff10aee@kernel.org>
In-Reply-To: <20260916153242.157171-1-sagi.maimon@adtran.com>
References: <20260916153242.157171-1-sagi.maimon@adtran.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 18:32:38 +0300 Sagi Maimon wrote:
> The ADVA TimeCard X1 (PCI device 0x0410) carries a Lattice MachXO3 CPLD
> on the TMC I2C bus.  This series adds access to it and an update path
> through devlink flash.

Good enough for me, please post incremental follow up on any of the AI
nit picks if necessary

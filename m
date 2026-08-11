Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC53C872C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465505; cv=none; b=kCZSM1gL6PmvQ4o7h985gtF6HlMuCXKhiGbQbST9pWeht7ZHmO/+YKKQ6Ef8UJKVgBAEzAzeqQj8GW0bNYuSnw1/SxM++EzLQpzu/tRTBqjLzIWa5BEui33od6HQCkRnb8AO6wz2eumbxWpjIWnp4ojlD8AgSQIgSKYlbSop+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465505; c=relaxed/simple;
	bh=skL6VC28Tew87Pd7WDNencpwaZcS4QS93iK8n3NdSlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVwF5wib3WbwY/GiK+lnD1vySJRO6vPO2oUlOqbK4XwDz3fJeR55Crf5aM/FZKNYB1BTWav/joWWHTD/ymRurUTrGNDK1Dkor+B4wCg5cyHkyGKlUZC6x7winuXwi0cHtaL75Ip6/FWygz1PuZPlqAB6XHcePZA0kr4P6GCT2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9wsraWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9wsraWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A871F000E9;
	Tue, 11 Aug 2026 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786465504;
	bh=skL6VC28Tew87Pd7WDNencpwaZcS4QS93iK8n3NdSlo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q9wsraWrL6IzJKHcSylCSmEZZ0SOt2Ev1yvfNx2PXjpYlFX5F0dh0trlqIGD3ptZ5
	 YpgH/NmARgOQ4bfX+vFp9M7Za/0hAZmwFk5DLha5NtWmVLAQ7yzt7JP01mZlcVdGJz
	 Q2y0zN7t0we0ZpMxlSY4I2TjvtaPw7LI/I9agEZ8YB0oaGtvUK8RVzY240R3ct1Lgs
	 BNUnuXYCZvndf32Q+tjzp5PJZZ76wAKHoOb5mFhbpysfpqgjadLFLJ37qa5cTaT0bp
	 3uN4cBKQ3gZHZKpTVeZ3GvAmj3cMPuEcwMmOZKAI6Ts6Ae/E8V4yDTA81SZv1yxhpQ
	 s1ThRuWcHEmJg==
Message-ID: <0426ecca-d0e0-4329-b47e-6e281996ea28@kernel.org>
Date: Tue, 11 Aug 2026 10:25:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 08/15] ipv4: Replace &arp_tbl with
 arp_table(net).
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Elad Nachman <enachman@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811022448.116235-9-kuniyu@google.com>
 <ee6e639c-558c-4538-afdb-3ab6c1c3476f@kernel.org>
 <CAAVpQUATfZAif2brwjaqdWTH_JzKzRjFdZ+Yrj07TrTkcYXQWw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAAVpQUATfZAif2brwjaqdWTH_JzKzRjFdZ+Yrj07TrTkcYXQWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 10:10 AM, Kuniyuki Iwashima wrote:
> It's still bisectable

After patch 7 (before applying 8 and on), data path and ip neigh show
both work correctly?

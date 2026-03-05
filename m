Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDC157487;
	Thu,  5 Mar 2026 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676726; cv=none; b=GTfzXrzMRXLbepd9Dj2Vl9SNh7f7V7n3UNLrB/ki7C8lTtlntU7gWrRMRDS8KfnLPe8jPIB3ua0ZF6NUc25SmWZtN9WHwmdcSEBPgHpO6862ndER8+bqOhLuBmb87lC1p6+yC6aAmX0uUq7D2rfdcVxT5qELDg0fD6bxLHx5zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676726; c=relaxed/simple;
	bh=4+9iupg0W/9o2VpCkHtEDNLaR0h7fusIT5LUm8uhtxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ju/qyH+J84KkRRgd+Ol3PuE/jO9k+t9N6wS7X4wtHcOoESqZMziLqEHkZc9YfKaLh4xkXb3wa9cvsYZXNmeXgC1DT8yBLbSK2Xg0ommQPkSQsPhmb6YB/l2MRVNQqUyTsDfIQUdGaOkeHTyYkghPtpSy8qnEAREzr0+ucQ4SAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aai8st3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aai8st3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7EEC4CEF7;
	Thu,  5 Mar 2026 02:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772676725;
	bh=4+9iupg0W/9o2VpCkHtEDNLaR0h7fusIT5LUm8uhtxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aai8st3zfVkhgHi0QZfN2WAUOdvZ6Ncv9au8e26qEb5zAdCBU/+xxjWdZwuTzUtQ7
	 Po6uC/AR35U4PO8h39YdRAlqfgb/6h65CnUVQlRrZg4MAx57P8jWir1iWG9C+GAfkV
	 dvPpagL4VmHz6QzaS7oKXu+LbzAHtmuQx2Jv94fwWUQr0HPhXika6+gGrGvFDSF15p
	 OVMrd6k1N1zzpTNzIY1lElLFOm1R/DJSmIyFUM2RobrkQowGIOy3lvrAeJaXQH/TrN
	 suuOwJDZWW0+MJtfVvrMpSpfXmjVO92iAZk1UrCTSB5akaC551ZX2wd0UjEWhHeTQS
	 V0fjZhlALR8eA==
Date: Wed, 4 Mar 2026 18:12:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Cedric Jehasse via B4 Relay
 <devnull+cedric.jehasse.luminex.be@kernel.org>, cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] net/sched: cls_flower: remove unions
 from fl_flow_key
Message-ID: <20260304181204.7b580afb@kernel.org>
In-Reply-To: <20260303-net-next-mv88e6xxx-tcam-v5-1-6f9129687276@luminex.be>
References: <20260303-net-next-mv88e6xxx-tcam-v5-0-6f9129687276@luminex.be>
	<20260303-net-next-mv88e6xxx-tcam-v5-1-6f9129687276@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Mar 2026 14:18:23 +0100 Cedric Jehasse via B4 Relay wrote:
> When creating a flower classifier with an ipv4 address the
> flow_dissector has both FLOW_DISSECTOR_KEY_IPV4_ADDRS and
> FLOW_DISSECTOR_KEY_IPV6_ADDRS bits set in used_keys.
> This happens because ipv4/ipv6 fields are a union and
> FL_KEY_SET_IF_MASKED() will interpret either being set as both.
> 
> Removing the unions fixes this behavior without needing special handling
> for union fields.

Jiri, this change is fine right?

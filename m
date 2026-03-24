Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D622689C;
	Tue, 24 Mar 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774321207; cv=none; b=S6ifQ/77wNb6sf5ne5EoAwwJQTA8tw0tUkNGbsuIPNNqIYbwnfS/PE5KtlDLsC7wQA36H/4ugrXcFIQ5VRx05cRhXMamhhjAqukp4jSSoCKT5iiutUmNQJw+9MclaP2rFTZb9X/RGX6KCV19rdryJwjw7GSZN2rPvj1+k+7Aq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774321207; c=relaxed/simple;
	bh=8am/PI/eXArNj+ENpOvmq28FMAO5BOgkaX60u3UIPrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4VjoURIrwax4ZXT7xeTaTpjUT1JuRRVzs74QN0d2kcIKu+/5O4FdEfEZPVg2K/TABWvf4pyFzory8jhsgFF0CwHKS4/W8BAut55FaXtGhW2IaOsfGn3JYM9ka5iGVrwZnAN++QTSPday437DMDBcquOc1BgbYVlTXawrMliuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3YnVCG6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3YnVCG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C2BC4CEF7;
	Tue, 24 Mar 2026 03:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774321207;
	bh=8am/PI/eXArNj+ENpOvmq28FMAO5BOgkaX60u3UIPrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T3YnVCG6ZVQ4YC2tEkSes8Vavy+9W37DmWXJZ6cgVu39Pve7BAh1VMmJqItvToa1H
	 u3E+TOaOpXfuuIHoQp1sdjq1J2zxWSzShwWuaZb6EWXjpji/lNKLcq0gDL3ykItoyZ
	 LGDGpZOuTzuMY47s8r3BkpnqVCYJsjQmMOvWhGlj7lyN6YYnCJ4HwK7cJqgvdPdVVY
	 dplvMSDREtrrT+1hzHyoe94cwTJLxHRqAG4fqwUWMR7eFhlW/1DvUl8fEanGw38AaW
	 re1DP9jDSw4IphTIiV6XilDSLgCNIdlxnjd5KLc3XVzf7ah8FihiAyG6T/8JL6ZKym
	 NNjY0ds9SbCYA==
Date: Mon, 23 Mar 2026 20:00:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethtool: pass genl_info to the ethnl
 parse_request operation
Message-ID: <20260323200006.7f5aa157@kernel.org>
In-Reply-To: <20260323095833.136266-1-maxime.chevallier@bootlin.com>
References: <20260323095833.136266-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 10:58:32 +0100 Maxime Chevallier wrote:
> The .parse_request() ethnl operation extracts the relevant attributes
> from the netlink request to populate the private req_info.
> 
> By passing genl_info as a parameter to this callback, we can use
> the GENL_REQ_ATTR_CHECK() macro to check for missing mandatory
> parameters.
> 
> This macro has the advantage of returning a better error explanation
> through the netlink_ext_ack struct.
> 
> Convert the eeprom ethnl code to this macro, as it's the only command
> yet that has mandatory request parameters.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks1

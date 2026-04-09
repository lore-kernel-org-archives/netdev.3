Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B671B4257;
	Thu,  9 Apr 2026 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775695185; cv=none; b=RoH+b/wiZQBAuTj5K63MpyZLjpisDK+h28a/zjDRyZjDyjBT4c6n0tFGywBGpFqAwImZNckQYJbyKBtza3BTKV68PCOGbvJnUyZCrkw4/vLhMtYskDaE+E+BBVPXPN3JJrYVpxSL6GRXfAhemMgdRLOQph2kTxsoSnTU4letBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775695185; c=relaxed/simple;
	bh=mIBdcAHhCg0cdf3O6BTPmI8DCT1I532pYGV37bdNJew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTzrryNReJJZdmxSZNW2c4SVrildT31yo0p5lz8g8WC4QvchCYEzM5U2+GR/x5DUxMU6T066Fg4fgjWbBMeH5lzrNjeq9IjEYbVr0E9W+o8qhf2z0i+TIGE1V21nrKjRSxF4cp6eBr8Z1UFv3LhTtK22OFSk3/fot1nvC6TVU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAJOxZmR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAJOxZmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E21DC19421;
	Thu,  9 Apr 2026 00:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775695185;
	bh=mIBdcAHhCg0cdf3O6BTPmI8DCT1I532pYGV37bdNJew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jAJOxZmR4cMneKisrl9eQ2hTpaXyP3LArxPVEeQiWAP1iBvaWa+JiM8kNGR4Rjga6
	 Dt1SKNYIxKLeuLPYr9sMbDRNloKjMIgf2VoElYA+0rE2wiR8JF18RCIbsRLbasbib8
	 ZB3np3sG/HjZvYSeJfrbDNkV4lCiyapKuOjeZlDMcWtmeBVRfTFsAMmZYaVIBMYzHk
	 6eRwrHXlcz/9aF4OJ2Gdt04A4oY2yPPaDrGXgKa5XCWxDEFK6gZAbSTA/GTFgDfFEi
	 PqRBef63oauZzV2MbLaKTg/dsFBA4MRetJJ+C/FMFxe2s8sHlP4FZ9q/ppwtgsrbPk
	 nwd9mIUmUOdxQ==
Date: Wed, 8 Apr 2026 17:39:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] ethtool: strset: check nla_len overflow
Message-ID: <20260408173943.2c239ae8@kernel.org>
In-Reply-To: <adaFjwkOrPoBgzoc@devvm17672.vll0.facebook.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
	<20260408-b4-ynl_ethtool-v2-5-7623a5e8f70b@gmail.com>
	<adaFjwkOrPoBgzoc@devvm17672.vll0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Apr 2026 09:43:35 -0700 Stanislav Fomichev wrote:
> On 04/08, Hangbin Liu wrote:
> > The netlink attribute length field nla_len is a __u16, which can only
> > represent values up to 65535 bytes. NICs with a large number of
> > statistics strings (e.g. mlx5_core with thousands of ETH_SS_STATS
> > entries) can produce a ETHTOOL_A_STRINGSET_STRINGS nest that exceeds
> > this limit.
> > 
> > When nla_nest_end() writes the actual nest size back to nla_len, the
> > value is silently truncated. This results in a corrupted netlink message
> > being sent to userspace: the parser reads a wrong (truncated) attribute
> > length and misaligns all subsequent attribute boundaries, causing decode
> > errors.
> > 
> > Fix this by using the new helper nla_nest_end_safe and error out if
> > the size exceeds U16_MAX.  
> 
> Not sure that's the user supposed to do? Does it mean there is no way
> to retrieve ETHTOOL_A_STRINGSET_STRINGS for those devices with too
> many strings?

Not via Netlink, they can still read them via the ioctl?
Since the legacy stats themselves can't be fetched over Netlink 
I'm not sure we should lose sleep over reading the stats strings 
via Netlink.

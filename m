Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF84EC67C;
	Wed, 16 Sep 2026 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560351; cv=none; b=gIcwkaOiUMV67bn4xBnCFUgCKA6q9odO1SbBAQTGgaodGqT/6O70WjGu6klhJFpYXdccK5bKo+xlD+isw7dpjWf1HgwH2FxDMyQMvK7qjg14fxxnNcM2AfN6taRfv7zDDf4thUCZEnmaNrBmkfR2DaC/9ombZzV4YiZeVoK/TXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560351; c=relaxed/simple;
	bh=CK2+EU+G2g3fCZCqPsbI4vrpbTu+gmMf8STlHXNc7vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqkXwsTiVc9EiZhimVjxqtF/VoH/Vx6N2I/D8Hk/Y7M1+xGzgeIH1qrd0g02foo/wdKzop3U8cifjjKNm4CwVxy5HPdUmEBRtrDBn+b44XwBUVQLVCTP6tEFvv2M4kkNvXnrR5ZeCvOfAjwD2eDUCP/+N+bSryOR2sxr/6KI0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhj/6BQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhj/6BQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FA21F00893;
	Wed, 16 Sep 2026 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560341;
	bh=tduLhELvxLlJ5TW7RXfLxV0DmqrWC7twkAXWDhTTi1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qhj/6BQdHWSTVjATJXja/idZCnOKprLaViGk8aiaVO+BHcYT3QFlCh0Zxe1J/7hRb
	 pALKMwK+rAvI4NeugTGzwTpI9+lfUuPLhCpd4WdjaHViLTh0zlytXtXmEwqSwQZJA0
	 ibaSBuEZW/N/21Xw0wF3OM6NmepR4/iPIpPj2z2GC7C8BNWHMQ9mwW0bS0O4jVP62k
	 lT3rWBRhNXyy6rc7aBvp/DcR1MdB4FcwZMgqWHklgzTAQBaWDCU4WEz2svz0cAt/g+
	 ESpxnw/NJN6UnHPXSc28SNGhaIJZTbbODTbPARKpKsSyc0/+iXImERKKNf/7tGsX65
	 Q0ZESXXZx54vQ==
Date: Wed, 16 Sep 2026 13:05:36 +0100
From: Simon Horman <horms@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: ncsi: validate MAC and VLAN counts in
 Get Parameters response
Message-ID: <20260916120536.GC51261@horms.kernel.org>
References: <20260912180937.60250-1-elb12345@hotmail.co.uk>
 <AS8P251MB0001747FE185395C4303F511C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB0001747FE185395C4303F511C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Sat, Sep 12, 2026 at 07:17:45PM +0100, Aamir Ahmed wrote:
> ncsi_rsp_handler_gp() walks the MAC address and VLAN filter tables using
> counts taken straight from the response, without checking them against
> the data the packet carries or against the filter arrays the earlier Get
> Capabilities response sized.
> 
> A malformed response can therefore read past the packet, write past
> mac_filter.addrs[] when mac_cnt exceeds n_uc + n_mc + n_mixed, write
> past vlan_filter.vids[] when vlan_cnt exceeds n_vids, and set bits past
> the u64 bitmaps that track the enabled entries - which for both filters
> overwrites the array pointer stored just after the bitmap, so the same
> loop iteration then writes through it.
> 
> The response is not guaranteed to be linear, so make the fixed part
> available with pskb_may_pull() before the counts are read, then the
> tables they claim, and take the pointer again afterwards because
> pskb_may_pull() may have moved the data. Reject the response if either
> count exceeds the array it indexes, the bitmap it sets bits in, or if
> Get Capabilities has not run and the arrays are absent.
> 
> Fixes: 062b3e1b6d4f ("net/ncsi: Refactor MAC, VLAN filters")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
> v2:
>   - use pskb_may_pull() instead of testing skb->len, in two stages: the
>     fixed part before the counts are read, then the tables they claim,
>     taking the pointer again afterwards (Simon)
>   - also bound both counts by the width of the bitmaps they index; the
>     v1 check covered only the arrays, so set_bit()/clear_bit() past the
>     u64 could still overwrite the array pointer stored after it
>   - correct the Fixes: tag; v1 quoted a hash that does not resolve, and
>     the filter arrays came in with the refactor
>   - use offsetof() for the start of the tables rather than the literal 48
>   - read the counts into locals so the loops do not re-read device data
>     across the pull
>   - add the Assisted-by: LLM tag (Simon, Greg)
>   - name the target tree in the subject
> v1: https://lore.kernel.org/netdev/AS8P251MB0001E99A1865DFEC3C3A16E7C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/
> 
> Compile-tested only; I have no NC-SI hardware. The OEM and GMCMA
> handlers read past the header at their own device-supplied offsets and
> counts and are not covered by either patch; those are separate changes.

Reviewed-by: Simon Horman <horms@kernel.org>


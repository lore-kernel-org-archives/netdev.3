Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F03B95F2;
	Wed, 18 Mar 2026 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828463; cv=none; b=gGvfV5mdeQBe5L1YIJ7g95r7OxHEd3ZDaPMbGXLA68JzpJ8V0wNO8JVWpj5EOj7pkhWGbhr2HxRaD1hP8IpDGYgBmxJ0ee6urI2C4KXc9Fs9uqIn1ou9hYt0RSIUe/+08O63fCkadQhwn3j3UdtTzcwO3rruARuMERTcCKHL1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828463; c=relaxed/simple;
	bh=aWuwGRmYag/h7yzZFPeJ4nT/X5k1lanNdxKBvbq9Gq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoWqTbjPyfcohLbN9GvqdwXBz4W5znf+9ycWZLnbLaQIWHnReycmyB85HE2n90MyLrxAhytlLnN8HjKqhWQL54eScyR+0neODLRFFcZe5CTYOry7sc3DLgBdhzwpcmktjIJ8VvTIUSX4HdEeMK3HUTYuTFtdhPKImpmlejwPl2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLa2aurT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLa2aurT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E7DC2BC9E;
	Wed, 18 Mar 2026 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773828463;
	bh=aWuwGRmYag/h7yzZFPeJ4nT/X5k1lanNdxKBvbq9Gq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLa2aurTFCAV0ItTLPkalSf0Qf6kJF2XwvT6FK6QsTvlLBq4tqVfY4yCjdn7SR0el
	 OButKANVkg9QesqL3OlXu0BkkvKyMJM4SgZUPNNoG5V6klD7bTlzNQb+quB29xIeeQ
	 Uju30v7TSFKu8EiizLG8+R0o7WvDXeTR5+TNyfE36QBIO7rETTbu2eRTcGOV/7re6k
	 QtDEBTekjltS0zN/dNcJJNbyHghUlq/7bKvJRoQnyDd9pzrVHL4zqJ1bz0D2+wczUS
	 Umvm5Sy1MEe+t9Rx+vmLRaMXYG0zUy/FpBvuSrpvWttqYgFt+CVg8gl0KeHQBAX3oj
	 Ej0L+P0PCUrZw==
Received: by pali.im (Postfix)
	id DC29655E; Wed, 18 Mar 2026 11:07:38 +0100 (CET)
Date: Wed, 18 Mar 2026 11:07:38 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Martin Olivier <martin.olivier@live.fr>,
	Qingfang Deng <dqfext@gmail.com>
Cc: netdev@vger.kernel.org, linux-ppp@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH net-next v2] ppp: add IFLA_PPP_UNIT netlink attribute
Message-ID: <20260318100738.vcnp7kntuzavyula@pali>
References: <PAWP192MB2411A808BB36F0086A9B00B99742A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM>
 <20260318015937.239409-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318015937.239409-1-dqfext@gmail.com>
User-Agent: NeoMutt/20180716

On Wednesday 18 March 2026 09:59:29 Qingfang Deng wrote:
> On Sat, 14 Mar 2026 02:14:29 +0100, Martin Olivier wrote:
> > Currently, the PPP rtnetlink API allows creating a new network interface
> > with a custom ifname, but it lacks the ability to specify a custom PPP
> > unit id.
> > 
> > Setting a specific unit id is currently only possible with the
> > PPPIOCNEWUNIT ioctl. If a user-space program also requires a custom
> > interface name, it must create the interface first with PPPIOCNEWUNIT
> > and then rename it.
> > 
> > Resolve this by introducing the IFLA_PPP_UNIT netlink attribute. This
> > allows user-space programs to atomically request both a custom ifname
> > and a specific PPP unit id during the RTM_NEWLINK creation process,
> > eliminating the post-creation renaming for this use case.
> > 
> > Signed-off-by: Martin Olivier <martin.olivier@live.fr>
> > ---
> > Changes in v2:
> > - use nl policy to set IFLA_PPP_UNIT min allowed value instead of a manual check in ppp_nl_validate()
> > - use of nla_get_s32_default() to collect IFLA_PPP_UNIT value
> > Link to v1: https://lore.kernel.org/netdev/PAWP192MB2411A5E7D3BE1B55E155A92F9747A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM/
> 
> The patch itself looks good to me, but I would like to check the
> userspace changes too. Please create a pull request at
> https://github.com/ppp-project/ppp/pulls
> 
> +Cc: Paul Mackerras, Guillaume Nault, Pali Rohár
> 
> Regards,
> Qingfang

Hello Martin, in past I have sent similar change:
https://lore.kernel.org/linux-ppp/20210807163749.18316-1-pali@kernel.org/T/#u
Look at the discussion, it can be useful to understand why the change
was not accepted.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A33C6A44;
	Fri,  3 Apr 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228341; cv=none; b=cQWSEzwL5XBuHfNAY2KS1p82hF2YFXk+r/LqxW32YvVrbuJzVXuFyg8rTUWNawoWt+CLvIpgIS4hJBmG3KMFuo+iFPfG7zPTbJCtthqXPpR/fWbSxRfYgkwKbJdNCQ7aEoniMnxbF27OKHDEb9Juxj4RES0dGBmx2jlE38/8sXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228341; c=relaxed/simple;
	bh=enGeWySKUi0HCyVOWNN8Grni0WBb2nqtURwmRJBoN5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC+FPpihZuEuRtOCJSGexHeJzodkAPdZbWZiggJL7TAzydQDCFjxpgQrAeR8LPsseLWI+Q9aunCSuKb2urigBpBcRnvogKaWnsqL+D2M5nBr1qIabmktme41XP/BopgfvXSkMp2RfZkhyFp8beRZ9KGzwjmeFaHHeKhOham1rCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7Fnsd1b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7Fnsd1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40229C19421;
	Fri,  3 Apr 2026 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775228341;
	bh=enGeWySKUi0HCyVOWNN8Grni0WBb2nqtURwmRJBoN5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7Fnsd1b6+ZhaFDhCr23v81t2B6lM2zyCPzeY40HYKId1lUmzP0mvkg/pHd45X9XY
	 jMoI0aDgGKQSHeNuH+bxU7U80W7pFfFjyadNzARrYahxsyPoM0XvmGsO1/FSCiyYq3
	 ioPD+gRHE7s2IMyOYGb4Mgim4J8kQ0vKaODZz0QmkYSl/atSKBi1mg9e/32Eh8UmuG
	 j+nkH6FXqmXktZJ3ia/1S3GAf9PMegEC+NZ/8GGv3GFtA1/qPn0h3T+/Zsz/nw5uoJ
	 k0AU/Boh6duU6fjvDZfJTURwHLRFAp/Q1OWw5x++5zYQD4faNY2oHwOFLBoIT4p6hy
	 uWN9I4padERyw==
Received: by pali.im (Postfix)
	id 616E4677; Fri,  3 Apr 2026 16:58:55 +0200 (CEST)
Date: Fri, 3 Apr 2026 16:58:55 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Martin Olivier <martin.olivier@live.fr>,
	Qingfang Deng <dqfext@gmail.com>
Cc: netdev@vger.kernel.org, linux-ppp@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH net-next v2] ppp: add IFLA_PPP_UNIT netlink attribute
Message-ID: <20260403145855.oyhsqunzy7e2ptsa@pali>
References: <PAWP192MB2411A808BB36F0086A9B00B99742A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM>
 <20260318015937.239409-1-dqfext@gmail.com>
 <20260318100738.vcnp7kntuzavyula@pali>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318100738.vcnp7kntuzavyula@pali>
User-Agent: NeoMutt/20180716

On Wednesday 18 March 2026 11:07:38 Pali Rohár wrote:
> On Wednesday 18 March 2026 09:59:29 Qingfang Deng wrote:
> > On Sat, 14 Mar 2026 02:14:29 +0100, Martin Olivier wrote:
> > > Currently, the PPP rtnetlink API allows creating a new network interface
> > > with a custom ifname, but it lacks the ability to specify a custom PPP
> > > unit id.
> > > 
> > > Setting a specific unit id is currently only possible with the
> > > PPPIOCNEWUNIT ioctl. If a user-space program also requires a custom
> > > interface name, it must create the interface first with PPPIOCNEWUNIT
> > > and then rename it.
> > > 
> > > Resolve this by introducing the IFLA_PPP_UNIT netlink attribute. This
> > > allows user-space programs to atomically request both a custom ifname
> > > and a specific PPP unit id during the RTM_NEWLINK creation process,
> > > eliminating the post-creation renaming for this use case.
> > > 
> > > Signed-off-by: Martin Olivier <martin.olivier@live.fr>
> > > ---
> > > Changes in v2:
> > > - use nl policy to set IFLA_PPP_UNIT min allowed value instead of a manual check in ppp_nl_validate()
> > > - use of nla_get_s32_default() to collect IFLA_PPP_UNIT value
> > > Link to v1: https://lore.kernel.org/netdev/PAWP192MB2411A5E7D3BE1B55E155A92F9747A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM/
> > 
> > The patch itself looks good to me, but I would like to check the
> > userspace changes too. Please create a pull request at
> > https://github.com/ppp-project/ppp/pulls
> > 
> > +Cc: Paul Mackerras, Guillaume Nault, Pali Rohár
> > 
> > Regards,
> > Qingfang
> 
> Hello Martin, in past I have sent similar change:
> https://lore.kernel.org/linux-ppp/20210807163749.18316-1-pali@kernel.org/T/#u
> Look at the discussion, it can be useful to understand why the change
> was not accepted.

Anyway, if you want to continue on this patch, here are my points for review:

- I would suggest to use IFLA_PPP_UNIT_ID name for consistency. We
  already have IFLA_PPP_DEV_FD value where is FD suffix which is saying
  what it is. So for naming consistency is the suffix "_ID" useful.

- Allow to specify -1 as an valid input. Currently the
  NLA_POLICY_MIN(NLA_S32, 0) does not allow -1.
  -1 should work as a default value, like if the value is not specified
  at all.

- Add #define IFLA_PPP_UNIT_ID ifla_ppp_unit_id into the enum { ... } in
  if_link.h. This is for userspace compatibility, which can check fi
  the IFLA_PPP_UNIT_ID is provided or not (via #ifdef).

- Do not rewrite error to -EEXIST when calling the ppp_dev_configure()
  from the ppp_nl_newlink() with specified unit_id. ppp_nl_newlink() is
  a new code path which will allow to specify unit_id, and hence it is
  not useful to hide a real error and replace it by -EEXIST.

All of these points I have already handled in my version of the patch
which I sent and is available in the above link. So you can use it as an
inspiration how to easily handle them.

Pali

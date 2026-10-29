Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282133;
	b=DP5YxxRqLZAWoQw8IHBJ3U0KrATHlnJlvyqWDn07UM/O/Joj81637dxC9JY8CcurJ/KT
	 gNEeZnnhXVyfnHd/yeAKuAjJb72S2ZbZtimFY7dmkrxqXj/JrQu8yD3jk8o3U+ZWAvcPO
	 ypAg5Qh+1LiKwGW0LsKRfwpeHHJZXXoE649WC8uwQ75GBPmPKbhPifK2WWodWCM3BmuNW
	 TIYQBFxX2ht0n7Y5xHadTYDW0m6VlVG3im33LuV+XtIImk4t9BCggN3rThwwoOKH9TF1O
	 FBB6Apvr+7xB9z6onwy1idWUJHTqxiakTE73PH0IZuJL7EthaVoF+NVgy+qoF10E4kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282133;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=GDJQEL1Snxyy99oTMfKYhvEkJfMxmlyGC8C0OGiTR14=;
	b=2qY5dBDVR4rD+rUdxheDBW+7UkC2ZRuamT8Vzz3wX6VfVIuvm3krcZSh58BGSWAmv9AX
	 ocjUr6hM727g5SaLIKrISikDkFrvnte/PpxqBDtQwTBzKecc566JUqJ1PBj/ngSsaBMoE
	 Ne9BQ+F190Qdmff9GWCE3PQmb41LETdEp3UUwT8mkn1kQjwZlI1NGAmYa/lwXWrr5g9cP
	 9Zfj01jV6sLBrP1Z+/zIiiaoBClk/4qyDruCZUUaIOX/jglzwB7KUXF5tSxFO4Tdp0/CH
	 yUxgJl/NRMll7EjyzHcseFbciLyk3kvYyBwY4VsjL3bWQaCfF6/8vuERRV5G9FYLMew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3N1i23X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8C606A327;
	Thu, 29 Oct 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3N1i23X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E16B1F01828;
	Thu, 29 Oct 2026 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793282132;
	bh=GDJQEL1Snxyy99oTMfKYhvEkJfMxmlyGC8C0OGiTR14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A3N1i23XhdrIQ9DMeTXMW3vzzSBTR039e22JPwAXJsqQ6sWtIu2bVM6BHazLejQA7
	 UBad1ev0sBeObnthzMnbWTBjva4JsYG/VzIbK0QEPdMsvQxkuAuXc3tx06ekopUu+1
	 vN2m+rYcAPU/TwZapeZTzm2tzQxWZALcMCVI6BvVn8HiqFzqxUTKyLds0oBQUhCpTe
	 bIfv79xQiO9B+QsGGsurU0fbp78/jDVM1q0vbTnxG5VAkOXvDFaoeZSNt6gr75IfuJ
	 g54f1iBuFvcFnCamJI4lJQYEkLDfuuAQWt5UJetpdCi/TL/zNRtiUrKCLfuIPPA4dt
	 zpcFAUnD39vLg==
Date: Thu, 29 Oct 2026 13:55:28 +0000
From: Simon Horman <horms@kernel.org>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, pablo@netfilter.org,
	laforge@gnumonks.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	nicolas.dichtel@6wind.com, osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
Message-ID: <20261029135528.GH257209@horms.kernel.org>
References: <20261027130623.3136658-1-anilkaushikwireless@gmail.com>
 <179324692107.3134.14443689892607921337@kernel.org>
 <CAG0Mgm_DxY=zZwBW3xEeNE-1LC93OWPkO4HHw=qF2Qhti-Mf4g@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG0Mgm_DxY=zZwBW3xEeNE-1LC93OWPkO4HHw=qF2Qhti-Mf4g@mail.gmail.com>

On Thu, Oct 29, 2026 at 09:49:35AM +0530, Anil Kaushik wrote:
> On Thu, Oct 29, 2026 at 9:38 AM <netdev-bot+sashiko@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 1 · Medium: 0 · Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [High] An unprivileged local user can still receive gtp multicast
> >   notifications (PDP add/delete and echo responses) by joining the…
> >
> > --
> >
> > gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group
> >
> > This patch marks the gtp generic netlink multicast group with
> > GENL_MCAST_CAP_NET_ADMIN in drivers/net/gtp.c and with uns-admin-perm in
> > the gtp netlink spec. The goal is to stop unprivileged users from
> > receiving the PDP context add/delete and echo response notifications,
> > which carry the same data as a GETPDP reply.
> >
> 
> Yes, this works, but the gap is in the genetlink core, not in gtp.
> genl_unregister_mc_groups() clears the members of the IDs it frees, but
> nothing clears them when free IDs are given to a new family. So it hits
> every modular group with a GENL_MCAST_CAP_* flag, psample and
> drop_monitor too.
> 
> This patch is still needed, and it does not change. I will send a
> separate fix to net that clears the members of the new IDs in
> genl_validate_assign_mc_groups(), like the unregister path does.

Thanks Anil,

One step at a time seems like a good approach to me.

Reviewed-by: Simon Horman <horms@kernel.org>


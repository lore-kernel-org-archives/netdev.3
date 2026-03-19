Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD152FFF88
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949473; cv=none; b=KvCOZTEDJBtkQVWw8g8LRGN6xdR5th0MYlFp84pf/0t55D7UznL5MwiuC/+/CgLyA70ws1cF03wTyEFWVpmN2Kti/z4HZOOS2FAZ2UeoxnraV7RHR+dK6TH4WZgT1jToNqfoWebxmBDTvt0OflJIiHB5Upu/CYd4kdDQ5bCtL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949473; c=relaxed/simple;
	bh=3ozfv6FU517Jb4qTTKM2z/pb6DduV9qQ83/ayPIuF3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiGisrAc3ROMfUCCG+9KMLqO/6g5eS3bSXhQLJkiS9AklFeLLvdYNM84SXjW+NjvSprmc1OcxCGVQ52NnKdhlUdlUmmbPXUbNGqcIg3x8zMOx6ExYQcpe9zayCaMvSzKNAiI21+Q97tJL0S4EOyBr9QcGGwnGxvB3qfFNxOVp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCZSmlkJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCZSmlkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581ECC19424;
	Thu, 19 Mar 2026 19:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773949473;
	bh=3ozfv6FU517Jb4qTTKM2z/pb6DduV9qQ83/ayPIuF3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uCZSmlkJ/8kY2P6jU+SrZO6stP1g6BHlNpCA5rvCsg/r25XgGVzawMtP/4t9w6hlF
	 db0Cw2OrmtNKEfIWIf6wZoLzuINfF4aDU7X0kJ/AG885AwlPdAI7iJnl9MB72kGpHH
	 RznS1OXLGx44kGSgrBb88k5Sj8CV19KeQFezVIJ47MN3CgMrYxp8c/VsyWwwj3vOtq
	 T/1rDbbS7fsOKRfGrqlDx/Sm78myjXVB6VYOXwBeFvZtU6SqUIjewxuKcXQMNeAr39
	 efywan9M5HW2+abh/8Ou5vbDO89WES/SzkRoVeXtF3NmH9LASUClpt65QS1IN7+kmD
	 XXKNDmE/PgmHg==
Date: Thu, 19 Mar 2026 12:44:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 0/9] pull request: ovpn 2026-03-17
Message-ID: <20260319124432.2fda076a@kernel.org>
In-Reply-To: <20260317104023.192548-1-antonio@openvpn.net>
References: <20260317104023.192548-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 11:40:14 +0100 Antonio Quartulli wrote:
> This is (yet..yet..yet) another resend of the original PR meant for
> net-next.
> We have fixed the hitchups in the commit messages, as pointed out by the
> AI.
> 
> 
> This batch includes the following changes:
> * use correct constant when declaring nlattr array in ovpn_nl_key_swap_doit
> * use bitops.h API when possible
> * send netlink notification in case of client float event
> * implement support for asymmetric peer IDs
> * consolidate memory allocations during crypto operations
> * add netlink notification check in selftests
> * add asymmetric peer IDs check in selftest
> * add FW mark check in selftest

In addition to the mark test failing always three more tests hang
around 30% of the time on debug kernels:

https://netdev.bots.linux.dev/flakes.html?tn-needle=net-ovpn&min-flip=12

Please follow up with the fixes? More info how our CI builds the
kernels etc:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

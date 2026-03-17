Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CC1FF61E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706506; cv=none; b=aevzXmGRV/4wGRV+7DCOCiCCxdK0inf5g9h2bRuOf7Emi7Fz65Nu+uIgjWv3lIDbdGfKboV2UWd2RX3z+i5EGiyDUfaZ7Im7yRQHill0JlW2e4OggF/FJZekHBqRxk6gL94DNORM168fZwxyzqxj7G9GLZR38oHcLS1O9Tleieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706506; c=relaxed/simple;
	bh=jkTAZSNReXnPdSy7AGbOxyT1cr2/MDlwJvrHAsel5zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnG2KRvzt7b1w3wbDrKcMdA5DMNIP3YZWqgr3kYkuKc9K/VgXouDj5ox5L/AKoO1ifaK/ClJ0utOxEYX71puisTngk7hY93E21CCUByNFNGw5mxq1V+GLYZadIZJTTuPJIb2bOkdH9fJQsSWguj3285O9WFHDbBCguEHyGZyghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo7ZGCVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo7ZGCVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58362C19421;
	Tue, 17 Mar 2026 00:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773706505;
	bh=jkTAZSNReXnPdSy7AGbOxyT1cr2/MDlwJvrHAsel5zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mo7ZGCVLpJjl17cNyAuXTP5mDNLeoo2tOQ3w/gLhtWPgboDdkVO+MfKHcCqgzPGaE
	 XR8BM3EqHrs+Fmd3dyBSy6G9+6CtIMKm+LGaLACcH1v/FydwYxwUWGeCvdLDQ60Xq6
	 3sObNMfAlz+8eLkv3UQzgAF4TJTYajnNnUjdnzjJO2q8zQQ44nz+WPWjS9Z8Vb0pvd
	 cVkSEWSglfm5ar0a9o8i+TlsIlXGGtSmTv02qmXSxSPGKgYglEIM/mb4iE+fe6Bq4x
	 y6OrlMIXNETYnQBHVnXvcEOKLalm/TW3aAAzX3XwMWkSXy7FwG1BUQiG2CszSQBgW7
	 6Db26Nwz4EIVg==
Date: Mon, 16 Mar 2026 17:15:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Justin Iurman <justin.iurman@6wind.com>, netdev@vger.kernel.org,
 andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, nicolas.dichtel@6wind.com,
 stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it,
 ahabdels@cisco.com
Subject: Re: [PATCH net-next v3 0/2] Add support for seg6 tunsrc
Message-ID: <20260316171504.606024d9@kernel.org>
In-Reply-To: <1b749c77-3ec6-4821-b4c2-5e8c3ab3033a@gmail.com>
References: <20260316162955.1253225-1-justin.iurman@6wind.com>
	<1b749c77-3ec6-4821-b4c2-5e8c3ab3033a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 21:01:25 +0100 Justin Iurman wrote:
> >   include/uapi/linux/seg6_iptunnel.h            |   1 +
> >   net/ipv6/seg6_iptunnel.c                      | 114 +++++++++++++-----
> >   .../net/srv6_hencap_red_l3vpn_test.sh         |  65 +++++++---
> >   3 files changed, 134 insertions(+), 46 deletions(-)  
> 
> Looks like patchwork considered that this series has been superseded by 
> the companion series for iproute2-next :-(

It's kernel.org's pw-bot not patchwork itself FWIW.
I revived the series. Let's see if the bot discards it again.
If it does you'll have to repost with a different title cause
our CI needs to see it "active" in patchwork to run tests.

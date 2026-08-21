Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F53A1A23
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313761; cv=none; b=cs/hDIF6E3ZI5yYUiifUSv4wsmMOpkFQYNIMBi6SGMsoahiwAW3XtGmnLkW7c7B1+K323n9DFFVXxSU7rE7a6ADyBJCPtDq+2xK+RVcu0Shzzp9AVPj4+urKVSEeLP8pmK09c9ufAd3GUCUBVrZyMDS3QX00w/RiQ67+ZMS5EfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313761; c=relaxed/simple;
	bh=dRUFmSotv4RDJu2bfkUkk0G/VTsyCfV53+OHMqb99iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbEiB2Fkys0Rf54glQJ+zE7Oc9iEA4PMQWVRJncHDuwSlBDMRoAfxjQRNwJn/D5rDE5qB3RvyAnSg3gDXr0ZLO/SVCZxDDqpaj/fPs9ybhKatSvylCXhF8CjGnjgIQE7pL2Pi7RrKgXKyjjHKa8JR3FhSShkCgtrQN/BMPF1ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=lUalz8jr; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="lUalz8jr"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hRJpG1QhYz4B1x;
	Fri, 21 Aug 2026 14:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1787313750;
	bh=dRUFmSotv4RDJu2bfkUkk0G/VTsyCfV53+OHMqb99iY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lUalz8jr+udKr/uoFiPRKJjeoYc2axFPbiNIBR/h3Udg+5ie3RwXPOe/L4GeIHZQJ
	 1qOUvvMYcQNFHHAUxLV3NK1o2RzsnlXHs72rX8vGNXZEZKYSnCzNYNtcQpp4VBSiNg
	 Zs1HyfHicg3rMaYHYZvpFgA1zxaG9DjDoHKe3mjCXWrBwnTO9F1FKMi3/F9EnozI9Y
	 pz1APO6Ro/xwfSXB00qYW1AHiKCqw5/W1MEH6qxoTFnPA9fxL6w0JzsOZmLPw8XVxH
	 j8sQy8bUibYfykdb6uGn2hjHrqxIIiEj3n3NRx6VGSTbjqi74/Cmvnxd8F9F4oUCPS
	 Pi9edLKpnL1Hg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hRJpG0kYlz46Jl;
	Fri, 21 Aug 2026 14:02:30 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hRJpF2Bwlz8sb7;
	Fri, 21 Aug 2026 14:02:29 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 36AF95F959;
	Fri, 21 Aug 2026 14:02:24 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d5d5d445-cb7c-48b4-9084-027031891344@leemhuis.info>
Date: Fri, 21 Aug 2026 14:02:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION: bnxt_en fails to initialize with errno -22 in
 page_pool_create_percpu on 6.18.45
To: Holger Kiehl <Holger.Kiehl@dwd.de>, netdev@vger.kernel.org
Cc: regressions@lists.linux.dev, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com
References: <6175537d-934d-41b3-904a-faf3b784973@praktifix.dwd.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <6175537d-934d-41b3-904a-faf3b784973@praktifix.dwd.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178731374459.2907694.4795341041323204153@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 36AF95F959
X-NC-CID: cs9OUTHkwGOSK5cZXcez35J4ts1alZf89HxCVrlGZ0f97O+5cfw=

On 8/21/26 13:41, Holger Kiehl wrote:
> with 6.18.45 my network cards fail to come up. When NetworkManager
> wants to bring up the interfaces the following is shown in the
> logs:
> 
>    kernel: page_pool_create_percpu() gave up with errno -22
>    kernel: bnxt_en 0000:02:00.0 ens1f0np0: bnxt_alloc_mem err: ffffffea
>    NetworkManager[2377]: <warn>  [1787169889.4135] platform-linux: do-change-link[2]: failure 22 (Invalid argument)
>    kernel: page_pool_create_percpu() gave up with errno -22
>    kernel: bnxt_en 0000:02:00.1 ens1f1np1: bnxt_alloc_mem err: ffffffea
>    NetworkManager[2377]: <warn>  [1787169889.4504] platform-linux: do-change-link[3]: failure 22 (Invalid argument)

Thx for the report. Not my area of expertise, but this looks a lot like
a problem that was reported yesterday. A fix for it is already queued:

https://lore.kernel.org/all/CAKPOu+-x_QPgp7gvApKNxd=aAONgNUmQQMbiLKwQghWd6u7Y=A@mail.gmail.com/t/#u

Ciao, Thorsten

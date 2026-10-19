Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58874CE670;
	Mon, 19 Oct 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405477; cv=none; b=qL+bnYDT9lLnRiDjYbxs4Brlj9Z96vbA0TLPHwU9d1bmh6Ke7MHhfPtM58EWqrakfPLTFJmxi8TcgRIRYDBbLqv3NB58Y2qxouW2328Ql/RiwzNevQOTIHLLxsINSuYVRLzgVQ/Yi9saQ8cB0j6TK4fVqaB3jhYKez9mvYXs0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405477; c=relaxed/simple;
	bh=qUkIaaPrmLzSbPHsOly/wLRVtHv+4xiLUlsMwSL+rXA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eCKXMg+XvrmUuZ1iWMdj0vV5KEld67R49UWgyT1ZEUirgpB43epIhJ8Cwb/OraooC0U68FMsEp3Q2ZMr8tYEPvlJoEXDQdyOyzAKc+CxqhVcQqIbpvqOLTBmWtncnOPrpPBsDHu5HI8AId/FiOQxq68X7btTYEQoo/BnWzbp/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=sLuOTZk1; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="sLuOTZk1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DDjf5Zet0LKmhh6LAOeo9wOIpr3u3VhhkFWY0LFMIyU=; b=sLuOTZk1259plTznuAjZZl8qHx
	O2XpSyfTSS9N+bngz1bNYYv2VEfq7tqHja8V7CTBuXUZbfodn8VHRBd6Ks2mZNRDSTVr0V6zpuBIQ
	xH7nev8zSTJnPMZ0tMP1ZGqA3vZQfexnkep3Z8ZIMThC/dsFyz40EPe43Z3sef/I9PaV8OvqYgySW
	g8ImJX65XH5Wv8PRMY2/pnp1R6fAVQ7CNQnQJJsjIjhEbpkKs/YrSDLgMBi1u98OmQNwSrTK/kWqR
	23ZA+erM83OeOPCgvt9+CGGpZdnW/x7ENxLW904NeY7+b2mWViEWetwi1zl3dULKJuiX0gPJAQB/T
	TzZP7DcQ==;
Received: from [115.246.246.98] (port=45272 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <saivarun@couthit.com>)
	id 1xIkXb-00000000VO5-2pJL;
	Mon, 19 Oct 2026 06:24:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 013371BA02D0;
	Mon, 19 Oct 2026 15:54:23 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id erd3YtZvu9BY; Mon, 19 Oct 2026 15:54:21 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id CAD1F1BA0896;
	Mon, 19 Oct 2026 15:54:21 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ShKfL8_7tJT2; Mon, 19 Oct 2026 15:54:21 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id A09201BA02D0;
	Mon, 19 Oct 2026 15:54:21 +0530 (IST)
Date: Mon, 19 Oct 2026 15:54:21 +0530 (IST)
From: Saivarun Mudepally <saivarun@couthit.com>
To: netdev-bot+sinfo@kernel.org
Cc: Sai Varun Mudepally <saivarun@couthit.com>, danishanwar@ti.com, 
	parvathi@couthit.com, rogerq@kernel.org, pmohan@couthit.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, afd@ti.com, 
	basharath@couthit.com, horms@kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pratheesh@ti.com, vigneshr@ti.com, 
	praneeth@ti.com, srk@ti.com, j-rameshbabu@ti.com, m-malladi@ti.com, 
	rogerq@ti.com, krishna@couthit.com, mohan@couthit.com
Message-ID: <493615167.624945.1792405461616.JavaMail.zimbra@couthit.local>
In-Reply-To: <179214979438.408196.11375100740673315884@kernel.org>
References: <20261016105206.167094-1-saivarun@couthit.com> <179214979438.408196.11375100740673315884@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssm-prueth: use
 dev_close()/dev_open() in icssm_prueth_change_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC155 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: use dev_close()/dev_open() in icssm_prueth_change_mode()
Thread-Index: Sxdr3LPvc6wuwZudfEjLAZ3i6JSt9Q==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Hi,
 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.
> 

Sashiko, the netdev AI review bot, reported it as a preexisting issue,
while reviewing our ICSSM HSR/PRP offload series
(https://lore.kernel.org/all/179151741150.434549.7819199497598747618@kernel.org).

> - Whether the issue was actually triggered, or is only theoretical
>   (e.g. found by code inspection). If it was triggered please include
>   the symptoms, like the stack trace or error messages.
> 

We first confirmed the issue by manual code review. We were also able to
replicate it on TI AM57xx IDK hardware board.

> - What hardware the change was tested on. For driver fixes please
>   mention the device (and if relevant firmware version) used for
>   testing, or say that the change was not tested on real hardware.
> 

We tested the fix on TI AM335x ICE / AM437x IDK / AM57xx IDK with the ICSS-M
PRUETH while changing the protocol from dual-EMAC to RSTP switch mode.


Thanks and Regards,
Sai Varun M.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542AA37267E;
	Sun, 21 Jun 2026 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079681; cv=none; b=jDoj9DIssMrNKiZ0exeQJLZ/JqmXMow67+2KTGvHvPlGoEJ2wpCdv/2EStlvPGvlejtbAB6mo29uRCZ/uM1H0fGNZnU0CWcaPLaJezU12rqEH6GkFOgzGsvFsZnUz0wXQG9Mj88d3GAzDFPNSOaEmfbl2wRC7czV0+9/WqqVcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079681; c=relaxed/simple;
	bh=wnq0x2nB+8XlZFm4chI0eyIUUmhx6NUujwprcJab2tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFUsR3MjAQ5VQhsdlMiChZuiXodLuLc4bWa6XQQO4NYHj12EUFA3qTLapm4AbwBLfuW/3W/YN1+CHkiaHgeJ4nospDmC63cJbNEVpHQaX/k7sYMA4BYE9yI5sDU1hUAkk6r6mplmkKPaOnyXgd220xVJBu1nxsclMY1so43b/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7JzgS/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7JzgS/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE451F000E9;
	Sun, 21 Jun 2026 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079678;
	bh=AaJPn54N1jMwmkqD+gZQYUCg8heFpPBUy6KizwuIPv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W7JzgS/YgdorTHSDtwdJNyfzlLUiVjZaOXErWzpOFXTBus/SNPJKqTUgG6EHUGR4N
	 u6wZCqIVbzpkBgwd3y+vJj9VLWBzoW1IxdbCJiTHarZSCwfylZsKyvMEPgDwQJFqTZ
	 7pJ+CfBZ1Kb3+fqhP34pORxqfIpTs9o1B/vkMT8aDiUrafBQNm2JiUkDxxRPJqQN9z
	 xzaRglxm90IUxje0l5WUBUQIVaSGUGHcSn8Po787NJ8H6+762kA8w0qQ7xY790Dt+u
	 xw2nD7+20hRd/6DCkYh4Q8ILmkdDng41y4im8YUrzye+qOQOxkeUwXsJeJ3fo4BmIW
	 Qp9CG0zlj0IMQ==
Date: Sun, 21 Jun 2026 15:07:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <nshettyj@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
 <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <Sunil.Goutham@marvell.com>, <naveenm@marvell.com>, <hkalra@marvell.com>
Subject: Re: [PATCH net 0/2] octeontx2-af: Bug fixes for KPU profile and VF
 RX mode
Message-ID: <20260621150757.5b0477a9@kernel.org>
In-Reply-To: <20260619090746.1829416-1-nshettyj@marvell.com>
References: <20260619090746.1829416-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 14:37:44 +0530 nshettyj@marvell.com wrote:
> This patch series contains two standalone bug fixes for the Octeontx2 
> administrative function (AF) driver targeting the net branch.

Does not apply, please rebase
-- 
pw-bot: cr

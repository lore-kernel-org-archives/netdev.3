Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655330498E;
	Fri, 13 Mar 2026 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363641; cv=none; b=iKA/6KI9FB4senmRPOoJ2MEOUpY7vrbSifCTvSJdlKiQ22gsCqO40vU5tZbqagzA1NKeLG0vq/v6sU8Ls/zyksYE09DNF7jADJn09YiWGBxsSUJHDn07zr2oJAFRnQsrlDsFrZ11pECi/O7ccw//rg5rxWS6LlM1IW4g/canZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363641; c=relaxed/simple;
	bh=M8OtnN1rvksBo+7fIEl1ge2cOUq0aHj9k7lajVTLv/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqjAwqURjzqsn7sYV8PfikTN6t0hCck89J1aLVHD7Idd09VC4iXq1I96S0ZuXrRMauVxa4gGke2QyfXl6PzOjmzGcNJibHwAhydtguA44rBhLjOg4bysTyZdoKGLAclYYSrFDMhjQihokqKUnMi1bWMpiS1ZctRbkRxazL3Do8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdlfykkT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdlfykkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E149C4CEF7;
	Fri, 13 Mar 2026 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773363640;
	bh=M8OtnN1rvksBo+7fIEl1ge2cOUq0aHj9k7lajVTLv/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sdlfykkTNaj9sebOkHXQvDpuFK2f1th5ZzftJOkcHQnWBuA8lXmxCE9iF/+4nFxzP
	 X9ff7x3BH93yLSRWLOyhFmhHnNARfsGNsT1ESIRhecRBqCVx1lhH2zZv8fGm/VaMLI
	 8u8ghrawIBPoW5wPvbdosnpf4kS7Zlai54rc+8xS+W8tluTnOzL18+J5ZXHTnRjNeG
	 OAaPBSWuNlpkoc/jFOWoQytrb/7J1nIx4SEWCLmiBpJbm/95itkSsIqBzz6Ypzm90s
	 Sui4/6lr7e1Rp4w16ayICkpG0SO1xHguy7XqVgw25YAFsL4O5uNUgS8oO+fuWB1Eki
	 1BDHNiGex2j9g==
Date: Thu, 12 Mar 2026 18:00:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Olivier <martin.olivier@live.fr>
Cc: netdev@vger.kernel.org, linux-ppp@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: add IFLA_PPP_UNIT netlink attribute
Message-ID: <20260312180039.436ca9c2@kernel.org>
In-Reply-To: <PAWP192MB2411A5E7D3BE1B55E155A92F9747A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM>
References: <PAWP192MB2411A5E7D3BE1B55E155A92F9747A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 08:35:26 +0100 Martin Olivier wrote:
> +	[IFLA_PPP_UNIT]		= { .type = NLA_S32 },

	[IFLA_PPP_UNIT]		= NLA_POLICY_MIN(NLA_S32, 0)

and then you can remove the manual check in validate?
-- 
pw-bot: cr

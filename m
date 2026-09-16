Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7243C1966
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522894; cv=none; b=bex0hBXDLcw7iaqPKj36wTEMn27oR6hUi73s3rJeTEEXiYs4KKohXk9Uffe/mWtkop94tY7xqoK/D5VdkMEuN4/u0BvA5xLa+RKs3LFOdUNE+Ilq19VNI8gQo6b+iqpOyRoEQCHWK+rWJnZOVTkJTjBt7HTAVL7RAjBxca1PrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522894; c=relaxed/simple;
	bh=NLMN1EtiJTZRYb3XtK3siLG1Sb9sK5R0fcOEje0TLgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sf+Qt66/LzqCRamGratNq7AYBe6aohO/luMd2nTkuYWtT/WLz9mv8t1ocEcZYXwjvvVJwjAE/4vLqFsd1wJ6jhPlofjR+G+L1gLkL0eEZZBpXMZ4IC36Vsy9JGfcUh9IC87CkmJLFGNvsV9bwYoNYQZvCsyJ3KxCBFqJwPhFHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXE3QwQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXE3QwQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A941F00898;
	Wed, 16 Sep 2026 01:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522888;
	bh=dHPkC8QhWXFUNuPNUvPE3TmfSki4JIu/IO8gxpc8dMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RXE3QwQX/PMPOGduTO8nIk3CEF8mjsEpTrVgZ5j1D8dgk77iEvanT57NnbZEdaWuW
	 0ynj9jo/PzzA6elP8zyWBWWaIxNMpxo/6LgLmXjDEw4IjfxKj5CA9uqY52GXrzNd7W
	 8WudTsqJKzDamL9kFPmU2KjU8l3Tj6IhmEZW2yevvOktx/dvSwA8U+jmAOH1jVEBdN
	 nAdQOlGgWA6nSj9p6TANkiCLkLp8LKWjGn+K+hGvs5Zas7zbeLfBP2UyE/EtagWfXQ
	 nA04XigIRVAVSZiZzL1Ixv9zRrT2GAlyLn8S10nIOyiXHWq1D3GZIQ8OEgZqWln9iV
	 GQxKojU8oFNmA==
Date: Tue, 15 Sep 2026 18:41:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v5] net: Wangxun: protect ring accesses with
 RCU
Message-ID: <20260915184127.25de623e@kernel.org>
In-Reply-To: <20260909090005.79368-1-mengyuanlou@net-swift.com>
References: <20260909090005.79368-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 17:00:05 +0800 Mengyuan Lou wrote:
> +			struct wx_ring *rx_ring = rcu_dereference_protected(wx->rx_ring[i], 1);

These  rcu_dereference_protected( , 1) calls are quite ugly.

Presumably you are expecting safety here because of rtnl lock?
so rtnl_dereference() ?
Otherwise please add a helper like

wx_get_rxq_locked(wx, i)
{
	return rcu_dereference_protected(wx->rx_ring[i], ...real cond..);
}
-- 
pw-bot: cr

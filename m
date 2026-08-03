Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799FF36B903;
	Mon,  3 Aug 2026 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799338; cv=none; b=JCYVOFSETGUEpejroOJgqWLRIgPTvjiWnb/IeGwKfSJOPPsB4o6d3cbyldC4oMt5+TiBFjVxwksFjiD6XAitKHmMf/0D5ZaxxCCiAN1N6MEnC0d3rpKSFVUNEeq4oShtj5lxlUXMvBN5vKdyervwYdFrniJy6KViHcNHD0RwepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799338; c=relaxed/simple;
	bh=Hh3CVAtSOQQNvGY6dUiq2gSJQ8PqohVmLEQxfHOnXlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNUSNYq6tgz0itkw6aUhDkkq7iNblG105/r/C/oRBZwSnRednnOG4jqn+iLkn9DMlrYiNmEBpkEzOOatdYJTFeGsiaclglNm7+rIr8HfmWQYeImAU5CEaStcTyFYOllTJCbUxp/BPRIeNw7JQ/rgHmfQykX4SW9fToWbPn9b2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEfAfXoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEfAfXoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EB51F000E9;
	Mon,  3 Aug 2026 23:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785799337;
	bh=YrM5T38/PRY78hfpXbNH9pN/3LylZ9vhTbYdJKd/3yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BEfAfXoDeooTOrlJPR3/iFtD168L12YR7GsNkidK2ep9OVvEU9gReFkvQLLeRWCft
	 81nZr33oWk/6rmN1d4zYS39bWUl0xVho1XS8hwNKBamkDaNPPBiaD9XSDZocyNbNvw
	 7gMEEHTKTNOW8TYRrg3Ffjrm1DF11kWRZ2zzqbc/H2/5A1hz5zvxOnn7lK6NeKsTHT
	 bcj+P4Ck8Q2733eF6yYD5utgXNzBJe2dkKQGjVpXR8vaMCZ4f6qUhvKGVNzVeMV+hJ
	 HXo32DPoYUI5o10szjdXPcaPGwy2w7nhw5AufQvHWyw3gDjov2+6W2UWG0xU7cm8I9
	 cE41fvsRvK+iQ==
Date: Mon, 3 Aug 2026 16:22:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Can Peng <pengcan@kylinos.cn>
Cc: manishc@marvell.com, rahulv@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] qlcnic: move notifier error cleanup under
 CONFIG_INET
Message-ID: <20260803162216.57bc2515@kernel.org>
In-Reply-To: <20260728032046.121631-3-pengcan@kylinos.cn>
References: <20260728032046.121631-1-pengcan@kylinos.cn>
	<20260728032046.121631-3-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 11:20:46 +0800 Can Peng wrote:
> qlcnic_init_module() registers the netdevice and inetaddr notifiers only
> when CONFIG_INET is enabled, but the pci_register_driver() error handling
> block is outside that guard.
> 
> Move the error check under CONFIG_INET together with the cleanup it
> protects. This avoids an empty if statement when CONFIG_INET is disabled
> and keeps the cleanup code structured like the guarded registration path.

Waste of time. Like a lot of patches from @kylinos.cn patches, sadly.

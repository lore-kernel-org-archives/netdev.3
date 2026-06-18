Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2491D432D;
	Thu, 18 Jun 2026 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826773; cv=none; b=riPxQFH0tj1uKjYSPkgo2hnSd7aBA+ViZ5ZBE481CLt4O8jcaNtZEBl3hB2km3Wj1nmhktbHdqMyPMOZaYgpAF4uygPUOF4vm/CI4QEFfw5ramve5JFnLIc/Fm5+/IMAH9qFu1nojYF1oA3iFTR71cduOURBEFlhDts2U/kdKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826773; c=relaxed/simple;
	bh=1fMqCeRAzURot3QR7lnU+VM1Zf5r7iFO0oCmPKSJWw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J02SBhJ6IfZ/EXCWPN2SI1Bg3KksOS6uMrRV77lqekXRX7nUnS4YwHdOTpRLYShNVX/NFqfihes8r5VsX29xbI6Xvy9gygPGOVLjqg87qCUlqa80gjiLiq/0E4D7Dh/kguyDg73oq3SJbW5qR3sNpqqlO15Tre40nN3tbDwUS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UklqvM8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UklqvM8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E431F000E9;
	Thu, 18 Jun 2026 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826771;
	bh=uUCIzc/GnjW1ATBDBpZJKy40lW/N/F06z5xK86WsEIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UklqvM8QmWzogHOkXT/md8DiJUOadKR2qXqlQJjz4HBaMRVsY58p+RkBp5GUCI1Wh
	 R2slRd5aFQWYCLDsg47OVrnXsBeu84czwgZ6Fbycbd7j4w++Ta4RBSppFaTeApdYQD
	 jZeZXP9hUbXvf3Ii/x51K90+I21P56Kdz6itQdEaxVrxNkzrH2CtLLtEQZdzNruIMM
	 B/Xid6ivj6HlxYjNIOS3DY2udJWpNQbNit+S9XGgM/sOdkv621DtwhOR3rsywkF8ss
	 kLAqXc8tmLq+GDjk9YKk44T7jitea4gPb6gntmKwc8FzlK5W7xPYtz0Dxpd9ZqyeWy
	 BfsVso+wwojEA==
Date: Thu, 18 Jun 2026 16:52:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: sanan.hasanou@gmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, contact@pgazz.com
Subject: Re: general protection fault in fou_nl_add_doit
Message-ID: <20260618165250.0cdfefd3@kernel.org>
In-Reply-To: <6a346fa4.26cc5c6d.1ace13.9d21@mx.google.com>
References: <6a346fa4.26cc5c6d.1ace13.9d21@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 15:22:28 -0700 (PDT) sanan.hasanou@gmail.com wrote:
> We found a bug using a modified version of syzkaller.
> 
> Kernel Branch: 7.0-rc1

That's an old kernel. Did you re-run this on 7.1?

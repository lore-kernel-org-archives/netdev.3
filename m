Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742762749EA
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427018; cv=none; b=eOMTS0sFdGRDleE5LM619RMoa57+5PFwaobiR+6IzEXcz4ZFRkxDd5tYOPGB0xaBr5JgZ6w0YwHjAilTws8hD2c3cgazuiIBvosa/zYzm8LfS/SX9Orn4deawnSS03iQtX6KtGXxolfaeBnkfpSZ9xtZoMju6zTFMmhOa0G9cNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427018; c=relaxed/simple;
	bh=Yb9zc5Unqbm55Kqcwq5GJE34VTgUMnFyUDUbA+hjqY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX3HnBJhA2/I9dXGFwkWBH6jBDpsRzoCuB4xT4BIgEej+6Ne/rJVID/qdebQYhwrqudkXjvT4Vt7c96Ye3z3+A7qMh08B1EFJ/BsdqXytO1b9W7AZOjb7fiDFSUGfAF9CsAg8qGbWmWTBuUIYG/bofc0D5DD+PNgG1HlaSih9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUigyiPF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUigyiPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5516C2BCB7;
	Wed, 29 Apr 2026 01:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777427018;
	bh=Yb9zc5Unqbm55Kqcwq5GJE34VTgUMnFyUDUbA+hjqY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GUigyiPFHwGr8sWDKONW22d34HdjsUYCDEGfyFYFpIqJO6wiXnQYdMOhfuf68vbDl
	 JHXO/O1fKar7wE1BIvWHlAmCHSWHP4GZ8pgAxPlDICd1ue4VEhLvypmO0Jpzfw0bGm
	 0iTjRByjX+tqpvMmPp0M5B9JSPQobTpqS6zroOA0K72bbiqwlvtCLsaQH6rLaULCUL
	 bEuPIOmYrCBRGgQ3THNpRcMGhlV43kFnHK6s2weORHJEs0aHWl8S80Wo2/9R0e2rh7
	 Pmy3QdoGE9xXBwaz97ui7fqNY5It2BlTi4UNSI6GAUTMqYc2f/j3UV4wHcMILtSA7B
	 5XF4kNEO6v2vw==
Date: Tue, 28 Apr 2026 18:43:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next 3/3] psp: validate IPv4 header fields in
 psp_dev_rcv()
Message-ID: <20260428184336.2244b6a1@kernel.org>
In-Reply-To: <willemdebruijn.kernel.223eebd28b57a@gmail.com>
References: <20260428205352.1247325-1-kuba@kernel.org>
	<20260428205352.1247325-4-kuba@kernel.org>
	<willemdebruijn.kernel.223eebd28b57a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 20:22:34 -0400 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > psp_dev_rcv() is called from the NIC driver's RX completion path
> > before the frame reaches ip_rcv_core(), so the IP header has not
> > been validated in SW, yet. We expect that the device has done
> > all this validation, but let's also add the SW checks, to avoid
> > surprises.  
> 
> If devices are expected to have verified this, should these be more
> noisy checks, similar to netdev_rx_csum_fault?

Maybe "expect" is a bit of a strong word, I meant "anticipate" /
"suspect". Dropping invalid packet in SW doesn't seem like a huge
problem, other paths in this function already do. For rx csum the
problem is that we got a incorrectly math'ed out value for what is
likely a valid packet.

That's just to explain my thinking, if you prefer we warn / dump skb
I can respin.

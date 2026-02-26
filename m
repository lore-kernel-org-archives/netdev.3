Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC95387579
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076391; cv=none; b=pfpK5XMVFTvKVMIxDIcenwCJB7r7ciW1xvMsrehAXPQ7h3BhbTj9QXf3B4FH1IWcO8C1v2hQpzrgQ2zZ0kmPz7UFMK467LDuLEVSYAEP79E916GADhtSg15sgG+nhyFQbQi7AQvVFGVnaD/BiSpGRdTMD8eV744h24XKCUmuBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076391; c=relaxed/simple;
	bh=11xZd07ssCetIZfDnnYEKUdj8sFlDKiHpt81AQv0jog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhL2vxIQmhM9Ia+gVJKLJd63mjZSZ93vZgTnvIHLXvddVrEITlZdkrv41CGDmBiSedzRzSzvEA/UxjlVGM4gqsPoVH8pqON+rse0jz19nHgt6qNJZtvTbf9oIFxEeyJJcU69xEtTwi+5lfBGR5eD5UFjJz/1TMvpd1nwun0ItEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6Gw+AwE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6Gw+AwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930B0C19421;
	Thu, 26 Feb 2026 03:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076391;
	bh=11xZd07ssCetIZfDnnYEKUdj8sFlDKiHpt81AQv0jog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b6Gw+AwEubQLx7t4/U8JHPn/Bq3vk3crfk/pF78WvT/7HHHOzlLiq2QOz6071rk0y
	 HtgLnzy2hlAP8ClB+/sEX59qaTT5TSrpq0QDU06psXvTIkurPjO62gphatwmoxMNXk
	 AEhkofAjrnl1mcRNrVfDL1ArQX3ool9ZGLjdL+b0StHbFn0DZhD7bQctDT1qs4xOKZ
	 6Tdp4H9LyCWEtog1gT9dy9CjwZ5GqsVD9lMTANyUx4ePsdgQA/tQ1+1Xgo9YIYIZmE
	 f0JLfjCGJZt6IZhzUl4xNvaPKNc5qUx3jBX2snvbTXJz2asVuPACaCR6dqU+c9pNuH
	 uEgDt06xPH/og==
Date: Wed, 25 Feb 2026 19:26:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Eric Woudstra <ericwouds@gmail.com>, Michal Ostrowski
 <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Nikolay Aleksandrov
 <razor@blackwall.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v20 net] net: pppoe: avoid zero-length arrays in struct
 pppoe_hdr
Message-ID: <20260225192629.19a66eef@kernel.org>
In-Reply-To: <aZ4hgh73UeHHd1gD@strlen.de>
References: <20260224155030.106918-1-ericwouds@gmail.com>
	<aZ4hgh73UeHHd1gD@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 23:09:06 +0100 Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
> > Although it is needed to prevent warnings caused by my patches send to
> > nf-next, it was asked to send this patch separately to netdev.  
> 
> Yes, thanks for doing that.  While I occasionally do send non-nf patches
> in pull requests, thats usually restricted to very small functional
> dependencies, e.g. a new EXPORT_SYMBOL().

Yup

> Dave/Eric D/Paolo/Jakub - this change can be applied to either net or
> net-next; it avoids W=1 spew with patches under discussion on nf-next.

I went with net-next.

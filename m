Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DE3358A9
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970955; cv=none; b=gsrjCN5lJYthUq3b44sJvS8G12RcRKbi14CaQjPwOJDhpz43oz2JiWYEA70UrI8AD1L41Cinp3P8naWiPu98Z3/pveP46ZJRwoWu84F89IG9sEiqn/4LAv5tZ/OXoQmbkpsXfCLUelTpURbBoVpVysCGdJcd774g67ZgWXW+/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970955; c=relaxed/simple;
	bh=k2+M4hVyUmwplnKUGUYz0nBAqIoxso7XBtSP7k8gCMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3pjMWs3B8BL0nhi3jwZQRJSUl/Bh26YKz/5zhVFvWE82e8KGoeHhvxblx7pOu1ebIQh578ep4M3YoLgKrEP4Tf7OEPNbtQi1JGpMN96evilhaFRinSfimWuLbghV1gtyeIbqdDA6chaf2BifhBIJFZWshlFk/3dCoWddCxvHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 589C860D11; Tue, 24 Feb 2026 23:09:11 +0100 (CET)
Date: Tue, 24 Feb 2026 23:09:06 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v20 net] net: pppoe: avoid zero-length arrays in struct
 pppoe_hdr
Message-ID: <aZ4hgh73UeHHd1gD@strlen.de>
References: <20260224155030.106918-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224155030.106918-1-ericwouds@gmail.com>

Eric Woudstra <ericwouds@gmail.com> wrote:
> Although it is needed to prevent warnings caused by my patches send to
> nf-next, it was asked to send this patch separately to netdev.

Yes, thanks for doing that.  While I occasionally do send non-nf patches
in pull requests, thats usually restricted to very small functional
dependencies, e.g. a new EXPORT_SYMBOL().

Dave/Eric D/Paolo/Jakub - this change can be applied to either net or
net-next; it avoids W=1 spew with patches under discussion on nf-next.

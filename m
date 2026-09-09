Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE812561A7;
	Wed,  9 Sep 2026 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912223; cv=none; b=BGR56ikw7QhEU6q3zkgRBMeYtsxEYr69705eb3MFLbBCYi1dFxhGR+uh1PWA73C3gkmHHtem7HG3gPH9JNq7JGOrSlAwwXa2evknmfLRyFU9pwa3qGzAvDCAR6u8LPl9UnQHAiTEROksjuFdubcjhiLr13Go2kMvWiNZ3CfkNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912223; c=relaxed/simple;
	bh=fRxxyaxF4sEIOICY66X/8reWA/2dX8AYB6hJI+WF83c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSNkSKsdxbuIsaoYVVCdvxTyulrSKHP5IiFWMPwrNLVqgEqW475kBXMquMp0EEoTFx4Dp7rH3vKeem2Dvvk/h7ZjR6AlQ4wqId+0MKysbv6hNwgCe088ZpoFhju7JQKgHiejCDvNXivz2LXDg8S/8TgWEijqzadK+qQ/Sf3nWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjv69hpZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjv69hpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF781F00A3A;
	Wed,  9 Sep 2026 00:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912216;
	bh=6IxhlJ9b8uAGlHKepWvd0viaQd29xcE83/MQglixBLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qjv69hpZltPtq1Jt++GXvMsJ/5TJDRZ1v3V1kkkhdBbRThP+4bGsMYao0gjhBtLAh
	 ot2lHeQXQSNi5BktOPaw7t0wSVuA8SzBo7HEQhzbDFTX6urtkSGV1rmYDo1PfLC5M0
	 h5zlFV3eZpzpDNXeOacd28NWmqrN1nSPEAzDaaJFfJbaIz5teGYRcJTr4vrERrw9e2
	 OsvyU/kWTGIET6SrAdxLq7ASXez1mJXENgpZc7TmB9548mCDN9LNqSDpOJ2XbqFbGI
	 HL9yXJosKU3T6d+KNDi3u67serPzDTuExJWTDNbqW4avXBj+jBYz+otefoBXKQpEmb
	 I+QlHAkYFyCgg==
Date: Tue, 8 Sep 2026 17:03:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Mitchell Blank Jr <mitch@sfgoth.com>, Chas Williams
 <3chas3@gmail.com>, Simon Horman <horms@kernel.org>, James Chapman
 <jchapman@katalix.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Kees
 Cook <kees@kernel.org>, Breno Leitao <leitao@debian.org>, Asim Viladi Oglu
 Manizada <manizada@pm.me>, Eric Woudstra <ericwouds@gmail.com>, Felix
 Fietkau <nbd@nbd.name>, linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: [PATCH net-next v2] ppp: pass private data to channel callbacks
Message-ID: <20260908170335.5e98fe60@kernel.org>
In-Reply-To: <20260906134830.992-1-qingfang.deng@linux.dev>
References: <20260906134830.992-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 21:47:36 +0800 Qingfang Deng wrote:
> PPP channel callbacks receive struct ppp_channel only to retrieve the
> driver's private pointer. Pass that pointer directly instead.
> 
> This decouples channel callbacks from the public channel representation
> and prepares for making struct ppp_channel opaque, with allocation and
> lifetime managed by the generic PPP layer.

Not immediately obvious that this is a win. Having a callback op take
untyped pointer can be error prone. Also, subjectively, making types
opaque in C often leads to ugly and unnecessarily complex code.

This patch does not stand on its own, IMO, maybe you need to post the
entire series, and maybe rethink.
-- 
pw-bot: cr

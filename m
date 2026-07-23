Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378B47D258;
	Thu, 23 Jul 2026 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826635; cv=none; b=ZhFjYbuvzd857gF9u+SHtnziv4ZpLg0sO1o2Js21C6CqGi+GdzeWjIl6rcnDtZ8n8dMHsM50LI9GukjEbLaHQGOc485MoE+YEWm0f5CQTqD5OvQGsDREQf6ylFLqxLEn7C+gjXsLxrfD56fYmd83aN2hz4p/fq/qDorkDjE4gfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826635; c=relaxed/simple;
	bh=NQjlK5S3H0O7EyTxQRpZxGYM6cmRbEb6J7vbDLNM+3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/j8YAalYN+QSEoAlTw5V+RTq196MBFcIfEEH89Px5V1IfTIv42ldWrOcgShiwO/xlITPOo4hGjkYLp4Dw7hCELl2rSyRFsWmMLRcUlZP1ZGFQmIacsh50Ezys+/5jKRnSdK922Rdzi5Aud/dTZYUNyvJPnmF07onXSvdn8Jom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35AD1F00AC4;
	Thu, 23 Jul 2026 17:10:20 +0000 (UTC)
Date: Thu, 23 Jul 2026 10:09:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>, Ryoga Saito <contact@proelbtn.com>,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com
Subject: Re: [PATCH net] seg6: fix NULL deref in
 input_action_end_dx{4,6}_finish() after nf hook
Message-ID: <20260723100949.4443811e@kernel.org>
In-Reply-To: <20260720204430.1886091-1-xmei5@asu.edu>
References: <20260720204430.1886091-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 20:44:29 +0000 Xiang Mei (Microsoft) wrote:
> When nf_hooks_lwtunnel is enabled, the End.DX4/End.DX6 actions dispatch
> the decapsulated inner packet through the NF_INET_PRE_ROUTING hook chain
> with input_action_end_dx{4,6}_finish() as the okfn. Both functions read
> the lwtunnel state via orig_dst = skb_dst(skb) and dereference
> orig_dst->lwtstate.

Per Sashiko's feedback - we need to validate not only that the dst 
is there but also that it is of the expected type, no?
-- 
pw-bot: cr

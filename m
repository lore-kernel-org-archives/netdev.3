Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720330567F
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788726087; cv=none; b=TMJwJnLjPC6H9Yo82vINRsDJbdpxFnnCSZQsgZbxwPhlkhIl+iRxAowb2tTK0SV4AimSYbevrj6Gb12rPg7CHyAGinea+MFSlaC5DW0/m8xN2DDxvKtHkT55P9PYY1BcioF7QWDGRMUedayeJ3o1gK+TTWj3yRP8oMIFlSWh1dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788726087; c=relaxed/simple;
	bh=yGM81zTgYUpWd7RvDEOjhVFMmPMtuHxi35UnvesAELU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RSDKqwAkieoX1YpZ9tELy+OAnpUxLz8SnzceoFZIYB2CexEBgYXF3rucAY6TpzaNBUmgKLqNf2ctydrbwPB6aV/7dQb8HDQokVq8kYusrIzEsborxQAI7TxPHhLyOTjP1U7b6C7tz5Z57TJrmXCLJjVs3j84CoyefQQFjcG5T8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=tUtPOm+x; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="tUtPOm+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1788726081;
	bh=yGM81zTgYUpWd7RvDEOjhVFMmPMtuHxi35UnvesAELU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=tUtPOm+xRT9VQ5/HjWHxC908krBunQEzDuQUyUI7xcGHdgdojLYyzpaaONktZ929e
	 IYuxBLBlF5/G1z+Odha7F4hMIWQ0ECw0odWWeXRcQjwXAKY/hWRX5VoakayaPPrmw1
	 A97Zj7iFcKexE1najHlqDShpdpx+FUK+n/B6bdzjR+dQ6qq2vdhcTrXOJtIcoi3ZBv
	 C17OqYlMcgUPdZr504woO9Ux27uadXy2j7aev7E+KyTZ4ToA17aSEAqPVh0JhxjI3c
	 9RcHpo0+wGqsZZIPX1nq+SmTbNCzK5dMb9uVzpd6Yekj8XfzwJ5Y7fAVfVHfZYOtKw
	 mKbmAeoDKU9mg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 07D4160075;
	Sun,  6 Sep 2026 20:21:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id ABB2920086F;
	Sun, 06 Sep 2026 20:19:09 +0000 (UTC)
Message-ID: <3e99a029-dcc1-475c-bc15-3a368b7c00b3@fiberby.net>
Date: Sun, 6 Sep 2026 20:19:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Subject: Re: [PATCH net-next 2/2] netlink: specs: handshake: do not accept the
 handler-class sentinel
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, cel@kernel.org,
 donald.hunter@gmail.com, matttbe@kernel.org,
 kernel-tls-handshake@lists.linux.dev, davem@davemloft.net
References: <20260904190410.3864660-1-kuba@kernel.org>
 <20260904190410.3864660-2-kuba@kernel.org>
Content-Language: en-US
In-Reply-To: <20260904190410.3864660-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/26 7:04 PM, Jakub Kicinski wrote:
> "max" is the exclusive upper bound of enum handshake_handler_class, not
> a class a handler can ask for, but the spec lists it as a plain entry.
> _init_checks() derives the policy limit from the highest entry, so the
> generated policy came out as NLA_POLICY_MAX(NLA_U32, 2) and
> handshake_nl_accept_doit() takes class 2 all the way into
> handshake_req_next(), which walks hn_requests under hn_lock before
> returning -EAGAIN instead of the -EINVAL a bad class deserves.
> 
> render-max is how YNL spells this, and unlike a hand written limit it
> stays correct when a second handler class is added.
> 
> It does change what HANDSHAKE_HANDLER_CLASS_MAX means - the highest
> valid class rather than one past it, as in every other Netlink/YNL
> family - with the count left as __HANDSHAKE_HANDLER_CLASS_MAX.
> The constant is uAPI, but I could not find any user space user,
> this constant seems to have been added for kernel's benefit.
> 
> I think the risk of changing this is worth taking, having MAX
> with different semantics than the rest of Netlink is very confusing.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

LGTM.

Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C03932C0;
	Fri,  7 Aug 2026 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112566; cv=none; b=SuXf3jXWz/Ss1YPzZ3ldYzKlL9vIwI8oN2sVQzuNZgZUU8XNm1UfK0WAhJw//GlXNYT4W6gpTsxdyWctRlcFiWzwj5CbIdM3q42ifat/INgDjDWShj/otjVz5tbx1Gq6XebsW/+XawNSFUDVaAeCjAs+CnQ8YZ/H7D9VSQ/neWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112566; c=relaxed/simple;
	bh=epSLej2hpa9oVtkPj+Mh8Mxdd79U6F76bpj/yaItDoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUlKA/fKTiNuSwTc4DxzfSEO9bLvOe2LNt8NnHe7UdHwGqUPIdYlbEdI4O30kcxN8bq9SWXHlREJ9sjBCIE1hjc4+gtDeXAIDgSTLateMmIxoTdK0QN/toxK9iZb2zr+Tqoy2Hz/uxXiRoPwpydlxIiwRZXy3l8Fl/S/83TbBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=NqNyuMP+; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="NqNyuMP+"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 8D5AF60191;
	Fri,  7 Aug 2026 16:22:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1786112562;
	bh=UciTGOSoT5a52Ix08LnUtvWVxbVgtQBmTXjeM4FJnt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqNyuMP+mJW+kEzC2s+86AtOMd0F59/HZ5MfIx+Sfz4wIDasbvT50TAe3naby3XH9
	 7lClBsx2bAJtEZyT7xVWTGKReubGyXHX1s2FaJiDVkhMNk6L2nc2XExRweBy4mIjA9
	 GRbP/lmKMedE/ZQXCfIVtMiydmvMlV14+mt9LSEY7o0DsPLzK/GTTgKZR5ZxMt+vFg
	 wDBq3oGPMEI3cbUHXXf9y7loe7E2xtaqflH6qS32NQJV3p7DFKy8d8PIc/2Xwbfi7S
	 boVz0kPMLQ4W9YoMHcFNfNOX8EyYij5ISIgpqSOgZQ4FMzHv/j27ZMhM+Rdc6iSR4T
	 LkiAAUs5BcJRg==
Date: Fri, 7 Aug 2026 16:22:40 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: Harald Welte <laforge@gnumonks.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] gtp: serialize PDP deletion with link teardown
Message-ID: <anXqMEQ8wajKIbTE@chamomile>
References: <20260806023226.5537-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806023226.5537-1-a0yami@mailbox.org>

Hi,

On Thu, Aug 06, 2026 at 10:32:26AM +0800, Qing Ming wrote:
> PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
> network device is being unregistered. The latter is serialized by RTNL,
> but the generic-netlink delete path only holds RCU.
> 
> Running both paths concurrently can therefore make both paths delete the
> same PDP context. On a KASAN-enabled kernel, a reproducer racing DELPDP
> against RTM_DELLINK triggered:
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: maybe wild-memory-access in range 
>          [0xdead000000000120-0xdead000000000127]
>   RIP: gtp_genl_del_pdp+0x1c1/0x420 [gtp]
>   RBP: dead000000000122
> 
> The second deletion dereferenced the poisoned hlist pprev pointer.
> 
> Take RTNL around the DELPDP lookup and deletion so that PDP creation,
> generic-netlink deletion and link teardown use the same serialization
> domain.

Could please you instead add a mutex to a use it to protect PDP ctx
updates? genetlink mutex is not enough, and I'd prefer not to fix this
with the rtnl lock.

Please, use this new mutex from gtp_dellink() path to protect the
iteration over the hashtable.

gtp_genl_del_pdp() must use it too as well as gtp_pdp_add().

Thanks.

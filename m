Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6153A3E76;
	Fri, 12 Jun 2026 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305942; cv=none; b=fvCNdcW2MCcwy20L1Rzp+XeAeVoW4ObQnUFa+yMfJ0CXBGsgicjebQ873FWaLRDOVlEMcEIgyhK8K1LjyhgoL14CedELUamyTQwNNiF7szm1ArkQidRrWlcT+gkq8yPoOUsj+w7fR41XzbXhzStDsrjv1BL9g6l59OVjuA9WT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305942; c=relaxed/simple;
	bh=MoEwvpdIZGKGyvFDEt1unue2cVnVVfQPz8rbJMRfetk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmU7IuNSPfuYX0TxHChJ+xSgkf4CY2nbIrQf0hohjy2aX7ldQ52E1fwd4/1p/QCw8ngtLFwrLCMXMV6R7Rutp9ilQ8gXY6C/vorkMIb4DvSpArQFRtTtX5lChdiDgAxs8bG/EPcoRAWqEixUPW8ZKV7vtVBWapolRBS3fFiBMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acGtyKdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acGtyKdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CA51F000E9;
	Fri, 12 Jun 2026 23:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781305941;
	bh=MoEwvpdIZGKGyvFDEt1unue2cVnVVfQPz8rbJMRfetk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=acGtyKdZN6XvGkhAG9vHM8ugVUS6OlHtIswHXnhb12dWXecih+znT6SxE3GAPbAWN
	 KH+5qHnkZBv4ECShHhCqo7HrOANnu2ylq5vhxdG2UjMRUCfGyEykPZDhW6xAcUj1by
	 INY++tgCXHPk1zCAtszPK/jXoC4cH+ETx9BOm2UO2C9CmPMjxOpaAyBANuWDUUwcnE
	 123z0ZEZ0KAReC8KK/y0a0fI1Mc0QTr+Ay2ZNvraB3QTKDCViHJKxSfeTLklo6pBdK
	 kz1K3XtDTNNnvJCUJkxEciORLgn91TaSn8z6hyv7blFtxD26NFyC2dHzW1U9v40MQN
	 TKnANzshDWfxw==
Date: Fri, 12 Jun 2026 16:12:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] atm: fix skb leak in sigd_send() on a closing listen
 socket
Message-ID: <20260612161219.49ac64d8@kernel.org>
In-Reply-To: <20260611163805.2151734-2-bestswngs@gmail.com>
References: <20260611163805.2151734-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 00:38:06 +0800 Weiming Shi wrote:
> In the as_indicate path, sigd_send() pins the listening socket with
> find_get_vcc() and queues the skb on its receive queue under lock_sock().
> It does not check whether the socket is being torn down. If the listener
> is closed concurrently, vcc_destroy_socket() purges the receive queue
> once under lock_sock() and removes the socket from vcc_hash; the final
> free goes __sk_destruct() -> vcc_sock_destruct(), which does not purge.
> A skb queued after that purge is therefore leaked.

same story here, nobody uses this, I'll delete it instead

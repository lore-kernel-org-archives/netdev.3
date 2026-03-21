Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152B1862
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774056689; cv=none; b=AQ9TK5girqEjHzGYCPSlOJrMCnkpGizcUBwNMgL+wAbcnarSbau3uZSvuCyRpX3lZEaXmwJFIXZK42Wed/XoL37OyJc1WZMcYZx+IWZ1ptuWZo5HoMk9aFjx15ILW8nhrfLUEMfhAJEJWGsP1u3cyLCymzpSFtI9dOWj+pUd/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774056689; c=relaxed/simple;
	bh=Ol71JvZMsV9PQXvwimEzBO7sWgFIqMYJwJfSQnCmfGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbeOzYh5NgYVqfXc5a/xJpxX072qBxQXl4XCuhor8757RezJoZwxeKg9Clb5KpN5shdQpJg/mXQ0AcaSYSJ5AMoiHuAmxzc1W+d3Bk6qfpNR1hrcL9wYxEh3MUdCuEhM7a+rey2OeFee4y+0zDldvruKgf6tppcf+6KC/8cqy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl7LyCxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl7LyCxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B763C4CEF7;
	Sat, 21 Mar 2026 01:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774056688;
	bh=Ol71JvZMsV9PQXvwimEzBO7sWgFIqMYJwJfSQnCmfGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tl7LyCxU6YyWR+YWjI7EgmDJfyX35ZsGKz9yQjcWJ4d/wSNv4FdaUvsD+L6KLhJ9C
	 M61BN8uPQInLHN0bfhsOOX6GSluy5aKCR7A6590QTCg1SojrgDc4Ih/1enmKBhaQKi
	 +2wpgp8L/dttRpCeO/0aUbp9l/HMma+aONlaiMJlwMNq6vhC56NTG3P53rE61/5kjy
	 hPXwqbmG8Sij4Y2MAKWb8QVc4xS37hO1Fu2xOsolSegC17pR9Su1vkQUKwKEqHsX+x
	 nawPOr3ZY2i8DyEJs93jxsxLRYa6w8ieL51I6tJ9H+i5I/9+uWSpITBOYK7x6tGdsM
	 V9gd9noLLSxsA==
Date: Fri, 20 Mar 2026 18:31:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Reset PPE cpu port configuration
 in airoha_ppe_hw_init()
Message-ID: <20260320183127.22b360be@kernel.org>
In-Reply-To: <20260317-airoha-fix-ppe-def-cpu-v1-1-338533d8e234@kernel.org>
References: <20260317-airoha-fix-ppe-def-cpu-v1-1-338533d8e234@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 17:40:47 +0100 Lorenzo Bianconi wrote:
> @@ -155,6 +171,11 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  						 AIROHA_MAX_MTU) |
>  				      FIELD_PREP(FP1_EGRESS_MTU_MASK,
>  						 AIROHA_MAX_MTU));
> +			if (!port)
> +				continue;
> +
> +			airoha_ppe_set_cpu_port(port, i);

AI says:

Can this lead to a NULL pointer dereference if a port is not fully
initialized?

In airoha_probe(), all GDM ports defined in the device tree are allocated
and the eth->ports[] array is populated with pointers, but port->qdma is
left as NULL.

During airoha_register_gdm_devices(), the ports are registered sequentially
with register_netdev(). Since register_netdev() drops the rtnl_lock(),
userspace could react to the RTM_NEWLINK event of the first registered port
and apply a tc flow offload rule.

This would trigger the following call chain:
  .ndo_setup_tc() -> airoha_ppe_setup_tc_block_cb() -> airoha_ppe_offload_setup() 
   -> airoha_ppe_hw_init()

If airoha_ppe_hw_init() iterates over the array, it will find the subsequent
port that has been allocated but not yet registered, meaning its port->qdma
is still NULL. The call to airoha_ppe_set_cpu_port(port, i) will then
dereference the NULL port->qdma.

Would it be better to check if (!port || !port->qdma) before calling
airoha_ppe_set_cpu_port()?
-- 
pw-bot: cr

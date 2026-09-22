Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DBDF59
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035512; cv=none; b=ueaqN9WSB6Y57ZuONzVIxskZhG5Wp4brZIQ5TsBgl6OMf76CAG3UHtiWQmRqDvy+Z05KFeJQU6qMdRnHLgwgiSS2rqg3CkCh81mhm9hKgoNc+CqWc6k9j1ncvWQbdigsLyNCkBskv/Q9pT7PJVnBB0R/t59a3/+H6ul2BVsb4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035512; c=relaxed/simple;
	bh=59JFFBCsavCxnIKakTQzEzLCtCgYefUgh1+xs2p62ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXtXLle45oJGRhvUyjz4ZquCBE5oR3aPHpBhfBXxZX+qz4zikEyp+pjNA8GKaa7Keylqcpx8VVHdE88ztXRboZJdf1pAS00cJUNl8pm0OquVf4otPyKcezTTIubUUtNY6gJGQgxriQpp6EL4waqMC9Jl/tNDlCyBXdlcwnfri6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjEf1vO3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjEf1vO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF4F1F000FF;
	Tue, 22 Sep 2026 00:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790035510;
	bh=wsRp4c6s9u+Jt5KvvbQZNkGg/AKtNrla6KySKiXlF1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fjEf1vO3n9bH9uhNfaXk4uiPrdUjC1ajMb2kR/SXKlKH8MXq7CVaNdbGc2dIQ6RTQ
	 bIAnASkkSBrA5sRCr2CFSpTaXYeYFv4KJxQhH/pm7Xl1LBqvKJX4GgTFEuGZ6HI0Px
	 XjL7LVDZn1RMHjAUECUOyagAB9wzVExIHeDyKYqtKefMvOo2kQBVQFuXvgaCxPdXOy
	 p05uKZFYm00PCCBm/A5c+iOAdc6HiAWxjHoVtCq8hcVQLP0OQ6qHfAPYKe1rSHn7YL
	 GdF1EqgnmX1nUNt6unqQDgOsmPEzhMnjCQw/pLdrSRYihFcek7fgec2JFdDZIuwyV5
	 ysvXNTibt81cw==
Date: Mon, 21 Sep 2026 17:05:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jacob.e.keller@intel.com, richardcochran@gmail.com
Subject: Re: [PATCH net v6] net: Wangxun: protect ring accesses with RCU
Message-ID: <20260921170509.3f471b54@kernel.org>
In-Reply-To: <20260915065731.6007-1-mengyuanlou@net-swift.com>
References: <20260915065731.6007-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 14:57:31 +0800 Mengyuan Lou wrote:
> -			wx->tx_ring[i]->count = new_tx_count;
> +			rcu_dereference_protected(wx->tx_ring[i],
> +						  lockdep_is_held(&wx->reset_lock))->count =
> +				new_tx_count;

Do you really think this is acceptable code formatting?

Plus I quite clearly asked you to add a helper:
https://lore.kernel.org/all/20260915184127.25de623e@kernel.org/

> @@ -1797,7 +1801,8 @@ static void wx_set_rx_buffer_len(struct wx *wx)
>  	 * the Base and Length of the Rx Descriptor Ring
>  	 */
>  	for (i = 0; i < wx->num_rx_queues; i++) {
> -		rx_ring = wx->rx_ring[i];
> +		rx_ring = rcu_dereference_protected(wx->rx_ring[i],
> +						    lockdep_rtnl_is_held());

And also to use:

/**
 * rtnl_dereference - fetch RCU pointer when updates are prevented by RTNL
 * @p: The pointer to read, prior to dereferencing
 *
 * Return: the value of the specified RCU-protected pointer, but omit
 * the READ_ONCE(), because caller holds RTNL.
 */
#define rtnl_dereference(p)					\
	rcu_dereference_protected(p, lockdep_rtnl_is_held())

Please, this is not rocket science. Pay more attention to what you're doing,
this sort of change should not require 10 revisions.
-- 
pw-bot: cr

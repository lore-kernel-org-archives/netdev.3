Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5371DF755;
	Thu, 19 Feb 2026 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771465227; cv=none; b=D88PFScVJGyNU/PZ4qvjuaSxD3cdUc9nA8SKHk9CYKPhnqzT7gZCMBI8pL+6iobW39018YyWsNVzNVFRLodtn3SjIB8AZgH8yW5wwPB3z5FcDdJ6+bHoXOus1gWvNhXJJfxjJC3/vM/piFhTMZ0H63ihx134iWy4niwNip9Z5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771465227; c=relaxed/simple;
	bh=GQBRSKpvkNr2pzuvPZojEXuXXleg6CZDVoYaT0/YNcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRi+LA3ONG9g436Y6XssxAEZ4djOu1hDvww6Nr1ZOnSrfrjAZzaGYi6e0W9aat83MR2i2DQXC4tVdNzH1n06iqlh9t1AI8XuhFSFrS0TsDvq/2Iuuaz21PYNlan4jiMZLp+S1I3e+OusOo0XtkANA17Vqyk4Vhf5D/t/Tr13zy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgQvLDRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgQvLDRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B621C116D0;
	Thu, 19 Feb 2026 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771465227;
	bh=GQBRSKpvkNr2pzuvPZojEXuXXleg6CZDVoYaT0/YNcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PgQvLDRSmROcJ7HDGADTGE+oxkjRyN0EHs6CLy2MvN4I5IZD32AAp7V6mREfO1sRA
	 q6UxrQgWwTZunuurm5kueV0HmPDIf/4/eQl44Gd0hB6vqa8hplk5z7lxU1Mqb+Yr9q
	 xAHrQXCSwWazpj2vXv+S966Z6XbsZ4Ur46zVtXeaPDLLsYIqnV2IWpZhLQEK+TT1iO
	 Qv6Ui1FP8jzUH0Jz6Y1eItQWTN7tgvwq0QGSfgyiPkNv50G5dDAo0+6JpsGan/0KLd
	 DAzMWDF+gj5T2Dfm+7c9ZPP9KJodclHCrv77yT3bJqEVF88MXjYQ/tfF/pVcRz7OpF
	 vYAdWwNQX2qBQ==
Date: Wed, 18 Feb 2026 17:40:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, Jiayuan
 Chen <jiayuan.chen@shopee.com>,
 syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
 <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki
 Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
Message-ID: <20260218174025.2fe593d3@kernel.org>
In-Reply-To: <aZURjBHTHRvjP7Ee@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
	<aZURjBHTHRvjP7Ee@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 17:10:36 -0800 Stanislav Fomichev wrote:
> > Reproducer:
> > 
> >   ip link add dummy0 type dummy
> >   ip link add team0 type team
> >   ip link set dummy0 master team0
> >   ip link set team0 up
> >   ip link add bridge0 type bridge vlan_filtering 1
> >   ip link set bridge0 up
> >   ip link set team0 master bridge0
> >   ip link add macsec0 link bridge0 type macsec
> >   ip link set macsec0 up   # triggers the bug  
> 
> Can you add it as a selftest under selftests/drivers/net/team/?

Stan, this "fix" may work for the promisc flag but won't we have 
the same problem with sync'ing the address list? Looks like team
will do:
 - team_set_rx_mode()
   - dev_uc_sync_multiple()
     - __dev_set_rx_mode(port->dev)
so AFAICT we're calling ndo_set_rx_mode without holding the instance
lock?

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B63101C2;
	Tue,  1 Sep 2026 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232600; cv=none; b=jxU8UnCpUvXOmqanBAimYoDO8lJuC65a8pgmBlEFMJd28YX1ULWWIq43TzGaOSmtvQy06LLqyepMAsSU2TPgHkLwz/Nj+Axh7w6TXzJk6rDKdtZWPg9TnD0QSpodGt7kyTt0v4l+j0jkTsQx7RjueaKytoVJ+53q3ZtF1zGfXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232600; c=relaxed/simple;
	bh=tIvRISwvVkilrBBt/Ig89czr1+h/GrDN3vOscKOToYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkEzaCvBxGVm43VJqfTd7+i2A3P9KiCy7Q6jJ10jf873VxkmvuWkmLj1zm6VbBTUdgU4xsPyg13zhRCxh4I7PngoraApzY8ne5T7DmPlrHDlLVdYLm2qAxjNrh+p6CLtP6J79FfbqE2b9ouW8arEsROt1xP8FanS7lgVVIv+6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGNrwVMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGNrwVMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7E31F000E9;
	Tue,  1 Sep 2026 03:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232599;
	bh=7krXdL8qnCCJ8l/4vTtzEqMKhBsAVL5sAaaAW6kzA/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lGNrwVMyLoDFYiLV8F40ZujS0x3EHJjHGiuSJ4sleWzdOMVMclMZJsTEg+91mNfBH
	 UFbTHmL2Gsr6M8se802hMsL9l1fefmo/nF4Ae/cGiGkwyeEaghyq8Zzn0/0Cc1T9Rq
	 0oe3AeYw3qbXFT/2FHGIJV+L8qhkCOb5vg2zJ373IBMoVBdhnEKvrYD3fiKrHHPisN
	 lWeocG9MZnzG86EnJBIU5Q3zDLYJ+cORK8A2Hp+OaYXtbyMu3DXFvtvcCX0rDLYlkz
	 2XXWoQmyN2kQZK0CSUXE2Y9oToS+39eoJXAgVaC4khLQz2APbHV7S1bBntGRB28ZJJ
	 9Otc3b0rRoW9A==
Date: Mon, 31 Aug 2026 20:16:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Petr
 Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: fix panic when NETIF_F_LOOPBACK is set
 on a VF port
Message-ID: <20260831201638.3bcaefcd@kernel.org>
In-Reply-To: <20260831042221.137137-1-jiayuan.chen@linux.dev>
References: <20260831042221.137137-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 12:22:20 +0800 Jiayuan Chen wrote:
> A netdevsim VF port cannot process incoming data.  It never runs
> nsim_queue_init(), so ns->rq is NULL, and nsim_vf_netdev_ops has no
> ->ndo_open, so its NAPI is never set up either.  
> 
> Since commit 358008f41d9b ("netdevsim: add loopback support") an outgoing
> netdevsim can also be the incoming device.  nsim_setup() is shared by PF
> and VF ports and offers NETIF_F_LOOPBACK to both, so the feature can be
> turned on for a VF; nsim_start_xmit() then takes ns as peer_ns and
> dereferences peer_ns->rq[], which panics.

None of the offloads are there either, hm.. VF already has its own
net_device_ops struct. Let's replace:

       .ndo_start_xmit         = nsim_start_xmit,

with some dedicated nsim_start_xmit_vf() which unconditionally
drops the traffic? Even if we clear the LOOPBACK it will be easy
to re-introduce the bug by adding some PF-only code in the PF xmit.
-- 
pw-bot: cr

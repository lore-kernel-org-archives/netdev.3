Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D7331EA8
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487976; cv=none; b=uDf98y0/pt2l9oCoyc5umM/5v2vkFhHMx+557pJhxG1oAl7IH2zRJHMKlwvD/xv5gXR2k5gg/V2AeORFxQvAs5jODIMJ8MQ01QVidES5EQ9aR8WwECNJGZ7OFb48xLF+8iprkytQK2mL3UPxV5lTcK6r3CE5v7metRfV1BO47aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487976; c=relaxed/simple;
	bh=uvwvZiWca+AIesZP6pGyU+NE/Jpx9vVIgLnfMAloocE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLR1IvWpWzHOI46hg126Hh+r1Aq20MNOBsnPkYDc9LoHAPoh2REL49y9MSlbX/XYDpxk2pRj2x8VS7CNkyhhjHQwqVzhvdtR/byw7Go363TcMNPa8eyCmuVid4J6mXxe5VTOWBd41LMUYspvODYtAPrC6zySRf7BET7JEQszwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DKRXKVsl; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DKRXKVsl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ltWIu37nz4B99Bnnkke4OdBYzUqX4cgsFgcIR971TUA=; b=DKRXKVslTgdy20i95gfiXBUqIO
	9P1H614A/z34xstftEzrH+xL4tMgqwvNs5FVrGh+vkd30b3y6qCvt2ZED6a/1VX8ZUQGRsC9B1Zr8
	UkEv2fc0NI3RK0TsN93UDxBNsM7Xfc/Z3KrBWfuPBD0xI5chxx0IIVyQ9o6VG9Jq736CbHYtK3FEA
	Kt/RSggo4rioBXFlPM1EALgl4ZLo5LcGePGEN7+6HR4Y75R33lXOWC3uvOE7IduZxtKGWXdB0xIQR
	l0LmmrAou39jJ+12D+rL+6Mh0Bux9rFTinLYgDOobMgh+lisIry7y20TNTWjKaPH1HdEX6R8PGOdH
	M1QO/6zw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpiz3-009tVa-20;
	Fri, 31 Jul 2026 08:52:49 +0000
Date: Fri, 31 Jul 2026 01:52:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, 
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 5/5] net: wangxun: add ndo_get_stats64 support
Message-ID: <amxh3Ef6FnHNnZQ5@gmail.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
 <20260731074958.19333-6-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731074958.19333-6-mengyuanlou@net-swift.com>
X-Debian-User: leitao

On Fri, Jul 31, 2026 at 03:49:58PM +0800, Mengyuan Lou wrote:
> Expose network statistics for Wangxun VF drivers by registering the
> ndo_get_stats64 callback.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c         | 2 ++
>  drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c   | 1 +
>  drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index ae20733c703d..a4ca01c18c6a 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -3092,6 +3092,8 @@ void wx_get_stats64(struct net_device *netdev,
>  	}
>  
>  	rcu_read_unlock();
> +	if (wx->pdev->is_virtfn)
> +		return;

Why you don't want to populate the other entries?

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441B48425C;
	Thu, 10 Sep 2026 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044581; cv=none; b=mos8u4oknI2jt0e3Zzk3DQgiO1dEcUPb5MzaB8h2LOE8lBoiO6tf65BSnrABcyCBz/QRifdLioBi0nyaUIuCW2GdCKhEHBKkDctLLtdye5lj/INoe0uR66QAhXSkepUAqjmgAZrpu99YjvRYV9r9S6qpXSMOthUR9p/QUXbl0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044581; c=relaxed/simple;
	bh=tf2IGoX3SZi08DOfXNPtbhAO3K0HpLyefQHKq64r6is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7WWSG3B9HulotIAfNcde5SORpXFwFsYRtUpaqeHbleCY3rQquC+y+AWAQaikNVScmneuUhMP1xAS+zPbbwTKvdF6Zl8KTwcF/KYamgFkIg5mwY5eQn0vA1Sm8khr/z+hKdiSZQn4oMv/NYzapJCDDsgqkaTUozbJq2DUGXPqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpEsYGxA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpEsYGxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45FE1F000FF;
	Thu, 10 Sep 2026 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789044579;
	bh=YsPKbnm14nAjsbC5ay+LAnMKluwaE6VtMw8viCHB23g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UpEsYGxAJp5bKwNUDDW+lWIR/spNjq/Ga15MhUAZHYc24ZEmfynV3Wmm+Yiylrwad
	 KKC8SRzx7ebOowsIo3egkYbXVESZjvVwua+2Nmk/3D12Eh4hrgcMfvJySRzmQqxvqn
	 8Ukg141Jqn3EtzKjjs04n1dPYpEM7Gwgc1oTiySw=
Date: Thu, 10 Sep 2026 14:49:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
Cc: 3chas3@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	accessrunner-general@lists.sourceforge.net,
	syzbot+24eb38c789655fc43663@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: atm: cxacru: fix use-after-free in
 cxacru_poll_status
Message-ID: <2026091016-gracious-purity-9ca9@gregkh>
References: <20260803101716.2592486-1-khiemtranzo532001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803101716.2592486-1-khiemtranzo532001@gmail.com>

On Mon, Aug 03, 2026 at 06:17:16PM +0800, Nguyen Quang Le Kien wrote:
> In cxacru_unbind(), cancel_delayed_work_sync() was conditionally skipped
> when poll_state was CXPOLL_STOPPED. However, a work item previously
> scheduled when poll_state was CXPOLL_POLLING may still be pending in the
> workqueue at the time poll_state transitions to CXPOLL_STOPPED. Skipping
> cancel_delayed_work_sync() in this case allows the work to fire after
> cxacru_data is freed, causing a use-after-free when cxacru_poll_status()
> attempts to acquire instance->poll_state_serialize.
> 
> Fix this by always calling cancel_delayed_work_sync() regardless of
> poll_state, ensuring no pending or in-flight work can access the freed
> instance.
> 
> Reported-by: syzbot+24eb38c789655fc43663@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=24eb38c789655fc43663
> Signed-off-by: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
> ---
>  drivers/usb/atm/cxacru.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Did you forget the assisted-by: tag?

And how did you test this?

thanks.

greg k-h

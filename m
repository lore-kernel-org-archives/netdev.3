Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC933F8C1
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962239; cv=none; b=r4iFeywjSEdit+xBo0/lGQ59XYP5jMr8QKeaudZS74sCOq+J7eUbAt200q0JNHpqqyYIe2+OVkTvsg8Xz02MX1jJ86HuIA7I5Er5VNbFELCmjciJdadn3iMqEmpCobev+TvbxlMP+Pww5MhpfcIOJguv7uZfULL/kfZatexsFlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962239; c=relaxed/simple;
	bh=Yl18ulpr6gLt4/hsDp++OZeojzFkBO4fOypFsHDVd3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyrB+iUVH41eqOfYQV909vLNxrGf4w7UU1FpMGxw7jLzw/Xvn+qvbVoWg0HUZ9YQd28pPtL77FtSE/jMXB8pxD1zlgilIQmnK17zp71VTTIcXY+9JqzTaIUK0ymnrUDX3TQz1Y78sTgTIMRUL34I2W9+GG3TkB5TMuEgFwsvBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sSuyLFFu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sSuyLFFu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OQwu9ux6pSKExzagKmtjFfwlMK7uhCpxAnHWFSdGKXg=; b=sSuyLFFukKULQMI3CxUANI8SHM
	qfOThEwRMN3JYO49ILy27vmaNMPyG4bl2mPTsx7KBn6+Wac2BuI9xzRKoFFymEgDb6ZP83sxvsvtF
	zopsJOEns5bXq1+lulNA8dOLYgym1ZsLcod8EKmf3jWAlGFZ3OUG3rLqi2DnRBHmTPwE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7Yl8-00ECMj-Jw; Tue, 31 Mar 2026 15:03:54 +0200
Date: Tue, 31 Mar 2026 15:03:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Jakub Kicinski' <kuba@kernel.org>, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	richardcochran@gmail.com, linux@armlinux.org.uk, horms@kernel.org,
	michal.swiatkowski@linux.intel.com, jacob.e.keller@intel.com,
	kees@kernel.org, joe@dama.to, larysa.zaremba@intel.com,
	abdun.nihaal@gmail.com, leitao@debian.org
Subject: Re: [PATCH net-next v6 04/11] net: ngbe: implement libwx reset ops
Message-ID: <3d9cc075-77e5-483d-a268-000c83020bb3@lunn.ch>
References: <20260326021406.30444-5-jiawenwu@trustnetic.com>
 <20260331005527.3459556-1-kuba@kernel.org>
 <073601dcc0de$a87b2e30$f9718a90$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <073601dcc0de$a87b2e30$f9718a90$@trustnetic.com>

> > static inline int wx_set_state_reset(struct wx *wx)
> > {
> >         u8 timeout = 50;
> > 
> >         while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
> >                 timeout--;
> >                 if (!timeout)
> >                         return -EBUSY;
> > 
> >                 usleep_range(1000, 2000);
> >         }
> > 
> >         return 0;
> > }

At minimum, this should use one of the helpers from iopoll.h.

	Andrew

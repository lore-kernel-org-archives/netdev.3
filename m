Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B158A348C47;
	Thu,  3 Sep 2026 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477623; cv=none; b=RbYvoOcdrUWXkWF4iNGb6++JKaFo6A+PwsEU80yiZSl229ECbYQXJTWEaDpP30xoRKxpHAqluzgLXL2ppYar9tWzJrnCeM2c2qAZgwign7zZHGNoPHfG798oC47ekhCualEm43bACGAaj0MTNKtHlu9vaNq9uJyXx7NdxBI6d/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477623; c=relaxed/simple;
	bh=S59SNuSACLdjyM+AU9w7c4CUYfxVPHHN0q6M5yk4FM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNWo//DUMocMT9sBmAavQC/PsyxCm/A2doB7shSYwrKSBLoYBgPimc67IK6hrN0F22yb24OiW0s9Bc3nm2r8YrIPMOTOcq3pqqlNV+c50JkNOArcWthWp+RGHwjXC8LBkTiYRZwqRd0uBTeSVD9aU4ykUsgUABkXNOOSH8mpZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbmS68SM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbmS68SM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A81F000E9;
	Thu,  3 Sep 2026 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788477622;
	bh=Jd2d3+3jAhjlIWPxn5NVZwiUzcNZ9cJ6/qoOYbHQKEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CbmS68SMAunuOIZQWmpFtxCQk7utUuViAFHuUe6GjOYQeTjKYbh3yM5O5b9kOTSPQ
	 ifmG3Nrl9vmCoLVnHdRrQFpgCED41Toeqs5/M0737rmTdoDKiACzGWzRs23ETvTmjD
	 W8Ydj9CccjusxqmdJaUoQvrawqm1i8R2sHUPbmg0vp9LGdEMZ42r00UjL3b8H5EyBD
	 wEdMRK7OgDO+NfMseCQCA26acf9n2B/gDTD/VypyqG+PWIGePX8+VJkVPVLH7/DD7x
	 MseYkufsPHfkSdnaQSKRvNHGn5E2qiNnFyVPpYi0hffmbQ61y7FIiw7idmYd4fQclf
	 p93cNSDI3k3jA==
Date: Thu, 3 Sep 2026 16:20:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Mike Rapoport <rppt@kernel.org>,
 3chas3@gmail.com, duncan.sands@free.fr, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, david@kernel.org, willy@infradead.org,
 vbabka@kernel.org, accessrunner-general@lists.sourceforge.net,
 linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] USB: replace page allocator calls with kmalloc()
Message-ID: <20260903162020.323f6cdd@kernel.org>
In-Reply-To: <aplR8tmzndmg4kfq@hovoldconsulting.com>
References: <20260830-usb-v1-0-aa349c302246@kernel.org>
	<178840081114.3041656.13596134068099743678.git-patchwork-notify@kernel.org>
	<apkRyoCr2dNI0bNS@hovoldconsulting.com>
	<aplR8tmzndmg4kfq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 12:54:42 +0200 Johan Hovold wrote:
> On Thu, Sep 03, 2026 at 08:20:58AM +0200, Johan Hovold wrote:
> > > Here is the summary with links:
> > >   - [1/4] USB: usbfs: replace __get_free_page() with kmalloc()
> > >     (no matching commit)
> > >   - [2/4] USB: cxacru: replace __get_free_page() with kmalloc()
> > >     https://git.kernel.org/netdev/net-next/c/a3b4826138d4
> > >   - [3/4] USB: speedtch: replace __get_free_page() with kmalloc()
> > >     https://git.kernel.org/netdev/net-next/c/534b18813974
> > >   - [4/4] USB: serial: wwan: replace __get_free_page() with kmalloc()
> > >     (no matching commit)  
> > 
> > Why were these USB patches applies to net-next?  
> 
> I see now that it was only the ATM ones.
> 
> Sorry about the noise.

Sorry, should have sent a note.

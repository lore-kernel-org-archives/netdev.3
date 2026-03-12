Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B4324B16;
	Thu, 12 Mar 2026 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295561; cv=none; b=fMHsbT0ygfy8B0vkkPLtdcM2xmV1nu8MuUSFwh7QJXgxCtg+ONWYS0lGl3Yxs8ENiVn1OYG0L792t/hhrePE5cEuee/BkPVNNCU5Ok40lAVP/YjVULoG5jMEfaM44Ng3BTksr2u+B3iVYAUq4tHHuK/zv9RStWOiqGu0kEhutVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295561; c=relaxed/simple;
	bh=/P7ZeZyhk1pp5G1acgHcRKYh4lgx8MJ2CCC/QPg9l+Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmlNTxQbAXeqRhoSDjLnbxRVa7c+DvhRFuJva70OYBmt3savZBW/n4S2SwVTBhQaf/rGgtQlZt/r6MFdNtv8TQd6whdd8Hb8VYbmq+FeRVI7nrU5PzWJWt8HIMqRwk5X47+AliEKpDbWpFiveQQKxmKTG6BpPacJOtlLxFle4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=Yzoj+YGA; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="Yzoj+YGA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773295550; x=1773554750;
	bh=/P7ZeZyhk1pp5G1acgHcRKYh4lgx8MJ2CCC/QPg9l+Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Yzoj+YGAjldpjhYAPWn8uPt3v5HuMBLmMfNHMlYY0eY0+YLAgZ1ZcSnFzMNQONJ4U
	 3Bd1kwrgp8aJ8tTWILqglsaI2zYriERjUWDitqy+114ERXOfSjsXDkoXZ6HdxIU+YU
	 SMim8/HLH/bVGnlyXUAD6QHuMfcfR+hZ3c/n5kD7SBCpE6rOt+G8EGWHLfbutOhUkb
	 aRcqp5zRpHUTzdZyxCEZMH5tY/oXSF/ShCPZBtiMI04gthV8gsfs6BHSPKiCAyfdoY
	 P78lIHbZFCOzFw+pMluxhTkxOEKedqO/WJLGNKWnWtXr9BoSQYP3xTlVGZjKep50YC
	 +TiJkDlC5RFnw==
Date: Thu, 12 Mar 2026 06:05:45 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
Message-ID: <HsPWaZkAZhVlbA7H6W6OtjDWVtryYVaPhSvE1jztmcWN02uRKeG3Gnvh5x0WjwdmDvowQge_ZUmD8Dmm3g5tGVyT5PjgmFcgGIRy2_B4bwQ=@1g4.org>
In-Reply-To: <20260311171802.2d8a4d45@kernel.org>
References: <20260309173450.538026-1-p@1g4.org> <20260310192842.3c3b2070@kernel.org> <cjiUUrQ73CJYWcTmlHQVSJPUJlxVg4kSZAnqkHKnU1SKeWoyy4F2qtIw7wuFRP9qz6Ra9ax0v2EQKsgdiRRUQnnuMweGbv-n08lgvXSTTG4=@1g4.org> <20260311171802.2d8a4d45@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 9486c23f579547f2779b1dbb6d3a8fe4c92ec401
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On Wed, 11 Mar 2026 14:04:54 +0000 Paul Moses wrote:
> > The reported UAF was in the GET doit reader path.
> >
> > GET doit enters rcu_read_lock(), then net_shaper_lookup() performs
> > READ_ONCE(netdev->net_shaper_hierarchy) and walks the xarray locklessly=
.
> >
> > GET dump reads the hierarchy pointer first, then enters rcu_read_lock()
> > and uses xa_find() to walk the xarray.
> >
> > Both paths rely on RCU to keep the hierarchy and its shapers valid duri=
ng
> > the lockless walk.
>=20
> RCU was never intended to protect the whole hierarchy in shapers.
> Only individual shapers inside the xarray.
> The struct net_shaper_hierarchy is allocated lazily but it is never
> freed during lifetime of the device, only once the device is dead.
>=20
> The bug is that we are accessing a dead device.
>=20
> (reminder: please quote what you're replying to correctly during ML
> discussions)
>=20

I'm sorry, I'm not seeing it that way. We are racing teardown, that's true,=
=20
but there is no reliance on the device being gone to hit this bug. It can=
=20
happen before or after, makes no difference.

SET/GROUP/DELETE paths might all be susceptible to your bug but GET is not,
it never follows the =E2=80=9Cref then lock=E2=80=9D pattern.

So the choices I'm left with are fundamentally changing in the GET paths lo=
cking=20
contract or papering over the locking issue to where it's no longer reachab=
le.

Thanks,
Paul

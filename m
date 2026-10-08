Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A130CD85;
	Thu,  8 Oct 2026 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791427756; cv=none; b=Lu4BVX8t9N62wem66rSjTf09ZQ2UgIAzXTFlLF1PU0Pg8AYPpbeyKqwLqr/qAYqkHVr5l+NFGrBb5Mwf83Ve3dnuIhbfSZmYpsLa2CFXOPd7KQgdzOw5B/ud3mn1pksXhOTv+pkGOHjJvX5CVVUAfs0abmIUYb7NvPh0EC89V5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791427756; c=relaxed/simple;
	bh=xbzZ/NFC1OvkLHeN7fUyGLmoCylpThxe6u9HvcmkbHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BP8I7MKNwX7XDyuvhqtzaFOQDBwzZQ2P41azGhGvmjaRBlWiEnpQCx5Lb2Jk1ov8cueOJCnBiJU4NG5nYSUpLab3e/v36m47wxzdoxLygy8H5F3Zdd2ViSO7jE9z2tFFYJV9MigmwFeLNbI5AkzbasAuY8TrOIA7rf98N7NUxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN2ND420; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN2ND420"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390EF1F000FF;
	Thu,  8 Oct 2026 02:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791427755;
	bh=Uhp1y0+YbMVfF4ieX00zrWaPdfF+gZRxEutiIRRmM3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dN2ND420YziVX+jYzRihYrRJ0u3Aj/5Uu/SRLP0AgSCL05K9Uz8crEhH5X/q42UAq
	 jvK1ZaWVW2I1W4kNqakSTxJSjbPGrH7xJA3kycodCE/r2Avy3BC7v87hUQtosjkcPs
	 SS2Wo0TejG9pXJiZ6zj0zhsSWRWKPJquSNkhAGEngoF5Tg87bnwCnxKDG1XQB1PCb4
	 1p9ORMOaPA4eYjke0gWFPA7/xawbDHMuerkuEIRXn8NRr7i/P9mrOL+17G82d2okb6
	 MQFW25Ei/Jcwu5yfI9JxHADY4NO5lzEEiMvLQKRJUCsr0zRiEiEp+Cc8LXIIiZbWzp
	 mQhu8QCIN7IAQ==
Date: Wed, 7 Oct 2026 19:49:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
Message-ID: <20261007194914.2958b69d@kernel.org>
In-Reply-To: <20261004223852.312487-1-omermetekaya0@gmail.com>
References: <20261004223852.312487-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  5 Oct 2026 01:37:24 +0300 =C3=96mer Mete Kaya wrote:
> Subject: [PATCH net] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_retur=
n()

the patch reportedly doesn't apply to net
--=20
pw-bot: cr

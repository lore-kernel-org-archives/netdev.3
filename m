Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107647CA92;
	Fri, 31 Jul 2026 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542158; cv=none; b=EeSDxaD95UZ6dfv+fYjmkrJeXd9boMDfit1PbyjqJEaPIlZEWQFIJK47feuav0wraDqh+Hm9hKCT6y228qR2qMoGNvdHJPu384UHh+MfiwT2D/0qkGUk9Wf0HjwLnFLWjEk9+CvuDaJkhU1InSdkQp8J7x0GpNRqDLRJFi45V7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542158; c=relaxed/simple;
	bh=fV3jlxIMrd3BMmhY6aGuaa3ta+K9DrPiCu+krjP2m9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXlCKUaGJjaJEUnZQTpzOfDYh7G4jaSKziBEXhp8ox2uVIiASR9StvcZtecfYWqlloqLW1qijLp99jnp7kDRrrvbOzpHIbbCj6kzEPFnwG0usRcV0zdMa/J8qcruZaCn5R5cAMwkCCnUWaq6y0FDLaNSqjk4W0q5FtwEgLazPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQFHOKrb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQFHOKrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32EC1F00ACF;
	Fri, 31 Jul 2026 23:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785542156;
	bh=fV3jlxIMrd3BMmhY6aGuaa3ta+K9DrPiCu+krjP2m9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bQFHOKrb3vY/usgTShZ6vijkb8ncEEsNDqvd7YcM1iRuYC/qtwQ6HRdCUc0NsdxPX
	 VjJW1ASLaJvxDCoJekePi+Xaoli8b2QCVO6QOovKZobt8reaca1+geS0q3JEECD7SK
	 vfiNWTuGUoYe0a1q8KCEXUiAOZxMIwshP6veysDftKLvPK+kS7DuG4E/nQeIEwZU9j
	 /qZgOumDGy6zxpgUVin62JHQ8KRRwDqW5vEE2xLQ5C12XSUe9X9/fOoqawRaYRVLfL
	 N0dtBeFBovD4WUvzZp0P2T5k+xBe8Ut4JZi+PGeJsU2i36jebT7IEA+OPqukXhohIg
	 xjy3OVcp/bEsA==
Date: Fri, 31 Jul 2026 16:55:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo =?UTF-8?B?VmFsbGVzcMOtbg==?= Aranguren <pablopva014@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open
 list:TULIP NETWORK DRIVERS" <netdev@vger.kernel.org>, "open list:TULIP
 NETWORK DRIVERS" <linux-parisc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] net: tulip: xircom_cb: drop runt frames before skb copy
Message-ID: <20260731165555.50741429@kernel.org>
In-Reply-To: <am0L4gNtPJaMPx_9@ThinkPad-P15>
References: <amzqfjeo0Yo1p0Rd@ThinkPad-P15>
	<20260731202629.10ff97e6@pumpkin>
	<am0L4gNtPJaMPx_9@ThinkPad-P15>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Jul 2026 22:56:02 +0200 Pablo Vallesp=C3=ADn Aranguren wrote:
> > Have you checked that that hardware can actually set a short value?
> > I'd expect that packets shorter than 64 bytes (including the crc) are
> > dropped as 'runts' and probably don't even use a ring entry. =20
>=20
> I haven't verified how the real Xircom firmware handles runt frames (I
> don't own this hardware). I tested with Qemu's emulated NIC, the device
> itself does validate and reject negative-size values before sending them
> to the driver.

Are you related to Greg KH in any way? You use the same slop tag.
Just curious.

Please send a patch to delete this driver if you want to help.
It's ancient.

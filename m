Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57200401484;
	Thu, 27 Aug 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856968; cv=none; b=cTeorBlCuefqPRrhQ1EoJt3reMXLk0VDvUHAE/SbbABcxyQ4K6w32IsAZgclVmpbeUo8305PNq680lk/87jH6V+HdF1evRVScXkNMJnDQ5PB9/6+SxAFTxOWhhBt2NKo9RYgHXv/8mxJbCPtB8V1BHwdlnobg8waEXjblQsJP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856968; c=relaxed/simple;
	bh=k4MsGBMM8Jl1yNbikuPHQwYFKWs3OmOxKlcWkEqZRK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6Fd/38mH//yliLAgSq4cFKuVQkUWQjxD9QJ1DWVp8XvHF3rbx/Plf5hyDPHBiv2VbKcVCVgjKiKl8OyxIt3qPk//DB7Jg/quHh2Lvd1s6hV5VO0qrSB07+fZhq4be8muoHPPelJfbLnzHB3oC7zoGgLaeqswhXvoZbPMrhCPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQXJon5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQXJon5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBEC1F000E9;
	Thu, 27 Aug 2026 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787856962;
	bh=0JNdvt6GVleitDiXCCtI1FsmuCnmCAQ6fpELLfP5Grk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MQXJon5/+xIi4xIi6emnkeYylem4mP4mCl4w+yCA24nj1rKqZXBrhOmV5N7LwI1Is
	 CK6enbB0x56zb8eUm5DE+frSSNtzf1Glt6t8FHKgfeRn4QyT5HfIW1Xqm5aoA2SZDV
	 grzNJgPF9XJ0SV2F7bq2qCquK6gfSCcJJdnOtyw6Y4lrpBWhS+6mmvlHrdKIxegHOW
	 zbHC44xUiYOJrfDPTlQleQkEamJAt4SxhCbYS65ZmSWQfKDv4yaXcM+2FavP+88EHx
	 v4ylvr5wP+gOnzzv4Iq65Lhyah++YU7NdgFTRO6I5xozSSaPLzm0lj9Rh+rvO4LNXI
	 FQrMRrJ2Hgbew==
Date: Thu, 27 Aug 2026 11:56:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, Conor Dooley
 <conor.dooley@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jonathan Bell <jonathan@raspberrypi.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: exclude software FCS from TX byte
 statistics
Message-ID: <20260827115601.6bf0b18a@kernel.org>
In-Reply-To: <20260824134703.766708-2-nb@tipi-net.de>
References: <20260824134703.766708-1-nb@tipi-net.de>
	<20260824134703.766708-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 15:47:02 +0200 Nicolai Buchwitz wrote:
> + * @skb_len: skb->len as handed over by the stack, before padding and
> + *           software FCS, only set for the last buffer of the frame

counting pad bytes to ETH_ZLEN as sent is perfectly legit,
it's a driver preference. Some don't because HW pads and
the driver doesn't want to bother adding a conditional.
But it's best if the driver bytes match wire bytes IMO.

Either way, you only need u8 or even a flag for this,
not a full u32?

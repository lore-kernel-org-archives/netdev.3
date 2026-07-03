Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00FC3D953A
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093305; cv=none; b=dxdXLC9dtllMYkxatOHqI6DFhWyr0OXk3oVk/oUsfQnZItJoHh/e32DrYu/dmZSsSMH7nN9FdK1mElvSZIsZIG32D7NvxbdgwJiE7QcXKcVcbT/KLX8R8CQkl+oFU0VhED5J7Obfn8mGxEvP7hyjPetOaB1UdUIyV2OZSnJDrdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093305; c=relaxed/simple;
	bh=G/pLU+F0okZ1V9jun6B/5v6rFA44fIV/eEHLoUG+A60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/vkPzvYblN7/zYet34HviXB4LQ1m09wgZTopkcgeWelLcPTvXbw4ZdzgTTz9Ya4vp37168jv/6u8+ESp7KaQEmlgpwNGnBhet0JXaAfw92Mm+PvM2EAch9wNXcnHklWWmtvP2k6Xm7LmVOUePgPsCOVEu+K9EO7CUizeLvDwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GTL4wBtl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GTL4wBtl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DD1C9C49F57;
	Fri,  3 Jul 2026 15:41:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E04FE60300;
	Fri,  3 Jul 2026 15:41:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0E33104C952E;
	Fri,  3 Jul 2026 17:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783093298; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KNX7WtqTWdCNcfOQcXMaIvwm9WL+CY/H8cg+w97kkpw=;
	b=GTL4wBtl4EaONMByKcBgcNhc+C+mcBRgfRskDFJoAPJw8tsRFoWqLek8XecWPlNJ+j1bwO
	mPgG4vhV7oPLrFjDhN5RHMZiaq0PQ0bmcgQvghSZl5G4kx1lEcoBWW9yy0FBcTFPN45Hg/
	Ls5pBnPZdC5uUZbfIudMwW+eDjalBQidtzx+MSr/zlFs0mFMYmepxFQtdpHQ/NEUmfmp8O
	oHk9VKekxO3GM+p5crdyJdgm61aau+/tGM4UbjZq2ygxec73aTZC9QU/3joD5HHRrG1Rl6
	xONupZOKhd4F+hi898edHmFZYE2YMN1NEj9pBt3aj3/o/lO3+eP23pfUikkfSg==
Message-ID: <1cf5bf57-701b-46d0-9186-20bd25b20998@bootlin.com>
Date: Fri, 3 Jul 2026 17:41:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: embedded PTP timestamp
 support
To: Luke Howard <lukeh@padl.com>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.deA>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com>
 <20260703-mv88e6xxx-ptp-fixes-v1-2-0138581889a9@padl.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260703-mv88e6xxx-ptp-fixes-v1-2-0138581889a9@padl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Luke,

On 7/3/26 08:41, Luke Howard wrote:
> mv88e6xxx switches can support embedding PTP timestamps directly
> in the frame, either as a trailer or at a configurable offset
> (typically the reserved bytes in the PTP header).
> 
> Add support for this on the 88E6341 and 88E6352 switches, being
> those on which I was able to verify this. Other switch chips may
> also work. The arrival timestamp offsets are relative to the PTP
> common header and will work for both L2 and L3 PTP packets; the
> respective headers are skipped by the number of bytes set in the
> ETJump and IPJump registers, which are initialized to sensible
> defaults and are VLAN tag-aware.
> 
> (Note: the 6352 datasheet incorrectly states that ETJump and
> IPJump are initialized to zero. They are initialized to 12 and
> 2 respectively; this is corrected in the 6341 data sheet.)
> 
> Signed-off-by: Luke Howard <lukeh@padl.com>

[...]

> +static bool parse_embedded_ts(unsigned int arr_ts_mode,
> +			      struct sk_buff *skb, u64 *ns)
> +{
> +	struct ptp_header *hdr;
> +
> +	*ns = 0;
> +
> +	/* APPEND means the switch appended the time stamp as a 4-byte trailer
> +	 * (not all switches support this). Any other non-zero value is the byte
> +	 * offset past the start of the PTP common header at which the switch
> +	 * overwrote the time stamp in place (e.g. the reserved header bytes).
> +	 */
> +	if (arr_ts_mode == MV88E6XXX_PTP_ARR_TS_MODE_APPEND && skb->len >= 4) {
> +		*ns = (u64)get_unaligned_be32(&skb->data[skb->len - 4]);

One thing is that you need to make sure you're dealing with a linear skb
when accessing the trailer, which can be done by calling skb_linearize(skb).

Then you should use skb_tail_pointer(skb) to get to the trailer.

You can take as examples the DSA taggers that pull the tag from the tail, such as
the tag_trailer [1], tag_ksz, tag_rtl8_4, etc. 

And finally you may have to use the chksum variants of the skb_trim such as
pskb_trim_rcsum(), like done in the above-mentionned taggers.

[1] : https://elixir.bootlin.com/linux/v7.1.2/source/net/dsa/tag_trailer.c#L28

Thanks,

Maxime

Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29237CD37
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531368; cv=none; b=rLN6R6/5HWz3Uggtta6zhfq/D8O7N2FzwixEiXQSzB+9S8LDrhwfRaZ5rj9oD78GzH+cFCdmmwUFSAbvU5nAhK8AJdAbHnK/fZCt+lKB8MbRpV9Vy4Wig80+APWPEpfKbxbK0XsHgVhe2vOR17nXMjWNu6iaUnObWaCiGlnzPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531368; c=relaxed/simple;
	bh=Fn5KP2Wfb+B894ZtaSSVi7ynGoQ1ek/mqOey7GWwQXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHxhJYtwWz3YTctZSC2U8GDFOt6CN+kSCskYeQXnVIPzAxy4RyQ6yJbcIDym7Si3NU7WziSGJRFDqwQX29WerxIIrUGMVSYlcMJelUl33lM2ACDxir49DXQnr4KrEqqIeGk8sk4h52AgrV5PgM+MWTKfBAtvzuQEQM/eb1MYKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWgRpq4U; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWgRpq4U"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f7027ca11so989661f8f.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785531364; x=1786136164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y7hbc7FAwrk5wKEc/VtbcMzvoD1OmynhYQ/r1fT/1r0=;
        b=aWgRpq4Uuu9n8OKzKdQ4g3wnVYzR0o+4GZzUmqyNpMEx/jCuHa1bS5ja+IM7DcX+P+
         trKXVtElUwZ5S6qnGw4FZtEt0WUwFs9b+wOQMktXmgNK/6HMM3Hx/u0s5wZarAw62wcz
         A6CClervOTzq3uqdItfDjLAha7PDRd8bX6fEy39h0gU4KiLjcJgElVYOByihdwduwPyz
         ZiJsMXjMlQEV5I+FcMWwY/RkFeJYZT/7nGNFv8W/apWrAE+J+OtVEPO0cYmZnqr1Fs8a
         Yer5GWOcmGLOsmvfz1HNQrs4XHAZJOBF3RqQcVbuVSvBpi1O1KBg9tk4aG0KyFUL0wBq
         4dPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785531364; x=1786136164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y7hbc7FAwrk5wKEc/VtbcMzvoD1OmynhYQ/r1fT/1r0=;
        b=dsyYUs6DSbNEUT9MQVp6wVslnMCl2brgZoE52lU8qhNAf6dqFKlPPJKEPDqlz+ZpMa
         ipw5iONpnD2gTmnVIh/7CuJo5O9dyv+1O0IdacGU1nOwlCUwLq7Xi4D2JhTzK2/iA6x4
         wC+ZilDezws79Z5/Zl3Z/NEXRSW5oD6O78ojUXZ3o9IMGHhi/gWjTP/7XpVXO9VswUWS
         TW7/86/dD+msgIpNtXFoM6VT/VeZasmAe5X3AwE//eOAvnO5OECKN89vN/PmayS82DMD
         iMPwN2Edm+bv7JjV4wRM4BVRDktWgtg53OQGgh/kx6A0HD8UNQNKMkOlOJYC0BRg43Ii
         C2Kg==
X-Forwarded-Encrypted: i=1; AHgh+RpnezMFsior925+9/L0bCpU1ZWOFBMbrQyDCi9v1Cb513p6jxZLSun/E4PRcN89BHnO2Q56iFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQZX50V85Q5HqWPhXjHrJfGrQGCfPMEL2g9IyMxZmcCkijJfO
	Bkiqz3mFzLfvjnWd8zhh636Sc0snBIeYgFzMTwqN/PgFyC363pxHsz9K
X-Gm-Gg: AR+sD10ugLzl6FWrDovpdAnmrc0tbFhXV0pzEyvwCPvgDhb6xTZf4UgbI/pCNY8CJ0a
	s8GUKpJInEGTqRRD7+QvQYOY8V8N0iyNqcYVx1Ooof1pstUNSYrt4owrfj+0fFqMluZggUnyWSE
	45TDN8qXy6aISNQQfVhCp3Fr8i8NlNEC/MRyRqlYW10gtnR00kH6uIm3VFBl8x+oh72VdYmsduP
	HWzS3xW/QvAEfJdf7BxzQn+FsZYPDrYKl+BXIh8pyK6oOaIa37A9jfy6h3EPVAmjfNS/g0TEFUg
	tyCcq3BMf01cOUO0rWfTkq5Cj8ISo1wjS+wDJ3izvGg1Pyv10avnw1Gg0akieQTXjQWsfQQyKs9
	JWFa1Ma79IgJgbTqnIWc7TTpxfa9+CwPGvJYxd5ZhhIG+2AcaU/nkGYRehGcmFLdqmwizakFJ6F
	QdJ0uSslJfVPzMPuaGdEceYNbIFoF9X+uM8tgl5vT+Yj3fbCEoc7iyiHPyGMfCe1xBcuVqXulWL
	AeEGgqTvtGq0+K7SSkkJEgm7EoJWKxXDBnXac67E6U9O4TreOlG/0gFeK1TR5FBezOV
X-Received: by 2002:a05:6000:4615:b0:47f:8887:3b07 with SMTP id ffacd0b85a97d-47fd72d320amr2212664f8f.13.1785531363748;
        Fri, 31 Jul 2026 13:56:03 -0700 (PDT)
Received: from ThinkPad-P15 (67.85-86-63.dynamic.clientes.euskaltel.es. [85.86.63.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1956sm10157797f8f.6.2026.07.31.13.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 13:56:03 -0700 (PDT)
Date: Fri, 31 Jul 2026 22:56:02 +0200
From: Pablo =?iso-8859-1?Q?Vallesp=EDn?= Aranguren <pablopva014@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:TULIP NETWORK DRIVERS" <netdev@vger.kernel.org>,
	"open list:TULIP NETWORK DRIVERS" <linux-parisc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] net: tulip: xircom_cb: drop runt frames before skb copy
Message-ID: <am0L4gNtPJaMPx_9@ThinkPad-P15>
References: <amzqfjeo0Yo1p0Rd@ThinkPad-P15>
 <20260731202629.10ff97e6@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731202629.10ff97e6@pumpkin>

On Fri, Jul 31, 2026 at 08:26:29PM +0100, David Laight wrote:
> On Fri, 31 Jul 2026 20:33:34 +0200
> Pablo Vallespín Aranguren <pablopva014@gmail.com> wrote:
> 
> Have you checked that that hardware can actually set a short value?
> I'd expect that packets shorter than 64 bytes (including the crc) are
> dropped as 'runts' and probably don't even use a ring entry.

I haven't verified how the real Xircom firmware handles runt frames (I
don't own this hardware). I tested with Qemu's emulated NIC, the device
itself does validate and reject negative-size values before sending them
to the driver.

> Of course, if you think the device might lie all bets are off.
> (Without an iommu is can write anywhere in host memory...)

I took into account that the hardware could glitch or a misbehaving/fake
card could be used. I modified the emulated NIC to mimic this behaviour,
and given that the driver does not perform a check on its own (to
validate that pkt_len is not negative) it does lead to a kernel panic.

Best,

Pablo

> > Signed-off-by: Pablo Vallespín Aranguren <pablopva014@gmail.com>
> > Assisted-by: gkh_clanker_t1000
> > ---
> >  drivers/net/ethernet/dec/tulip/xircom_cb.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/dec/tulip/xircom_cb.c b/drivers/net/ethernet/dec/tulip/xircom_cb.c
> > index e5d2ede13845..62c64da1c8fa 100644
> > --- a/drivers/net/ethernet/dec/tulip/xircom_cb.c
> > +++ b/drivers/net/ethernet/dec/tulip/xircom_cb.c
> > @@ -1110,6 +1110,11 @@ investigate_read_descriptor(struct net_device *dev, struct xircom_private *card,
> >  					/* minus 4, we don't want the CRC */
> >  		struct sk_buff *skb;
> >  
> > +		if (pkt_len < 0) {
> > +			dev->stats.rx_length_errors++;
> > +			goto out;
> > +		}
> > +
> >  		if (pkt_len > 1518) {
> >  			netdev_err(dev, "Packet length %i is bogus\n", pkt_len);
> >  			pkt_len = 1518;
> 

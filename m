Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0A45DF77
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525995; cv=none; b=RE3ne6SU3a1hAILFRDDyxD+uTULeWyhMrSbvfO+WML+ouGTVRnOdyC+o/DrwwTE3zGEM9eX99lTZBTGljovIxcm5Fh+pMienllTYiA1LcDMkm6iYtMWKq0W3Ft81ApyPwgD3jcZBA2+kT5jJF8WxInofOimNyb0eh+Ri+cgJDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525995; c=relaxed/simple;
	bh=KkF5Nke1QJHyg8FJ5OsLAEE7JZPzkufAokSHnEISuKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbjpSRzo19zWiTs8+aOLEIs76LfdyLroBrQh/bMKMZ0LWPO7nVHHvGx81rQJ8F8QN7WzjDe2jDCFV8bnIbG8oggUmO9CfXDjT+ielREdZwGGlGH4m8yto4YW3ipiR6IdIAl3aqNFWmObilhb3scD5y4FVGDLbqOGyyVWZvw1ipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4Uz/U/p; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4Uz/U/p"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1489443f8f.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785525992; x=1786130792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qto0P01IO3CrmBO6x4tfgO5l9DTkXSKTrk6PtYpQaHs=;
        b=e4Uz/U/pWX6IZHurxJRR0uNlWsjpNhjjwuf9tLgg2x6OxxS3QMmX1iUTNfQJlc1zl4
         uOb1WkJ+DkHK7z1PQBLl50B0TTmZ2BJ2xPX9UpbQfsCtJ3A1xfBh91aZ0o8STrGPixUo
         JXQnXfcIUgQr//zSkidl+kSNA927hyddaRi0BNOwEfvHm03zjCpe4H5Wrtnk4TbMvb70
         79yFNHceEDbjOgqV7ocJIXF2ELjRBFO2AQmG8XN0bChrJNQXY5AaBp+ieAqVIUZ+w2Ym
         67z3sCNXRbZE4FC/ZP6sU7xyEaU//mmVly6bcJgGF8eUhZwfsfC5vABgobsowoyU1j0S
         ZQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525992; x=1786130792;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qto0P01IO3CrmBO6x4tfgO5l9DTkXSKTrk6PtYpQaHs=;
        b=WH/sNN9cBVBQeOJIm9CNI0y3uVcMxIpBn5Lb9bdkdQbUyswTO3wcVCCI6ttwwZL0bs
         EZMdgQGLC2eAITCMZ3GiLVmWSAG8wQvv6PMMAoK29U6WG1eKfgCaz/HB7eXKs/xIjJ7F
         yRQe8/SDXdyivUGPWlq3AtjcQudJnYBmiMwtDhezZwqVYDtb67Cfjubp5gz2tt5Ag+/0
         Pmbg0qWesse/JoaAGnXp8SSibjP2ataDzHf8YuRzt2n5jjz/mI2lXjY5LCpQe7Vf8iUv
         7OO0uwFKItFgnVsOogSLcD9jSYcG/KNuWSWjMR7oEaYjgAfB7KdhCrvgZhrRVfACQoZn
         hyjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxbRA2HhoohWe0deu+zKLwb3k0Q5fA0O2Aw1OjTvNlgPXxUzqPtlzbh9oRu4SfCw7Bu7RfLuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4AB5Eo10ShaNE9PN9b68ZSbOn2T+XXibTCrzku9UPNLM6zA/
	bNd6xp/CFd9y8Z2XeCvoigotOSTLY4L1rjI9XqvvkX6SqCCDvA8bxrg+
X-Gm-Gg: AR+sD1212UD9E+w0mtn/zyyaZ3ZGmfTqLKBH/mlPlu64zKueR7p3NDLvZhJqRfo/1O2
	OJW9RDDOP0DQbsF1sbzPvGUgJ/x6BEtUPy+uTgPI7yYNzI+wr7TqnMyODF7hfzwhQWQa3eJ/8K/
	jZrBIHG10/Uax1+xPxnGTGuQY7XHxmVIP0Nj9wJ2LRzmE3ZbHTBudG1jF5+zbq4bcO1TI8Hc+iR
	XG3ZovS9FAJ12G9cZQfuMvbWSXk1ostMFuKHzcCuN/w9s5HdgeEuBB5xAKwO9oMlwA1f/bIgIoo
	Yexe1P/FdOIgHzDzGiLK43NLCZCH+4BL9MeBpTxXepma55J8PFrO6A6YGcuLIySLUpNQDs2RYAd
	+6hIoKDFDfR+ZEAa6VBlKiXMcHJ4aoBn7lm9tqL92NjpGelgdEtTIfT0A870yIJp4Ue/MqEvtjO
	JA06Cpj8kXu1Gx1nVrWBUfGj0pcLAb5pjhkOI+QMdiCiK+4KgMcnoisPbcy9CelRnzxl3n4t8pk
	/Li0RxvsflzrfPX3B8udaMCNQ==
X-Received: by 2002:a05:6000:2489:b0:475:3a97:8e2c with SMTP id ffacd0b85a97d-47fd72a8634mr1849874f8f.16.1785525991497;
        Fri, 31 Jul 2026 12:26:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456262bsm7841993f8f.17.2026.07.31.12.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:26:31 -0700 (PDT)
Date: Fri, 31 Jul 2026 20:26:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pablo =?UTF-8?B?VmFsbGVzcMOtbg==?= Aranguren <pablopva014@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "open list:TULIP
 NETWORK DRIVERS" <netdev@vger.kernel.org>, "open list:TULIP NETWORK
 DRIVERS" <linux-parisc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] net: tulip: xircom_cb: drop runt frames before skb copy
Message-ID: <20260731202629.10ff97e6@pumpkin>
In-Reply-To: <amzqfjeo0Yo1p0Rd@ThinkPad-P15>
References: <amzqfjeo0Yo1p0Rd@ThinkPad-P15>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Jul 2026 20:33:34 +0200
Pablo Vallesp=C3=ADn Aranguren <pablopva014@gmail.com> wrote:

> investigate_read_descriptor() takes the 11-bit packet length straight
> from the device-written descriptor and subtracts 4 for the CRC. A
> length below 4 underflows pkt_len to a negative value, which is then
> passed to skb_put_data() as a huge unsigned length and corrupts memory
> past the end of the freshly allocated skb.

Have you checked that that hardware can actually set a short value?
I'd expect that packets shorter than 64 bytes (including the crc) are
dropped as 'runts' and probably don't even use a ring entry.

Of course, if you think the device might lie all bets are off.
(Without an iommu is can write anywhere in host memory...)

	David

>=20
> Drop the frame as a length error if pkt_len is negative after CRC
> removal.
>=20
> Signed-off-by: Pablo Vallesp=C3=ADn Aranguren <pablopva014@gmail.com>
> Assisted-by: gkh_clanker_t1000
> ---
>  drivers/net/ethernet/dec/tulip/xircom_cb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/dec/tulip/xircom_cb.c b/drivers/net/eth=
ernet/dec/tulip/xircom_cb.c
> index e5d2ede13845..62c64da1c8fa 100644
> --- a/drivers/net/ethernet/dec/tulip/xircom_cb.c
> +++ b/drivers/net/ethernet/dec/tulip/xircom_cb.c
> @@ -1110,6 +1110,11 @@ investigate_read_descriptor(struct net_device *dev=
, struct xircom_private *card,
>  					/* minus 4, we don't want the CRC */
>  		struct sk_buff *skb;
> =20
> +		if (pkt_len < 0) {
> +			dev->stats.rx_length_errors++;
> +			goto out;
> +		}
> +
>  		if (pkt_len > 1518) {
>  			netdev_err(dev, "Packet length %i is bogus\n", pkt_len);
>  			pkt_len =3D 1518;


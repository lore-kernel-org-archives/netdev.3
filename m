Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2F3806DD
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784455968; cv=none; b=ninmDbI1HDiDJC7amUJynpfBhUapP/2b/YCdmYQ1ZBysseyv3bdEk9AncmNHSq15rfoyzDhZdnoxIuHej9q9Tq7uPRq29/T42JdyE+Dk9CfCf2xE+PYlarzkjk8gq8WlXyEOw6/Um4ueD5lSqijprM7c9CrpBpLmQT9g1lOY2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784455968; c=relaxed/simple;
	bh=IX6uwEvUSMGaR0cZ+BWNkBIs5GN9bVOotT1KPZImK7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7kIN4i96xYRdKH0IVqZ66EWql/eEBbOXmYqoLFvXK7ZqcQDKfADNDoQB3KC8+dx4KNdCcD8OXNlCcewKptj0+2I9O+g0ex0hcKHJfUGh4R5/OmSirOMfSw/2nk//2MQZBxrPD1jAmc0MLYud/TUF9CEKqQpjV5CIFlgCUNdrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4lBnNcJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4lBnNcJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954b3c5cbeso2248445e9.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784455965; x=1785060765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KRKs9H4rL328+i+tC6jy0yDGsWhK1FsylMyl9gj4/r4=;
        b=r4lBnNcJdCnIbTfiskrHHMA9yWocn1b/L98dAK5Wb8oxw8UkAlIdEuQGOykh2tcQjf
         03NPUOlU5OsBv/6DI6lH9dNZubNzaeoyynzWu/eh8Ugmthyw9NIeqOH2oskFd83KT/xp
         qYHOV0IzVH5myXJ0PdgJybfv36mxDKM9BlebjDyNJcKM60h5I0VUXlK9FdRUSwVD1CC3
         pH510D0DiD/7g1A3EuVoi2WrZ26hmLscRfcPzROyvzaTJxOVLsPBufDZzieFINvXL2uQ
         Eef97j3miWd9AKEMG14f7mVoISTRvFYl2XyCeO8bvqK89oI+kjzdV48i7THy22zzHXQC
         GOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784455965; x=1785060765;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KRKs9H4rL328+i+tC6jy0yDGsWhK1FsylMyl9gj4/r4=;
        b=qrFVcNfFWISKCVo7joCrhMQYh+AHNXCuo6DxHxl20bGn1I+QtXiHVc9/jEFw17kAos
         qGyF4I0Wu/cGJc995xIbs6PfseBJf864cgCZOPa2ls4e9PGzjU1uvQwm2urfmF/2Sagb
         QeD3sWTsJRGbEQlFdSkBuQSDh4wYi05VZTYuYd+SecC7WO6x+vMubWZU0JH3Tr+VzJYl
         FJUPfRZbt46xhnl3uhLTixvz8aEPNRtNXILjZUokCM25gtNMkNlhlnJyeQe2L0lF22bw
         YMWXkGxZ4KIb/Tiz6d3m79QWLP3y/79Lq5ybVfB74ceg1q6NYRqswfrRWpTESsewx0u+
         KdeA==
X-Forwarded-Encrypted: i=1; AHgh+RqFrGt70TIaRhP88OReuDK4NvPK5GLPG3CYo230YhzeV9CXeiEh71Rwuh13x9Fp+m1LA8AqyAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8clHQLlI/vHIK75Tq8EATiYcKRdV33m6QdBVCLC5/vhmegXX0
	O9KqFNMgYl8NT7wXSxtfdORiatTSDdkI3TRJCxxV/WolNECl4vc47Qez
X-Gm-Gg: AfdE7ckV+liNn/maaJWTguOaIN76K8lfu9aFw/EeGOUKBf2c8XELOSJ9QkVO1ZDRlTz
	zG6zcx07OjoAao36V6ugzLfQG/BFx65HkAbbAGluP5PBuwOfaING+Jr0pgKzNgcjhOSN1Qa1sF+
	8IB1uPSDvrzYL5vnStSsT/gB8pV7KrjlR7+VgbMCNzB4oSpZSK/GNvqSuH8ngAPeB6lqMI4sr3i
	HxN2yWKJVfAp1KOtfVzsCPCREyGVBs/wAxXFc+0YJwJojW/XuuNQHtjybhBAZ3efZnigETHs/rx
	pOpZIWWTiFe228NZ6wcVZuw3Cs3EOrHuuCDtP9aYiXW3BRJA8jf1WjBaEdAIxM4dwK1cZd58XH7
	H1mAopUWJPDc4xRBtL4HaZifhdDfd7XHp/MZgh4SjFqelSO3vOXQmrpkp202pw/C1ycfk
X-Received: by 2002:a05:600c:190b:b0:493:f42e:1b3f with SMTP id 5b1f17b1804b1-4954a40b8e4mr61842115e9.3.1784455964578;
        Sun, 19 Jul 2026 03:12:44 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:a8b9:5a2c:9df7:540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2b87c6sm331350835e9.7.2026.07.19.03.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:12:43 -0700 (PDT)
Date: Sun, 19 Jul 2026 13:12:41 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: embedded PTP
 timestamp support
Message-ID: <20260719101241.xs4nz7r5bonb3qys@skbuf>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
 <20260710-mv88e6xxx-ptp-fixes-v2-2-af97c38df247@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-mv88e6xxx-ptp-fixes-v2-2-af97c38df247@padl.com>

On Fri, Jul 10, 2026 at 04:43:42PM +1000, Luke Howard wrote:
> @@ -6370,6 +6371,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
>  		.ptp_support = true,
>  		.ops = &mv88e6341_ops,
> +		.arr_ts_mode = offsetof(struct ptp_header, reserved2),
>  	},
>  
>  	[MV88E6350] = {
> @@ -6447,6 +6449,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
>  		.ptp_support = true,
>  		.ops = &mv88e6352_ops,
> +		.arr_ts_mode = offsetof(struct ptp_header, reserved2),
>  	},
>  	[MV88E6361] = {
>  		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6361,
> diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
> index c359821d5a6ea..c25f53923e768 100644
> --- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
> +++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
> @@ -68,6 +68,20 @@
>  #define MV88E6XXX_PORT_PTP_CFG2_DEP_IRQ_EN		0x0002
>  #define MV88E6XXX_PORT_PTP_CFG2_ARR_IRQ_EN		0x0001
>  
> +/* Arrival Time Stamp Mode (ArrTSMode), CFG2 bits [15:8]: configures how the
> + * switch embeds the arrival time stamp (PTPArr0Time) into enabled PTP event
> + * frames.
> + *   0x00        frame modification disabled (time stamp read from registers)
> + *   0x01        append the 4-byte time stamp at the end of the frame,
> + *               growing the frame by four bytes
> + *   0x04..0xEF  overwrite the 4-byte time stamp in place, that many bytes past
> + *               the start of the PTP common header, without growing the frame
> + *               (offsetof(struct ptp_header, reserved2) targets the reserved
> + *               bytes of the header)
> + *   others      reserved
> + */
> +#define MV88E6XXX_PTP_ARR_TS_MODE_APPEND		0x01
> +
>  /* Offset 0x03: PTP LED Configuration */
>  #define MV88E6XXX_PORT_PTP_LED_CFG	0x03

We try to keep the data path protocol between the switch and the host
API compatible, and identifiable by /sys/class/net/<conduit>/dsa/tagging.
I would argue that the protocol where PTP timestamps are in registers,
vs where they are in PTP header reserved fields, vs where they are
appended as trailers, are 3 different protocols and should not be
presented as "edsa".

Two different switches both use the "edsa" protocol (say MV88E6390 and
MV88E6352), yet one expects timestamps in registers and the other in the
PTP header reserved fields. Strange.

In some instances, user space cares (though perhaps not imminently).
For example, libpcap/tcpdump might get confused by a non-zero arr_ts_mode.
Or an XDP/AF_XDP implementation of the edsa protocol might not understand
(because it has no access to this information) what arr_ts_mode the
underlying switch is configured for, and thus where to get timestamps from.

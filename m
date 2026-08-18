Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939B4477FF
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043588; cv=none; b=RL5gOwYm4r6dMD/RsMlPcznHbrsRL51+HUywERvwpkPmp8LrwvwAUkJSi2vysv/teCj8gZupbEhsO6pNeD5poj+91xCS8TrOkFtA6SZK2S3YoszhGfj0TLJVUgmFiTZMSzacp+8H1Y2k1lQcwhpktyyNglkrFQrR5kmdtptI7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043588; c=relaxed/simple;
	bh=7OKeIQJtan/vPHab7JonrLUvfOsfGdkEdabx+T7S120=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA8yu0ZVpZK96Lg09FCxyiiCn0eUEUkQZy/9VrT1wGwGW7bN5GBLu9Fbf1AoY23Wixn4vQCqtrSw42vhzErNWoU6LRXR75NWRvZ+9RKFRbMHf0SvnvUqeDfbMfnaV10kc1g70rmoJcv8lNSIMoeA05RCd3CP8YVn2g8hmi726H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL/qXPpy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL/qXPpy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954df200ddso30992325e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787043585; x=1787648385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7OKeIQJtan/vPHab7JonrLUvfOsfGdkEdabx+T7S120=;
        b=BL/qXPpy2bwtKWGtPN52ChTDhrBO7f6ZmvMDWLAAAqV+STTpTIwpv73/xpju+MMMMh
         T0qCffLmjFyvYbLFjaXPCfRCOeWZ+rNiS82SrJLlBhbqdDjrYzkoYdBTBleF4fh9figj
         j3HC0cykPyW4Y680IT5gaBOlQ69L99o37cZ21+oRPwoTm/QLGWew1plaOYg10N201wWz
         8/RPXACnEpS6H+g+r4DKvEZffrMONCevG9qC0d2inwANdG3Q/mWxpKlV9s0lOz2aN8uD
         Rvhchlcxhikv3B7lbQxfsFuvFJhjjSrtsnD/W84sNv5BfpbV3TP9oKUino66Q+ZWhs4S
         bxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787043585; x=1787648385;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OKeIQJtan/vPHab7JonrLUvfOsfGdkEdabx+T7S120=;
        b=QoD9MkqO4PiLcDaoGuUvrEGSp38CWNl8493TIl9/Ve8+bCAmKfU5g75CSGNGDMpabE
         M0rpCUD6prf2UyrfYtUgqbO9dCFvXTcU/i8QOu3cYTIyqGXDRqTr5n58JVizkgvxtxuu
         IaVr67KXNYtsmfefYZEmNxcdXTXppkNGavRM17wzmtt58LlkLM1HxK6fucUfIMWETHCi
         ikP2crP8epN5kwttOLLF5DPtxP0+p0ETuYd1xbE57B20JoA2F4W52DDj7e9addCjQ6iD
         MV2DT6FphID1+rDMUIiLJc9pQ4wOSP9zno+imaZwji6nuGJlfshdSnRLoRj18cxdXCkp
         8TmQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVwpM+Fhtr77WwUuRyjGPztLJFR+I84QcCds5aHUb4q6ZiIcF1xh5LWp2DMv4fKv8eLcp3cP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1SIvTQ2aiUjQktc5+bMGfbzrUN6qVZuxhGjJbis5GReog0r08
	ZTU4eTLWFTCpPZGJyb9x9Waexqpn/6GZbK1Tdnw+d6KmnTolnLS3iL75
X-Gm-Gg: AR+sD12jjZcIakopy11/Fxn9Gi4apUMqRJGTBSgoOmevd2/wIohD4AZoCFO+xTdRDNN
	ydphg58PegibcV24AsXHAJURVF5WS0HKKCoNQszjnKwEMiLTCDbff793P8t+5fyWcvAH20fZZb0
	WPWeL+5Lvn/wOtFMqNHlOwDNvZVTeGSJb8rJ1DFFKNo9tOLYaoMBPBNf82TSBualcXtyLpzOr/o
	7RuQLcS5smuSbZBR9ZY/gadzU9Aj2HiDEIJ4821Ejgp+CJtSVsBKluv1dkyGTiTBAR+nEys4RJn
	WCgvHOnVclpAZ9GhVD4QCNklQRnLX4KvPHFL9TmqL2OA4T6TIQskv7uB+NE6AWq/mpVROASptpF
	mpFdM56PN251srrmqYXmBxlFnnj+CRKhSB8BZZrnI0F5CEdgb1MgLCsD9j0Gua/cPQ5Lwzv8eT1
	JWEuNKajPVzfDRusx6nbpGHtkGHZfSu5p9+8xdh/jfRuZkD0YXMm2MViG15PvW/I8b5G0ViDa6/
	2ez22qIermoMXKxvD7wl+CZ2OMG+t9eWDIOp79I9MVUH70SNpXBBetew6UNijbkNygdeX8k
X-Received: by 2002:a05:600c:4fca:b0:493:a623:d090 with SMTP id 5b1f17b1804b1-49987961c23mr482541885e9.10.1787043585262;
        Tue, 18 Aug 2026 01:59:45 -0700 (PDT)
Received: from cedric-laptop (2a02-1810-cd14-9200-a598-4f77-766a-92c1.ip6.access.telenet.be. [2a02:1810:cd14:9200:a598:4f77:766a:92c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0876b8sm166122195e9.8.2026.08.18.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:59:44 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:59:35 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: 
	Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>, cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v8 2/3] net: dsa: mv88e6xxx: use the hw tx queues
Message-ID: <hgrxt3hlj6i7rcg7jxgyxzrxw6knk2eqykpiq7lgpu3zshprqq@ranq77v7pxbv>
References: <20260811-net-next-mv88e6xxx-cbs-v8-0-10d0baab2905@luminex.be>
 <20260811-net-next-mv88e6xxx-cbs-v8-2-10d0baab2905@luminex.be>
 <20260817105024.65be6d55@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817105024.65be6d55@kernel.org>

On Mon, Aug 17, 2026 at 10:50:24AM -0700, Jakub Kicinski wrote:
> On Tue, 11 Aug 2026 13:45:48 +0200 Cedric Jehasse via B4 Relay wrote:
> > When transmitting fill in the PRI field in the dsa tag to select the
> > egress queue is sent to.
> > From the datasheets i've looked at these switches have 4 or 8 transmit
> > queues per port.
> > Note: skbs with skb->offload_fwd_mark set use the DSA_CMD_FORWARD
> > tag. These are processed as normal ingress frames, meaning the queue
> > they end up in can still be altered by other switch config. eg. priority
> > overrides, tcam policies.
> > This isn't done for vlan tagged frames because this would overwrite the
> > PCP value in the vlan tag (The PRI field in the dsa
> > tag is used as the PCP value in the vlan tag).
>
> Pretending that a DSA device has multiple Tx queues _from the stack_
> makes no sense. You should be offloading PRIO as the root qdisc,
> like mlxsw does. Then the rate limiters should be attached as children
> of PRIO.

This patch follows what the implementation i found in other dsa drivers.
mlxsw seems to be the only driver handling TC_SETUP_QDISC_PRIO.
Wouldn't that mean setting up cbs for a mv88e6xxx switch would use different
tc commands than setting it up for another dsa switch (prio vs mqprio)?
Is your comment specific to this driver, or for dsa drivers in general?


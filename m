Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95824E4C6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584793; cv=none; b=JKrlErHHBD5yHo0/w3PZjeBf3ew/7pZ4NBDHkFGYAuaULS2865hnwv4bmi/wughIJfNL2P3GUiYSlKtvt7+HUqahVfa50COnvTGZ7NvekJ2e2gIQrA9DuqXxwTFHsYOfPu5s1251wQaJhAy7J6m9B+vrLWa3hvGhHz6ZlYFdCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584793; c=relaxed/simple;
	bh=8cH4mAiquyBWMo7JCLMDAIcgKxWh3mA2G+eVR5xhxcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CX/f1JwHbWmJCh53MHzBFLqdbsdDPjwSeTgcsE0puC/87lvdyw86fufM/Aditrd3W6HDEBLkoRMaediRSw91cNJnddbJ6PNty7DKHFfH9N7rnYp1E4yuo2Wvx1M/8K78a2i2EO0m9QjiBvF5GveBCQNhrIfop4oA1jQwLQy3A2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTC/jynT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTC/jynT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso9918435e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780584790; x=1781189590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjRGuOqbwCyHAFXf1dsFmUnnUDQzMFMpBmyvdHjNefI=;
        b=qTC/jynTxhm3I5qQzwfZQKtBilHchZNwXRtUmI82AJYBHnanRmxaE2sdXL43vRE057
         VTdKCkrtJ7gLFcnsqTUT7XyKQrE1tiaz9aYfAcQL8bU0Nis4rIcHls9Rx6ck3+yje9/w
         X9BadcrLdVt4jAjxbi2KChhtwWN9p4V6K7HgTnMHa2Amp79Ai/a7sQmSkEO9isd/PKlx
         7Awg/NolOpvSqQGZdM2LsZsSPZ5iT4tQoSVpHS4bm5BbstbgeBI41+OkVbqkOXCvNaNp
         TfHJ59ntCMwQE8CvYzwmvNf246mDi7exNjnVljV56ZALIPK6Ex3XE6qx8BRL9aYz4fot
         40rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780584790; x=1781189590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjRGuOqbwCyHAFXf1dsFmUnnUDQzMFMpBmyvdHjNefI=;
        b=ROyJntS2od+E7Y0Qf4CiQchWcqV6GCkEQdBT8p65+eS27KNABw0L/urTl+Y1VmsJvr
         8vibRdzQ0l2KVDpG72WqZSgM38V0JJbXie7LYIVf4EtpSWOOyyza8zb29j6VAciIn1pD
         jJhPynitiysQyQ2bw1dwSk/P2zZZsMALHQ22GA3GnKWKOw6SU/6JB6WLVks+ymhmuTBZ
         V5qkq1jMHVPobZdD6cBHqjB5HKoR0rJdvHH9AqH5UjS5HDoiKwXIyApZwnm2GPaue4RG
         m9RI8G0ntS1mopsadGHzogQhUM+Z9S87w/0/ckv1hROMqUAedSVb7QQ7VXim7Ov5GDej
         FscA==
X-Forwarded-Encrypted: i=1; AFNElJ/CnMmIB9pMPboatn3UbN4y/q8d3c/ku5DPstmt61EldaKHp0FsWSh/BjkuEGVFRgSAdmOnkuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlNQZRwcHIRYF8nkhC9cOWABOWkCQA9IJSepV7nnVMZo5daO1
	jIA126uf8C1LJsJS2NWEX1sWRPWDGjSxSUcZggenWyRshMzRUyUaX6tt
X-Gm-Gg: Acq92OGlpM3TfkwPxOcGE/61zexf+fl9XjxEhV8REcaJ1Hjvv0w/zUuwn8ul0i7QoHH
	I3MkUIXSvWp/ao1Bfr5ETIgf34dpNP+x7rK8ZEgKkJBRAwt2dHIvOacPzfN/FVV8eNvdSoAraK3
	8FAZPokELD/x+SyKyyPd74/T+JCXvoCU4sscqAEqEQM/lQsz4nVvNfP6PROKfPDjkmrrXSt++Mt
	4TctO4C/VSkopspinLwhicdDRK7Wo0a5ZLP71oBG+pAaZfMPrUpYuqiRbP2Cugp+fMd4t81C4Kl
	YFImY0GKucXs2Cem3KVQtKXuJznBJ2amdDhifHxav/bvY35cEKzOtRByvtqTTUBRTtJDo4zKQqX
	oGGwPLPMMVmxr6h976sk620QHnPJhiT0+E9rsXr6vyzula+3AdusoexkbXDk22kT1oiFTIC3CxB
	fD7jiu5H9pmwuNXVGzuwXW3TmJvzzmxGPgw4svzJH2bdVXfNWtvINqn/aqi546hhbeEQ0H0M7T4
	9+dLNhVjA==
X-Received: by 2002:a05:600c:a0c:b0:490:bd66:e526 with SMTP id 5b1f17b1804b1-490bd66e5femr59985365e9.32.1780584790359;
        Thu, 04 Jun 2026 07:53:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm17030103f8f.0.2026.06.04.07.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:53:10 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:53:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
 <horms@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu
 <larry.chiu@realtek.com>
Subject: Re: [PATCH] rtase: Workaround for IP fragmented UDP packet hardware
 bug
Message-ID: <20260604155308.770b2deb@pumpkin>
In-Reply-To: <1489704deb9844b08848758af95a448e@realtek.com>
References: <20260601062341.63981-1-justinlai0215@realtek.com>
	<5c095b26-9720-45b0-a8d5-a8495291e45b@lunn.ch>
	<447c46ad1f654222a8daa423149f0b89@realtek.com>
	<20260604124606.7143581b@pumpkin>
	<1489704deb9844b08848758af95a448e@realtek.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 13:43:27 +0000
Justin Lai <justinlai0215@realtek.com> wrote:

> David Laight <david.laight.linux@gmail.com> wrote:
> > 
> > On Thu, 4 Jun 2026 08:33:51 +0000
> > Justin Lai <justinlai0215@realtek.com> wrote:
> >   
> > > Andrew Lunn <andrew@lunn.ch> wrote:  
> > > >
> > > > On Mon, Jun 01, 2026 at 02:23:41PM +0800, Justin Lai wrote:  
> > > > > The hardware parser incorrectly interprets 319/320 in a short IP
> > > > > fragmented UDP packet payload as standard PTP destination ports
> > > > > and treats the fragment as a PTP packet for further parsing.  
> > 
> > Is that a packet that has been segmented by IP, or one where the skb is
> > fragmented enough that the data in the header is too short?
> > I thought that IPv4 required an mtu of 128 bytes (ish) and IPv6 somewhat
> > larger - so I don't see how that is a problem.
> > 
> > If the skb is fragmented then you need to move data into the header not pad
> > the frame.
> > 
> > If the hardware really is broken then I suspect you need to disable the feature
> > and suffer the consequences.
> >   
> > > > >
> > > > > If the transport data is smaller than RTASE_MIN_PAD_LEN, the
> > > > > remaining data is insufficient for further parsing and causes hardware TX  
> > hang.  
> > > >
> > > > Where does RTASE_SHORT_PKT_THRESH come into this?
> > > >
> > > > RTASE_MIN_PAD_LEN is 47, so matches all packets which need padding
> > > > up to
> > > > 60 bytes, plus FCS. There are not many such packets, so why both
> > > > this all the complexity and just pad all small packets? Do you have
> > > > any performance numbers which show the complexity is worth it?
> > > >  
> > > > > Pad these packets so the transport data reaches RTASE_MIN_PAD_LEN
> > > > > before transmitting to avoid triggering the hardware issue.
> > > > >
> > > > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>  
> > > >
> > > > Is this a Fix? Please add a Fixes: tag. And base it on net.
> > > >
> > > > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.htm
> > > > l
> > > >
> > > >     Andrew
> > > >
> > > > ---
> > > > pw-bot: cr  
> > >
> > > Hi Andrew,
> > >
> > > RTASE_MIN_PAD_LEN is not the Ethernet minimum-frame padding  
> > threshold.  
> > > It is the minimum transport-data length required by the hardware
> > > parser after the packet is incorrectly detected as a PTP packet.
> > >
> > > Therefore, this workaround needs to pad the packets which can trigger
> > > the hardware issue, rather than just padding packets to the Ethernet
> > > minimum frame size.  
> > 
> > Is that a longer length?
> > Excessive frame padding (beyond 60+FCS) can be treated as a protocol error.
> > 
> > -- David
> >   
> > >
> > > I agree that RTASE_SHORT_PKT_THRESH is not necessary here. I will
> > > remove it in the next revision.
> > >
> > > Yes, this is a fix. I will add a Fixes tag and repost it against the
> > > net tree.
> > >
> > > Thanks,
> > > Justin
> > >  
> 
> Hi David,
>  
> This is an IP fragmented packet, not a fragmented skb.

Ok, your tests are broken for fragmented skb.
skb_tail_pointer() is the end of the initial fragment, not the
end of the actual data.
So you could be adding padding to a full length packet making
it overlong.
Somewhere you need to be looking at skb->len.
Probably with a fast-path check to ignore long packets.

>  
> The issue occurs on a non-initial IP fragment whose payload
> contains values matching the PTP event/general destination
> ports (319/320). The hardware parser incorrectly identifies the
> fragment as a PTP packet and attempts further parsing.

Wait a minute, what stops someone using either of those port numbers
for something else?
There are no hard restrictions on the use of UDP port numbers.
So what does the hardware do with UDP packets to port 319/320 that
are being used for something else entirely?

> The workaround does not modify the IP or UDP length fields. The
> original protocol headers still describe the actual packet size.
>  
> Therefore, the protocol-defined payload size remains unchanged.
>  
> We have tested this workaround and have not observed issues
> caused by the additional padding.

Have you checked all the systems that might receive such packets?

-- David

>  
> Thanks,
> Justin


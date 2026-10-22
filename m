Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702087;
	b=DW+BpwKi9Fef4Q0/gX/meM6FSPA+VrlvSUhQbNZjS9tesn4QQYUSIm4v0c265Ftw9Zyj
	 B5NFaxrOm/Y2rEhx64UuEN+uXam6ljc7Ls/3togaU/R+jMX8r0Zb6mCSobdi2yy6plF91
	 8m8qjmNxZTcYBwgsKk5bemWP3+/Xxwblk3vYeh5ZVQEGflM/t2hHfbK3VQ6boSncubTZb
	 YNXTLsQtW4aapMZJ1bsr3z7qYv3m1IXVEXFejpuHvMMsexAiguP6sriI8H19IwfS40er/
	 CWnxcuc8lWcAALCDDEkHJygQO2nN/6mpkbwZAe8PaR7WEUVsJzraid5Mj7jV/5yq1Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y5/2svsntF9R7wAKTIjqq4lXpmG9ahkTltbSjO27xnw=;
	b=1PTLFkBCihcIR+SjbJKohmw+ZrMn+pUx/VGXwNWlf7TkB5UxvfzqYNVYyFGdtw4dvt5R
	 Nr+Xp4R6UEkprGY6rDX762BaYs2WWPwsaRrZKhwFvYHS9wgtCnIyhhiie3x0RxjVgjvMU
	 mCRNbpTLLY1pB7CTwWDWrNkKZSNCksipEBXK2YgaHDVw0ymvOLWS4E6LMbPqNDLguj/hS
	 /V0t+aub5Lom+cGasq1jzi0ZDxF8lqEw7utagSwG96FkWt3Zm054qJhkjlVTkGnaQAajn
	 M1huLtXvBpEy+/fM6y30xyJ2UYyWU8U2TjYq9u5OAhE9hoNKvE624Or9jl4d/VC5hjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mbtscbdr;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CC606A32D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 979CC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mbtscbdr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso2368995e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792702086; x=1793306886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y5/2svsntF9R7wAKTIjqq4lXpmG9ahkTltbSjO27xnw=;
        b=mbtscbdrs7qZgCYJ+njfdJf5aVFoyYRLmprOpQi6PPJ3oWFxP4h9Z2G7jXnP9/uTve
         QN0ANENOrCfjMEiNhzjQhtxEdb50u3UrAupcb6Qm4gXaBz7gJs+KPa1yQCNYIiE5GpVO
         Ilmy2epFjqP4RtbJ202z8d/RMnqOKlht50McXYEipVy2Q7hbJtTklVfihlxv+/hGJAyX
         VNzQFq331nQL3Qwn+pSiANu2ysd0xfEcW9S00FYww2oKTSLEr+lTxchpj3MKv/CZZ9pI
         uWkyBQLjvNGE00Tx80HO2RANZBbBo9bA9nY7bNBh3qHxG4RmRB6mQaLystsYuiikPnN8
         9aDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702086; x=1793306886;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5/2svsntF9R7wAKTIjqq4lXpmG9ahkTltbSjO27xnw=;
        b=On+mnCf3T2RN6ERaEa95gbU11wwnm7hkKkEh6jBs27GJkQF1f1P6OSGf/ApTbZISd7
         bqxdAEvVRDmCDTIUmFXgt73tlrTt0CLDVEl2uykD/61PmzAiEvR8s5OcoaF6KJ70XwVV
         Vo+9sovpwfqM4A03Rn+fUi5upDEBm+ch0+O4noy6rtr+yr9Jc1ZNodhjq0l0Hugh37At
         D9VzfAHX0z7q6GXw2fpAgxJ6eCKrV7VB7hEndmSUgGi2ZEagRRYwdiU5E67IaggBWOTs
         +zMqCgOvhf9KkjQK+XruLdQYmxOnDCrE7Lp2u702yF6broxrF3cmRvtp+L+jm+jHSXty
         jhOA==
X-Forwarded-Encrypted: i=1; AKwUvBzY2TR5oqgH4vBFM0o2p+QYgFGyFlqC/gT1AVmHva0MDxcq/H6aDJYKT4wx1424T8MmUJqOio0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzGGpMM0NR2+dnzPuFbn7SeqXmO+77WTEj40FMihXH1/indPBe
	8h0c2DQwML8QI+OuUghO9o7+aHNnrHB0sciR4OQTKaT7ISFr3yXOmgjU
X-Gm-Gg: AYBFou3xQ8HeHn2IA6MCKJlZtIzZn8V0kL3kIPa9HnEti8lmPl9Jvy1NZWMnQuiU/HB
	9UsEpdE0oAOmJjATCgpuDC8BGYv1O4vgrsSbS+VUDaMT7vWgXriIVrE2evAvn6DQX3nFC1bFKF7
	brKaTwlVGUNm7TbH8H/85ljc1gPWgDSkOjdTXqhJaWEO8HoMECtOU5PAODbigG15JLUE+uPr5cv
	Xz+5XlFdMWaDg+yqei0sRkN8EEEsOeM6vXk5A187gH0pM9QFcanxPQBi/LizPwy3UbV9G47CnHo
	uG/jK02gqygylT78v6HpLBroW5XRGS75tKL5jDUhAx1URNxGxmzADqaeD6H0W4SO/AKs3Anx3SZ
	I9uPBCz2hY/eScvR3WQCe/+gyBLNeF/2BOYQmMDKK1D5ztF7tRZMWqX8xgVJyo5JLewoc0YRXE8
	mX4goG4mXNdso3NwOH8zLx7YrjMHlg/XNRSwBthLj+E6S+w5buO0soN1bfxcXHKm4hKsYCGFk/S
	nIUrqLHhXClBumQiXxaS8qjxmRgLiN0GPAG7vDcvE7YilwYl7zOgbSgwwaYITa2t/7xXxjW95oy
	n54iP/2dkyr99IEfT3gxxCO1/dWp9tlPABj6HMY=
X-Received: by 2002:a05:600c:1c09:b0:4a1:f377:5c6d with SMTP id 5b1f17b1804b1-4a211cd5bb2mr3236035e9.6.1792702085705;
        Thu, 22 Oct 2026 13:48:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e380314aesm308718f8f.28.2026.10.22.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:48:05 -0700 (PDT)
Date: Thu, 22 Oct 2026 21:48:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Zefir
 Kurtisi <zefir.kurtisi@westermo.com>, Zefir Kurtisi
 <zefir.kurtisi@gmail.com>, netdev@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net 2/4] net: enetc: do not rely on mEMAC hardware
 frame padding
Message-ID: <20261022214803.40cb2aac@pumpkin>
In-Reply-To: <kaqeg262ql6mucqzn46axaniowt35eq3hd52nefev2uvvkbfkz@6onteyxyjypx>
References: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
	<20261021145314.1435049-3-vladimir.oltean@nxp.com>
	<20261022093359.723c7e93@pumpkin>
	<euqz7djxfn4tqbd63ymcj2bnu7k2bb6hzlmeilao3rvjdhyisf@bk3wj5hinfnr>
	<20261021145314.1435049-1-vladimir.oltean@nxp.com>
	<20261021145314.1435049-3-vladimir.oltean@nxp.com>
	<20261022093359.723c7e93@pumpkin>
	<euqz7djxfn4tqbd63ymcj2bnu7k2bb6hzlmeilao3rvjdhyisf@bk3wj5hinfnr>
	<20261022112218.11a1faa8@pumpkin>
	<20261022112218.11a1faa8@pumpkin>
	<kaqeg262ql6mucqzn46axaniowt35eq3hd52nefev2uvvkbfkz@6onteyxyjypx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 15:35:05 +0300
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Thu, Oct 22, 2026 at 11:22:18AM +0100, David Laight wrote:
> > On Thu, 22 Oct 2026 12:41:49 +0300
> > Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >   
> > > On Thu, Oct 22, 2026 at 09:33:59AM +0100, David Laight wrote:  
> > > > On Wed, 21 Oct 2026 17:53:12 +0300
> > > > vladimir.oltean@nxp.com wrote:
> > > >     
> > > > > The driver sets the ENETC_PM0_CMD_TXP bit to pad short buffers.
> > > > > This works, however sending short frames from user space and looking at
> > > > > the padding bytes inserted by the MAC at the link partner, we notice on
> > > > > LS1028A that the first octet of padding is sometimes not 0.
> > > > > 
> > > > > This is fine per 802.3, which does not require that the padding is zero.
> > > > > 
> > > > > However, there is an unproven suspicion that the padding bytes may
> > > > > come from internal memories, and unfortunately I couldn't get sufficient
> > > > > priority for this octet's origin to be investigated by hardware
> > > > > engineers.
> > > > > 
> > > > > To be defensive and not leak any sensitive information from the SoC,
> > > > > let's pad all frames to ETH_ZLEN in software, so that the MAC doesn't
> > > > > have to do anything.
> > > > > 
> > > > > There are 2 distinct cases to handle, for GSO and non-GSO. For non-GSO
> > > > > things are trivial; we need to call eth_skb_pad(). For GSO, things are
> > > > > not simple, because user space may set gso_size to a very small value,
> > > > > which could make the GSO super-skb smaller than ETH_ZLEN;    
> > > > 
> > > > That isn't sensible.
> > > > The minimum frame is 64 bytes (including FCS), subtract that, the MAC
> > > > header (14 bytes), minimum IP header (20), minimum TCP (20) and that
> > > > leaves 6 bytes for user data.
> > > > I doubt it is sensible to do GSO for anything under the minimum mtu
> > > > (128 bytes rings a bell somewhere).    
> > > 
> > > My fault for not being clear and inviting this kind of objection.
> > > 
> > > Since we do GSO in software, we advertise NETIF_F_GSO_UDP_L4 too, and
> > > there, Sashiko came on v3 with the observation that for UDP GSO, user
> > > space can set gso_size to a small value using setsockopt(UDP_SEGMENT):
> > > https://lore.kernel.org/netdev/178960175550.22033.10648880872141935672@kernel.org/  
> > 
> > I'd fix that in the setsockopt code.
> > But that might be a bug anyway.  
> 
> Why a bug?
> 
> > UDP segmentation has to use IP fragmentation and that is usually done because
> > the interface/path mtu is too short.  
> 
> In my testing, UDP GSO does not generate IP fragments, but rather, each
> UDP segment is its own datagram.

Hmmm....
I wouldn't have thought that was generally useful.
Losing data from random points in a connection is going to be hard
to recover from.
I guess that it why it is per-socket rather than system wide.
I mean, you can run telnet over udp and just hope no packets get lost.

> Are you thinking of UDP Fragmentation Offload instead? As per
> https://docs.kernel.org/networking/segmentation-offloads.html#udp-fragmentation-offload
> this is deprecated and AFAIU not what this is about.

That is the sort of UDP segmentation I thought made sense.
OTOH I think the main user of it was NFS, but even then 8k datagrams
were actually so unreliable it was often much better to tell UDP to fragment
the 8k blocks into 1k chunks (IIRC that was a mount option).

> 
> The docs do also explicitly say that UDP Segmentation Offload does not
> generate IP fragments.
> 
> > But there is a minimum mtu for IPv4 of (something like) 128 bytes, and
> > it may be invalid to fragment into smaller pieces.  
> 
> I have no idea what you are referring to, here, with the minimum MTU of
> 128 bytes.

The correct number is probably 68 (min max size of an IPv4 fragment) rather
than 576 (for a reassembled message) - I think both are from the start of
the IP headers.
That means there is no sane reason to fragment anything so small that
ethernet frames get padded.

> 
> > > Sensible or not, it is possible, and I did generate a test program using
> > > an LLM to confirm this.
> > > 
> > > Regardless of that, the last segment of a GSO super-skb would need
> > > padding anyway, because even with a 'normal' TCP MSS, the skb->len
> > > modulo gso_size could still result in a last frame < ETH_ZLEN. Padding
> > > just the GSO super-skb, as I did in v3, would also not fix this.  
> > 
> > True, but that is a different check to the one you did.  
> 
> So what is your suggestion for the driver to do?

Clearly you need to allow a BD for padding if the final fragment is short.
That is one extra BD for the entire frame, that same as a non-GSO message.
You could leave the hardware padding 'stupidly short' gso fragments.
I assume the driver is building the ethernet/IP/UDP/TDP header so that
will be one buffer and not hit the 'fragmented after 14 bytes' issue.

> 
> > > > But does this code allow for the VLAN tag that you forgot about in the
> > > > other patch?    
> > > 
> > > Not sure I understand your concern here? Is it that with VLAN TX
> > > insertion offload, we pad "too much" (i.e. to ETH_ZLEN, then the NIC
> > > pushes an extra VLAN_HLEN)? I'm not sure that's a problem..  
> > 
> > That is a problem, VLAN packets should only be padded to 64 bytes
> > including the VLAN header and CRC.
> > However such overlong packets are likely to be tolerated because
> > an ethernet switch can add a VLAN header before forwarding a packet
> > and it can't know whether a short packet is padded.  
> 
> Well, if it's a theoretical problem but it's not a practical problem,
> I'd prefer leaving it as is.
> 
> Since eth_skb_pad() itself is unaware of VLAN TX offloads, I'd be
> opening myself up to an endless rabbit hole ("why didn't you fix this
> in eth_skb_pad()? It's a generic problem." followed by
> "changing eth_skb_pad() broke 20 drivers!")...
> 
> Unless it's very clear why I'd be doing this, I'd very much prefer not to.

VLAN headers came in after I stopped writing ethernet drivers!
I think systems have to tolerate extra padding when a VLAN header is present.

David



Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD05426439
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442315; cv=none; b=GsTHJejiJSEXWABodXnTaEYBk+OPEgn7JV2rQehDN5zEj8u2Ic6ViU74MapD/E/wXFwcAb+JCGERZHHTQ+LgSrU9zpspHXYPmThQTptQRe3uhr0+voHVfdAH8BpYdEZc1owBFJt2DtvR57eO2Wg0OInN9VM/6397Tc9K94otEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442315; c=relaxed/simple;
	bh=hniJAEV+U15u+Ql7Igu+2iAh8IKNJ1ohqnycyNNCkVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab4BRw7SHhUafLPMOxOGp444Y3zuz4oUZgRNHzbUSafSLJFAwPVTLUjH+tDeNczOdJPgpIlIS8ShLAXJ3YVCoez5JxhzQZ5VvqSmuZJNO64ST+5fdbkzOJuVYC3EBe/0n7IaNH2hPkSxgkT8UDroQCgT531hR0zPBx1R7hV0eQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7vAmKZD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7vAmKZD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fe45db360so352333f8f.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786442311; x=1787047111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/H3xbh9omUK8Blaba0EzwlFPPb4dOrAmQXLpKYZNEo8=;
        b=a7vAmKZDVy/MgyRu3RS17DurknIYHkx/34IlVWsUyFn3FXjMXcbFkjbZTsIyKGS3jn
         /pjjdIPbqsNm5r5SV2MmI9k0+ZAKXPTUz4kCHLDsc2zkab8Q5t1WfPn69Na0pHDFNqf4
         s49bp8bUuGcByRD3qnwHy525xRXJR9MdJSgfpFg87W4gtInRhaydsUL9Zm321zB1a2/B
         dwBVA9mz+24htrFtxtZgdlZSr/WOWZmitE3/pgCosdWuBDAsAQAR4xnYY8cYowi5HtRp
         uhq1/qgFHx0AjTqnU5J1NEFHuNhODmVI7zBEFg6OgcNCrH5mTTbhmzAqWI2M3LHUf9Q5
         3Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786442311; x=1787047111;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/H3xbh9omUK8Blaba0EzwlFPPb4dOrAmQXLpKYZNEo8=;
        b=Q7rwLBEk5nhekeT0wTnlLXyqwuxvyXn67+1I19/5lODZ+wePDmrISn7pSf2C2af5AJ
         LE4kSCNLOzN8NohI1vMwbKnVeg4huOeEYn+B/PbmbAeOPSa/cI+wtCdeCiE/EYJiM4OT
         K7WsalCRFF37Yi6cbHPISlWInBtL+q5C9kbu3AdMaNgdSOIbZbOzSm/DHQN7xbRgiSdc
         uaefHo5zW9Vg/LYir46TfUFhB3kpKkSHsYUBzsF/k0/3tpvKLRE6NCQ06C79yJOSS6pX
         aWRrxBqMCZLf2p5ZX+uKcImTncyUlbsSqI+ToOnrBylo7HtoKxJw3q4o2TE0iUg6/lzv
         KG9A==
X-Forwarded-Encrypted: i=1; AHgh+Rr6UMAk3hjA1P00OWZcb3CSW1s7kMy4Ld2xl4YpbIR5224nbQrkkMzdc1py0O9J5PXYFQxcVRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHaU099WMkufdcjLMF7eQSI7f9o4YbyMCizQYt7Q9IptDt4g00
	jTk6TfhGUFX1M2OFtQ3f22yNeuInheT04gKzc1ZHlnGbQpoy9eF/fwG8
X-Gm-Gg: AR+sD13TI6UHuhDGZmltPtvTYZ8BAfteBaTHMXKw14yoCeQsCbWrWFgNVEo/AJOg8jV
	aJlhQiaB8VNGLPyfbkJY70gJf0bMUvm/rZezRkCu/OciTYZBLftxRvIvNRrD+EiH+64CSkiN+M9
	vL4Q6AEJqb20+OQCE4/iJHscAQlC2reuk2AXMKZibD16FHFL+s+gs+Dn7wUhIA2XL1MHXEbnzZt
	GvoUL2/JTzibvv1WEZDUUkh0746/m1P44jQB73KxvzFWROWE645YIyzja+liyK3L56CEC39aHHv
	Rl0pU6OLdlJvmkzcXlpb/ic7fMoXUZVORZ0wQDazuT6bJYKKPCtcZG9w8hfQEBIZeNVcXUP3S24
	wVVv1IR69KiJRiOoNHf+9Dq2z8gLcdbypYYWx8ymDFvtEguGE138CNkwDMPNISnYtONdq0YT94T
	WQXpvUAJCibcX88/xAufRE1ZIVqb7Dx95lD8ugmeiMwWe/hjjQ
X-Received: by 2002:a5d:5e8e:0:b0:47f:7e91:3d55 with SMTP id ffacd0b85a97d-4814adbff28mr1558338f8f.2.1786442311386;
        Tue, 11 Aug 2026 02:58:31 -0700 (PDT)
Received: from skbuf ([86.127.220.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac6e6sm3182629f8f.6.2026.08.11.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:58:30 -0700 (PDT)
Date: Tue, 11 Aug 2026 12:58:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
Message-ID: <20260811095828.xwb4nsmx74wtzjei@skbuf>
References: <20260806073119.387-1-strst.gs@gmail.com>
 <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf>
 <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
 <20260806124313.see74vgu4dlqqse7@skbuf>
 <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>
 <20260810120821.lykofvogbrn2y2ps@skbuf>
 <CAAsRjRn7qFWy4UBL8tWGQ9pBo5q3du4e=tU9gSKkSSd7K3RaDA@mail.gmail.com>
 <CAOiHx=n43MPXKxA7oxBjGh15pa4Uh5etxkPdrV+0GxACEnrRJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=n43MPXKxA7oxBjGh15pa4Uh5etxkPdrV+0GxACEnrRJA@mail.gmail.com>

On Tue, Aug 11, 2026 at 09:44:37AM +0200, Jonas Gorski wrote:
> VLAN-unaware bridging does work on BCM5325 and BCM5365. The driver was
> originally written for this family (before upstream submission).
> 
> There is a register bit that controls what happens when a VLAN-tagged
> frame is received for which no (valid) VLAN table entry exists.
> Default is drop.
> 
> On BCM5325/5365, setting this bit makes the switch *forward* the frame
> regardless. This is why it works on those switches even with
> VLAN-aware mode enabled in hardware.
> 
> On later generations, the bit's function changed to "redirect to CPU".
> Stand-alone ports still work there, but VLAN-unaware bridging does
> not. Everything goes to CPU, and the tag driver marks it erroneously
> as offloaded.

You need to be more specific, because I don't have a good grasp of the
various vc0/vc1/vc4/vc5 bits and specifically how they interact.

I *think* you are talking about bit VC5_DROP_VTABLE_MISS having
different behaviours when clear, because that's the only reasonable
interpretation of the code consistent with your explanation. Are we sure
there is no other bit which influences "if we don't drop VTABLE misses,
then what?"?

Then I suppose the VC4_ING_VID_CHECK_MASK affects only what happens with
VLAN membership violations (i.e. VTABLE hit, but port not in VLAN). Thus
it does not influence the VC5_DROP_VTABLE_MISS=false case, correct?

If customizing/unifying the behaviour on VTABLE misses is a dead end,
could we consider an alternative? Some switches support having the
VTABLE enabled, but ignore the 802.1Q header from incoming packets
(thus, all packets get classified to the port PVID). Is there any bit
which achieves this in b53? What do VC0_VID_CHK_EN and VC0_VLAN_EN do
exactly? Does B53_VLAN_CTRL2 maybe have some useful hidden bits?

> But I didn't notice this until recently. Partially also because there
> is no kernel test for VLAN tagged forwarding on a vlan-unaware bridge,
> only for standalone ports. Everything saying OK with a vlan-unaware
> bridge made me think everything works as expected.

Good point. tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
should definitely have a test for this condition.

> > The port-to-port part has been the same on everything measured. What
> > depends on the silicon is only whether the CPU gets a copy of the miss
> > frame. Three chips have data across these two threads:
> >
> >   - BCM53011 (bcm5301x, my RT-N18U): measured for the CPU direction.
> >     Every ingress-check setting (NO_ING_VID_CHK, VIO_FWD, VIO_TO_IMP,
> >     plus clearing the VC0 miss-drop bit) delivers 0 of 7; the frame dies
> >     at member-set resolution, not at admission. Whether a miss frame
> >     reaches the CPU at all depends on the IMP routing from the other
> >     subthread: with port 8 as IMP it does (indiscriminately), with the
> >     in-tree port 5 topology it never does for LAN-class ports.
> 
> Only port 5 is an invalid configuration, so no wonder it breaks. The
> only valid configurations are port 8 or port 8 + 5, but not port 5
> only.
> 
> >   - BCM63268 and BCM53115: Jonas measured exactly this case there.
> >     Standalone RX works even on a table miss, so the CPU copy exists,
> >     but forwarding between ports does not. That is the case you are
> >     asking about, on two other generations of this silicon.
> 
> Note that BCM53115 also supports a dual IMP / CPU setup, and has the
> same limitations, so this isn't something new to BCM5301x. The only
> difference is that on BCM5301x the switch is embedded and has ports 5
> and 8 (and 7) hardwired to internal MACs, which led to the incorrect
> usage of (only) port 5 as CPU.

How badly broken are the configurations with only port 5 as CPU port?
Is other management traffic like STP also not delivered correctly?

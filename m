Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F212472AF
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020200; cv=none; b=S5ow+OEkkiyT2gDA8farfkmkQ9IPWkoQTUdOy87MTUpRy8bbl5kDCZ5BFVgSCOxTqbza9k+Ggj5DLVE5g0l7XkucWvK6mA/HTP0zX1Lo/CoVHm5gGgalg3LJNGOr4U1ITpCVfRPdnwPqPHjTvd/6g8bmKiskJbqwK7F/mah37t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020200; c=relaxed/simple;
	bh=ELia1nGSVtDjYCk8ugSr2bXhv8uV52FM8aXndjdaki8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmknSQqW7QompYxpzm3CUJH9/pEirdkOF6D0l7vLneNnaYlBU67WYHtqdvCvwhXifri+mPt0gYCMEwIDlZNM/zVO0Z3EmX3GuVToJxWst7T+u66z/8ePrHAqCz2IbXBnNUNrsoQyFgh1xfrnp00WBcxVf63njNgVjLtEL4IYEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY2bBdUN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY2bBdUN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4731f5ffa74so155666f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 05:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786020196; x=1786624996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6nKiIB+peEoaY10+rPHgfepIi/Nb3ssNCd0EEwEPfa4=;
        b=BY2bBdUN2hj1yfVm1EjgHVQPSj0gD4SjTQuoTSHhx3bDzt6WBxL19Z4WEamIw+NLNB
         Vxju7ypw2P9XTVf5eL0CZXTl8lI1SrNyYu/hi012SVI1DuH7qFz31ljhnYk0cVtJMke2
         UF4DT17ZREc49GeLearfakwEbGizhgknRPO8C0insb6AcfuaO2yeVMr2nyobsYZdf5f+
         eLpHCVzqd8JJcdcy8E6XBL33gmQYRvGrz7lKsDzqIS/BC4if2ENKvQplmQPChhiQMMce
         Cu3qlu9Nu+5HgVLKcOxtXtVSVe/U1BINusllw8A8D3/A8wORQw6nsszyO9boqyZtHWxN
         wA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786020196; x=1786624996;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nKiIB+peEoaY10+rPHgfepIi/Nb3ssNCd0EEwEPfa4=;
        b=JAO5e386NwvTe1y232i3hCBRgTHvp5SQtXLAX5m7Aivdo1o3gQ7CnwoNhGE6e4QYA3
         S9aBLsngDw3gKPk0AzzKCnFmPlVMJ+f56/N1m6VRqLKADpDWt0/aLCHb1Z3ZkH2yiZ8F
         DYSncBiKjRCJ1DrEfZKB7YqvzuwyX2+KtSV6rRvx4UXPIlMdZFHactPHJ4XrbFPiiAwA
         NQpGP7N/8yFqClPHGOz6yOd7Qd82RoiskpCBbA+l2o043ia+zSdbuaDh2oeFK2AMr20m
         9yPIQhNG7wVdg48RK6N/25a+cCux+3z14EK6/rgyNGr9QAj0dgOMllZSMOiciloLTaNl
         PJRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpf7IKZH97+o3hep4//8IrtVDrmxckYovei3AvaPXQro5nt81Rw34yE0xBGMryju4wVEu2WPe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmR7yvpdSOUaWGdmu84dsOAAZW2mszDYI7HSJn/3nx71rQfz2
	GNdVSZXrsB48Oa22o72WLnTspBeId4XOQ/M+JcNJEXdDuI/JPrm+wPXK
X-Gm-Gg: AR+sD13BySSYXjw9TUPMMZqNmLPcn7zZQE0cWAzfmo9dlBhcZPR3vLqm+Lg6OxyhU0j
	WzV5m2egYNSc2VXsrsN8wB/bhfyOHZPVW/6cREtBKPVIHCGMaoT3IJIt6UNRzf/j+bSva12tQls
	zcH7ICkE87FKOxvg6o8f9kkx0fS/g2Gycm0vg94tbl9ZSOX0nVk7EMHshjSEd90SYKXKBOIUNz8
	bZuudz2NJPKbJr4WZ9WblOKbQRsOS8qRgqORHMZR44leCocoKcK5Exc6JGlqC5kjxDR9Xq3yoDI
	7c5M9CJDDkNYm0A/lzCQ0wHhzg7zT9swIju90AmFJMJd+pCglBwDXHIVK61N4lwrYGDbzG8mTHk
	LmqY9p1DX4APgX+oyzOQTtNxGrevZ3iODjurW1eelntCyNdfcST4zRMmRTDxYESo9Ckj9RXLVqN
	7VkRYLYRt3Y9pEgo0n/0qNQxuvAu88Zh9OYeZTSM+fsrSRlHkd7Egd
X-Received: by 2002:a05:6000:290a:b0:47f:7526:5a0 with SMTP id ffacd0b85a97d-47fec47628bmr11598780f8f.0.1786020196246;
        Thu, 06 Aug 2026 05:43:16 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d801:b100:3c1b:726e:a458:5bcf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b26879sm6023626f8f.30.2026.08.06.05.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:43:15 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:43:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Semih Baskan <strst.gs@gmail.com>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
Message-ID: <20260806124313.see74vgu4dlqqse7@skbuf>
References: <20260806073119.387-1-strst.gs@gmail.com>
 <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf>
 <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>

On Thu, Aug 06, 2026 at 02:44:44PM +0300, Semih Baskan wrote:
> Hi Vladimir,
> 
> > Then their "vlan_filtering off" implementation is broken.
> 
> In the sense that the hardware cannot forward an arbitrary tagged frame
> transparently while the table is active, and the table cannot be
> deactivated without the ARL cost from the other subthread, yes. The
> flag exists so the driver can compensate for exactly that.

But it doesn't, at least not in a sane way. If it still only accepts
those VLANs that have been added to filters by higher layers, it's not
VLAN-unaware. If a solution is not found to the problem, the driver must
reject operation as VLAN-unaware.

> > BTW, how is the "standalone port" behaviour different than the
> > vlan_filtering=0 bridge port case? If as you say, the switch must have
> > the VID in the VLAN table to send the packet to the CPU, what is
> > different when that port is under a VLAN-unaware bridge such that this
> > presumably does work?
> 
> It is not different, and it does not work. A tagged frame whose VID is
> not in the table dies the same way when the port is under a
> VLAN-unaware bridge; this hardware cannot do transparent tagged
> bridging since the same v5.15 change. Jonas observed the same
> limitation earlier in this thread from the other direction: on the
> chips where standalone RX still works, forwarding tagged frames
> between ports does not.

I fail to see how commit 06cfb2df7eb0 ("net: dsa: don't advertise
'rx-vlan-filter' when not needed") could have caused a regression in
VLAN-unaware bridging on your b53 switch. Only perhaps if VLAN-unaware
traffic worked by coincidence. If the switch drops packets with an
unmapped arbitrary VID=1234, it would do so regardless of whether
'rx-vlan-filter' is advertised or not - unless VID=1234 is not arbitrary
but was programmed somehow by higher layers. Which is *not* a
requirement for VLAN-unaware bridging.

> 
> The reason the fix scopes to standalone ports is that they have a
> finite, well-defined VID source: the 8021q uppers, reported through
> the feature bit. A VLAN-unaware bridge has no such source; making it
> transparent would mean programming the whole VID space, which is the
> several-seconds-per-toggle variant Jonas measured and rejected in the
> first thread. So the series fixes the reported regression, the
> standalone PPPoE/upper case, and does not pretend to fix transparent
> tagged bridging, which this hardware has not done since v5.15 either.
> 
> > If there is a problem with the vlan_filtering_is_global +
> > needs_standalone_vlan_filtering combination, then hellcreek also suffers
> > from it, because it does set both flags as well.
> 
> You are right, and the commit message argues this badly; I will reword
> it if a v2 is wanted. vlan_filtering_is_global is not the
> differentiator, hellcreek sets it too. The difference is what the
> forced vlan_filtering=1 means for each driver. For hellcreek,
> switch-wide VLAN awareness is the intended operating state; its
> standalone traffic depends on filtering being on, and hellcreek.c
> documents that unmanaged setups are not supported. The forced flip
> lands it in the state it wants. For b53, vlan_filtering=1 is a
> different user-visible mode for every port on the switch: untagged
> frames become PVID-classified against the table, egress untagging
> applies, unknown VIDs are dropped at ingress. Forcing that globally
> because one port left a VLAN-unaware bridge would change the behaviour
> of every other port, including members of VLAN-unaware bridges that
> expect transparent operation.

..which you just said earlier that they don't work either way?!

> b53 needs the VIDs delivered while vlan_filtering stays wherever the
> user put it, which is the narrower flag.

Sorry, but I'm not able to make any sense of this explanation.

The only distinction I'm seeing is that in hellcreek, VLAN-unaware mode
works, and in your b53 model it doesn't.

> > Why can't standalone ports tolerate the .port_vlan_filtering() call?
> 
> They do tolerate and still receive it: the ds->ops->port_vlan_filtering
> call is unchanged, b53 sees every toggle and rebuilds its hardware
> state from its own records.

Ok, my mistake.

> What the flag skips is only the core's
> dsa_user_manage_vlan_filtering(), whose two jobs are wrong for a
> switch whose feature bit is permanently on. On the way to
> vlan_filtering=1 it replays VIDs that were never cleared, so
> vlan_vid_add() refcounts every upper VID twice.

You are really explaining here what is needed for your hack to work, not
why your hack is needed.

You need to skip dsa_user_manage_vlan_filtering() because you want to
keep VLAN filters you need while lying to higher layers that you don't
need them. Just saying that you do need them and refusing to operate
otherwise is much more straightforward.

> On the way to 0 it
> clears the VIDs and drops NETIF_F_HW_VLAN_CTAG_FILTER on a port that
> happens to be bridged at toggle time; I measured that case on the
> RT-N18U: after the port later leaves the bridge, its uppers stay dead
> until reboot, because nothing re-offloads them once the feature bit is
> gone.

With vlan_filtering/NETIF_F_HW_VLAN_CTAG_FILTER set to 0, no one *has*
to reoffload the VLAN filters, because the hardware shouldn't need them.
Try the VID=1234 case with 2 veth interfaces in a software VLAN-unaware
bridge.

> With the skip, both effects are gone and the driver derives the
> hardware state from the flip itself. hellcreek does not set the new
> flag, so its path through dsa_user_manage_vlan_filtering() is
> unchanged.
> 
> Best regards,
> Semih

Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16F42AFA7
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014932; cv=none; b=vAQEVSJ3orq9i0P3IMd6BussuGfLhjh8GDv3AxSKJvpnZq7lXyuwF8KJScfafO4BpBGcGO7pXkn7LZMngbE/9tIInWdDMTWi7sKC1gMP/MUb/GOewfhzDCp6vKu1ZbICCwgXNc6xd4xhSijsSU4dSUBf4ykJBy5HwPnCDk2mykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014932; c=relaxed/simple;
	bh=iN8EWmEjJXaX2ge3xTz7IJX5lu/e440bMAEXubYhQ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfPboa+Mz3Z5QQEChPrLRg1eRyyb5KMQIMdp/4df+yc1qlC4ublqpzMS3bifE10cg8x8m57AGKsAcddJTamN3tvvLm+eW/gumDrK9ZccdzaJ9TRT8eToahYMu6XgQh725aEupRUd1XbcNeQxcPNPBsAPEu53a9ry9rjxHEuAabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHwY99fp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHwY99fp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4994d41ceb9so2344385e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014927; x=1786619727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ucQVxY7Ip/OXB41QE9U0rwI6FZtaUd53QMHB1zAuAaU=;
        b=HHwY99fpGo5J1kXTH83AvCR55t88s7nlOC5HbJHjPHrxLKVC3Lyre7dSWgUnreuGpC
         QKr8l77C3uoRcH4mu5FP3yYyuFG+AWdIYScD4vbpORbjI271QjhANQW+ttA/HNAuFT/9
         qt3GhroMWzf7OqrC7VX9tQ5ik8JI/2eXFLzbiAcQ589mhyR+wdlWj9nUz786mSu4KNcJ
         MqKvS+mewwrurizzkR9iyO7xiRXXPU+JZu/ohCs6okjp4eJzc+ddWkqoLko/SgMhfO0w
         MiD3CIz5YB8A1d4JzqVQ5LmJFeygyBcXj/C6v8ht0d1qcfUPmng51+aSi7wS0Hc9s2XL
         2BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014927; x=1786619727;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucQVxY7Ip/OXB41QE9U0rwI6FZtaUd53QMHB1zAuAaU=;
        b=qPPdajOe1d/QEY3RgKvavAF03Qegfz5bxaRU80sQcKMPKi68p0swxX/YwFLODQDXlG
         jK6RD2mUaYr/32P711ebeKlKL1iWNO/JWLUxLPyYF2kVeSYpfrQVRNx/1gTUEzMvXCeR
         2VurpRM+5F7YAaqGe0wqjU1ks1GiFjv9COzZwnYQ01CaoXAEx5Kj7VW6fdHerL8RFvLK
         GwqPySVv4ut0NkCinFg5IHc2oBJpP+pz7vEKNGVYFftzOWO4G0q9hknPawooEcvFxg6q
         SIllFLa8mEI7e6k1lSZYfZiN5DRqVmKUfqgsXDHwrAgDfLU4zVTVtkCbgzf0tNQ1XYZn
         nibA==
X-Forwarded-Encrypted: i=1; AHgh+RpYqtgirnhanArXQiylBwBvF0mAAvuBbrywnBZG19qbD/jiik/57O6pWnhbKsBh2iEqgGdnKYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcvGxesDfPRn4QxYyxuV5f5tw5usu6QCEIrjxEhKmxnSB+c75
	zOSh0LMucaxk+5ClFgMNJHY5++Ivxz8Gxowt6bIWS4tGMoWwnY0a47c2
X-Gm-Gg: AR+sD11ERJ9PnweYkOQcvLyj7wYB0JcIjwe9LJ6D90EWdky1cGqjSY77iZxaIBCLDQl
	7AFCnC9uLd4wg4T1FF+IVKO95RkpHeUTRiprosj4TH7+r5PtXkBfqeAqk4FCXZdW8rq5jOCGeVa
	L40vxVfzheI6RIKZE1F4fke0pjolyp8kDd+PZ12sEqMgzKscQBneyq5MsilSF6QdGGAwqGp4RtT
	Dixt2zu5zhv6YyozZLLf7uTyIdVuKyySB44w5/fXJY9gYDSED7IQ7hSiG9oDrS3/yZyDnMLy6jj
	QQaH+5XVuRjWDt/AmTXc0C9/DeZTgXYHGA4PC6LVSSzfNAYrnL3mIPnf6Z1A6nqBS4vHox16zab
	c1yPKjwvaVf8tAgQJQS/V8ZBeKDI5EaR6C6n8AHpUn11a6w8h4aL3Xx5aVs3tvqji2viegEpNuz
	2bxoUlqVlaiS9AHC1BiGn98G8SCURmd9O0qF7WMu7Wa0nU/1lB21+XGYUqIY/BD/c=
X-Received: by 2002:a05:600c:b85:b0:495:4505:dad0 with SMTP id 5b1f17b1804b1-4994e7ba5efmr100741165e9.2.1786014927022;
        Thu, 06 Aug 2026 04:15:27 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d801:b100:3c1b:726e:a458:5bcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf820sm95229065e9.0.2026.08.06.04.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:15:25 -0700 (PDT)
Date: Thu, 6 Aug 2026 14:15:23 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Semih Baskan <strst.gs@gmail.com>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
Message-ID: <20260806111523.gjlhjfmb526f2y4g@skbuf>
References: <20260806073119.387-1-strst.gs@gmail.com>
 <20260806073119.387-2-strst.gs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806073119.387-2-strst.gs@gmail.com>

On Thu, Aug 06, 2026 at 10:31:18AM +0300, Semih Baskan wrote:
> Some switches cannot deliver a tagged frame to the CPU while its VID is
> absent from the VLAN table, not even with VLAN filtering turned off.
> b53 is one of them: its VID lookup is always active, and disabling it
> moves the ARL to shared VLAN learning, where ARL operations force VID 0
> and the hardware table drifts away from the bridge fdb. On such
> hardware a standalone port can only receive the traffic of its 8021q
> uppers if their VIDs are programmed into the table.

Then their "vlan_filtering off" implementation is broken.

BTW, how is the "standalone port" behaviour different than the
vlan_filtering=0 bridge port case? If as you say, the switch must have
the VID in the VLAN table to send the packet to the CPU, what is
different when that port is under a VLAN-unaware bridge such that this
presumably does work?

> The existing opt-in for this class of problem,
> ds->needs_standalone_vlan_filtering, delivers those VIDs but does more:
> dsa_port_reset_vlan_filtering() also forces vlan_filtering=1 on a port
> that leaves a VLAN-unaware bridge. hellcreek wants exactly that. b53
> must not have it, because it sets vlan_filtering_is_global, so the
> forced flip would turn the whole switch into a VLAN filtering device
> the first time any port leaves a VLAN-unaware bridge and change
> behaviour for every other port.

If there is a problem with the vlan_filtering_is_global +
needs_standalone_vlan_filtering combination, then hellcreek also suffers
from it, because it does set both flags as well.

> Add ds->needs_standalone_vlan_offload for the narrower need. It
> advertises NETIF_F_HW_VLAN_CTAG_FILTER on user ports, so the 8021q
> layer reports upper VIDs to .port_vlan_add, and it leaves the
> vlan_filtering state alone.
> 
> Upper offload of such a switch never depends on vlan_filtering: every
> VID was already delivered when the upper was created, since the
> feature bit is always on. dsa_port_vlan_filtering() therefore skips
> its ports entirely when a bridge toggles VLAN awareness. Restoring
> them on the way up would add VIDs that were never cleared, and
> clearing them on the way down would strip the driver's record of a
> bridged port's uppers and the feature bit, leaving a port that later
> leaves the bridge with uppers that cannot receive and no way to
> re-offload them. The conduit change path keeps its explicit teardown
> and restore of standalone VLANs, and now also runs it for a standalone
> port of such a switch while VLAN filtering is off, because that port
> has VLANs on the CPU port too.

I don't really understand the rest of the explanation for the "narrower
need", as it relies on the false fact that hellcreek is somehow not in
the same boat.

Why can't standalone ports tolerate the .port_vlan_filtering() call?

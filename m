Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C6471D1E
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016698; cv=pass; b=lhwE5Z+5Zqnx7fd0KtiOg4w69qehiG4p+gACePTYPdnd1S6eGKR+1apzkyrmpPkeJLDAP5iLhtqMEei+uNw6rjffSNItMtb93YhSUJsoV4eR/w1jVibohhsxcoDxvbr0+lh+l1azWVXlBVuHLxVyl5CLrpdibZIUwxiY8xBIJBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016698; c=relaxed/simple;
	bh=AUxgG1Ig6Ovtxh4RzkpXp3mi3TLTHszOIpuoo0+1H0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW17FWPPglLiVyr5U8b8GIQ1j9YjNfHIqFxygu2/uBrmaauX11pgQtdFHK/kl13nRpanng7vIgEzR/iaVAafH7GZBEJpRHkHL5b432PSrAmsor8US37faFrCrQ4IPfK7hgtErnklY11FTBfhvxLgr9JRacy+ewBKy7NG4GASDkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIYloeNH; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIYloeNH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceaf8a1265so31700295ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 04:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786016696; cv=none;
        d=google.com; s=arc-20260327;
        b=eDB2FLkTFPHOKILMh6WdXRc3SAv1c6S5g10Q6fb0+NxRYJwew5/D9KoVDdOsr6k8FL
         S8X8dQa/gX1IlX8zqGsxW3bOluOpXj8kawMKV4asWleN6bkDoKOQ4vF9BXACtwWWlNFo
         fGJy/eoz5kvfDWDSsMQWHTXZQ77otKfA+mi3eg/k207HE9bf90aFk5PcA+HV/2Hn268M
         UWc+RaBJYVBaIx2yyNT/+E+PpoYKUYkLemntx5tWNiOAkgbogungES9yJYOItCYzBERY
         yrnnLQB23tEheIRpHlFGPHguYAH9GwsX92rGos0/R7r5Slv78+Q1OWGYxQOwKRKCK3vK
         4qhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AUxgG1Ig6Ovtxh4RzkpXp3mi3TLTHszOIpuoo0+1H0U=;
        fh=Znq4fw4ZkK0+0DLTeWe3HIuD4AQ8LVagr9Azjf0hWyI=;
        b=O18Zu3u+UN7dDv54o/LJp4dPhcl/FP1WAhN0OCNFT4pJr2M8FkPKMTIHPVb/le3bSB
         MOWgJn4m0oGGfmG2oxOGUgVRDee79qS0BiKz9gNDzIZHB6LejWmX8yt9e77l+WtsZP1C
         gchac8SAHbMzHvgnFsygXGhlkhN9UBWK+I9iZB/yeLo8RRn/4cWHrtUeV/1Occy9Udt5
         ZpNZfvRathZpvEFJKgMu3JPl4zZPen85Q0/VO5Q4W7p6b2S7DnuLH+YLPxlnvfO+C0DC
         /65KYnH98NHIMzBnJWH2BkhaGuFPxGTswG5naiEoeczgAulR7pMux5cyR+HtMt/2ogOy
         +caQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786016696; x=1786621496; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUxgG1Ig6Ovtxh4RzkpXp3mi3TLTHszOIpuoo0+1H0U=;
        b=iIYloeNHZmrLymD/tARTUnyq7nPaQmB7ksENOREjleHCntlD6edXdy0ORiingIQbCa
         8f5061/TwnicKbv0Jm8npdnv3l2pdEH/NVtgUORbuPDSYIBB+vNeo/g0aepn2dyyyggy
         WvTv64VTnffvdAlUeB9qtmEWwjkyS6BqRAcLEXMIxKl1vW6s2qOhvHYjSTBqt8MCb1vC
         WHOEQWHXJyrOuz509XVNFwlwYOI99WxlUGsMJxhfNv5d9TTo8+wgFQcq65J42dEsa0P8
         53zeY3cf0h8p3bL+dQ2TGlHDcDHdo9bpCd3z9WLrGXlwuBIMr/hO6Gl0ez2ovcNJNUoH
         l34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786016696; x=1786621496;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AUxgG1Ig6Ovtxh4RzkpXp3mi3TLTHszOIpuoo0+1H0U=;
        b=Mrwg+ys/o47jYkohVAXqYaNa++YbaqmJD+LPYgE7CoFCw6fDs2GEtWaO+8TKh8A62a
         8hfuQAZP2gurCBlDFN83H1CVXTqGiWN7gmeSnd4xN28ncr0pMBt0uD+fR1ZFlEmjAA+r
         kXPWVJKVdGRiZ14jThLoGYQAoml9DEKmx7m57ekR6RtUwHt3rRfa0yrb1Clx05t2oUjG
         LR9Y5d6TogPIBu9rI9CE2Pt9V02UYYlZPI/FTcd+E0D4zVfqR30PNWk8rKT8PmkJ8InV
         76PbgdBFOKt/JvKgVtnhe8fHIQ5+iH3IZcn5ZJPXOtfoGALdTc7+VwKg/jC6Twjl7wAV
         yjVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXUY39nzcduqdP21Nlirau0K7o2n+jt3MEoNzajUqchkEhBa7bejrv3AKdsnH6GsGSLRwLtxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywse74N66ZsWbvAJ6DAK79ZcMmXjCCVGzN31SkPyCRTqS4DLq0M
	WumrCXzB1zP38w53yOIn0SR3KKyIBUfQMAK8uBNGlrDKgS+LxJBKahQuqKINBC3myLwVw3RTyeB
	JMJx0BqSyesmWDQXPAthRwrQAdv4VV8M=
X-Gm-Gg: AR+sD12RvFxtgCy3+6kAatdisf2gHC6Bc6NdtHpXNJr76D5S1rn7TW8L/ynR0nsHcyD
	t5ebvpw/ml+S8641cf6u1wIycoZT8qze1z+XVaXmA7Z6kiCsryrKpRFypQolQoe5KbD+gxlGvYe
	fm7eE2iVC0SUpmqcvy8cy9Cp325wOpcHRXG3/ZN0czWkVsUx9Y94RwFR26SsQrwWxWSHQ3be2t2
	hqlbsFJCzlRZ0OL+GxHaIhms2mIhax/mr24Vjd787slTKCkAEf26KOZPJ15m5d/+jcpP27QvDhM
	QMGr5m400f3zWl9XcFhsRhRQL47MFgxjvL8qVDpOpO7ZPyGb0lor6wMncg==
X-Received: by 2002:a17:902:f605:b0:2c6:9f66:d573 with SMTP id
 d9443c01a7336-2d0ca71b3f0mr180101105ad.2.1786016695873; Thu, 06 Aug 2026
 04:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806073119.387-1-strst.gs@gmail.com> <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf>
In-Reply-To: <20260806111523.gjlhjfmb526f2y4g@skbuf>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 6 Aug 2026 14:44:44 +0300
X-Gm-Features: AUfX_mwHP697PP4AGGxhxU3Vfygk5y6Zd4Szc3bdootKBhEca3ZtrRhRfZuUozo
Message-ID: <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> Then their "vlan_filtering off" implementation is broken.

In the sense that the hardware cannot forward an arbitrary tagged frame
transparently while the table is active, and the table cannot be
deactivated without the ARL cost from the other subthread, yes. The
flag exists so the driver can compensate for exactly that.

> BTW, how is the "standalone port" behaviour different than the
> vlan_filtering=0 bridge port case? If as you say, the switch must have
> the VID in the VLAN table to send the packet to the CPU, what is
> different when that port is under a VLAN-unaware bridge such that this
> presumably does work?

It is not different, and it does not work. A tagged frame whose VID is
not in the table dies the same way when the port is under a
VLAN-unaware bridge; this hardware cannot do transparent tagged
bridging since the same v5.15 change. Jonas observed the same
limitation earlier in this thread from the other direction: on the
chips where standalone RX still works, forwarding tagged frames
between ports does not.

The reason the fix scopes to standalone ports is that they have a
finite, well-defined VID source: the 8021q uppers, reported through
the feature bit. A VLAN-unaware bridge has no such source; making it
transparent would mean programming the whole VID space, which is the
several-seconds-per-toggle variant Jonas measured and rejected in the
first thread. So the series fixes the reported regression, the
standalone PPPoE/upper case, and does not pretend to fix transparent
tagged bridging, which this hardware has not done since v5.15 either.

> If there is a problem with the vlan_filtering_is_global +
> needs_standalone_vlan_filtering combination, then hellcreek also suffers
> from it, because it does set both flags as well.

You are right, and the commit message argues this badly; I will reword
it if a v2 is wanted. vlan_filtering_is_global is not the
differentiator, hellcreek sets it too. The difference is what the
forced vlan_filtering=1 means for each driver. For hellcreek,
switch-wide VLAN awareness is the intended operating state; its
standalone traffic depends on filtering being on, and hellcreek.c
documents that unmanaged setups are not supported. The forced flip
lands it in the state it wants. For b53, vlan_filtering=1 is a
different user-visible mode for every port on the switch: untagged
frames become PVID-classified against the table, egress untagging
applies, unknown VIDs are dropped at ingress. Forcing that globally
because one port left a VLAN-unaware bridge would change the behaviour
of every other port, including members of VLAN-unaware bridges that
expect transparent operation. b53 needs the VIDs delivered while
vlan_filtering stays wherever the user put it, which is the narrower
flag.

> Why can't standalone ports tolerate the .port_vlan_filtering() call?

They do tolerate and still receive it: the ds->ops->port_vlan_filtering
call is unchanged, b53 sees every toggle and rebuilds its hardware
state from its own records. What the flag skips is only the core's
dsa_user_manage_vlan_filtering(), whose two jobs are wrong for a
switch whose feature bit is permanently on. On the way to
vlan_filtering=1 it replays VIDs that were never cleared, so
vlan_vid_add() refcounts every upper VID twice. On the way to 0 it
clears the VIDs and drops NETIF_F_HW_VLAN_CTAG_FILTER on a port that
happens to be bridged at toggle time; I measured that case on the
RT-N18U: after the port later leaves the bridge, its uppers stay dead
until reboot, because nothing re-offloads them once the feature bit is
gone. With the skip, both effects are gone and the driver derives the
hardware state from the flip itself. hellcreek does not set the new
flag, so its path through dsa_user_manage_vlan_filtering() is
unchanged.

Best regards,
Semih

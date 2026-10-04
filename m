Received: from mail-vs2-f20.google.com (mail-vs2-f20.google.com [74.125.227.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262A3FFFA7
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791141037; cv=pass; b=NdrRj90vfkx+QoZlnZDxyxQmWRxtlIJDeKA4alvPY4glKv9FsB87U+tPkzkc5U58KIeTlmt/umDIXaWHikJIcninbTdPyerhAoBVNxEIsHHEU17vMkrM2eMwzB4291w46kj6XqefiRdtqTe+2vcPI9jMuOb/b1dK4baseIN4SOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791141037; c=relaxed/simple;
	bh=z4KDwGSCeUl6OO60pOlQkNnNe+e6ge5EX8bgo8KStA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf/bL8ldlOMIs14w2A9uV67TSrFIcZvaifZQ/PEs7d1+vHuzpba4YRyoAP7+zrpWQJRxi7KclO3W7ZxXTBA7KXZ8axiZrMJqerrbvWoPfJKwtNHlKy8B+UkZ/F/xMLncjb0Bczn2lcrqJ0CV1KLXKl70gOix+M9FRcmksFm5iLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azmJ86dj; arc=pass smtp.client-ip=74.125.227.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azmJ86dj"
Received: by mail-vs2-f20.google.com with SMTP id ada2fe7eead31-7ba99a2e56dso206967137.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 12:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791141034; cv=none;
        d=google.com; s=arc-20260327;
        b=nrs303Q+pnSLbs58r7ULHr+pPBJim7LZoYVUh+lqVvea8DpJDFZHYv+lPDcVHU1+b0
         o1jb8h7aGmflxBN0UNKP/YH3YmvWffu6dvROGE7BhCDRtrDhHWfAIi2ZVXjDsL5kgI/5
         +y+0j5U7J2+f8YulF1tUT6VYcfZtzzYq0e49+jQ7M8Tn3Sc9Zf9cMip3w2VkNjtCDh+2
         y79xAn0yo8eRgO8j53iuiTBL5O0hStMaaSbqMRwujv1hLbmYHcWNY8FKC8NFCM3MtpAa
         cXZadDXs5m6UXAfQdADMD/P7DmwTigSfLkBdWIunzNi+zaCMM0iTEOaGhILbwEVI875r
         jTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xkZNnkM2zHQpEZqhgoebCPzMrZI5v2FZv8Rlnaa+Lhw=;
        fh=zT239D3uluY0S4SaxSt6v9qsARJBm0AH8ZIzY6AOLC8=;
        b=RS9JgEcMSZPSNe1c43KtFY3HuHvIJh5JbT27UKomhPsG8Zi3ExNR6+Y4/2O56iuDZl
         GkpMhHSjXfjq5qIyq3nfNhrbgIvTcOEbV2cZb8c6S7/yHp+OrECP1RFXZci1a2rSPrdC
         wxChFX6Ujhya/VKDffSh03R5ga/h/3TFKFhR8+H1oRJIqe7JGSXACOYol/i4OC4L/5PA
         ZKBR/2ReB4S3dTvS+FhYl4x60HL3FROWryOLgJZGSppYg/0ZTUD08F3xjd5uGN1NfCfz
         qrMb07mo0ggFNVeKP8plQ3h8EgFrGHm5Xho9TRILmpEjlRSlBlzdxG2y0xNQ13eIRYe8
         z4Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791141034; x=1791745834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xkZNnkM2zHQpEZqhgoebCPzMrZI5v2FZv8Rlnaa+Lhw=;
        b=azmJ86djbSt3sBvvtqyEcjmK39zF85f4M9bUnxi9mUUeM/hr0dDPefKZiljTxy19xk
         HwynE6c+zk4Yhhh9btgLRgV9/Xvn4zKg0L0Y8SkS/853a5SAnttxlXr+VCsURtx1oUFt
         eVhdW+ViZA1DrlqD7TZjs069rbiprVMflyvUr9Qf5T+65w/s0RkWxhUTKcco/PwnrE/n
         aSicfbvGHuXa08nd3g2ELzE27r6tptaUFEFbpKNHCvmhDsm0/qzRNL96ef5k7JoO7kad
         vMQRWDacHdWByEActGgEpbDdPogJcjzKYkFB1p4+06zMLKQ7IQrJ/g94IvigrLIMXoxL
         SdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791141034; x=1791745834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkZNnkM2zHQpEZqhgoebCPzMrZI5v2FZv8Rlnaa+Lhw=;
        b=BnTmajS3Ej7T2BTc+dnlOV00eiB9cPqQFyoRl1uQUeBvYNwSTSCirDM+/9u3lXAigw
         soSm6wKvMjgnfcFQ3+UmTQ3ynB0Q+cq3vKUIzGsjLEDbdscu48xVB9huFW+qyCL/83JV
         ScfZXTHGLe3Pk0P7tlf+5pBHEhQu7pxyeMxtU+gr1cDP2q3LeD4jqa9AyZ2pxBUJOyll
         UMPdJ/wQy7sIQmAWYK9ICVDBB9epzfcpInRCkdgNGyW4b6/D4gZu7luD89JPnS1ojZj9
         T9qTDrS456j5mj5IXbS1xIDE1ItmFGFSm3LOel/8YPTW7xAc1ZLBxwSAEGkOQs6D95gW
         L1qw==
X-Gm-Message-State: AFq9FYLKQms8Q6S+Da3A7ikQb2DtcoHUDZv7OWGdJ83lNfbohqwxDXcE
	cCY6O5vaWFGYzwHO5Sz2BEVqMcZTmfLnnP4B+KBvs51L+Frpj9nHPZNlOd2lRnxKsjYgN0uJM7T
	I0+AVVfa80DtJGoaxchywvrw5gZlcilE=
X-Gm-Gg: AYBFou1GdajLu2J0OdMfe8MoJ42dXlYaiceQq5Il1jyYvLSSaUsDfRtENRaAZN8t4Kq
	jf0VuB3t3SyJJzThg5unai4Sz6c9ahKNzrRcg3AsT/8EK5rk0v+9uTZWZeEG6etSU1NFImIgkLp
	WMbGnIHgDiyFCopr7M31neqvhNp40npyCdh+UMUqLamKa7roeNbVFS1AA62wSDviHQhPGg9HBFM
	Mu0LcoeuvCCCe6OiA0pGjQxnjzo8aVsIlsR6ECIi4gvHymp1PWPLXQjdHokOPNPySlXf7JGeIN9
	wwif31VvD0VdyJ17sANVUCKJhQX61ycoiC0R0QZGdPUED+21w20Ulf7+XY2whie2yR6bV8gP6n7
	NZ08aK7wcWdrDndhMraeb9B+JO6jKKbST3wpFCIfMI5D+bvGhg6Wn2acx/JWHKEuf1qC3wlb5I/
	dAV0JT6O5mZBL+I+ncI/LB53+XXbSNrVSrLiRwwLOeiUN5
X-Received: by 2002:a05:6102:ac7:b0:7c1:b55d:373c with SMTP id
 ada2fe7eead31-7c1b55d5b1amr1023105137.31.1791141034613; Sun, 04 Oct 2026
 12:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b@gmail.com>
 <04e29fa0-3ff9-4248-bfe1-87dfe8ce3ec3@lunn.ch>
In-Reply-To: <04e29fa0-3ff9-4248-bfe1-87dfe8ce3ec3@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 4 Oct 2026 13:10:23 -0600
X-Gm-Features: AclHuK_y06FW1116Mu5hZ1KX5sWXMaJ-6Dz8hI1d53uu8GYrxhRaXRuilJzrS9U
Message-ID: <CADvTj4rm0h0iy7vHsdxc4zQGuybjUvGFqVqrHOn7r2O1z+OWoQ@mail.gmail.com>
Subject: Re: [PATCH net] net: phylink: allow stopping a suspended instance
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 7:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Oct 01, 2026 at 01:24:53AM -0600, James Hilliard wrote:
> > After a failed MAC resume, a driver must be able to stop phylink withou=
t
> > resuming it and reconfiguring the failed MAC.
>
> This is adding a lot of complexity, for an edge case, which i don't
> particularly like.
>
> In your case, why is resume failing?

This is a prerequisite for the stmmac recovery fixes, rather than a
fix for the underlying cause of a particular resume failure.

stmmac_resume() already returns an error if stmmac_hw_setup() fails,
for example when the DMA reset does not complete. That return is
before phylink_resume(), leaving phylink suspended.

The stmmac recovery work preserves the interface's administrative
state after that failure, but leaves the datapath detached and
quiescent. An ordinary down/up must then be able to release the
retained resources and attempt a fresh open. Closing the interface
therefore needs to terminate the suspended phylink instance.

Calling phylink_resume() merely to make phylink_stop() usable would
reconfigure the MAC and restart link resolution, even though MAC
setup has just failed.

The additional bookkeeping handles the two different suspend paths:
with MAC WoL, stop must finish the deferred link-down and clear the
WoL disable state; without MAC WoL, suspend has already stopped the
instance, so stop must avoid repeating that shutdown. Suspend-owned
PHY speed changes also need unwinding so the next start does not
retain the reduced advertisement.

Those are phylink-owned transitions which stmmac cannot complete
itself. The driver still owns the recovery policy and any fix for
the underlying resume failure; this supplies the cleanup transition
needed when restoration fails.

>
>    Andrew

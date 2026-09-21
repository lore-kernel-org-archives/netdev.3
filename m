Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7C336654F
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023411; cv=pass; b=smYwl5j93XhtMS76pDU+SMMhisSepQybWtDQ0ekGMNT6VsDGFzCbWQ93cqHfNT4DeBmSuqvtRYtA1aFt5ED4ocVzc2+H9Tchv7Tkkf/9L2refH1se3wb8c2RlFsHx2oRYmm3Vez9gRvvMThJ7B3+hD7Byp5HZCxPGLa15Coa9o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023411; c=relaxed/simple;
	bh=2AqOeRbrkTEeKxz/VGkXBEycMszwg20ujuSANUVGQhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6FLJQvgzWdF6iqzIQYJBIpXPKAkLGZ0v3YHt8tbG56GGv5YuibX6hErmTeKB1npzEqms0i++jsQwqQrEutJXRJPh2QAvhKTKxFjst3haXnnZtWOABotaX6TkUK+9C/pCX0Xo4Ea0Q9u1Ik1ZmHQaJB7rCxFD6xYqCIvGaehbtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoDPnoOR; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoDPnoOR"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b8997bc6e6so206388e87.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790023407; cv=none;
        d=google.com; s=arc-20260327;
        b=fNmWPiQkgzaaouyaOpkgUxBCoDp18WO/2QWbshrTb6PCdyr9zt3SuUra/IiIydJxrN
         7iMWkh10SCsPc561KWAvYIp0j/hhEoqrL1IAVPyHGwOc1soWVdPnKdrO3KLBlAayN9J/
         nHXw0RTHG9TZ2eRykc2ycZllzZwyu75n8ztMqmznRkZTv5vkRBkZEP0Rbh48kdqFE9Zd
         UXi+HsmxB0Rr7JW/hW8Jl3HKZ5UyB0KXngB71cyPvMf7OPFUJQD4DheCxV+GmhOeLpwd
         eHd86hcOUNK46MM4SjBxeYECjwvEErAmCiHXyngSw6STvMHAQFKViB0DSaaXovab/K72
         A3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2AqOeRbrkTEeKxz/VGkXBEycMszwg20ujuSANUVGQhE=;
        fh=1GaSuDKV/nrXJ2i8CwULLyELHfalGK+i4z7y+gQAKwQ=;
        b=QzIs3Z3Ywawl0mIFaKa47EjmJlzlBImEGQsWoeTkVa9CE6PmJPRfz/9+zZX5iHTkT4
         841Vo0RdEq8wG0WxKHcOl5GmDj6qS8lMZpYUCKNLJzpxMWKW7gbx/DmyILMoOzqKONQz
         bOP8K4/aTMrmyiMd2a1Cyp8JmBZTLPRU5x9Br4gt74t0C6ZmL33rvL3FLSzImB7fmGZl
         /6JvrOVHchoJdbzTuhMbDKfEAUHAzr3cs//RwTAnfJAV67i33/xArppesgHthH5Pt+4N
         Kd0hBazGaW4qo8HQD0WQhoEf43F9diOsuO4xpnWXMHvDhyPMC+CZuc/zA+XirPNVTIRH
         XYGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023407; x=1790628207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2AqOeRbrkTEeKxz/VGkXBEycMszwg20ujuSANUVGQhE=;
        b=GoDPnoORyycuUdelfqd5OUIt9Se3EY0kad14vH+3MD9E/20H7L/wdsYHd24C8ClAvV
         dM7NFhJkr1BeTJiuJnk++grbqDbfeZR9Aw46iFe134DoVtaTCnmU5PIxjJrGXeG2B3zu
         9u5im+PChGZdYlopb8xds10brRi/yTw/Im7jiQtfHYkAy7G6EnyzZvYCJA4D756Xbuzs
         kIyGDMd1FkXNyyOpVOy+s2fMqs37g83RUm0I8KJaOCPeX3x2mTWQzG4hCPPCiwwb7zsF
         gHwUJF1Kd4AkTFiIRucvciLmq0NHn4oUWNethsE1VOdnQGbYigQlfiLQyX6wMEidP6jW
         fDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023407; x=1790628207;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2AqOeRbrkTEeKxz/VGkXBEycMszwg20ujuSANUVGQhE=;
        b=l4O9z2og+f/yFhijS2hunF6gvONVndCF4BYG5nCqiG9niz2ZxxdbsCbvGoTyEgDh7r
         RL4tNALgCqzWHn+78yrQL+UiFsD7JNxeXDt2aHVsoTVPa+yeFBaEWgMD38PXkI39oxNs
         N+HgfLqFFTkcg0Ym4tJAQd0icH+fMuHoRgbFnZBKP19GrImD7yB5z+vSnJtNIErFkUQQ
         VP9qtViDx6JnKjX+N4CCOo72YLt2unZBrBPFs8bnot8mE5lGpwo/5feRpB8aOk57VQTn
         mreMQ0geizQKsy7cBllSW4QF9iZ7PryUHejoAcid8gDkRz8Z2H17YtupJLvuiNXw43F9
         3+EA==
X-Forwarded-Encrypted: i=1; AKwUvBzwNseCJKXMyUeNqQl8INYK3KI4zCgimKF67j6mE37SoZgpXee+kRfvBcezMyKeHT8h6bcWiic=@vger.kernel.org
X-Gm-Message-State: AFuF++m+gF0eezGvJeJHwEKxObMJuLJYmk7g/yb0uLc6ws9lvl0HKG3E
	nkP8OVRHPQkgdrT1Mq0A48ORdTyPE6PpWC/7gW2OLYDEqEt6VfFfaTJZtJUycIW6oFhcitcJDcg
	DAKkjXeW6IBrAvCiUCpyxxN/k4XuPzZM=
X-Gm-Gg: AYBFou05sY+NtWPwJ9rgBdFbcqHfWlpXsyc/7d0ioZkyQ6TFfI2Iwgm0nvYPL7Gq089
	dwB+TO/BUNiEbivqezXLPcfiDVMPcTO9Bla8E6lEyfiegyMnz2+WF5vxmAWkZnvL0e/HjTPyFI1
	tPNdZnG170pRh7SwfVfiSKuyfL0TUBVL/coVIsCVrSdnTmMCiwiwkHNvDQ4L1OR6+Jqq7zBnENV
	P0aVnfGOGWhK/fq/l9JZ4k+QDWQ9H/+rg4NO+2r+we42ikqwUDC5+a8FiKRO1raZyLiT1WlYyBj
	X+wX09Ko9VCSyGpV0ESz9/jeduXetNVELwlqEMURwfzhArZbHi7+CdRCC2ay/vXpx5Z9Flsdb6p
	q6z4ZHJRBYSot5pNQx6yPjHhYGcvrvCjF9qA29jgg53r6
X-Received: by 2002:a05:6512:3c90:b0:5b8:b392:b401 with SMTP id
 2adb3069b0e04-5b8d28f8740mr203875e87.16.1790023406454; Mon, 21 Sep 2026
 13:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918-fix-macsec-net-v2-1-784203ec4836@gmail.com> <arD488xDvFFwtTTN@krikkit>
In-Reply-To: <arD488xDvFFwtTTN@krikkit>
From: Haseeb Malik <haseebulhaq55@gmail.com>
Date: Mon, 21 Sep 2026 16:43:15 -0400
X-Gm-Features: AcwNN1UVt7aUbP_RA8XzUc4ImBuixAqqs5Pgi8wN_QARDaMYSFlj-pf3Ytt-ASc
Message-ID: <CAB4N2KN-0EpTcU4eWD3hdFN=cM0S6T9UVjmy1URQPjJck8riVg@mail.gmail.com>
Subject: Re: [PATCH net v2] macsec: initialize SecY before registering the netdevice
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Haseeb Malik via B4 Relay <devnull+haseebulhaq55.gmail.com@kernel.org>, 
	felix.walter@cloudandheat.com, edumazet@google.com, 
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, hangbin.liu@linux.dev, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	davem@davemloft.net, syzkaller-bugs@googlegroups.com, 
	syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, you're right. I picked the commit that introduced the warning,
but the initialization order goes back to the original MACsec driver.

Corrected the Fixes tag to c09440f7dcb3 in v3:
https://lore.kernel.org/netdev/20260921-fix-macsec-net-v3-1-accf94f93f5e@gm=
ail.com/

Thanks,
Haseeb

On Mon, Sep 21, 2026 at 5:29=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-09-18, 15:01:29 -0400, Haseeb Malik via B4 Relay wrote:
> > From: Haseeb Malik <haseebulhaq55@gmail.com>
> >
> > Creating a MACsec device with MAC offload over an LRO-capable lower
> > device triggers a warning in rtmsg_ifinfo_build_skb() when IPv4
> > forwarding is enabled by default.
> >
> > register_netdevice() invokes inetdev_init(), which disables LRO and emi=
ts
> > a NETDEV_FEAT_CHANGE notification. This reaches macsec_fill_info() befo=
re
> > macsec_add_dev() initializes the SecY. key_len is still zero, so
> > macsec_fill_info() returns -EMSGSIZE and trips the WARN_ON in
> > rtmsg_ifinfo_build_skb(), even though the skb has enough space.
> >
> > Initialize the SecY and apply the new-link attributes before registrati=
on.
> > Move MAC address inheritance into macsec_newlink() so the SCI can also =
be
> > initialized before registration-time notifications report it. Move the
> > per-CPU statistics and metadata destination allocation into ndo_init(),
> > and release partial allocations on failure.
> >
> > Fixes: ccfdec908922 ("macsec: Add support for GCM-AES-256 cipher suite"=
)
>
> Why this commit? The "register, then init SCI etc" order of operations
> has existed since day 1. Without ccfdec908922 we don't hit the WARN_ON
> in rtmsg_ifinfo_build_skb, but the bit fixed by "Registration can
> notify listeners before returning." would still be bogus.
>
> The patch itself looks ok. Thanks for picking this up, things got
> crazy and I forgot about it.
>
> --
> Sabrina

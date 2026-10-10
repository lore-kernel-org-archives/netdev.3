Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316E2D97B7
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639176; cv=pass; b=FMYL1whK3jbJltC0Td45O4xjd8EVw1ZUh2aBCyAtCos4SYIfKSCeYppXFamIsOg2DqX4f9+kHd0izCdSvs1MOWOf9QdROxbmCNRcfc3SmZj7faRNkGTuGtKPnA/AsyfQ6h7WOJIezbng0OTcISBHWXaBxTmbBQQDE5p6m8GCudk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639176; c=relaxed/simple;
	bh=mtsamemj69B3iRndW+JReJ4MdazWwyBzoeeClqSsfHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMm4Obxgd1bfTbtAm7D8gVhB4SLdNbfePwxwA+KHD6uLHj9i6LgNy++wcJb7cd4Hh7pw7cGjna11KuLiazTJW0slusVIrAhS21ORxwo5uJoV0yGNHI415kmE6snI5mECM7kiYOniWotCYciglRz9nT+t/31Sc5TpEqI6lZxKOBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th08GXw0; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th08GXw0"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a9ad623098so5941021fa.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 06:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791639174; cv=none;
        d=google.com; s=arc-20260327;
        b=WjwzM8FfohdA81XkeqImYeHuF9CnglP2ZuHE5pJagJDOGdunvIhmca8Jgc7Io46E7/
         pbO+81U2+0aDTLT9QBFA8G5aev4MEUyiAQQpSS4Lx5lZgA2izxgpIZYK2vBoznYkO45M
         zrQAY+KSPNi4XFL39bPdbymXoeBD4ULXMcXB6MKqtgN+0KZ5JdOmtACQ1Q7yv8ZovQgF
         b0TriRMHXyU3BRJICeYcRcWDBarcQWk4pamdQB/2Ve6kJaTav8L3eaMxU4kyP20NJjSa
         5P7Tnbd1ggQt/eNBJsAdI63FCm+VAyIzdyBzl9efLlLr2E4F4vG5+x7gaBXhwiJ1JIJJ
         A0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pYVu/5x8kOjkfB1OLFe4Wb0FAXv3rimBPK2ZUX360S0=;
        fh=jCO3E1qmlSyKzLIp3FJfrMaH92BMsNHXgGYHq2p8BZY=;
        b=A9hdfqxBshGDRsp7DYgR2357+HOqSwV7qrsPlsm8nwlL8dkkLFW9QPDLLbkvAx6Xqj
         tjbMSOGD5di35wi0n6Ziwi7IKIC7v/5BnqzN1AMEoJO5D+HtMCbm5R1yeLI/R/O6o1ne
         Y/GMFwMqLvXV/f2bpxgchLbPCde7nUrFONoVhEorfrdXWzPSgkIyOuzNvzs66/XyrDmQ
         FaIyrtCayiTV+GtE4iTOAFAeaw8QQmZz/L0noPH6gXDsh0qf5wSblt8KDODZ91tuWiQZ
         BX44nvMysXAsqpSE28gqCdlRjrBWGZMpqURQhaA0K4bEhd0d5FAAFwo9b18vsiAvx0lg
         jyfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791639174; x=1792243974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYVu/5x8kOjkfB1OLFe4Wb0FAXv3rimBPK2ZUX360S0=;
        b=Th08GXw04g5oyZOZrcolN6lkThyeSPl0uFs26ILwRvrekmRRyU/ak6jLJM+6GPYtVy
         wjg5O0m+/GNnWrRGiPlZYAUiw15NdoT5TwXam9XdcOhy/rQNY/29Tqr7AtUtnZJoVp+U
         Ml6ezJ1q2rFvqi8kWNoiYmDTpJF+M/esoF+IaT+vimu9y8wu+kayoSOJ55OkDQSei1W7
         WUDnx2hR/Zs1EulcVkkhMUt/ExN/VC3PJpXCZ37leVxP5vbP4ssU6AsKvKWIUablkjCf
         3EwdwDIwaLNqQ+9gOH1cA0n13/pW55YRnhaaPylYTl3dTZ/0gTzMMBStVWX58ZZ+3yIX
         2OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791639174; x=1792243974;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pYVu/5x8kOjkfB1OLFe4Wb0FAXv3rimBPK2ZUX360S0=;
        b=ZzRwvfsOa/+lZGtouDUEQhYNIssgaEnNtXCilsm09WYe4Eus3TmREWzWPmNgMjVKod
         bqE2pmeKSHsItj9IQhk9YJg5srAi2nufs+hOLTbjHEZ/MmXEjunnxqoYNPxGTKMHAiQV
         ievpgXGP3ANceEl1/ycb4fzKLFFYVQ82pkM1sCKyoAgAzVW5kTe9T6eWN9MCle7Xrhgd
         dt4O6XUKMogbfbhSm+zKwKfI8QIzsL5/RTkvyxqRVYmUHF9XrCtUJ9o3hHXuq6h+Vy8Z
         fdl3ci1vPcybfn44Ml75OPvY19qih5y/ib+NriP40X1Ul/8H69qJ1HcEAgV+foQpxDMF
         hN6g==
X-Forwarded-Encrypted: i=1; AKwUvByPOgDjThxMCCUYJbCopQ0GrRv+Q0zlKe60ohJJHbekM09GEhR8mQurnkZj9egYZnikIrD34ck=@vger.kernel.org
X-Gm-Message-State: AFq9FYJE4vEUMdl3dgfd3c3vIZzpHjqvSNC4xSu3JqSLAUkpt/vtN4Zi
	BYDZ0YXsaEnSuKO6SCGLKAAxfY71YIM86j0zqgjINkUFLGErcojdITRZtJL+rFESU9Nzfx19YBw
	WfCZV9VWGNs/vO5RFajYpXJDDaMybPIU=
X-Gm-Gg: AYBFou1ybT+uQPV/fOAuVL0KZCPIKxJpgT89IChWnB9GAGMDC3HEHCujnBEYFDrybBf
	4ghe5QGSgrOZAkDPpPPli/j1v0nwe+Hgg9eRaD/B5GxkmEGkMPuSFxlsCvWrc/wx136eylGW+BA
	dnU1JeTay36LVrU4wkDNaVUei6VSmx8v770JMr/8tEd5dPEncveg5FBt+3GtLHzauspOdB8rt3d
	g35weWNC+wVOGah9F/YzfCh0oB8u5mH8ddevkdqem/I8IDPRLZzO3f/y8zwYMTJDG2M4h6H95xa
	TxDD7nV9k7wooOAsbtDsW6ZALHsI4U8YRwfAdgrBVu646Nxvi4b1hhOHFQJxA5GkqlPNRS6di3m
	hEdbiY7RZFXyw1T99kClSp7gPSHNMcR4ZOkbJDOREhzvKIFI/8R3N5mvy
X-Received: by 2002:a05:651c:144c:b0:3a9:707e:ad9c with SMTP id
 38308e7fff4ca-3a9c5399cb7mr11669841fa.4.1791639173378; Sat, 10 Oct 2026
 06:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007115821.11332-4-sigefriedhyy@gmail.com> <179154713053.434549.11454657718901075006@kernel.org>
In-Reply-To: <179154713053.434549.11454657718901075006@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 10 Oct 2026 22:32:42 +0900
X-Gm-Features: AclHuK8XHLLXtzmhhgPNwPEtq6aAUTQyZKtjE1IommkdRmUGkoYJ9BfWJQP14DE
Message-ID: <CA+7S2v+=pQv4OGqcK5Gw=ZdnQJ9FAhsYXwdbichThiTd4sVH7A@mail.gmail.com>
Subject: Re: [PATCH net-next v10 3/6] net: add a generation counter for
 dev->mc changes
To: netdev-bot+sashiko@kernel.org
Cc: ajay.kathat@microchip.com, aleksandr.loktionov@intel.com, 
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net, 
	dsahern@kernel.org, donald.hunter@gmail.com, edumazet@google.com, 
	idosch@nvidia.com, jacob.e.keller@intel.com, kuba@kernel.org, 
	johannes@sipsolutions.net, kees@kernel.org, kory.maincent@bootlin.com, 
	kuniyu@google.com, nicolas.dichtel@6wind.com, nickgarlis@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, 
	sdf.kernel@gmail.com, vadim.fedorenko@linux.dev, willemb@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> - [Medium] netlink: AF_PACKET multicast dump misses changes due to
>   reading sequence after loop

This  seems real, I will send a v11 patch, will sample before the
walk, and once more after it for the
NLMSG_DONE check.

> - [Low] __hw_addr_changed() (net/core/dev_addr_lists.c) does
>   atomic_inc(&dev_net(list->mc_dev)->dev_mc_genid).

Same as every other dev->mc writer under the address lock, nothing new.

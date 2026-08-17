Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38652175A99
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976638; cv=none; b=cmJ0LZCyXUOawDWNhDFOQBimnbD6r0kqeqVJ6FYWVEih/JzO1dacLv9eSvAh0s/9bCTDP3OqYpyCk7c3d8x+LSULcFfDR3x855VKban2PJqUF2YQBnPXQa2DhIJ9AFCTWKUv+Oo0pLKTdO/qaA+fROSySeXr0PrxKFSuSkHkx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976638; c=relaxed/simple;
	bh=7aCtA1t/7lG+zje4vmScEV4L0FB8oukORLmRNeadYNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/HRlUuzDz+jwJ6RUyVAOM6ouX/LfYXVzyylIMgzasGIqukr0jhI6r7Ix7w+ezk0ct1H7kyqgFLFbQhmooJO60joTcPJlydh799jqkZorqWsG+6p64fvx7+nT+jEjChq6FkEx5fKOYmEUXaFSRJ/BLlTsB3klaYVNzBmmBCpzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7v070tC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7v070tC"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476a130c138so3625155f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786976635; x=1787581435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=If9lDPMz2SaJWMhQWOQ1mzEz7CNmQ9kfipX5E+1z4B4=;
        b=L7v070tCovS+zR+RoIgCqPVTTqmE7uZgD7TELmh9PafRIBkAtgTgvmfnT9fPs1zx4l
         hIBl+RwI3kTdWtOm6X9qLhW6P746FrHb43Uodxf2bV2FyUp/rps3L8TyhmEs1CXAdokl
         6G/cobSMLVdT8ZyZtcezjCqaC0h3CiCvdg3skjiakj8xiS+q3QIJeu88sIweHbjmZVPa
         cqxYj3PUN16rmIG9UF8TU1VT++d+418RxSOdZmlw/pPL+G/V09JwOK6x/n2juGnmyHvV
         D6xQp61L85rHP6hbIAkSG8jK1E16mhZ9y6iUKRpIcCYiZWNV6tfJnI6XLZlLzgEw0LZe
         bAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976635; x=1787581435;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=If9lDPMz2SaJWMhQWOQ1mzEz7CNmQ9kfipX5E+1z4B4=;
        b=MhtrUELkCnnwdAmXL9j8qG4Hf+2odDjSlT0/uweraKNJF8BV+tgvcoYEbreUrbxekl
         LAG1TGXIBa/wu/6sLn6xAQ5HGZKKHIjWOrtxRWuIU2CE4O2VCT45cOrBe7X0M5aRCfu6
         tBNj9418mgKb6QeqXlDVgxn5+V3hbmJg4hpyi84enPEKeW+cOI/HDIsymxA85PGFcCAK
         Djs5KsqRUCLjkCIn10i0uZpP8GB7kKPBn+BpTSlnXljIzxsRk/pPQuQWqpdYxBU3DuVE
         NjPyxs7cQ0vP05XAbwXRDVb2pKBuMhIo56LgIPBguPSo8nc9zHR2z/QNExyF7CE5McEu
         pt8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpcfmYnw2dz/4rNcJk2VClxt3Zb7nlrsutQexFOaB5mE9U8PjzK0HfuxyuwP1i4xn4E9pKB+xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnngSygRCB3t/2nwt7oI9EvxDzY9PTSn8hgL9UjfE0EfJjVNz
	n71qtpjeTPl/h1eQaybmUS5kRbB7ea5N6Qp/P3eC34yIwczn02hubkie
X-Gm-Gg: AR+sD11agSeF9JVXc/yICOFcxahFiTQNsRy4QZeWEK7Z24KtSUuL7RrLo7VlMS8jv2s
	TnFK9xpke0B9uWtjDlYYm4WVVhNmeKeoMXXsnn8IlUtDoppNZvTrR4epyBX1pY66echD49tOk1X
	VYMGDgdxZMMW3s4EuEs++ycVo+5QP1zE3LhhTMOK/U1jvx5tvKBQ+Ma/jXH6oT44HmuCzsnMIcj
	21MhRE6Z10Xv5u3CB5Cd5fpoJ3aPWA58wE+vaAp0fGU8o58Q8pMihsq08QpdINI/nm1kxugCr4g
	v4kHfZpALRV3Rh5fEZJ+vAPwMZiNpxpiZwqULFgvEuhpvWu70RaavUYshRQrNfi/+D0s3BDr1lT
	OTi9adWZyXKcbgyyT8w93jwJG4CqIHl6/zVAxLt/ofh27YvrBEBDVyoy+YZEswHSdk2AWuLCsH6
	2/4P9ITkTRPvkAypUGsW/HN9E5N4PsDG1nFt0dObOUYCN4e0ggjRuvLn++4FuzaFFWEn6zto35u
	YB4CZk39fGEgNrl3yfwqLBJ5A==
X-Received: by 2002:a05:6000:40c8:b0:481:568d:f119 with SMTP id ffacd0b85a97d-4816068c6admr36693220f8f.0.1786976635193;
        Mon, 17 Aug 2026 07:23:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b77fa3sm4154065f8f.26.2026.08.17.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:23:54 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:23:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Ajith P V <ajithpv.linux@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>
Subject: Re: [PATCH net-next v3] tipc: replace deprecated strcpy with
 strscpy in tipc_bearer_get_name()
Message-ID: <20260817152350.573c4eff@pumpkin>
In-Reply-To: <GV1P189MB1988B4FA71085BFFB31AF4CDC6A72@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB1988CAF7D299010DB0C80031C6DA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
	<20260814160846.338273-1-ajithpv.linux@gmail.com>
	<GV1P189MB1988B4FA71085BFFB31AF4CDC6A72@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 07:53:53 +0000
Tung Quang Nguyen <tung.quang.nguyen@est.tech> wrote:

> >Subject: Re: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy in
> >tipc_bearer_get_name()
> >  
> >> net tree:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
> >> net-next tree:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git  
> >
> >Thank you. I tried the correct net-next tree. The same patch applied
> >successfully here also as shown below.
> >
> ><path of the linux tree>/net-next$ ls
> >arch   certs    CREDITS  Documentation  fs       init      ipc     Kconfig  lib
> >MAINTAINERS  mm   README  samples  security  tools  virt
> >block  COPYING  crypto   drivers        include  io_uring  Kbuild  kernel   LICENSES
> >Makefile     net  rust    scripts  sound     usr
> ><path of the linux tree>/net-next$ git remote -v
> >origin	https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
> >(fetch)
> >origin	https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
> >(push)
> ><path of the linux tree>/net-next$ git am ../../patches/v3-0001-tipc-replace-
> >deprecated-strcpy-with-strscpy-in-ti.patch
> >Applying: tipc: replace deprecated strcpy with strscpy in
> >tipc_bearer_get_name() <path of the linux tree>/net-next$ git branch
> >* main
> ><path of the linux tree>/net-next$
> >
> >Am I missing something?  
> 
> I see that your patch was applied again successfully after failure.
> There is one feedback from AI review that I see valid:
> [...]
> > @@ -209,7 +209,7 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
> >  	if (!b)
> >  		return -EINVAL;
> >  
> > -	strcpy(name, b->name);
> > +	strscpy(name, b->name, TIPC_MAX_BEARER_NAME);  
> This isn't a bug, but the destination capacity is now hard-coded in the
> body while the interface says nothing about it.  The declaration in
> net/tipc/bearer.h is still:
> 	int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id);
> and the comment directly above the implementation only says:
> 	 *     @name: a pointer to the buffer where the name will be stored.
> Should the TIPC_MAX_BEARER_NAME requirement be spelled out in the comment
> or in the prototype, so that the interface and the body agree?
> In the current tree there is no behavioural change: the only caller is
> __tipc_nl_add_monitor() in net/tipc/monitor.c, which declares
> char bearer_name[TIPC_MAX_BEARER_NAME], and the source is
> char name[TIPC_MAX_BEARER_NAME] in struct tipc_bearer, so the copy can
> neither truncate nor overflow.
> The strscpy() return value is also discarded, so a future caller passing a
> smaller buffer would get a silently truncated name plus a return of 0.
> Would passing a size_t len from the caller (sizeof(bearer_name)) and
> forwarding strscpy()'s -E2BIG through the existing int return be preferable
> to a hard-coded bound?
> [...]
> 
> Please update your patch and send the new version after Aug 31st. (Because net-next is closed now)
> 

One 'solution' to the non-problem is to embed the array in a struct.
Although (IIRC) this is a uapi constant so that may not be completely
possible.

Otherwise I'd ignore the AI review.

	David


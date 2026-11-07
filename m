Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794077276;
	b=wog0eLN5fLukkcuZPS02rpd89QYhxNJq2IImamnAY6BURsdq4WPPX2hJkOJ9itrWt20F
	 tYdRMkOwr4kGjhY12z3P1sMp0FADNF1Y5d2Kjk/viYlvtLgI880TEE+/wNrCg2d42FORD
	 9otadHWZaFxUSF2ky/tute1UEhXPKHvevXetrQgFDzxVmvmVVufXyEXTVrQMXT3KI3jTO
	 IUSPJ8YhxeqA14DFqZY4MMjdtmhRQFBlEnGuQalhhr7SN3ZWPAzkplVo33AxeLagnY9SG
	 41yGtfOWNhACCOa+z/EH+LAJhGUg29ePrXte2kVXdMLUw8avUmFHxzV90VHh3OkRb2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
	b=s7CTHOQy6voqnhgLVBhqtB0PK79KTXC0pPcyKF50fxueu1V89JFfalZvOa5FO6loMHBT
	 XMNr3xj0mD61JwY5jnn6p1a2nsTYVGFpgGx6akb4DEhCzhGj5blgBOCNUEHSBZFpSH1SJ
	 eIaFWZhON7SliYRLrUXhCOzOAvX6OZ5Vuyk7bKZo9Ifrw/bkrADemF/jopn+g42omFZwi
	 eQpGbTG9545yqaXrdcyktROOPPYcqpylDGc113413UsnD6BVRx11YsOgR7qmQQnOT6l4p
	 P3bfuQLUalmAaLHjX3SQ3I+ag2K7cdLFj0rIYTGAWQyxsihcCcnCimHSfavTnlAiAOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jDsWkgNe;
	arc=fail smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06164606A332
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 18:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06164606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jDsWkgNe
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be47aa555cso1407859e87.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 10:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794077274; cv=none;
        d=google.com; s=arc-20260327;
        b=mprifGlWNrCxW1jj0ShKHmyrVbTdOy6XJ//DTCDmdqFGDRZBuEdnJs6xpVRSeNvYLv
         8PQ4w3OlD1aWhLwbb+kXDG0BJ+gUQy2K+ZX2NQCWddDscecrYCq/7CaAj8gEOHqlH7ZQ
         5gMpHzBa5eb9HeRsmWygfBN8AHmFcv8Qbv3SFUMjwptyPoz/atptCarpbXdpuu/t9aAs
         LF91ChVc9oA4RN4SWVCK4PRsJclKm33kzhTSjpzuVeJZSGnLIImPcQFihCu/NgNmQfyq
         AxKFWs8wKb4UvZDmzvqd5yvIpFW9APWkO190Ri+bn0JzDvwMwo62zOLkgCUswwK3JEWe
         34Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
        fh=/1UvEaUG9z85JHOMfAjIGOiaQBLlqNWpUFTNHGaTwx4=;
        b=Ptc4rsQoAQU4doUAdNYIW1b+cx7bIytdGRhWRDQKiKYK9Zr9KqrCihMAhc8eNW8Tb8
         JRSJsBw8+cA1dTC93hICGXM7TIznAgmocEJUoExlAWZtnmgfgOf2gjK5gSS39Vcc3CgJ
         QWB81tnynwq1309Llu8AtUnTOiWZ1jrBzKewOT5QPb5GumhIM6BUhUdteJyaH/YiOEr8
         skorzaHEEEmm12YksgAotn7EdC+JWcYk9ubIGsR9pymAuQ73gJXOu6bMtC7ksjs/t/k0
         HAg59SLscxmQ7RrOe1VkZU3vpCxi082WEBoX1lNxBYJR2h/lJWSRPe0CmhyLNRbYHOZy
         t4+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794077274; x=1794682074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
        b=jDsWkgNeFsbdQ7qKqbpHSGOmDkfyI4OzDS2pJc6+Irn0QHpBxG9wPbmRTDmNnDdzS5
         db8t7KSVAGcHE/QtRbNhFDCWnX4uqUr1mEeZuLglr9YUDK4k94+gZZ0e2v5XDqaLBMAu
         GF2mKtLq3tPj9IBZGN3w1gGTAF0jFrsZMFCKcXAmKrirJiOIjEcuysNg1l24IqICP4gV
         r2UQCTmuYiVAi+q/1GU8UDVYE1+IZodom/D3RIz9GtMMMdasHTqHTXmlylMP0IcXnVJO
         5lWPTzglrmuISOXtwRoPqefa1QyXnIQk56sGTTb2Rf1nGsDNJzcZ5BPRF2XDpKcZZ3TD
         g2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077274; x=1794682074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
        b=XGDxSrtsxh+KzIieZt9uL9XZoOoZANDHXcgoWK++BrwOSBU8VxHFMd19WsYoHTUBH2
         E/dJl3/XHKDLpKVwL46WyluQK/NVlNUYLRuDNMi7iLT6kKh6NUPBG4vMGjREYu3QaxQP
         /Vm9YUoQKpQ9cLWl9BRjQqzlIjuLNDGLbmkIT3mXZRXXI+AuS59HBMqU7LPwWgjNE2/h
         6HRhv2qbuw31T1d5z3o8JV/y7+9Um1ZGPp3+HfL3fLqZlZIHX8poUtWI9t4fOtAKRFvD
         nEPtsrg1eNc7jiD8fxpBBh+OIdzejr7SNUqJVCrtHrbTYEV+31TfyVU8kBRTtiNagRL0
         tPcg==
X-Forwarded-Encrypted: i=1; AL+hErH8JTsM/NeyBC7dN8DKkFq9vhWJOP+6tE+Z7zXIbx4kqYr+PeCM7eS+a1mtzDZm5W0NP0wCcVY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3CnZ5/e/zx3SYni+UDVOsaY/ygiKz64urXo0TRKNK16ipqwzw
	WPp71/Op/IV+H05s7qyR4WyklOXd+BbepblhT9i+rkJfbc90W4SaAH2WExjdBwBOrkf6CKsvMQW
	qe/MzpbT5Uhi+/qTdVcCmlpFiZVcaPqf2YIGS5snv
X-Gm-Gg: AYBFou27Sk9aXQgxcLgiobG8EJBLHdIcgwd1c+w6Tc4aCfB/tkc9P83Oo97jsBtiKrf
	lEOzwlKhJpmUi5YqGLa9O86festFv8W7yJ7Ov1cCGtvoXNK0SiIROz+X6CCaFxZg9m6Ivs4w4Jt
	tv/lJqGj19vTUv0Sy4roUQplmJHW97DRv4bB9+/KJHHBEsDAhxoHjx/FUKSqWCV/CVPZRFLLEZK
	V4L4PzsgL4eoFW2VgRFV4HImO+HdZzBAR2V1YvOmldgoSK4O6SVt8Td8Epqvwl14FQxnWcOtzU5
	yFVCeqm9a1w2djEnRpgg8N601CGlRr8IIMEEGCdNg8H7qVJgaOiDY0k1W6taPyR0B4MUcXbMy+x
	fL8u3mYYXYH9eHedJsBnanCPk7x19N4S1VQ==
X-Received: by 2002:a05:6512:291a:b0:5c0:ca1:9dd7 with SMTP id
 2adb3069b0e04-5c00ca19f2bmr594320e87.35.1794077274068; Sat, 07 Nov 2026
 10:47:54 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
 <20261106-befreien-addieren-eislauf-e09212803534@brauner>
In-Reply-To: <20261106-befreien-addieren-eislauf-e09212803534@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 7 Nov 2026 10:47:41 -0800
X-Gm-Features: AclHuK9s0dgg3FDVqp4WbjYQnA0hebDpEpxOAgz_VjLjRP_HfRjeTpRH9DX274k
Message-ID: <CALCETrWa1SBLcb5oWjqjgzZvKvCoHjmYFk=Lf5ytEM9uqm5jYA@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: Christian Brauner <brauner@kernel.org>
Cc: "Hallgrimur H. Gunnarsson" <halg@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:13=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Oct 28, 2026 at 03:56:11PM -0700, Andy Lutomirski wrote:
> > The whole unshare/clone flag situation is getting out of hand, IMO.
> > And this new thing makes logical sense but is really about reducing
> > exposure.
> >
> > Perhaps we should instead have a small list associated with a userns
> > (extensible in the future) of things that the ns's admin (i.e. whoever
> > has CAP_SYS_ADMIN relative to the ns) may do.  That list could
> > include:
> >
> > - Create loopback with sensible defaults for ipv4 and/or ipv6 (i see
> > no obvious reason to separate them)
> > - Create tun/tap interfaces in that ns (and attach them, etc)
> >
> > And add a very simple new API to do these things.  Actually, the
>
> We've had this idea in the past and I think it is reasonable. I had
> always thought that we should expose a system call to create empty
> namespaces ot any type. Usually I'd be excited about that but I think
> that point is a bit moot and I'd really like see whether we can turn
> cells (or whatever other name) into a first class api.
>
> The problem I have with the patchset as written is that adds a lot of
> moving parts. And yes, I find the CLONE_* and UNSHARE_* flags plus
> sysctl to be suboptimal as well.
>
> So the TL;DR is that CAP_NET_ADMIN + userns =3D
> CAP_NET_PRIVILEGE_ESCALATION 10+ years later. And this patchset wants to
> put it back on a leash.
>
> So why isn't an aggressively stupid solution to this problem to split a
> new capability out of CAP_NET_ADMIN so it covers the absolute minimal
> set of things that should be allowed instead of doing effectively the
> same thing but split over multiple apis?

Because we don't actually have a clean way to make a list of
privileges that are, in theory, harmless but are hazardous from an
attack surface perspective and assign them only to tasks that ought to
have them.

But maybe we should invent such a thing.  It would be very, very nice.

Other than that, I agree with you.

>
> Anything that is reasonably advanced should not be the kernel's
> responsibility to delegate. I really think the old privilege model where
> the kernel grants control over a whole subsystem is inherently flawed
> and is much better replaced if you have the means to let userspace
> services grant and delegate resources.



--=20
Andy Lutomirski
AMA Capital Management, LLC

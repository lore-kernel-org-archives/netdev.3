Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF7441623
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022954; cv=pass; b=bBf7rxZjy3u6G5da/ustCMz1Xw8fZuBURaDZB0qbSalvScysGTz2FSu/rqxhn0fS5R0kHFqGIA2eVpv9DsvH/9He6z470uX0IA7irGBfLNCZVmT4I5nTKCIhzYVIiI8MOvX8CRIxNX28rCVn/PHOgg0xzVTu/l7s+5EzCyMX8UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022954; c=relaxed/simple;
	bh=U3DXEKNWlCB0uYRtqUZf/ug5VAzBLjlT6fU2c/knisc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anKeh2MkhmKUowyIMz0LjjD4PuQla312C2YQ53XLf+OgPfCl7zpeD0J5NYyKqypcas+6EtcaKsnfhFCzqLS/zKqek38pdEUxOeUDBpOKj92WQt/7AG+nlkZ8vAgyhsla4Coyf9ncROVbcgm2SbqyMV+fWPsmymHJHeLG8kLnGIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PelLgQG6; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PelLgQG6"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so379909685a.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790022952; cv=none;
        d=google.com; s=arc-20260327;
        b=bfaoUWMBm0lRWP3O/1itAlh3OLNiXc45d9fySKIFSypR6IHacJv+sQGwT8lGgtx52I
         VQy/Z8OTHpaDNz4RLvRvzYD1/UeGKdEPkKPAZiiddGFlkkAQSP6+2Ywl++1k0BbrpzZF
         jxBnWLZ+uwGCuexpp+++1po6oeR/U7dgt+M/MIgwiQfv+uz5y/vdo08f8Uuae9faKorK
         T4qyuh7vEEbm5bfjXpRt7Zku9WZ/WRcaG4oWtpxhP7w4WaqHpf+TnMSb2G2tCz7f9moZ
         K95CFomVdES5LvImw1QCBzW9efiXshnHzg4f1u+P2Tzy4i9rYt3/7RHTC4dCGPQFMFwp
         dP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GzvEhHEFf3U+VWscOvjIoCtOuQQNDN766fh3j56iCig=;
        fh=j7jo7tI4OVxJyMVZst8j6beWGDkZ6ivVPPuDMURfQYQ=;
        b=Vqimd4YCE8HtjhGWNLKCWTngqigm3uhJ/WiNXLuD4ptcRcqjofoNL7NvXGJOEA5/01
         V4X8Sh9l/pmq/TKFDPZbm/1LyCqFOv88MRp2Q1K+GDXfxEdSRdeYHbPdE0zIPuMRCGNs
         LwDPAd3Txuso5nA/o93Cv/UKMO5O4QZPkUeNnV/1kZ1TExi8JU5WrwFMAgGZoTGbVl+U
         wKtDjhYZCR2rrDTyKpszUFF4hdSakT2hcNpSMP56leLQCtpbIWCrSQXqneRDQI8M73iT
         8ZThtfyiN+cznJ3x090jiey8rb70zAMrhG0HPqavNgBEK7BVidkhSDgqPPcluMej4+J6
         eLiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790022952; x=1790627752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GzvEhHEFf3U+VWscOvjIoCtOuQQNDN766fh3j56iCig=;
        b=PelLgQG6RVFjFUuHWfpFTnfPidTIkPHrD2Ms6ODqrKDQU4PU3OM75qsoJfpOoAMo+d
         9yB6Z0Klg/PR/Wp4H5hxeDO7dHmyruFREuQutvLoYad95lFanPan3zJLdzSrpUzPYINv
         r0Nz4mCQkyOAm61cghf0sJIISnOGqByWYhp2mPjvUw85c7rw+4dv4GNFdAjCKiPj4Rxl
         uo8M9Z+/BlqLU+m0OJdScommCJcNFCm5d3MyfG9+GB3E89qXiziT+OhV0+PkyefRV6jJ
         MjLugZVpRNl2aBCZU2VsrdeuDzCVHRsDJHHaEx1shZMLBeLbqvqWUrktZVAMDmwQ6uYO
         F69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022952; x=1790627752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzvEhHEFf3U+VWscOvjIoCtOuQQNDN766fh3j56iCig=;
        b=LgfFnTlONy2nUsZg7/i6J9mZOJ35kBv44wM8aVHCcOsbiFI9THlEUTh3hvVan0m5sQ
         B/qyJPkR5Ob4ohHLhS/FN4or9ztGWaADNRE7v09dN3g/u/gNbj6odzDyGKPVdvgH6TXE
         vz0GVC4YzFTUrjDIiMThBor8E19xpodFdl8R/xmKu7myskR4uaLsz4TqVpiBI15YmyWc
         iTqCJs8NYLV0QhCfJyQE0BeL9ohNGsealhzhXmPkNVeUXc6nfvNqOnwizQjwHvHkEFke
         V6qomrppAzAC7kl0z/BVyIedhKkE5j7AcnN0yWinboRNbZ27xv1ynlbjtSi3qFd+4caB
         0L8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwTRsL4S5p5NMlt4flMqsCEEYxiLUVUIZna8SDEiKa0pe2H23ls9CCbJhj3+Fu2DgGPJhih3HQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n53leOe00U9VlWBAhUuagfUNSI+03y9JyExOOOjqQ+VVhDZjaD
	P71PfjIU1SXK3pTa7FWsM7P2lEE6EGwlVJJZGmDT1MntCmFCYQYcJaW/NqDJU+34VTqpTTUACLw
	CZhZVdTtsyVz07zaYnQ/Ko11K6vQx0aGwLh85W+ev2Lf+EsQOGnPvzm8xkmY=
X-Gm-Gg: AYBFou2c1kA0KJOsoLzs44H3n6ZrMF5POGgyaj+Ts4Po6uXscPFquSsR78YxpP48qEc
	ShyXQOvphaAsre5m3UfE4RaA7vx4O//wd6It5ataYELIgmyLb5kxBn/wDvPh+2EYLJtMzAWnYl3
	qRsVQa9mBEtneiV2NGxQPdRK+F6g8SXyG1fpoLmffSENP9aclC1bBg8iU/K5KQnjDL3DNtNl8X3
	sWsInxS9WjAW5jKaXAqdEjigCKVdokqPiH3PhxexmFbubcRBLNGgwNKCPehVRFarKVco3bkDzZL
	ACNAmyIg6MQB97XqVbzOovNtGTwyMdRWhCblOuOv6m/njKVSzYCYds8BJIDl2rJoGQ27UOxYZ86
	OLjj3GU5fXOPeg0gqsaDRSkhBF+t0WeFc8L49dZlCk9P/yx8y55hg2DEnhiaOfU9NViaNyZ+GaC
	TRe2C0
X-Received: by 2002:a05:620a:178d:b0:939:10dd:9c01 with SMTP id
 af79cd13be357-93c19a4621emr25588585a.38.1790022951139; Mon, 21 Sep 2026
 13:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921183758.1812310-1-edumazet@google.com> <20260921183758.1812310-4-edumazet@google.com>
 <20260921130337.57d93c2f@kernel.org> <CANn89iJkB4BERbG_7yCmvguMdTcJUBzpM_Dkas+L2LnB6nraMQ@mail.gmail.com>
In-Reply-To: <CANn89iJkB4BERbG_7yCmvguMdTcJUBzpM_Dkas+L2LnB6nraMQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Sep 2026 22:35:39 +0200
X-Gm-Features: AcwNN1V64J6p4OcfZ1zcGtorf2O_LNTNxzeWB20He_8yDz1A7aaz3_3FLq53UA8
Message-ID: <CANn89iLqsBte3krUn6hzKeTTbNmfEBsvcx5+1LkV1q+T+RFx=g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] net: ethtool: add KUnit tests for the
 generated RSS key
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:10=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Sep 21, 2026 at 10:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Mon, 21 Sep 2026 18:37:56 +0000 Eric Dumazet wrote:
> > > Check the property from the definition of the Toeplitz hash, independ=
ently
> > > of the way netdev_rss_key_init() achieves it: an aligned block of 2^q
> > > consecutive values of one field has to land on the 2^q queues exactly=
 once
> > > each.
> > >
> > > Four checks and a control. rss_key_property_test() does the algebra f=
or
> > > the named fields of the usual hash inputs, rss_key_grid_test() sweeps=
 every
> > > 16-bit aligned position of the key, since the generator does not get =
to
> > > know the layout the hardware uses, and rss_key_spread_test() hashes t=
he
> > > inputs of an actual burst and looks at where they land. The control,
> > > rss_key_checker_test(), feeds degenerate keys to the rank check so th=
at a
> > > check accepting everything cannot make the others pass.
> > >
> > > rss_key_alias_test() covers the other half of what the generator prom=
ises,
> > > that no two input bits read the same 32-bit key window and are theref=
ore
> > > indistinguishable to the hash. It sorts the windows instead of compar=
ing
> > > them pairwise, so unlike netdev_rss_key_init() it looks at every dist=
ance
> > > rather than at the multiples of 16 alone.
> > >
> > > The field table includes a PSP over UDP over IPv6 layout, whose inner=
 TCP
> > > ports sit far past the plain 4-tuple, because that is the case the of=
fsets
> > > of the standard layouts do not cover.
> > >
> > > Commenting out the fixup makes three of the five cases fail and leave=
s the
> > > control passing. Keeping the fixup but skipping the redraw fails
> > > rss_key_alias_test alone.
> >
> > Is this AI generated or do you think there's some genuine value here?
> > I don't want kunits which can be trivially re-generated during
> > development to be merged. But perhaps there's some genuine value in
> > this one?
>
> I added all these tests because Willem wanted them in our internal bug en=
try :)
>
> This can certainly be removed, although I have to find ways to launch
> vng so that
> /proc/sys/net/core/netdev_rss_key is populated.

Adding the following seems to help:
   --qemu-opts=3D"-netdev user,id=3Dn0 -device
virtio-net-pci,netdev=3Dn0,rss=3Don,hash=3Don"

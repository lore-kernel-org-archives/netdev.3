Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC66463B76
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141185; cv=pass; b=b+u9970oqKS7dUwfrPhPcl6x41SdbnbF+D35cFLLYXFrMSEfeYhkPXBQOs8+DA5atQhoKp4wW6brCHJqKCx40YPWg9Svu1mltdQX3xDBGO3VMfIVdNKgxptZtEMykiQWe2D355k0hJ7fY+7HFhw9aTSbf5C0eEmtO7oxuGErvIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141185; c=relaxed/simple;
	bh=tX8oW19EzNSpx55rVPyv0ZfQzctQtnlywYu1+2gW2R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyUhJjY7Z7dh8UAjdPSTWRLUi022MmnLfbut8o97jYWZbBbZSEPUZ3vGUOtAvpOi6WH6RBPCww1xiPSLnafXdzSYsx5oyfYwSBfEE04w4a9KG/oM5BJCpvknf85OqbAwYyentOPRRvw7zWSN002nLqsKixHFS72eBqVxOFS7m4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AqD6hVh5; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AqD6hVh5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so5639a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792141181; cv=none;
        d=google.com; s=arc-20260327;
        b=PGoRd4g1Gwn04HWEyEhKB+ZIlW0nC/H6TsehhaEUqkjWtpcw2J/DKpZIcxGECrI9Ur
         IhmR+/fXOm7LoFX3wr9m/c+VlGP4kFozdcYeI++/RWr9mARUTjk5ZdXBTFkUvHdGm/qo
         RIICXahS+oUClKZjUqKtKcYxfAYixGBIUR5Xx2GwQ/ZeCA6MsEqOCRsIzwh4r7oSnKEd
         dl1g29YD5BZ612iWm6MTPpWA1aUgt9VmDJPX+gtrM8SI8+FB5RGp8tCoy/XNzqXqgtXw
         T521ObfERGi53TgugpCPBw/ccYd1F51MVukMc1A5W+Xk+qXIZxtEhCQrtqvkhaq/V2fv
         OpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EZlGH4yy9O7O0nf1ZYvJL4ZoQnTfHAsB9O8BKxrx/Xs=;
        fh=qZH4IOUuHtrSPCS/MoiTv97crgdHcwmNowaBioLg8WA=;
        b=bY54LwoGulhp31oNtze8fjNSlfaTLqPlRP1q7DrlyXrX4z2GPD5TvMgS1NIy1stddZ
         Dr2QmkTIFcyzk1CVQqQodY1eBxaONW2hnCiO/W3JopExOA9KbgQbIt/AJX7mVrnm/Ix+
         vTiJAUNmeQFMiEBse3Ne2Z9j3jZl5XXDSqC6tbEaBH6j4+1xlDv2ufrMxwq6MtVYePi4
         w+FQlzXbQgJ4oFXFzexH/dO2GskJogpAFZfRlptTc2O7MHqWeAJIYkXL+eWFOb9AqkeP
         Wm9VuRBzg67JqTthCv8hbxBxu8C7QgsPRtS+rRNX1zEtpURbTwf0ljBryOP7wIUGA51w
         4lJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792141181; x=1792745981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EZlGH4yy9O7O0nf1ZYvJL4ZoQnTfHAsB9O8BKxrx/Xs=;
        b=AqD6hVh5Z8fsmeU9NWVsCuw0LvJ4423W89OeuInlBsI6XDsT6K//yzPoLT5m8HbJfh
         offi0z3iCY9M7g/YE/QZ9uSCmbzN/yB+j6kHHYXPfPp+gJEco49tuFOYQRD4fdtKnpia
         OJ29jEM9LUnCBAIFRwV7Qo61yGxZ2XbCNVCXvePMbQJ7OokiX56LnTyj8TfZodb9e+6J
         2yNoBfR8ijIVY3SfKdln8IF4BCMScMOLgLasTQA/ZEXk5YH0Whv2WLcn8YNZmtAyfn9Y
         9l4vI4wlmM7f4Mn+lyI8VxxB6fqJfSro1+mLMppkUBm1AXdtxhZk3QCRy0luHD36UGzj
         h3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141181; x=1792745981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZlGH4yy9O7O0nf1ZYvJL4ZoQnTfHAsB9O8BKxrx/Xs=;
        b=KdWCKj1Ftahj8csZ+i7nAxzlh1hhOyqaFTwt44xPXsUHu2wPAONuO4NbAZEceEcPJ3
         +fPkKB3pJndK834vygYP/N+n3DriJ08wMpG/MLVmT5gh2hFXNYWTSIFWKbFKTkKwKLRH
         cFcAF7+wTGxK3Sp51ky6O5shTSKtnaaQIu1Ws4AOZw/bYM8BTetdqRz1AaIuSGTgY3s8
         O9CchLvN0ZV+3Lj5X2x9A6QzleyPI71N+8uTOxnWNsW6YqFK2UzfnCHo21tNkgXdJ5bw
         JcEoBdPY4wcjGJ/pJYoFL2ltxwG7/2tI6pVLHlFiIEoIICrutlUlJ/FQ9u5rxwQy4yEI
         ciQw==
X-Forwarded-Encrypted: i=1; AKwUvBwLtlRno91CApe+XxQWPfQI4IbNh7jOVGn0TexN+zy3GwBi7B6XtDV24DKoEpj5pjMIdcDP9zE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbe/sJLZPvysiXrocuTa6yIEMoVuSsDrz5at0bmd6vi11V2F46
	HFvdZSUR8f9HZ2Ynmiqd5L104zYr5ObYMq6sZhvbTJt6coYGKKf2kNzMLMrY31pWdeBuyNhbedx
	zwhU7/llX+AS2+s2VTNwuzp7XwOsBD37cRQ/9tIqGaLxcQDlPaxbBz6wsh0Ub4Q==
X-Gm-Gg: AYBFou2PrCKE1OCviGh04tZ7ozFCvoUIWX56tuOc+K/o30yoot9pGBEEg2aYEJJtq+R
	g7ENhAxRIomIZvdhR6san5ewhBBB8hJt/a4NM9+OXhvcOtI14t0ME1vPrCAtyGKGoBSqtmLc58+
	5rIGfCWzbyUmzcnOBBSBC28grEeao2rPQGCnns7J508Vd5jr+EgwfzbSBUc5qrAF03i5SyeSTNB
	IQjGRI+ZYM/TFNgX72CnlZfwNfMvl2ODq5W8udipuRvR4GFbErwOofMK69SUeBh80jhnxpPYKAk
	DgFXKSMunxiunNlKwbMOm1xy3sxdp8V/VhuB/MK32YdLQ6h0ZYvBq8AeEJTSUtT0VhM8JiFC1up
	v66poeLxtRUTtKwlZew2fK7zU
X-Received: by 2002:aa7:d7c8:0:b0:6a9:d188:2374 with SMTP id
 4fb4d7f45d1cf-6b38c3c7baamr30067a12.1.1792141180097; Fri, 16 Oct 2026
 01:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015073736.2944215-1-tavip@google.com> <20261015073736.2944215-3-tavip@google.com>
 <CAAVpQUCpFC-7J=uEgBfh37hFb5BCJvhJQZx7_YKEDCtvbGrGWw@mail.gmail.com>
 <CAL4WiiozXgApewA6WWQA--YxaweezQASpiOiiLz7=ijrqbkqgQ@mail.gmail.com> <CAL4WiioJjvno8r7YeLCTf00q9L5w+OOGLbGz-t330R=NZ8ATkQ@mail.gmail.com>
In-Reply-To: <CAL4WiioJjvno8r7YeLCTf00q9L5w+OOGLbGz-t330R=NZ8ATkQ@mail.gmail.com>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 16 Oct 2026 01:59:27 -0700
X-Gm-Features: AclHuK8hZWfSCQBFUZf2062w8cM86knegB4R5UxwwsJOxtJtgSEQ4r1q2T_WaWU
Message-ID: <CAGWr4cTPTqYvfKg_e7kTgg_ioav+v2AWTre5aQqzkm7tvfS1sA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: net: packetdrill: add test for
 negative sk_forward_alloc in tcp_wmem_schedule()
To: Eric Dumazet <edumazet@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Wei Wang <weiwan@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 1:23=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le ven. 16 oct. 2026 =C3=A0 10:22, Eric Dumazet <edumazet@kernel.org> a =
=C3=A9crit :
> >
> > Le ven. 16 oct. 2026 =C3=A0 09:54, Kuniyuki Iwashima <kuniyu@google.com=
> a =C3=A9crit :
> > >
> > > On Thu, Oct 15, 2026 at 12:37=E2=80=AFAM Octavian Purdila <tavip@goog=
le.com> wrote:
> > > >
> > > > Add a packetdrill test that drives sk->sk_forward_alloc negative vi=
a
> > > > tcp_collapse() on the receive queue while sk->sk_wmem_queued exceed=
s
> > > > sysctl_tcp_wmem[0], and verifies that a subsequent non-blocking wri=
te()
> > > > under TCP memory pressure fails with EAGAIN rather than returning a
> > > > negative copy length from tcp_wmem_schedule() and failing with EFAU=
LT.
> > > >
> > > > Assisted-by: LLM
> > > > Signed-off-by: Octavian Purdila <tavip@google.com>
> > >
> > > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> > >
> > > Thanks !
> >
> > Are you sure this test is passing on arches with 6K pages (as some
> > arm64 and ppc64 platforms) ?
>
> This was meant to read : 64K pages.
>
> > We might need to add a check to only run it on 4K platforms.

Ah, yes it would not pass. Thanks! I plan to add a check like the one
below in v2:

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 0a97d5ae34699..e2a418357bf1c 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -52,6 +52,12 @@ if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
  failfunc=3Dktap_test_xfail
 fi

+pagesize=3D$(grep -E '^--define=3DREQUIRES_PAGESIZE=3D' $script | cut -d
'=3D' -f 3 | tr -d '"')
+if [[ -n "$pagesize" && "$(getconf PAGESIZE)" !=3D "$pagesize" ]]; then
+ ktap_skip_all "requires ${pagesize}B PAGE_SIZE"
+ exit "$KSFT_SKIP"
+fi
+
 ip_versions=3D$(grep -E '^--ip_version=3D' $script | cut -d '=3D' -f 2)
 if [[ -z $ip_versions ]]; then
  ip_versions=3D"ipv4 ipv6 ipv4-mapped-ipv6"
diff --git a/tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_nega=
tive_fwd_alloc.pkt
b/tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_negative_fwd_al=
loc.pkt
index 8e31db546f432..5e6a40e740b42 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_negative_fw=
d_alloc.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_negative_fw=
d_alloc.pkt
@@ -3,6 +3,7 @@
 // when sk_wmem_schedule() fails under memory pressure and
 // sk->sk_wmem_queued >=3D sysctl_tcp_wmem[0], returning EAGAIN rather
than EFAULT.

+--define=3DREQUIRES_PAGESIZE=3D"4096"
 --mtu=3D65535
 --tolerance_usecs=3D100000

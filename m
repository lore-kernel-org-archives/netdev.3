Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802C3BB9F4
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830830; cv=pass; b=FR9IP3OmGbNA3LJBveXz2JxO5QG3rSRFePlqerBBnKb6j0EOlAWOVyvBLbRPDQqHPSYe+qulTSJXxPu/gywaxKTM9v+Q4t+9cDKU38qprWXIrzxeaDeKqGWU+LfeA5PM2TYI1RieWUax9M3JAYcqH7BgcjhPJNhpzf9RUjlIQy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830830; c=relaxed/simple;
	bh=Zh3J/7+6v7BI2SGhzSIn/LFnZmpHEi7qHcAEwASRlRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYxAHDEsbqfB8kRGDcgNndZQjn+VWsS7qwPCuaXNKuxzWj2mscsDx/yheh9Zwhk9X6RHICQEEUpe049R5Kjfr7ODrzH5l9tRCmkKyOh4+4yoOJhTeDaR88bs42NrUEh6wv0Hsw7fT7TG5l0UYaoo3DS2LMZlDJYG0n4BAmZez0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KQ5p83Fb; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQ5p83Fb"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e512a9a6bso74866985a.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784830818; cv=none;
        d=google.com; s=arc-20260327;
        b=MUqfL8A0E8svTLxRQp5dVd20Jp34WVYmElEsr+e5zoqisRnfz+3/EbRL2f6X4e2ek8
         SsSK7EYyEkxAbgwU1c0v6sgioxtVXjX+niIlrANOJ3hIiY/tcn6lfnAy9D1NVHFpdPrC
         xj+/3Pmt+vYWTjBb/5pGjtGzibjVm1TF2yHfrGoT0Bwl6yNPbcHjl/dlft+UBjI8CrVp
         H0RhVrUTM+JzFJqKGZHbHLiCjMmL1qDn9NMPVL2P4JFSLPrvmMio6jBE4yVb4V/FQLFt
         WPn2t9f1moWvX5mZglTncyJQ1w121XtBPLvhjoMmtWpkJRttMYllwS7+ODcdX+ZA//b7
         6Euw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ONF+adIMSAX0fK52FUlr6B1/Vlk1nbk8rk7LhS9c20A=;
        fh=mQbNe6hcgwcoMJ9gTO63zjuS3+3wML76sZJHHvYH/lg=;
        b=d7DS0qRsfaDAee5OndKr3VZKcAh1k8hr/TH95mofiK7OE3BMVc/bJE35fhFbAjXAcF
         Q+jNPl1FW+GtZcY1vDsOyYhVZJ1IJajbbMaBIFrFxNy2/V4vSnHuVIR5I+IM74aBT/c1
         NU5bC4kKsZ6XJ93Xbt0qsYSGBq1yYXVSxcRhhy+QIY7rimH7lAn1H/tee2EklyMJTm30
         bQIf21XkMqPsUUdGVIKDiVbucbhSG8nweqhN6WziyJMUIWS4RTDo962GCpURvhCnmSsz
         pS12xf8/E3ek304aZRQ9dIQ4YIVrXXQqSAMbq5xLbNpNswsX9fVm0MFTcmWbkYj8N4Ar
         bCJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784830818; x=1785435618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ONF+adIMSAX0fK52FUlr6B1/Vlk1nbk8rk7LhS9c20A=;
        b=KQ5p83FbLfhu+siWCQsIm1gRluTEpKU9H2oLjCA0zrvWLcCiGdQxdDwAVNpKdofZkc
         u+rlXGpH0/XHlcowDSbJS6oq4IgB8/Pnqo8BG1hvfVPopDA0u/y4ci6miYCTcaALn5FI
         cE6iEOVwX/hMVgTZG0kg8r46hGokSLzNee+TczTZUMiqREKaZBhCwp8PP1FCMTichIfH
         0Hdrnt+zaFxEWcMN+QMlHj3n7kEw5PDjhrT+ltunhnCeuNGJBNMatNAAaMudbyg+fWAl
         44mqLE2I/W6Hjl3LdbfRYsrvT32xsPNdSA2eXoIDeRNiLZI1/KtXfVLJFa5DGJOJNshO
         trfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784830818; x=1785435618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ONF+adIMSAX0fK52FUlr6B1/Vlk1nbk8rk7LhS9c20A=;
        b=LdwKhmxLhAAyX+R4YMzcRDNw9sp9KoXkk1o/tDjReXEf2DOG25xe4gOnQlNonX88Gt
         Ow1V5OGjbEN/W9vSujoOBJAxbvD0c0cJ8s0UVwaf2xlN+ZoOhh3Jcm/nSS0fTCSE877Y
         +VyHcdCUEE6UT1x6AYAMQnWm6M8yvYoaT6cNa+xiGh5ZaEfA/TD1+OupnhpH6LQNh1lX
         +uHYa+TrDGF3dvxlFrXn9XYyCvDljuMk6FQKQrMlgbSdKWzTeA+vq1LOrZqs5WjMjuul
         t2mRm5cuuszGxskUHKZk/8xrVQ/AVWAU+x2KrqIhKrpDlgrPByaOY+xmWrqu9slj0WT0
         4cOA==
X-Forwarded-Encrypted: i=1; AHgh+RovTP3pwj6dAhV/n8X2UZxodNhmhqqAtSu//rEJex+wyXWIyUb3ymDXQu42NwqidBTrRrbQ2E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQZrNqhVW1MEkN8C3+OOU455MQEZwqKaRZTAQgtJGggeQmJRa
	SAMUc0QOR93kUwVmhrWuTcJshAzQDnnGX2QDZYWdH2znP0wQgTgmyZb3A2cxLrMGsvlXtLFrJMh
	dcdtiogsybl6i5QkXOPjBIvYZG/lDfdZxj48k+k46
X-Gm-Gg: AR+sD11wIdAr7fNf1ZBFtOQAvZf8BnMKUU9GSrlfWpjPZxuVMLfbb5qITE/MvnBXPXN
	Oi+SHbjc9xF/D7Tumb8tQv7iwjsmg/T4FGD6uVmL37erGr4qn64d1i89A4CnXTHL6Od57+xvItt
	KUs2WbeS9W6rVd9c3O4/PLAfuelJtOBgODl/sHFAhA9htcmotya4fJUy1onyacmbygpZMm8Wq6h
	IPfZQoz4+7n1nWrdSgupNPiZgLbv/iDzB3scRvPc6r+VDK5PrnCzjkC7bWSvSNsBoI6GLJWhzgl
	FGM6Qk0Ag2Di3UIVuvDTDTD12pwlV80ClwRs/ABsZXjr00oTp5zGpXr4A3a/FNJDzCn/NPSBPw=
	=
X-Received: by 2002:a05:620a:470e:b0:92e:5c0b:a6a0 with SMTP id
 af79cd13be357-9310389253dmr468618585a.26.1784830817739; Thu, 23 Jul 2026
 11:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720072622.3541873-1-edumazet@google.com> <20260723092203.5b1470f5@kernel.org>
In-Reply-To: <20260723092203.5b1470f5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jul 2026 20:20:06 +0200
X-Gm-Features: AUfX_myZV_Xsy7j3MPmS_2soQ45VqVBC-OOJTPkNQEmxso5V7oR439xsnUxNvLc
Message-ID: <CANn89i+8zN45ytxA0B6O2yW+OU4OqG99NBGszkxqRgzzvWWOzw@mail.gmail.com>
Subject: Re: [PATCH net] vlan: fix skb_under_panic() and races when toggling
 HW VLAN offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Tangxin Xie <xietangxin@h-partners.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Hi Eric,
>
> Looks like this broke VXLAN tests:
>
> https://netdev-ctrl.bots.linux.dev/logview.html?f=3D/logs/vmksft/net/resu=
lts/742304/2-test-vxlan-mdb-sh/stdout
>
> AI bot says:
>
> The NIPA CI detected a regression introduced by this patch in the VXLAN
> MDB selftest (tools/testing/selftests/net/test_vxlan_mdb.sh).
>
> All data path forwarding sub-tests fail on both normal and debug kernel
> builds, while the control path (MDB entry add/replace/delete) tests
> continue to pass. The failure is 100% reproducible across both runs.
>
> The test topology uses VLAN subinterfaces (br0.10, br0.20) on a bridge
> that has a VXLAN device as a member. mausezahn injects multicast frames
> from the VLAN subinterface and tc ingress filters on the peer namespace
> count packet arrivals to verify forwarding.
>
> With this patch, `vlan_passthru_header_ops` has been removed and all
> VLAN devices now unconditionally use `vlan_header_ops`, which calls
> `vlan_dev_hard_header()` and inserts an 802.1Q VLAN header in software.
> Previously, when the underlying device had `NETIF_F_HW_VLAN_CTAG_TX`
> set (as veth does), the passthrough header ops were used and no software
> VLAN tag was inserted.
>
> This change causes frames injected from VLAN subinterfaces in the test
> to arrive at the peer with an unexpected software-inserted VLAN tag,
> breaking the tc filter matches used to verify delivery. Tests that check
> frames are *dropped* still pass (the frames never arrive regardless),
> but tests that check frames are *forwarded* all fail.
>
> Failing test output excerpt:
>   TEST: Destination IP - match                                        [FA=
IL]
>   TEST: Destination IP - no match                                     [FA=
IL]
>   TEST: Forward valid source - first VTEP                             [FA=
IL]
>   TEST: Forward valid source - second VTEP                            [FA=
IL]
>   ...
>
> The pattern holds for all four overlay/underlay combinations (IPv4/IPv6
> =C3=97 IPv4/IPv6).
>
> Could you please take a look? It seems the unconditional software VLAN
> insertion breaks the VXLAN MDB data path when veth (or similarly capable)
> devices are used as the underlay.

Ah right, we probably want to keep hard_header_len as is, and instead
inflate needed_headroom by 4 bytes.

ie in vlan_transfer_features() have somethng like:


        netif_inherit_tso_max(vlandev, dev);

-       if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-               vlandev->hard_header_len =3D dev->hard_header_len;
-       else
-               vlandev->hard_header_len =3D dev->hard_header_len + VLAN_HL=
EN;
+       vlandev->needed_headroom =3D dev->needed_headroom + VLAN_HLEN;
+       vlandev->hard_header_len =3D dev->hard_header_len;

Thanks!

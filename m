Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.230.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793097945;
	b=OzY+FRHx/fyMhul2s6l4ckcYVVT4q4XoLJrsz9GJa/E8GgRKx+FCnBI8FiiDPT3mvCP7
	 etBv26SWrPqOvu/b6TqnRyBY+mcI6VjwpEjQBmD7wgo7maaCiy5RoxpQOSoNX9/13l5yk
	 dYGXXRCPNS+KNJp6aoIWzHi+N9UGVxKQDDabkqJxGfh/3kc0cHS0rRYjp8lfnrhAba6gu
	 FhbZHm+UI+brWz9wCEuUy7gFDYVCdHSgGpNdkeTg7aklUTYaI+jKTEqJufIjkVpRltE0p
	 1Q5vw3vECImI5a13VLKZgFy25K9TVrG5GdA+U7CAJGMgVjTTqPg/35nGV6VKhwnx+Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hTokF6f/74TTsrDj3bp7weKrYI5kvTRFYSNs6uOsOws=;
	b=MQnbFERYJ+mYq1c45NERI+R3Ucg2PDWDuElzCldL7hbzAK5Oo+rMJZURrYUPaNaVS9Da
	 Hner4ell0C+B1cTBlQzacJXtDoYg1wTxSJwyc7Md3NVGGSi/m5htVN3YzwkJKxCesx1XI
	 32auMVB4fw3+vl2qeKCP7iojv6yjwUGBkVL2e4qDtCEojGNFCyUjuLci93q99WZJB7klz
	 JAMKLCYX95j3d5t1dK0TQ8EMiPHvWWeXwm7z18J2y9gqlYetFtIOtAX4sQI3wnWsd3GC+
	 3SZn8Yx3GxkEPKYPbpWK6v2Rrf0t1j5KRE4O1LKX8vrTyAjYyX7nuCh9VwcYf52p47w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sogkfs8Y;
	arc=fail smtp.remote-ip=74.125.230.69
Received: from mail-lr2-f5.google.com (mail-lr2-f5.google.com [74.125.230.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169A606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6169A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sogkfs8Y
Received: by mail-lr2-f5.google.com with SMTP id 38308e7fff4ca-3ab2ac79b69so23026961fa.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793097944; cv=none;
        d=google.com; s=arc-20260327;
        b=iwxpUyruxyuGI993IvLviGWeNoG3+d4Ct37gYY2+Z/wT8XxVFaLIDraCazg7JheDPS
         /tokYV8IVCu2OmkKMY1j7xiYBumd2ZegjKsV0v8GDz/q5s5+oHhampjF0zTVt6xsVk5u
         2ZzDO3imksqxp9kmmJib0FPThFdzOv7H9toYWmQs2zJmCmv+4pSge1Z2JgzLpADIx2vO
         ZRiCL63aa8triMse5lOX0q/TTVEfroeXEJxCIK5Ctuz/H4XM/3ig1vt5BgamHNgqPfbI
         dfG9t9kjqw6WNGBnO2od+rACB4RKhTmwxpFzll/3mglHYMugval8gIMZRb6GMT23URdk
         EcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hTokF6f/74TTsrDj3bp7weKrYI5kvTRFYSNs6uOsOws=;
        fh=FZB7py+8sVLUqQpUlPEZ2uFnw9DYh0Qcxn4MGmW3XJc=;
        b=lavWHfvVut3APIPG04ST0ONpUy+S4wF8gj5wMM+TikkLfb0eaAkgENbg8oG6wgaTh0
         PukLSGcWs6O1ONPWAXZC8vn78HsbcaZWy4N+GMZ/qP380rjxDE9SPYiCnWQgynd98awX
         rWnsTLQi0GrKvFVexGLX5T8TkBzxjNWAem1uqiGbhD7xOO+AkrZqZT2mZY6AJJye/gBq
         feU/raPD+q7KJVrzOsHBykFy5v5Grfb15gjSc9joierhdSWFhk7BkHFADOjKXmv/CeAQ
         xgB36FtsUJ0iQVgkM5LtuREFqTqPYL6hBZA03D6rIBddRf1iXx4fHEXUppfB8+7gjqNy
         jHuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793097944; x=1793702744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hTokF6f/74TTsrDj3bp7weKrYI5kvTRFYSNs6uOsOws=;
        b=sogkfs8Yj7sLD1GRZUKprdjOlswEuPvl0xyZHwAG0iwY476oBzdktP8aRfeuCj+QEU
         h6aXCTXRsU3Yh7oF6mda1jsjjtbiEku1MBHqoMyLt+I1j7oj4hgW22Z/unEMrUU2n5ts
         5kc7EptSgzWes73Knoo0y4sPi7VLDrs01ZFtI79AlzO3Wv/67i4HT2J4S0cq44Y1J2TQ
         /cmyG57cyRboHEPJ+CLmKYX8mQ/yiLCQPpDFk/JAW2KqgqQ/+3gsM5dREycEm+1tb+wz
         /OWiFY3481x0kpqQmvg6ej5GanWyR8/4rpyAb+s62N/7MBRUrG9P95ZjCVaXHuUwYrSN
         TMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793097944; x=1793702744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hTokF6f/74TTsrDj3bp7weKrYI5kvTRFYSNs6uOsOws=;
        b=NQzir2KRZ9cIct6NQB9y1w3IJ3uGOAM+n28N/vKEwDzIrZ3Z7n3EPv/rvece6Zly0D
         b9YtpR9wHBLzyI/xEQ8E4QXYBrQwoAIdudscPh7Z2qB6CH1gaZO2nZH6Z281VzcA5JBD
         dc2DcJKZrcY3BcoX8iOOTCjmdKoLtD6UNPVRgJyhouGpXuhK2yUMSsrocWco6q9kA1xA
         38PYJJbFZFV7iifgFiJ7DbAiyb3QB4DiDWMCd7WNzZiD7Mb3RKZlTvLAHej08YiNTA/o
         g19GWtaFJgrk3dNz2LMriq42G1h0mKWpEgmSpb8RGVzbB6p8pLdq485U3xcGrYW7xiVe
         gu9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwAQQDUV/GhDE3Z5LPkvLv8SYB8PwN6Oi3gs7Qi7IU89PFe9oBCMJ7AkTTJvjyZTW7ZS0THcqk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkGEzo5Yj6oOzyVl+XHpDZjPZVnfE8eMaxWcfhBZjgSCwL5NzO
	akMRJaxuOQn94g7Ettqqi1HwKwTS+vMgjeyw2uBExSygk8g0ybVBljxd6CuHBJvoVHwRfSwKZu9
	aKiPl0LMxMTVtfVTYV9MqWcOWejMC+Q8=
X-Gm-Gg: AYBFou1lzzODCdtoqUFcwmrbfY3crnhzgw19UppWtMJyijU80h3JigJnJFvZQuxF+Xs
	4IZuoEgDL4LQQxrvlTm/L4vZba/bMHK87lxF2ycZxLiqsfIDWMlOGbQQj2IaFFbTw+0ytgLKhm4
	WpQGaj9yKLVX645GIHgVR12ifBBB8GRkFI5+0mcxwasZMT66fsG6kxJ3gtQq/pDDCY5817EHmZn
	EMxcAvzJFDHROGba+QLey3vxO/wsfI4lFcIpPaXAn9TSLXFr9SaYu6zQNsgmdtmnUCLz/qFhOA+
	6We4egYhi4arZVRWqOqTFA7CDb/kpYjpzsmjFm5r3P2GIKAe7072H5WQFZJ8yCcFw7QhymVQn0G
	SINF42qZznzIyeJ4ikCxgAztEcxny+cSG0JJ6Eg==
X-Received: by 2002:a2e:8a88:0:b0:3a6:636b:63c5 with SMTP id
 38308e7fff4ca-3ac6fd3b986mr20717081fa.16.1793097943292; Tue, 27 Oct 2026
 03:45:43 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020034531.1420194-1-bsdhenrymartin@gmail.com> <20261021102614.GA3351287@shredder>
In-Reply-To: <20261021102614.GA3351287@shredder>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Tue, 27 Oct 2026 18:45:31 +0800
X-Gm-Features: AclHuK8Zgr31J_CCsucf-oYLGgEzAL6MqaaFwHvcjtoZy3YHWAsoUhYfxrWtFnQ
Message-ID: <CAEnQdOoQRuH8A=HnJqruN_kp5exzTwV7bK-LZUVo=LGuSMmgNA@mail.gmail.com>
Subject: Re: [PATCH net v2] vxlan: reject adding a remote to a nexthop fdb entry
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Petr Machata <petrm@nvidia.com>, 
	Ferruh Yigit <ferruh.yigit@amd.com>, Antoine Tenart <atenart@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Seungwon Bae <qotmddnjs@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

No crash and no leak: the appended vxlan_rdst is freed with the
entry, and vxlan_xmit() follows the nexthop whenever f->nh is set.
What breaks is state consistency:

- vxlan_fdb_notify(), RTM_GETNEIGH dumps and the switchdev FDB
  programming all prefer the remote list over the nexthop, so user
  space is told traffic goes to the appended remote while the
  datapath follows the nexthop group.

- Once a stray remote is attached to an all-zeros nexthop entry,
  __vxlan_fdb_delete() destroys the whole entry when the matched
  remote is the only one on the list, so a dst-scoped "bridge fdb
  del ..." or "ip link set ... remote 0.0.0.0" tears down the
  nexthop entry, not just the stray remote.  Same class of
  inconsistency as commit 98fc57d16744.

Test cases added to fib_nexthops.sh in both ipv4_fdb_grp_fcnal() and
ipv6_fdb_grp_fcnal(), mirroring 98fc57d16744's style (rejected
append and rejected non-unicast replace on a nexthop entry).

A sashiko pass on v2 also caught that the rejection would leave
"bridge vni add" half-installed, so v4 is a 2-patch series: [1/2]
the fdb guard with the above message and tests, [2/2] a pre-install
rejection in vxlan_vni_add().  If the consequence description still
reads as net-next-only to you, I will re-send there once it reopens.

pw-bot: cr

Regards,
Henry

Ido Schimmel <idosch@nvidia.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=B8=89 18:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 20, 2026 at 11:45:31AM +0800, Henry Martin wrote:
> > FDB entries backed by a nexthop group must not carry a remote
> > destination list.  vxlan_fdb_update_existing() currently appends a
> > remote via vxlan_fdb_append() on an NLM_F_APPEND request with a
> > multicast or zero MAC even when the entry is backed by a nexthop,
> > breaking that invariant through three different callers:
> >
> > - "bridge fdb append" with a dst on a nexthop entry;
> > - "ip link set dev vx0 type vxlan remote <ip>" (vxlan_changelink());
> > - "bridge vni add/change ... group <mcast>" on a vnifilter device
> >   (vxlan_update_default_fdb_entry()).
> >
> > All three reach the append block with nhid =3D=3D 0 and a PERMANENT
> > state, so they pass the earlier nexthop checks.
> >
> > Reject the combination at the top of vxlan_fdb_update_existing(),
> > next to the existing nexthop guards, so a refused request has no
> > side effects: placing the check in the append block instead would
> > return -EOPNOTSUPP only after the entry state and flags have been
> > rewritten, skipping both the notification pass and the err_notify
> > rollback.
> >
> > Note the resulting behavior change for the two rtnetlink callers:
> > operations that previously succeeded while silently attaching an
> > unused remote to a nexthop entry now fail with extack
> > "Cannot add a remote to a nexthop fdb entry".
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
>
> I agree that it doesn't make sense to append a remote to an FDB entry
> that points to a nexthop, but what are the consequences of allowing it?
> Does this patch fix a crash / memory leak? If so, the commit message
> should describe it. Otherwise, this looks like net-next material
> (currently closed).
>
> Also, please add a test case in fib_nexthops.sh, in a similar fashion to
> commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a
> nexthop id").

Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32F3FF1B5
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762845; cv=pass; b=VX1mFBs08Im1kXjXLWhlW3m9xF4pM1ojB4LfyNbHa3eWhRasVPRdeN+patbTeXCSbZfLhJyjfbaYuN80drZtm7/f3TuFOXjFq18ySmMziQASrHj0Mww9+Dr+llIjf2Bp2QGDlsS3TpU1CPsAAcQEOZkd0knWyDfK3aZDk+u8/Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762845; c=relaxed/simple;
	bh=xcsQHwdrRWYkM4QTQD70RTNUYZJJL7rpA0TJMV4kEk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+UvXi51hXDJOcXpe5dUd9GmC1RT5o68pM1roG+MzL6BieHq3G/y8rYOehBXzBMszUF90gZ64nDLpYCft71LF3EVgKKpYHpPv8TPtQGMgbNS8Dq6gvLadr892ML5BMeoHW0nCzzrDntJhAVtgiui0oTWqNus5nv5qH+XUs2pFhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiTX8rLx; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiTX8rLx"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5302b692c8eso28907641cf.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788762840; cv=none;
        d=google.com; s=arc-20260327;
        b=d1lWAiopWVbBtcA5Ic6mYpRA6ecAkld83zdN8jRsGdoy1mRpHUfdHuw6lTGz5lAM6l
         hgDXacriLGi/YQdAC9YvMIILK981cMj0vQrosOuNaPk8e+vEIFbWCojjBxS7sgCoSmlt
         mXbhqimdybMsQP6msoxtqKkitO/4iesZGGl7CzJOvNEAO0Y1+LJAHkiuqe8u/QbPAHiI
         Z2q7XPprXKW68Wn5fC5yBTuTeIFfFn7A3a9UhMSFIiy32ozXRaWnTI3sZdvzGd/ClZoX
         XSE1CnYtuc7ktAlTDEkcXl1I30Dz91zlrjX2fIHdEnbI2xDg5DRB5o7R4hY0zP8o92aa
         a5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G1eHW2V7q06p4N9KdZ3EMVmUuYgRalVGJGGybQfpM7o=;
        fh=FWLaimJoyfw6rF/A1cHXNQ4nu5ptjueFJhMH6X3r7Ag=;
        b=PXiA8vWXd7zWMcNrMbfE6CqHI0omsfv1VOjl/SulvbY5ME2ioMTQdC8Smo5UfzkaKh
         O6p+E1WRtIV//9UR8+45td+pIlWjN0xkMO76EykZygMAVbX4QFBm9P2JSt2SzPytRtPM
         JuA501dGi8ofaDkby4k9VPOu420snohJXmwq1TvvIwybQSM+7ewTxUsDicTLfJ3fdrZL
         odWYsTjHKupJ5bEmNCFTkxbtYYotoVv5/cJwFfDyzQLVlV+rLAi1zzP7mnT3ruGeZsyo
         j+KNfTCsL1DIawMvrQezoOgWiuMC2RU0tQ7/Uu5+NGhDjPOuh1wQ+JfUoPcxkRIKRDFp
         P6DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788762840; x=1789367640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G1eHW2V7q06p4N9KdZ3EMVmUuYgRalVGJGGybQfpM7o=;
        b=AiTX8rLx+BEslb6RwH4QELfjBJwVN2H3LuLvB+6TSxaMiNMelK55eiLmDqIfkos3WJ
         E21nonG65/9NoGK+0hP5Ft8J7B2yDcSp+Rjk823AJPUz+2PUvig2eFtLSl8aze3HTAN3
         MVjHk3yz3WBgAdMiDy+N1l0dlNB9b4Yc6PiSlCc5LIJ0ZrHcfWKUEPtAjGNuHfhwcylR
         lF0TdqZJYfubUDUVwazQP2BvZZ/El29RkeWnvnQdrLcLQjjmfnQ51nHk+66pFuEUVtQM
         IDZ8HME8gRJZXT+nL8RoI4EexNlpyW9wIGm7HtnWgwFnJY740/6DtzTg+QhljI+M+BFn
         nuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762840; x=1789367640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1eHW2V7q06p4N9KdZ3EMVmUuYgRalVGJGGybQfpM7o=;
        b=ijAlOm1tOkysBtOGlEfvqUXJcYHk0pEwqypZ3n6tr63bSMP2IM1nBZApD3jlGRyoMx
         GJros7ltqArrIwCObuNUueRU5+W0KhFwr7bH1Us77eISFGxuKR7e90GD2FcwsnRXJelG
         Q5+dYU0bBZIpOJbDFaKBPQgQHHR8NN/Uh8VoalFkdZXNoZlsFTB1O3YC6JANwZRKNLoW
         NShJ8opwX6AvXb0J+ktp42NoEVoCOEe6sS4lVYS5zeC5HJl6TxnkDC7Zg3nWeZfy6ZDj
         ruTvv4N1bwFMimGQ8ShcLlSRI9DOt7eSQlHsD/U/P3wWZ9Eqdh6tT5Wb193a+0xEysbK
         DUig==
X-Forwarded-Encrypted: i=1; AKwUvBwsNM6GSX0fm+G/IDD9I0ok07te3rL+UbM+NUQhJavq7TSMGHELKT7d9HRf3fkI513a5A49yj4=@vger.kernel.org
X-Gm-Message-State: AFuF++kuVCQMvJ8Z9H0UeVLkTZ48dW+SD1tgjrzhUad8Exv5pu8r0r3i
	apfHxZdLW+eSflHiIeHZwnbRjpbTM+SYAQ2C88npdf5+O1o8Xais9Cg1Fu40BNhqsrs3T+rkmAh
	uLgPzhaPMNF303/2WZ1sMr2vKxXgMpFu0+hOCDVo5
X-Gm-Gg: AYBFou3zxTU4fbdJ3zZ9Lbzddxhkmfu1LAhih5axQFsZC5ENUjZ/O3305t5rZIYh73Y
	FJDOIfIRxM4gMQxh8Gb87T0nBvQzz4JFAGY1hHcagQRcvO3m87WMRP7D7UpCdlG/cWU1/rWelso
	u1+JjgcTeZWdH/sit0II2p8P4+gibZruVmNQbbtKRAS+2cuZCOmKtoD3HBw8n5t1lCNwwk2lgsP
	nfB7OC2TMGL2J7GHlrHWpSffMM3aJca47PXAzH12D8cie0XA2pdwxJNA4JZhZbqYZjRlcl6TZzq
	tXsH+HViRx/NUsPZSF4Zoyc0i3WjHeHiQiMzghgUP0x7Vr2OaGy6XvWz5YjQpTiVlV1pZpHDMRR
	Q1amtCfOpNRIyv5ybrRMcdKYrl4+fcP1OAyJLZ2uGGOZ7ogv1bMAz6LYrbgw=
X-Received: by 2002:a05:622a:4c18:b0:52f:bfb3:ed3d with SMTP id
 d75a77b69052e-53054944d7bmr258043911cf.25.1788762839165; Sun, 06 Sep 2026
 23:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-3-edumazet@google.com> <178876148175.219967.9585071476410633782@kernel.org>
In-Reply-To: <178876148175.219967.9585071476410633782@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 08:33:47 +0200
X-Gm-Features: AcwNN1XGJs0pz339HeOYbu1YqHaywkU2PExCB-7xAL1umY3S0g_snx6N0MJWFD4
Message-ID: <CANn89iKm6fVE4StiX8q0eUJGqf8zxBPAChyVBYORPPF69x8qsA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] vxlan: vnifilter: free vxlan_vni_group via
 RCU in vxlan_vnigroup_uninit()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, idosch@nvidia.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 8:11=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] Changelog premise is not supported by the code: commit "vxlan:
>   vnifilter: free vxlan_vni_group via RCU in vxlan_vnigroup_uninit()"=E2=
=80=A6
>
> --
>
> vxlan: vnifilter: free vxlan_vni_group via RCU in vxlan_vnigroup_uninit()
>
> This clears vxlan->vnigrp with rcu_assign_pointer() in
> vxlan_vnigroup_uninit() and defers the freeing of struct vxlan_vni_group
> to kfree_rcu(), adding an rcu_head to the structure.  It is described as
> fixing a use-after-free between device deletion and an RTM_GETTUNNEL dump=
.
>
> >     vxlan->vnigrp is an RCU-protected pointer accessed locklessly under
> >     rcu_read_lock() in vxlan_vnifilter_dump_dev().
> >
> >     Currently, vxlan_vnigroup_uninit() frees struct vxlan_vni_group
> >     synchronously via kfree(vg). If a VXLAN device is deleted concurren=
tly
> >     with an RTM_GETTUNNEL dump, vxlan_vnifilter_dump_dev() can suffer a
> >     use-after-free when reading vg->num_vnis or walking vg->vni_list.
> >
> >     Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metad=
ata device")
>
> [Severity: Medium]
> Is the described race reachable in this tree?  The RTM_GETTUNNEL dump is
> registered without RTNL_FLAG_DUMP_UNLOCKED:
>
> drivers/net/vxlan/vxlan_vnifilter.c:
> static const struct rtnl_msg_handler vxlan_vnifilter_rtnl_msg_handlers[] =
=3D {
>         {THIS_MODULE, PF_BRIDGE, RTM_GETTUNNEL, NULL, vxlan_vnifilter_dum=
p, 0},
>
> With flags =3D=3D 0, rtnl_dumpit() wraps the whole callback in RTNL:
>
> net/core/rtnetlink.c:rtnl_dumpit() {
>         const bool needs_lock =3D !(cb->flags & RTNL_FLAG_DUMP_UNLOCKED);
>         ...
>         if (needs_lock)
>                 rtnl_lock();
>         err =3D dumpit(skb, cb);
>         if (needs_lock)
>                 rtnl_unlock();
> }
>
> so vxlan_vnifilter_dump() and vxlan_vnifilter_dump_dev() run with RTNL he=
ld,
> not "locklessly" as the changelog states.
>
> On the freeing side, vxlan_vnigroup_uninit() is reached only from the
> vxlan_init() error path and from vxlan_uninit() (ndo_uninit), both of whi=
ch
> run under RTNL via register_netdevice() and
> unregister_netdevice_many_notify().  Doesn't that make the dump and the f=
ree
> mutually exclusive today?
>
> The dump also does not cache a device or vnigrp pointer across paginated
> recvmsg iterations: it stores only an ifindex in cb->args[0] and re-resol=
ves
> through dev_get_by_index_rcu()/for_each_netdev_rcu(), so a stale vnigrp d=
oes
> not appear to be observable between iterations either.
>
> The code change itself looks harmless, since the remaining readers alread=
y
> tolerate a NULL vnigrp:
>
> drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vnifilter_dump_dev() {
>         /* RCU needed because of the vni locking rules (rcu || rtnl) */
>         vg =3D rcu_dereference(vxlan->vnigrp);
>         if (!vg || !vg->num_vnis)
>                 return 0;
>
> and vxlan_vnifilter_lookup() in drivers/net/vxlan/vxlan_private.h does th=
e
> same NULL check.
>
> Would it be more accurate to describe this as preparation for an
> RTNL-unlocked RTM_GETTUNNEL dump, and to drop the Fixes: tag (or justify =
it)
> so this is not backported to stable as a use-after-free fix?
>
> The next patch in the series, "vxlan: vnifilter: use
> list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()", repeats the sam=
e
> premise ("runs under rcu_read_lock() without RTNL"), and the RTM_GETTUNNE=
L
> handler is still registered with flags =3D=3D 0 at the end of the series,=
 so the
> same question applies there.

Not that Kuniyuki pointed out that the patch was not needed, it was
dropped from V2.

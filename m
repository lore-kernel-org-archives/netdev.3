Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793247589;
	b=1z6Q1fQc5KMuws9URqldu5QzZG+PaVq3/a+xay9tfMO6BCafqwCdZ16A1+J1T2RUAQVc
	 IN3UOlBxd/2vAugT7+0cNa/zoz3eEogWiU3n+AspRwvdpiXyc5UVAuMaXtGEO4MHsdOL0
	 RLvFD5L9hc19tS0kToF1TDAnHF5kkabWyABJc9W0idICS6YIWShFqTVNnKYfRG+l1w9Sq
	 cHz0knupWvREnK2WJZdwMQhIcFWNEHLj5ZTfFxQZ05lw21GEyV4cNKZAH3YtXJ3qyD0O1
	 hXO6sXVvULoMeQkshon/2hi5z4LiR3bLg4APhBEZPmlbhrrVD2VmyBe7Ei8lBfiaBjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=L2k3UmlSrdqSAZ+HJXhHNb2h+Di07rclplpAGL50AO0=;
	b=1i9bYbW0lXBrwNTT4jz30H3TZFOmNTtlUxoPTrtoAhPR9BW/aObvS5nqR9ifrFQrFuiZ
	 YyXHRMF2Dy8ZkeB2FJLKqm/j6ZV+6aWgfpy0d8Nu7xP35pDm7BwaaQ2x++HQeyo999POs
	 f3GOMxmCoyHSK5BSlGCY4Txve7azLxcZhrpX2G560tqM5HAz0+jdjUmBumkLTtfNaPvrS
	 uWSEhl6z/XTlHoBCsY0UU6tbmAynf9tlGTs+Vf3gi3WHDbTrLv3RDAkXr+ozT/QU9o7FH
	 qyNCeFs1psvJIl9FPFiX7J6ZCJY8saI31GoqkINF45UOTNTjvc+ea5C+oC/WEpZPdXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HEB212IE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADED1606A31F
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 04:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADED1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HEB212IE
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ba3b1199f6so1787006e87.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793247587; cv=none;
        d=google.com; s=arc-20260327;
        b=cqCRg9MKFM1ai2jwJZTChZUPtvA6SZ7uhen7YEcmjNR75xYJ7HFY8cVQVus80OCll6
         RsLZbBbxFLVjD9DqquOApQ8VVpPKgRe2FABaaPs8PVv/hYkY4ycP4DWQQEb4+OepFkTz
         525nfKy34UZh4gRHzGHhHT/xWi4SX6YFZCeOqJ0ZF8Ih6nmAcADaRRDjx5Wmh1IWvpyQ
         yc0D9KIGR1SYHKOLUwklO7kbl1qBtR76bvWkPFINVH/7coo23XDc8DlZSVO4awTsbSJM
         VipRpGGlUqSkjqPQ+hJIlU23LQVV4VCnxkpvIGzInU0A10oHIk75d2kkdE+ED6PDOzDt
         8xUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L2k3UmlSrdqSAZ+HJXhHNb2h+Di07rclplpAGL50AO0=;
        fh=4F1bRD0mO1uCDTMUvhESAIZBr+pmAMIEyKYP+TCWIQI=;
        b=n4P+1b/WgeNOhy8du/TuGpRxr4uLRY3uTDPIb4Yk/IpCMWMNTD/17ooBUynVRoBX3a
         Kud1uCbP1mWPyTSYnlbss6kdlA0Ayd1ExFSAeT22e40ugJU+3B27a0R/VZa8V8NY2iK8
         B4jS3TerJv0a32LZFEEB0d6o1ub+nJ2DG4fK7zmfQceg8YbIdmKW9SYy1qhol0hhGLts
         kq39CKkDX1fg8Uf0aMVLw4AxEREK5YjgtHd6LHVW5MTTK9zkZrJIu8Co0UW25O9fIPVb
         S51i1dW9MOZb/Df8nicRnFeLmKXPaDjaON+NcwOB8lc7fHCwEneC6HeIu/4Eh2mB6sFy
         57sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793247587; x=1793852387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L2k3UmlSrdqSAZ+HJXhHNb2h+Di07rclplpAGL50AO0=;
        b=HEB212IEFBUQDlu2rPkuO8dx0ut1v7W3ydXYZjWbXnLUNYBMlYQU33QP/tTkIkL1r/
         5/wvnzexmSUOKW3reekBXet0zBuiHkP5bbRbd1eh+S7JIfNq8Qi6dfPSxzGsTHcSpkXc
         w/iPpidZ16f20j8+CmZI2woOCkRiONaOFhaTJUb4G9D83tuUfotzDK3VLN7fmrzHkAVq
         eCFcvG3IOjpUP/7PY0Yj9Wp6BYiB4je+4NvWciSZN3YtZ8oBhlO++iPsNPUIHZzIpPrf
         4Ike7PVongnfxMPzChYKRQ/tI4ZIbpj8ILoPuHlFK+I+fM4/R7W1MeBQERqLEq7p/aaW
         M24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793247587; x=1793852387;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2k3UmlSrdqSAZ+HJXhHNb2h+Di07rclplpAGL50AO0=;
        b=DJRvQ40dIAPwRNVHJvWHHJmYdOGeu3bed3BB1vjHxmghwNtlGFZoADb3ak04xIZThk
         qqmBIBKVRgCxf83qElJw1PJX0TscRJmL3pKKEtmdkV0f5a5hxzybvq+sl2R7BfdjeadQ
         guoNsaIb962QyTL8nqGFXFiGp/xaQSOMLZo8ICfHrXKlosBuLoysznFruisHZL9OFAcG
         xH136iyKK/5v5at2sni+IZlbs+DKBHVvxymSYy17WjIUTaOMA6QXqRkfNHisxd4HWkcN
         FR63HujRxpb32Er2lKJBUWCcaCqq5iTMHC7/8w3yYczyvn3C5kLYZZ3p5+kD0iUwA9mR
         V9CQ==
X-Forwarded-Encrypted: i=1; AKwUvByHzys+nYRb3g8bP6/4bGdITphOKynnzgHAp8SH//WBmHWZ5vIXPonOxQkKKr+g7rpnE218O4k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIczgZFS6I+QlGuG25VrY6nv0q+ReC58AypSUjjSdQW0cYWsS1K
	Hx/7fCVJVFrjsD7LKx9J2gjlmfNZUGxnCEj/erH1QMgxbeI6ayq1185oRfnuRw10glQtX97C8yT
	Kfssoti4uTWUp7WzRXIySTEFXSCcsCj0=
X-Gm-Gg: AYBFou37Y1rr4aVlTmssWSyNFDodWEwOb1sjVJwK+u4JR0dYTcCdxcSXDRyzJXGf1lD
	CZqdIPZbpWfE4lg+FHW2O6dZxawg3iiB+TjKjxjh2k2PLU4IukGTeB8ce8sR54tCQ27/GmeH8Hi
	0rj5K6p1tdSNHP4JNJsqTJ3HESJtEy/ttONUzsRXWSutOa7thnhNYPvGpKUS3sfWAg24zlhxIGC
	6yyXHF+Fo5i7To5a3t1SRuMv91c6WrAiz93Exv9VOIjb3LBgfwpghbeectwfx+m0M49YcmFG7vq
	Z1SGL5qayewxCb4HXZK9LLlkqMp9vW/QJ8f7IWddVNbZ0/iwm+pKSj8gql7AHyCy7FlY7GwufTF
	itreH8ceqb3EMAY897RbM/S09pobHD3z4/7WqpZ8GfFzDuKvIcCsL2QuYgw==
X-Received: by 2002:a05:6512:6c6:b0:5bf:a46b:5546 with SMTP id
 2adb3069b0e04-5bfcad768b6mr1683276e87.64.1793247586539; Wed, 28 Oct 2026
 21:19:46 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027130623.3136658-1-anilkaushikwireless@gmail.com> <179324692107.3134.14443689892607921337@kernel.org>
In-Reply-To: <179324692107.3134.14443689892607921337@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Thu, 29 Oct 2026 09:49:35 +0530
X-Gm-Features: AclHuK9xKynmmPtswLR8RyT2-XkrOflzEjyrGurfI0hbR5tbnbbT78k1otsVn6M
Message-ID: <CAG0Mgm_DxY=zZwBW3xEeNE-1LC93OWPkO4HHw=qF2Qhti-Mf4g@mail.gmail.com>
Subject: Re: [PATCH net v3] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
To: netdev-bot+sashiko@kernel.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, nicolas.dichtel@6wind.com, 
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 9:38=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] An unprivileged local user can still receive gtp multicast
>   notifications (PDP add/delete and echo responses) by joining the=E2=80=
=A6
>
> --
>
> gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group
>
> This patch marks the gtp generic netlink multicast group with
> GENL_MCAST_CAP_NET_ADMIN in drivers/net/gtp.c and with uns-admin-perm in
> the gtp netlink spec. The goal is to stop unprivileged users from
> receiving the PDP context add/delete and echo response notifications,
> which carry the same data as a GETPDP reply.
>

Yes, this works, but the gap is in the genetlink core, not in gtp.
genl_unregister_mc_groups() clears the members of the IDs it frees, but
nothing clears them when free IDs are given to a new family. So it hits
every modular group with a GENL_MCAST_CAP_* flag, psample and
drop_monitor too.

This patch is still needed, and it does not change. I will send a
separate fix to net that clears the members of the new IDs in
genl_validate_assign_mc_groups(), like the unregister path does.

> [ ... ]
>
> > diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> > index 86c8c88b702cf..1dd32e979cf59 100644
> > --- a/drivers/net/gtp.c
> > +++ b/drivers/net/gtp.c
> > @@ -118,7 +118,8 @@ enum gtp_multicast_groups {
> >  };
> >
> >  static const struct genl_multicast_group gtp_genl_mcgrps[] =3D {
> > -     [GTP_GENL_MCGRP] =3D { .name =3D GTP_GENL_MCGRP_NAME },
> > +     [GTP_GENL_MCGRP] =3D { .name =3D GTP_GENL_MCGRP_NAME,
> > +                          .flags =3D GENL_MCAST_CAP_NET_ADMIN, },
> >  };
>
> [Severity: High]
> Can an unprivileged user still get these notifications by joining the
> group ID before the gtp family is registered?
>
> The flag is only checked in genl_bind(), and only when a registered
> family owns the requested group. If no family owns it, the loop matches
> nothing and ret stays 0:
>
> net/netlink/genetlink.c:genl_bind() {
>     ...
>         int ret =3D 0;
>     ...
>         idr_for_each_entry(&genl_fam_idr, family, id) {
>     ...
>                 i =3D group - family->mcgrp_offset;
>                 if (i < 0 || i >=3D family->n_mcgrps)
>                         continue;
>     ...
>         }
>
>         up_read(&cb_lock);
>         return ret;
> }
>
> The genl socket is NL_CFG_F_NONROOT_RECV. For NETLINK_ADD_MEMBERSHIP,
> netlink_setsockopt() only checks the ID against nlk->ngroups. So an
> unprivileged NETLINK_GENERIC socket can join any free ID that fits in
> the current bitmap.
>
> When gtp is loaded later, the call chain is
> genl_register_family()->genl_validate_assign_mc_groups()->
> genl_allocate_reserve_groups(), which gives gtp the first free ID. After
> that, only __netlink_change_ngroups() runs to resize the table. Sockets
> already subscribed to that ID are not cleared or rechecked.
>
> do_one_broadcast() only looks at the socket's group bitmap and netns.
> So the earlier subscriber would receive what gtp_tunnel_notify() and the
> echo response path send through genlmsg_multicast_netns(...,
> GTP_GENL_MCGRP, ...).
>
> The same user can also trigger the module load. CTRL_CMD_GETFAMILY does
> not need GENL_ADMIN_PERM. ctrl_getfamily() calls request_module() for
> "net-pf-16-proto-16-family-gtp", and gtp.c declares
> MODULE_ALIAS_GENL_FAMILY("gtp").
>
> The commit message says:
>
>     This fix blocks the unprivileged users.
>
> That claim fails when gtp is built as a module and is not yet loaded
> when the user subscribes.
>
> Could this also be closed in the genetlink core? One option is for
> genl_validate_assign_mc_groups() to clear existing members of newly
> allocated IDs with __netlink_clear_multicast_users(). Another is for
> genl_bind() to reject IDs that no family owns. Either change would go on
> top of this patch, not replace it.
>
> The same gap seems to affect other modular groups that use the
> GENL_MCAST_CAP_* flags, such as the psample one.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261027130623.3136658-1-anilkaushikwireless%40gmail.com

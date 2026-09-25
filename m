Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA903D9DDF
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328473; cv=pass; b=pGsYLQxr63NBP+6pV98xzHt4RAwA5C42aoikaRNmXbJClMWtxMQM5eLbqIru3TYnuZij9ROmwByJv9kMUTyY2TdJHFl7JOrmmKE20PSThPHaREa8h4Y2t1/6nUQ/ftrMfkduU/4VWkH5JfsP64kL1xDuSMCn0u8zxcQPTbY8C9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328473; c=relaxed/simple;
	bh=Z5q+rbktykD/DNtdkcPWya6lGy9YBgzw4JRv8i9v1WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6GwYuh5mtc7VqHzPheL5HIIo8clEcO5qSbqAY83xBtHxs3D2j41XARPMsq3CHjXalCVnKsVvMQyHmCHICSbD+f31bPB7IJg7JTYCV2IA1BzsHYxxsljHZyr0zt42zbYOKHzA/HTkoywfkzY6q9VtJhzp8ATeJxHqcnj1+RUC5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZSvnyve; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZSvnyve"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb767cc97so7886931cf.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790328470; cv=none;
        d=google.com; s=arc-20260327;
        b=U7v6QPThxbtFkkiA6Mp01IVt+TNmdZbo43gtdIgyTzmLTXg5qXC35QAt+EB+A4RYjQ
         Tqod+jIAtK5TUKEIz/i+aw0+5aMeBMQLxVBUv75lzcfWu/OctYHZIhdsyfHoAzRRT3Uz
         QS5kCd9UNkFxDBxd12sSuXYVq5sX25FyMWzGD7i4wjOM+bCfZmTt5zV6uKNguABPgxhk
         IpT4Bl06/lw0lbUpprTFjo94PHR1DUbvOHJ1Y51L/npZSh+k20hO60zrAPARpITaeRdJ
         rhJD6W/gNGtIcXqZr/1z2UAhRcs0TSAmrfvipOUamd09++x2hzmOYVqVtn+VZhwz58fu
         iv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8R69reE7bCSDEqOYnc8T7Z3wrMNCm63YNA9ekTLLEBM=;
        fh=UCyFOnxVaWKB5LBK3POMnRaX0owMwwDl8s31TnFdCUA=;
        b=cM+HpqiA5zZkNsjAemBXriXpA6RuNXm3LkrU4GytzVOYCf9a9C6v2IR4g+uvOLfxE2
         AYAZ/A9DT39fAJlu4CKNztl1u05tvm1jZzZP9ZMKJHWa8evjo/IVmUyQHL6acmdP64zP
         3WwezSfUCdawXkFhyY6agNd0bLbtJuGTPd24VF2PVS8zWoP/k3tfAYg5ndm0kFZ2Ub+H
         T6yteX5f8KyZ9DoBWVid2AK2L1Uh82UILMVxmXYGju5bKxjGdPkcysPwc6wgps/bK9Kn
         pWKl0RTl/4IghdNH2IeE7RNqfNqwsQt8dmTLDjwEwg2tTId+xsurohd+zN4jux5wP/RC
         4SxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790328470; x=1790933270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8R69reE7bCSDEqOYnc8T7Z3wrMNCm63YNA9ekTLLEBM=;
        b=CZSvnyveCaw1wrpMf8iGmN/NXaUnZWnVvTT6yXMarP3CZydtnNicmiY6QqNSdNQo3a
         Lbp9+hC/XRjKB3mQ7/R+czvPZAjGrQo0Drt9p3zZDtu3zRL5ZrX4uCzOEfLWTjxSovJ3
         uFUAIA//lA2rUJtE+qd3DLZCoRhXZ92o24T1I5WsUhMoUIYb+EwM2WvJFEl8eNvfIcI/
         F6PGk5TffeuhkHBowjff9J3JxklcpZG6JewwownQOAl3YLabW7tDxlMIu+qJQnF22qcg
         PdGE7hOkTybrBNI7QiNaRMFG2OX8G++SJWCXO3R1NzkAHkT4G/j7sb9Xu0pc2ZM4ViP4
         3vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328470; x=1790933270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8R69reE7bCSDEqOYnc8T7Z3wrMNCm63YNA9ekTLLEBM=;
        b=U2r+XUbMDrUfxkGmIlJstTnOlnWHexEDkOlrevOXxi2ohiR61arySVxwRK/iiUh/bO
         +WO8amRDyLJFeTYuR4cUteJIjNVn/BYUke1dwhyRXEvkC0+jbIZ52yfpncfsSQYbka4d
         AsEBVWbNRVzWtw6yjfPQsQQrYrY7g83YStA0Fyv1Z8FdQhz7J12X/SuiebUluiZwu4Uu
         vGd2b+N4d8QiKlWxALAan38BUsj0xg5SGBwhsCf7z12Rm5bIFFvXxUW4UY6AHKq2TsU+
         aJy5Y3M2IKbmrJRbu2dNRlVn+0oSJyZbD5h00OqAxzJi9DXQYqMti5jx45RknbNo0AK3
         Yyxw==
X-Forwarded-Encrypted: i=1; AKwUvBwD7Wqyev0pSIz81TTfVTwiWm19Hp3gh8L0KdqDTGglNlOGZOYdV17EAJu5TBxeVlQ2MpxQNDM=@vger.kernel.org
X-Gm-Message-State: AFuF++nHbc8k+0/OhVi4xNm63Vbfiyqq29OoIOtNVAxiGW4qgILn/Nex
	qwJaqnDf85WZY5Ytr6Pm2fGikYt9yc9aOi7UjlyIscGMh1XS5T75hvomf5VYmmQ1JJeeuDRtrn3
	jNtwzmmb7rIE2mOVDm1KmWIRbKIrkgEb8OsAlQ0V0
X-Gm-Gg: AYBFou2iXkgqzYsQOkX73lAGBYt7JI+NBFsB1QVIgqM9AmEPUnwCEppbaA90XfV7CpJ
	3AEMCMpzvLGEFZa0ENzeA6+tOUMDEDRy/YbqhGIs9T8FXOd172KlrlACn9CpDJ92wFj9sMLMN1u
	b2oT7GKpWANVzQ49XaxJDHmdmndYCEnMqOL88DKyPvrpzgw4oc+nWQj3j/Vz1n5BjQYOWbrjpQZ
	AnTfatoF1OgunFs0PRtO0ZF38n5A7bTYSOKiOAHFJuoWzdHS7XUUmIfK7Cn4bW1G7/4ZTy4rXm5
	10A4eMYtTOn3WCSRNHLPoB4EuCDcVp+rERaSjA4ElWEY5sSkhcJsgk9JCbsGekCZ9cV/Il2EURO
	IeoMWzMvXaJCfswDyogifbFCufZfDOBB93FIawecs0tW0u2wkE5znvurP5KTVyvQjrtC5
X-Received: by 2002:a05:622a:1106:b0:532:d202:3280 with SMTP id
 d75a77b69052e-5330b5b173emr36157521cf.17.1790328469712; Fri, 25 Sep 2026
 02:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923035217.179102-2-edumazet@google.com> <179031917882.2160803.2662236543443790926@kernel.org>
In-Reply-To: <179031917882.2160803.2662236543443790926@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 11:27:38 +0200
X-Gm-Features: AclHuK8-2Ms_0eQkIj79IJ8K7ChjCrA_yLacd7EhkxPo8gkOYUm48iWk7m34Fk4
Message-ID: <CANn89iK0w7uLcJCk2_eSMOV3-e-nk0f2FY_rZhH-gsXUzgWSoQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/5] ip_tunnel: do not clear the active encap
 before validating the new one
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	u9012063@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:53=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch only fixes the case where
>   ip_tunnel_encap_setup()/ip6_tnl_encap_setup() itself fails.

Right, this patch is only about the memset(): a request that
ip[6]_encap_hlen() rejects must leave the tunnel alone.

ipip, sit, ip6_tunnel and ip6_gre changelink handlers setting up
the encapsulation before validating the rest of the request is an older,
separate issue. Fixing it requires staging the encapsulation,
as patches 3 and 4 do for ip_gre, in each of these drivers.
This can be handled separately; v4 states it in the changelog.


>
> Pre-existing issues:
> - [Medium] ip_tunnel_encap_setup() and ip6_tnl_encap_setup() update
>   t->encap.{type,sport,dport,flags}, t->encap_hlen and t->hlen one field=
=E2=80=A6
>

Pre-existing indeed, and not specific to the encap fields: the xmit
paths read o_flags,
tun_hlen, needed_headroom and friends locklessly as well.
READ_ONCE()/WRITE_ONCE() annotations (as started by 88b84cae6b94 for IPv4),
or a consistent snapshot of the configuration in the xmit paths, are
net-next material.

In fact, my plan is to convert everything to RCU.

pw-bot: cr

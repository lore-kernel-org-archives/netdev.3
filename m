Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C9487CC3
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177876; cv=pass; b=cgCXbnpcVO4iDU/BwB0kWHto8Yvi6rrsLhSl8y2+o6JBR3JMU3F3LR0PdW4WBqU7Qbawg57JNCBXvleRUINOBUYlw7DLhyEEvar+YmhPltWBZtFcUs1ul7lgDJ4F9CbAsL6Se6XRFx98HPrzxpRBVx7iic6U9eml8MOpLVMD9qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177876; c=relaxed/simple;
	bh=qppVgsYFvGGhHcWK5q8fwgXEoXbm8x8Kajt5Kyll45Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxgCexgAt0/E4orv77ao9c4+JOFLV3kxfPC+OklC99NgLC/HkEnxFAtjwbxvw+KiAU7nrcltc4SS69E2k8JCbZGnO3URczc7uUtMIfGUtpfpBNVrkEjpyLAWK2KJO3bRMAjOfSjN2srVJ4hmKgdS1196iiTxpb2WFpZh0hw+OzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNYHVnir; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNYHVnir"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-885cf67963eso2591527b3.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 12:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792177874; cv=none;
        d=google.com; s=arc-20260327;
        b=SiGn+WtVvLbXQx06UPJa2xW4GCJ1DGmCJTaJUktg9fUx+yAbE/HqGmfh8b4NcBpo4H
         bVaSJlMlZQ67q5qzZZFlGgCbtXikQrUTtEAOa/nd09FwtMFnLFUJ6n8kOomNBAuIIjc5
         B4k0kegIfdiJpqebLFsj9F9ay/79wctKjzIhYGZScjfHhIw71wHk+KmY9FYowdimkRaN
         O84vaH1i1QUlhcGT1T2qSk8PHTHnr/6JbhgEpATXJVOF1rM0qdf+S9l+zukz+XpwnM7d
         YglvcpTxTZsrk0JgKLMhcpQlo3wOtwMG++u6seedNDenA1GuC6b/Ez6rdjlrQEyEU+Rw
         ENXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rcM0e5h6kl2DJj3y8GjJ9yn5THeHomwVF5DySO9cYxc=;
        fh=nxicnUGRhxRS2wi8dQBoOb0lSt37fWpwKiBRsEtwm6M=;
        b=XX2yvcnMyQ6+pUCpn+5XYBlQcY7rRTG4b4V0PnC/sb4GUvqIEWRSEHNgzfErLxd+ux
         neuEAC5rtit08WmdEuOQMGc2+8H5HXbqQnqIMD/9QU8VdOt6TkXeYS8Yrn/3QsP2sX0P
         CKVjIub3F9KF1h6TswIzzkiGFb1Kov2weKSwFEcC9TowxFbgmiGrzgjGbEn6L+vrQQqY
         Id6E3GR937nKQclGG+t+yfEuMImXk+6IwnA2qyxGO0/anWnBt9hEyxMQRsNta+S9jlMl
         XWwx6KzcPBQwmYlsV66vHVwSTHjduREHhcC53o/jRoAGwWo+5fZnWAuxZ8OtLLjtOgL2
         Yo/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792177874; x=1792782674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rcM0e5h6kl2DJj3y8GjJ9yn5THeHomwVF5DySO9cYxc=;
        b=lNYHVnirjmv/XVzkDQrJJrtTF9KNDAbXxawbFWCxJHjZruMMjPqAmhqeKnvX8Dhuvl
         FqHZWxxeA1e6BytDa6B6qWm88wVrLzwDEykURFCxQx3GhLCfSWQ8hX24aL5jkY+DOSeW
         a5LUkceNq6eXRyJXYk91Xsrolvl4ZLVSW09ID+JiLAiBJwZlMk/9roGrfDRIobieGdYA
         zRTfkxGvy0mJEEGWG7b8rFrA2HM049eB2dHGCNYgNMRsupgebUZYB35BuuWYyM+WZMB3
         UzicVHJkTFg9yRS0FeittYF0id7wNbKhs14p7mRXpKok2DzsraiYLJVstHVmYBs5nriU
         CoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792177874; x=1792782674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcM0e5h6kl2DJj3y8GjJ9yn5THeHomwVF5DySO9cYxc=;
        b=CbrJur02wzdZPU2G4JkPJiCYgkz9K5XQfhyNjffU+azqomGaZdT6NoYavCP3MXhfw/
         tnUkoxIfwPOzJ0hkQRDwGy3p0+B7tpMxF5AujsxLlf9qq/1/8BWk6jX67N5GAhFlimYT
         VXqSuFsIFlWFkQyXB/MmiTSHrJpK8gTMD55Ar33HXiVCgp2QTgWw0XZWCrlxm2eaAYzF
         vXMWt+i/cwDR4hK3tuSLJAIWW6wz+AVEr1c+IvZQ4GU1InTQLGbKrYD7+YyOAlO2lq44
         nylCjiLD2+uOn2yawbAaG+JRRPkSshVXOWl00QqJSDfs/dLV9JI236qoy1MKbAeYh99j
         mZcw==
X-Forwarded-Encrypted: i=1; AKwUvBzCc2V3bUUpqXEdBsG0W2cz4hjadlhBHjbyhw32pFxh2SkYEhqzy8mFFmEnkU9XYEGEUKGnSLU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoUITHCYxjahC1kqNwGymKCYqPAqDWSSnw91DIkQz0y6y+lBPE
	eSp9hEtqqbL6KduRTP8Aj7Q1RbOPpgYMevKBAaB4/iL3veFKq2ZMC5Duj2VTKWy04GaMb20OAvx
	5+vrAXQ0qa8jU3m91R/QbdtOlhl1VPBM=
X-Gm-Gg: AYBFou2nsBM3OKhKLzKd+a9D/pI8LfsFk8O3CALekM/izG0n3hHg0TeEQxunJp8+Ubq
	CgWpMenjOyuHUTpNRccCnYiBjEFZQwQOJmeljaGjzmURANCA8IXrDsctmsF/bikLk/lmT1fyZSu
	8hH4JCx8GLO3UX05n57XcwV8HLQz4r6wABWQtC64gflP7bmo7Ia52o1Vwddyp59H4tTjU87WU6D
	saEjyUdZPSCMWH9dnWIDCIuSFnebIc0M8YBx+Rp9HEUzOAGoNAaoo5+lUCNlF/WQARlyj/N3W1t
	ZbKCxBwNXjlXurGBcQyaPSbjw+kfMAmN44hNhmFmDaVhpS8J+hzG8RBnpPMNmoYI2w==
X-Received: by 2002:a05:690e:138a:b0:679:c9af:6d51 with SMTP id
 956f58d0204a3-679ca86652fmr108710d50.69.1792177873691; Fri, 16 Oct 2026
 12:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179216146138.25460.7866279004288174372@gmail.com>
In-Reply-To: <179216146138.25460.7866279004288174372@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Oct 2026 15:11:02 -0400
X-Gm-Features: AclHuK82Reo9t1Q_XYkamM6mGKm-uUZWL-8Kv3QM6WU-oPDk-hAS-2iAswxeKCA
Message-ID: <CAEjxPJ7fLbBANfjcgN7Xa+axbQFE5ZALWzXxRz_kQ8zGvmw4Rw@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't label bridged packets in selinux_ip_forward()
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnacek@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:37=E2=80=AFAM Joas Antonio dos Santos
<joasantonio108@gmail.com> wrote:
>
> With br_netfilter and bridge-nf-call-ip{,6}tables enabled, bridged IP
> packets go through the NF_INET_FORWARD hook, where selinux_ip_forward()
> calls selinux_netlbl_skbuff_setsid() and NetLabel may add or remove a
> CIPSO or CALIPSO option.  cipso_v4_skbuff_setattr(),
> calipso_skbuff_setattr() and calipso_skbuff_delattr() move the IP
> header and reset the network header, but the Ethernet header stays
> where it was; when the bridge pushes it back in front of the packet it
> picks up stale bytes and the frame goes out with a garbage destination
> MAC and EtherType.
>
> Labeling a bridged packet based on its IP addresses is not what we want
> here anyway, so leave bridged packets alone.  Add a stub of
> nf_bridge_info_exists() for CONFIG_BRIDGE_NETFILTER=3Dn.
>
> Tested with QEMU, two veths enslaved to a bridge with br_netfilter in
> the middle, SELinux and a NetLabel DOI 16 configuration, 5 UDP packets
> per case:
>
>   case                                        before        after
>   CALIPSO packet, unlabeled destination       MAC garbage   5/5
>   unlabeled IPv6, CALIPSO destination         MAC garbage   5/5
>   unlabeled IPv4, CIPSO destination           MAC garbage   5/5
>
> Routed packets are still labeled (an unlabeled packet forwarded towards
> a CALIPSO destination gets the option, 5/5).
>
> Fixes: 948bf85c1bc9 ("netlabel: Add functionality to set the security att=
ributes of a packet")
> Link: https://lore.kernel.org/netdev/CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_=
6EhAuu4qfUFe_mw@mail.gmail.com/
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

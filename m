Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E045C6F1
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341028; cv=pass; b=eHrJKs+h6Mg+FuPIJSx+HAoLdWoJLRAMtl7koi/F1EsJdl2/ftp082RGTHHR0vfJPhw3qUuLm5jVkF5apo+wDLn925T85ltHUKq7+bI5oiQBcYWGdQyz8R9irt5E+GtYwneXO4svtez3Ty8lUz2lf/z6Tk1AxhRUaNhP+OHPbOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341028; c=relaxed/simple;
	bh=9jvHZveWtXHHlQ1jzadPI9gN3vbZDtiixL2Ia/KB0jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oswONLn1gAUqZTiQpH99VgrPVDOz1C9xvzeA4YidXY8chLFhvCCCU75116IHFOU0kp+gf+hEeXkPJ7a1DNhojYapWmir18yve/iDEVCX+HQlp8SYDCZxZTGSqKUG6NFkx2iLTMPjddC0Q/nLyNuQbDX/QgVr/RNoZEc18a4yTTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud85PurI; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud85PurI"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7466771f1caso424419137.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785341026; cv=none;
        d=google.com; s=arc-20260327;
        b=qRnebU3XmDF5XMw53Z/cZB2bxvs9r63sg8EiplC8gKC3x7sjr4O2BRXEALgGHEMgbd
         XhEiiqjqlKxGgx8/20mCNOQBo6EG4YJLMzVqTbE4oWWPth10/K0BAG7N/9mE5QKaZNh9
         7Eqawtb21F+4+PmJHLDHxrX/77pE0ZrS+ZlxU5LOg484fzhhuH+a8LuvEYAOHJm8Ixij
         2HQ6TNuarGGqMtKuS0RKVBDZ5b5lyqijK3iCnBtxiKdHOXwBlhIAWx2pOzL2VhByVknf
         X7IHytjKhOEy3EZOv68z/64+MPJjgz4ZJoJbyevRWaT+D2VKNnG1YiRhHA+oPJxnLja/
         zttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9jvHZveWtXHHlQ1jzadPI9gN3vbZDtiixL2Ia/KB0jk=;
        fh=PlveywlMV/nNCQx/b1XlJY8tJU8jAHqKXcEklO/u0kg=;
        b=OV25g17Z7OT8BXXvYTQoV8SFVIM6xjaMT2YuJmS4403nBDMd5fietoOOPJUDAJ8QjJ
         OVL9FsUweV14tjpCQWKX8HkJe9TGIELDEe5lSuJWwLYetz0lTmHP0PZv+0Q5pVMVMtC6
         sYMPZEILlhTSC4dcgInj0t2O02bgNT1u7VKl2RQ/P8xgIIc4kGOpdjTJvHs+CALYhffy
         gwVsFSH5Xdbq8IR0EX6uC45rz6RbvK21pVIOyNfhHMQq31il3CPQYA1nVun37S3axzle
         xTwAOARx5DSurAOkNakEXWuoWt3kjqjbeXAJ9CWnJB1TB21rHMIGThuOnXAJnZJJwUwx
         EK4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785341026; x=1785945826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jvHZveWtXHHlQ1jzadPI9gN3vbZDtiixL2Ia/KB0jk=;
        b=Ud85PurItnY05UmeYWhIPTecYmwfTb7TyqvIQ7cDAgirJ2COQ3Zxa32vaKJaOAChcj
         xO1ck3iTyCEBtW5nrfCyiIKH2uM5SbnIp6AQgNuRiq12luAWYCaCIKMRGdZBXFOUJ+eV
         3f0VYfPeVOfnjcbh7aNsw/RTNPl+um2U02/L4v3jBljpKfSIMQr0K8W52ZqUeQjXPR25
         ABwddyjYXSch0ki0dknqxOIqX9lIpA9tpjio3oHPZDVJ/R0eH1m++uwsFheBZstBSq3p
         M1VH4Jp00D+bzULCyDrZewgmWxfaRno7yzi4wbm1rKpehCLrd2p2ZqrhvH02rzdJtCZK
         g22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341026; x=1785945826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jvHZveWtXHHlQ1jzadPI9gN3vbZDtiixL2Ia/KB0jk=;
        b=kgIkzKxYDO4ZYPNUZsPmMpuvMlzY+uDV6rM02HDteixt1zGsSZqGCuMzxbgd3HaxRi
         0XKDwUPqXt0ki0IIRMiDqUhrCennkYPy3rl3uPCzBhvuoIVr4a0RHuXuYsKpbMFSyGr+
         /w83hX7KqLmq+d6dMhFegl9LN57YMImozPLr0E5xzW78v8IsqygOFsCuS4xXtU97yA2D
         uaESCvZxjGl9ZzRlX0BJppeitT12svxf7bCrkviHY4z6CiARZfaxlZTUjvlWhrpnXRex
         YuilbNDrOjTtsN2rWkWsPa3xhipYS1dkk8PQKVhNl7A/6vBOc2v4+i7BbsDouDcMZevx
         vXUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQLNrjPuSrpyfHx0FmJLF+C/Eo15ZHT68SqkwASuuKYO0wO5w2MygsrDsl0x3mJGRGLeGa7sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXAS7n7UGUMG3OvZVmgT2og/RVmxzscQtEjH+2bE9b9LMnWsl
	JWYpU369TX7SI2ahP2umBl0OpmSsuvDVBmDM3tbAFLKOnpnj9p238T1WETNEzuG7RPlpqF48OUh
	cCd9Tj1jRlN1qzktH1+OPKSCVZDQnxEg=
X-Gm-Gg: AR+sD127mekwAiFTyObMpOubANhrjc9FemMqp0PZjhbDqMxsAqiFHEbnVH2y1VzHaBZ
	Flm5ITJSoC3EUCEYb+gBje9GYvkxNKO4ex72xlq6gDPD8/mIyEI92qFsPxS59BWPWs8ASIAZ4k8
	By0I35HUtjsn1tEXI1wmE4O+VVOmWHkN4imXxf6EjRt1bbLoBu5XJM3Q/4Sn4YlKCaGsRxY/HIZ
	Ed74llkknHTXsZb0GmCw+nVr1s/HUxPpT1ilP6H7jazd7U+U8rdcyA8WovSwwAHgwn+lanVu+dH
	7G0nbwYwDPGI9wEV2DxBjrTJ8k44QJQNlYVU6vYfNVFWvAl6ay+2BqkXzt0pC4ULaT4xcUb/gzC
	5CfR2KF4LJ2XYxjZ8ScPVOD9tJvfy6+IN4OT1BHSkCmo=
X-Received: by 2002:a05:6102:3e87:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-7549f147633mr3169780137.3.1785341026373; Wed, 29 Jul 2026
 09:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723071818.459034-1-l1138897701@163.com> <20260728182431.3291b917@kernel.org>
In-Reply-To: <20260728182431.3291b917@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 29 Jul 2026 12:03:33 -0400
X-Gm-Features: AUfX_mxSOAibwdWHo3uMOeOrFHcxPhaZyGA2yz3_5W-NC3DfmXI2lIJDX9QqLXU
Message-ID: <CADvbK_dhcAwiaK6htMA3kkW797-qchajjFsJhFyi6KMEbkEm4g@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix addip_serial increment on ASCONF_ACK
 allocation failure
To: Jakub Kicinski <kuba@kernel.org>
Cc: luoqing <l1138897701@163.com>, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 23 Jul 2026 15:18:18 +0800 luoqing wrote:
> > From: Qing Luo <luoqing@kylinos.cn>
> >
> > In sctp_process_asconf(), when sctp_make_asconf_ack() fails to allocate
> > the ASCONF_ACK chunk due to memory pressure, the code jumps to the
> > done label where asoc->peer.addip_serial is unconditionally incremented=
.
> >
> > This leaves the peer's ASCONF (serial N) unacknowledged while the local
> > endpoint now expects serial N+1. When the peer retransmits serial N, it
> > falls into the serial < addip_serial + 1 branch ,
> > which attempts to look up a cached ACK for serial N. No cached ACK
> > exists since the allocation failed, so the retransmission is silently
> > discarded. The peer eventually times out and ABORTs the association.
> >
> > Move the addip_serial increment inside the if (asconf_ack) block so tha=
t
> > the serial number is only advanced when the ASCONF_ACK is successfully
> > created and cached. This way, on allocation failure, the serial number
> > is unchanged and the peer's retransmitted ASCONF will be correctly
> > re-processed.
> >
> > Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)
>
> nit: missing quotation marks around the subject
> --
> pw-bot: cr

Somehow I missed this patch.

LGTM, except the nit Jakub pointed out.

Thanks.

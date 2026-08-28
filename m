Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF03890F1
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936602; cv=pass; b=ImcmZ8pAlhR/5ZBG+r6oGTcjYTswGD9kt4N7B0qakUxSLOnjYSNShqG1pYavcUaxmOFRIqmMWDa9J0YTWOBpZwz98ucweeBtPaY9P7m9O7SVKhQsBo5iMfDapNcxj07F8ZkJZwSkgxWkZPVKVb1AdCpudFaX92NbZsSqqOI6+Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936602; c=relaxed/simple;
	bh=wP62moPxMAH/ckYjnceOzlKQcAACIf9yQB3gQOrPKi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkjD2WjE7THptSyfwlanEhR/5I0MRdzv7GmwYoaOfLP/giYxdAdnt14HfD/MpDdFo8iSh6ddeZrzlitr4aIp3T1MvVYhw8xrwpJ0S6zEYcwNBgo/7xqJcBgXMQzPQBD4T1t1+eNL4QnvlIAjj3BXz6BR1lVG6JEUUbT+sYxoJYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gBPDN3yl; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBPDN3yl"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1354566a12.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 10:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787936600; cv=none;
        d=google.com; s=arc-20260327;
        b=VapJUoQiUDepzP41L/l2fGxSvtP/SlailHr/JCZFJRvhfgSswqC0uQWAF3yBpFupNH
         NVrXpV8XhM7mFyzZZEAoipOqmxUNYsqip7xX5Jv316fG8/Ze5JFAcgcMNg1fUtAXKB4+
         chG3igGLJJ38ylQ0FC4BbLBocLsEHRb37d8B15r5fU7btjvdTSV58nOtxV9xfJo7AD/r
         gtvu4Rw9ejptScjJm6ujBYzxXijfglefG3gah7W4BRFT74ysQ25pEBKRktZB/8+1g7Kx
         qCNxjVuYmMyDZDFryyDf4Pvy26WpW8yFr96+KvzTN32UHjmf0G5/3KJ+HtsHhhNq0x7+
         O3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3D9xQtFnagYVLW4vz/xB8xNx9SMn/YPoGUoz7up9AxU=;
        fh=sd0EUqneYiTRk5yM2PQCuUTBRdLXP4OSX/nU1Z3Hl2s=;
        b=NWr3jPj4xRyVf0kXIFcpLoaQa+cal3kIAaj8x1p9DuRhqtcUJh+rkc8inrLMvF0C2E
         rSW16xm4Fu5rpNKKgnQ6YUrgw7yXrugDEDwjW3ksgoglo3fvslBP9aXDXa5s6bSY7riU
         sjX93wEs64vdWudAd7lNQbx4e73QvP8/Dbt6xwnFULUiKsGjya1vFLmSqrREU4wZZY9u
         yEnZ8iUaj3I5LDSPlrPcRCM5WcXTNEHHM5uhgncTrnO0mWWAbo6y4KvlS0OIK8034Iex
         Tf+U9CHeGq7sUISayOgYJcbjbrwiCouXDfgYWHwuVhC2QMWeyqh2BnPwEcXsX8pnkdmw
         yjAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787936600; x=1788541400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3D9xQtFnagYVLW4vz/xB8xNx9SMn/YPoGUoz7up9AxU=;
        b=gBPDN3ylyBZjzTKa7/C5y98b18l1cCoPCjwkqSMrOCExe2sRsEDmaHblE8Ip0g6Da4
         zlE59uwWis3PYnpXMXO9TxNcXxNR8MgOZD3XoJ0vg0bHZnll0lmOhMR6eZ50OWwrNWcK
         Icit+Avggf/xgulUKd08ddZ8jGyUKIuq7n0uoT7zz291ZT9J6ZiEsg59NvSUW/kCwBZj
         mBxSqZ535brwNZZtSFZYvNlykUKfm03oZdi/7eUHJ1pyj2iuPfMBpkf07F46MaAMB5xg
         4D2ZTGnUGF9GNm3nb+f9jgHlVwvDQPd3hiPUGItrDnjaErbSuQCl+eOoShuRmA3m/tY2
         +h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787936600; x=1788541400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3D9xQtFnagYVLW4vz/xB8xNx9SMn/YPoGUoz7up9AxU=;
        b=Hb+oMUEfB+MG1rLZ9Edi5CWtQgp0vZLFpKhbAtDwtpCnmGd/7gTjBmLaTaRoPO+EJt
         FolE/NnTnPrzlD/ptmUHB8NwNdjqmTmC3BdUoio+sQq/bD5WAKhByVQKUDXSQDtl19h5
         DdMbH/m2GBzROYWxi3vyfdWKAJqIdg7WRPDk79q7FOgbH3GUq0AEg7bdr6/3T7ELwHnc
         pPGigBGoGSGuKTGrPQ3ZWZtKGDYN1ZF+xkgV3F2Iar+2KowHQgnQJL7LQt8VcbFEn4jr
         shy82pLBzaS3rrgxRS09Z5kczdv+yuO0wD01a7151wNUOX6BV63Hdtz03fEzxFegwk9y
         fLag==
X-Gm-Message-State: AFuF++lODG8zeNQKNCPjI1VX5APW569xdajvnPlXadiySswMwov9n5ra
	AGC3KTBo0NYI0BgKACquOpryQr6/53BJAdQKPWAXIlW5vFBbbberCkh97WarIYeNpYW8rMsPkwl
	iSYWe8NfeUTeVIpwY5Vb+Md/wORcxB4Oo9FpO7pMp
X-Gm-Gg: AR+sD10imChb+mVW4Yyf8ZKuGUtDAyirdaaY4cLrAOoYkIDdku8uRYazpI32vUXAjzQ
	Yo3xS9GEtE850F44bHfkHuhXqRu/GeMYvfpiG78Bdhj7nZGIU8cbgIG9K1lYx9NT4QLzvrGHsqH
	58Z7fQzoa04m1DNpsP3rsXjtkp200PyhLEGhy0r2K3yA1owlFsYgjaTfuKJhJFYf97LsH4q2r40
	ebwMBWBytOPBTyzSt0qkSHnSl/gpKWmx+y+NvDEAO3ZcJYeae6P9ZHy+Y2AobRw/A3wmBpkbjMV
	/+ARpLsJoVKNZmZtnktnwrEcBLt0fyXaMSn2AUXH0zADCEnF9FOO4Q4jlM/ujeU2b9bIc6+amK9
	dJH0rM6CeTgKsJLwU/cg2uajUd+McNvIrmd06X9QOC35uJU1gbbD9p3ZUq/HYRJqrIKFvwf2/T5
	+8h6mFk+FQUnBZzEc=
X-Received: by 2002:a17:90b:4e88:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-3969bb05e4fmr23190637a91.8.1787936597976; Fri, 28 Aug 2026
 10:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 28 Aug 2026 10:03:05 -0700
X-Gm-Features: AcwNN1UazCKsXBt1bQZ2-rlEPqZo593Iv86LFjnUhcYSmeB20RqI5rKuNU43TFs
Message-ID: <CAAVpQUDEXAOc5UeMwDwFMBgxV3gONM4qDU6dHQhyCgjef5DpLQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] ipvlan: unregister upper devices outside pnodes_lock
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, bpf@vger.kernel.org, 
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:49=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> syzbot reported the following circular locking dependency:
>
>   xs->mutex -> netdev lock -> pnodes_lock -> net->xdp.lock -> xs->mutex
>
> The pnodes_lock -> net->xdp.lock edge is recorded when
> ipvlan_device_event(NETDEV_UNREGISTER) calls unregister_netdevice_many()
> while holding pnodes_lock.  A nested NETDEV_UNREGISTER notification for
> an IPvlan device enters xsk_notifier(), which acquires net->xdp.lock.
>
> Keep pnodes_lock only while marking the upper devices as dying, removing
> them from port->ipvlans, and queueing them for unregistration.  Once the
> devices have been detached from the protected list, release pnodes_lock
> before unregister_netdevice_many() invokes notifier callbacks.
>
> The port remains alive across unregistration because
> ipvlan_device_event() holds the reference acquired by ipvlan_port_get().
> The dying flag prevents a concurrent ->dellink() callback from deleting a
> queued device again.
>
> Fixes: 35add1093e2f ("ipvlan: Protect ipvl_port.ipvlans with mutex.")
> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

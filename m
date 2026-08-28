Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF11357CF7
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935892; cv=pass; b=MJmNvusMTvwr7v/Zqne9J5Zqe+KysPby/r/oeuU8jNjEAfQEPeDgwsTTgVomYDxlxtqTHdG5KX7kokl0q6XqOsIZwPxmhaM0GfQ9i6mV8a1SMonsIJJNteJJita3mx19s4yNWy8C5D0Ql5AGCI7OuVCb/v1DIi6EnNXlW9jjhRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935892; c=relaxed/simple;
	bh=9bt4yB4wrN8kHYOfxeXhMbkcmKTisipIJsXnXK0ZxD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex2x6zsH7RehJizexzZ17+rNI8GfJrDaRRNRCNDjiniJvGzn9omPaaNHaQ2hLRU75w7iqBjL2dB8eSwYz0vVS1gAce4sCoryqndAZivoE/sZ6cyIPVssArq0hnwbs5ak7JTqYQQdy49fo7u6CyfI3gE5BbOvAy/cdnTIV9iKvys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S03MfrYd; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S03MfrYd"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52f83889a93so10356311cf.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787935887; cv=none;
        d=google.com; s=arc-20260327;
        b=WtoeGflYJ1VgBDh0Yutqu21J2zO16v2ZYnlQLDZ5paHExtmiuT5AQLb1jZbiSTtqvc
         OCcMkC8gNLcFzh+ScG63omxGPKEBo0jzChVDAT7VYOPThK4dVQl4+EH3+bv0gZtK1//U
         NpSVZi9sUGt2FiBeAhmbb58Xgcu1AO86dRCQm0ddsNm1qoHQDTreZ0bbj8aLVv1MCqnO
         jltmmoDnC4RfgYgQKEIe321Xhw2CEdMgxHdHFDMJq0kKeDj63RWpPPgrZ+74SyRZ+HVn
         QMWPVLtfh1rYRzBfSSSegHViyAsta5LX6rhDziheZkTbpo/mh+W78n8ayEPYkpEck6cX
         +96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mMlaPah34klg2SfIGU5Q2NKW+XSAghjYJ83EboJBxEQ=;
        fh=vcKY0jlpnaixeEabHNdFoz2CU/7U2ZCQX99dw26BGIY=;
        b=Czn7BxWsNCOrMTeb76wIlLRvE0uCtwDkSZ2ZK3PrL8dTccfe+H+oZYlnoM9ep3Xpcc
         nxarPBWIvj2+Mrjo9EqOeU4kmiwbW+oSHfhgH2/8icW5Le4vOLilPfxfXi1kB2UhcMkS
         J0EH+0zLAvnqUHbWXqowPggzmazRDOQJHIq4hxGyZLpy+Engn1EKoBoCyuOZz4Q2P0FD
         rsdhuDwBZBzYzpkvaHMlexp0FTMGnO0mdK16K5nMiQv8yk3H156Pqj87JFYQQ03VehNo
         +DLhRG0mLPvT4IayMEBartoPGa58gEZ0WhrPMMRZl5Xv9vBt6LCGrQB5qebkz7SQh8Xs
         wDEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787935887; x=1788540687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mMlaPah34klg2SfIGU5Q2NKW+XSAghjYJ83EboJBxEQ=;
        b=S03MfrYdTW5Rx3/WhElnx7QQSdMr+5rJQDaq3lBdKyDnImCmv3yJf7n9u5zXH0QkBz
         ZBR+yhImIBK/ChSOg5AirlOjVmhzVHKDV5eJtRRUUd8bbLUMz9MrNgYHglvSICjoI+lb
         QdgEtIeN4Bp7xv5FZkys+nF+Ahz1bcxvG0yZGtwh+pApyECjKa/HoxE8fksGmw56oCeG
         Yy09Uo20M4OeTlcqkJrZZygsgFY5hk63rIeIW7daMlRZWGN8hc+x5hA3WI0DqFtF7793
         x9AYNvCqLDa37MfAs3i5LqP2TH5vGbyjhjdgI/gA5r+B89WmZhfid+VcDOTC6YfGAwLS
         efIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787935887; x=1788540687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMlaPah34klg2SfIGU5Q2NKW+XSAghjYJ83EboJBxEQ=;
        b=ZM2ZTl1aFrHoGjvIYQVHvkOrWAjtT4UxZh0GI35o2n/JaAEZkVpYECaFPhDg0qGuUQ
         XLZSm8Ff89V+rRdvfZGQEqseLKrWK2JQFjW+cwfbr2Ubb/YTU5CUNqc2VrB75xokh7i4
         /j6XT+SPR6Fn2WQeYNKPnyZ7ZUH/JVLSwfFGffZNdY8b7+zqUieXkanIm+d8XZQvpzqN
         /LLT7EjC0wYfyYS9BkaagCG0usYxtdDJl86B+4cjvYGVXjVODJ6rY1UxuEiE1px/UPTO
         oT9m00Y8Qi1T7kUD1dzG8CTNdKkLbVFsT/0PKzOo98zHUnUg9pwaYv1o+kood3/gzyhE
         8mnA==
X-Gm-Message-State: AFuF++m4QwRn/e9wa7jmd1kadhB5bRyxvM/+2ihdHMY48B7A3SD1H0x2
	DEZ87VjE+Xlx3Uyy+0OqfhQ8Y0riOiPP9yJdbazPYLzBvWma2FwOOj56vmYC9p/Wlq3ikaD1oSZ
	q++ojcTKJ+HNiONMdnDCAZ28EPaK+x3sWoHedWPOfb7nbhPCJKVgO3xfi
X-Gm-Gg: AR+sD12guv7k7FlxgbkRGl4v5vz8kPpNMIbYFVJPpZU0pjWwU+dyswJHJfaPFwJGPDt
	D0Fjb2Khr6GQc133SGaqlSHh7DVWatC4e1JC17gXLpyyFsCuAWrD6Dev6E3DKgD9aiI/CT6qAPm
	A4w3urpy6EMjZscXxgdCWX4xqib1LzprwVCO9TilBXVFzYQdN4uGppLQ7VzAykVPXBZOPgCA1GC
	lwrbGKvpHHg9w1/FhJnKIbuavggqfsxC70adzkwhxWZwYarc+6IARUpCRpSwtUzy/duhVXHEZfD
	kW2LIGDZ5vzKkGTewX/vsSIcnzjy2bGnMkCq0SKTUM+OuJMzdYoLTeB908Mo4Bsd/DzrxH5mV0L
	4fmX+MJrdXfQPG3Ds/HdCJ7F/mcoY9QAsZzfmGGSOOx1kdBZ3Hv1qfL4pbQE=
X-Received: by 2002:a05:622a:c0e:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52fb93cf74dmr100711571cf.1.1787935886865; Fri, 28 Aug 2026
 09:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 18:51:15 +0200
X-Gm-Features: AcwNN1U6wjvnrTjChRJ42-n0h-q835Ksy05AvEQrrkJT1qt_7aTQ3cY8JbZm830
Message-ID: <CANn89iKJRSsYNzirnzUwLSwGOoyn8ujKyBWRh4BBeZHHPFaM3w@mail.gmail.com>
Subject: Re: [PATCH v2 net] ipvlan: unregister upper devices outside pnodes_lock
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, bpf@vger.kernel.org, 
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:49=E2=80=AFPM Maciej Fijalkowski
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

Reviewed-by: Eric Dumazet <edumazet@google.com>

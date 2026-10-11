Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9E1E8332
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733571; cv=pass; b=Tp8MukFM+jOGT5zxpdhX+vruYYl3ze2wi/nP09N87xWeyaObUmZKsTNz8EiIPnKlb28523AhfCSZhnOb4qREQR10JGToX/9EU4VFPffJZqvEC6eYa1am4BrOqJ9KQ+MUw6zHWUDh/yktihS8qgAsUkNdQlz0nPaOfdEJQ4mklNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733571; c=relaxed/simple;
	bh=rQXlRoSMdeeZu3l+07GtH5SZ02qfTqlKbUj7DiEyiPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXlMc2W7hee5fAx6jcUx2NiaFTq2Gevt+OnCjuaVZvTQtt+oUHw0hrGDVuE4bZ6SXfaL0m2XcpC5RChUym0NZAExrYagMy1PiJ1uXqmTw5a5rXC3ceclF4fyxQ9VfMQeT7ahOnyjjZOBJwbKs5IlRocM0Rv3UsfScdOvWwWTtH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bb1NoM/0; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bb1NoM/0"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so3805a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 08:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791733568; cv=none;
        d=google.com; s=arc-20260327;
        b=DMlvtVOsWAfT1wwjH6N55l10bCbhfToOFyVfE8ypzHBHzBiv6q+3gv4bvnhCzwYkez
         HxWlWWKcQb+pHlOrrR2xDpLhF4BA7gmEHaai4/4xu9ZJrC7rJ5L2EzjmJAWAh2EISjkV
         aPctdNnspyuf/U8HPYCvR8IOGV0zty7kaMrXpIaNkN1LStSyLY/InyuaGVFmEFchbPak
         W43jcix/j0PvfoRwxnAqRayg5y2mRdEYFdk1jfxpEPrirSIe138fyVFeBPg6kJft6Wne
         UY7LPhtOdIqrQgYtuWfPVCvHbCjqzG/NnBy3XNKiC6tWnBHNK6ZIyXuno7k118ll375S
         AZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NQ8Y8vCXDwvbwSecDA7aeQbHVXaWb6F8hoqdYyLqgk8=;
        fh=6toU3DEePwSeIS6MNoAieyjTAbNFN5ugtyiGAa+sQdI=;
        b=sZZWTSZfnRkWoC4e26CIKJWUcjlmo4ZeZwnWCGVcOeG3y/sTCnqI0tqcJCo2x8R6wB
         NYZbn2OZFqK/gvKQUnEraenhK6Zvdb2r1fXjIdbuX0af8mN8PVZetE05iiUlC4ft2Zwx
         xUWxpVWgmVExUQyKLw4BSFmWSQ5VGybP0J2Y+D9N2ygUCiPGdeEdVMxBaXaUZ2bp0goM
         Kh1TLFZEr+J/LFWnxerO6JVJLemReryG1Pnr87D80PHpcnXTkTNPYjII5LjtLBsW8Doo
         4XbP2UFhaqqXRJZ9hup7jHHZcmHCn+iP+7jVZnaB04cbq8XwLK7yHabRKMgb5tS9YUOY
         +S+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791733568; x=1792338368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NQ8Y8vCXDwvbwSecDA7aeQbHVXaWb6F8hoqdYyLqgk8=;
        b=bb1NoM/0kjC3EZPLOADjfmsOI2AQCH2n6T6TghzdLY+guq/FGYIsanWSG3zffP5Xj7
         QHJBhV0q/EloM1S64F/m+qAu8lGthx3RptnqL42H3hy9acmGvXjiPpwM4eDDW/Iv6RcB
         QF1/LbVZ6WPPVBxOL1fyi30egNQFBSy9yOgEr8NJYG7QgIHkyjfQZQjmBKGr77WzoJo/
         vJwWm4Z9jAknTQkYPolPauhC4bdQz49uPFFMHkqSITo7EoBxDBjPv+Xv1P/O9ZoIYkQQ
         CTO5HNbIJ0klplJVmyWwbd8RLxXTU+ryvub5Q2RnVNrp/TMqqXNMCxa/ndYtRffV2Q1o
         TB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791733568; x=1792338368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NQ8Y8vCXDwvbwSecDA7aeQbHVXaWb6F8hoqdYyLqgk8=;
        b=SJy2VFjijRaZOb0NnsanxIRzVn6c+NNZAmP+anpefJ+IuQDN6YUI8q3H2PYejzclDi
         hnNwDoM3O0PBfO/Ug5heOppESm4+RFjt14hv/NKa290thqdJIi0zKtkfXB7Ix2E9K6qS
         DwfH2y0VxforgGHUYdUXwgwtojy394YaKbR1e3zyO3pBY2nKzo8Nb9as2aS5ru8ZGii3
         vhkT1RccnpWQjqNP/VDCQ1gqkGmL+fiwV9LSIQ4sSufP5q7x2R0J1vXEyXUGuQBjreWN
         vgyO06Q2eSKG3wbvmJwkvR1vtg3CRWQAQ4IITl51Rvvs74FxKcd/b9UutYeE7NxMWbXd
         z6DA==
X-Gm-Message-State: AFq9FYJe1jAkiTYGS8/h24k82es7VC5dvCeSAcK9c9ECB/sZLDXdOvk8
	1NYbI0d9AvMvUHUfjc4uFEDxz+bjcWOrsga5F0mY4mSUsen1NtUnLepY4fRQB0HqwA+2nzLPCbz
	Ze93s5Irjq22kmQbUMaeEGLoBxVRfW5iYV9KDMx/p
X-Gm-Gg: AYBFou01rsdc9gQ27IelM9zeAtGGqKcjaYip9+1TE/9zPpPZ94pkfC3crcicA6RQMSH
	ghKS7h17KZEpBGDMZSKOe+nQF6FWQy7uxldrV+eHCr/WQUIwWjQuMh/ughDW9KqeVwiBe123UV0
	jv8XgWyc7rLZJVaxpcU1bML5OC7rzXDzwhSwu4QrjFxuq4hzXLSQP5B8priRExV92rcbXKfrSps
	PuPuSERFuRfrZFLepBFB7gMIrCtG5dqdFmw4y8q60UEc2d2ORUbX8FYvE8CbbwWPLDr34U4DxGK
	vhKR3c6TbRTS3pxQqDR5MBLwEqzQVPjg4VMvQm7zbFTmVL2XLyXuICaawQt2EORy
X-Received: by 2002:aa7:d38d:0:b0:6ae:1503:5a27 with SMTP id
 4fb4d7f45d1cf-6b1999f28d0mr32551a12.8.1791733567188; Sun, 11 Oct 2026
 08:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008034027.1403188-1-almasrymina@google.com> <179173083927.434549.6834667881612626912@kernel.org>
In-Reply-To: <179173083927.434549.6834667881612626912@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Oct 2026 08:45:54 -0700
X-Gm-Features: AclHuK9Z8QuC4Ay-2rnhGygOdIrDTmHPITpI09OOb4gpQMofmnM8JDJaiIrsSis
Message-ID: <CAHS8izMARWs41xLX0gD+39qd=NPXA8QfUwXc8qKwqAUf1anS-w@mail.gmail.com>
Subject: Re: [PATCH net v1] net: devmem: prevent mixing fragments from
 different bindings
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, kaiyuanz@google.com, sdf@fomichev.me, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, horms@kernel.org, 
	bobbyeshleman@meta.com, antonio@openvpn.net, asml.silence@gmail.com, 
	ralf@mandelbit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 8:00=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 (1) =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] This patch makes a valid devmem MSG_ZEROCOPY sendmsg() fail with
>   -EFAULT.
> - [High] The commit says it prevents mixing fragments from different
>   devmem bindings in one skb, but it only guards the=E2=80=A6
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it undermines
>   the validation the patch hardens.
>

Both these issues seem valid. I could fix them in follow up patches
but it may be good to try to fix them now. Let me take a stab at it.

pw-bot: cr

--=20
Thanks,
Mina

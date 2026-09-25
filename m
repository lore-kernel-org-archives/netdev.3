Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3143A5E87
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341577; cv=pass; b=bIxTR4PFrCMkiL3BEjlutwn6d+XN1l2Z7xYzyOj2BFhHZwGNXXhaVCXnCqja4BhM4Lme19PLZrMKpqIAbDIkrAiqcFI4mHH0b3H0ToG52PRbpgaB8m+OMQqOpyv60zlCDefS2lX7Dv3DRfPhAhE25kfMlomwUKD8zfMMWgsNOz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341577; c=relaxed/simple;
	bh=9nrEMoJUJX7VmsXRZnVyqtxvTjWeXkBe2HP6/AIK/Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqmgrbAWZBnteEjRdz4mmmEUO9InQMpIRLDVMiEq4C4pLtktOiHOGj4pRSy2wCqs+SlX40ORq1riFwuwYKnvHWRcGcXZxTH/aOSXIVgUDoDZo7m04wHdmeTco/+xsrroIiporkZeetPtggqYsv3XixsrdijNUbujXl3ThBniL00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2R8RzpX; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2R8RzpX"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52fa9c055b5so19804761cf.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790341575; cv=none;
        d=google.com; s=arc-20260327;
        b=anwfPvGRTmbWaUPW6x/CCDhNnOunesC5IJ6DaAydoTvgWqPoSM4EEnlVzGPISGaqJQ
         NIgrLcqih+1IERdOQHcy+wkZuFymfj7YW5q0/9UmGzZKF5Y5QsCXI7+BzkoOTzTgR83q
         VkaL7nqEpTk+dEo7UCrSMG7GypsK8II4BjPiCmgr3LJFuyn5+e4lEbAeWlpyE8VkdzIJ
         8a+3SzcVYIAqLKH03ZbPToGD3l81Emu0jMh7xHk7lWQef3us7iD7KM3zRwfw/tI/ZltU
         NNvt5EF6XphTL0M6xYgacUPJHfc2+qDrXnW1TQYjRMBrqcQlphLKaLxXE5FQClO5iYWR
         V/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8D1YO6sd0c54kD6iJBZK2OCmGo9pDdAYg4PTg+FFCBw=;
        fh=b67Mk5kBV8bo/Qvcvzn0qdE+9m8oxrc1NCuSWbopfE8=;
        b=BXtwm5LEve7dW/ceOgWw6GWoH6rt4TsxEObLYAJ8w1zQzRIeJGnDb6Gc5u6urwPDrc
         Z+GJOl0N57IAjjBKU/wUbkelpT5nDSz0NiZzZ5OOltkAEMgaKnzHV8/eGh066/lwutPe
         xD7XfkzhWnmYtwPPzkcewa1DDve5eIaXuFlcT6XK+z/at6Nmmb7GIUlFjhIumgvYirya
         zM6veP85YtxGfS7oJicveIai8Wcjx+BBCTRbvVZCywqwqlt6dave3EN+taAHDp52shuB
         6q0zOQaRUEFohaQ+ijZo5qUrL5ETYWpoMfdLV+FsgACpO+zkzZpKX7hepD91gvj23Ozj
         qzhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790341575; x=1790946375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8D1YO6sd0c54kD6iJBZK2OCmGo9pDdAYg4PTg+FFCBw=;
        b=D2R8RzpXLblTvzVkG2HP0ao397SOqm2W8gBizobae6AJtnUzyGjl/qf4q/cRHBGGKN
         FO1Wi09RaxRYPgSb6gtvKdJT7vOkgi27Ow+f2KIRHwHPJ/nWje9lZf1bCkiit4UIA6zW
         LhTEo8K+mriBLLVlPpCg9pPTJEKjRbxg6X+qkASZjfgrCydkITa9+unMobkMHxuqAnUR
         WKpnm1v2UG1X2GztbDxXFUJ5pT8yW7yFIT+MLkE0bSSFw00pzhA8DS3q2pESQyCNOu1D
         mO+duoVJI13IFflxTZzMCU5awF74xWBBjo0HOb+GN5iFUIOlkmqW3wlYVVrYLQ2TCjU+
         v4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790341575; x=1790946375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8D1YO6sd0c54kD6iJBZK2OCmGo9pDdAYg4PTg+FFCBw=;
        b=ZK4GrPtK28NGFIbWritmZoLdXcUmINe+1lyRfXFaIt2k9PC7yq5uTU0DMcrfySSEtp
         lwWyVCT1M90nrH1YaNOqI916lsswycsy9SLbZw11vLtVYMDsPMx0H++4Isfm+1Z78DVi
         amsdk3sPiOTTLwMXykozizDpd3GNaWcinH8zvtTkeh3Fx8BQ8+URV843OknTSXlozP7X
         PIiGrj+A1dqyyt0osQTxz/j1nqB2q8WYzUt1U61KpDiAJ0e8U5Hbazrb4OsHx6YU03EM
         rNY39WUciQLTUuJs2wNRCZpuy7WHpeaF8pvAIZJeaZJzwggWr1tVKMzdYjYG30Tejrff
         0kbQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4O0mYuruua7mY2GPg6B4UsAFyEu2a5XmUp22Tt7QuB27l+PhiemjOWDUd6CTIi8OFKUhC3ZU=@vger.kernel.org
X-Gm-Message-State: AFuF++nkDJqbqqZ6jyRTJt2fxZlCEC1QHximk1JyCkeDf40MkOe+VPVt
	p/wTw1Kuv308R3mQ533ecRcZ1YIJXHUnsq91gouwqmbJn2eqO9CI7UiUTZRlsd/IJXd9s53ReRb
	y+7Tu2f54FBSb+B8J/greBV+vo6MfcB26hGJLr+F4
X-Gm-Gg: AYBFou1V5zEA567/U5Q9NaDIROURJbMw9j5hLsiqbgqmTo6Pa8PNTE3UxozRsF4Tveo
	XdRqISfz6Pggv7NFiBglMXKvYnNqqZ+sH06ZiHyzPeaE55ySfLwabu70guasNmgymlJrOchOVTu
	jcs3bL+dYN2AA7w7lF8hgdJnbR9Jtc8CDWl3Byv2ozOh3VWZZjSnGhi3IDqyFUE8urPjeAOyTxD
	7fPuhT4KUkJXxBq1NvLVNdfhl2ehA4M5JoxGPapqG69I+c2m9hsi10lfuFwdBHwyRNNQJlFeGU4
	6voiju4IHSG8xF2DVag0q0Qxtte7qh96iNEezaDdFGAEj63WGHcYHwzVw7Mg5dpgPXLvGFi1Puj
	fSzxXSoEC+hLA+QjkRrcDE6rzwONNLhzkiCSBa55qc/t50ssJAyJuya6ynhnKxn4E2j3W
X-Received: by 2002:ac8:598e:0:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-5330b5884b1mr41318051cf.1.1790341574370; Fri, 25 Sep 2026
 06:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924123602.1979090-3-edumazet@google.com> <179034054266.2160803.16187930067723490774@kernel.org>
In-Reply-To: <179034054266.2160803.16187930067723490774@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 15:06:03 +0200
X-Gm-Features: AclHuK_kYhiz0b4a3xexB36evdvdw25H6H7d9pOfTuBdTVxHRscKsusa68tO7UU
Message-ID: <CANn89iKOKtJVOm-24cyEUTta8VUsiw47VF9_h-73XX_YiqmBaA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/net: add SO_RESERVE_MEM test
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, weiwan@google.com, 
	horms@kernel.org, caixinchen1@huawei.com, netdev@vger.kernel.org, 
	edumazet@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 2:49=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 4 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new SO_RESERVE_MEM selftest needs memcg socket accounting
>   but never checks for it, so on systems without it the tests fail=E2=80=
=A6
> - [Medium] When socket() fails, check_non_tcp_rejected() only accepts
>   EAFNOSUPPORT or EPROTONOSUPPORT.
> - [Medium] cgroup_memory_max opens memory.max with plain O_WRONLY (line
>   217) and writes an 8-page limit (line 225) to the cgroup that holds=E2=
=80=A6
> - [Medium] preserved_after_traffic checks `get_fwd_alloc(cfd) >=3D 16*ps`
>   (line 325) right after recv(sfd, MSG_WAITALL) returns (line 323).
> - [Low] The fallback `#define SO_RESERVE_MEM 73` in so_reserve_mem.c
>   (line 21) is right only for the asm-generic, alpha and mips ABIs.
> - [Low] FIXTURE_SETUP writes "+memory" to <cgroup2
>   mount>/cgroup.subtree_control (line 80), and FIXTURE_TEARDOWN (lines=E2=
=80=A6

I have no intention to work more  on this test, which was really a first st=
ep.

This is going to be 10 versions of AI agents trying to talk to each other.

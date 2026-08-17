Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908642CAE6
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972953; cv=pass; b=W5u//nXSXqB9dtF1NWzRG/YGwZJxvFZCz39O3AuCpa87bdIwQ26OVrQzFPqkqjGqz9ylwwN//81+oF/vUTt4V0kT/Q7uupg3lF5sTBtaK3R7PUWYLGS6K3a2Ec1JM+o/IOZYsLfn9dHMKJ2rgXylcerJoj8tLIw71wNPPkurSv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972953; c=relaxed/simple;
	bh=IDXBICyW5K9yanU9AkRYwPsRUzVXWytBadGnz45RTes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2eOdXv5eVkdEBkS9qB3ynUoiKqH61v2a+MDA78sR1KUwblQsH9mlQZkNz3qKCnRmcTru9BpHyxvT1fZ/6hfXhrJlkXNtlYhYe/cEeJvp54Stg6BQ76d2dVDs7j6z9VYXKjdE67t0OLF1UNp7xS05bdtNO/0Cvtb4bc6Ad/a7qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YOSoSbJY; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="YOSoSbJY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84faf87d19dso3550206b3a.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786972948; cv=none;
        d=google.com; s=arc-20260327;
        b=AFvJRoFrl1Jq4GxyWmYnWyrGjxCT2YcMJV6AyJ4D2lPv++HXNIxVbwXgu6ncD280xM
         BwHXRMY6K1viCWi5DMkrf3yd3KYgbqU4gdi73xx+rg6jp8+oztszxqOuZqX9lPKZdWbR
         r59ro4FS1Pld8gX5WsNMMhmdU6Njc4bJmmVW51AGN1jZAqtz3cDAzPDT/uibFysS8Cpe
         PK3cuJ9BE1wEzFVghP23CkIR8rOWSiA7aCqk6mSZS4Vxomu9sL/GSxZsAh1IBRV01QNV
         qevhQEBQxz0nsk9q9sMEIF1z26RoVq/WPEyits/efTHuHNcsy89QUQneXRP497eGwNOB
         Z+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7p2R1K/orjZ9v/LS5PXtHMMx90Yq9cMvIs7A5Wjt7vM=;
        fh=SE+kJtiTTCvi51zOyxsxHiUyX+flnHb/pF5aArSyV10=;
        b=cM32pNeuDQUl/gbTUVj76K/A3pnlr2TkQb8DGhKMGDS7qRjd6jHy0l6hvJGq6/J7h+
         6QPaRWUYy2TZPvBGYJOvOx+NfsXkZkG7cGJJs6a23z5foDUPZ8kdZildJdfi/MJIAgT2
         MXjMfdS35+gDQzr09QZr+WHa7vMmUsCxeXAge6Hh25GMtHLEaQQhOUBtPNEWU2xn9Ee9
         h/DciH7kNyBiNew/Xk04eA8JdOiNsKEmSXynNSn2XFgq11bLnpFWE8t48qK0ZxF+lh0o
         jYMJhLh/5aDi3DrdS2h9n7TJydXR1YMXE6l6wHogpLprtUsC1Hvy/OPiINlsT+I2FOmr
         yvIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786972948; x=1787577748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7p2R1K/orjZ9v/LS5PXtHMMx90Yq9cMvIs7A5Wjt7vM=;
        b=YOSoSbJY9lksKFVXSUXy4IQWD8KGBXhUqarWZoPGHG0Jp5ch6CbUdM62jigoVAgsSf
         ERnFWCcyjQhSxde1uPRWmES7WqNum+OScElzReahKe6rgl9AGB5RTaqZG8yp1cSqHAkt
         qHxLH2tf1/rooKBo8BtqKoRUvFD5KDLFsEnNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972948; x=1787577748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7p2R1K/orjZ9v/LS5PXtHMMx90Yq9cMvIs7A5Wjt7vM=;
        b=q3ypEsvlv5YINVCs31168lMEd2SnC7z8L4oTtp5usTR0QN+JLVbCwlN9q9c4Nq1eLr
         y0xzQyUdYCObAXnH2IS/fqOniszxbZHncUPMSiZfEdzDYydrca4MOjxAGMhoYz8EukOS
         TDNB6r33sKYnaTlHp5jZ1l5G7MojCtbYeXxRkwCO+iSJ0m4jwD6WdsWqgm/MT3N8GBNu
         zLnOgSxRHQGAuLPiWUYs7pEXg9hEi19iUEXCSRxt/d9LoiIOEfw63WVyloZiv+4aBlXV
         tHm0reEmvGFTIr9ji/0jnReJfVQHqN+LeDqutZxNTW2bPpb4bXBRHz+xnig0KDQSw426
         YVdw==
X-Forwarded-Encrypted: i=1; AHgh+RqoYvVm2jDTqALhtzoaBWcxluy/lP49VsbMWmxe25MuzcrMxgn/LFWNENk6gCR2p0ntR0+0akc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyHTFGHQcYEk5VY9JNeoOj65b5oFamZvsVtzgvq5w+W+2Uqac
	B5RuTZuVWXBkeCgm3pQC0lDCwJq3b21WRfmB4Che8Fp1kJZATzTazeIbRFW59fSzOeRBNjRPpyF
	pth3+bNLxDIfMBDatyusxY+ocXOm+WxT9Jua9thAU
X-Gm-Gg: AR+sD13R7XkzZ1RvfuAzCJhNt+JldtRACmXMxaktTp97wFCMZEgFsRnLRmUES5IbXZX
	/paMQtAk472Uwo9E9Xk7B8hmZC94a4rgScvqotB1UVOqbZK2LEojfi7DuSu4F8NCPKUK8GpzzxS
	lxATxPOy79Oo6lNKwdqctjBGt9ewwW1O4UfLlhTU2IOEsTaQhdVecDJ2dWM5RmtU645hnM0zudm
	ttZI6V7JlrzAPAUogCN0AbwLqsmTAo//tAbCNREEHiweNTAlOzLgTphwz7k5nJw4kj084eB+fVY
	jBagUUnDPUvDAEQTGfFH6LlFyIgdfoYza8PmEmF+0w==
X-Received: by 2002:a05:6a00:4004:b0:847:99bb:b6d8 with SMTP id
 d2e1a72fcca58-84fde251c75mr26346536b3a.26.1786972947890; Mon, 17 Aug 2026
 06:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091657.879929-1-jhs@mojatatu.com> <20260809094325.2069096-1-zhanxusheng@xiaomi.com>
 <CAM0EoM=6zZVucSOUDi7pJiGhkoeTJ-PN9M18DnPWSpfH4GP6=A@mail.gmail.com> <20260813184515.16a874d9@kernel.org>
In-Reply-To: <20260813184515.16a874d9@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 17 Aug 2026 09:22:16 -0400
X-Gm-Features: AcwNN1Uuyh4IGGmXWZR6U_I6dcEzQ_QXz-mDnDul4sDrX6tz9HQAWXx5NYONCeI
Message-ID: <CAM0EoMkW2a-Brq7tfi36J1-_eGmX02GjGStnMm94oS5RsePkaA@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: gred: fix 32-bit backlog wrap in gred_enqueue
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, netdev@vger.kernel.org, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, David Ward <david.ward@ll.mit.edu>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 9 Aug 2026 05:56:01 -0400 Jamal Hadi Salim wrote:
> > > The gred check is the newer of the two: it came in with a3eb95f891d6,
> > > the commit in your Fixes tag, while the bfifo one goes back to the
> > > initial git import, so there is no useful Fixes: tag for it.
> > >
> > > bfifo also has more ways in than gred.  sch_red.c and sch_tbf.c insta=
ll a
> > > bfifo child through fifo_create_dflt() -> fifo_set_limit(), passing
> > > ctl->limit and qopt->limit straight from userspace; tc_red_qopt.limit=
 is
> > > likewise documented as bytes.  Since this is heading to stable, fixin=
g
> > > gred alone leaves those paths unchanged.
> > >
> >
> > I should have paid closer attention instead of focussing on the bug rep=
ort.
> > Since i already submitted, we can wait to see sashiko says - if
> > requires an update i can include the others; otherwise it will have to
> > be a followup patch.
>
> I _think_ the Medium severity issue Clashiko called pre-existing is
> in fact a corner case missed by the fix? Please shout if you disagree..
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809091657.879929=
-1-jhs@mojatatu.com

yes, it is. Sashiko (Clashiko?) a bit pushy. I will send a v2 because
i want to add plug and the fifo qdiscs since it is the same
bug/pattern.
Some of these things are ridiculuos tbh but they are bugs
nevertheless. I'm happy to note the bots are no longer finding serious
bugs.

cheers,
jamal


> pw-bot: cr

Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC078446065
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458593; cv=pass; b=LHrTcvXo198gK9TOghJAXt61VQB1xuiIcN9/dq+GmgKVRCI6HgYK0OJAPLkRHURrRsHsl/OC51Uud0SMjRFv4xKDzzkFXYLlVlnGaLoRZ7mYjWBibKLOzrODds3l+ZTnQE5GsXs3N/8ZSD4UpDiAluLybGiRbtgkrFZjhcKUiOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458593; c=relaxed/simple;
	bh=emQwqc9mzCiZHwIou7TBfv5Zkf1R5qVqTYx5ypZsZ8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0nOlJ7YXaolTR2eDWigB8iTBzBf4Xd8AQ2TSuvH6Oxj5ZICGG+oXZFfQo+MVolizevRoVX4b20XziO7mzIUeDQ+rgs8dzlQBwLSd0PFov42ToHkr2PlUQzfLmqplSYBDQ1JVdhBgDSROq4O9wZLQrvd7RqxLYZ6OP6XbA1jO1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arHb6N/Y; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arHb6N/Y"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66899c7b57bso1226685d50.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786458590; cv=none;
        d=google.com; s=arc-20260327;
        b=PHzifkb5fYBMEitGtBV6RkJb1Hly4XAI8DY00+tsbqCH/iJe/1fR5Hzq4c3JFHLqV7
         Du531TC3B8CG7gUeRLywHxBTAigOJly/v7+5UmMteIhcFr16HhXSojTOHKhLMqQWavDB
         hekwHgmTblkHhXmcHuWUdOYIPOVBATUl9TszWQtsHXcV+dbFNFKX8Ob5jjNnytRf5JdS
         RPNhU+SyMS61XDmI8nWmztaRZb0EeLqNQUXwm3cAVvczKqKMsL09jNmPfHGK/lcXDry3
         c6Zg/AChR8e79dr1XUm48nnwvOtOg/50zBOrPhTMx9jN3kMlBNDtQ1Y9Nk+TBaoOgWnG
         Nn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BvAEfzUrn06gSRYyw6LGQl24SGcs52Zoc6SpFTMDiQk=;
        fh=aZ9z+NuKYGW/njwBX9/AxVwhkSfo1SA7FBqhDETgiEQ=;
        b=URFB2E/5tFYdiz9ystSpjtJcOe7WctmAACQqHoffPQgEuzjxCAmI9YReP2tda9T9y9
         yutlS08h88+/3NjHe50PPCw2Gr+LIobuEU70EfeIb6cb/vSHh31WW5ntjWZY3+pNFSZc
         SbnxGhkIwDbdbsq8Y+rfIRtRcRRh3hPezlOujXwvX7YURBLEeIfk3K91kLS4b+GzMbIg
         5MOxbcZb5Gue/EYEy6kWfyWkjMW0X0hvLaIhLBizOGuzRGjP9BhpUpM0+xXKLgi/A24b
         K0tKdoGnBm/htQ66ZfphYHaZ8GkYC08UpaMV7dmEt23mFlDfWSsTyO0jaA59RtDaGOGN
         yHHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786458590; x=1787063390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BvAEfzUrn06gSRYyw6LGQl24SGcs52Zoc6SpFTMDiQk=;
        b=arHb6N/YvWN/rLlJ+EgWFrQQmcIseH2vRUgweggVEXSXrmyFeS5HOpNjlJonrDc5o/
         RPlV347BIy/IPiShgnSn6C99Z6+pqi63WfSjcDLgWSJnDWjQqOsTq0L19k3mKM8TvIgC
         MJLtQppxWq05hcJAhpG/q3cp2EHlBqr+M+4wtLtqegVfb6k92mpRiiayFthCPx444a0J
         5L11XPREhlso4OlCPnO3gRRZOJDGo8W4CvQViRLZ8t9wjdDDYlJYR+fQKtYKsIGagHKk
         FLNWobskLo/2+QIcgkXXI0UmNjay9Jr2J+aIBioexBWdBfdAwPlfyqhFDeLwJvW7RRop
         04rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458590; x=1787063390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BvAEfzUrn06gSRYyw6LGQl24SGcs52Zoc6SpFTMDiQk=;
        b=mZr0u182IBmjRgKh/Lubq/aKNjZlIkYd8Kha2kdGn3UIimgVEMLKFd5zrEaIHSkEHW
         LxlIwwBzzLmzVhvrKf2BE634sfqnHEq6H/e69qy2+5HW1AB7YYOr6LvHl6RKs6lHMXb1
         CVbVm8U5ATYqjFhKRNnBLjNPJhyqRlc4VnDRJjnDF5HkASHkwmInz8/pKW5AOB0YjDUu
         KikremPcrfa8jg3++dPscJ68Ryqr0nWrb/nt3mRTbG5lQsc0xp5da+pOlf4bd24dgOU/
         aJrSL8AR0COMHFUDZnyoRSvtOL2tIl8dKpDV11SNKPJOxTpt/DAZvS7+gKisc00Svpmd
         ubLg==
X-Gm-Message-State: AOJu0YxYUUoDcyVCokzwNrsNUeAJkAJ/UEbC+C25qDhccOqgLVcc9xub
	dXXMJMA+zvCXjmhQTimV0rMdewZ1XpFT2WVKRIfWA1Y8DjIwpe+zaShdcvLuegZjL7blv3yio5q
	reQxjk26brNk4lxJlqVJbyx0uhH0VtjIrkA==
X-Gm-Gg: AR+sD129XIsmtI9RLAZ7pM3hD3DmQpCQvYAtXPax0/VLvBvM27eAQD+1wPn3WafsuhE
	GkeQD+oeYPECdIIctT9d/1NVHHYQ95tKygdJazbVBjEJ5wCVoCRAP4cjA9apyXx+kD8JBkEQDlN
	J/kV6jERWC8AW/JQxMXnJYgBx57JaeiEZ0NQzozWLYWf9po8NmtyiDAbslbwqh7vU/T5FAJXP22
	cZN1h416ugJmSwhvp3ItRuI1lQLiPgkhBAZuhBX4zK+iG43VnzUJ7fRlahCOy9IiKaOA0m4kWF1
	CXRYO/0KpwsicntHFEXbMqdDUdI2/BtTu6s73ONM9vyQcl3hVpgm06KOlQy/SPGYLJ4Ulv0+HVl
	QeDc=
X-Received: by 2002:a05:690e:1a93:b0:664:d0ac:7c8f with SMTP id
 956f58d0204a3-66b2c3e4c18mr471547d50.30.1786458590282; Tue, 11 Aug 2026
 07:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808160129.890119-1-willemdebruijn.kernel@gmail.com> <20260810183118.32d5c06a@kernel.org>
In-Reply-To: <20260810183118.32d5c06a@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 11 Aug 2026 10:29:12 -0400
X-Gm-Features: AUfX_mwnByV7F-sJlbHR_ItWhZniZI-BEPRVSnBXFOfKsJDxPKH4z3CYHApwoCM
Message-ID: <CAF=yD-JsW3moq_xw+ZM5c8hxg77btODoBujMpNut3Nr04PYt4A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] selftests: drv-net: so_txtime: only send test
 traffic to sch_etf
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 9:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat,  8 Aug 2026 12:00:44 -0400 Willem de Bruijn wrote:
> >      orig =3D tc(f"qdisc show dev {ifname} root", json=3DTrue)[0].get("=
kind", None)
> >      defer(tc, f"qdisc replace dev {ifname} root {orig}")
> > -    tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
> > +    tc(f"qdisc replace dev {ifname} root handle 1: {qdisc} {optargs}")
>
> Ugh, sorry, I should have checked before applying.
> Looks like this regresses the test on all setup in NIPA.
>
> Random example:
> https://netdev.bots.linux.dev/logview.html?f=3D/logs/hwksft/X710/results/=
772526/test-outputs/11-so-txtime-py/stdout

Ugh apologies. This did not trigger for me on my debian trixie vm (nor
netdevsim). Where the mq root qdisc handle at boot is not 1:

And I was entirely unfamiliar with the subtle difference in tc qdisc
replace behavior when f"handle {handle}" is added.

Apparently

1. no handle -> can replace with a qdisc of a different kind
2. handle && !match -> same
3. handle && match -> expect modify in place, so kind must be same.

which makes sense.

I can reproduce after

tc qdisc replace dev eth0 root handle pfifo_fast
tc qdisc replace dev eth0 root handle 1: pfifo_fast

It is not possible to replace tc qdisc replace with a del + add pair,
due to "Error: Cannot delete qdisc with handle of zero." on systems
with the default 0: qdisc, like my debian trixie.

The simplest change, then, is to replace the qdisc twice, first for
the kind, then for the handle.

@@ -45,17 +45,18 @@ def _qdisc_setup(ifname, qdisc, optargs=3D""):
     """
     orig =3D tc(f"qdisc show dev {ifname} root", json=3DTrue)[0].get("kind=
", None)
     defer(tc, f"qdisc replace dev {ifname} root {orig}")
+    tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
     tc(f"qdisc replace dev {ifname} root handle 1: {qdisc} {optargs}")

It's an extra replace, so a bit ugly. But avoiding that requires
parsing the json for existing handle, branching on that.

I'm testing the above some more, will send that if no concerns.

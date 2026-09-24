Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277DD49EC66
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262775; cv=pass; b=jej2NufWrY+VML+YVLuZ0J3Fi0GD+luhpVZVVHUIYNQJ5lMn+f89SkhERFdRSRVhPihWrLZGOfPvw7BrMz2xjx2Rlt17nhEaoStpglf0e7YxEIx0IpAvSEJSjLNKIV2jJFPKPQi2ODkQecPMEAtq0fF+2L1bGCW6bdpSBO/ll+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262775; c=relaxed/simple;
	bh=ayzFfb1FouTGWibje+shic5Jd8f745FFhgi5JrHZ4pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGBxTnreMimhUGqRAOl4YtJutcHWiavPgmvRgDup6ZxFGir9A+dLVT7o5TqrDBUPxE94HGJTI47NaPgHw+OfEZnXxzVmJycc7wpSwydhiy2ySn3uiAEpflSwYKKSFKn5ghtzUlm7LS7WPtyhDkFSxbM/AE36Rj+2VQIKiUwwZQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sy9vj1LE; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sy9vj1LE"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so13890a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790262771; cv=none;
        d=google.com; s=arc-20260327;
        b=Zo153Xaf+8THak7QuV3UIFz3Gv4xL+YZZfz/nqQPJ0z4qeO4mQxeyOBJ65KoQfxn2h
         M93OO+yiB3Fc3HuNO/4otaEuCKNCXegiFEA9kDEw7z7GDr0m3lyfryW1aVvcuUHM+C/4
         boOierv+BQqONUVaEYUPHumtBP6q7CeoP3CsflpmbrMrjgI9DQGzmHV3g1ueT8eU44cY
         gjDzdkA8EO9Q+6wt9B3iTCA0Mh46P6fCr8Atny0lPrXUW5QxsdKoyduVT7IIH24K0/ec
         Xa+SKVTsoWi0taVUFvvHnXc1JtLw+tjnuQvdhoN9QWsykVkLoJvX4X8K2oCob+kTm7Qd
         pdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ayzFfb1FouTGWibje+shic5Jd8f745FFhgi5JrHZ4pw=;
        fh=8CzTddl5kGruf2TbqFgEwHf29N+HFYYgmTUn3cIWA3w=;
        b=pRJ9XRSdMbSFspZzzxj6Oh5VOfIIRjpzuWiwA+aqbyXrmE91iSLXMft3qP29gqGqns
         ZfMrpqDyDC632WxLF36b0F8/KZIPTaFZCKAASWRI5xW+ryvg/+IfSn52FOqbxloCWUb3
         npr2tTXV+8JMwJTGVPPmLwK1TM6+x/de7YOgK6kweBy0RlzQ+peOqQKQ50aXwCOoGnwA
         hYL6LMRhWULZUQfEBlldu0q9ZGlr70/Z93yW2OuzvhYwBSGR0SaLrnDwnpQGYuaTup8f
         yt5bBzkxtoSnGlxFJJRTogcyBJ/NqvypWMfTBzKUPalSwaUQ2tXuHIOF82yy6R9EEBjy
         2RSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790262771; x=1790867571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ayzFfb1FouTGWibje+shic5Jd8f745FFhgi5JrHZ4pw=;
        b=sy9vj1LEQ+/AmkcRo8gPmc9zlePmqcOBdevpf0vlpfompH9jFw+khCDXOc2VJng5RL
         nyRBWpTe0KqzQ/JYXa0Znj1GS3gah9JMgzY+XiSTgdvms9w/csbmvCtvsK/XjTcq+LYh
         85AZ81LsOaiWWONDQv/ODngWOqpG6dvE26NZAbvFLZVkZtqBzdOfK/PFGo44JKXU7L+r
         ZJFTh3etp+ZJcom8LcjHtCTIic5WAd9hbBuYdkHAiPv/pHM1klvhK+xpSCOe8LJncBWD
         8rXZwxl4PSkvzNW/Ruilt6c1VznDUUG10xHp9Rfhq/TGKcfq4W1YD2leccspnxTprXVo
         739A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262771; x=1790867571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ayzFfb1FouTGWibje+shic5Jd8f745FFhgi5JrHZ4pw=;
        b=otdeOa16E4AJp7pIFwoLtfcxkeslszsro/u1xw3rRMCkcTuXRsQyY060owfFRFEroL
         FkSS0leYgmzAhXd5kiAaePB/WnMkx0XG6GUuvwZz0G5ENeIVZ+s9ZlLOBRqA8Hxf/WSk
         6oSv1e2ogHT52/4xUapaSa/wxfD/Jr7DpvcG3ba+XMS6n4E1etLpIi5vZaT2/Aa+DzW+
         HGirece5D0/raPXN9jlDEJBgqQ+fPz/xOiga+H4VWoLy3wQ4kxccpqCnUv8WGUBi6nBa
         3RqrVm7lmFUawX1WUZIrjAnPjl/9rffe9lW8c5FqBYapIvz54gM04DCrE2OUpqca/OH/
         08qA==
X-Forwarded-Encrypted: i=1; AKwUvByGacr4x0KEtJu1PuM1Ygi7dXkFSY/5Ryapd5iFhMrjDB/6gMSTCOo/VnQK9lFZICJvIB433M8=@vger.kernel.org
X-Gm-Message-State: AFuF++nKq2V1Bl4DAMwXTqvfmu0iVYiQrOAhMJf23lPGOJFXnZHetjZP
	cDDjd6pZu8T88KIiIecWKF25jxREXoZhhZ33tBR4lIEsMSA7wNARbPdTzKdQ75oEcWHAmbZ7FQg
	7gnaFXKu7DJ/87+XtZZAsEiGGLBHDwE4LWPZpyX1H
X-Gm-Gg: AYBFou0w5TSIMFU2kFgGA0CfYk17AHfD3hAH1JU5Pc9bqICICX36GrwcOkNe/xdbyTt
	tSX2HtZSQ++QmP2+D20ybjmnb69z07r6djvLoOZ4EYgmWK1hM7D+w65g3AXqqHqed3KvCQMX/+E
	AecrUDs94AuxcCbm9QJdxboC7kC9+helcjkz8TH9yRyt4Ka6icaJHKt/YV+xJElDhNOIqBC49ad
	wUzHvMCGEPOV/NDDrL17u24DwW/KU5ZZthFzcG35hA+1XXwd2YdMOLJiNi00BuUn/aD1wpTOvE3
	u06/Pt/KNxtLyl5IOZdKZke5YyTblTAkQGFU2F2W4+aFrkc8psqtXJ/Q8E4bvfnsnLttaLU/W9E
	J2X6LJ84p6g2t3vD2GsA3VaZh8envSDpV8tchYwC2X0jgXQ8=
X-Received: by 2002:aa7:d899:0:b0:6a9:e652:ee7d with SMTP id
 4fb4d7f45d1cf-6aac7d310c8mr56832a12.16.1790262770450; Thu, 24 Sep 2026
 08:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921222609.50824-4-jeffjo@openai.com> <20260921222609.50824-6-jeffjo@openai.com>
 <CANn89iK00zXGA8sdpH9Y1CkFK3n=uKG9Bci3+=69fGV0UDQ80w@mail.gmail.com>
 <arIE_i8Ysz5nOI2W@com-94485> <CANn89i+nY499TfuGMvMq3P=Pxw6vBxe+uYH1zioK=bhU--GXYw@mail.gmail.com>
 <arK0UmX8qJy3O-rS@com-94485>
In-Reply-To: <arK0UmX8qJy3O-rS@com-94485>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 24 Sep 2026 11:12:30 -0400
X-Gm-Features: AclHuK8kdadyxKWpIT7s0hVkEOx-xmt8QKZIpbxbCbWF9vh84qV429WJhqE4KQM
Message-ID: <CADVnQym70oFVCvcsGsf1PRcKX4cPK5N60uW3Masf9nNV3c+yrA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: net: check timestamp echo after an old ACK
To: Jeff Jo <jeffjo@openai.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:01=E2=80=AFPM Jeff Jo <jeffjo@openai.com> wrote:
>
> O Tue, Sep 22, 2026 at 10:09:42AM +0200, Eric Dumazet wrote:
> > I saw you sent the packetdrill patch for formal inclusion.
> >
> > Let's wait for it to be merged and our runners to be updated, as the
> > kernel bug is minor.
> > This will allow us to get a nicer packetdrill test that exposes the
> > issue directly instead of via a workaround.
> >
> > Thanks!
>
> Sounds good, thank you!

Thank you, Jeff and Eric, for the fix!

I merged the packetdrill TS ECR fix patch into the packetdrill repo here:

https://github.com/google/packetdrill/commit/83f72d3f9085d0e26eb4d206fe4d7c=
fab5b6d872

Jeff, if you could revise your tests, re-run both your tests and the
existing packetdrill tests, ensure they pass, and then re-mail the
patches to the list, I'd appreciate it.

Thanks,
neal

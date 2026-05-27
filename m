Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7E2BD030
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846420; cv=pass; b=nZ0YbwoZsOL8qeNoV3If2nmGWrCjzeJTsMpXKVolKOLOO8z6o/tKYQZFNOtkN95ZrHWO1Gvy0CqC/g/s84Qzk5jK2s6jZ2LtOAC//j0RNQsFacGhODyCwFIfbgTE+oiWISk4kwURvXw2R9NaOdafVEg8pyk5mYeI6pbOnOsW78U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846420; c=relaxed/simple;
	bh=+04r+7H/Ff8/JI7yjuNcO/cMN2j9uJ3molBSVlXXxb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnX8mTPSiHJJc4SxYgr6//OzvXJIlrFpjljg8sx95Of/2hVGDoEB6Fo3/ih9qzgu+BrXlx7e2KE9AEz6sM/+DN2AUEJxLOzp2pD4mpK4RYR8rtm26p52nmoiRZxNBIyJEQPTU/ccExu8sswHizspO9mA/yMfH3BX4QRoL+b1U0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN82+6ZH; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN82+6ZH"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1353c2f35cfso791748c88.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779846418; cv=none;
        d=google.com; s=arc-20240605;
        b=ZU5XE6qwMYr4Os9Am2l2/K3mUQrvOYhfPQZPpADnAW984KezPER9CckbDvK/5W7B4d
         GCYUqZuVM1awdJu69MJXj7BuZbU9I56y5A7syNroBdYy9oTNLxdnEOoonrC+9wjztmFO
         10jz4AuqOa7ql5mA4bUCZrSeg29uBeq9NVebkxlsTrM9GdMoGUj5U2J21CfFSAt+gVeB
         Emv/5vMK7wS/c2xdqx7EX9IHLtLsUDVfYrN1EFf6roex0/Pmpj3XEbgoM7339FqPcErm
         3pqb9UniKVuLl5vso3HMCp3VXD1GTkUAoLtF+C8F3KeNvoD9BubWmtjm+fo3XgAlchJm
         ZmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+04r+7H/Ff8/JI7yjuNcO/cMN2j9uJ3molBSVlXXxb8=;
        fh=9Q33fPjAgLrll4yhCjC4KGkRhY+DuIFI6YNArEBgQxo=;
        b=F/+RAcUB2qxQAH0/D+lv5wrNr5qu0Namy+RE/feOjQs8/xdBT1624BA6vz75Q8dWTc
         oLfDKlknJiDKvjCLBKD6O1/6O7ZtfS53Dnz4S+82fuP7cewbcrOYCX+SWzE8R9FkIHmp
         WzfpmM9HAgW3+vH3EvnXEYRjZg8OUQRCvTawJwgoX+sUc5NI2VET0JE1px2FDigVDcLg
         QvjGUMu93u+QNsjAVPlKUrCrazT/UgZNP8ufWfIpD77axRXuDsKkDSi7Hz2zNgqEIg74
         rGYYnA8YGoy+XP2QTARUaVIu3oOo0LTf4WV/02Gq6V8CT54i3vNVpGTNyRM/pUfgfxC9
         GUpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846418; x=1780451218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04r+7H/Ff8/JI7yjuNcO/cMN2j9uJ3molBSVlXXxb8=;
        b=SN82+6ZHAEvroF0csEksfNoSkCRxpX82huKPXAgMmXU9JZZrb6Prt+E3vq+zPbsY6t
         uTCgWjBVlZDcx3Vn3QROrdXkqyVesQ6tNuGxeAFZcQFrA3MfNkMgDkruEzUpS1dOCi3t
         k/wZHkUqi6UadIEDNBCaZHg9mcrMIHFd6Us+0aTO/n/aKTinXcsRz5mLngNP1/F7EbNO
         rYwduKi29YnsBKd9elgJcUJ9/T2C/uwPczxnhy8V+AbtYXp9tv8tDJjkB6kup+28RtZo
         +XZxt3HU0BxiEuNg/MSbA7Lsphmbsdk7zGFTxcVZVa9IrYfj2u95oElhg2ylFLzBNlBF
         zA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846418; x=1780451218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+04r+7H/Ff8/JI7yjuNcO/cMN2j9uJ3molBSVlXXxb8=;
        b=pTTbVgzJCm/7uyfPRw6MumpSvy1vmzQ//WUL3FBRBHKYEy7NVIgI6i7Av5hEWePZ3q
         vdv+bkTyvdlZ5BQEcCN8QXA2NzFI37ip0HBgsptX838Um8VHlVxR6hTmWrpFW3W+Tasi
         OUQcvLYkEr0w2wRZwH16zO2tqaGQta+DqV+dpSmL5UeFX5dLNl0ZH8AnS6mx7YgMwZwQ
         V7TxSL5RVkcoFTKFKWKG+ove6st0/u2vbSVjkp7oE9ODFAT+c9lzmgglCGaGSpF5qXua
         Cpr8eYeKCTxode0e4D3tDUok+tO+JIKcnvlF3JniJOGXQdfWCGUBzjy2m0FBbDXMPK+D
         I7Yw==
X-Forwarded-Encrypted: i=1; AFNElJ/Xo3a/BmnaV76F/IzYKtPy6fSv7LvIu58deLIu8pLIX9/IHpMU2Tn/RQWRMGw/0QWnxlxwZGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYx7I2giba77NxRO63xWbnFfUJVANF95S8i4kWVr4pJWHDa9s
	NPnR6S5IIldM1M2/JgCXeXFMBJF7NUxcXP+Y4nd/sQeRVIkbzIXW+Q3ioai+4NKYJDm3pL7BNLC
	ze3R+O7tWFLxOtpb2RCD/Ar0vZmJc9Vg=
X-Gm-Gg: Acq92OGtxK5dvKvBQxoi+5Tc4ET1h1KHOoNgZrCu3gTJjbvbcGU13diGSU/RyC4M+f8
	agEUj2cz7YzAm7/dEVIMpXv3r5DGbt92NIZy9KTZfsp3gACVylJR7HoB6hYkM3mK6xF+rolSolR
	+mvKkP1kDADn7ICDE1ycuDfh2YaRNi6vYjBtEpeBxU4vDr5PeBQoP1znCAzTEFH6rTW7Z7vwfpw
	Wj8nHn+Eg3O1VP4a8ktg7qgjQBDJ556ZF7eKWvKKeC9O/ENU/o6kjzg33TxJL9Egh42ME55ErD/
	2yVqVLhQRZLsOTxgDrR0y7b/8dh+77c8ybcTS4Lc
X-Received: by 2002:a05:7022:313:b0:137:1ae1:bc19 with SMTP id
 a92af1059eb24-1371ae1bfe7mr2334555c88.5.1779846417889; Tue, 26 May 2026
 18:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20260526180233.4323832d@kernel.org>
In-Reply-To: <20260526180233.4323832d@kernel.org>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Tue, 26 May 2026 20:46:46 -0500
X-Gm-Features: AVHnY4IkCZ3xS069Ov0wNSWJciSMcrWEH40NF12aPNiUZ8pKKwxyYuBAVL5md_A
Message-ID: <CAHYQsXQ4qQa9nLc6re=Oobyojv3FVG9Pc+3KVEq4qKXEq3kXYg@mail.gmail.com>
Subject: Re: [PATCH net] octeontx2-af: cn10k: restrict LMTLINE sharing to same PF
To: Jakub Kicinski <kuba@kernel.org>
Cc: Junrui Luo <moonafterrain@outlook.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

I worked with Junrui on discovering this bug and preparing the patch.
I found the bug and reported it to Junrui, and he helped write the
patch. There may be some overlap with other work.

Thanks.

On Tue, May 26, 2026 at 8:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 24 May 2026 15:29:29 +0800 Junrui Luo wrote:
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
>
> Really? I thought I saw this reported in Sashiko..
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260520154157.143931=
9-1-michael.bommarito@gmail.com
>
> Either way, Marvell folks - please review.



--=20
Yuhao Jiang

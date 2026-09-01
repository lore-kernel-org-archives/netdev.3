Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4034B1B0
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 05:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240558; cv=pass; b=QgKgxiospdMLBPX71KjGQeSl3pqI4eLbLOVplIW6xSE7I+Hud7YXdLaYyIAeNMfn20QP+OBF9dHIcFQMpxt3gasO7i7Vk7B17KwlGKCAIQUSBAAgDIqt0o3p7kFbD3VdI7bieJEff3zxPiw8RBxeT4BaLV6loN4sBUl9bD9DTKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240558; c=relaxed/simple;
	bh=GwctvFwVAkHjOBx4vb1TrJmuUy6f2b/bl2DeLQJ1Qkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtKAu8nXvW2BGMwo3flbmzSVGMH1HpDE9ysi+qu9TIsKx0MTE0tn04LuoeZAhDR74hU79UpoPgm+L4qOPedZXd2BWkjTcXI40J2l1UW6bT0tAJMbLeIXZBTulNqhYYyxMePUCtrGsOAp2u8JwUSTCVebLOqVsJHDb8Nod5g0TDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLum7CxT; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLum7CxT"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso2590987a91.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 22:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788240556; cv=none;
        d=google.com; s=arc-20260327;
        b=Jd+S2FpcteF+UUts4hx5qfqnOf0hoJkFTE+Uahck1gEZRyVQb3Nb3KwwwKrqBvbyfT
         pCAL+0qPEXLpJbAM69n+JWz8r8xq6GB5JzvqUsCuCH5t9vADdMju5FcQrr+0kixj6YrU
         3tZQDcgxw7wilHRVqXckPbT8EUyJ7d8DCR37AyUXn1NPDOXPuTx787HNPCjoPM/fL3x1
         MNRvXruUu740iBb3SBrt0IpQ/KA2Ock6NvAq0rtOGDR6SXsh5UQzQlfaeF3X4VwyGVZQ
         Vhm/R97B0swQjPTB9waISMqi73Jb3gOkJADzdCQN4MAT6MW5wyrPIC3/pG9+2mUmvor5
         yJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GwctvFwVAkHjOBx4vb1TrJmuUy6f2b/bl2DeLQJ1Qkg=;
        fh=jIVrljIstUHQXcWgNK0aHnNJmDK3aIFTwjZvYj6Y+z8=;
        b=cINTBXF+3K5e7R3rDSSx7XHTF3DAoPYZt8QlUXBGkdzBM3ec4gaTGFxG3F143NztTO
         A82zQ/FHMLj/HfoGOBHDUcGaUX4wL6zVX3eGWWgIUSCzBxkqYcAiSSp4T3QzR+6ca6M5
         Gt2swIH/f4ko7xPEb1hgi+1VxleLdqj9Jwbq36a9MkGJO7L3Oz9iWKYWRKZjqe621STu
         6s6AsEKCge4lmx26KQ96tP6zw0chdT3SGE09AyI1mxwu7qRj9gKULgtRKtxRpCnSjtgT
         mWIJ6qLISVVnRrEfKY1iPL68/J7T6qnFhtVW0UoQapW+IbhRUn+XIFyu9wMR8yIH0+1Z
         17BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788240556; x=1788845356; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwctvFwVAkHjOBx4vb1TrJmuUy6f2b/bl2DeLQJ1Qkg=;
        b=YLum7CxTRINirvmrxLuNbnKa8zV1npR9BdkWNXS8DGFuJfD188YQ6MagcUydcr2Bql
         CtKdEr595+Zyj5uZUC+Wy1s12/X0k3ri6b5J5FoumC4OxtkyME5H0v1orex6bmrx47vV
         JhUQye88UnH6yHtIgKWt+xWpZfet+EBP25fCcUj6uHqNEemLARKUJqc5LcQhfoEYvSQY
         4ozWsC0SjtcqpXffQ3lk6srV5XD7SdiKfrvdQNfrZlK9If+9kZA6wQSXIBq0Me8blu6D
         2RBNRuDbGnC8xMjYuB9tyVMgzvOeyfQWXiTB6jw7f6vuiBdhdWyrEUUNk4Fm5RYG0RA4
         yOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788240556; x=1788845356;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GwctvFwVAkHjOBx4vb1TrJmuUy6f2b/bl2DeLQJ1Qkg=;
        b=CqmBNHtsFYkQ7Ze8a7BSUXWlHJ47tXpk13LuZww9OlQDFn3Fb9R2DWPl2FyPYDeCjy
         6Jm2xwXkwO1eqHoBYT51E8iveP7xGeO7zO8yfOqweLOsg7ZXtRzWGGtV/L6meYNhRn7g
         PKB3eEq92qoRl5LX9jeXdyhjMZs4RT1nCSy5pKxmEo7YqlUV/+P57ftKBqgvtarzYreS
         coneiX90w18gM+vd2Fbc8gopCYsL4ypYzDpGIKguxW1Xltx9SDDQMwXHI32wLrgYVh4r
         4Dne3V9bf8jL9zR1yneeS1/a5TWcMqQ6Lwea1o6teyAKQ3tNb0uc/+YVltuUSEwIercq
         27xA==
X-Forwarded-Encrypted: i=1; AKwUvByWx2NiXmO06efpODyzjqdk0gR/rpEqrKXdTFweJx3s0ZB5P0kuzf1eKmj9r9TJjUF/NC8fdCk=@vger.kernel.org
X-Gm-Message-State: AFuF++kB7/uRy9QMRzD1JUgP1zpgWkXqFGZoFoqDnyXRP05QWlEHtTSK
	lIdHhLVJbWnQ/izUBHC6EnN0gvPiiBn2d0Nkd49eJDc76UsX+ABk2c4xfs124mITCzxROjAG1vx
	S2X/kowvuoQkIDjHLi4XqRmI9m244pMJsEOX0oMQ=
X-Gm-Gg: AYBFou1F6Xz8bX4iHnrUEI20UKX7E++j4HcyjvLlrTIjYOJgDbu3l6XAc3W/A3qDDIL
	rrJ4Qc2AchAui6PE+jkKBbfbgEMF7S/661S+Z1udXCBdE4tHp9ejo7C40hFEvBbyuZkMbbKLpef
	tQJO1QeX/CBvCt80RBkVpUGTIMzHL112md+UWZE96n34WgtmSUXKTcLWOFWMoSdVmNTCkigPH9c
	53q3IPw71aAchrGidNO4RsQGmx1RjOfqP9ViVzFyeOID/MS3bk//QoGwLlquLkl4kcw0W6gnNuW
	ykONpkiK3wtHnWn8JwRYoGBALfDsE7dkX1y7boGT7uzpzxKAmsm3OL4Jnbwj73GFf6J62OvFMcL
	NyCTHsw2s2CWRc+OCd4QXsa/4qTI=
X-Received: by 2002:a17:90b:3910:b0:398:9beb:5c17 with SMTP id
 98e67ed59e1d1-3989beb6373mr29600132a91.18.1788240556415; Mon, 31 Aug 2026
 22:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831085217.391-1-strst.gs@gmail.com> <CAOiHx=md28_BmsDOsNDp0XbUpfih=P+-+aDYb6tiWPJTCu1drg@mail.gmail.com>
 <CAAsRjRktqEx+-CLDO_q6rLUBe1dtRQPH1NkX4xy7ichx79yGPQ@mail.gmail.com> <739079cd-dc83-4b53-a3a9-a7e610379d19@broadcom.com>
In-Reply-To: <739079cd-dc83-4b53-a3a9-a7e610379d19@broadcom.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Tue, 1 Sep 2026 08:29:05 +0300
X-Gm-Features: AcwNN1UEeHd9ZRjJ0HoaeursBIRKyHkxNHGprx228jpqMq4BYYExnIVM06ec9EU
Message-ID: <CAAsRjRn8AFBN7k3i4TMLpLsyFQc5DSL-a9u+OieFyVtYgD6x4w@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Florian,

On Tue, Sep 1, 2026 at 3:24 AM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
> But you control exact how the DTS gets distributed in OpenWrt, why not
> just fix all of the DTSes there and have the users confirm that using
> port 8 as the IMP works?
>
> Don't get me wrong, I am very appreciative that you spent a decent
> amount of time trying to come up with some sort of solution.

Thank you. Yes, that is what I am planning to do. Port 8 as the IMP
is already confirmed on my board, tagged RX and PPPoE come back with
no driver changes. Next week I will start with my own board in
OpenWrt and hope owners of the other bcm53xx devices can confirm
theirs.

Best regards,
Semih

Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410D45FFD3
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432316; cv=pass; b=Ev9moca05ReVg5Ljc8w4eAVCGmub6FByAprKkD4Ap5rvoC5CurD2J3wXEmvB8rKHOSsWpGCNSxjxpb//wBA/DB4jtWhxSfbJ+wmm6J877XRD/nV4YSkRQ1Tk50p7NdT5+OOo2XYwlrDMOXwGKLNT0MzqNdJCnDLJbGauJelLwJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432316; c=relaxed/simple;
	bh=MC3LKltk3JTVfZBBFyqVVxV3QzHvBo5VHIAP3AgGrfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYAVvhJBWUC4LACRbSMPpkuHeBGCv8dKZVdyxXomDOy9EG0XNkK527cPzddI5Raj8zv/xoBd/uc/jXChAICxJEZoG8XWXGGMMQGPag8AtSR6+j9CAzdpyCkR9XYoylmdwYgwaVlbNWHsyKUiZrGh2GFAYdPlvXXtipKHC20aXCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7WlaipP; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7WlaipP"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so1943571b3a.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 03:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788432315; cv=none;
        d=google.com; s=arc-20260327;
        b=A0aEakB3lkVRMZ1N2PVvrelgdRulsCsY7NpUIjvhEe9LyGxnfCBAz52eDqSF7lhCYi
         7xYet/COW1MUOwdZEQ/K1HmmaJqbJMeeCF5GS3L6HxF6nyvhLnPGA0wilP2IHJAiqmDG
         zKIGx48U1kN4bqOEe1MZF2R7BJWOAE7i5P1IzGhnfmlNRFA03/wlPR9Ce3olEpSkf8Ek
         FcVMi+oIqlNCgTMpD+Tk4eqNWXOGkAZVemizpl0ts20rnTpoM5Yl6ZxG301JgqE15hi+
         JLQq7jYM6ArnMxtjPdyeleG8xTqZN+crtc9k0p8C22acUX8okFonFqIk1ynSxJW+x3IH
         9cnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MC3LKltk3JTVfZBBFyqVVxV3QzHvBo5VHIAP3AgGrfA=;
        fh=ZhYB0aylptsJFMT3E0hytIqe7G1kz4wljwxiWc/KwZY=;
        b=WUgi9awJEzuksj0E1YlfjcVC07m4fyC2UTSM84Jzg/tp3iPedWHjZYT5bxyKuKhH2/
         Vi60I0+F2nxwQE1KHXB9OhHFI/cK7ArYKTTfZb0iPc+1Z8dqup8yO3S97lcnABHpNgwI
         jeL6BlUUdFWi2LhTQHcH41vue4E+t5JonUP1W6jsyjIUChJaaKgWCPfXH4nvZHE8kRV9
         p8Sn8XTsTsiD8Mtn6dOAijt2hW11+pdcY97yRNlrP6HndBQ8htoZhV6IBSraaDLjvYNT
         YQyzrHig1zkQwyI8tMkNpgu6DWoiXSLlv4l6j23C89cyiqH5K2YERKerS24qblAo6KTT
         R9CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788432315; x=1789037115; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MC3LKltk3JTVfZBBFyqVVxV3QzHvBo5VHIAP3AgGrfA=;
        b=V7WlaipPCMCSNOBKODUtdVgLuZMdrvhJlzJkJLRLwDZWPzhA5OkVG0eYxDO/qrEKsG
         eLTq6GQBZQsQjOU1caWyqT2d6Bf4I2ruCHu0NITjY7Y0FM57mYqQrzI5ZfVqYIak1Sgt
         CE+dVo6+mm6kJvuh0YER/7Bpkmosc9zFhNb6U6zvgrHGSanG56yDAmI9aKnBHaTQ6YVJ
         uDpM6zA2lOmZWH2mUoKyqSLZUSaHUoRt02KYmUUCJNUBo8J2cVcWWc1prmd5byELUx7M
         9oNb3GNDOZSQDw98VNTpuLBspNRUPDamIk1Re2MVtI1wJLucC7Z+yOwlIU9CcQIZqpoa
         24Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788432315; x=1789037115;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MC3LKltk3JTVfZBBFyqVVxV3QzHvBo5VHIAP3AgGrfA=;
        b=tGfIOc0CD38ipn/DCyUpylY9FyOCwGE5HVVD9rTv7IiqwPVkV7oXtysur7TitplLGK
         /wIgSOzNR1SaNwfN56JyVKGWV1KcMd3RwVLl/i8OTJ/VH6QH7FYPpbfbO61Y3jftGfr2
         jYJGZrZLx14m8woNfuiSiFFjK+MNitIJIa6GjLGagU4c9cny3To3xUfpXFXORin7m+bc
         sbmvGb5JJRvlnYuIDYZHuI24KUqyz5JZLvYHT5E0uz4YosL3oOMxFSx23J2CObvrSs+y
         HRIGhTsDp7dKC8o6MyuU/3URRLyVgyoe2U6x3taUIm24UGJBaA33uJAaNaLxjqQdmWTZ
         S5KQ==
X-Forwarded-Encrypted: i=1; AKwUvBzClyJr2bFwIj86OVAAnFUKrjcdnu7LpIXoYPR+XINuGCE16Bg4uTTtN0JZkAwTAwBBCMNbN28=@vger.kernel.org
X-Gm-Message-State: AFuF++m4vOGg7NheD7epGH4U63Y6YqPUhgK+8Czu7HxY0wU8zJJaQlSC
	y405ZO/589KXSXOz0lmnw9b+gbDrN5GeS9vr0lajI20b2eYJlTgffIXPAXBtvcT/t8bDMnqkSg+
	bullNmLNziiD5w8NT7R/pSYENBsb+Er8=
X-Gm-Gg: AYBFou18omowbfu0jpebCQHmfkwp4vuSnguJdoX6r1nsCdUBlIuos0h4Ky3nJiUJIMg
	A1IBH1E/HL6GKPofsfslOCP2Mk8Qa2j1a8MJ46qkuMZPQLrdv9vFcWa0I546WQ9AKXomeaYNy7m
	OowMKuh3zNl38pN2AspLQ8RT2YAeOHukOON1ECmCfl9xZ5PqPmB89W6cyQgd8/l9MyVv5XPuTjF
	aN9BIIFUg9SIvbNNDPAgguhLag8akCGoKYazxxZJ9YQIe6+jnXzLF0IP6WgJHW5q342PrPCRGoh
	BMXWpNus/Y7O96mdOY4AzJHmXVdvj9UJMGWCJv4HvJZ+cMZeA+LU2c/JPUkmep8/TJbXvnf7GnV
	vA0uji+eatcOXjQuTov25oRvwgD++dljVtjKUs6GfnjNLbjWpOocfPKHls4WOnYLwYdc=
X-Received: by 2002:a05:6a00:409a:b0:84f:dfa8:57c5 with SMTP id
 d2e1a72fcca58-85ed398aec5mr16632746b3a.13.1788432314612; Thu, 03 Sep 2026
 03:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903092430.354186-1-phucduc.bui@gmail.com> <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
In-Reply-To: <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 3 Sep 2026 17:45:03 +0700
X-Gm-Features: AcwNN1WSJhqM0iZz0vmdxNeM9znHr1Ya_X824RjSXnv6-S-4Z4zMmbAJxEGwZ6Y
Message-ID: <CAABR9nFD1+GJiWdyxiuGVRzKjpCUfu3TQHYOLnOym3hHzOM2tg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
To: Wei Fang <wei.fang@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, 
	Stephen Boyd <swboyd@chromium.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Wei,

Thanks for the feedback.

> >
> > Fixes: b86bcb299092 ("net: fec_ptp: Use platform_get_irq_xxx_optional() to
> > avoid error message")
>
> If this is a bug fix, it should target to net tree rather than net-next.
>


On a previous (different) patch with a Fixes tag, I was advised to
target 'net-next' instead,
so I submitted this one to 'net-next' first to be safe.

If you think this fix for commit b86bcb299092 belongs in 'net', please
let me know and
I will resubmit it as a v2 targeting the 'net' tree.

Best regards,
Phuc

Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8838332A
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787287798; cv=pass; b=ciYtQh8x+cCnBS+Tl2Pr7ceeKSPZ8pILdUM3UZJVbPfuarVt0TGuX1Ac/ecy33hPEjsNQeb26pAYLlwAPFTiTvK9Q/J6aKDeEwxV62sNiQSNUsBAkIOM5M8irOV+3CbJ1Iw4PBGIsU46L6NhZIK+3x5NhGflXDrGMxaKsF8tbl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787287798; c=relaxed/simple;
	bh=ZdwbukgKMZpFMb/tOHgfdkhhWXLuGK6kfhgy4uhoisE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwZWMhC9VYIFnjW151wAd8oBHYxITBcNAvRF0tuLv6rR5OBtY6ShqJPOdDsROefXQh4bcam1kxr7Gxw+bOLW/yQwLt18PHnCQGobWZ8Cy9gr+16awZu+cQCumnKxJc9bTzmDx6yyI6DtsDqOUj4HQsAaRdjuLAjRlkzdro+o2Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0zYnMbi; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0zYnMbi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d53197d8b5so6546825ad.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787287796; cv=none;
        d=google.com; s=arc-20260327;
        b=XkRhPQRT9VhUWSk2oTrfevNmSYD3/AuajO5vftB36dC4z30gfi0rvQxy/GGF1izeqL
         rYbhyrefHwAnyYg2y+NBDAoL2vsePAGAQv5kf5ygPL7hk1AnXZlOwG6IWR7k5iWdEP/X
         FyOZqWi4mSurXQyqP6U8/yRZldl7mZrKXr09vn76VqE0WzB79Xu6NPd4FhgPVRzVm6EO
         we1hz0eiERhG1njiSDl7HUqs3xbxmNFONTHk+MElFz9pFZ2gx8YAnTSlC07K2qEzwN/b
         InkGnJeWUX6JBOzQ6c3hRhidr8T9pKsOlqdGZTGSb/iAH+/F69MkmcQWcUQwP9RS2giN
         yilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZdwbukgKMZpFMb/tOHgfdkhhWXLuGK6kfhgy4uhoisE=;
        fh=+p9LjLIo89wADV+5G9JCe1YLWUtOuz1AYbbe6WU54z8=;
        b=Y2JlU28duFAfcmwC9Q8zfwO49LAVOPvTQXcWL0+Ub0KwxHNGC9AEQyKtIXXWnFAGEK
         +5Mi++VDlYF9setn8PboTtkIey8SU8iSSmq+2fnSyxLVVpUc1ff4TiuZiBjz2ACtLRGC
         LMnMWR4AiqzmJiYgWxNGP/EiZk4+5ZkkbLvy3QRO891edkG/Q7mHmo+cAE1sZOosPk3v
         VSfaeqSg4NpAbhEKIeiA84Ihk1aC78i7n8XnDx3BSW88UMLumQwzPbMGmCjaLVYuD6Tl
         Hd9mjIIELfjQ7kusb6B/cWlPKxeNTT0OZPeH9XiMTiaeHmemRdaWqulcAlH5fYuHbvHL
         GEjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787287796; x=1787892596; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZdwbukgKMZpFMb/tOHgfdkhhWXLuGK6kfhgy4uhoisE=;
        b=U0zYnMbi69e6VTJ3kq12RiJbkWLo8Q6NW8N2VOnsbDKIBsN3V6P3uzd+F8Xt9yFlwM
         tKzwc6+Lfk/FBa1xTUOj0ZLupdpxjmqc1BdqOjkbxGQFK2OJXHXpoQDRyMbiuBIPvutR
         MkiyQcINuTCEOTlroHnPMDeIir2wxMZACGvN2Xnpy5S0vnjBENwpaaLeFVn1eNCLLU/C
         T0gGlbKRiGMHHJ7fx4bgFN13iURyiJ7Jmwys9CWuq5ECJE+aodmXpPBatoNZPOOsbH20
         h6d8oDqipr+3ch7tvVH+0rjxnX6VDm0xfQQ/Jm6J/iOpem8zk5usBKrRz65JtI0vFlxr
         tq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787287796; x=1787892596;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZdwbukgKMZpFMb/tOHgfdkhhWXLuGK6kfhgy4uhoisE=;
        b=kawVlIempEshqQWjYbIZsyWv8zBXKlggiYFQjm38h9HW6koMqppIYmCP/NMNy1xw44
         XjtHVlJ5se24hcilAKwNljjGqePRrC2Bg/MKEy6KFo0x60oZPITKaB9y2Qdu1C2w6ZB8
         FWaZyKseKdfhW1iMaM7F0GL6JAVkQ8pgIosPtP8itOUGhU4Ggi7BCKpFl9p5Mjdpl+NJ
         lWP8aFfEFHx+2yqb5Kc6cr+2LN3rimvFhV7sacK1F+foa1VxwVfVEDxJmg5GneNa5nXX
         Z3VHtEoApb34LX4G1yz20aUpbc62Z5/0sMDeIfwJ1H2v//qFqkSGs2zOoH63taKscLIo
         LqXw==
X-Forwarded-Encrypted: i=1; AHgh+RpuTwW1rK+C7OhASXziu+nvEG/fZuf0tW95S858Vw3vvqBAmixYuar9FGE73Tj072FnkInPhBU=@vger.kernel.org
X-Gm-Message-State: AFuF++kOG2/JdNTUxYSJmS3u5oi5k3bImShyAJhN87HIGlOIiB51/FTs
	mSy8iE8fyCj2VexxBblwX3l+xMNG9M7aytyFTwrQI6vdakxY5I0UL/jBhGYIQdgi7rJbcJrPDPT
	xnQKVp4gM7L+MbpDChlSTeE3PyYi1/3M=
X-Gm-Gg: AR+sD13ybvHIMldYGJjXgchQ6Q9pNMgwz6OdY3FX3KhjoHx+ck1VtVvtOzWtcmahpiO
	XAuobEpNn08bHtFDslzEUzaRI5iLasXVckL65HGux2FnWxhvyLJ+S26WHEi21rTbYRU8WfbFRZK
	typVgcR0BSrxd2DDudHUAG2w7Rp/wGW5grpYULk7kqhS4g2DnMScHOtO5zCuP2UH/md27aMC+uL
	tDi3B72dHDohQuQuhEa/sch57MERQWpxicMhPm1Nzop7QtD65wc5O+rytGWtwgwm6qnAneG9Zva
	n59cA9j6LRW7qskRhnrncmkm3+OYksgS8lSM1N55fdaSorNJ/w5MsCMlgomesUCqQF6s1xsTZji
	eSp+FKPHa/+Nn3IbXhoRA7c8yvz/Eu9MMBUVVK5v9Fz8nSevOnystjLBs
X-Received: by 2002:a17:903:32cc:b0:2cc:f5b8:4c2e with SMTP id
 d9443c01a7336-2d64b0cd474mr68137735ad.9.1787287796019; Thu, 20 Aug 2026
 21:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820111456.97947-1-phucduc.bui@gmail.com> <a618bdba-c370-4f16-ac09-0f7ceb742d42@redhat.com>
 <cc18ef57-4f5b-4459-b110-b29bf2c8b8eb@broadcom.com> <1958a140-a3ff-4f0c-8982-9695d1dbd8a1@broadcom.com>
 <CAABR9nGr+cYmGsj2eXHCRRvN7TkcsT_bTS2LkA537Z2Ns0VORQ@mail.gmail.com> <f999c24e-7009-45aa-bf09-658d368af8eb@lunn.ch>
In-Reply-To: <f999c24e-7009-45aa-bf09-658d368af8eb@lunn.ch>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 21 Aug 2026 11:49:44 +0700
X-Gm-Features: AcwNN1UVQu0uelIKuaGK9fTcDQciPO75G5IgmKbCKEOLs67XQkyD99maPpgIYKM
Message-ID: <CAABR9nEA1nu9DyXDDqYS2oSi+zzR1e5Z9C+WqEsxE-jX83=xPA@mail.gmail.com>
Subject: Re: [PATCH 0/4] net: broadcom: Improve IRQ error handling
To: Andrew Lunn <andrew@lunn.ch>
Cc: Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Paolo Abeni <pabeni@redhat.com>, 
	Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thank you for your feedback.

>
> > What about -EPROBE_DEFER? Do you also want to ignore it and not
> > give the driver a chance to probe again?
>
> Please do some git research. How long has the code been this way?
>
> If -EPROBE_DEFER was a problem, why has nobody reported it?
>

I did some git research as suggested and found commit 6b77c06655b8
("net: bcmgenet: Check for Wake-on-LAN interrupt probe deferral") written
by Florian back in 2022:

https://lore.kernel.org/r/20220511031752.2245566-1-f.fainelli@gmail.com

In that commit, Florian specifically highlighted that the interrupt
controller (irq-bcm7038-l1.c) might be probed after the Ethernet driver,
requiring an explicit check for -EPROBE_DEFER to ensure the interrupt is
eventually fetched.

This commit clearly shows that probe deferral and IRQ lookup issues on these
Broadcom controllers are real-world problems rather than theoretical edge cases.

Best regards,
Phuc

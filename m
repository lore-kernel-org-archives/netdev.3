Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A04A99D7
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531163; cv=pass; b=PZzXeQ3TKwI4p/N1TCpfRiNLtQhgvidWzGw/vQwO1cvCWhxfH52gdjgy+3JfZL4ScxHsotHD3N8P/oSZw7iK0eWzCdjO9dlyjPvo3FZS/OOdzrMySvZR0j0kfwJ/p8XEyOkfrAlSgpzVS8inA1NOtnyIPZZSF+vL3fDRxNIOj3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531163; c=relaxed/simple;
	bh=tJiXGDNLyxuN396q5CUOQROK9/agExeMPwA8K6/acLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKosARPeidOADQ7bmss1J+Em5H3w6bVvVZTRrBBgoPMZApYJsS3b/EW6hV+Y/9EgtToZAsAKIAsYqLBLxKzm1V+W1GKud1YnxpwiPpsQyLo7rvh+Bu9fY+TAQ15gR1ITAwGo7sKB4WC0OXBNhj69MUzqW4r/WOWfkDEdb06D1ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzVe/MIv; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzVe/MIv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c253425b253so152709766b.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 07:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788531158; cv=none;
        d=google.com; s=arc-20260327;
        b=Vs7J2zrMruL8nIf/dAx3T3lKX23NmRM/87GKxqverxhFzdpjd3OOLoEMC8A87+5Cih
         dsbJJIYwmaXn7zTSMo7TQUetuq0uEe7TfzLx8MDqRxzBbo/Qr3wzPk7PMKKtgpFSTyN1
         k8NZFWJAmCUGaV4ON1mLeZis5KPNaifUc8cbjKT5hxBnn4ApwZ/l+2oXNGWVD2Ctjc6J
         LrxytTnsedJ1O/AupP+Fg1TzvE1I++gIdPbXF/SmCOMOJMoBwKmNWFEU441ghSKU51kx
         N+TYTfVH9R+6DS+bi+z7ixocfYSmtebzm/a4+9aY6L0t3o0ksv10ulvywl4wBbiYTsXS
         u1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yNlBRwCMNMD3QTbLrkFdaLqTwN+WPCN5l1kXt+BpUQY=;
        fh=zLky42nQ0cEc2RzDN91ZqlL6+SoXNBxbXJgik5tjfzg=;
        b=KVeeEdv0QH0moq5+wjEHu+Luoxwndulx2eAsMbXokqpgYW0PtD4yVF+X/A55MMJvjz
         bZhXL/jRUr6ZtsR07ktt6AzJe7ikIwf0DKoFrTvSH0rJZXG+YnK4x/Hok4OhBKl5rG8T
         ePg7syw8pnQM63O1+l2pJb4ulylIgIRIGV160La0uDjfFUADJauZdQNdTBfbtF0izYGZ
         9gB4I4dQ8c3uFTkiB1Wx+nc+ZOMT4ROPScoLP0s5D8pDZERJDqpjiLMV9SGbsP40WrDm
         7X3D3i9sD236b1SzLG2qtuz6sWv5v0gB/3l990x5/tiW2jFGckpIAgKp+hQmVnrVmIFC
         fCPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788531158; x=1789135958; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNlBRwCMNMD3QTbLrkFdaLqTwN+WPCN5l1kXt+BpUQY=;
        b=fzVe/MIvOn8dgctNVo5pmFSVoN8JTAaJ0WO1g/DQU4QI+/6kmz4oJ46sS2EHTUnDfP
         ghe2cifp62WrIBlWqVKndwYFETtGR0yusJ7J1I7nKzTspfc3t0CvnBqGwdQzF89P5a9P
         RDrzDNfI2Nc8UrcN+67VLp2G695dq/2OlCxO1aVjeoMquOovexI+CsS2rXJTcEgeZT2e
         8l0lnRcP7+VI0z4rT6i7lIhHdG7f4lrl+sWQFl1UE9VarRsnIujuMr4xpEFA+5VYVDQ+
         k/H2tPutE4/A2bfJVZBa08pbQuvBQOeQyK3A7G39MZbc25y2Op/pQp6D+TtyZfpl0LoJ
         hirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531158; x=1789135958;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yNlBRwCMNMD3QTbLrkFdaLqTwN+WPCN5l1kXt+BpUQY=;
        b=XtP0pRfr9H07nP21R6fjoHRCxWe4qKffv3EPTbjkKekl2ulUWRIns5AkM61m9mgz4+
         EBgbRMYXCzuQaOQwwqNXaPxUbyJ5d01QCm938C2QLbxUuiwQrhEAMtF/YWHmSXxtMWPJ
         Ok0LcaHK+ecetyp8hR8CRNbQ/dRmOJkQ5+q6VBBvU/OhAoTANXMj/P2V77chFcbso+xN
         FwXDtzsINdFH8G0LzlN3hMy/k1qxtzXH1gGY8A5dXXXNe4KYg53DCh0e7LKCAD+WcvK/
         5Dy4UBufw0pGRWiTYagQ3o7jMgbVqKckeJgN7ooIObmd6QxyMC7/nU0ekRCyhcTC7zxK
         GqiA==
X-Forwarded-Encrypted: i=1; AKwUvBzkyV+2Ty2WulbI8wavYRmduOs2rXHbHoc6XByog5SwJKv8T0NMSlr4fLSVrIxTHKYHd5CvS+A=@vger.kernel.org
X-Gm-Message-State: AFuF++noFIhrI0OraaH0/v73MYb2jNFMLV9vFC+16PDR/Hmc2CDKml70
	UF58shtgQRbPLuHfZ9YIkJfxuUJ9W68bzPPcxgEJv2xfLNFyE6ReuqCXh9y62kBDT3t5jt3IWdg
	jk5Cs53J6+lA+q45caGo1rODi1YqA4ZY=
X-Gm-Gg: AYBFou1tgRwvgVeipQnw9VTPyz9adVrkAvWKPtLpHIIqfU7H/cKVL4AZjqL/SwzhamT
	kXRZ0UXotgni79AMFNUSozoah7jMIa5c+8wb8Na0LHH2yomhsdQClablQC13dHWUHAbO/qXTGL/
	B6+FJniST29pnfKh0N/86Eop/3cWG5EYrTieEKla4Lcd9y/XZOq9cN0LP92pn6Q9V1L86rIaTZx
	kAjwMxfL2Ku40lTDLsOBfAO6sN34ozyJwBswJE2odFV7KyUEhZsUupHR+NG8SVMraFkoa6YJa/6
	i9yfM5yHKYEnv+qceB7sUSQycgQ38Thqz0z47SNH2CUPO7g=
X-Received: by 2002:a17:906:2099:b0:c26:207d:8a8f with SMTP id
 a640c23a62f3a-c26207d8bbfmr50356566b.27.1788531158400; Fri, 04 Sep 2026
 07:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903092211.2922058-1-o.rempel@pengutronix.de> <20260903092211.2922058-2-o.rempel@pengutronix.de>
In-Reply-To: <20260903092211.2922058-2-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 4 Sep 2026 11:12:24 -0300
X-Gm-Features: AcwNN1WbPDaaw00DsU5oy1rq55aIUcZnNRKdD71hzUNdp_uim09LPhoaHN9ApEE
Message-ID: <CAJq09z6w6DQsh4o+9nXinfi=WAUxW4ShmxJspBkXeakCf283tw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: phy: realtek: use C45 for
 RTL8365MB-VC internal PHY MMD access
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The RTL8365MB-VC PHYs are integrated into the switch and have no MMD
> registers of their own. What phylib accesses as MMD registers (EEE)
> actually lives in the switch's OCP registers; the realtek DSA driver maps
> those MMD requests onto OCP and exposes them over C45.
>
> For a C22 PHY, phy_read_mmd()/phy_write_mmd() would use C22 indirect-MMD,
> which this hardware does not implement. Point .read_mmd/.write_mmd at
> genphy_{read,write}_mmd_c45() so phylib's MMD accesses go over C45 to the
> DSA driver's mapping instead.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Anticipated reviewer questions:
>
> Q: .read_mmd/.write_mmd now use the C45 helpers, but the DSA user MDIO bus
>    only gains .read_c45/.write_c45 in the next patch -- is this bisect-broken?
> A: No. Until then an MMD access returns -EOPNOTSUPP, but the only one that runs
>    is the EEE-ability read in phy_probe(), which phylib ignores; probe, link and
>    traffic are unaffected. ethtool --show-eee reports EEE unsupported here -- the
>    same as before this series, since these ports gain EEE only in the next patch
>    -- so it is not a regression. Verified on an RTL8365MB-VC.

I was going to do exactly that test but you saved me some time. Thanks.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

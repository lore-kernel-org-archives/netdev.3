Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792758969;
	b=SSbK10yGqka5M0VkxzCUkc9a1L5zpF1Ie1m/9gic69V9VJFKDOElY7NwPEoIed4I4u5t
	 Wqd7suYwclj0DUA79dTpflDB4oK+p3ynfqlQo26iBHBs2i2YWqk5+nfLwrOk2P62/go5B
	 Y/EAiRAa9yJUxlpTwb6C22+Ex/3dqz85BhEzdFBoRpuW6+0Jrnq5J+VbSX4Ycsh6Gne2H
	 9wLe+yo4k34Khsa0sX8hM66OX9d1tJDtOWRg8XCZ+kAT4VxMkC6fhVGXJzIwzLT/B9Ool
	 BbAcGrocCkzTgq/FmGmbeRFzAG2JCahh62993v7qK0Dl/9BH97dtOXkzyPJ46PQ9dzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=jCwLz7Yk0IunCGqCLB2zmrV7N72LGMZmnoJIAewTS7s=;
	b=Y9JetQTIZvo6RGPQDoKyQAqx/XxeP2c3ttFN+HivOGHejCa9ppye01nzUDVeCxdnG8+V
	 d+oGBVqM8RXf8Qg1bsLMGifHydKXxWaqQ9vJ1D8FgzM2suZ+7dw/n/U+HDZGKCtBCsheC
	 VBSb+7C/BsVhUYZ8Wie/n2FmDJRoESfRmyK1YdpEE3mVXvBTbm1vBxcMbZ44YdGZ1+O2H
	 C8dimgDgUWyfcpbtg04F9yxEqoraom88oTB91RMaw+SD7Hd2+IS5Kez++eGGAsi2hy66g
	 dsXh5qlSYScUE8C3rIEEvVW89W/4UK05kFC4hsRnxOSLo0SiHYgAbXGs8A9a8skIr9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rxRnDqd8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC72606A32F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC72606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rxRnDqd8
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1483345eec.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792758968; cv=none;
        d=google.com; s=arc-20260327;
        b=WvgdngTm5mnw+0OOmrKqookWC33UZSMBmowUuP6Ck1SXZrGLDC7IpV5XUUpNHoQf3g
         02d0NMO7yYFjciSfF9I1/p5pVoUBj0JQ1oshocDznTJKIxkASAz073IHdjyI0ndaDZHM
         z76NEeBvEW99WCqSsE1tA/7FOHxkm1/A/wCl/cVxLUwZrO/yAqaxceecKIjr+WtH7yWz
         kEqSEZ1ZVlMD1v9xHbjZUTFTy3j1lJo9BLzzw1NKBplVdylpfPo2CAL/mu35vFdHxyVS
         jjVyQl5Uyxcs6a7oGXh5Jca7tnGpnqgq3EKfmHjWfsVSZQ49dOOtaMmTAxqkJ0dLGQdM
         Y9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jCwLz7Yk0IunCGqCLB2zmrV7N72LGMZmnoJIAewTS7s=;
        fh=j50sCChoxrhIqTLzWFDVW8DRO0BMRAA5qhIR7RKc2DM=;
        b=Ri/SVdrsHaodk6DDHTG3PYcAIQwtNcjV8i40lYqFSyfFRreDQIrNPbxo/p35mzh0dJ
         htmAqC2AC5dObq1wcWbgXrB4oZCcxJXIXNmcijKBLrSp2CWTjI5ln3ooHs3RSn+cwkGx
         H0ymkXF6l/mXzyrCXS2SOs/zk2rlA5dHmoNTef2TzLjlZw3op0mb/MZgOQt3m1yflkN5
         PMdSTYyAoH0G9RUDb+qnaDq+JYUlk+Wg5q4slbCCtvJ7wrOTowGxWeDbnKWtG0agvKbW
         t/Jte3EugwxRUCYnbOUuTXatIvqHKXf/uF15xGF9ja1+Oaj0ffp2iHVBo875JWiAIb/X
         QHzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792758968; x=1793363768; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCwLz7Yk0IunCGqCLB2zmrV7N72LGMZmnoJIAewTS7s=;
        b=rxRnDqd8C/nJQVDxN2mKhpw32NCW8yj08XxXHq93H/0wb9JtoXPLAEFd0XYy6irypW
         S5POhuIIrdyTfiviMIm3KTbH6mVmk+0gQISkPj2ytwKfun5qutMEWCXZQ69lJzp7585A
         DmkQg0GAt8JxOadZ3XfRN4MDmUb6/ghkJWmX5ABAtF3Xx+8jLsOq45rqJItEP5dFR4Xz
         hMNxueSCHNqT4TYTQ4yY+WccWBXrA4QeJdVCWovfVtIRoWEtEjlbJ7WwA/jhhQLkyPFF
         TdLomC6z1Xh3Wfihe52eETrhDdn94/WzF6fjCkbcKYa0wyy4J/E9E7MHRrVCqtZWy3FU
         juLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792758968; x=1793363768;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jCwLz7Yk0IunCGqCLB2zmrV7N72LGMZmnoJIAewTS7s=;
        b=Ggv507DntgH3ia9sy704La4alRsZuXdBO96dNU2GXgh2HaYa9iUHqA4KPJNtNqWMO4
         5lMfayh5wV2aWUW0EbbOfsIFs9PWWvdG5O6lUE8wkkIhi1H5QcNu10WsjgaqFtKt5a3m
         dHOzUfSOzo00MD8OWGyCwnX5m2ZKeIJwAW3DfypNQlR/hNLgNmT+z0DPVHtxSNDbB5Xa
         4OtTN5FoKmb63459aC0P4wyhEwD0cZ/ZNngp+cJC1KFW5hLoP/8ckvHAkGEfJfEnQZMu
         Tn9ky34Vf7tpEUe3Oa6DJAN55gtSt7Z7RF7WeR6JOstqqCaYV8dejR8n38TOeCEIsApS
         vPBw==
X-Gm-Message-State: AFq9FYLdagMEHg6cXee+G/eDhJfoDS21919cJ1w6xNyFdpkAEpk8hEeX
	dyB21VvCnQOXibNdGYhm/biwqucfXmxUa++x5u7oyTAgUEtXjsACloB4FgNLcHomJtga4o0RgP4
	KVfVKQjak+Kki4m8mFtoFacAhBxPbBkw=
X-Gm-Gg: AYBFou1ea6bx84rgdaXTUVPdYgXHx8zsLFvVk80CXsURwmxkYJDTTP/9jNc9xo+l/pa
	y2Yyb1H/J9gjnDurdmJfVFAH7S97PJuQZ9wezXIbanq8ZPrAqcjawpcWLpZpLAJfYZ43+IbCbjX
	R+7k1JoynN+DDwoUqEfkStupnduioctJrPsUgZyvZ9UyI5BagAltxX+PhKjxd3GyAqbPwTeyVHe
	6b6v+lwaQMHJPctIVMG8kMP117bS9rk3RK2EGUIwq4/R3n04SAr0bUcn28+NA3Gx5iLNcXhx0We
	pVgup+Kk7Z4q1vQSIuuZ5e/gIIuLBl4Fsj5MofctzLtDsY/u6RrDsJ7AmyaxXXk2LZB2bHay2NL
	AQtlEcFVe4z0Il89RcxBZ9fQVPs3dZgvMnkaL
X-Received: by 2002:a05:7022:4388:b0:185:fd0c:4585 with SMTP id
 a92af1059eb24-195c7b7c1cemr4224639c88.33.1792758968220; Fri, 23 Oct 2026
 05:36:08 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022103821.89552-1-timur.stukan.linux@gmail.com> <atsRW-aYHeB-cEgi@fedora>
In-Reply-To: <atsRW-aYHeB-cEgi@fedora>
From: Timur Stukan <timur.stukan.linux@gmail.com>
Date: Fri, 23 Oct 2026 15:35:57 +0300
X-Gm-Features: AclHuK91YxWcztNtNuUxM5uyMh5PXCAtkXygIGDSBa7Vzza5lJegEMqSt0BPPko
Message-ID: <CAF+_u5Byu9BccKQpZ9VcXAb-fMEhpKAD9A65LktLDJ77ng+KfQ@mail.gmail.com>
Subject: Re: [PATCH net] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 10:48, Hangbin Liu <hangbin.liu@linux.dev> wrote:

> >  static void bond_miimon_commit(struct bonding *bond)
> >  {
> >       struct slave *slave, *primary, *active;
> > @@ -2807,10 +2828,21 @@ static void bond_miimon_commit(struct bonding *bond)
> >                       err = bond_update_speed_duplex(slave);
> >                       netdev_unlock_ops(slave->dev);
> >                       if (err && bond_needs_speed_duplex(bond)) {
> > -                             slave->link = BOND_LINK_DOWN;
>
> Hmm, this issue only happens when link_state is on
>
>         netif_running(slave->dev) && netif_carrier_ok(slave->dev);
>
> while !netif_device_present. Should we set the link up when device detached?


Hi Hangbin,

Thanks for the review and the suggestion.

A detached device is one way to get there, but it does not cover all
the ways to hit this bug. In particular, it does not cover the case i
reproduced: during inspect both link_state and netif_device_present()
are true, but the carrier is lost after inspect and before commit, so
reading speed/duplex fails in commit.


Thanks,
Timur

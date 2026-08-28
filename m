Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC037CD21
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948791; cv=none; b=tmHMmAl5FR3QSvC43Zy3ciMH9y5kjdG59PUhS8cbgqQJbglAEnOR+eucHUjs6xvSiUW7tj4QFmj4jQ24zbvh+5VMUBAAgo29K9yG6G9BeF5HYw7ADK/TvpvXtXqIEX1+uc6YryQ2wbjOy1JHl5EFsh3h431jNfEGKUFJ0IFDZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948791; c=relaxed/simple;
	bh=lFpFtYv6iQcb7S5D9sDFzWR132x+i45bvQJN5YmB7Zg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QBXRRKYv8vsIvf/0IoRUz7tjtiVOht4YCgDAPBg286Ok/tIs9o3k+yGvyD79j4QBqy30Msn0Dr+iEtbJBqrXsVEa6oHv781f7kkPZQN1zpR+T5bnJvqVzWe0V4lq87v6jDc3CKWvwGLL+ja6LuYt3ilCLroWTE4GUkqoT/iNH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHe0a0U7; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHe0a0U7"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66bd7857841so1715476d50.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787948789; x=1788553589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tGVauGPoAYu5wHetzl3LM6n1Jp84rQMdvhVyIaoVuCg=;
        b=bHe0a0U73dR7D66cNuxInO9OFEprZe1WVNp+4DAFZ9NnedJtyWEwJuLcS1ku0nmxBj
         fy6/vZ/U3YSe8+1sNYbnBCH1iaX/xftHMO5lA7VxCFBViX/qdnw+I7DqsV4IMZgMggCw
         BHypkkkzust1/SFpxQ5EKRaNFUHys4hAyYI+pni8StKM+L+SQhTSQhGKEoUvdvDSCihf
         KMKeZc+e/KNuIeZhxvMas31N51ZAZJg//CAy5bK22x/0qDYA9QLuv7rxsO5eAnSPpPCq
         /G9IcSl6VhG57fhxWpuu58AGxfyMutW0mYdcTcUc/LQOy1Y5nLVWWKD41k9GTBvpcwMJ
         569A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787948789; x=1788553589;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tGVauGPoAYu5wHetzl3LM6n1Jp84rQMdvhVyIaoVuCg=;
        b=DWw28QIbgpmNDr+pNu5ecUB+pC6neOJxyEZM5JODbAp3QeQg6SCmC7FXVJlBlovBon
         I/FLdX+DpbHH4nlMc8kyB463H8vOcWkrRW3m9vQijKa5G3CJYZyS82mywhYJWZCcU9Ru
         MV9Bc4JK40JIJHljsTiDo01lvpQQE4RxdFCf0lw5/EIzAegsJGe0ppQf21timYdxkS5Y
         DiG6yzAYJ1zjYHfj+L7dEHpDD7ro4qq5dEbMsGQGXrdoJHGm2jjX2uoriXKS4LReD8Tj
         Q335EJsV0vyEEYdYgdsA3CfsP7UFEggVBFVQbWP0nT/FZHVV0/wuaUIJJNxGJsMzL3x0
         Aiuw==
X-Forwarded-Encrypted: i=1; AKwUvBxOVfgHolHvtNhPaoAde7Wno3IiUkA97L06YpmNoS21KEl17v/rayrydo1I8crgSAQM2fe1B8o=@vger.kernel.org
X-Gm-Message-State: AFuF++nhxol7QwID5OxXFScZIiDQgNnvqFSFwIhiT9wMuk040oZdtPVd
	cmfiI7V8prf7VbSj/kD38pGrpy7m13FUjwR4aROXaKbUI71CMcJ2wDuI
X-Gm-Gg: AYBFou0g2a4OZSNCHi1I2i86Bxi+MgG/2cw8HDWIKzbkkcbJJVQP9ty2D+aZhXX0IMw
	j6yu6FwoO37nQWGSvtIxZ2TDBLfgcZuYRiIop+vlnMC98Vz7EAySLTZwsRa6pVTaifbR263XOU5
	eODAWO3E+O+xBnLRzS3Ss31CPcSV4sPWNAArvnOKPZperOEH0IaB8fCr5BVPKyRafv8tYluX0fp
	JhDK8QW++T6kkEQohqfqq60p5s515gePb48oKs7Ie4uBj4xP2egGU2Rg9yA3+c+bxDT9QNdWG8+
	26OyNldlcglDIO1Em+LI67BSksHzJjdRVuemloZOb69jUL5Bfo32StE+FvUxgckr0Es0FRzYW9O
	PaX8+Z0fhFhIcP44SCFD37xahmLEQOtl7VIKgLoXQLjEQmcV2oTMoDkXyae9A4OgAwxjICognAy
	RZwwJIQJoJc2rnlgAu4LwNeE7rEX1epoKqa+R1N8KOZBrc9BF0Cn605F1IWXIynBkZVtTXIREC4
	a2GOv2ldtATfNvN6eNAbbOktYo3WNH+Go65EaSAN8i5M1+veUIKQw==
X-Received: by 2002:a53:bc8b:0:b0:66d:117c:6cfb with SMTP id 956f58d0204a3-66e4c731f0dmr2380958d50.31.1787948789271;
        Fri, 28 Aug 2026 13:26:29 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb66e45sm1469968d50.9.2026.08.28.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 13:26:28 -0700 (PDT)
Date: Fri, 28 Aug 2026 16:26:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, 
 jv@jvosburgh.net, 
 jiri@resnulli.us, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3553a6121b350@gmail.com>
In-Reply-To: <CAH78GvtPSzvaRtph3d9j5CV+wBZNhLEuUN7bvsQVc6DmcfFY1A@mail.gmail.com>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.2ec10017f4836@gmail.com>
 <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
 <willemdebruijn.kernel.361c9e585560e@gmail.com>
 <apDgeCLGiHTd7fAC@fedora>
 <willemdebruijn.kernel.3786f2ddb8b17@gmail.com>
 <CAH78GvtPSzvaRtph3d9j5CV+wBZNhLEuUN7bvsQVc6DmcfFY1A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> Yeah, agreed on steady state.
> 
> One thing to flag: packet_snd snapshots dev->hard_header_len at
> af_packet.c:3023 (no lock) but pushes the header at :3059 onto whatever
> curr_active_slave is then. A concurrent enslave that bumps it in between
> -- first non-Ethernet slave 14->24, or a bigger-header failover -- can

It does appear that all slaves need to be of the same type, in
bond_enslave:

        if (!bond_has_slaves(bond)) {
                ...
        } else if (bond_dev->type != slave_dev->type) {
                SLAVE_NL_ERR(bond_dev, slave_dev, extack,
                             "Device type is different from other slaves");
        }

> leave the in-flight frame short and trip skb_under_panic (oops/panic,
> not silent corruption; local DoS for a privileged user).

But the same type can still create different hard_header_len, e.g.,
with GRE devices.

I had expected that bond slave changes, such as bond_enslave, would
flush the stack using synchronize_net(). For instance when updating
the valid slaves for non-primary bonds, in bond_set_slave_arr.

But it does appear that a packet may see two different
bond->hard_header_len in a single packet_snd.

> Happy to drop v1, or hand over the create-time check if you want it closed.

Much appreciate your help on this, Qihang.

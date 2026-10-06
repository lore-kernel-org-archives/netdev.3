Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1573E6DE8
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287133; cv=pass; b=O5Bc633I1kiA0XdYeHrHguH6RtqyM6/mppC0x546GMUseZnoEvd34uaBkgpIQPNLOecR4UUOJj1Sc6Ow5dqR6eM9CMtxn1Bz0QooF2hecCUGrhAsp+pEFwC5bAP3B8++HEKrQKD2I0yMEzBKWdeDQ2X3q+4wC6zgrDLx3iM3+Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287133; c=relaxed/simple;
	bh=KWIm9uSpGoSIN+R3P1gUQ+9JvIW++8a5LwJI2335PJg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Wt7AXFuwY47zmUtIOnGQj5pv/zK605l347XqqFjI1u8Ngwtw0tWIecv7dCEvo/o48QGenaFgn4BXXtMaC858ppfhutRoGuxjmn7bUxxKRPEHxmED2eHIum4dVY8+eQapPBB8Xd/ID9jmh3TlL1WoCUapE4XAaBsA6dip+GrUDGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=Q4XpqYNp; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="Q4XpqYNp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso16149205ad.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 04:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791287129; cv=none;
        d=google.com; s=arc-20260327;
        b=ptxqnxLgMQpM8QynTkg7dCzSiQpH5D2ToYcJMvKK7Y+FqrfAdKZ4nNNjzJRAsHqtmT
         vrIqzvZxbuvcBLMDoIXeRRKSD2fIgZeZnv12IDa3rQTMTBZjhH5ur7vzWoj4xrq9vR9A
         BB7zeshhzhTUQGK7MY4PI4Y30HT5HenkZ0Rw8WpDtbVoDhZSGh4J6h94MrB8EISrEZr4
         c31J3my2YG3pGdZLU5lOkihch0aGqt3bvck9rXTdt0iSp9LskxCwevI97VpU/Bdx8iEP
         sD3HiXuMOc9LIMZjwmiX6xfjKKQyqrPTJH0M+XWFwYZC5LdSRi7anh9s7SfyP4koCwzC
         7xuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KWIm9uSpGoSIN+R3P1gUQ+9JvIW++8a5LwJI2335PJg=;
        fh=o35q+2TjwVXYQojqSks8RlSKI1dtZyJHiTn/u4Lanbg=;
        b=DYCtqsaujSYqS9nO2b6fg5VipKH93A8rdZkSwBj/+4y/EYcI4cgvqT0PuSNOPNFqio
         dggC3vtDXIaRucUFq3grPyHRD/O28g8qajXlTglFBjvHTx9xkdAYPLYBsxbglfCHal5r
         zH4EXph5UjaZxex8s73AQe+UNnwn06d+qO7hiP3/oKpqvlbY9mGAa3Q2/qlAJ+FbouDW
         ctuNDqWGn93VI64RglDj5LZ25kHy2OF4nErn0Uj5yIxp6ZvQWcJQm/BaVoVE/FuFt5dx
         vd3ldQ7qI/gAk7/aNheJ6a4ISgnt2xiAJ3cIGBve8sx9ccSZKPp5pguUciZvn22CteuL
         o/iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791287129; x=1791891929; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWIm9uSpGoSIN+R3P1gUQ+9JvIW++8a5LwJI2335PJg=;
        b=Q4XpqYNpqN0g7sPzs2TB5ihBYa3PMGdZKqruDbTg0eNlQcRhX6lltvQpvGVW9W3R6S
         hsELwPHUEObkkFK5MKvou/y30MWtY4Xp0baFtPNc8Bj4WYqh6EgC/h9wkAWeB8V/6JiR
         nlEPwKmgf31OIYWJLcjPg9UDnGrtECy6L5pwBXbt4+LLFCI1AG8Bf49s7AILnxP7YQom
         ax3tbpctIS4Da61kq34gRLmVRtNyjbvY34YgoGg/81BIIGFQYcyMS6+X4X5b1knGNdTS
         a3ODCbnxTEubKeqLAJikJr9gOpCXQRN9ybGE20ueHOZHOcrdVgLvyZijNXL1PbYeRvQn
         6PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287129; x=1791891929;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KWIm9uSpGoSIN+R3P1gUQ+9JvIW++8a5LwJI2335PJg=;
        b=NA15LjInEbpWXLY+97AtdILXG7Bu6AYG7gdBzyPWAlSCli7+mCG3zPZZNeIujSOONU
         deWvCdqFIq3V2/le7534HehWLVQeB6c1mbvQoyXPQs08TgKJnGfzrsbQsvp0qKJCL3iI
         7Mt8N1giSyb9uQpziTQGuPuPc+H8NIMMYiDa72wbxa9ITHxhPgLIJcLyI8q7nn4EuXZk
         mcOHqq5gHpllPoFvIpo1FvhazDC41NVAze/idV68F4hkaoSStowX6gtF3rSU36U11/ad
         wtPTGJVqUjsvVp+ATKZzpWLh09fAx7LXSBiYUbe/gbWoF9qNooyM83rU7Bt6/8uOfm6P
         DCqQ==
X-Gm-Message-State: AFq9FYLCPuz9USwHDUGuzBMLLTVMEep5tbXPMyf/n5V6gYzJX57s1kU/
	7RlfRMRUko2k0QZA+/aNet8+KXENHk2aVf/PUUumsQAc5LQfZDnO2C9W6K3wpyjxqDmSvIT4/TG
	EyS+VQTGg1y+zckuMkJBkNHLLslJhNMEYdamt5xgE6LNrxTze/JwZsfAQXg==
X-Gm-Gg: AYBFou1ibFfr7/TzamMJ8yWJspELwz1EQSDhAjsQvBGmLML5aTutjVJwDJBjnqlr399
	eZ9DsEHOJO99IEp8rh1WKK1q/ydWbgMwyaB5XItsNy59KIblY529FPGQtMVWyZC5Wf9crgFBaPl
	HyE731EaANcnZjn1Wozsbn1KzwBH1RUHNN+RutyQ4sUv1gGfoqAatxnQsMUwQ1DC4yTgl6Vzags
	+Lgf8OabXPiEC7dmmq4z0ipRUIsxZxWhdQPAXvTtbBRxCS7RwmyO/68wnLjOjazIabnlVRJSYS3
	hyDozUBzHP2VzXpakOgVVkVe07Lu5D9ZOZbb37c45trTvG6auXfQLer1Y7kheRXPRTd3zALq5EN
	cC7EPOmDWT91qwvGRGT4zdfsd9P3TfbimVxCYRb6GuAoXMrvL+VAKNraw8G11HdGazpsnFkyFQW
	j1
X-Received: by 2002:a17:902:e945:b0:2dd:c100:4258 with SMTP id
 d9443c01a7336-2e510587a58mr90345025ad.60.1791287129271; Tue, 06 Oct 2026
 04:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Tue, 6 Oct 2026 13:45:03 +0200
X-Gm-Features: AclHuK8SA5n7vXONC0JbjGkzdM0ZYOjGctZLd1mE8yax76JeSneiCv7T5coxQOA
Message-ID: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
Subject: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on VLAN
 frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	nic_swsd@realtek.com, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

the Home Assistant OS recently shipped kernel update from 6.18.39 to
6.18.52 which was followed by a bunch of community reports about fatal
network breakages [1] which had one thing in common - r8169 driver and
configured VLANs. This manifested as network stall early in the setup
of the system with dmesg events like this:

> r8169 0000:03:00.0 enp3s0: NETDEV WATCHDOG: CPU: 7: transmit queue 0 timed out 6125 ms
> r8169 0000:03:00.0 enp3s0: rtl_rxtx_empty_cond == 0 (loop: 42, delay: 100).

As there was no change in the r8169 driver itself, I focused on the
vlan subsystem, where AI pointed me shortly to this suspect commit in
the range: 1517d1996b5236fe69eccd9d253f725e06996eb1 ("vlan: fix
skb_under_panic and races when toggling HW VLAN offload"), added in
6.18.51. I'm not referring to the mainline counterpart below for
regzbot (447cbe95ebb9) as I can't confirm whether it triggers the bug
there as well. FWIW there was another issue [2] with a similar
combination recently in the regressions ML but that one seems
unrelated, as disabling EEE fixed that issue, and it doesn't fix it
here.

I don't have the hardware myself, I asked for testing with this commit
reverted, which confirmed that this change indeed started to cause
trouble. However, it's obvious that the change itself is not bad, as
it fixes another issue and the regression is scoped to very specific
hardware/setup combo.

Besides the revert, following workarounds were reported to fix the
issue as well:
- Disabling TX checksum offload with `ethtool.feature-tx off` in
NetworkManager for the connection (HAOS doesn't have ethtool binary,
hence this option instead of direct ethtool command)
- Enabling REORDER_HDR with `ip link set enp1s0.100 type vlan reorder_hdr on`

Clearly, this needs rather esoteric setup to trigger the bug - I guess
most systems set the REORDER_HDR flag by default, however, due to some
legacy in the DBus interface that HAOS stack uses to configure the
network [3], it was disabled. Anyway, I think that disabling it should
not lead to driver breakage as we're seeing.

So far it appears that this only affects RTL8168h/8111h, XID 541 -
there isn't any report of another chip/XID combination yet.
Unfortunately, as I said above, I don't have the hardware available
for testing but I believe I'll find some community members who'll be
willing to test a proposed fix for the issue if needed.

[1] https://github.com/home-assistant/operating-system/issues/5019
[2] https://lore.kernel.org/regressions/353419280.954808.1790290283530@mail.yahoo.com/
[3] https://github.com/home-assistant/supervisor/issues/7248

#regzbot introduced: 1517d1996b5236fe69eccd9d253f725e06996eb1
#regzbot link: https://github.com/home-assistant/operating-system/issues/5019

Cheers,
Jan

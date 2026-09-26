Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5D53815F3
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790459529; cv=none; b=uaKkoLyUT8EAkMpvF1X5qzmxG2pTAygFTAh6VWBmKS7JBqqNRQmS72fUAWPniXUWV5q0N7VhA+O/xaYj9JJr8t6N1BGQJNUlv1VbRjEAxdGqQi7DAwphH9jabexlWa69ebGUN4JTo5hFBqPx/X3Q2/Q1Zl978h0x+bRzbSBlhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790459529; c=relaxed/simple;
	bh=nozFzjCHoY9nJR0dTI8x7puPhIPAjPpq12LYsWc3nm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dtcw6IWIzCen95gdiNgQC/JcdNyle4X2znVLlojtEo8ZWsVwaVsYw86cxHeDaW+97Cb+k/sOhm4UOo+cHJ/T9iL0CiPaZsjtaawXVcaVnpv2RKUpUwSWKj+eP8sN05jpiGL2o+ZXv5s4vVXADShh5OSwLVDli5nx0m+nsUsSg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2bdXPk+; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2bdXPk+"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2dcdc386ddso10477466b.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790459526; x=1791064326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GTHY8dj9isNKlVEtk2ciNN+C6fWLQRwd0CxCymnmGc=;
        b=h2bdXPk+25Lg/c1XQ2vrZ1RzVvvfKgplaPbXHVXmYId2D4zNJ7UfZbW3lttaCft+As
         E2FqJqX8eEzsfDcEBsgQHcoARGLDRg3HCgEXfxK5YVa09nQiD+mH90ZC83Wfyz0OTpId
         +tJOlvJc1x/Ko9bMCfk94TPnAkiE8+4XFGZCYMG1YlVpguhpVvzR+Ahryn6GxrH+sYkw
         ajsbcTObgpgyOC5FnbqdPp0JqMhd4QEqHIq9cYuE+X1TEeHc9unAMOf6bsTbZZ51ceGp
         sA1MnpEwK1WiZg/MJmvUUHTeaX17CD+5/vAZu1Hmqvb2gp41gyh2bI5rMzbIiUtvWD+u
         aRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790459526; x=1791064326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GTHY8dj9isNKlVEtk2ciNN+C6fWLQRwd0CxCymnmGc=;
        b=w9ZoYWBTIaGiTloGXoCWnGEEFcTOi5UwDKS6B+HP8NSZFtFFzzBMWApkpmFi9/WfL9
         sQ0gQuuE4k17MlGhoPjuvfXu+77whzovZEnb29xCbDYshKX20OYTkTR62kmAS97K08LD
         D1S0hp20odeAT/vBvZpprrXgwgVIJCZLDQq15JT+3dDnTlL65++oys2hVxqJVYsT/DF2
         f6ILwV0QKXacQ8p5e6gD6jrxv3b7cXVJarCCSVjG53NqDI+TBCBUm8BWFdw/1W7YP4zn
         wNm48W1gi0V9QUAJWWeFJAN9UKLiflfQjZbeFQHiLFf09jaEdiNDqxgbsRZRUPIba7rH
         Vjag==
X-Gm-Message-State: AFuF++lOBzFVHL0+lW3Hg5UxaGGifbi5JuE9rkKaruxmzqBLAxZ0FxMj
	NI+LU9AcM0zDUjlRkGPueJ0JNI3eLwSNuvGjzFAYkqJwl00xsZ+IFMFg
X-Gm-Gg: AYBFou3gdPXtYJZS+c0nzpa3v+Gscgbqvzo82phLFx5EgADn1mWzl7cY6BwCRpbZMUc
	PsRnpUJJrSQrQnvs4qY1lhDJbnK7f5MrPwv1tI+1ZiY8hOnGx1S06VnNxjzO3x/vqXrW1mlI810
	OOvpbBuCPtYCKTID35ePACht4hoNKa3cYvSkUJR59coOfp7uFy8HdUyHEcEMQgAtAw+R+uqoGkq
	hqb1aRKxKPXTtxtUkNPX8K8FyvKDGoxmA+Gr2uxB4gwHfGHxNYP6CES7xSra9LG+cZZIw+NtYyM
	KgaUqLzVlKa6EHdSXmp5AUhf4xj8h5y0w84+eiK5xJBizfBk9ZQRKLSZQy6YGpra6vWZltOGVcs
	LKmtzINglUufwJkVWf3J2ymTpLzR1CQczVZFnLCZZypQ4AM3vAVg3t2x9pNjJOWSrPDHUqXYlyb
	bwPLvqBB88LK/6KnrzBbf3N9k48G8eR+0vTaX3B1hhWrkNAdlvX03XsfR+xaufMDoj/4liOjuTb
	yzYNBKzU22xZpZZ7BO4xpk2QZLPgGjjSGlKATAHiFEGgxwEGtnMzYo+0+Z15ZvUiQf4F6Snsb5/
	jtzpHszQvJ/Njmd8I+Mb
X-Received: by 2002:a17:906:c115:b0:c26:22ae:b66b with SMTP id a640c23a62f3a-c2ac2328075mr821985666b.15.1790459525741;
        Sat, 26 Sep 2026 14:52:05 -0700 (PDT)
Received: from localhost.localdomain (83-233-221-53.cust.bredband2.com. [83.233.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7353f0asm274704166b.15.2026.09.26.14.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:52:05 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
Date: Sat, 26 Sep 2026 23:51:52 +0200
Message-ID: <20260926215152.376-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <426f9dcb-7473-48d5-a473-4435cc81312c@lunn.ch>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com> <20260923215858.1653-5-yongzhao.derek@gmail.com> <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch> <20260924234814.1734-1-yongzhao.derek@gmail.com> <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch> <20260925210153.8717-1-yongzhao.derek@gmail.com> <69b36e16-eece-4739-9208-96bd8e60943f@lunn.ch> <20260926082129.1632-1-yongzhao.derek@gmail.com> <426f9dcb-7473-48d5-a473-4435cc81312c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

> The IPQ5018 PHY driver does have cable test support, have you tried it
> out?

Yes. I ran it seven times on the IPQ5018 PHY under OpenWrt 6.18.44
(NSS build). All four pairs reported OK each time. This was a working
link, so the result does not show what the QCA8337 sees during a failed
boot, or confirm or rule out insufficient attenuation.

I also ran an A/B test on the OpenWrt 6.18.52 backport, using identical
kernel and rootfs contents. Before the initial PHY software reset,
both paths read register 0x14 once and unconditionally wrote it once:
either the original value, or the value with SmartSpeed disabled.

Across six alternating warm boots on this board:

- Writing back 0x082c failed all three times. PHY4's CTRL1000 read
  0x0400, register 0x11 read 0x1030, and the CPU link did not come up.
- Writing 0x080c worked all three times. CTRL1000 read 0x0600 and the
  CPU link came up at 1 Gb/s.

The pre-reset value was 0x082c in every run; the two written values
therefore differed only in the SmartSpeed enable bit. Writing the
original value back did not avoid the failure, despite the same MDIO
access sequence. This strengthens the case for disabling SmartSpeed
on this link, but does not establish the electrical cause.

I'm open to selecting the workaround through DT, so that it is enabled
only on boards known to need it. What I can document at this point is
the PHY-to-PHY connection, the reproducible boot failure and the effect
of disabling SmartSpeed. I have not established whether the cause is
the board's electrical design or something else.

Would that be sufficient justification for a DT property, with the
underlying cause left open in the commit message? If so, would you
prefer a generic PHY property to disable downshift, or a
Qualcomm-specific property for this workaround?

Thanks,
Yongzhao Chen

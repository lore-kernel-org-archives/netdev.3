Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C138E8C6
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488663; cv=none; b=dHyC05BBpwXJgAvQL4JbFtyFx13EbXAPZSb1gO5trnfPTQVMskTQUfwI4NgmsX4FkRoXRxvJSienXOyDx1fkPmCxAGdhDhCH86FkbkDt2rPzPPBFHGow6fCajgjVz4621tfPC0zYpraJFb0tsyurHufIKWxdfW5ANNUyCZYCZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488663; c=relaxed/simple;
	bh=XaOpaGXMPr9YkCRAQJOKJig23iwcq1i3BikLgYLofvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hhb8MYtj1aj5IZLzE6pnUAehVqMl+SFiv2vQg/CeGinl7jrvQT6333ahfqZrdFUgWlRrkV8iGIWMn5W0WyEqNDanxwhjaklmrCfNZjf1WjDEQyO9APERN9QElp5FZPLo03/Au7FFGvatvyRjlBvhBp1ejEt8kDHhX8KJTl/woSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=PboOZ/t/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="PboOZ/t/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c197e7e4e94so456674866b.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787488660; x=1788093460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XaOpaGXMPr9YkCRAQJOKJig23iwcq1i3BikLgYLofvk=;
        b=PboOZ/t/pC1cfMAFXkeGwnUP7ZE8oeGDGwN18RTZcobNpGhqqNWg5USVOCxrg10rxZ
         FL4fy2xXg/EEl2uC0BJ+hZiG4BitkrZ/9URCe+AHkalwYjxaXcttE/L6YKgAGtRtvsI0
         nzPQlWEPHAfmzfARwHoYRnqHQbIoE7fKYo+ia+iSPi9DmTg+ar7vd/I50QmBWC/zB6Be
         qepZojn4XG3XIVjHWeacP23Q8Hr+Oj03iyACLLMXGYMdHGTWWx/WZnshk2R5o2mk4fhZ
         kNi6Zy0oMwZbKVSi17WCc2vplCk/Gao0qtAXaj4LnEilJjM4I/YdZia6TiLxYn2+9j4M
         LP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787488660; x=1788093460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XaOpaGXMPr9YkCRAQJOKJig23iwcq1i3BikLgYLofvk=;
        b=eecFIeVxYfqQBMjhsFHo51lqArGdxrH1+NKZIlgrYnGJVmhETWjK2llVD0UyGdzArb
         eaNwD4bmpPoudMJMXaheZ3L9pyJGgOxmjZ5DUbPV8r8eVrk+XY28AaKKpd1SAHkZ0oa5
         Pf5G3GgZbBYOzKNXl/K1+HGX+nf4TkxfWwmxwNX/HVrPTfZPx1gMLbRqpx5lg5Qw4hUn
         ldT9FdHCslCzs8bnw5E/lLiprjyQ+l9dv8v57vA7Cx5TVM5ExffEjEvJhLSfepem9BjJ
         BY50e6wKugiW6tsfUmsLiuBtlOqfZ2ucZ4xZdgca15EyKPb5xv8GMDUyofSGhKpMpwYP
         q20A==
X-Forwarded-Encrypted: i=1; AHgh+Ro2vdIsP+e6fehiMBykFUglhdy5W3P6myN17vb+YTJYSf/rjvGwHuuiT4ba7biuzQEbwbqCoiA=@vger.kernel.org
X-Gm-Message-State: AFuF++mskL2Mmn+5+OFkDmOKWh1KrO9TEdl2DM0IKhSvHxQubQyX2lmu
	bBvreoQVzQ9sv4RjLFSQMovQzX1vNUhfrtMpFBcxLvxHcaNf/CLRkurdIrKggsyxsR8=
X-Gm-Gg: AR+sD11Prl6rfAABXOEQlKFOActO1LkE4Jt4q97+1l97z7eSZvUwrYB9sY+soD/ggop
	yKWhS/VRJACy6BQNuWeaNc5CTmRjccFHW+iMwnqi4f4gv3uvwDNL7pKl3x8FZ1iQjBO6Rt8qvgD
	Y6uy9p8CQX0A5/5COC4yjid/Hu0F6IELtFo1SIfzJS+Z0IYI/A1cD26YzEiwqC1gElKVVoYgw6Q
	/+WYlopamK5G0t2ZDlIW0g8h4NkIERVuVKtq9tAVRT9HE47vQLUTc770+O79R16GwMEaWltUccu
	W3tADv4BHHwlxREtZMam4Kzylhkg1h5s+FnTZa6bi2CIXPWb5l4NJCnWtvbXy7kk4UdjWkrO3rJ
	eirqy/XUzuagRa4W9hJivgPdUDTErplqMrorCVe9SAwHE/znbRFEsV8gtmfK+isoCzUAx+T/D7k
	/esTF1d8DZBHvNwlBkVynmwy1AW+gqcrgfUeEMg9cVKs1sIRht
X-Received: by 2002:a17:906:9f8e:b0:c12:6d25:2c7a with SMTP id a640c23a62f3a-c2492621d0fmr1233591366b.17.1787488659081;
        Sun, 23 Aug 2026 05:37:39 -0700 (PDT)
Received: from ownbook ([109.61.81.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b696sm859023966b.7.2026.08.23.05.37.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 05:37:38 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH net-next 3/3] net: dsa: connect a late-arriving PHY at ifup
Date: Sun, 23 Aug 2026 15:37:29 +0300
Message-ID: <20260823123729.74290-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c712cd5d-d4bd-413f-82a8-6303ff3e6526@lunn.ch>
References: <20260822155259.87146-1-f@lex.la> <20260822155259.87146-4-f@lex.la> <9557daed-f039-434a-ae64-ac849b9860be@lunn.ch> <20260823000549.6095-1-f@lex.la> <c712cd5d-d4bd-413f-82a8-6303ff3e6526@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> How about making the DSA driver depend on the PHY. That would be much
> simpler.

I worked through both halves of that for OpenWrt, where one kernel
image serves every board of a target, so every kilobyte lands on all of
them.

Built-in: the PHY driver itself is cheap, under 8k of text and data on
arm64. The firmware still lives on the rootfs though, and a built-in
driver probes from an initcall, before mount_root(), so blocking in
config_init() until the firmware shows up deadlocks the boot. Putting
the firmware in the kernel image costs 144k on every board of the
target, and almost none of them have this PHY.

Modules: that works, and the kernel gets smaller. OpenWrt already does
it elsewhere, kmod-dsa-mv88e6xxx depends on kmod-phy-marvell. What
stops me is that it moves the switch driver out of the kernel for every
board of the target, and NFS root goes with it. That is a bigger change
than I want to push on my own, and it gives up the case you asked
about.

Do you see a third option, or is the module direction the one you would
take, with NFS root treated as acceptable to lose on boards like these?
MODULE_SOFTDEP looks useful where dracut builds the initramfs, OpenWrt
builds its own, so I am not sure it applies here.

Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B094C77A9
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948848; cv=none; b=jqOcQ5a6rM1DHayQXDnZuR5Hr5gq9D7YXHjAPNMDq5Nj0MA1RgZX2NIWA7SCdcNm9faTpTGKqHs60rpkmSDrQjFLV0uBNP7S/4rxmQwaqZ8pc1B61j+vUIX9CxkJrPpo0U5/aIj1WjyS80TFmmGAnfEvgZELws9OjykxA4dkjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948848; c=relaxed/simple;
	bh=8wkVR54HKtCmvT4epnFFfFoh7l/x4A5Z8r0EQJHwXbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JN3z9bxoalOffBTBNoCGN9Ze0Gm9ers2q6WveRynxHbjEg6yu+V8EATr42fTS62lFwmSx6kqXCgFkPO/RfA008YjR7VIIiZPKyS+ei6vjL06hTqt6apD5GuWtCOrlrDbLVjagk0BZKYM2lV9b6JXwuMBQeEYotC/SS3LZkdwWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0mmCYgB; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0mmCYgB"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso543089f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788948841; x=1789553641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3wFqSlIV4kXpf46Lk+RTfPnzO0CcPwpy1/grqIwRVw=;
        b=e0mmCYgByrZO++YUpPtjPuHNXiRbLqqCuD7lmAJx+/bIix8YVQifSIM+AYJ3LazzO3
         FuBGLWCXjBTPMt/nxM7o/0DxTAZ6HLuZMRzSbxPz5f0384J+kNaDFmZzdi8Q7ZolZCSp
         RnKMVlk2md7ub6P73TMruid7fbe467pow52qMrphIhbATVKv54J/h9GwsVGLdK6BePhG
         C3+VIUaaQXdx9TBu6jySmi5YvUYr+8dnllVo7cLal8/kVKtjvVnX1YQwgnsXJGUv1mgs
         wIh9oUuMyOCmF78vzNqeUY7FTJ661989MYTyqDB/SidRIlmj8i5aVPIRhM9YTrYzDlRT
         MB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948841; x=1789553641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L3wFqSlIV4kXpf46Lk+RTfPnzO0CcPwpy1/grqIwRVw=;
        b=UeDT6rRxs8qdmG+csIh/r1sox8Jh9iqnca4pfKZp9KwMNx1w0eHVYH7VPJoNK3TVs1
         GtSZ2AMKN71M0ObI+IUURP2yDTqBGG+Mf+bzt1f79lWeNtTLrsgVcXo0XJ3xJNmqUZZf
         bbexx+F0KaYmEDRFLt9cdUo0OtpfcAO3z5BktfgOmkBD54M1qX23JdocdO7UkDuY1Jtc
         SJvgwbkXbvZM1HUlPkrXlaRUOeSItdUnLZtSwyXxmBb4BzL3f4H5EelNdo1dthhWXobQ
         +pcb7GkpX7IPbdtgtvNq+jQmmHhWtOmLKtf/rO/BRnjELaKTPkHtHkRHEaaJXSkediP8
         TRCg==
X-Forwarded-Encrypted: i=1; AKwUvBxd3irkMI5er/bD3jVj6smlXNxmiVLR9BlNp15tsBTlTs7c4deljAf6EGnU/OX1I8zEhkQH3wg=@vger.kernel.org
X-Gm-Message-State: AFuF++kgafJO3uPqyhRWvX9FNcSZDjAZ2e2HBQvCQEHR4Ar7H04kpz+b
	feSWwHqB8spix8FKa3ktaw34fItgwlcC6cV0ZO8svg6ngtqpXgAfu3mE
X-Gm-Gg: AYBFou3+gnFjRBwmfLkqkRVzag9pl8oAxFPd4xjBAKkgg2/7nepteofqkpFMx8jdE07
	W3cWeGZzEz6GscvXbgNLrR3LTLzVkhNs0QV9Ye5Ndgx2MKPWlVG5GVuQwiTNrebcBPZKNgdhtTw
	cSs22zIveY2+Thn/wBmt89QN/dpydRKOsJ77GYPbcftuXr9MPwx4nqcK1ghiP36cR5uoCV6b08W
	iHY79Ks0WRnjSDmTJy8gfVcTCg4IrJ3X9UXtnwgFmFoIh8oQox8PTT14Ynqi6c1AVVVdcCJWRac
	hUB6GCks3Sk6Pi5nP7lg15ldZJvZsFJQQop3N+EokxJ+e6xtc0FUyO+IHTbZA6CufWdna842muD
	xGUZw2uclF/8XoICzL9oxnK3kL8xgmxzhggtyeYIzwthI/4C7HXD4g1zXgakkux9dloUa0RkJKz
	5Oxlu0xpLcCUvI6CUCd252bshrjmOyt+E2/ybEEzDPD8TYDUwbujEbciWrrABs0Nze8emJla0Jo
	Umr/fl/YJDKgWNnRBP1
X-Received: by 2002:a05:600c:3b1f:b0:49d:5ff:f408 with SMTP id 5b1f17b1804b1-49d1f37bb1bmr82227985e9.15.1788948840941;
        Wed, 09 Sep 2026 03:14:00 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c51:e108:e113:5dfd:782e:8bfa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0af538d0sm336040765e9.8.2026.09.09.03.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:14:00 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: realtek: rtl8365mb: wait out the full chip reset time
Date: Wed,  9 Sep 2026 12:13:55 +0200
Message-ID: <20260909101355.25660-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJq09z4qBz+poVQR3tEQzB-_4se5ka76Xq1mwEM0RvEnTuGLNw@mail.gmail.com>
References: <CAJq09z4qBz+poVQR3tEQzB-_4se5ka76Xq1mwEM0RvEnTuGLNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

Thanks - all three points are fair, and the first one I owe you a
correction on.


The power supply
----------------

That July message was too broadly worded, and I should have followed up
in that thread rather than leaving it as the last word.

What the A/B/A established still holds, but for a narrower fault than I
claimed. The July signature was link up at 2.5G/Full with 326 FCS errors
and 326 drop events on the switch's CPU-facing port; swapping the supply
made it go away and putting the old one back brought it straight back.
I have no reason to doubt that part.

What I got wrong was declaring the cold-start problem closed. On the new
supply the board later came up broken again, several times, with a
different signature: no FCS errors, no drop events, no CRC or symbol
errors anywhere - the switch simply never forwards what the CPU sends,
and the MIB TX counters on the user ports stay at zero. A power cycle or
a driver re-probe clears it. That is the failure these patches address,
and it happens on a supply that is not faulty.

So: two faults, one supply-related and settled, one not. I conflated
them in July.


Why unbind/rebind always works
------------------------------

I do not have a measurement that settles this, so treat what follows as
a hypothesis.

At rebind the chip has been powered for minutes or hours, so whatever
internal power-on sequence it runs is long finished; the driver's reset
then only restarts the register blocks, and they come back quickly. From
cold, the reset lands while that power-on initialisation is still in
progress, and the two overlap. That would explain why the extra wait
only ever matters on the first probe after power-on, and why every warm
path - rebind, reboot, sysupgrade - is clean regardless.

It also fits your RTL8367R observation: if the reset bit reflects the
register-level reset rather than the completion of the internal boot,
then how much slack there is after the bit clears is a property of the
part, and a driver that keys off the bit alone is relying on that slack
being zero.


The deadline arithmetic
-----------------------

I have no attachment to the implementation, but I would rather not
change it on my own judgement here, because you and Linus have landed on
opposite sides: he reviewed this version specifically liking the
deadline optimisation, and you would rather see the complexity gone.

If you two settle on the simple form I will send a v3 with

	msleep(RTL8365MB_CHIP_RESET_TIME_MS);

up front and a single read of RTL8365MB_CHIP_RESET_HW_MASK afterwards,
returning -ETIMEDOUT if it is still set. Total probe time is the same
either way; what the current version buys is only that a chip whose poll
already took the full second does not wait twice, which on reflection is
not worth the arithmetic if it reads as complexity to the people
maintaining this.


Numbers
-------

One thing I should be straight about: the "one cold boot in seven"
figure was measured with both patches applied together, so it does not
attribute the failures to either one on its own. Johan raised the same
point on the OpenWrt PR. I am running per-arm cold-boot counts now -
neither patch, 714-01 alone, both - on the only board I have that
reproduces this, and I will report the counts when I have enough boots
for them to mean anything. If 714-01 alone turns out to be sufficient,
the second patch should be dropped rather than respun.

Best regards,
Stanislaw

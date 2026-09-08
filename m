Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0986492E25
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908389; cv=none; b=j+rUHNUQRVSyFiNcd+UjOXjzxiBq3tmCTWNiEt+C/z326Xfdp3W36fGfFnGwRqXgwkEOmcGWkCJLQkeWpLWONg2QDyAU8shb3FH6HhxtIaC4FBvIjCSf9Z/sLDMYPlG8bhBdi20GJ4+P2/ocObFqzG4IDnonP48rGsT/NTMub8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908389; c=relaxed/simple;
	bh=t+TOJ9eQ1Quf2t+eJx0wqvdgljwm7WcRyxNM1fEnmK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqeNluqVxkQ1j/wcPqCws8b2PAUGpw3bLvy/c1NcC9kw0I16lyKqVyOmiGP2jldRLyXjkhfi59Iphl/vzmyk05KLJvo5sIfapRFVFIqLg7iKBo4s2ofRx58lfic5dKCSJPmGLroDogDxEpd2OJwibp9pxHhK9wfU94tjM8OM9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzT9SM13; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzT9SM13"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so3993976a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788908387; x=1789513187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+TOJ9eQ1Quf2t+eJx0wqvdgljwm7WcRyxNM1fEnmK8=;
        b=GzT9SM13dskqKNzu7lKjtWeymEnjBxQUNdvin5ehZVNpMbJ7lHEwf0IwiGrSiFPhXg
         pyMPDcaSoyZC6MTDObtZKhmLnGkgccZjRU5OiK5NjRZVs/1XhNrdqlo4Bd8oEQVzwn6P
         mUbb/fbRo4opLWH0HIrCaJj7qnM1w6CThmzYnGoBrDFFTyZJvimtS60N0BorRR0HsmCz
         EPshzVP7MDMOvtc6KD3EyA6XIZWfIvAmIttxVHbZPmfg3B6SBaAgk4z00YpvyHYFLAqi
         rMUx7s/lZp8RbiYWEkVG+Qj5puk8NmhCZAGmHjCrpc8yOIibU4e8GSppBWsFEtL4rjNy
         9WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908387; x=1789513187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+TOJ9eQ1Quf2t+eJx0wqvdgljwm7WcRyxNM1fEnmK8=;
        b=ecSJVoLAIgGV8kI2g/lYmXpc5qJ/ljbpPVFy7Vzi71YzkbHNTE5amEKN7L07aflycP
         KzB0MX3vo2S0vPT/YA09/yULxpeIKniTadnnhpAr9pUbdZjwdSfe7vyL3lZ6TyIiIV7V
         5iRkLhv4ZEjvFsqsOZ1w9DSMxCRACL1bctZX6gduAl9PazFYbDZziVzRRigALz4HpzHp
         x73ljLS2KrAZGXyLu8BRqA5UbuLkgsIcSuFlZXWlMzjlieHoRw2Iv9a2ZafUGOsoGjQl
         k0ydHKTpqpQvwai80XTDEefdydtFQFQkYPbwcBxt2bvImlcOpn/fhLNs3FFZWrZ3yN1z
         ZCIw==
X-Forwarded-Encrypted: i=1; AKwUvByE3T2vlvf2bkEKJLAuvXscgwbeLnR6mCEFaocMueDjZ5wjIldhMnuFrTXYk3nDmUGjAFVRv8o=@vger.kernel.org
X-Gm-Message-State: AFuF++mWOmxC2gBJ5JOCIW9ct+rfhb1RGK8tCXICLdwL/3Uzx4/l47ok
	TbLeptmNpS6BwWEJ/9JYCrN0iz6N5s1VX39xWOMrFxHWKkupLb1rE9Q=
X-Gm-Gg: AYBFou1lZWIwyXNS2me/55cRThq1zCpw9C94pQbfKVXE/B06TxktmWNdqQlEi8NcGun
	oU/JBIDO8N8Lu2J0a1mYZPuRzmvwnBcLri2Gew9615B0GA5AFLK7bNi6wdg2BJcUVGbVBiRU4Pk
	FmtaCIG4LuzWBsTkfZ6ew9kIbK8+bJPxgFf/mhN0dgriDJihNWUy30p5nNVqdu7aYR4iWLvNTd6
	MxEIdPdT97z6cxl2xt0vXF8KJwXDZD5+4/z9FHrJwlnJyBl1cz6cgbNh2TLyO1joAS0vMwp9zhZ
	eUsGgvo8/YS1c7rVO4NncxL5Q3spy19rBXfvhDQ60zKkEla6GVYvl27stJ17RZ8ea/G6DRoA122
	XFhRw1bd13yV5f99FVeOuMMiubP0Y0AvyZ6wuIUtvjziluRUdqCoVoeqs9i8QfmrEd3uzNozH6u
	vG89xeYOtuAyP4wF4X0e4WjfKDV0cg/j8ymC8K3EqyqrSeScYcD0flFeLkKC/mgviz0EyoinlOw
	4XS6SpOYe/xyHo6
X-Received: by 2002:a05:6a20:244a:b0:3cd:9f0b:f788 with SMTP id adf61e73a8af0-3da39d12327mr46169716637.12.1788908386855;
        Tue, 08 Sep 2026 15:59:46 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:f6ea:9d29:b387:9ed5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc464393760sm4897059a12.3.2026.09.08.15.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:59:46 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: andrew@lunn.ch
Cc: hkallweit1@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: dp83867: restore the LED polarity after a soft reset
Date: Wed,  9 Sep 2026 07:59:41 +0900
Message-ID: <20260908225941.105431-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <252b331b-0ae8-4248-bcfb-5c63d8c2b7fa@lunn.ch>
References: <20260908114901.74637-1-donggeunyoo.kernel@gmail.com> <252b331b-0ae8-4248-bcfb-5c63d8c2b7fa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 08, 2026 at 04:14:58PM +0200, Andrew Lunn wrote:
> What about the other bits in LEDCR2? dp83867_led_brightness_set()
> might of been used to turn the LED on/off in order to show the state
> of my caps lock key, etc.

You're right. LEDCR2 is cleared by SW_RESET -- v1 already showed the
polarity there is lost, and the DRV_EN/DRV_VAL on/off bits from
led_brightness_set() live in the same register, so a manually driven LED
loses its state too. Polarity-only was a partial fix.

For v2 I'll shadow what the driver programs into LEDCR2 (value plus a
written-bits mask, updated in the setters) and replay it from
config_init(), which runs right after the soft reset. That restores both
polarity and the software-driven on/off state. The runtime setters run
under phydev->lock but the resume-path phy_init_hw() does not, so v2 will
define how the shadow read is serialized against a concurrent setter
rather than leaving it racy.

The function nibble in LEDCR1 is lost the same way. The DP83867IR/CR
datasheet (Rev J) section 7.5.5.3 says the global software reset resets
all internal circuits including the IEEE-defined and extended registers
to defaults, and LEDCR1 (0x18) is an extended register, so SW_RESET
clears it too. The netdev trigger only re-issues the function on its next
set_baseline_state(), i.e. the next link or activity event, not on the
reset, so an offloaded LED whose link stays down after a resume would sit
at the reset-default function indefinitely -- the same failure this patch
fixes, one register up. So v2 shadows and replays LEDCR1 as well:
config_init() rewrites the last function the driver programmed, which is
the trigger's own last intent, and the trigger's next update writes the
identical value.

I did consider pushing this into phylib so every soft-resetting PHY would
benefit. The core could reapply the DT polarity, and that alone would let
aquantia drop its leds_active_low/high cache (61578f679378). But it can't
restore the software-driven on/off state -- the core has no way to tell a
software-driven LED from one offloaded to a hw trigger without reaching
into the trigger's private state -- so that half stays in the driver
regardless, and splitting the restore across two layers seemed worse than
keeping it in one. So I dropped the core route and kept it all in the
driver. I may well have missed a core mechanism that would change that; if
so, let me know and I'll rework it.

Thanks,
Donggeun

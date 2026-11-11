Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410528;
	b=hRT+FTelIbRE1M0nmqN+BRXhM8Q2/cwe1EvpR14B50J8kKlkXg942w06RJMOB736sKsQ
	 WXoAULtAqMyOETnjZfq8y6rhCCmnju2C76MQSbkw38Noh/O5GlaxIyUrYWzy3qLct6WSi
	 UtTykjWz/ma3zJmb3zP4FizW0lEHWkCo3ujygddjfkE9AeFuT05PhjNKzKNtrMZ9qN9vp
	 I+ri90VOJkZjGMgCMt3NpylH0a4nS0G+JHQc12eW/ZLJaQ4iqcJoiKHqihUMN6sFtAZ1u
	 1fc+xJHSqBQVaa6jOaTLGeR3bgtbGy6DmPLU2NL9/n499pRgrtgPbGJMMVI1ykRAvXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=spmuZfC/dhB9wOC0shsRTlNKhiKFYUA58QCJu4KnRLs=;
	b=gqUC/vUn/mV3tGq+tik0xZU06paRpPTJyLs1YRfy88hsi5zBFRFBcWR0tKxIQxi8ffRk
	 ab4cGYAEwnZCBVvIka1MTvmAd2zTxKmAH+fcRx9dU554ETUHEMOLKoOJ07aWO3vVBLsH9
	 J6/ITdWzK1U727PlEQtoMWSQ8NMTICYuty3xtlbVuYWYYfTLhsqs7haAAM59Itl9R4l+u
	 wswE1Nasngyj4GkT3jhliGDRAgvmjFOKgdcqA1S8q8KuVVbKwlIBPYqqm1og7Fl/K+rdJ
	 wccd0e4rqPaBTY91W9NNIDnWuGId/FdXGkWfosJp0i1dWteAOBb7ANsDaOZB2ouJBbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmnYm6ZF;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED8606A330
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24ED8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmnYm6ZF
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d05d51553so23045155e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 07:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794410526; x=1795015326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=spmuZfC/dhB9wOC0shsRTlNKhiKFYUA58QCJu4KnRLs=;
        b=BmnYm6ZFBBeKmlthKXbmWB2LvyBF/QXG85L/s3IcHytWRRPZNScsc0utVWkTITbAJ2
         om1ZR0lTO6zY02r6TRTDYJiiH8lFegskbVH8roj+aVsvl9VLAqvR6XhBu6EK76+QLrQN
         FjZQt2O2ZojQB3BHGioG7bchG9MnUN5/dC8FXT+7mjyc9rHJWOPjR7rLkm6nSN3B6WnT
         MXt0fNNqN0WkvmPOuq8lqRBaiecWjKQEHmd24p6lb7Gl1UO+LQTWGGuRu5kOCJ/jNqoG
         IWoKO6Xwfhz/l0R1dI2F5lh87r2vCJJhSpSIEs6ixxvfrUEFC3NZ/zGpUrFipbpIGd9a
         absQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410526; x=1795015326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=spmuZfC/dhB9wOC0shsRTlNKhiKFYUA58QCJu4KnRLs=;
        b=LO/m5QSh2F8yM7OF65fPgdfnwaiTgoPDMwq2UsAW7VIfjROn14Z81OoUWjEfqG49r9
         ajwsRUf+HXrUGW9+xF1vYPSxDUYavgDvTd5v457816C2BNkIaks0aUoMccCiiJbB9Dym
         XYISvPu0HW92ZyoR6AoaO9xVhOJHPH+p7I4kMZnhgS17uKGxpgCvXNmzVAtLsbnGLnls
         vErFlbFMZLsxH88Jjn2tBxjHZzULslM9bnMZRCQHfuJb/M0brNygk2rG/Mo7NdROIRDA
         blq9Ex+no+KSBQ3i43/Zlmal9tpu/ExoiFjrdeyh2zrnvqHEoSWUisPNBwyfxS9Yt29k
         nilw==
X-Forwarded-Encrypted: i=1; AL+hErFPFouMhhtVDBhkPC6DClx5dQZvD4AblR2y4UbyO6P8IXqyXXJnd65asZULM+Br3m2fkbTsgd8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Vkftou9WlDOS50TgDFIPs+3i4pE+xMi3FuZEkPScSJV29erFn
	VyQcCci3gOVPPyqLRnZm/BOkP1NNt4qUftILIW5P4cLLTCvVDGqDVE/v
X-Gm-Gg: AYBFou1fm2YsiErPnwfOXUbRhg+3q4dCp5C7iWMlE6MfLWgcGyUBwHPmfU3J6Udy5eS
	psw9SBsXxMBJHpCcnqqWKggJluPTc13HzWWiitC5GJozcv74/I/tfKIlLLRRZfHQeFXeUvNJrIK
	cxWo0rggLsooQfwwukqPLfKWsetZ2Bbw+h+nzTwitUi2LWiE0lgN/BoLnfh2knrjQfaXF/tjYxB
	K+1j93g3Xf9Fg57TZXMQBnct+6zdU/2ypqrN0L2pupnen3LHBMYxilO3FJ/L6XdlVIArv3Nxkxh
	fmzRKudIrpmlzsdbLN9pTjWQGL6sJoppxepfMKSQ1oUyYtfxGTy15wA3G4otrmm8px7kwX7wppG
	DmdAVHGLWewdzMH2rV263R+LeDXRRIAOYhYZzjWMz2JZ4ROtOUoNDIdByKmCfmNEh3S9q8DGu/q
	5gtsu/n10a+jOJb+52oZjXhrmr1zxNMAkdE8LrIf14SAIeg65dvpl/lu67mQbIWTzPvSpRJeZIh
	7yVxmxkZImbtNHFCjt+1Km2Q585Kh6Km/keH2i7Ta5nppW6ZSXnIUvXzjxH75VI0Bjez641xb+C
	eQ2ftoBcTDYGeykA76Na+INVPkCcM2+HukbLFFJqQNdjilzporuYy9fiUtwp7eIvASRk+0F20+E
	qvQGRKzlh4w==
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4ba093a3cf9mr55715145e9.28.1794410526239;
        Wed, 11 Nov 2026 07:22:06 -0800 (PST)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (user-46-112-80-97.play-internet.pl. [46.112.80.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a4238sm12079575f8f.54.2026.11.11.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:22:04 -0800 (PST)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Johan Alvarado <contact@c127.dev>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	alvin.sipraga@analog.com,
	gabonpivovich@gmail.com,
	linusw@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	luizluca@gmail.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gusfmora@gmail.com,
	fabianotassotti@gmail.com
Subject: Re: [PATCH net-next v9 08/11] net: dsa: realtek: rtl8365mb: re-latch the family D SerDes
Date: Wed, 11 Nov 2026 16:21:58 +0100
Message-ID: <20261111152158.467255-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b68807e4-1470-4f4b-8975-e8a70dffd011@c127.dev>
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com> <39e46930-0d24-46d6-8861-5dd309bb7640@yahoo.com> <1e8da5e3-0d1c-4ce6-bb3c-4b9b7a5789a6@c127.dev> <f84cfedb-b551-4316-8d2b-4d6e06fc151b@yahoo.com> <b68807e4-1470-4f4b-8975-e8a70dffd011@c127.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Johan,

On Tue, Nov 10, 2026 at 12:49:04AM -0500, Johan Alvarado wrote:
> Oleg, could you check this on the AX55 before the first ifup of the
> conduit? A single register read tells:
>
>   devmem 0x98218    # UNIPHY MISC2: 0x70 = SGMII, 0x50 = SGMII+

I can't answer for Oleg's unit. Mine is an Archer AX55 v1 with an
RTL8367S, family C like your MR80X v2, so this is a second family C
board, not the family D answer.

That image has no /dev/mem, so I printed MISC2 and MODE_CTRL from
qca-uniphy instead: at probe, around your preconfig, and before and
after every pcs_config(). On every boot, warm and cold, probe reads
MISC2 0x70 and MODE_CTRL 0x421. Without your commit, SGMII+ (0x50,
0x821) shows up at the first pcs_config(), at about 7.4 s, while the
switch configures 2500base-x at about 5.0 s.

One note on the values. In the pcs-qca-uniphy table, MISC2[6:4] = 7
(0x70) is the USXGMII value; SGMII is 0x30 and SGMII+ is 0x50, as
FlyFish-go pointed out on an RC3000 v3 [1]. MODE_CTRL says the same as
your reading, though: 0x421 has SGMII_MODE (bit 10) set and 0x821 has
SGPLUS_MODE (bit 11). So the hand-over is SGMII either way, and 0x70 in
MISC2 is just not what tells it. On his board, MISC2 reads 0x70 after
the boot loader's block reset when U-Boot runs no network command, and
0x30 after a U-Boot ping.

Reboot loop on our OpenWrt tree (6.18, dwmac-ipq5018 + qca-uniphy), with
the OpenWrt ordering patch removed in both images. A boot counts as
broken on ping loss to a host on lan1, or FCS errors or PAUSE frames on
CPU port 6.

- Without your commit: 2 of 15 broken.
  - In one, the switch sent PAUSE frames to the CPU (1368 on port 6) and
    to lan1, and almost nothing got through. No FCS errors.
  - In the other, frames from lan1 reached the CPU, but nothing from the
    CPU went out on lan1, although port 6 ifInOctets kept counting. No
    FCS errors, no PAUSE frames.
  In our tree the conduit is closed and opened again at about 26 s
  (pcs_config() runs again, the UNIPHY already in SGMII+), and that
  didn't cure either boot. This fits your note that a re-sequence on the
  SoC side does not help.

- With your commit: 0 of 23 broken (20 reboots, 3 power cycles). The
  preconfig puts the UNIPHY in SGMII+ at about 2.1 s, 3.2-3.3 s before
  the switch configures its port, and pcs_config() at open finds the
  mode already set.

2 of 15 against 0 of 23 is weak on its own, but it points the same way
as your 18 of 51 against 0 of 32. In the same thread [1], FlyFish-go ran
the RC3000 v3 (RTL8367S, family C) at 2500base-x with only the OpenWrt
ordering patch removed: 4 of 7 cold boots broken, against 0 of 5 with
it. In every broken boot the SoC-to-switch direction was the one that
failed.

I have put the same result on your OpenWrt PR [2].

Tested-by: Stanislaw Pal <kuncy7@gmail.com> # Archer AX55 v1

[1] https://github.com/kuncy7/openwrt-nss-edma/pull/73#issuecomment-6796451511
[2] https://github.com/openwrt/openwrt/pull/26597

Best regards,
Stanislaw

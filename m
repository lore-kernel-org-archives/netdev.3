Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DBE3C1D73
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366157; cv=none; b=EIuo0fwovzho6cmob3OFwdXQLssJRuqzQn41K8hUwHjHqlZ3s8oYHmI5mYsvGnX0d6v9hP3EUPOwTbfe+21LBRqcAWsCe+bZdoYeiyNri0QwFokCeemonx3DSopGUKAD7/c/g4tRhdVVr2J6Bm1lAY9u2rqICeuEbb8NqL4AmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366157; c=relaxed/simple;
	bh=Mb/hA1HXPT4Bnq1UiYb25B7njxnyG9hjVQ+B93Af55c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQrJxe5y4mZpKVNKZhNB7PEHQVXF0L2QBBIFanOjHPQ/uYFXDR8HwknAStAtcpBMgxv6JD9zJmycYfQL6FKzVR1BQBSjD2G2r8ExUwqsu5z7VU6ARtBlbiA0xqQIUpMJyP+2LpLFu6zIJjvZH+n+dAnIeb8MdrxeevkGtM3Ve8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCCjqe0T; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCCjqe0T"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca957432c7fso1736735a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366155; x=1786970955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mb/hA1HXPT4Bnq1UiYb25B7njxnyG9hjVQ+B93Af55c=;
        b=lCCjqe0TKEHA7E7hMXfJqU7f2qT07kKpllHai4k1CxachKsST6OK4QU3hFAK3uSb+4
         Y+q2BiHFaFi7cJAkwZYXt1uRIrNCwZZ1ZjwhzQNxQfCJcy65MPDBzmieaNgbSOlejaKC
         BfEeQhGKDv8GSJqL3WWLnLXGfNVQvLitioMNvobVHRoDJFwsI9uLY7UZ1Z0M7UdVT+6i
         guumJewgr52xZMd96S7N9YnJkeBZgDqk6Vj6Kf13dnU2p/qFIl5+4ZtUq57rqyjtFoiR
         s8mnjLeZccJmdeqVZz8xsCJUs8oAsE3SgQ2hqDlNrrWG+ZhQ9V7uUlkuXInD60wujMiD
         Nk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366155; x=1786970955;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mb/hA1HXPT4Bnq1UiYb25B7njxnyG9hjVQ+B93Af55c=;
        b=fp/mjMm13hhBpCkQ0tlWme+eVYqhKbX36Ic5vyoBk0MNmZL6kLwyScviLKW8hzcAdP
         8oeL/hLvYzDY63SZL6h61VTt9Tgua7JzIvnWbKK6kmOpJH6CeD4i0OiVBmPmVXubaJvg
         q2HwCeisCjTX8sRzXvFgZjl02hoidRuWSh3FxMC8/03aTRaNfHQatRRLze+hiPwAbsrw
         RYQ1o1b2YSmwGZ+n6Ve3ahf4YSqGw0CMnw43hAArduDwBmx4zwGYDHFebQUMbsPrLdAz
         j8+ZMkCSLlAKm78X7MECeOmjQPyiBbQnePltWN6qPwAhm/r44dVx1nXHVhlVHpHhy13T
         FTRQ==
X-Gm-Message-State: AOJu0YymL4zxE0S0HaNguCTXNbgydZU6PYjIWo+GSBdce9PN2FuG9+Gp
	hUFBWYP/gWdauwpDPDO6YVxALKy8LeVI38SFh2LkiJ4Dw53P3A2oTEGS3nmc5H8E
X-Gm-Gg: AR+sD10/NIDgk1pvI6JAnSw3p4hGKAGhURLDdYGN8RFXw9/qBCv1QX/Jm7i43+hk9yG
	rxylbAaBVC2cOwcWwp4Q4YuIFb6JzjEtHoy4B75oVgoaNuGLyRP5jri4prYKqGdIwVRfNAucF0l
	fbSZvNTycrIwbBLeMMfJfuN0YRUH38DzyDqh+EEElwQhyKmD1yb3fPIR9+g/Q3r+BMt/nmxrMel
	9hVSZfALcj5XpHTdwO6oVYq07g+gPLIHdSdm+YuKL2UwVOD9WhwKCXtB5HmuKz03s4X+CsRKWqM
	G2DTQ3bf5BM/r09aO+XUtK3fbvc1UO7S2KxqonuqsozyKtpyuBu37XAMYPQRvM+6kaknVP3r9uy
	uPriQEGvThofex7PVLa1catfReMmqmsxSHrR6PORkwFI/kDgo7VYpGN5muV/nVj21F2efgOctFm
	csZZUYnuLB3AHtEJW831HWXpTXYRj3XXbxSjNzBSlvO0xWNZCPRRbzCHPjYr8yNFzlcvdI/h+tf
	p4hn4TVpAsRpBN8rOqXByuVE5fBIw/aWav6D+1bcqN8gE08sLdh3H47
X-Received: by 2002:a05:6300:141:b0:3c3:a08d:5b44 with SMTP id adf61e73a8af0-3cc1a35b155mr2142812637.23.1786366155463;
        Mon, 10 Aug 2026 05:49:15 -0700 (PDT)
Received: from ubuntu-openwrt.tail1b3f25.ts.net ([219.91.181.237])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde353sm47455493eec.23.2026.08.10.05.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 05:49:15 -0700 (PDT)
From: Sandeep Sondagar <sandeepsondagar@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sandeep Sondagar <sandeepsondagar@gmail.com>,
	nb@tipi-net.de,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	j4g8y7@gmail.com,
	robert.marko@sartura.hr
Subject: Re: [PATCH net v3] net: phylink: treat PSGMII as an inband capable interface
Date: Mon, 10 Aug 2026 18:19:08 +0530
Message-ID: <20260810124908.145701-1-sandeepsondagar@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
References: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Nicolai,

Thanks for your email.

This was noticed while working on the OpenWrt support for the Jio
AirFiber router (JIDU6J11) based on the IPQ9554 SoC, which exposes
5x gigabit ports (1 WAN + 4 LAN) through a Qualcomm PSGMII interface.

While testing I found that the QSGMII mode works correctly, but the
PSGMII mode has both a hotplug issue and an incorrect link detection
issue: a 100Mbps copper link is reported as 1Gbps, so the link can't
pass traffic at the negotiated speed. While tracing it, I found
PHY_INTERFACE_MODE_PSGMII was missing from the phylink in-band
handling, so the PCS was being programmed in force mode with its
default 1000base control-register speed bits instead of using the
in-band SGMII word.

Best regards,
Sandeep

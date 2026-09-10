Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96BF4BB5CC
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054702; cv=none; b=F+NzQgYa0J4i0Tg2FS2dtEfBpDpmjjpUflxFAUS0PvEmdz5EuQpVCSD23TOTOM5YjPfpR7OT6yFnM59MxqFrcjMnuQughVNaRWV3YVpZ+rTUSmbAzRp4mYKUqDA/Pc4GYv7v/6YE0hDPM43WM1RRKied1A4GpyxyghpTVKkOLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054702; c=relaxed/simple;
	bh=ZxqeS1E771yr0ofEeWkRJncYn+0HDmT7Y6kC3tSRRLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWDP1yqoKRAUW5ubVOLHfVY2TkKDUfCkNDWsqpLFbk1U9hX4T/NVvtr4yAiMncPYuXNWF3SyRm0g8vTd8uPkAnd9kqdCNUvkGIem/CTDQBAdvwHtczTunXw0r3y8N9qDxepmG6ZzztZM6auv8dO0b3l4lVTzT/wmewOTT7L5Ypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=N4HrI+01; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="N4HrI+01"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4956869750eso65369545e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789054698; x=1789659498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZxqeS1E771yr0ofEeWkRJncYn+0HDmT7Y6kC3tSRRLQ=;
        b=N4HrI+01u32kOe55aBgx/5Fqt1Rgje787WB9kHAqk9J7O1wH86VXlH66I9ZjEsKDI0
         xhaSfwqZPfRFjAE1zozPoF1RO7P/w39HBXbAichZO+q7bASHiuVVx+GpQk4cYnZLCdFb
         i1HwMh8+WOzNAl71LbCMPOxqj9WBOHPX+BD9zZEI3OYDYItiHmHAROZqmCPSUfDNHZ40
         ORlNXspml1CdDQezdx4HXnk6IZYBACvOMAeVX1bxdWDM+F9+FjF9aiAPhoI1lUtd86jL
         WlzJgIWqGLSXK4OzFY0FC+NVZtOa7TaykJNmcVNIQtsNufFie2wVUFizMHGocsY1okp0
         pLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054698; x=1789659498;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxqeS1E771yr0ofEeWkRJncYn+0HDmT7Y6kC3tSRRLQ=;
        b=Eveppj7FuhYGCufxfvo7mxPwntivxSaLbISlebNzf5VBRcaUe0tnni175iE60Jungs
         7b89wCJl/sRZrumX2hANwEMTe3ABmtAevLYHld2+UITMvVXmOipivlFjPcZQ+BJsgNJt
         u47/dYJOYFSUPjIqL0FEvPihRQ2UP1DoXP/zHa/EWpc1B8oQBx+FfB678e59WBnlSFAb
         asd4fEeAl4eqqboM1E7YKYesXpdFHg4nCQHXkGCZ2WjIpVBcAYrfsyzeZqp/Cf0GFmM4
         hwpHow5YxteSmgBooRhn3T3L8MTlelK4XeKVcPJih6pSIHbn1/9S7Q1p8vG0I72jYKbE
         zPnA==
X-Forwarded-Encrypted: i=1; AKwUvBwgC+VEvRjVdeDnL7d9ElsCEzFuMMD9C2Xy14fZRVMPpBSvb36FjBIkkhkNv0AM/XjOWXMG5ms=@vger.kernel.org
X-Gm-Message-State: AFuF++l5O0xK+/zHSi+canWE4TxWORe20+H7gQVxOgnf+ngW/2ajuwXf
	Rft5+/MffKBPb9AQm78I3IBKt54+Hbb5cFyoSJl8e2hhX6IRbQtw89qV5zqHf9Vp+nM=
X-Gm-Gg: AYBFou0bO5pW7GatGshEYOzoq8f1Zzr44GX9OFuz/eeWmtBX+H1Pcq9QSTaPtXX67QC
	//oemvymCPqUPIpiQk0gEGMRxu7zylXJWBBRKblFK8KsmcWClMk7gvTFx026qEff1q01LzME5uI
	PzHJmhJIhLraT6eeUSW7kqOTPtBurivPnxEq9VWJl0S2SeLmno0TLQvEKDKl0dSK9hdSDUGbv+J
	30AHT1akeqQIB04PLxdRChGbuC9gaMS1C0LAE/yFvCDR1FZ2lLifW7cJJAUt16Vb8Q76tQQ/9Ya
	kL8ishd7HT7piHlGPgmak3qO2QYinHkYZ1RJWWtgrv2ntW3HIHudDdV5c5+eGfo5mgGJ72w70gt
	NMc3mabZko0pRR1sWcLeGcJ58vbM6OH+mWHrkiTOigq4Mk/1THAU1/ZuMuKZSrPsj7vHRY9XFdv
	1w9wNvQI/TQWIJmgEJ1oSrcY96009Vw+GAXGecIPakjFoJAzBJcISN54fgvVLzjw==
X-Received: by 2002:a05:600c:3115:b0:49c:e1b5:b2bf with SMTP id 5b1f17b1804b1-49cf7f48645mr421170135e9.0.1789054693628;
        Thu, 10 Sep 2026 08:38:13 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5dcb40b3sm16903555e9.4.2026.09.10.08.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:38:13 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Conor Dooley <conor@kernel.org>
Cc: Aleksei Sviridkin <f@lex.la>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add phy-needs-host-firmware
Date: Thu, 10 Sep 2026 15:38:11 +0000
Message-ID: <20260910153811.778387-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907-shallow-universal-b614da6fe0c4@spud>
References: <cover.1788711837.git.f@lex.la> <20260906174621.4107320-1-f@lex.la> <20260907-shallow-universal-b614da6fe0c4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 06:26:31PM +0100, Conor Dooley wrote:
> That doesn't seem right, sounds like it should be on the phy if the
> behaviour is caused by the phy.
> In fact, it seems like something that should be determined when the
> phy is identified, not really sure why it needs a property at all? Or
> based on the fact that the phy has firmware-name.

firmware-name it is. marvell,aquantia and aeonsemi,as21xxx already
describe a firmware loading PHY that way, and as21xxx requires the
property for the compatible the chip answers before its firmware runs.
The node on my board already carries that pre-firmware compatible,
ethernet-phy-id03a2.a411. So the new property goes away and the wait
keys off firmware-name.

Measured on the board today, same kernel, one line of device tree apart.
With firmware-name on the PHY node the port survives setup and the PHY
attaches at 7.1s with the interrupt from its node, link up. Without it
the connect fails at 1.83s, validation -EINVAL, "error -22 setting up
PHY", and the interface never appears; the firmware still lands at 6.37s
with nobody waiting for it.

Identification is not what is missing. The chip answers 03a2.a411 before
any firmware runs and the generic driver binds to it. What the kernel
cannot see is that a driver for that ID sits in a module the rootfs has
not offered yet. In the other topology, where an MCU driver registers
the PHY's bus, there is no device to identify when the controller
probes.

One thing I do not know how you want it: this chip takes two blobs, DM
and DSP, and the bindings that use firmware-name allow one name. Name
the first and leave the second in the driver, or allow two entries?

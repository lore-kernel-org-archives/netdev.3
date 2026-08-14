Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D1442FAA
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706433; cv=pass; b=GURts5e8ZyR+vhaLS3nvpvxqdAe77RbfMbS/icErEgqs19ROzSf0k/QraxH15RqASGsDhIYTPMmvW85ZZ83sskRk6sWj8mCbszY61ipMUi/zdKYB3RAqHjLuP6g7kUSrtQtDP+8tyiR60YRAkm6bFHiREDF5KpOjyfAqbTa/tAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706433; c=relaxed/simple;
	bh=Fys8FAUK1SSUnHhjnFx1KnLM50PXjqJhH9rzB53Tx50=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oyUjrkFq3XTjNh5Gjtt3isuCz0vWKi7hZ5/NVv+QVtObcFsUBOaH9PHZ1LrrkLbPP/lNYhtk3zNN1n0WgKX2x5HIxAwjofMc4nJXFZ0rmSPeQY1jX/80Q92GY4zO+h87ZICTMw0HWJFCZ7weoonecYwcfcyLEfzmQKGv1p0Rorg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9jF8g8h; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9jF8g8h"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a378f90555so1363599a12.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786706427; cv=none;
        d=google.com; s=arc-20260327;
        b=m2X1wJB/v4GF/peHtCExWZl+ugtbDX7E2jyTC77++wHmp+C2Kwn15/NRQJX4TDIwvM
         PdTzxXVHV8abkJ4ANYGGviAeEW/KjY4FH9sxXUAVq5GY4HyZg4ibzWsbV0MV/ovPUqdu
         L9SG6hCK4yPV3ebZX3KGpwYLwzmobdM/7u2IREVbA3b3LoKLlcPsa0YFSPiaMd/VfJQV
         Wr19ZGxvIlBdq3k2H+kk8Yf+ZtlmJbJRQA6joroViXVNW38LTziZYpYujK/dPws2eH3Z
         4f6Zm397Pxs4ue7Ql5fExbVSY7jZBu+4g1wdhXk4Ludu3U5ck0EEer6Nof52oSA0RygI
         jQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Fys8FAUK1SSUnHhjnFx1KnLM50PXjqJhH9rzB53Tx50=;
        fh=JlrZvb3ajpbRJT2zcJXVhHqRs34cek7dxDppXAuyI1c=;
        b=LijxCT5BkNiWFjqy7PYBv/7VqcaLS0kSxIQvR+Fi5KtsKrXpTt5xEMjdiTHEG5P8cQ
         +Qq/kgvpZA2PUknoj5HPVPOLOIKdxZZ0dDJwS2/Ql/p5GI0d6L9ZcSIxwf3iei0xeIs0
         jPXhHTRbxUm31jaWpaQAZLy+oUdlIGvM1Zf9nu2p55wGHyUjNfORlz1HKXvH5iowG3YU
         OrG8n+YaMRZWcDOnj2c2EMFGA9Xr5dU0CHgTN5QTbU1XrT3Nn/bzVqlHBO+z2ve4JSPc
         zzgLA5Nz9YZ/m0ayIhrg/FbuM1hrDxFmIOk8GIqd52OiU0c52r2Rxv2SoqzWasZSR08b
         OT0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786706427; x=1787311227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fys8FAUK1SSUnHhjnFx1KnLM50PXjqJhH9rzB53Tx50=;
        b=K9jF8g8hopD+OdKAifvO9md6juA0DXsRFRiMgynC3DHSu81qT3aCi/1LpJbKYKN9HJ
         irx9c/D53vWBEwoo73IIHmaihAZDErERIdJKuWD60bC54N09jSrj+SRHB3NkbPChrBwc
         v+yyoE65UPQsVnk3pfZ9Sz/nHFytQImkCEJIkWYB6FBHzMgErgYcpZA6MWX5zL5JXumE
         U2SeYc3o35XSYNMzeVadfQsAmDdrs8Yusk7soYFqvthdE9x7+mNopfbjCSND59eSdEmJ
         PySSL4Xrd9/gac3CUMFjhrX8j9ia6TLR6PQhcGvLR/zt0NTuWAANwD0kk54DfOBwa8Ve
         xZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786706427; x=1787311227;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fys8FAUK1SSUnHhjnFx1KnLM50PXjqJhH9rzB53Tx50=;
        b=svgwCRwOfPIu8QLEPNFz3WhGSJ4sNnq2k1VxegU7RJRBnhtNlkzJPk3diF6SyVABFE
         f/WAsBLU+Ns3uZ7kDz29+GZ8w4V3XgxazYGE1kuS6c/QC9IPD/mm/iBiJvYU1eEh5/Af
         EMcLddT6L9xxJcU3G0yxlACxESVrCs0/iBbILiYBqoB+o8oBLqzWc/3TL+W9ZeyVB+em
         VrqO1Z8llzbRWaLZjIZOCg66KeCXrKUhGTXHm6LDPlRQrIGqzLbyTAjDr436f4lzHOb5
         Tk/xDiexaOJdzP12qSjmdpf/acwRbT//g7ckid933I4FDKpoxLZpbrzzztvszbSF8Dfi
         bJfA==
X-Gm-Message-State: AOJu0YyFy3c2YLxzsINa1PJzZ7ri6/Bp8DA/cq0WP8dZU0cLFE7J0FQE
	wfeIksspMhlJ6g/4RtvDviLQebxcstVxbbEmIq2Gpj/bQ03h7UJEPmf+pb9fRkvVrFXFE0tZDsv
	8jEmd5NcylhWDLPXN1WsRHMmh/aazT9KjTzHa4DAq1Co8SYE=
X-Gm-Gg: AR+sD13RnSh5lhGamgaFFKCsZZ9JpkUxsvRJtKdaMdtxEkUwsn1fg49sid5mOLikQHv
	/bi+1Yaq+F8mvhfMOUFPEII0Stqt6hnZiUD9Bjet91iRHXlgapTliI8XaCIzHt/nn/EBHWzjXWF
	musCaWzhJCAxNAm151oOvzWTV+gOeXNYbzIQjaGf5pG6zfzAXLOuVbl6bQqJHoLxAJmjT4SCQgi
	rNWPdqfJM28E0xI1zwSLwcpO9UbOWNdoVs0oJbDoItSC6KthMdUc5OKS/NwLnek2F6sWF1tzJKn
	cHW0vrD0JxxEQn/O1NYXnyB3UYgj9CRCPieLgL1+D0TREg==
X-Received: by 2002:a17:907:7b93:b0:c20:ff26:336e with SMTP id
 a640c23a62f3a-c212a25389bmr234390566b.14.1786706427518; Fri, 14 Aug 2026
 04:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JzQsNC60YHQuNC8?= <rizlirizlirizli@gmail.com>
Date: Fri, 14 Aug 2026 14:20:15 +0300
X-Gm-Features: AUfX_mze5oXNGauV_gkderDPFCVVjs65HBfmN49f5Oo-dNvgzxLZ933ubg_UXx4
Message-ID: <CA+0KmMv-3cakYA+SvZkt1pfh3=pycR7UTLB8_iJdDNvixT6yww@mail.gmail.com>
Subject: r8152 SFP support
To: netdev@vger.kernel.org, nic_swsd@realtek.com, hayeswang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
I'm using a USB Type-C to SFP adapter based on the RTL8153 chip
(driver: r8152) on Linux. The adapter has an SFP cage and I'm trying
to read the module's DDM/DOM diagnostics (TX/RX optical power, bias
current, temperature, voltage) via the standard ethtool interface.
Device info:
lsusb: Bus 003 Device 005: ID 0bda:8153 Realtek Semiconductor Corp.
RTL8153 Gigabit Ethernet Adapter
Interface name: enp0s20f0u3
Driver version: r8152 v1.12.13 (vermagic: 6.12.101+deb13-amd64 SMP
preempt mod_unload modversions)
What I observe:
ethtool -m enp0s20f0u3
Netlink error: Operation not supported
Checking dmesg immediately after the call shows no driver activity at
all related to this request =E2=80=94 the call appears to be rejected befor=
e
any USB transaction is attempted, which suggests get_module_eeprom,
get_module_info is simply not implemented in struct ethtool_ops for
this driver.
I noticed that get_module support was recently added for RTL8127 (a
different chip, r8169 driver) =E2=80=94 the patch "r8169: implement get_mod=
ule
functions for rtl8127atf" (Fabio Baltieri, April 2026). I'm writing to
ask:
Is there any plan to implement get_module_eeprom, get_module_info (or
the newer get_module_eeprom_by_page) for RTL8153 in the r8152 driver?
Does the RTL8153 hardware even expose the SFP cage's I2C/TWSI lines to
the host in a way that would make this feasible, or are they only used
internally by the chip (e.g., shared with the chip's own EEPROM
interface)?
Is there any existing internal Realtek tool (even
unofficial/Windows-only) used for production testing of RTL8153-based
SFP adapters that reads DDM data, which could inform an
implementation?
Happy to test any patch or provide further debugging information (USB
captures, register dumps, etc.) if that would help.
Thank you for your time.

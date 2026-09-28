Received: from mail-ej2-f26.google.com (mail-ej2-f26.google.com [74.125.228.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E64BD35B
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601692; cv=pass; b=sLGvFxN15zXLfOPluV0Tr1SSyWGc04Y5qde8zTyWgjh/BO4ThBo+9pmo1YgROkGuk5FVATeZ2EfFnHupGkGO8VkYyHWxRZpKk5fo368cMnmVT2bXl0m3tAQoA+PE4VBEqM9Tpwq9AHacI0DfV68ry6p9A3j9Nn7sN11ChR0X58o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601692; c=relaxed/simple;
	bh=0RvoQj5vNOfyxA8kxUC6Dv9RTQAzgxllJsJz1LHNKQc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i7xM7V1EG6dhczcGy/ZNtDe7jHUTJl1HGqADD+BbNyyFhVKbyZWqmyKsO3hil+/LJk3BZT9lOszrClj1yz6lgK7oWXFnKsDeY5oc50Z+dO7Vv+vgjyIH4VSqrsmwqPifjJFMwPmt0W0DI4LzHjZEQkMT/GXvVeJLeTS4WnYIhcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jitAvbaM; arc=pass smtp.client-ip=74.125.228.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jitAvbaM"
Received: by mail-ej2-f26.google.com with SMTP id a640c23a62f3a-c2940ef15d3so367148466b.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790601690; cv=none;
        d=google.com; s=arc-20260327;
        b=iOCPssGIksOKMDdjo7KHev2JURQLLNX6GapA5haiVJ39tm27ZTmFb4wX9bkpLvl8nH
         zlabX8LetRQ8JuB/Mo+LCNqKsgIEKjNAVD53dlwpem2U/8CsGPm2XMdaX1nKVwMsRjsj
         1bjUW6tWoXFkPbCMcMGegNPxhCEpKUsEML2fLmWAo6j1NGvzSWDrVJnzjAD3FusRGp7d
         GEHKAyUhvkx7Q1j60Tk4ja8NdG1t/2yexwtAivgkc6Iqn9g2vd8gD7LS+FbTafl9tQLf
         j2XZTrLwcIaPXcaLeNN/vfLO12FkZcRNP/wVs+N5z6txHmdBpqxp+rzxDembFDPQzaH4
         S+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lKpVI/GIjH6yd0YCpBwARd6V1SVjcmFw9CjyMnWolos=;
        fh=xqtfYMNQ/e2FlQO4JnRCvuZ8b7U9NsRt3o/SZYlroS8=;
        b=G3HyiTez7zh6fYrEXI6hk1wg/JsMB9LMQ4/Q8zYWxEPQQQ05p0R9laACB70T+Gruii
         fZ/g6oAmu2IkC6YvhtqwZm8sHIE93WIgadgE3o6+A95iu4ZCZlu5cX7nU0bA/7TolExn
         W4NL/8Z/m4O3nXVrxHIMe+TbaYXc62wwaDc5tGO6lxaKuZLN8Ob02J5oYIZz9LGxD00s
         gavKOuN2niWfy2DEZaZC3L7WJ6BRmh7L6qjV8gI9JIPHxeS0YZewZl4J/AfRCgs8XHjO
         g2ggImYvDIs4jfkIjBqZ4NI/IOofnMja2foniVNjNEp4vcewiYNYS29AK8cVbOBuZ/3o
         aSZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790601690; x=1791206490; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lKpVI/GIjH6yd0YCpBwARd6V1SVjcmFw9CjyMnWolos=;
        b=jitAvbaMDVXAfyzg+wlNY9ajPHS2TPH3SE0TIZHl1f6Gdc6Bot3wUr2NKyjW1mU/TK
         k4jomaRCJ0XZGARZ7Utmt7WPGo9PJP1iHe3LjFmkzsPO3dwXrUpb5YUHrfOBtcqUuoE8
         oEopiEIcD8aQa4X4b8/s9kGUL6w1LUuKQqeHe0WIFRQUHbR2K9ZN40dUWdW6gJ9D2bTq
         PMfm2UiDchTqxC4KKDNnJAZ1xA7r5Z7Y7zysSmBalsU229mzlnzgaWyfEdR4TFyMh4zq
         yNjfyQMr8Ohv0bXwc3HW4biS5Zpz8HCCebaAOdaorwa0mV2HIZLAsgyFqSxLuYlwPbtd
         8M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601690; x=1791206490;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lKpVI/GIjH6yd0YCpBwARd6V1SVjcmFw9CjyMnWolos=;
        b=hVcSPSxsjtdeD8RubGbOkihkcFjWLnp6gehLmFo7Wz0mU3KtBLZFebiD26564ldfIT
         EHeaSGeqGfUK7bHd919wrqc6ka5gm3d2Dn8mLwQKD9JeerBfHkkH/VNxp6p6htNLx8Z7
         7matBNYzlV8y5nYK38Y5/cxzxtIsdrDeytTBI6+5zTg2IEFSOFz/woHBC5RRAVvRjRw9
         XCmO7/50Gjd1EEdsrBMLCH+2XFyvPVTz+FjR99vGtQloMEW0ViDbpxoPkQK2uRMlJUgW
         8vrg640WomBLeisO9Aph3en+8fdmmE0eIjZcqGjNuQa4/uqQ84V3tbmS4bSat4H8TRV/
         +ijQ==
X-Gm-Message-State: AFuF++kJRNMANzHjsg9SpEavxASRSG67pRTGaDoAxR9/UeoZWZuLD6NQ
	w6D1tIDu5X1GpbIyHdHjPhTcAjuGkqamgFbGI11I5NVeQ0LYZoWEFmqZB5i2slvB3W5Db+eQ6NC
	GZSrspdglIaxR0rPLyD+acPTogJ7ewvY=
X-Gm-Gg: AYBFou11cpm7aYezsUxwRDkFmR63UTzg+wBHhuupV06w7/f6s6PjXf35h8seOS2v8zG
	slEbJeq9e6+FiMItw2Kjoy7LgnXNoitGWP49qNHfoHZ8jqgIKEHCZyk4SNRgHa2OsbCBMQNIL6l
	hHcjiuGfZLz73TllbzuT4Aa/gQzr/YcFCC1ElU9wYpMyxx1hMTp5tASa+F9WgbHuMbsdNXobFJh
	7jjb4H3k9Q/+YfZlCc/m2OA8tx4KrFlrDIj1+CSZO0f/4W4uzZd+AXOcvwjd1Q8+zl1Ps3wytUB
	1xBVoaeSTomNatnCTsd5gbtleo1fZk9DD44vuWpp1f0=
X-Received: by 2002:a17:906:c115:b0:c26:22ae:b66b with SMTP id
 a640c23a62f3a-c2ac2328075mr1105392266b.15.1790601689462; Mon, 28 Sep 2026
 06:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: V3C14-Embed dead <v3c14.asus@gmail.com>
Date: Mon, 28 Sep 2026 15:21:17 +0200
X-Gm-Features: AclHuK-PFJLnRG6bEMoU119kuWxbU_2B_Xy8XXlB17RbyGVjmrLfBG_DLK808G0
Message-ID: <CANXPfioBNN5mrijuy=sS3NJg8aWBKARi59uH2ZQrGFy468Z6dA@mail.gmail.com>
Subject: amd-xgbe: CL73 autoneg never completes on 10GBASE-T port (ASUSTOR
 AS6804T), forced 10G works
To: Raju.Rangoju@amd.com, PrashanthKumar.K.R@amd.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On an ASUSTOR Lockerstor 4 Gen3 (AS6804T) running Proxmox VE with
kernel 7.0.14-19-pve (a downstream kernel, I have not tested
mainline), the two AMD XGMAC 10GbE ports never link up with
autonegotiation enabled. Forcing the speed works.

Hardware / firmware:
- ASUSTOR AS6804T, BIOS V1.23
- 2x AMD XGMAC 10GbE [1022:1458], driver amd-xgbe
  (enp233s0f2 / enp233s0f3), firmware-version 19.118.48
- Link partner: Netgear GS110EMX switch, fixed RJ45 10GBASE-T port

Symptoms:
1. Autoneg on: ethtool reports Supported ports: TP and advertises
   1000/2500/10000baseT/Full, but "Link detected: no" on both ports.
   Same result when advertising only 10G (advertise 0x1000) or only
   1G (advertise 0x20).
2. Autoneg off, forced speed:
     ethtool -s enp233s0f2 autoneg off speed 10000 duplex full
   with the interface up gives "Speed: 10000Mb/s, Link detected:
   yes" ("Link is Up - 10Gbps/Full" in dmesg).
3. /sys/class/net/enp233s0f2/phydev points to the driver's own MDIO
   bus (mdio_bus/0000:e9:00.2/0000:e9:00.2:00) with phy_id
   0x00000000, so no external PHY is identified by phylib.

Log with dynamic debug (echo 'module amd_xgbe +p' > .../control),
after ip link set down/up (prefix "amd-xgbe 0000:e9:00.2" omitted):

[ 2206.375463] enp233s0f2: starting PHY
[ 2206.375466] enp233s0f2: starting I2C
[ 2207.390072] enp233s0f2: firmware mailbox command did not complete
[ 2207.390147] enp233s0f2: firmware mailbox reset performed
[ 2207.390162] enp233s0f2: 10GbE KR mode set
[ 2207.428875] enp233s0f2: firmware mailbox not ready for command
[ 2207.428945] enp233s0f2: firmware mailbox reset performed
[ 2207.430443] enp233s0f2: 1GbE SGMII mode set
[ 2207.430454] enp233s0f2: CL73 AN initialized
[ 2207.430805] enp233s0f2: CL73 AN enabled/restarted
[ 2207.990892] enp233s0f2: CL73 AN Incompatible-Link
[ 2207.990909] enp233s0f2: CL73 AN result: No-Link
[ 2207.990913] enp233s0f2: CL73 AN Ready
[ 2212.583519] enp233s0f2: AN link timeout
[ 2212.583855] enp233s0f2: AN PHY configuration

The last block (timeout, reconfiguration, Incompatible-Link) repeats
every ~5 seconds and the link never comes up.

I looked at the recent amd-xgbe work on netdev (RX adaptation with AN
disabled, MAC_AUTO_SW in CL37 AN, the pending "synchronize KR
training with device operations" series) and none of it seems to
cover this case; the last one is not present in my running module.

Questions:
- Is CL73 AN expected on a 10GBASE-T port on this platform, or
  should the port mode come out differently from the BIOS/ACPI
  properties?
- I saw ASUSTOR users being pointed to AMD's Ryzen Embedded V3000
  Linux driver package, which carries extra amd-xgbe patches. Are
  those meant to go upstream?

Happy to provide more logs or run further tests on request.

Thanks,

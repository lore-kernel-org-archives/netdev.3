Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802EF443C2C
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142415; cv=pass; b=kJGkNU8u3mQLG74s1HEItAsAT96IseMdqAaIT/Vtwh/8/a+GgdwrruTfucHp+BEUkuRZxoBr1rxRGH9Eka47xjASbOSd5R3J9TfD/d0VyQNmjjQnXgXhyOYzBB4RtQAmyjXZLnxdvNRVosFbqAKj5IN1ZDGlVuCfka13R5AIm1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142415; c=relaxed/simple;
	bh=xdYXrkvSAtJFqq2SMrRaqx6Zf0YUMSg+v8z0zNR/QE8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e+cpHsZZqxFjgIaMuddfIYbttDFujtoMpRpaMBeZfJFzkB7z46bua/ZMmt+uARgX9gtoCuBUcbV4BXpGxxa3y07mVfjuDe7o050VZxlxmSh/3GQvl38rEOf5FOM/OS3pkxAFj5GXCAT+wgkwD+8ZuL2S43+KPKkbE16r5VaNs4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=g/vVcLMe; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="g/vVcLMe"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-868cfc5c244so47268b3a.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789142413; cv=none;
        d=google.com; s=arc-20260327;
        b=Uoj8LEvSrs6NtaWXaSZonqlAYlfld5oEI9jrRBBEmYLFeEEtO4EdSA0dUO4Ig8LE43
         thEi5/Xo0kh4mL9Y3mvNY0eIx08clLdw1/Vs0z2xQ57F60DUm47egoTVQHesalQB3z8v
         mL/islhlBcJXl13/tDqkLr1SstBql++YlaLFtmrAzullwGuiZSCRKjzSHWyS9G7Yyn9q
         tqlneyF2pW9GxzYzpoHAFOWXxnFQx+6b25HmGgxmXHFWwtfAKoyY45Ixl49MBA7y2oCQ
         4E7567l1XGxj4fw4YD7BWgskrDt9t2mrm5FeJbqhB4yCDUKv264cW+/YX29/Z86nldFr
         LsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6o6eJVULpeEp8WLdO8x1Gh+edLFMd4VwpUo4VuvKGUI=;
        fh=g2L7s5feqmvlSELV5yhkFz7un6dQbDac5RlhOq86xPA=;
        b=U352em8jIfaZxDpi4YG+WG6DnDJwrzh6y3Iqqx7wigQkbidWJmGSaFmYqfS0yuUYru
         WGEKe+K0UQNQVewWQocOJhq2livF4EDAa0gd53i9PyKfe2V3nDG01+Y+/vHNIabXsAvU
         tp/vIfUAouAeEIitVwa5WJuL3MkVC/NL2dlHGZ+pBBOdikpx4UEMovxvtdrOJf6vu2oX
         MSuDpFDhLF7127zzOVXoXnfKkOLBThcFCRkhu5cB2kvBzkPY22JO7kKOekuFOsElSfnI
         0M2cZ+1vtfpcFuRF2eDteNGqPzaqL5iEPG1oH+OtsBejiQoDYzFRxGL6AsOvgPLyWYwt
         at+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789142413; x=1789747213; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6o6eJVULpeEp8WLdO8x1Gh+edLFMd4VwpUo4VuvKGUI=;
        b=g/vVcLMeEdGXYNg/RRPBq8yEiNZ7HYhxeQ/4Q2qYn8HhPEmh6mpDW4/n6+CqHrZV6e
         yEkus17WM4nrNmmwp/Mhnz4EQaY/Dbe9jnxxvUAigOtvZuAaus8z/BC4NpPF8KRrnC+6
         W6fwxja72w8K2Fyvbk6opQvGA6vj4QZH1EKlcKxo+s1z4xMHLH2fpSVk3cvEKeSTeC7s
         wqdGSFgfqhxa/86LX8vo8mDxD0Igp0M0C6BOyEcBdQVxJgtfssCBYg4NVpw9tNBcshlz
         aQskhPkIjnAkYThpNtjIpQbbI0FY6kRwxLyPL3RpyENY7oGKGDCrLd2GVJa2Z75h/mtv
         rWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142413; x=1789747213;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6o6eJVULpeEp8WLdO8x1Gh+edLFMd4VwpUo4VuvKGUI=;
        b=GCbDJxy/TVv0mdYxGj8uFe8wmbVwIGnO7CrEYnx3O1OIB8ijxssbfjThXMisA3Ikkb
         ZfIJOvvlzw5uJvbU2bMI8ORR1OF3gAZQ9Wf8X9Em2Mux88gpNqKPvHFr6HO2UpveD9tL
         3F4Fw41jQJ+nMZDhQgCygsgH1kqOpO14WRddx2hizptvpV89SdTKsu4Uuv42Wx/yXBcc
         H2SrSIRwOWlgYKSauRWJnEYDTaD68Qy8aZUPK3GhgRM4LMBrS+vMTccRjm/ZPfaPX1CP
         bttyyuwAMtXFtp0F8E4jP0mo+U7kPiuiMwC9PKRcPLFMIRtfeGKfpJUYX02nsn6irOuW
         u5Eg==
X-Gm-Message-State: AFuF++lNYDzoLt+L69HLbNHXCDHy3qa7vLnltGZ4kAOYapw3ZrWVUDqB
	Vv9tikVpBuuT4n/y0HSqwXmERrOYJZ3VFyTjacXhtr0g3x5b0BIsCiXaHUeXWRWJBPhoHa6txYU
	tzXqqeI4ZIM1w/on9j13W8Lpp0C4SrmWkl9B6n+T7
X-Gm-Gg: AYBFou0QkWKvdy42DIiPJ4SP+myCfWGr7OVsrC0mZgtPp5Wc9JBbuVZ4SeNhJn7BkBl
	FqSF0opkzL4S7kChv0e5lQmB8SEBDzgYrbrn/JdOi/CHkEt2wv528gXNtBL+T3PW2VNmDZwi9bD
	0ySw4LpDRR3r9p2wp5xbk8G5aQuWXktGK7pxXFduYmx6P+lss3ims8vTQeRsTa0FLEwEHeQTE7d
	Ya77SETkUJpS/93LRmoO9mpJPP4E4fCXhXzqYOvdJolp+H/wlLGB6cD0A8iuqt+d7hng4dcFXeV
	30i4Vr1OsSv8c6eYw/PNOPwc/1EKFDLUYZP8CeAqsz7SgdCodYKRbg7YvyfTAMUIyDJitvdxpOl
	Wu7LgxQIvE2vSBXlZqAe5WMYC1vBvgno2rAIIW+24jtSSyVXWiF3V1TqnEQOY+NKVEbsWds7Tgb
	c=
X-Received: by 2002:a05:6a20:a10d:b0:3d7:b3c1:cc34 with SMTP id
 adf61e73a8af0-3daed51e44bmr8486971637.26.1789142411634; Fri, 11 Sep 2026
 09:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Fri, 11 Sep 2026 09:00:00 -0700
X-Gm-Features: AcwNN1Xx9RlIOGZhbEBxCuxnryU_TvnX7Xu2eSmlJBIgfEpxTcoESIf82jieCAI
Message-ID: <CA+0ovCjDmFNXBJD=+8JBk_mpCA5kjCO+gPLSLDBKqY86B80WtQ@mail.gmail.com>
Subject: [BUG] general protection fault in phy_ethtool_set_wol
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e6f742065b372d4a"

--000000000000e6f742065b372d4a
Content-Type: text/plain; charset="UTF-8"

Hello,

We are reporting the following crash (reproducer attached):
Linux version 7.3.0-rc2 50d05c7c76c96b90462f24debacca971d2e86713
Build Config: UpstreamAppArmorKASAN (KASAN + UBSAN, panic_on_warn=1)

[   44.382472][ T9491] Oops: general protection fault, probably for
non-canonical address 0xdffffc00000000a2: 0000 [#1] SMP KASAN NOPTI
[   44.383626][ T9491] KASAN: null-ptr-deref in range
[0x0000000000000510-0x0000000000000517]
[   44.384388][ T9491] CPU: 0 UID: 0 PID: 9491 Comm: repro Not tainted
7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   44.385328][ T9491] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   44.386283][ T9491] RIP: 0010:phy_ethtool_set_wol+0x31/0x100
[   44.386830][ T9491] Code: 41 56 41 55 41 54 53 48 89 f3 49 89 fe 48
bd 00 00 00 00 00 fc ff df e8 ad 95 2f fb 4d 8d be 10 05 00 00 4d 89
fd 49 c1 ed 03 <41> 80 7c 2d 00 00 74 08 4c 89 ff e8 1f 8f 9f fb 4d 8b
27 4d 85 e4
[   44.388549][ T9491] RSP: 0018:ffffc90006c578c0 EFLAGS: 00010202
[   44.389106][ T9491] RAX: ffffffff869806d3 RBX: ffffc90006c57980
RCX: ffff88802b762640
[   44.389815][ T9491] RDX: 0000000000000000 RSI: ffffc90006c57980
RDI: 0000000000000000
[   44.390574][ T9491] RBP: dffffc0000000000 R08: ffffffff90563d7f
R09: 1ffffffff20ac7af
[   44.391323][ T9491] R10: dffffc0000000000 R11: fffffbfff20ac7b0
R12: ffff8881083a4ec8
[   44.392075][ T9491] R13: 00000000000000a2 R14: 0000000000000000
R15: 0000000000000510
[   44.392874][ T9491] FS:  000000002473c400(0000)
GS:ffff8880d7388000(0000) knlGS:0000000000000000
[   44.393672][ T9491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.394264][ T9491] CR2: 00007f4a539c7238 CR3: 000000010ec32000
CR4: 0000000000752ef0
[   44.394978][ T9491] PKRU: 55555554
[   44.395304][ T9491] Call Trace:
[   44.395613][ T9491]  <TASK>
[   44.395890][ T9491]  lan78xx_set_wol+0x180/0x240
[   44.396335][ T9491]  ethtool_set_wol+0x2cb/0x3f0
[   44.396778][ T9491]  ? __pfx_ethtool_set_wol+0x10/0x10
[   44.397264][ T9491]  ? _raw_spin_unlock_irqrestore+0x30/0x80
[   44.397795][ T9491]  ? _raw_spin_unlock_irqrestore+0x4c/0x80
[   44.398328][ T9491]  dev_ethtool+0x141e/0x29c0
[   44.398751][ T9491]  ? __lock_acquire+0x74c/0x2db0
[   44.399210][ T9491]  ? __pfx_dev_ethtool+0x10/0x10
[   44.399688][ T9491]  ? inet_ioctl+0x484/0x560
[   44.400129][ T9491]  ? lock_acquire+0x115/0x350
[   44.400585][ T9491]  ? dev_load+0x21/0x1f0
[   44.401000][ T9491]  ? dev_load+0x21/0x1f0
[   44.401414][ T9491]  dev_ioctl+0x392/0x1150
[   44.401811][ T9491]  sock_do_ioctl+0x23e/0x320
[   44.402239][ T9491]  ? __pfx_sock_do_ioctl+0x10/0x10
[   44.402706][ T9491]  sock_ioctl+0x5c6/0x7f0
[   44.403213][ T9491]  ? __pfx_sock_ioctl+0x10/0x10
[   44.403679][ T9491]  ? __fget_files+0x2a/0x420
[   44.404149][ T9491]  ? __fget_files+0x3a0/0x420
[   44.404619][ T9491]  ? __fget_files+0x2a/0x420
[   44.405066][ T9491]  ? bpf_lsm_file_ioctl+0x9/0x20
[   44.405549][ T9491]  ? __pfx_sock_ioctl+0x10/0x10
[   44.405996][ T9491]  __se_sys_ioctl+0xfc/0x170
[   44.406420][ T9491]  do_syscall_64+0x155/0x510
[   44.406846][ T9491]  ? trace_irq_disable+0x3b/0x140
[   44.407310][ T9491]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   44.407858][ T9491]  ? clear_bhb_loop+0x30/0x80
[   44.408327][ T9491]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   44.408890][ T9491] RIP: 0033:0x425a5d
[   44.409290][ T9491] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d
45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10
00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25
28 00 00 00
[   44.411074][ T9491] RSP: 002b:00007ffc17c574d0 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
[   44.411841][ T9491] RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 0000000000425a5d
[   44.412604][ T9491] RDX: 00007ffc17c57560 RSI: 0000000000008946
RDI: 0000000000000004
[   44.413419][ T9491] RBP: 00007ffc17c57520 R08: 00000000000001a0
R09: 000000002473dca0
[   44.414166][ T9491] R10: 00000000000001a0 R11: 0000000000000246
R12: 00007ffc17c577e8
[   44.414919][ T9491] R13: 00007ffc17c577f8 R14: 0000000000000002
R15: 00000000004caa40
[   44.415649][ T9491]  </TASK>
[   44.415954][ T9491] Modules linked in:
[   44.416487][ T9491] ---[ end trace 0000000000000000 ]---
[   44.429798][ T9491] RIP: 0010:phy_ethtool_set_wol+0x31/0x100
[   44.429815][ T9491] Code: 41 56 41 55 41 54 53 48 89 f3 49 89 fe 48
bd 00 00 00 00 00 fc ff df e8 ad 95 2f fb 4d 8d be 10 05 00 00 4d 89
fd 49 c1 ed 03 <41> 80 7c 2d 00 00 74 08 4c 89 ff e8 1f 8f 9f fb 4d 8b
27 4d 85 e4
[   44.429820][ T9491] RSP: 0018:ffffc90006c578c0 EFLAGS: 00010202
[   44.429827][ T9491] RAX: ffffffff869806d3 RBX: ffffc90006c57980
RCX: ffff88802b762640
[   44.429832][ T9491] RDX: 0000000000000000 RSI: ffffc90006c57980
RDI: 0000000000000000
[   44.429837][ T9491] RBP: dffffc0000000000 R08: ffffffff90563d7f
R09: 1ffffffff20ac7af
[   44.429841][ T9491] R10: dffffc0000000000 R11: fffffbfff20ac7b0
R12: ffff8881083a4ec8
[   44.429846][ T9491] R13: 00000000000000a2 R14: 0000000000000000
R15: 0000000000000510
[   44.429850][ T9491] FS:  000000002473c400(0000)
GS:ffff8880d7388000(0000) knlGS:0000000000000000
[   44.429856][ T9491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.429860][ T9491] CR2: 0000555e3ade6018 CR3: 000000010ec32000
CR4: 0000000000752ef0
[   44.429867][ T9491] PKRU: 55555554
[   44.429873][ T9491] Kernel panic - not syncing: Fatal exception
[   44.439990][ T9491] Kernel Offset: disabled
[   44.440533][ T9491] Rebooting in 86400 seconds..

Regards,

--000000000000e6f742065b372d4a
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtx56mzz0>
X-Attachment-Id: f_mtx56mzz0

LyoKICogMjU0LWdlbmVyYWwtcHJvdGVjdGlvbi1mYXVsdC1pbi1waHktZXRodG9vbC1zZXQtd29s
CiAqLwojZGVmaW5lIF9HTlVfU09VUkNFCiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZmNu
dGwuaD4KI2luY2x1ZGUgPHB0aHJlYWQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxz
dHJpbmcuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNs
dWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxuZXQvaWYuaD4KI2luY2x1ZGUgPGxpbnV4L3Nv
Y2tpb3MuaD4KI2luY2x1ZGUgPGxpbnV4L2V0aHRvb2wuaD4KI2luY2x1ZGUgPGxpbnV4L3VzYi9j
aDkuaD4KI2luY2x1ZGUgPGxpbnV4L3VzYi9yYXdfZ2FkZ2V0Lmg+CgojZGVmaW5lIEVQMF9NQVhf
VFJBTlNGRVIgNDA5NgoKI2RlZmluZSBMQU43OFhYX0lEX1JFVgkJCTB4MDAwCiNkZWZpbmUgTEFO
NzhYWF9QTVRfQ1RMCQkJMHgwMTQKI2RlZmluZSBMQU43OFhYX1BNVF9DVExfUkVBRFkJCTB4MDAw
MDAwODAKI2RlZmluZSBMQU43OFhYX1VTQl9DRkcwCQkweDA4MAojZGVmaW5lIExBTjc4WFhfVVNC
X0NGR19STVRfV0tQCQkweDAwMDAwMDA0CiNkZWZpbmUgTEFONzhYWF9NSUlfREFUQQkJMHgxMjQK
CiNkZWZpbmUgTEFONzhYWF9WRU5ET1JfUkVRX1dSSVRFX1JFRwkweEEwCiNkZWZpbmUgTEFONzhY
WF9WRU5ET1JfUkVRX1JFQURfUkVHCTB4QTEKCnN0YXRpYyBpbnQgcmF3X2dhZGdldF9mZCA9IC0x
OwoKc3RhdGljIGNvbnN0IHVuc2lnbmVkIGNoYXIgY29uZmlndXJhdGlvbl9kZXNjcmlwdG9yW10g
PSB7CgoJOSwgVVNCX0RUX0NPTkZJRywgKDkgKyA5ICsgNyArIDcgKyA3KSAmIDB4ZmYsIDAsIDEs
IDEsIDAsIDB4YTAsIDB4ZmEsCgoJOSwgVVNCX0RUX0lOVEVSRkFDRSwgMCwgMCwgMywgMHhmZiwg
MHgwMCwgMHgwMCwgMCwKCgk3LCBVU0JfRFRfRU5EUE9JTlQsIDB4ODEsIFVTQl9FTkRQT0lOVF9Y
RkVSX0JVTEssIDB4MDAsIDB4MDIsIDAsCgoJNywgVVNCX0RUX0VORFBPSU5ULCAweDAyLCBVU0Jf
RU5EUE9JTlRfWEZFUl9CVUxLLCAweDAwLCAweDAyLCAwLAoKCTcsIFVTQl9EVF9FTkRQT0lOVCwg
MHg4MywgVVNCX0VORFBPSU5UX1hGRVJfSU5ULCAweDEwLCAweDAwLCA0LAp9OwoKc3RhdGljIHN0
cnVjdCB1c2JfZGV2aWNlX2Rlc2NyaXB0b3IgZGV2aWNlX2Rlc2NyaXB0b3IgPSB7CgkuYkxlbmd0
aCA9IHNpemVvZihzdHJ1Y3QgdXNiX2RldmljZV9kZXNjcmlwdG9yKSwKCS5iRGVzY3JpcHRvclR5
cGUgPSBVU0JfRFRfREVWSUNFLAoJLmJjZFVTQiA9IDB4MDIwMCwKCS5iTWF4UGFja2V0U2l6ZTAg
PSA2NCwKCS5pZFZlbmRvciA9IDB4MDQyNCwKCS5pZFByb2R1Y3QgPSAweDc4MDEsCgkuYmNkRGV2
aWNlID0gMHgwMTAwLAoJLmJOdW1Db25maWd1cmF0aW9ucyA9IDEsCn07CgpzdGF0aWMgdW5zaWdu
ZWQgaW50IGVtdWxhdGVkX3JlZ2lzdGVyX3JlYWQodW5zaWduZWQgaW50IHJlZ2lzdGVyX29mZnNl
dCkKewoJc3dpdGNoIChyZWdpc3Rlcl9vZmZzZXQpIHsKCWNhc2UgTEFONzhYWF9JRF9SRVY6CgkJ
cmV0dXJuIDB4NzgwMTAwMDA7CgljYXNlIExBTjc4WFhfUE1UX0NUTDoKCQlyZXR1cm4gTEFONzhY
WF9QTVRfQ1RMX1JFQURZOwoJY2FzZSBMQU43OFhYX1VTQl9DRkcwOgoKCQlyZXR1cm4gTEFONzhY
WF9VU0JfQ0ZHX1JNVF9XS1A7CgljYXNlIExBTjc4WFhfTUlJX0RBVEE6CgoJCXJldHVybiAweDAw
MDBmZmZmOwoJZGVmYXVsdDoKCQlyZXR1cm4gMDsKCX0KfQoKc3RhdGljIHZvaWQgZXAwX3dyaXRl
KGNvbnN0IHZvaWQgKmRhdGEsIHVuc2lnbmVkIGludCBsZW5ndGgpCnsKCXVuc2lnbmVkIGNoYXIg
YnVmZmVyW3NpemVvZihzdHJ1Y3QgdXNiX3Jhd19lcF9pbykgKyBFUDBfTUFYX1RSQU5TRkVSXTsK
CXN0cnVjdCB1c2JfcmF3X2VwX2lvICppbyA9ICh2b2lkICopYnVmZmVyOwoKCWlvLT5lcCA9IDA7
Cglpby0+ZmxhZ3MgPSAwOwoJaW8tPmxlbmd0aCA9IGxlbmd0aDsKCWlmIChsZW5ndGgpCgkJbWVt
Y3B5KGlvLT5kYXRhLCBkYXRhLCBsZW5ndGgpOwoJaW9jdGwocmF3X2dhZGdldF9mZCwgVVNCX1JB
V19JT0NUTF9FUDBfV1JJVEUsIGlvKTsKfQoKc3RhdGljIHZvaWQgZXAwX3JlYWQodW5zaWduZWQg
aW50IGxlbmd0aCkKewoJdW5zaWduZWQgY2hhciBidWZmZXJbc2l6ZW9mKHN0cnVjdCB1c2JfcmF3
X2VwX2lvKSArIEVQMF9NQVhfVFJBTlNGRVJdOwoJc3RydWN0IHVzYl9yYXdfZXBfaW8gKmlvID0g
KHZvaWQgKilidWZmZXI7CgoJaW8tPmVwID0gMDsKCWlvLT5mbGFncyA9IDA7Cglpby0+bGVuZ3Ro
ID0gbGVuZ3RoID4gRVAwX01BWF9UUkFOU0ZFUiA/IEVQMF9NQVhfVFJBTlNGRVIgOiBsZW5ndGg7
Cglpb2N0bChyYXdfZ2FkZ2V0X2ZkLCBVU0JfUkFXX0lPQ1RMX0VQMF9SRUFELCBpbyk7Cn0KCnN0
YXRpYyB2b2lkIGhhbmRsZV9jb250cm9sX3JlcXVlc3Qoc3RydWN0IHVzYl9jdHJscmVxdWVzdCAq
Y3RybCkKewoJdW5zaWduZWQgY2hhciBkYXRhW0VQMF9NQVhfVFJBTlNGRVJdOwoJdW5zaWduZWQg
aW50IHJlcXVlc3RlZF9sZW5ndGggPSBjdHJsLT53TGVuZ3RoOwoJaW50IHJlcGx5X2xlbmd0aCA9
IC0xOwoKCWlmICgoY3RybC0+YlJlcXVlc3RUeXBlICYgVVNCX1RZUEVfTUFTSykgPT0gVVNCX1RZ
UEVfU1RBTkRBUkQpIHsKCQlpZiAoY3RybC0+YlJlcXVlc3QgPT0gVVNCX1JFUV9HRVRfREVTQ1JJ
UFRPUikgewoJCQlpZiAoKGN0cmwtPndWYWx1ZSA+PiA4KSA9PSBVU0JfRFRfREVWSUNFKSB7CgkJ
CQlyZXBseV9sZW5ndGggPSBzaXplb2YoZGV2aWNlX2Rlc2NyaXB0b3IpOwoJCQkJbWVtY3B5KGRh
dGEsICZkZXZpY2VfZGVzY3JpcHRvciwgcmVwbHlfbGVuZ3RoKTsKCQkJfSBlbHNlIGlmICgoY3Ry
bC0+d1ZhbHVlID4+IDgpID09IFVTQl9EVF9DT05GSUcpIHsKCQkJCXJlcGx5X2xlbmd0aCA9IHNp
emVvZihjb25maWd1cmF0aW9uX2Rlc2NyaXB0b3IpOwoJCQkJbWVtY3B5KGRhdGEsIGNvbmZpZ3Vy
YXRpb25fZGVzY3JpcHRvciwgcmVwbHlfbGVuZ3RoKTsKCQkJfQoJCX0gZWxzZSBpZiAoY3RybC0+
YlJlcXVlc3QgPT0gVVNCX1JFUV9TRVRfQ09ORklHVVJBVElPTikgewoJCQlpb2N0bChyYXdfZ2Fk
Z2V0X2ZkLCBVU0JfUkFXX0lPQ1RMX0NPTkZJR1VSRSwgMCk7CgkJCXJlcGx5X2xlbmd0aCA9IDA7
CgkJfQoJfSBlbHNlIGlmICgoY3RybC0+YlJlcXVlc3RUeXBlICYgVVNCX1RZUEVfTUFTSykgPT0g
VVNCX1RZUEVfVkVORE9SKSB7CgkJaWYgKGN0cmwtPmJSZXF1ZXN0ID09IExBTjc4WFhfVkVORE9S
X1JFUV9SRUFEX1JFRyAmJgoJCSAgICAoY3RybC0+YlJlcXVlc3RUeXBlICYgVVNCX0RJUl9JTikp
IHsKCQkJdW5zaWduZWQgaW50IHZhbHVlID0gZW11bGF0ZWRfcmVnaXN0ZXJfcmVhZChjdHJsLT53
SW5kZXgpOwoKCQkJZGF0YVswXSA9IHZhbHVlICYgMHhmZjsKCQkJZGF0YVsxXSA9ICh2YWx1ZSA+
PiA4KSAmIDB4ZmY7CgkJCWRhdGFbMl0gPSAodmFsdWUgPj4gMTYpICYgMHhmZjsKCQkJZGF0YVsz
XSA9ICh2YWx1ZSA+PiAyNCkgJiAweGZmOwoJCQlyZXBseV9sZW5ndGggPSA0OwoJCX0gZWxzZSBp
ZiAoY3RybC0+YlJlcXVlc3QgPT0gTEFONzhYWF9WRU5ET1JfUkVRX1dSSVRFX1JFRykgewoJCQly
ZXBseV9sZW5ndGggPSAwOwoJCX0gZWxzZSB7CgoJCQlyZXBseV9sZW5ndGggPSAoY3RybC0+YlJl
cXVlc3RUeXBlICYgVVNCX0RJUl9JTikgPwoJCQkJKGludCkocmVxdWVzdGVkX2xlbmd0aCA+IEVQ
MF9NQVhfVFJBTlNGRVIgPwoJCQkJICAgICAgRVAwX01BWF9UUkFOU0ZFUiA6IHJlcXVlc3RlZF9s
ZW5ndGgpIDogMDsKCQkJbWVtc2V0KGRhdGEsIDAsIHJlcGx5X2xlbmd0aCk7CgkJfQoJfQoKCWlm
IChyZXBseV9sZW5ndGggPCAwKSB7CgkJaW9jdGwocmF3X2dhZGdldF9mZCwgVVNCX1JBV19JT0NU
TF9FUDBfU1RBTEwsIDApOwoJfSBlbHNlIGlmIChjdHJsLT5iUmVxdWVzdFR5cGUgJiBVU0JfRElS
X0lOKSB7CgkJaWYgKCh1bnNpZ25lZCBpbnQpcmVwbHlfbGVuZ3RoID4gcmVxdWVzdGVkX2xlbmd0
aCkKCQkJcmVwbHlfbGVuZ3RoID0gcmVxdWVzdGVkX2xlbmd0aDsKCQllcDBfd3JpdGUoZGF0YSwg
cmVwbHlfbGVuZ3RoKTsKCX0gZWxzZSB7CgkJZXAwX3JlYWQocmVxdWVzdGVkX2xlbmd0aCk7Cgl9
Cn0KCnN0YXRpYyB2b2lkICplcDBfZXZlbnRfcHVtcCh2b2lkICp1bnVzZWQpCnsKCXVuc2lnbmVk
IGNoYXIgYnVmZmVyW3NpemVvZihzdHJ1Y3QgdXNiX3Jhd19ldmVudCkgKyBFUDBfTUFYX1RSQU5T
RkVSXTsKCXN0cnVjdCB1c2JfcmF3X2V2ZW50ICpldmVudCA9ICh2b2lkICopYnVmZmVyOwoKCWZv
ciAoOzspIHsKCQlldmVudC0+dHlwZSA9IDA7CgkJZXZlbnQtPmxlbmd0aCA9IEVQMF9NQVhfVFJB
TlNGRVI7CgkJaWYgKGlvY3RsKHJhd19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExfRVZFTlRfRkVU
Q0gsIGV2ZW50KSA8IDApIHsKCQkJaWYgKGVycm5vID09IEVJTlRSKQoJCQkJY29udGludWU7CgkJ
CXJldHVybiBOVUxMOwoJCX0KCQlpZiAoZXZlbnQtPnR5cGUgPT0gVVNCX1JBV19FVkVOVF9DT05U
Uk9MKQoJCQloYW5kbGVfY29udHJvbF9yZXF1ZXN0KChzdHJ1Y3QgdXNiX2N0cmxyZXF1ZXN0ICop
ZXZlbnQtPmRhdGEpOwoJfQp9CgpzdGF0aWMgaW50IGZpbmRfbGFuNzh4eF9pbnRlcmZhY2UoaW50
IGV0aHRvb2xfc29ja2V0LCBjaGFyICppbnRlcmZhY2VfbmFtZSkKewoJc3RydWN0IGlmX25hbWVp
bmRleCAqaW50ZXJmYWNlX2xpc3QgPSBpZl9uYW1laW5kZXgoKSwgKmludGVyZmFjZTsKCXN0cnVj
dCBldGh0b29sX2RydmluZm8gZHJ2aW5mbzsKCXN0cnVjdCBpZnJlcSBpZnI7CglpbnQgZm91bmQg
PSAwOwoKCWlmICghaW50ZXJmYWNlX2xpc3QpCgkJcmV0dXJuIDA7Cglmb3IgKGludGVyZmFjZSA9
IGludGVyZmFjZV9saXN0OyBpbnRlcmZhY2UtPmlmX2luZGV4OyBpbnRlcmZhY2UrKykgewoJCW1l
bXNldCgmaWZyLCAwLCBzaXplb2YoaWZyKSk7CgkJbWVtc2V0KCZkcnZpbmZvLCAwLCBzaXplb2Yo
ZHJ2aW5mbykpOwoJCWRydmluZm8uY21kID0gRVRIVE9PTF9HRFJWSU5GTzsKCQlzdHJuY3B5KGlm
ci5pZnJfbmFtZSwgaW50ZXJmYWNlLT5pZl9uYW1lLCBJRk5BTVNJWiAtIDEpOwoJCWlmci5pZnJf
ZGF0YSA9ICh2b2lkICopJmRydmluZm87CgkJaWYgKGlvY3RsKGV0aHRvb2xfc29ja2V0LCBTSU9D
RVRIVE9PTCwgJmlmcikgPCAwKQoJCQljb250aW51ZTsKCQlpZiAoIXN0cmNtcChkcnZpbmZvLmRy
aXZlciwgImxhbjc4eHgiKSkgewoJCQlzdHJuY3B5KGludGVyZmFjZV9uYW1lLCBpbnRlcmZhY2Ut
PmlmX25hbWUsIElGTkFNU0laIC0gMSk7CgkJCWZvdW5kID0gMTsKCQkJYnJlYWs7CgkJfQoJfQoJ
aWZfZnJlZW5hbWVpbmRleChpbnRlcmZhY2VfbGlzdCk7CglyZXR1cm4gZm91bmQ7Cn0KCmludCBt
YWluKHZvaWQpCnsKCXN0cnVjdCB1c2JfcmF3X2luaXQgaW5pdDsKCXB0aHJlYWRfdCBnYWRnZXRf
dGhyZWFkOwoJY2hhciBpbnRlcmZhY2VfbmFtZVtJRk5BTVNJWl07CglzdHJ1Y3QgaWZyZXEgaWZy
OwoJc3RydWN0IGV0aHRvb2xfd29saW5mbyB3b2w7CglpbnQgZXRodG9vbF9zb2NrZXQsIGF0dGVt
cHQ7CgoJcmF3X2dhZGdldF9mZCA9IG9wZW4oIi9kZXYvcmF3LWdhZGdldCIsIE9fUkRXUik7Cglp
ZiAocmF3X2dhZGdldF9mZCA8IDApIHsKCQlwZXJyb3IoIm9wZW4gL2Rldi9yYXctZ2FkZ2V0Iik7
CgkJcmV0dXJuIDE7Cgl9CgoJbWVtc2V0KCZpbml0LCAwLCBzaXplb2YoaW5pdCkpOwoJc3RyY3B5
KChjaGFyICopaW5pdC5kcml2ZXJfbmFtZSwgImR1bW15X3VkYyIpOwoJc3RyY3B5KChjaGFyICop
aW5pdC5kZXZpY2VfbmFtZSwgImR1bW15X3VkYy4wIik7Cglpbml0LnNwZWVkID0gVVNCX1NQRUVE
X0hJR0g7CglpZiAoaW9jdGwocmF3X2dhZGdldF9mZCwgVVNCX1JBV19JT0NUTF9JTklULCAmaW5p
dCkgPCAwKSB7CgkJcGVycm9yKCJVU0JfUkFXX0lPQ1RMX0lOSVQiKTsKCQlyZXR1cm4gMTsKCX0K
CWlmIChpb2N0bChyYXdfZ2FkZ2V0X2ZkLCBVU0JfUkFXX0lPQ1RMX1JVTiwgMCkgPCAwKSB7CgkJ
cGVycm9yKCJVU0JfUkFXX0lPQ1RMX1JVTiIpOwoJCXJldHVybiAxOwoJfQoKCXB0aHJlYWRfY3Jl
YXRlKCZnYWRnZXRfdGhyZWFkLCBOVUxMLCBlcDBfZXZlbnRfcHVtcCwgTlVMTCk7CgoJZXRodG9v
bF9zb2NrZXQgPSBzb2NrZXQoQUZfSU5FVCwgU09DS19ER1JBTSwgMCk7CglpbnRlcmZhY2VfbmFt
ZVswXSA9IDA7Cglmb3IgKGF0dGVtcHQgPSAwOyBhdHRlbXB0IDwgMzAwOyBhdHRlbXB0KyspIHsK
CQlpZiAoZmluZF9sYW43OHh4X2ludGVyZmFjZShldGh0b29sX3NvY2tldCwgaW50ZXJmYWNlX25h
bWUpKQoJCQlicmVhazsKCQl1c2xlZXAoMTAwMDAwKTsKCX0KCWlmICghaW50ZXJmYWNlX25hbWVb
MF0pIHsKCQlmcHJpbnRmKHN0ZGVyciwgImxhbjc4eHggbmV2ZXIgYm91bmQgLS0gY2hlY2sgZG1l
c2dcbiIpOwoJCXJldHVybiAxOwoJfQoKCW1lbXNldCgmaWZyLCAwLCBzaXplb2YoaWZyKSk7Cglt
ZW1zZXQoJndvbCwgMCwgc2l6ZW9mKHdvbCkpOwoJd29sLmNtZCA9IEVUSFRPT0xfU1dPTDsKCXdv
bC53b2xvcHRzID0gMDsKCXN0cm5jcHkoaWZyLmlmcl9uYW1lLCBpbnRlcmZhY2VfbmFtZSwgSUZO
QU1TSVogLSAxKTsKCWlmci5pZnJfZGF0YSA9ICh2b2lkICopJndvbDsKCWlvY3RsKGV0aHRvb2xf
c29ja2V0LCBTSU9DRVRIVE9PTCwgJmlmcik7CglyZXR1cm4gMDsKfQo=
--000000000000e6f742065b372d4a--

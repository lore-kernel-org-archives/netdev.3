Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09984B7A4A
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597675; cv=none; b=cesp5pM3vnW5ODAhWg1Lo1UwSLgl/vSFk/Dv8UxqKo1s1po8fDvUmhpWSJxkAETJ2do/mEqPle0g6KKgsVbd4xDxfQk+35rwZ29FRXcCihZJggdhNnA0M65thoNW7LLH1mO68DdXiulk5cjzqgHnyU6+7RJqiV6Md5gvtn9sm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597675; c=relaxed/simple;
	bh=PsX78lK8kV1p8QCkLGYhbOO7COY4EBTDxfg3nkpwkoc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=s2GMgCcRNT733wyhFRa5/2t67ZVlw3W72xsqQS00rDeB/Q7O/r4qZiPzb7/XCcCgYz+P6Ru8fQqNm5zG0Q0WMwNLqz0H2q6Z2ov6iraFKBvSBTN4hwKNM7ZwosZ6p9Fig8rqV6QEiMxT+79Fjg3WnYHaJFYDIddPtLm1FLhNsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4mZ50zR; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4mZ50zR"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93c64c01c86so85016485a.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790597673; x=1791202473; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UyjIKBIPqYXv8Prs9gssJSF5uuCPKSgTcpAD5Z9WKPw=;
        b=P4mZ50zRR0P76mt1TfN/4ZaWkRP2CFiUPF8nSmkAkDvflHtDLGVWx5dClZXaa7V/K0
         Dg7izmh/vzUyLd2l8eHKcXvvfPqLoq1XFLhQIlLg3KFMLAGPEy/gAyEj8c4jJnp3YaLg
         w/sxMId/VAVuMW7HE+HPCCbc0g3trp2r/msvhyLH1qBLFHt0rk7rjUsQnRt8YwOVFuUm
         7vqNcNDDkQo778Q/fJcerVMyhK5QQGWQ+Ea51JT8os8ScQKmDo7YjnoU6u58Qi0t9Dj5
         bxGnLsXNLn/FLeoxZ3xzaEs3pr0RJRObhJjXdFNEum9Wv8uGzukhT5+VcL3f9g4/fgol
         eq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597673; x=1791202473;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyjIKBIPqYXv8Prs9gssJSF5uuCPKSgTcpAD5Z9WKPw=;
        b=x3Ynv312Zp+pGs+3Pt5cuiSKmwLSSck4Zmk80eEmfxZsFRqagkQg0qVycOIhDZWNUa
         tIzdNzjM1IlwAEs9whHQsqKgcYqJDpJs02pKasGeTNXrRs1Pg1ASefbQ6uJRjJl5uo+3
         kcAzPQdemquYNI+6xMXG6q6gvd6ws3BssYbLRARwk40VpHnUgAw4Id+eGfCsTFCqGuG1
         B7On2+QYcn8Ob5eL+ionxo5gqJgtYzbkrdHHebIVtAMa2DmY3vRbqWlnPayAdgd7QfGJ
         jQwR0hyAVqI/6Ydqla5+5lc1fXKyzPJzjrRp+YxhuF7bIOj0f1KO5xtVu6thygESrhFM
         Fudw==
X-Forwarded-Encrypted: i=1; AKwUvBzGrTIp33/pX2GmRM9w/9XJgcENdO2aq/tEBmLKUaGIrOGqrh9SQTJwo/bvtbhrMGVFljfHB44=@vger.kernel.org
X-Gm-Message-State: AFuF++lvF/B3gn3dPzmRxDSZ/XAdvVpP84JkF9ZnorZ4SGe+9pcFI3uJ
	vTIhm2w1j6EmA9m/LVBJZRaJQRyg0+Cl0Ca1MUvRpKWR/eMKtxuiNgLr
X-Gm-Gg: AYBFou0rHDt4INJ308JfXPkLrfZ2aBqyKhJV8Xm6X5IIfIU7eXHs0to0A/dj2h6lXo1
	MsmhbQie1svIajcODQ4Udrss+2wDKi+1B4Wd8nXV4P5OgMdfD78b+sEtOmiPKU5KhX+ffOlcCV8
	PviTEyVqdRmCb5vJlNOJgU8cR2MuyQXLGFV85WtA345BXK6TR28UpyQyhWBG1FKK2ZWl+1mf7V2
	QVeIxKlH6/XpHYKdeiZjKxR94ISQJt0pv2fhuDC6IQ+7kdnFXVZR0XgzPT5CUcl1dS5LESl8U2x
	bu2qHYbHPNOhM2+VFs/iR4ZXV4gPrEv2r4HdZVW6ol8SwsY+n/2HD/zab9BeDnai0cTGUyj9lS4
	mhPnOtItYbJnwM2fy98IND1dNGrxvtxwwyGyRCOgP3DoxdXGedNcBHQCWjQeO5HJ/kidSWI2yRz
	aVdtbIWosBg/O2XtSRV3/XkYmMb58bYV6sBXhpRuInWTkwSLqox7QwrZLHOql+x4kg2jAEfYlFs
	t4=
X-Received: by 2002:a05:620a:a40b:20b0:93c:5872:ef48 with SMTP id af79cd13be357-93c5872f16dmr925585885a.50.1790597671134;
        Mon, 28 Sep 2026 05:14:31 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c8125e571sm132463485a.5.2026.09.28.05.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 05:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 08:14:29 -0400
Message-Id: <DLQXWDJZL73T.102F8VI566PWB@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/8] eth: mpnic: add register init for the
 device
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260924-linux-mpnic-v2-2-4badc9b58b9e@gmail.com>
 <179055369885.3145.4992800467382356655@kernel.org>
In-Reply-To: <179055369885.3145.4992800467382356655@kernel.org>

On Sun Sep 27, 2026 at 8:01 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] mpnic_dev_init() writes BAR0 CSRs up to MPNIC_OB_ATTR_RDE_P
>   (dword 0x9a001a, byte 0x2680068 + 8, about 38.5 MiB into BAR0), and=E2=
=80=A6
>
> --
>
> eth: mpnic: add register init for the device
>
> This commit adds one-time CSR initialization to mpnic_probe() through a
> new mpnic_dev_init() in mpnic_init.c. The new code sets static TXB, RXB,
> TQS, AXI and relaxed-ordering configuration. It also starts SRAM zeroing
> on several blocks and polls until that finishes.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_pci.c
>> index 96393e7812418..68a64377e6c5a 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
>
> [ ... ]
>
>> @@ -108,6 +112,10 @@ static int mpnic_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
>>  	pci_set_master(pdev);
>>  	pci_save_state(pdev);
>> =20
>> +	err =3D mpnic_dev_init(mpd);
>> +	if (err)
>> +		goto err_free_mpd;
>> +
>
> [Severity: Low]
> Should mpnic_probe() check the size of BAR0 before mpnic_dev_init() runs?
>
> mpnic_probe() maps BAR0 with pcim_iomap_region() but never compares
> pci_resource_len(pdev, 0) with the highest CSR offset the driver uses.
> Neither mpnic_wr64() nor mpnic_rd64() puts an upper limit on reg:
>
>     if (csr)
>         writeq(val, csr + reg);
>
> The highest register mpnic_dev_init() writes is MPNIC_OB_ATTR_RDE_P, from
> mpnic_ro_init(). Its byte offset is 0x2680068, about 38.5 MiB into BAR0.
> mpnic_desc_sram_init() also issues 4096 writeq() calls at offsets
> computed from the loop index:
>
>     for (i =3D 0; i < MPNIC_MAX_TXQS * 2; i++)
>         mpnic_wr64(mpd, MPNIC_TDF_DESC_CFG(i), ...);
>
> A device that matches the PCI ID but reports a smaller BAR0 would make
> these accesses land outside the ioremap'd region during probe.
>
> The PCI core normally trusts BAR sizes reported by the device, and fbnic
> maps its BARs without a length check too. So this would be defensive
> hardening rather than a fix for a known failure. Would a check against
> the largest CSR offset in mpnic_probe() be worth adding?
>
>>  	return 0;
>> =20
>>  err_free_mpd:

These are in the range of our 64MiB BAR0.

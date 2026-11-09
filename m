Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794191709;
	b=gP2tBrkCgNFKIF1aCmaSxOVDfdbIL/e4utho0zooOM3VaRDeU5FlZhX3Ln0PW2ISDpbA
	 GBFr8pXid3fsdSXCpUN5JRCZk0YmQUtdaiarKaTcWkG0low4CT89KAUQKXwmefgi9IBnv
	 cnlvA7aWNcN+C2VCz0PJltOgyd5poI3Tv4kMn83A3LV5mGlQG52r21BC5rbS5aYDozmXL
	 cEZ0Gbi+XMJotIPZBFbbq+F3mRmXS3ggKlxq0RxXqnVMBEZVOwEaPfQZbxaN2/xBX9Bva
	 2tRGACC80ULF9eccHi+pJH1vxyUohPo+4Kv36j74RMP1VY4ARafqYis+ZHwY66XxeTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iPEE4e+FhVTbeOQfC+hq3HXlXhp32T0R1afgEhwbTZY=;
	b=5A/TY2jMtQc2OGa/LOZrSvZrhGdRG4NsFeOlr8aSjRMLt6u7l4BsG7AXqkCCNymn6d9d
	 +eQM/Wmh1fGhvvLJ2ISHOZU+zG3xlKbzfH0z7Z/Og1ZRsEpRxdI/IGk8CQsE4dhSO4i0M
	 G9WqDNAJNcS1JqTUN4RAi5f8rE2ya6IYtf421M4Rz1bVa2GNs3Tz30poKd/9t/110o49T
	 Mw+LblnTcv6moORn+1MkimHV9wt8jMGiCwHcEARHDP2uUb+NNJ2JCWSShLsVZnlpmqhFi
	 lf4lLqs5ilnTsrnbDFzU9uITHRfIGJeCcBmCSMcrg3jQf/NMapqKRmDwH2pqsbQZweA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZKm54WY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02D606A331
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 02:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F02D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZKm54WY
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-716c0217635so372198eaf.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 18:35:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794191708; cv=none;
        d=google.com; s=arc-20260327;
        b=TgxFV4Yd90hOZckaUohPiz1GP/mZTxkF2/K0AewcXzgrIodxIyOaqwY66heX8dyt0r
         HfCNkLmPLmPTSA+xBkGJ8CX0RuDL7sw5ajEJQgdwAbOKAyrOvwVUGrM6rE/7gGfLp+cO
         588BxfUw762X3nYtrf6y52LuKUUNg17AVOHkiXyWx57rgQI+W06/j0ccZtd62VlsgBgn
         NsH+Ro+svT1tXVpDIotGo1cHfGKVrwwE4+bcANr7uxmdKn3W9v+Z9YsTw63rapMAjzdO
         Ic3304wLXBjElC2yguuSWO5JqIiN5gsEOAvllKexickCzqHxmOj6Ewb/WybuXPDHhvrh
         af8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iPEE4e+FhVTbeOQfC+hq3HXlXhp32T0R1afgEhwbTZY=;
        fh=HOCoUjSZcGf7NBRBuDNcjKmv70754EEUZGzm4U6Ujw8=;
        b=jyrTZKDqwHYaABG5oDBpP7Rzn2At4y938klMx13Vc1aRkN8VYFDCktr0YLoXau3XJt
         WUedNXxXtQFjoXj1GZbj9tArdDmf0SP5AOYeLWX6mGP6BRedk26OXmkOWimSYlGVDejw
         EV3k9Tw9Tyw98Iqx6f0zgC8KyCA5avhRk87GvANzamkpiJZ/eqvCni8N+YZB4RNwDI8v
         rf3W2hX1ucq3fM3KgH0ZfcdaWHH+MYE7XDB0mqKMatjucg4dkaCEoEBeKEa4c+GjBBAs
         /vgb+xLJpHdPbULNHu6z9mtkaRnJRSdOvCpFxZt2iU4en6hCDl28cI0TL6fjFEuQm9rO
         n25w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794191708; x=1794796508; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPEE4e+FhVTbeOQfC+hq3HXlXhp32T0R1afgEhwbTZY=;
        b=eZKm54WY/ijAlIPxiznq8wqeep7LsgU3WAKgxqCqmAr9oNmREkx1We66q5WLkl3Ddx
         tDmcH4KNis5hcw008QZVPPMAUSy21pp6qkCi0yatqUfDYtouoRcf0jIYjRJ+exVSDvc4
         E6mAxrPqVx+/8zShGbDcDNFhFi1OO3WUAgjn68BZGeB7RH072CfRek4ZTHHbQZ5YC1NF
         2q9KMdUrsZS2zXHXQdA4MbWlKZY2sa0clc8KtyoW4/t9ZqAvR8ob/mm5O+RATpnB8HxE
         66YCQ3wORdtSC+mznW1di8ps66AiQbDsQEv+4XIucZbnvAWQCbEFAaAE1s7kDqYqN1a6
         q+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794191708; x=1794796508;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iPEE4e+FhVTbeOQfC+hq3HXlXhp32T0R1afgEhwbTZY=;
        b=eH7VTYxHkploDYXW5AsrEXZaoM+T1tyndkqyOqm1I1Po5uM3ExfytjVVJMBjfhijS2
         BLXzmMEIIFAwSvaGFuOUee5TVkdxGpyfSe44wJZ7K1/8vDFE8a12w+fZDFTDnXDeYSnK
         IbWPJXhpGCGt7ZwJ4xDQJgZSnmVTTiVn18jxglb9Tu1K+uCzWWRU/ndz+njsIRgGALFI
         Tec+/NEUY/lZw0m37cSdV8xmThq7M0jzg0DFa3ASgh7eR09agU3lOdileD2LZ6o0pBNl
         gt0afJhplq15TcA2YtwGpjsOzY4xWdTv3ndE4etQ7VX0+uEycu34yJm/ttcHuIKLi1Am
         mI8g==
X-Forwarded-Encrypted: i=1; AL+hErE8MWAtSoJE0I+qTAuDpNZQQeOCRRURnLDChIFWS1wDHRjQ93wIqkynl3Q+AI4ScKsEITS9SHg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SeM/1yOkFvtPsTE0JjIH2ou9Dsywv4BUj0ZOT1SUWUJDWQmer
	SDoFcWxmO+sfxnOGX+/T+VoMS7yglEUhG0lXlKqzoZntagJvxY8iPaxSd6vM0OfWw0Y/o81K47x
	j0AlXBG0oi+otSkXM1UWU2eLOauGzklI=
X-Gm-Gg: AYBFou1TnQ+VvRHYJkeazLOKK9dPYB1+DiFEqQS/u7XKdOy2YELkTfdGEmN1jKpCw9n
	gnr4VEBN9bOTf3i6OEvgQN5CpmbeYbvH+2SXuoB2ikdrrwqY8RNPhWGi6qtniCuCYjQC/UZ0hp5
	oarZzVSqw4fr+jpPJHWWO1XM7C5MtoqpN/JQpUolfCq1IH8+IUX5bDADhv3y0/yzI1TMucl+kaJ
	ayZhuNt11tQs80ZlMJ42f51cR3mG+5O7eufHJPKzPawaanPw9XriaqfAf1LCuXyhuXipwhq3eSR
	EHnK5wCd9loKrHd3iYrPesY8fLktYfOdMR3U29aelSaBZc6BvPTxNfUK5XRDlo1UwU+g7d22UKz
	4ChR1syAPIn2NYbxzcCVUjHjkiYmtb2VzLL50kuuM0IB5JaCh8j9m4SwSHJJZmG/3c+6J3A==
X-Received: by 2002:a05:6820:81cb:b0:703:ad5d:e673 with SMTP id
 006d021491bc7-71700ccc4a6mr2488203eaf.30.1794191708251; Sun, 08 Nov 2026
 18:35:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com> <88239c31-e161-4623-8dbb-db39f506af6f@yahoo.com>
In-Reply-To: <88239c31-e161-4623-8dbb-db39f506af6f@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 8 Nov 2026 23:34:53 -0300
X-Gm-Features: AclHuK8y5AYFHGAYTEdMasnfFP8h-556sx1sTmQKK0Jn_aTTYXz0xJVOxMeuACs
Message-ID: <CAJq09z6UsRtbjF6KCMKuTTC1gcp=4=h024EuKuRYwvgLwSmsFw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 09/10] net: dsa: realtek: rtl8365mb: make
 L2/LUT access work on family D
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The L2 lookup table on family D switches (e.g. RTL8367S-VB) differs
> from family C in ways that make the current FDB/MDB code misbehave:
>
>  - An L2 entry is 5 words instead of 6, with a different field layout
>    in words 3 and 4 (port, age, static and multicast member bits).
>  - There is no EFID and no per-bridge FDB isolation. The register at
>    0x0A32, used as the per-port EFID register on family C, is the LUT
>    aging timer on family D, so writing an EFID there corrupts it.
>  - In the table access interface, the SPA field is 3 bits wide and the
>    address register is 12 bits wide, with no address extension bit.
>  - Only ports 0..7 are present in the LUT and there is no
>    FLUSH_PORT_EXT register.
>
> Teach the table and L2 code about these differences, selecting the
> layout at runtime with rtl8365mb_get_family(). Family C behaviour is
> unchanged.
>
> Specifically:
>
>  - rtl8365mb_table: use the family D port mask and address width, and
>    read the hit address from status bits [11:0].
>  - rtl8365mb_l2: add family D unicast/multicast entry (de)serialisers
>    behind *_any() wrappers, pass the proper entry size to the table
>    layer, reject ports above 7, report SVL (FID) entries with VID 0.
>    Use age 6 for static unicast entries as the vendor code does, and
>    look an entry up before deleting it so that a missing entry is not
>    allocated by the delete.
>  - rtl8365mb_main: make port_set_efid() a no-op on family D, add a LUT
>    init step that clears IPMC_HASH and BCAM_DISABLE and programs the
>    aging timer, and do not advertise fdb_isolation or
>    max_num_bridges. Traffic between bridges is then isolated by the
>    port isolation masks only.

So, family D does not have EFID support? I'm curious how this will
work in the FDB table when you have two bridges using the same VLAN
and receiving traffic from the same MAC address. On family C and
earlier, the L2 table uses both EFID and FID/VID as lookup keys.
Without EFID on family D, what are the implications?

The number of EFIDs defines the number of supported bridges. Without
EFID, should we limit the number of bridges to 1 (or prevent creating
multiple bridges with conflicting VLANs)? Turning a used field or
function into a no-op without handling its architectural consequences
can lead to subtle bugs.

This highlights why a simple end-user test isn't enough when adding
support for a new family. Every feature needs to be tested
individually and aligned with the driver changes. I've had the
RTL8367R up and running for months, but I'm still testing features and
finding bugs (and the support is still incomplete). That's also why
the VLAN/FDB offloading patches took so long to get merged. Alvin's
original implementation worked well for standard use cases, but
covering edge cases and verifying all features required a significant
amount of rigorous testing and bug fixing.

Best regards,

Luiz

Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272D2F8E98
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454384; cv=pass; b=pXcJl2x1faNEoNnIeyyg3dPl+x6FU7PSEuhQGq5eIAyueY635vpoed67n8UI0EqFOF/BRe7VdWseD9FXS4ojnSaSshTKd/ihDnfTsZ+T8IxXbEefdUS4f5TEy3WlcFn3zXw1vYvnLjeXmWGBnQFetWVquAgQN0zr3sM1uNWPl54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454384; c=relaxed/simple;
	bh=9EiAa+Ogugh4b+2lwzX2umapF2/7iRJngWsrNV0vO3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkiOs1MPh3gRdCkwE+0Dn2TwPjnPrpO5WE9cRTawy8eMEgFGa2qCMsL8KJNJP8lreDKBHgf2JekXRoIEQ6hXQpjJIkj/uTRE8BuM/Brd7t3pNwsXfYQ9yekUoT7QegGVCqmPlNvc+7+i5cK3v5EB0vVyQKSTCFR1dkGQ1hjF7fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a93tklK/; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a93tklK/"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2330142a91.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786454383; cv=none;
        d=google.com; s=arc-20260327;
        b=DvfqvnWo91JRDBLTIUq93QmPdXlqotmcyZ9qYFnOye5KbNBfQL2CqMm0BPm+77d8Dq
         8Z9DOBnb+95byjW2rEOsjqM1XRexwBcuhQpHY2hdZbRvJF3H4hBW5Wa5W7wrNa/Cd/qB
         BbX46dmqTxNL2oFtjJ+oDjq4nj4i1qTOOZLDc+l1i4tk20ukxo85ACIb0JonbbiW6bBQ
         PDXl2X4EV0yyhO4MWBc0ghp877DoGpZJ4elSXUo2PRg0hCPVAfPUjqJHMMNuJQvzJwva
         kY9JKlqrKEvNapBdPbRv4ywwfbX0VTpl1aisLtMpvHXMZ/On6NFcam3dAJsmI73gLMVV
         ao4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9EiAa+Ogugh4b+2lwzX2umapF2/7iRJngWsrNV0vO3Y=;
        fh=CBJ8n6o/oDvJNcJdZ9HyUnNkNv9TZBrGl81tZDTLY+w=;
        b=BN4+3kpQ/s3UGgaBaXiB5BBAWjtYjAz5cr+aOIpQaHVmF921282pM8tBOkwesY7eNe
         H6Cysv2DG6j+mpJJzsHU3nzmT/NFBbVWX4McwG1n1zSVxRbMQeS1cZv4k/FlUK9BILn1
         Lgzz2nU5NWxc/mtfj2HIH5yVGkJ1bHOzWQ/gwn3dmwfDsiRpDIQpTKethtRw0yLZZHue
         PPrgSXhJnov/G4UZSkAud7LZqgZplZDT5Ly7HMBPUDk5++Kk49VDYAHw7gamjt6Oh6sE
         A8ct6EncVThfcpFBMDWqLl/i2GmjBxsqY1tYWVDCV+tfH65F2jgXBo19SXZA8mSMLkHH
         qb4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786454383; x=1787059183; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9EiAa+Ogugh4b+2lwzX2umapF2/7iRJngWsrNV0vO3Y=;
        b=a93tklK/f5bXM0X3ZRPC8w3AsX10hpinvBK+FZXBgyZbC6yUz9pU7g+6e4e09OXNYl
         BTuzutz3M9ETIYy1oKnSPpc9zRT7PVgOO3MUKXxBunZaLTCE9C6yv7tKBmsMbWNt/rbn
         rtRP8DkCuQjdo0R6kMYulI0faLgqxNN0o99sodgbEtT4J1Nx0yFYlEoq7qLJpYGuIWGS
         UDuJemo5lXgQ2Lalr009Ii45kmOTT/iW+QQvYRjGumICcyb1+pqO+FAXFetoAN/L+6yx
         T9lKt/meF473hgPsb1gUT4V2Ze6rlvTNljWUczVirU9VPn9lj3msQwmlaDebXkwnFOdK
         cJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454383; x=1787059183;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9EiAa+Ogugh4b+2lwzX2umapF2/7iRJngWsrNV0vO3Y=;
        b=hzNEWhvJyF3+j74vsgaFJRpttJms2QWGl738CQ1M5+24dYPNYkstK0CZgFRtFkSxnO
         bTx1afZlp3KQsKb0ztWIWT05HAVQPtiZJkMHWO0yAHVyiLX/Gwr1yMHfx2yKmvkv2lVp
         rXtNBVWAhTgurHCo/lOpS/ps1gbwGF1xLly45C24vb0eDNbltg4qQiElVqe2htXiX3Yg
         L0j/H/pwNrxvixVBquilPvA1X3U0BYT2E+YoYJ4d/9DYHFs8WJVmwzGyXPtJuejLpZCB
         S0y66WdC7A1i9HwJx9KCcQjKxwrEQ5cKP7akTu/YEdIJ5k6V+ZnJOHFk1JuxHJlbaNpR
         r4Fg==
X-Forwarded-Encrypted: i=1; AHgh+RpF1CimJNMH1oSL5yXP4erc8K59AVZEKBc7t6Xhe8HZQAEDmkNMgQURyQmlBrOLW0kuEjM5RNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8sLjJr7A5okiaZBmVXwSjxtWfKt3dliY8g7S4CTqgNUHDiBrj
	Bd4hv4eX3VUu0M7jIuzxjk4B9HjqCuCGinXX6arLOc7TymP/n6/n95ZNHxhocJ4qqHgeR5/srpO
	chPy7YqBOYt4hesGDL4kiOyEYP/MHqMc=
X-Gm-Gg: AR+sD12LxFZjwyCKS8Ra9Ea39kLSsQxzgRTRz2jcdvhHUuf/rirmRLM7r68D6Efb7fm
	DcsYe7jr2RZrryejoOED+b9Fk76d5e1Z9qhQ6E1QNPlqxQqEwql7mHt35ZX5QmwJdC6Dcs8bkoC
	5CnY5wZtXGx7pn80WE3myOE14UNzLB30Jh1LEwlNlmyI37DBpQ6aQUbc58GJdhhGZ7vcTyU8hSn
	hwG2rfp86foMKRmYhsTcEGCYigiYvjHhPob1nmTiZhyL8LpuZNGQxMKfaB6Z2BJEpQWbvteL+Wg
	0w/dI4AVwjrz7pQBDL3Dc2EbJL4hIdQz9DPQfSNnhcAKHw==
X-Received: by 2002:a17:90b:3912:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-392ec5a8214mr3305617a91.16.1786454382682; Tue, 11 Aug 2026
 06:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806073119.387-1-strst.gs@gmail.com> <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf> <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
 <20260806124313.see74vgu4dlqqse7@skbuf> <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>
 <20260810120821.lykofvogbrn2y2ps@skbuf> <CAAsRjRn7qFWy4UBL8tWGQ9pBo5q3du4e=tU9gSKkSSd7K3RaDA@mail.gmail.com>
 <CAOiHx=n43MPXKxA7oxBjGh15pa4Uh5etxkPdrV+0GxACEnrRJA@mail.gmail.com> <20260811095828.xwb4nsmx74wtzjei@skbuf>
In-Reply-To: <20260811095828.xwb4nsmx74wtzjei@skbuf>
From: Semih Baskan <strst.gs@gmail.com>
Date: Tue, 11 Aug 2026 16:19:31 +0300
X-Gm-Features: AUfX_mzKvyvwoRjhsGg97q4BfFxaBLqDrjKwl5fCuHuGmIiSf6HKuVVH4HOUOzA
Message-ID: <CAAsRjRn0LNMspFCbi_7QMQsNPBhMXeAZfcvrc40k-Y87F7jHmA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> Then I suppose the VC4_ING_VID_CHECK_MASK affects only what happens with
> VLAN membership violations (i.e. VTABLE hit, but port not in VLAN). Thus
> it does not influence the VC5_DROP_VTABLE_MISS=false case, correct?

Correct, at least on bcm5301x, and this part is measured rather than
read from documentation: with VC5_DROP_VTABLE_MISS clear, all three
VC4_ING_VID_CHECK settings behave identically for a VTABLE miss (0 of
7 delivered in every combination, standalone RX probes from the
measurements behind the cover letter). Whatever the check field
controls happens independently of the miss path.

One observation for the "is there another bit" question: on my
BCM53011 the running value of VLAN_CTRL5 is 0x10. That is bit 4, which
the driver never writes and has no name for. I do not know what it
does, and it may simply be the bootloader default, but it is a bit in
exactly the register you are asking about.

> If customizing/unifying the behaviour on VTABLE misses is a dead end,
> could we consider an alternative? Some switches support having the
> VTABLE enabled, but ignore the 802.1Q header from incoming packets
> (thus, all packets get classified to the port PVID). Is there any bit
> which achieves this in b53? What do VC0_VID_CHK_EN and VC0_VLAN_EN do
> exactly? Does B53_VLAN_CTRL2 maybe have some useful hidden bits?

I cannot answer what the bits mean from documentation, but I can answer
what they do on bcm5301x, measured just now with two external endpoints
on two front ports of a vlan_filtering=0 bridge: neither of the two
candidate bits gives that mode. With VC0_VID_CHK_EN cleared, and then
with VC0_VID_HASH_VID cleared as well, tagged VID 100 frames still
deliver 0 of 7 to the far port and 0 to the CPU, exactly as at the
0xe3 default, while untagged traffic keeps working in every state and
the default restores cleanly. So on this chip the 802.1Q header keeps
participating in classification as long as VC0_VLAN_EN is set, and
clearing those two bits under it does not change that. Clearing
VC0_VLAN_EN itself is
the earlier thread: it works but costs the VID-keyed ARL. I have not
probed VLAN_CTRL2 for undocumented bits; on my chip it reads 0x10.

> How badly broken are the configurations with only port 5 as CPU port?
> Is other management traffic like STP also not delivered correctly?

It splits by the port's management class, measured on the RT-N18U
earlier in the thread. BPDUs ingressing switch port 0 reach the CPU,
because port 0 is WAN class and its traps go to IMP1, which is port 5.
Management traps from the LAN class ports 1-4 go to IMP0, which is
port 8, and are lost, because GMNGCFG has no "IMP1 only" encoding: the
driver's OR of the field mask programs dual IMP mode and port 8 is
down. So on the in-tree topology STP is broken on the four LAN ports
and working on the one WAN port.

Best regards,
Semih

Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116548097B
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792233467; cv=pass; b=hukiTPOB72J/2al2qs+VOEAFf8TihDM2DSNuE3RJ+czds9M24L8L3uryzmsv83+ppO89zk2n9+uSFemP6yMqIwmAloAU7D0tuDFdflgkzZvcPjBDOq8sw50DodjAh4IS93J5aEZbAvmuA9RN4nc0rw2SHTy6LmJ0eAKst43XEaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792233467; c=relaxed/simple;
	bh=DdTRwYsOyMO2Pon1eB9HGGKKuUN6WYiZ/XENSt+d+ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPndJb7fmzGby2U/AV1A5jnMI5vu4snvR155S3e7WZyXii3mUepysERzhKqJkX2UmOTIzrcordP6Sl5xQcRJIT655uwBZm814+khCcC5A8+hPHK595zS87v+ou5bQXlSFoeUEEY9EUASIjTX9AR+q4hSwVP2YfQZc+hnXZ/TBaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=Gz8k7RRe; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="Gz8k7RRe"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6798eb0d13fso572787d50.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 03:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792233462; cv=none;
        d=google.com; s=arc-20260327;
        b=mqdKEydUSNB/4dSAMd5iaKcqCZ7fYzd9AoLgIdY04h4LImT3/R//ropePhVHVY6ewL
         Rq1SmxxaLCbz0G6SGccq7YJJW31bd12Qjv6BGHLRSDeJcVcb61gqOpVB8WlvumJPZMmH
         7t+858kSKzO9IY08MK2WZlxghso/n075iV7vD0qcMjxEKa9UYAr5IYaIiPJ/L5+GGZ/w
         ojZgNFFIAvmepNJeUhL2sNGmmgJwFDUdh5pbZbhDIZDo2j0HYHVZrx95M/8wSpQSltde
         iRdw6F84ovhXEVzqYU2eJhfcTSpmzM/8d/d+CQI21Cyk4YqIeqa6K039Bl619F2yXCGe
         ufww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8xQtVA18Ly6EVrTffA/+C9Ju5Q0HewYi23Ad/Eu06YI=;
        fh=iYosurN2bd1NoYUS+uKdahEQhfeL2NtHxyKxBoPdOqE=;
        b=Vcpj10tdxAS7OCu7D1hSBTjXzaYE/tM1ujTk1E4ZAOs9i6yY/kVh3jlaC4eeZ2xoX3
         KxVdTU7MLqE9ziQe1hvzBJ/SZIO/eSxIcZIt0Om00Pevab1sv69xAmVGlV8qbAoBMahY
         Ox4BtsKmYa74ERAICDwmJHBPzo4OpymezR2cAtiRvKhpSKEWSWuADLQBOn2C/f+fGlk6
         1JOHlMEff1UuiADOw9rA1z+iAPfvv+gdU0lq6OF/ykcQXDtrIESermNySkbFsE2VfE17
         Rmhd0bsiJ27F36dSUBeY3nLcJZVbEjayoRj1l2/W1HPVC8KtmjxGEhPaiWer/rplZUO1
         W6yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792233462; x=1792838262; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xQtVA18Ly6EVrTffA/+C9Ju5Q0HewYi23Ad/Eu06YI=;
        b=Gz8k7RReE/vgqJIU2IlmmvzZtxgqj7Zoz1Pqg9mI57Ea0Zjc9gnNpvTRM8DDyEByI8
         KR4iQRBvgZjjOWswddPDV1Tl/sWmckZUrR2NlxR2jl42h63QQUetaHO6ieZGz/8wmWZ3
         MIMzj31omne/mFjOOAKGgAvjQvM4c5omH1sOhnT8KjKTdWh1dAQoSfuwK6uVJCwBNqPh
         T1TQ6e8QIYjRj9JeRF+24xakerjrFEM5UAcQ4d4Iy3cwyT2oKVeqH5JvCYZfYnk3oJYk
         emC21QpdAUUd5mZGxoOv7FN+tsAPAl43Cx/+SW3/XatAAY+2Jukl3l07heiWDmO3MnXX
         02UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792233462; x=1792838262;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8xQtVA18Ly6EVrTffA/+C9Ju5Q0HewYi23Ad/Eu06YI=;
        b=0CROOYrlKNOGmadhssj5Ox7vxF/607j/r1q4Z+Dhc8L039FsRuZn5KSeIpLllJILKi
         ZdwdzaUrcPMrueKCysVA5edLSO6O/AqduaAW94TaZXEEQWyOo7ZOviTbNRXTPKm9x2TS
         1xqqKIuLemKtp+WMTZuBGaY1F8XLKdJhC3PL9kczfUg3UN4nvl5xe957ByrghDOmjIGq
         tAJoDZYRgAhWi0KoP4A24KBa9aEdMa9JYB7BdsnkwbHFPpQeaDQx4hE6zfAbrtg7c1IC
         myTOeFut5bXG77e6SGejQCLd7UbvF39NdpXFRcexd2gaOweW8M/0LKy6/ymAC4Z/JviH
         eb1g==
X-Forwarded-Encrypted: i=1; AKwUvBy1Ye8Bi+NY/ebTt7LH/UOWqGTdGSwyNXzYxqvpy5duTxTYT2dnr/GdGG/joK1z7LesyI0JeVM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1nANtjaYgiDsWvzeCJFMA0iVLxSfTD79oSuEs4rIHkBAqSDiT
	caYtqUKRwTNl49auYoFnZEzyei3l/X5hkre3LR0yA5THBB7M76PPYlOpwnQt5zWr99vzq9+slfK
	PyOPOfybgjldYoZ7haKwQHYVDNibJCgWb/L43o9j1
X-Gm-Gg: AYBFou2bWACgtRZTcnyNu8eXWby3RZznp+9LdVtVX04a1H+ZuvTuLHuQMz1Qab5QJmK
	XYEGUiQmslJTaKRn/46f5++Z51EEioU0bzgcvzCKQR7sA16ycJw5dYCTxKjQb4cdJnIA98Mz4kA
	Yz/h/C6Rbg8HqWvd+6NgshhzqQnOj8UWUAGfv692bxPhovP8R53JycFHoElfkTMtpZWtfqFvuqS
	xvYyFjN9dqOuloD6yIrOSKuUStNa62frqhkxm9fvjBIMltutoFZEpHOBuqfjMOV6AlQYJThEa62
	PddPU9NIg7jJfmPBtVpWrHbISmuLJm+Fv4kPSPvGsMxy3CYHQP74OpinXPUxwrdOELihcwMV6gx
	FWHhSD7waqigxPVsoG8T9lMTMnMVrpLW2waWXTejqhaq9bhGze2k8sKEwsYtECma5nA2Mt7KMBz
	L4OoQzS83k/6/59Ti+gglonWlmeYPo3BQBAu1BP2lZK+I/96GcDSTK9z2d6YhVDiGyuJW098ejR
	z7hQjwjfRusBBDguB+wygB84nRK/uKffk0xopjbcR2Gc3AW5buZCZCI6bmG/AtP8WoB+Wz91oOM
	4yO+JpE68Xyqpg==
X-Received: by 2002:a05:690e:1913:b0:674:981:a937 with SMTP id
 956f58d0204a3-679ca914780mr522735d50.121.1792233461776; Sat, 17 Oct 2026
 03:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004171616.3544880-1-julius@bairaktaris.de>
In-Reply-To: <20261004171616.3544880-1-julius@bairaktaris.de>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Sat, 17 Oct 2026 10:37:05 +0000
X-Gm-Features: AclHuK-ma-16nXT2QPoniX4Y6rIglK1_-HkBDcD-pfQT-pjJWoWmgSkOWis1dDQ
Message-ID: <CAC1t37LLnXEaD2YDSj1iBBxezSKjHGNqm_AR9G4s5Nhy_O=9mA@mail.gmail.com>
Subject: Re: [PATCH nf-next 0/3] netfilter: flowtable: update upper device
 stats in the fast path
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, coreteam@netfilter.org, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"

Hi Pablo, Florian,

gentle ping on this series. Let me know if you'd like anything
changed.

Thanks,
Julius


Am So., 4. Okt. 2026 um 17:16 Uhr schrieb Julius Bairaktaris
<julius@bairaktaris.de>:
>
> With the software flowtable, packets bypass the bridge, VLAN, PPPoE and
> tunnel devices above the flowtable device, so their counters only see
> the first packets of each connection. The classic forwarding path
> always counts them, so this series does too, without a flag.
>
> Patch 1 adds VLAN stats helpers; it touches include/linux/if_vlan.h, so
> a netdev ack would let it go through nf-next. Patch 2 updates the
> counters from the fast path with the lengths the classic path counts.
> Patch 3 adds bridge, VLAN and tunnel counter checks to nft_flowtable.sh,
> which fail without patches 1 and 2.
>
> Hardware offloaded flows are not counted. A GSO packet sent through a
> PPPoE device counts once, not once per segment.
>
> Cost: struct flow_offload grows from 296 to 328 bytes (slab object 320
> to 384). Forwarding from a bridge with a VLAN port to a veth in an x86
> guest, mean of three interleaved runs without/with the series: TCP
> 55.7/55.0 Gbit/s, 64 byte UDP 177/173 kpps.
>
> This series was written with the help of an AI coding assistant. I have
> reviewed and tested it.
>
> Julius Bairaktaris (3):
>   8021q: add vlan_dev_sw_netstats_rx_add() and
>     vlan_dev_sw_netstats_tx_add()
>   netfilter: flowtable: update upper device stats in the fast path
>   selftests: netfilter: nft_flowtable.sh: check upper device counters
>
>  include/linux/if_vlan.h                       | 36 ++++++++++
>  include/net/netfilter/nf_flow_table.h         |  8 ++-
>  net/netfilter/nf_flow_table_core.c            |  3 +
>  net/netfilter/nf_flow_table_ip.c              | 53 +++++++++++++++
>  net/netfilter/nf_flow_table_path.c            |  9 +++
>  .../selftests/net/netfilter/nft_flowtable.sh  | 67 +++++++++++++++++++
>  6 files changed, 175 insertions(+), 1 deletion(-)
>
>
> base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
> --
> 2.53.0
>

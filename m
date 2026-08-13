Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585333A872C
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617563; cv=pass; b=bHXrj+L2k4//Pvqfdmjncy8ogLB8BEltQFs2bWEk6ijAvIJym6CzlJoILfg4rWsuFNtU3ZpbplqoMihreP94+tZEnFl6qPMbe+HAPy3ppIAsa4gqXzRLNkn0dkyOUomL4dLFAZoSukdXpUB7hqpGi4QEP3pfvUF0AAIEcgruVi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617563; c=relaxed/simple;
	bh=LxN3GJXKtM1rE3GONf+cApOOqvprGn3a241qh/akkeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEaV265kUtScPpDfWze2RCL5kjqQ0hUQgsmwV8w9fJ2o9wJdV9Sse0ZA4+ZnlAkKOxerwpBrspe9vHdSDpROCIGm2s1QM0zQB2SKIkLB6B2V4iehJTeY5pihrEBDiH4wI9cKTu2IAhcMjoEANd45dFGXWCDNwjuHdvJPhAcfb5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rodXrPwR; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rodXrPwR"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2385065a91.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786617561; cv=none;
        d=google.com; s=arc-20260327;
        b=Hn9CJ0tCBupEk7hr0IpS0Q7O/p2DBetXskmKjVFpg6d0SnsoJs0Qc+Tl7nljwdfZ8Q
         4Ph7uaWVmwTLo0kOaFmweEbf1tPC3rhJdOcFJ7yS+lJAGMq9rP+kQLXU12IDhm0Vi/8R
         ZPq9sV8ErshC0clMOWjRkAWKNBWiV2eWuj+e17dlTzit8909nmRtl3mxPLu7kEpLrGaJ
         pluW/KEdJSXxg918vSeuT4sGR6EJ9OijIGVys4lKiYH8KBHd8waacegbmpqDDpITFMS5
         SOI6yeaUSN2EmMUAswDmc+IxGcZ4kzIHI6Av/TInAVZE10Uiv8mD7HbtFLktTJLUM+m3
         pIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uKpopVkmCHWz5eManD/zMgSNkvMZCZH28nRQJUqXhbU=;
        fh=aX0wZT18i3ZynrZbfKQvdgS0mwC0xcB6XBM8fdFE2RY=;
        b=j7LTSdA0sXcWN2Ms+H29oC1xMAbaLLQUXZYv+sZO+LtsfmeLgOXSRdDftQqZIEZGmn
         LSO28f+gG2Su0z2h/9Ge79i3xYbsRm7HZS5+nGOM4W8/ff7ZNGyZpNV+r3xxsZw/ahWj
         nbuCC+yN1NH4p5xma6fWr5TaZf3+8Ee4aFID0Kei2mKERrRJiJzkpFVbbDkjeV/rwj4J
         9D6EeJP4b5n7wk91ANmqBniq9sDSyL4lzJB+TkvpCFB/m5WL/zjKR9lyH/St6WR0TbiW
         6n41HoQT76zWPzIY8n0MCTknXRuo+5xTgN0WZ8r6QZtFLRdXyVg6PD1biqlp0ZGcYPaJ
         QquA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786617561; x=1787222361; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKpopVkmCHWz5eManD/zMgSNkvMZCZH28nRQJUqXhbU=;
        b=rodXrPwRaqfRP340GscKJs6IZNvyq5E4yivYC3/nxvUBkV5XlGQjwBEfNTg6zRrklZ
         4Q8sBN3F2m3xavoABAcaega0a+OnNUiNSRD4C+o4+YeitiL0VKXUIGlt7v36540h1D6N
         QDPfUZaSn+1v+CsdQtc1Yjbla7sqmFw1pQ2VIUeUp1NWkqARNmoYNKHBtX2/6Jcl/wik
         PUBFk+pV/tvYYj7BjhEJDtv3+mJFQ1qF5AXdpZhuY66xEyueLfcC+0CBw4mkbKCOxaHs
         ggD2GH90CFqmSLwth2blgve7GZ+q/c8dL0CAJCdRL1mekfrD57yaGnDO/CMieh1bOl7O
         U7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786617561; x=1787222361;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uKpopVkmCHWz5eManD/zMgSNkvMZCZH28nRQJUqXhbU=;
        b=O2NzjDjyHnREuuXJreEXvYKAtsFEaKVHrtRniRm8qW9HR5amTfV4ghv9iS0YAN9YwO
         NqQFtUSie65MTleJtL0TlJekOLn75XyBs4GMqYn1hZ7dBmeOFoYVg954bhBJeDFV1qj6
         p0k4sfxnnC15rLTQQ4I4I2BYjSwP0t8c0D85nHmGs28T1jsPq01KOC7sMsm9+ohv0hOW
         sz8joJQBFtoANLZtazmaGiD/Zf6AFOgXvukTXpYxB/b9msPn24c8oM+f84kTYJVCtjpv
         B5TJ3IAzd9Qdug2Hc4G4dvTD8XjkzvtzlnlKtVeW86wQfWmZy6yBM5RN4fAJPEwpsyPi
         xp/A==
X-Forwarded-Encrypted: i=1; AHgh+Rqgq73Px0MBciob0AkfN/Ghxuvhe9+TQ/2Pgh8MhIEO3RaNo8QYp2WvAaLTXnHHH4qoYUbSbfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0EZbyoaY5Kb7zRVjhiTJlQL938FqW/L9rsygPC5EviNnLnNDW
	2bR7UJ5ZechiNtHTqoDzXWwSzmm2+gXWrUQavKkdqO5Rc2Mcf/7/pfVW1h0v6my8FqcQAkeYjyh
	GT8AAaUA7F5tn4NBzILWWXz5qelai4yQ=
X-Gm-Gg: AR+sD13If+oTWtqfHNeIBo6pm5UQjSKRRHFobfXxG+4gr+ZRs6MCCfx7cVlgZ5YFT6M
	G8rL19q7kT4xWt9ETRIb6bvMC/DGwf5g2lpHjCLfSg+KGhmtsUk9DtLjsdLe8UbMD0UoGmQ2A8u
	dynWAiZ8fpjnQWmYsjfVWkqB4hy4M8QcSLZolgORRJCLeWO2lafIoemcfqpnwMskm6miNX8X7h7
	eAbgyUrcauf5KSU5w1i9MYRjX7eN3zp7EEXMviGcoyjc4GRtb9MdMkO59swd0BWKDFrlZ0Myb9C
	f8V4v1j4ZtA6RN0B1Y6CtBXQFDuvBAU8IT0nnYL88fbAgg==
X-Received: by 2002:a17:90a:c110:b0:392:c868:35af with SMTP id
 98e67ed59e1d1-3931e2c17f2mr6330788a91.20.1786617561588; Thu, 13 Aug 2026
 03:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805072641.402-1-strst.gs@gmail.com> <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260812205047.ojq2yyjtmoe5gjot@skbuf> <CAOiHx=kKoZrZp3=o1kpH5ueSvfc+QLSu0GF-noCa7LPQnSQbbQ@mail.gmail.com>
In-Reply-To: <CAOiHx=kKoZrZp3=o1kpH5ueSvfc+QLSu0GF-noCa7LPQnSQbbQ@mail.gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 13 Aug 2026 13:39:09 +0300
X-Gm-Features: AUfX_mwTPb0Y0x3HgHHo33Ekg2exHaAljj80x6C4fQSZu0-MA_xhQlDOKYN0ZCg
Message-ID: <CAAsRjRktfP0gM4qe0d7gtRg_oQXUu4FFh4Y9Zm+bRHL5Ow7hKw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

On Thu, Aug 13, 2026 at 10:08 AM Jonas Gorski <jonas.gorski@gmail.com> wrote:
> Right, that would be the quick workaround to allow functionality. We
> just need to not mark them as forwarded, as DROP_VTABLE_MISS=0 will
> have them sent to CPU already.

On bcm5301x, miss frames reach the CPU only with port 8 as the sole
management port.

All measured on the BCM53011, DROP_VTABLE_MISS=0 throughout:

- In-tree topology (port 5 as CPU): a tagged frame with a VID absent
  from the VLAN table reaches no CPU port, 0 of 7. Already reported
  in the offload series thread.
- All three CPU ports enabled per the in-tree bcm-ns.dtsi, with
  Rafal's V3 patches 1 and 2 applied so DSA prefers port 8, measured
  yesterday: still 0 of 7. GMNGCFG reads 0xc2, dual IMP mode, and in
  that mode the miss path delivers to no port at all; bringing the
  port 5 conduit up or down changes nothing.
- Port 8 as the ONLY enabled CPU port (FRM_MNGP=0b10): miss frames
  are delivered to the CPU, indiscriminately.

So a software bridging fallback that relies on miss-to-CPU delivery
works on chips like BCM63268/BCM53115, where you measured the CPU
copy, but on bcm5301x it additionally requires either a single IMP DT
(disabling ports 5 and 7, as the Netgear R8000 and Linksys Panamera
do today) or driver code that forces FRM_MNGP to 0b10 when port 8
is the conduit. Rafal's pending "ARM: dts: BCM5301X: Enable extra
CPU ports for Netgear R8000" re-enables those two ports on the
R8000. On the port 5 DTs it would receive nothing.

Best regards,
Semih

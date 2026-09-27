Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48C315D53
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541436; cv=none; b=gwc6y7/WyvJDIH2A6sJX5nlGdiACyXSkfWt2qNfNrbb45ULc0PClO4Qo7sAhTNug31r4hM58oJkacScbAEEKjGNs75snhWDe4h6x1xmO/cLvrVVFkxr7j5VcNOQKQsHpW2Fa0+KNQra+SidS1oFKalPFqZ5/OFLGU0ZVEcrz1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541436; c=relaxed/simple;
	bh=oCr48qmYE8TlRfU2x1ehdZeec3vRLgFXFPx0WF6/6nA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ki5Ow4nVSU/C0uq6XLo8BmlTaudE3Nbd+1VPPXRuFBXGdm0ZJS6L/eEz17gRNRW782o1CeAgO0R6iJN93AbT41hWgyZlp3xAXZidSqImknClEGbRGh91zNU5ftBEVcsWgpJCSFgUiqosOhBljnSw2TSx0/Qki7kGjRCHlW5Pq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLWF6/Cp; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLWF6/Cp"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895353e9051so19439857b3.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790541434; x=1791146234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oCr48qmYE8TlRfU2x1ehdZeec3vRLgFXFPx0WF6/6nA=;
        b=NLWF6/CpSpJ95lUKKdH1OB3YCB7YF7YIolXN/HqILBKgqcRjD5+xpLQUmzqfE6Zo9g
         /U8WLtlC24k/N87qT+mauLDAbNO994GbyovBMgHi9xaq8MR35qzb/vy+s+oU3ohHqqpn
         nt+wwbXWDBjdKhoxybHv2zruO7jW7CeN4IMnCy0d9E03RlzxXt4gaqOznYaJvyKCYw/m
         xgubuU/3Mz0NkdzG/S1EFAzfGokCnbrfc3kd8i69AyX/bBT4vFI0E1tTBlxDM5EyYCT8
         lpW8JoHXTgWTZduYCR5WkEit8Z2S5X9ZERj+GW20bR/FzP4pzphKWq66ZjlrO0fwOMli
         QuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790541434; x=1791146234;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oCr48qmYE8TlRfU2x1ehdZeec3vRLgFXFPx0WF6/6nA=;
        b=moiJaO/aok3Lwb0/80eI86Z+lr2zRE/stO8Yy4hrUSUvjfx9HIWG0lKTLNJFM7Va2J
         5xpG2CFDxv/KJMjeMvyEGJM09jVrPyRUzATBL7SkDuxnzNGSQ8KwJ/PYCHzhkqul7wed
         B/IOdNPFJrk9yKIyJ3tLuli2P3zCCGnj8zCNiLoz25JdYIEY1p+7AF685BQE6LCtaSgm
         OPhtinF6aFVkqqTz3G4DFjl4ebPIm5l3zomvWcI3pmfrzvXANQA/Mei42I0wIlXE4bIK
         PS9h4OPD+BzSmYIW+a0EK13JSHol6256CqY2Wkbyi6jtSKoPreAGmtRGNHGWUJza0wT/
         MVkQ==
X-Gm-Message-State: AFq9FYKvjizl/giYq4+SEEs2cioFFPSYoW0Jd/0YuhP7R+44tzuWkMqi
	H9CCKTAGLu9xYpv6yU4Cl4Io5GkUmpJp/JQ+6rnfygR0pJ1XZ+wSl3tRyRRdfw==
X-Gm-Gg: AYBFou2drfVTT3QkF4KEiDjgo0oJ3UpbNqq4WJrHnIHZoBMw3S19SPMjjYNBya0o9pU
	e0D0TrM2iQsblA4LPUJZauVD5tNpmrVXBcuL76ti+dJwhsb1zNbVBWJ3OhvIyIQDxjRlN+cECTg
	p6mkaKqz90gNoL154UG5TrJKg1k3Pk02Va5mXGFgjiQpe56Hg5qdnbuC7YwpqyOu1tQ9nrsq84Z
	KVqIO71mHJ0Rfw06WJcLy1/lT0c7nE4fSD6W4on+LJCgeQ37XWPNdvtMiV0hi6siGqCR6z21SmD
	Z+yHRyZRzPtGy5SPnFczQxtcqnIQ28qsMOeY0+d2cxlZgWUhlXYjN/O2A5kb7AUOBgSEZwor1si
	WUW06s/OrexDJKPR2pqRAD77hvV8UcqqKLdSjFe6iqZVSGVZhbv10HZPt5zC6Nv3AScpJ//6SfE
	BWlkShvFTd9fnaS+zL4hIV1xdup9v7J33qgYx15nPrEketSkMnnf0bt1zjhzOhPzb14rJVkCCuk
	ZEx2Lm06F4erppTIqdescgMU8GsSXatNS1jmG0Zd6HGyUTt0iTW
X-Received: by 2002:a05:690c:d94:b0:8a9:b50a:bafa with SMTP id 00721157ae682-8a9b50acc84mr15470757b3.55.1790541433683;
        Sun, 27 Sep 2026 13:37:13 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a86100263dsm35018497b3.35.2026.09.27.13.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:37:13 -0700 (PDT)
Date: Sun, 27 Sep 2026 16:37:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?SWxra2EgTGFwcGV0ZWzDpGluZW4=?= <ilkka.lappetelainen@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 security@kernel.org
Message-ID: <willemdebruijn.kernel.1b973fd535145@gmail.com>
In-Reply-To: <20260925124829.6595-1-ilkka.lappetelainen@gmail.com>
References: <20260925124829.6595-1-ilkka.lappetelainen@gmail.com>
Subject: Re: [PATCH net] net/packet: prevent TX_RING byte count overflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilkka Lappetel=C3=A4inen wrote:
> tpacket_snd() drains every SEND_REQUEST frame in a TX ring and adds
> each valid packet length to the signed int len_sum. Userspace can
> recycle completed frames concurrently, so a single blocking send call
> is not bounded by the ring size.
> =

> After enough successful transmissions len_sum wraps into the negative
> range. In particular, 65536 65535-byte frames followed by a 65007-byte
> frame produce 0xfffffdef, or -EIOCBQUEUED. sock_sendmsg_nosec() treats
> that as an impossible return and triggers a BUG. On systems configured
> to panic on oops, a CAP_NET_RAW holder can panic the host kernel.
> =

> Stop before the next frame would make the byte count exceed INT_MAX.
> The positive short count leaves that frame pending for a later send
> call.
> =

> A two-thread TPACKET_V2 reproducer triggered the BUG on an arm64 build
> of Linux 7.3-rc4. With this change, the same reproducer returned the
> expected positive short count without an oops.
> =

> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Ilkka Lappetel=C3=A4inen <ilkka.lappetelainen@gmail.com>=


Reviewed-by: Willem de Bruijn <willemb@google.com>

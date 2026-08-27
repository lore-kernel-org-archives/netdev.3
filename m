Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2BF432BCD
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860318; cv=pass; b=pA+pps1Sfnv2+/DbMEL/A4ysPuKJkBX3z7KL2ORtJBhquCMw5nqOnjeWhoAWEzLbe//+RY3ezzUZjn3kN9hN/TDtBVFsJbNEr80ExnP4zu6mX1NMxxYnBOD4eiEiEU9SnMXA+QLH/HdPsQwpkOcCoRz7V9aWQi3zjB+2xu6QpJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860318; c=relaxed/simple;
	bh=LgsQ2Jk6vebxd+VnjhN83g9OOGJBDaYEmZksFSbG534=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJZXNkk3A2PniNnxpLdEHGHJgzEryjGU2NGf55C8ZlMSHg4lnFmik2ZzqJtbMdVWAmIqt9dzXiXX4ACe+QtTLSjWdrycm5330Z72zehbxMd43vy/QbBj62vF3m4iVAgQ3oV72DdBaSA9YNOnz4thavUAjJJqxP+JyNHfzKoUP0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vv+MeUpR; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv+MeUpR"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2531f453eeso45390066b.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787860312; cv=none;
        d=google.com; s=arc-20260327;
        b=OfiO5+U658DGnakoGpIf3t8UMK1G6EuGZKSrm+6NAnB0Ydxej67ehqwVVG6ptiYkO3
         r8XMts+IQgGH67RQvvpvwWyO4MROSxfyoONH06Oa4MR7wvsw5MiYTLWNTEmZ73fXbElq
         M2orivsXuh/ZRk8mqLHljJH6/JmlOnOM6OhtvaOffbWAIF1XylkQu0ape6cS2JMSq9RK
         W9Zmj8NTgY/+Iu7RRH9sEjBKJsdmjgmcHn8L3iGnTLbb6N83vENEDKVjGqplGfysjde/
         kn14M8ZrYONWy+ZGYIdNS5n1iqO/jxYuTwM555HP+wBoH6aPPgdvsVxv2QClVN8QVnoS
         N4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LgsQ2Jk6vebxd+VnjhN83g9OOGJBDaYEmZksFSbG534=;
        fh=06cT6OzFqvNfptc6Oaj7QL7A8r9R91Rbn61+wC/aYso=;
        b=KGjx9s2M20lqUIbRvzgXN5RIIottrXH4bC/Y0se+AJHl7S+VZMmfxPFdE9rA1iY8pG
         nyPsY54BREfYDzRsYA34+h0CtOa6fCapC1VmK2MMsVLO1RJo1AeFGRRTNB2OVSTndfRL
         f83Nh/lWa2w0Pu8qVqOaElnhq9A2Ny1XQ03aMXrBkovq5jXFkUkmcviXcjmQJ7T3xbi9
         YAc9hrh/EFqRvBP+C2LW3lrrnVW/Z1NqDlEZT9ERt5CCNtuWuxtVnKvlhsIjFVySZbk+
         ryBAbOl4ZzMjW8hGxToSRJXhQ08Db9l169Tvawe/ymVw+44zn2F9nMDXu/XhBlw9PtM7
         nKyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787860312; x=1788465112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LgsQ2Jk6vebxd+VnjhN83g9OOGJBDaYEmZksFSbG534=;
        b=Vv+MeUpRuWDbm8h1hXmlQOi7+RYX1gL4+xeXqhhYZuDkXjlraqXA6oaZaL8duj1PLd
         MZdRwIDjgX3u51nZ+aQb0LI8TMzX1ZiEsIZN1WhLqvTHfetcNShX1iNi2aBU3tDWvEp3
         koQeufV4iB7+H0Y+VWq9JLXALApusw5ekYTT2GVD2bbdl8eT9HlLrDGuJwsXxggojlg+
         2pbLV29VFTCz+SUMF7NDsWh7H8uQNXFiYIg6b27UwwYAFFa1xX9sxDHL7bj6QlcekXpA
         N3TXeNNpXcn7djbHbfQxn0jADQN+fNuVaLFV0vH4VUn4K1VivRqNZdZF6tvOzl22MF3k
         AfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787860312; x=1788465112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LgsQ2Jk6vebxd+VnjhN83g9OOGJBDaYEmZksFSbG534=;
        b=iZhZEMRvMcsu+bdao2PQa3+k1dAUpx3d6qzLNy5BFFG/U8SvZ5P5NuZ3sP6PhP90mS
         rI8lM3PwbOZMugmpFcF1VAL1Pm1htAcgGzzoefEqBwQzSNYo/Ihbsh9YkKAGLAZkSl9i
         rJDLGSF5TnNheIVgthyFmEsI5aBtGNGxPoUwe+UykvLYifAT+5FqMlCbbzYyx7BlPdsq
         leStqfO6q0umu9xXoQPRwvG4D4mesTOYS52KH+qujS5cBXEbguIzxj62biCGJZaXmDek
         /GwGkmOgj+qzkjPqhrBVs04E0fRX5A1UxOgv6Hb24P3nFHTBfu/2BoBQBAuWEYjAg5YS
         XhPg==
X-Forwarded-Encrypted: i=1; AHgh+RoWBOS5USpwJuwrKOqJb+ZQk9alC1KnKkTOhHbgG9BHkLmgjYmtrs3OnhXgQvmBMh/HsgVnx10=@vger.kernel.org
X-Gm-Message-State: AFuF++lQZY8s+TduqN2N6HZGeBjF8G0xJNLahNVhsOh7HgUZhI9Pdvk7
	2sVRBMMtGLnD4GWjk3prq+3lnTtidpMNtVF8AD9WhJ+6P+B1FfoyRNGiyRJnvJc1o4Iiqkc+zyG
	2UbhETHu8U77EW5Gf9+3iIA0ekw8Ykkc=
X-Gm-Gg: AR+sD11ZgVF40lkKZVK2kwx/0HCLRnlLmvtLJQPYeZPVFaOWitodKwkxoFhToApiAJJ
	nMXmdgiC9k6mPHroQX8hthRpW+MRlQPtvGadlxHr+WbPH/+oYKGIKhJSPr2ce/q2zGT8W0oGyTp
	2Bos4cdg7WvVbVzCze47p3Qb/6vcaiW2MDTKpn6Izf8UJuMU+eUvrXL2qK+xKlfcOIFiFCadvYm
	cl8fZoiw3MTQZLZ8X4/YJWtyzlGcJ92z4HYXzPGOsA4QiikbDULDbKVI4+Fd8pLtDIuO+luqcYI
	rhFL5RUf5b2D6vpFrGjjCjWE+FKkOchaETgDWWKi/WFA+w==
X-Received: by 2002:a17:906:fd84:b0:c25:2d27:5652 with SMTP id
 a640c23a62f3a-c2557181486mr63937466b.11.1787860312178; Thu, 27 Aug 2026
 12:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810061612.23745-1-kernel@kempniu.pl> <6a79d7fa.ebbd881c.2cd61f.2e0d@mx.google.com>
 <anw5dJ0EqBJtAqRU@larwa.hq.kempniu.pl> <6a7c3b3e.e9cff95d.4a93a.554d@mx.google.com>
 <ao8DqOFZJkln4pvh@larwa.hq.kempniu.pl>
In-Reply-To: <ao8DqOFZJkln4pvh@larwa.hq.kempniu.pl>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 27 Aug 2026 16:51:39 -0300
X-Gm-Features: AcwNN1VL7MyL6EB5xDYfvyMpi5OQ3QxL7EIQtKmK-epqtLbXB6ovgscaDfRIm5I
Message-ID: <CAJq09z4X=RMz3-b7378WBJq3k9EUwjULJ_08TWeovZxFRz2gbw@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

To add to this thread, there are a couple of other well-documented
issues tied to management Ethernet in qca8k:

1) TP-Link Archer C7 v2 (dual CPU ports 0 and 6): One CPU port becomes
muted/unusable during setup when state transitions alter the
management conduit. (ref:
https://github.com/openwrt/openwrt/pull/24011)
2) CZ.NIC Turris 1.0 and 1.1: Internal PHY access via management
frames leaks onto the external MDC/MDIO pins, corrupting communication
between the kernel and the external WAN PHY (commit 526c8ee was
insufficient to fully fix this). (ref:
https://github.com/openwrt/openwrt/pull/24755)

There are also several historical reports for other TP-Link Archer
devices (single CPU port) where ports randomly drop after some uptime,
exhibiting similar symptoms Micha=C5=82 described. At least for the two
cases I cited before, bypassing Ethernet-based PHY management and
sticking to MDIO works around the issue reliably.

As noted in Turris 1.0 PR patch, when the switch translates an
Ethernet management frame into an internal MDIO transaction, that
signal leaks onto the external MDC/MDIO lines. Because the switch acts
as an MDIO master for that internal query while the host CPU remains
the primary MDIO master, electrical bus conflict might break the
switch's internal MDIO translator state machine. Commit 526c8ee
attempted to solve this by acquiring bus->mdio_lock before
transmitting management frames, but software-level locking cannot
prevent hardware-level bus contention or state corruption if
QCA8K_MDIO_MASTER_EN toggles or leaks while lines are shared.

This raises the question: does Ethernet-based PHY access actually
yield any meaningful performance benefit (or is it worth it)? PHY
polling occurs at a low frequency. Also, maintaining a dual code path
(Ethernet management with silent fallback to direct MDIO)
significantly complicates troubleshooting. By comparison, drivers like
rtl8365mb enforce a single, deterministic code path for register/PHY
accesses to keep behavior predictable across all boards, even when we
could use an optimized path.

Given that Ethernet management frames for PHY access introduce
multiple hard-to-diagnose regressions across different board
topologies, should we consider dropping qca8k_phy_eth_command()
entirely in favor of direct MDIO, or at least providing a mechanism to
disable it? If MIB access becomes an issue, we could introduce a cache
mechanism.

Best regards,

Luiz

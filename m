Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792549534;
	b=F8Sf9phBUhbhENhXgutmDj4qMewLPm6MtLtJpSTp/6nwph+3AUli+y0E9T/UAG9JPabJ
	 vHL5KljGwJz+ExCQRnWR52F2FUb5rNfjf8k07CcG9rcryjZgz2NV1F1VehhEZ07rKZ0qf
	 QgBuvINhi/WCH99syiMt7a+b8AuKXu5GINLYsBs/Unolq5L0fpivyfw2zfHUHuB6PWToh
	 GlISctFZ9RDPoA821wV4PwBfsPUg0ISpRHbpPNMGta7Nrz9x/W+Zu03u4vL9oZZm/QKkx
	 9aHs7J+9U4bFHBOHSa4r23DUG1T+00BBKD4BvLQUfFa0M2wrNb/CAbkTKHG5Uvmz59A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GVRjqnqrO1TkJYy/+KOYddRQ6BdsaJ0o8sfMv9oU1Tg=;
	b=BS+iNr9kvjV6DndpIu6/UfKhQjzdZM13P73UollSD94uxBiswiJSedtKBjbnMvm3RzmK
	 zA95gYNY5app2Q8P3ID4flcsPZXixxW31DWEyr1OjKa9VbZB/0koQBV5PGymV1o8gBE+A
	 la6T8/w9jCKeWL8SKn7xyMRkh1qjhCD3UDCVxEoHDN4yM885oj+utCSI1ANH4CgAZ873y
	 oWHPm+3yENBzyn65dXrDA9AWTelCW3BdLEpslR+9dDB6s12MsVLlOiGSB6WGIDhu6qdR0
	 2c/IyKqyB/RAkHkyZzklkrJ9Rk5CBCN4w36PGcYCjVNZALMVZzwcX5QSSd/7XsY/Pwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jlEKSHfU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D747606A31C
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D747606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jlEKSHfU
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3aae7df0971so1943821fa.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792549532; cv=none;
        d=google.com; s=arc-20260327;
        b=NeGFLhX3LKP7RNkWcqwyY1FXgQUc3S4ct8ajq+ti3Z2EUF8A53R7zkMnBIDYLfQ3Ha
         Add/NLk2JQDf8LzBEoPclwa6Eyw1oMjHmRoT3u4i05wbgt6DMABuOZCUoqKsYLXxYV+K
         raCjq3TSNolQ2rFVXTYwKTIpUlI/FP4ScqWHOGMcEFjIA3WRmL4fB9aK+wM/6KxsuSua
         WcisNCX3yfMnw+VP66z/UYiyNRHdE1vi1KtHtyJZio1oGQTcvSkjJhYEu7I/uG5/HY58
         VV12Bd0pu9sDek7Rwlhp01EBhyqKxTgisQU2dGdvG3l36/yOuZXzqY0ZLBEJt07EYg6j
         IOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GVRjqnqrO1TkJYy/+KOYddRQ6BdsaJ0o8sfMv9oU1Tg=;
        fh=6K4D5GiJVUfqI+GORUz7TiXG50EpcNCXUZOu7rZA91M=;
        b=QYL1AXRBQ7KF2slkSZev2JsxP/7kSjmBYgViy1f+kA2Z17DS+r59G9r0FzOOB1IqLB
         QaFjb59JoXNYxgKAfufJUVdKjmw4UPe65v+O9lhjeTj324Uk9KADJGxRFolZuO4DN0jZ
         lIZlr4KUZH1bKHwynAYvfz8MVsvQn1meNNshx7tJV+US4KkOf+/IYPCFaAVt6tHsO95X
         XgUZBGpKN+HCqBLry4ivAiPxTOisb+Hk7KB6PlgR8TksQFXJ57r2E2h8sCB3Q3A7UHv+
         C70A9AuAXGz8ovxTqNyNWXe4AWTz/RFtvajo36uANRddpny9fOOJqyjYBpjLh5N78HZr
         +WaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792549532; x=1793154332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GVRjqnqrO1TkJYy/+KOYddRQ6BdsaJ0o8sfMv9oU1Tg=;
        b=jlEKSHfUzDaU2aIXp7vI+X3ST5g/eOC/d0xVQlixnmhH7uOedsgkpMYdnsRQdN3D8t
         guMQMrZ9GfqdV4kS1JjF6suFiIB6B6a8+lh+TKJs+gbrxiyCb11TWCbFB4XnEM3qkY2q
         BU4vXuNj2RBvutSiMizZQ8is+G4ngrKbdeQcHVxwGxzsSoYltbO4AP7DbV53NHr7fo+l
         zIrsBBO7ysoZo7+Ys/3XlddEqR5X8AulGJGqTBy9uAfnC1okMlyFOYGX/455IPeFNgZ8
         ySN7V+ZRcrcm2e8hECWjYLt4zwCy76DltgONvGmpZcAVaPLkUy6AOsh70je6+TL5+9Za
         d+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792549532; x=1793154332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVRjqnqrO1TkJYy/+KOYddRQ6BdsaJ0o8sfMv9oU1Tg=;
        b=wt+/DxOuXXpCZ7UAiNMlQCjYlaxyKcHrUTRCk+b/EDHtBhN9SKFn2ZvHsNgdu4Omyx
         QyECmDjZZZCUGo0KJVrCDM8UntkY1LjKBcuWuXMPIFP1B9m57LBSs/uakDPAwuei6FaR
         gLozImKAcKuHKvRKGrNycS3wAOhOzuNE/U+/79whzazMwg7JnoKhMDXwB5ueqrHIQHDh
         CpkQCuDcVfeqU+qWFgmWf5M+ADpeX211whijjXGsk6YIQR3ku0SPmdHzLzDE6LkHnsmj
         KuqmZtLYfIhkEoxDfwaBa8arUC6KK1qqS85bKvbfc0ymupDU7ce60W6W6Db8KFMaAkUC
         LcBg==
X-Forwarded-Encrypted: i=1; AKwUvBxiqfojD14cLND5SfbP2NrVlbN8ZrCo4x8el5TcIwj5YRpAwC6rX5WZdx6F/ipOz5WjxVkLLeY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjm+mp6uX+X2rF8mn+MgH+xyLaP8AR5lbdIMm6Zh7J4BXMBs49
	BUnl/iKDVJrBcHs1qgfQWo3vMzOKtZbTgtOubVSFaSPVoCttas0baAZLdiRxIVJijIBzYhhUtth
	6KhKlHt5E4R/+XzIYVNrliZsDQxQFlP8=
X-Gm-Gg: AYBFou1/XPhbYjbMEcDa+S/gN2MY7FTd2HZJoQwlSrKG89aCGPRhhyHhYWjJ/OC2x/4
	8XmtXJOiLa20rP/tj2mZUW5bOmemb9+iGVWcBZp6bGVG+Mhj945sggl/H2MfUpnnCwA45WWi4XC
	yLzk+5O4RIjFheWzZG0xcAml3+o/49QkhY9QUBLUNj6g0d/4l8cbXPGulMW0ktFSsk9o2UeeO7T
	GFkpSDEGtms6cij202icWzikTEHMZv/JOPSiyLl9Hmdkv5jQl3Lr2NM6s/hwOL6EaA1dgbH3PMF
	b8EjLqYWt8Jr27i7Z6oBQT8PeZC94SuhRnlL/d41CqQ5JINPzNJcAuGKpjmn1CM8778YLMX1Goz
	5MV40UORjjH6hUR3D77bI7IJkWEqIJdCZwxrujGyAtyCO6DjJev5K9u8zLVgoWwejoYenXazZOz
	t1QL3naSZUHOr9SBTRaQ==
X-Received: by 2002:a05:651c:a10f:20b0:3a9:740d:51cb with SMTP id
 38308e7fff4ca-3ac441641c2mr1409611fa.14.1792549532251; Tue, 20 Oct 2026
 19:25:32 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020234434.318-1-rand.sec96@gmail.com> <20261020181122.53fd0c79@kernel.org>
In-Reply-To: <20261020181122.53fd0c79@kernel.org>
From: Rand Deeb <rand.sec96@gmail.com>
Date: Wed, 21 Oct 2026 05:25:20 +0300
X-Gm-Features: AclHuK_0eTtTegQTW-Jyoth0ZOCcpaLSxzE2h0YEB9H2Dv6Vkek-tei8FaPf1fY
Message-ID: <CAN8dotn+f4Cpf6WPzzRhxmgRjViJp10c+qK6TSQWLhtreC9Qdg@mail.gmail.com>
Subject: Re: [PATCH net] net: sundance: fix sign extension of the octet counters
To: Jakub Kicinski <kuba@kernel.org>
Cc: Denis Kirjanov <kirjanov@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, deeb.rand@confident.ru, 
	lvc-project@linuxtesting.org, shda@confident.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 4:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We don't take LLM slop fixes for ancient hw

The change itself is a simple cast, so I was surprised by the "LLM
slop" remark. The same kind of fix was applied in 2776d2320ac1
(net: dsa: fix unintended sign extension on a u16 left shift), which
you committed in 2020. If it was the commit message that gave that
impression, I can make it shorter next time.

The issue was reported by SVACE static analysis, on architectures where
ioread16() returns u16, the high word is promoted to int and sign
extended when it is added to the unsigned long counter, so
tx_bytes, rx_bytes end up wrong on 64-bit.

The issue is theoretical and the change was not tested on real
hardware, as I don't have the hardware.
If you don't want changes to this driver without hardware
testing, that's your call. The issue is real and the fix is correct,
it is not security related, but it is still a bug on those
architectures.

Regards,
Rand

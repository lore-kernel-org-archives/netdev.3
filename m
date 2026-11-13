Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794562152;
	b=hlCFDjmCdYuRXPSqT4LwbDsc4wKjwB3FBvyQ23YtZtR3AO+odoGQwoyfqiT8HoalOKXe
	 7KsZP5sixctIBM1bnsOGVTHh+zeaug20KeAhsKhBUa7CCqkcd6JNVt5Fk8FAkkaOp2Ubw
	 22ReOmfDbQuXm4bNc76wyQTldlI85ksUtBqLfKGbQXuWemTN2O4eoGeylefQiqkY+2ot2
	 btwwXYU7aRUCpaVvCNyp0syS9oqdFAJcTZok8SdF1Dt1+HPmxfq5TM2gXmWegQYzKp25m
	 wmS77iRYxPqH1KPvmgbrT5UAJEKGg3EchotM43s+v7uFEaE/ZyHzurP3TE4yGR3p/KQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XjhMZHTLhubfcTGQOwtx59Gz1meBM7UXW/o/rOqtaeY=;
	b=2ShannwexBhZpjzPd5TZNRdBIsjrXyOBo3BtohwKbijJKA0ONF/Tyc28APbyl2pomImn
	 WurxyElatza6EWaA5gw/25vz/TpvF6Cn7FWFTByTQekAfhgbCDKUSFDxF6L7tiu3JaMGP
	 O0m2zkkIvLnG5E1K+fyolLXkRLosYUkOk4g2ePPFxgPWaiF7doISaJn1+c5EcBRj9CZ7g
	 vlu6zVvua1emFQ4C7TNcZxlFIXGrxeprFQjskgMz9dgT0xAITQkqfAqObh+WVwV0f2A6H
	 yc47X/E8OOpD9eGengkfP6tbETCy70P/rkLuajHRX7Wa7GT7LHP5nCdmw6jenOYCEiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMqBraLt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE6606A321
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02BE6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMqBraLt
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99bf7b97f12so1138274241.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:29:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562150; cv=none;
        d=google.com; s=arc-20260327;
        b=eEtgnJLRq8CX0znIwfG5OdVKkJ9yHz5wIPHmNvJoVlMitQhxNdX6ysWftAbS9qledG
         Vqx2OqWByzNWkUU8xSJ3ESpprP9/chzm4l1Y36b40MzXCHfGoEpCAtm2/hsAKy0rt9KH
         z+CIlL6q6aX1eBPfOjHEYRbFiNqkaq8xJxRX7Z8unBIhpfjLxKVAMo/6tZiMX8syht0L
         TL6T2OGpZHe3P1oD+lOyxQcW1khFqQJNJULCmILEL8juZFuhLRAngnPZ5BmV6qN8iBBs
         R0MzKp8Smi7X4r7Bk9yhHxAcEG66ZuOuXyAgzPlopkfEK1ZZad7xREhVbADoM3jr2taY
         0ttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XjhMZHTLhubfcTGQOwtx59Gz1meBM7UXW/o/rOqtaeY=;
        fh=eA6g9hT0PhlEhcHxKQVnCAOD8EUhik83KpPWxISFOqI=;
        b=Fz8m6ylUPMxpf6e7YwQDKL/bJUA7RwvAEfQCkPm4MBL5l0TP2ml0U/vVGNr68UNPdn
         jNLseBlDAbPkgEo/3qFUPzMJiecF8mTorfanKfyK2+bx/tzVxNHNDluGb4jRY0prrCV+
         PrFdnHf5iQdruWKqft1Lg7glM+riAhXWoKsblk19yGK2kNtPvfUuu7mGvE/widGo9jin
         geJfeAJg14DrWn1kZV8mXcMlCR2cUM4VX0co3Uu3CjunX4f/stf/cSJ0oqeYC2dtghPG
         g2gwD7oyMXy+LIkywmiBvHKVtFa0Z8jTWyMyAQFUcmQcsvA4wENF1VMImHS845HPgAUD
         W1yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562150; x=1795166950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XjhMZHTLhubfcTGQOwtx59Gz1meBM7UXW/o/rOqtaeY=;
        b=mMqBraLtEgLyaWlAzXEopwmYztVUzSa5fY6JTlz+LU/3cJT9lJte7YycYhjqtHFzny
         eLkXlH28UKYE7jmiCKaskVFiJl4sWkEwo2XH9l9wuiP+irG9hzb40vFnWk00ad7cV4x/
         sQtGIcR2DisML0d/grvHKjRR38Hb9/EqqKdbgMoYJ/I0/n9/oAyuS0TySEMrEj1Gfsyr
         hcGVc6RuNEvbQmN5LWsYBfGlnxsBQ6/NGJnbiOyO/VkQg34eb1PBMcqngc/LJVqrRc7X
         8Vzj860bQOx7bzf2UZzbHk462KJafmxQjvI/DObHvzGQ8jCEp2KoHXqz2xdKBKYc9fDv
         zl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562150; x=1795166950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XjhMZHTLhubfcTGQOwtx59Gz1meBM7UXW/o/rOqtaeY=;
        b=KBNBIb5HVf3XTZVkTqxPUz7iiqU/KchMUbqFmFJvRRyNO3cwACL/BsSRkk3cTLjnRk
         D1LLrus21/otb4I9BRYreEd/hSLTRfycxUw6fqrQgYQ2tNzLH8PvqLdfWxwg1HT+SFrv
         OcFI0mPjgj6mgxWxSQeizxg5yAYuTeJXBYD4H1ps/on5QqC1HoqFzii6zyNlHLnsomIM
         AblJwVfqDVfEaru7wtVis5gYk97gmQfCCkaeepqzs3qtubaDsN13qNOGJ6u3S9pFlvxe
         3yJGgCYAV2jCw9b5KIwxY76r4xDsX5kxHy1O0yWnsIggrL8xh8tKFU2Eso/ymGTUpD+0
         7eqg==
X-Forwarded-Encrypted: i=1; AL+hErFngYgJ2euf8kq2dBivR5i1EHjCXdbV3F6zX9489ShMIT/knImkVrFXiSK4Awb77HzhMVoSZAI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yquI8fa8fvQ8IfaN1kr8RJKLR/h5lKarktQCZIXLMInd6rg++
	Q7bwb2M7MZ2WRvnb7wdmJr/06ot3Y55Gv275b+flynbbsGdbUWtycptOn4iOR/ZOYzPt1Z7Sz+8
	705ImLa535UyMfVZ0agoNQaxyFXXWh0c=
X-Gm-Gg: AYBFou3p+gZRQSiOIqYmXrDvRNmDO7FhZMhq2/sBih27K4GJbRZ74TOIlo+bhsuvqAX
	D0b46SyhBU9j/XF8N9LsZYYwWQOlOzaI+pOBmNoES0rsaffJIIkRCTzuQvxDgd++We909ccUdGR
	0OxkCD573CfbyBYnRDqvpy4WkAEZ+VAmOhMuhu9Mdvnca1qgtypfHK7OlFMhUU8rigiJhDu0umS
	J36rm80D/gpSdLvTyd/LgsMyVixatI51v6UJXYOGIEOb7adLHAle+AAQjGPW9sRbWpQsItjgGLU
	Q5zDly7BFlw6+YWkF0Bw0FOmIChnID3Lg9iqIFNZA6seYEGMwieHupcOsPMRn2Z+EA+Vv22/8Uz
	sb8dxnyPKgUeUjWIDNERtnMkQ+SmYr6pJ/VueXYqRco8luUYaE5x3DYVJ5f7a8k1YGdzn2ZZev8
	c+drW5Usn/d/1ZxXU/QGZ+/4ASI+FwPoi6ZDU66VVdZetB198tgUHNbFfPnoLsC9ci7W+zy8dgk
	+MTWHEwYtaAkhC9S5mEd0biaCCtMw==
X-Received: by 2002:a05:6102:2c14:b0:7c8:78bd:fd7a with SMTP id
 ada2fe7eead31-7d6317bd8b7mr1575466137.25.1794562150521; Fri, 13 Nov 2026
 01:29:10 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com> <179456000126.2168702.17640123049966028359@kernel.org>
In-Reply-To: <179456000126.2168702.17640123049966028359@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:28:58 -0700
X-Gm-Features: AclHuK9oifC_qa-phW-VX8f_5gBCRaopk8ooFtHAGMJHKCJwTqeG0TkqH_U-rIM
Message-ID: <CADvTj4rghWnS0TZygMd-N8iOhRo3C+4mjKtODSQs3whfPD13vQ@mail.gmail.com>
Subject: Re: [PATCH net 0/4] net: phy: restore driver state after userspace
 MII resets
To: netdev-bot+sinfo@kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Chan <michael.chan@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 1:53=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

This was observed while testing AC200 receive statistics.

>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D27E792
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786237062; cv=none; b=mPLF6ftylwlfUUXFZKF7o8m2+2+DIbgWtuAlmuPtWcQ/e4a7AC/xMgN2q2O2I2j1CmdxVUSBdCJhAhddNWT1n02uBT+82wXU8mw8XVdIAdDBb+nvGJvgVeYp4ukNOiYtc84Z1p60u0B5F3C8Fk6q2sQ4clgzZygb9exHYEEJZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786237062; c=relaxed/simple;
	bh=YFv1wVIfc6tMCRAvNnVt4Iu9dWgpQczxlDTzev+0DH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiNT8zAwmnknRnlO1+TIKYNvdIjpxIiB5YVPNDkR8rF/okhskv5MW7JEbpG4wdQcKZvPTTw7BhlNYIjidTHOLZinbJnMEHIEvMl9mT+ozRo4uGUpSvBmkrqNC9pWHiqtpnrDIYiJDuqsjykewJrww3AtJuUyaVWohVfyCejDMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNZILmvO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNZILmvO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848743155bcso175343b3a.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786237060; x=1786841860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6kSW5p92W8/kaqT2ruoYIIYu+uhyEIgxwAMS+IbMAY=;
        b=QNZILmvO6gcpLp0O2hLlebDeaz4jV7ZNKbODIH9ya9nKPGXqxtvkgP9+AQIBdZMEwD
         p3ie7+yK4L6AsgI1XxyFnVwCVpu3pdywOEOyTlrQPUCr0gqHdtesmMH6B/tlVTS7ZDy5
         2iFlGoiAnnuNYDfk/GyHysH16g79zqjY5avjDPaaMqhQb9yaphhZWCZcdqNtr5OOakS4
         ohz+gPsZrRS+RQbTOg+yR+UziAzB+dpR4/2GBjM95Fu6Y2AlDZefGBhhC97y40gm7cHA
         R8V8Iux0gkW1qDXQ6EuTPQ0NYyrKStgtddiE7ZamadJFD6Umbx9XSAlaNGhas8MGvpDQ
         dKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786237060; x=1786841860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6kSW5p92W8/kaqT2ruoYIIYu+uhyEIgxwAMS+IbMAY=;
        b=gnu3uRbZ2Alnb2a/3PHa6iLErqz8jOAg0MCmKoyKmaR4w76tF0NgItiu4iwlzXb9S3
         nBhuXPZMmSVFotMlxyr7MUx845GPe/YiFq4rAO1W+jkyBuXqRcqMgs8h3KYeHbFXW+Je
         njxRhRYAgkYAXyollc77cnJSk/nzsRavXvrdY/nN3ZLcvWqNrewFgDk0ZM+IYCgc1MWD
         1Uu2swlP7iT1OR/u5WeF2jU4Y9iFB6dJ5APUPUGmURckrhKnSWeuLEczDqgrq/GxxS0o
         KHJAAaSashZPMFJvK6J7mnf1zJEab1t4hmwjzmz2hjLIt5PIveUG134bd9g8xb0Rxcy2
         8vsg==
X-Forwarded-Encrypted: i=1; AHgh+RoPeNjUS9GhU9UhmNwW4EtckV5f4R+Rlz4QtIz5ou73Gor76HaQUxJQtxxEYga94dicc4W7Xgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpWYEk24hxxPexFQ87cmX8gLrrQbLExGHuygTDD4+INnDhAz3
	+0Z66Dc9/qjMDUfkOsMm6VAzocz9emhSTRMFYNm2FhxVlBB65oPW0ma+
X-Gm-Gg: AR+sD114onVOIx+V58PCwq1kl8kr1RaNddsS8NmllMXSpgLYF+lhY1SNWrGrt15XHNG
	GzLGuIWZN6trz0JNOYv8r31pGwb/0Var4sLiY0Y1SKmrWp4qat1giGFUnXN6WHV6jm6DdQ6AqWl
	4xj56Pei4APUBDZlNkU9JdF3fa/yak3EGDptczDhobWvEbk6zxm3XmEA6Nq8sylrqXXbJzqeqDm
	IG2rCPIk/HtUl6NW3e/Pmga3Kt6Dm0c/WYS8x23E6BDwyFuZfbazQcO/myj03kGkXsd5ywcruO3
	5tCAGcuEhtcuEtlqwPeywJ8kziKNVKgiCxUHsrI9NMMHfx2y0ydmk86B0DUrnuV5Zk449WsjOHa
	+K11oJaIh/WIDObpVfHEEaaFVdildEhGjLhjdaZVBSfwA0798HqTH7xWpYGpKDMa56/H0TUreT2
	kX0GCvAVG+pnBE3v1nwCNGLbXXirVryoUVXIwxjeqVqup0cMXZRNEXQwv66vZw4edK
X-Received: by 2002:a05:6a00:9295:b0:84e:23f7:1188 with SMTP id d2e1a72fcca58-84f4febe528mr20371687b3a.28.1786237060578;
        Sat, 08 Aug 2026 17:57:40 -0700 (PDT)
Received: from Inspiron5409 ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a58dce5sm2471214b3a.58.2026.08.08.17.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 17:57:38 -0700 (PDT)
From: Jianhui Xu <neuromoments@gmail.com>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	neuromoments@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v6 02/13] ax88179_178a: Split driver into library and device specific code
Date: Sun,  9 Aug 2026 08:57:32 +0800
Message-ID: <20260809005732.3084198-1-neuromoments@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806-ax88179a-v6-2-fde7414619e6@birger-koblitz.de>
References: <20260806-ax88179a-v6-2-fde7414619e6@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birger,

I noticed what looks like a typo in the newly added `ax88179_read_cmd()`:

```c
if (size == 2) {
	u16 buf = 0;

	ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
	le16_to_cpus(&buf);
	*((u16 *)data) = buf;
} else if (size == 2) {
	u32 buf = 0;

	ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
	le32_to_cpus(&buf);
	*((u32 *)data) = buf;
}
```

The second condition should presumably be:

```c
} else if (size == 4) {
```

The original implementation before this code was moved to `ax88179_lib.c`
also used `else if (4 == size)`.

As written, the `u32` branch is unreachable, so 4-byte reads fall through
to `__ax88179_read_cmd()` without the `le32_to_cpus()` conversion.

Regards,
Jianhui

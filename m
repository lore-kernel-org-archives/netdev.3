Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981CB3749F9
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001033; cv=none; b=gsqxmrOLaEMZ9QoDGpq6RI89yi1plR7L0h/3A89ycB337TvP4Us/mgHI7HPKSt6RD9BpxYc/8YZcG5Mw3ZyUh8GD1tHmNecIbKnwjfOrZj2WURcCCR/tAp+1CWOQCZ7BUAZt8hPHD4mSzxrcPFM1Cec+eHN86rK4dNmaXT08f8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001033; c=relaxed/simple;
	bh=JdvoMc2LwVyUcDqUaDHPze8wUz1GjeDXCO2AEqFuj3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iu/9JYrSIHQzbBNOHpVa6w9/Act5N3m0lzpxaKU39GeIC7c6302evWsZb2DOa1rZlayqpw/7H6+/uXSqTWV9SB/VtGm50SUKV2RbJlnGCxhfZ7wSB405dF9YwoDRfjJan3SQ2DMXr008RpxbURTX9S15oxXHhfuiJUlIXoUdPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyAIgs7d; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyAIgs7d"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6611669cd16so587851d50.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 20:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784001031; x=1784605831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JdvoMc2LwVyUcDqUaDHPze8wUz1GjeDXCO2AEqFuj3g=;
        b=AyAIgs7dQWK7gY3eejMqgyux6vqTAofekXKQg0vyrzTjoFjg/E0cYXQm0YHORFvXiK
         oboNmlmDUzhS5KW+Os66PG46KXMEA9MT6AUlgd7sF7at4oP8J2ek6FyoTZqGAGoqzzlr
         azFp+1sYTxhiq+QeDQ2FY3uO34ZUW6rId685UQnwiJNX4JIezGR6Uaxo2iZ0k4rwMLEv
         Ppq9Yl257TZifigT6+9Y743eEPnoM4fsVSLyMFCYXlA0AabIgLTZG5NX4tuj574VbRV+
         aUYA1G9AE9R0NuyM1N7puMfbqSg+Mw/CVEmoWde6lrw6YTkgvp8hRWTYpLjn6CSDjtPy
         4DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784001031; x=1784605831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JdvoMc2LwVyUcDqUaDHPze8wUz1GjeDXCO2AEqFuj3g=;
        b=RXoFA3Pn3ptUbGKlSjGtwwkaIsKEUrVONz0ey+bi+kFjL6xhUlYge5r1MYcx+bNkHG
         H6iwl0P9eadygE4p2VUsomTY1MdCAXLpLOpWXG66DeU67UWUJOOMeHwRWBTy5I5W70uT
         Jk4q3Vn//WH/Xwqa5oG0T9QL7gwEVGnb3wfZ+Q91CF2NuTQSypmygPhCXB3B60pcwYua
         XAYH/8vt+xOZ0sQcAH2mRkplIpCmopEwDwoE4ATkLLcTU2IoQOLwpfqmzw0He7SXMrC4
         Pn5dgMKk/YxvCMAFbqvxU2OvtfE1JZa/A/++s130D23PJoWrADJFgvQgRzWAmTR4E93a
         ME/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqTBP92VMb6g2xDe3A1bFuLppVGLPzz6pJDYfWZai5paJoMz9UFyg25nBUdYDJ9iyDJ24vA7UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWhClrEbORDvVd9YxOAnyxlTFdeYJc0w5sKc45BJj4z69ye7fU
	90tKgqer0jUhwPw8mmSjGNswAyHP0e+7QgPOp56LUbug64E8Vc8oihOc
X-Gm-Gg: AfdE7ckil8AiJ2zE2aK4lGrLKSr4Msqli4li+M9rwx8uVWAS/ksirZKP1O/rchzVBo0
	e6KqqpUxy7k2oxrsv8X7KuiENejHGbxu+aTSDnJSFtuuQu+TCCPEF75K7F77iih2Wa18euegdN1
	eTHK9XysgYUP/MWJFZItWL8QFDzxxSbbjUDyy5AwxCRQlGg0FZlp97Qy52Tje4b92kzMMqixsri
	WRZsyRUzYNN6iZYs+YmQ/gusA+GpLJ8ka/gPfEkUE+z7KvuGPgX1QtOmyPwMATDPeRDLL1nokuT
	VplfSg3DVz8T4orxMtOvMvmgsgaLy0U9VIUN1l8YbraF6RsK1mxj/mgagNCYtqqCYRenyteQ66u
	w0H//C0ogpaIyEqAxObZ/HBLfBXtP9XhvD9YGEXuOhUZIJBTCexeXS9rMcyTWMlhW3foQGHQAT1
	7kqVNsLBEkQWXpM9zI/rmWpLVfZ1IKWA==
X-Received: by 2002:a05:690e:4395:b0:667:c7ba:99ee with SMTP id 956f58d0204a3-667d7a9f648mr4706710d50.2.1784001031494;
        Mon, 13 Jul 2026 20:50:31 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6678775df90sm15394234d50.2.2026.07.13.20.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:50:30 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: andrew@lunn.ch
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jmaloy@redhat.com,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	tipc-discussion@lists.sourceforge.net,
	tung.quang.nguyen@est.tech,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer MTU validation
Date: Mon, 13 Jul 2026 23:50:30 -0400
Message-ID: <20260714035030.259097-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3ec7b01a-270a-4b57-af9e-bdbf85313da2@lunn.ch>
References: <3ec7b01a-270a-4b57-af9e-bdbf85313da2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IIUC, the MTU here is TIPC protocol-level (stored in struct
tipc_media/tipc_bearer), not device-specific, so netif_set_mtu()
wouldn't apply. I'll prepare v5 shortly with the full range
.max check only.

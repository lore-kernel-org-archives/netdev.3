Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF0374A12
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936020; cv=pass; b=KPs8dmHR4B4ssSkUxfixWQuXL3D3aGiU2na2Ut8Y/1gk6kCHOrZzYE2bXdtWNa7zgc8fZCglXavQ6Rnn4AF+GOaX0tksJ1WjYFi8Yz55g22prRU5iVlAYVt+P/JKW+VoOQZpZFBwPa4EZrKzV38tGkW9VjnbRVxqqSYU08Apco8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936020; c=relaxed/simple;
	bh=R31dQDnJ53ap5GeH4hbi3ZM97krFZBGuCEodpNOsenA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHkR01AGRcxHwXkrB4srdVIE83QjxL4ShfvchrQyYVvVEaL+9A1sX1Qqz1vmuTKuaa8Fue5abr1U+bOZRKItHrnly9/FgmP6x2qHSvipgpPrvZzSHH/QCLIbGGdoEYWiqgRZ1pX2WYo6lpFu61dbinLONyDSv4LepK5koc9Kgtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzoImABX; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzoImABX"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba447469b1so1542630e87.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 03:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790936016; cv=none;
        d=google.com; s=arc-20260327;
        b=Yfnb6PFzUmCZfJC+ocfG73r03RtGF3tigceDILUfG9mawGlFdtZbwua87EbPVM+yVs
         DIUpnRDgmgOh5J7tjHEYmtIDNXQ52AsZ+Y5mQvIDxqyPeds7XLOxr5IIHsfcHVhI3tSs
         Jo1BKrGPPgEfywKBbskNaIR/h8CCr2iFDvHCaYamQjDLtuLxujMGOR3PMxpi0aVxs66K
         WDdjlehVAHXKvVGzsgQSdci27KCGbBQsPaZDvdDSyWt1vUyADSwpPs4YCx5ef3jr5gWO
         vjCTXfgwTQw1XLVOELKdzfXO74AHnF3E4BjTbgrvZeHQP5R97H8cxnOWMJ4c3zxDp+Wf
         80kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YtQs44M5gzBLsCq+UUJQkpTtJc7hzbbbWNdnDCJs0yY=;
        fh=7WiAnhYaD8wZd7S4M7pgxYlilSWOLOnaKKy1muaXSZk=;
        b=DNmRHwPCfYA2JQkvlZ2SLZYj3EFTaDmbyq5B0iaD77C5qZgV8IaeBySxj+6G+6QM4a
         4T280w3pQmQFhu7BTfh2Wx08n5rTSZfo7OPBVJuKNhkO7BFbXSzZiWCY0SFIwG7OaE7P
         mRiHHUNur1xgtRnWMEdH6fon9zZ5/KptFN6A0JpdDmHZE2JaUf21yRt9CbR5KCfMfLXF
         /dV7HK3L2wd5DKJGyfjQJpflkogHWmhzqr4f05CxoNj6ylOwjv7neU4s5rSW/9KubZke
         HK4IFRBZZPcxNXhrhHWWqCSWtXwKhBCL4Y4s8cSDiDZOPTY6FXdLk/L4MRMWzoVKbg5V
         KyJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790936016; x=1791540816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YtQs44M5gzBLsCq+UUJQkpTtJc7hzbbbWNdnDCJs0yY=;
        b=dzoImABXSK2Gn5sUjxkaIb3Ut06JZ5GtduYxFB+DlVlZxUZXLMXBxKtl9w5wb8jKmN
         869QAukK38CFKwy5AW1Wl/eSoSBulkQ9FYMFHJPXX65uanH6t15vx8mYbkA2Rp2+ETQc
         91gou23YDlaZVvHG9ZnL2ad6tnx7JY29xRZ+wMVqo6syg6pc5xswPPskxc/p7WiI/HwM
         5oHGaMz9xGzb5IvxIpqM205iFpKjvQ2fPi1oYxKrsI6Q2IeerGYiXYF5Lm1fjAPsQHiW
         dVT/sBCTxzfQu4ULOo9wOWQgSUGEy+aaADXdcPdak0rAqz5Vu/qZkvHos4pdlou5Jj8l
         KxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936016; x=1791540816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtQs44M5gzBLsCq+UUJQkpTtJc7hzbbbWNdnDCJs0yY=;
        b=dqFlGM/B0t4C75G8onebbHjwuqgq0FMn62SZ6aZHkCtluXHav6lAjyx6RMon2hPiXz
         //CGHKNpTwVBfygF3I5WdZuz4WfijGd0g1hL37MRtR2upCtMMeTWuXf49AHtarbZ94B/
         hbN0gq+NhEFWsUj/4HurQefKDcGlkl6eV44JCFiltisdJEh+wtvKFnG/1w0VRtYVztp+
         H3WDYRbQSQegeHpu5+saKmLHq/mNPseJFMH6zsomZyufk7jdvHtFCgbRxOeT/hg3EO+T
         UoVMKKejP0wXewp0el7+xwXGvcbxqEAUtHb6brg+ngm6jr8ZZ+8UyJRNFwWWWuL8wvYz
         BEyw==
X-Forwarded-Encrypted: i=1; AKwUvBxLPXW9zpbeFSI9fiv3nvPX1/qht6jDswnZsQhAEDG/k1zKka+T/pp/fOHh7ryUgO+Zi0lZguM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJxZuWmJz2L7Pil+5KGjl1eJ5FyzcG+XVGEoQsHIAYLYGTNt3V
	gJPdbveg0GxlEu46UibMMrujva8lbtZMRXezpgLhRaOKf+p2hwAOQ75eKMyJhcXvvErZWpdGEVk
	gg86o5/FGrBuqF5c3JTCWCLKuGxCIUAg=
X-Gm-Gg: AYBFou0vSnUIR3EIMZgcD5cbgnkQL+jknG5uTRKf6OH4aLOwpCsDPUMqERDoNP+aXcB
	ezg8/y3B9gtkgm5YsiQsEyJTrePj7JLx5599/avAy5dF1aTbmzBR4q+toSQTtW9XMuKlwc6Z9aN
	uxdqb+8MejlAg9JYYzCvWIBSsTP7K1SCNPFC3CPgNfJMMnFF/hvoLGqMNmn1zN0uXt/Ywp/GNdB
	UaI2E61AF0X+quan4xtJRYbQaPOYrmIYifVZDTIeR17SMkF8YKOK/pj6/5qS1s1sTUl0PklP2Qr
	sepRsDSxzr6RJz9AfQTETSTsnAFu17n1YEJmFHEiF1+T5hqjJHDtigL5rAXhgiEuyEYtd1V33NW
	0/Kbb7uHWbDU=
X-Received: by 2002:a05:6512:2346:b0:5ba:3888:705b with SMTP id
 2adb3069b0e04-5bb9bb22cb8mr661934e87.54.1790936016247; Fri, 02 Oct 2026
 03:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930112842.21323-6-sigefriedhyy@gmail.com> <179089748368.434549.14167408771777474746@kernel.org>
In-Reply-To: <179089748368.434549.14167408771777474746@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Fri, 2 Oct 2026 19:13:25 +0900
X-Gm-Features: AclHuK9nykm4Rn1HobyHFdYa8n2y3hHFC_CiwY1QwI6PRZQntiimuWrJxRLpDDc
Message-ID: <CA+7S2vJCT+PzSvFtmL9disx8t8nAMZvEMULcL=97v4p6MDyPcw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/6] netlink: specs: rt-addr: document
 AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: ajay.kathat@microchip.com, aleksandr.loktionov@intel.com, 
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net, 
	dsahern@kernel.org, donald.hunter@gmail.com, edumazet@google.com, 
	idosch@nvidia.com, jacob.e.keller@intel.com, kuba@kernel.org, 
	johannes@sipsolutions.net, kees@kernel.org, kory.maincent@bootlin.com, 
	kuniyu@google.com, nicolas.dichtel@6wind.com, nickgarlis@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, 
	sdf.kernel@gmail.com, vadim.fedorenko@linux.dev, willemb@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> - [Low] The patch adds `target-netnsid` to the getmulticast dump request
>   with no condition, and writes doc text on which request semantics=E2=80=
=A6

Fair, will mention target-netnsid in that sentence if there is a v10.

> - [Low] In Documentation/netlink/specs/rt-addr.yaml, the getmulticast
>   operation still has a `do` section, and its doc still starts with "Get=
=E2=80=A6

Pre-existing issue.

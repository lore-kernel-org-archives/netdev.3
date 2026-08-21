Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E73DA7F3
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338213; cv=none; b=IkeqH9l7deZmo37suiN4QcmGk3eu9+CihsQYhwOgtQQpQJBl8pPhzbSDpdgNcaBULOO1pd+byNh9G+mpxLx4DkYEErDkGM4JfVwbmxfBue1+f+rkiFglFMXzl3AcwdvlrEn90F56seWHhU/lwiAOZGdNBNHEZpTu/k64aBzIDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338213; c=relaxed/simple;
	bh=w8OhNYTb3BzPB5ojbe4bR270KT2CKHlLbR/449Zb6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWuPaTWHWFwpWDuaPdc7NoritTQ2wkxxEOH1u3v6zBB945orCFf3u9dBGLC96dRww1jb5JllOw1R7ETZtSkRo3AJublGsSeOLTpSCBvvpF1zapdfV3yIiupMa7Jx3x2fDsf8/yNvMEV17M3AJ8o8HtQxIQ5650IcsxmhyypINs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EABabr52; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EABabr52"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-395cf2535acso937330a91.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787338199; x=1787942999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8OhNYTb3BzPB5ojbe4bR270KT2CKHlLbR/449Zb6fs=;
        b=EABabr52Z6dwp3O5ofknzIhIb9UtwG8PSiVmkRdBGFIxGHdbEhb8my1sHuSmEMk7wj
         OqMad/QjCK7J7xZ9OxLxDVibiy+CwmPyFWeh4n6TC8zoq75HeAE6Kzd/OL5fxTd0UC+S
         217tSEi8xkcQFb58SE+7CjxekSzBp5ykSJtfAKsFBB1IgclPMV/7z9UCTNbamsUOto9l
         lHOrWbvLrUU3r/wdW7je3tKtlXKGPdrXCSSIMPe3nbmN289GIk98vYt4pocylvV9L7JC
         UH8WPVbLTZwjiVPeYWiyzzZFL7cgQ1G6b6AEqgX+c5mXllFo30MB56w4w07WoZzzR4vH
         Vr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787338199; x=1787942999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8OhNYTb3BzPB5ojbe4bR270KT2CKHlLbR/449Zb6fs=;
        b=P/ATpxm6Fi0M3+uVGtoqO90855OZO9F+ryxe1xcPFLSPS4OY9uFynvPSVTfZPsCGBO
         jTZ1HeGNrhzSujaVn0S6SyEZ3PkTXazw7GS0WajREwUeQyntZIbVkkrgAVrDj8lwBAoF
         me+2MmiW27b4U2BLZO+NlGSNgORtxrAHXl1LaDLFXh0lYqQLo2uYWl5OCZhsoNpflone
         UiE2hwmeRxULUvadnCz3IAO5coI+Xx3d/K+rgyWx+RrRXYI1Let7AtUiqyGRIxi1KWOp
         iy3cxIIOs9tWkzTFIoCyPDMkGx5NctagLxAlx5pEv0fLCBFBJwvIUqTDVLPrGxzSj4lh
         hP4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp/KncvR9aKKq55Q7Bzugva7umIbeO70ZnGWTN3E2o6c/bJBOLjJ92+Sn9EQ51qRREZ6qntDkY=@vger.kernel.org
X-Gm-Message-State: AFuF++n+xzG04wbcxWaJO7Wsl4F7NLvbAaRhoRky3scWlXPWZO8n/1Hp
	RSHAE96ku0rD/Ko76K67ggUA30Z/vx514expocVStlVX2zmF+puR8pk5
X-Gm-Gg: AR+sD12KlQ2aVVvFx94ByvTn6KRSo4me7HYJ2q0U/uO3M7ypD1gZDP8rjI9PFtSYsUy
	lT0Q4XMvpA/C0C7orJTLvsA5yH7F5PQ89N1HOyiLBSxnCaVpEi8IuWbrlxFdr5FlFj2fr01vFGx
	eCU3zqzr9ilGpcFpDBUIIEcQf0XMcFtgad1hLSe5X42Qo2OTfh7lXN3ObRbEib6VTFRqYqCbPdt
	kQ7wdjWWXBxZzo1MScf2xlKYvcrwcZ7+ucfwzfDWzVpMcjhDaP2xHr/nEz8KhU+uH6/U7nDlBMT
	XAE+wWiQtCU79qbiaC1oli5U4GyPoDSk7me1+q89kNf3gEMrWldXdPYUafz+MREs9oX08SeVmHa
	VL98FodOz+B3AzNg2JdXSl5Heg+UBmrZfgp96aeiKwawwn/0U6GPU2fLvCFG/w1MakOAw9Nef9V
	BEWR2GwsmCfHgc76pk8kSyrd3Wuaz3q+mINQSa2YL2rVmgH6sFNzK5dNYGd1GqvA7b9eLlmhT9W
	83MtyCLRBNW9bBxrBMf0Y4k
X-Received: by 2002:a17:90b:3943:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-395c50b43bamr7549988a91.8.1787338198788;
        Fri, 21 Aug 2026 11:49:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1010:54e5:69b5:423e:871a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e14b4283sm165982a91.2.2026.08.21.11.49.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 11:49:58 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com
Cc: AutonomousCodeSecurity@microsoft.com,
	andriin@fb.com,
	ast@kernel.org,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	horms@kernel.org,
	kafai@fb.com,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Fri, 21 Aug 2026 14:49:43 -0400
Message-ID: <20260821184943.867-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com>
References: <CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review, Eric. I will send v2 with the data races fixed as
well.

Thanks,
Cen

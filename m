Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724C3EBF16
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466720; cv=none; b=rItq/banRdZmj8TF8jXO5oie/HUrUQJAiRJWd9Iul1vnAFhmm2YA7wDvdW0BRzsqebhvfjmkIqS+UG4LSvH+CMfPNSNIOuAz29yCDz15A5U0410lSKetgKwweyPCZY7q4A0p2S2oQpEVI5sP12GLONebtyJvdcbl4IfN1n51siU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466720; c=relaxed/simple;
	bh=JLAIROYePggFfJJH59UH4ireJPYPOsIoeVi6uJuUcDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maAl9j4IIiL2bmcWA967EWSqmvgYHh4smuY+JwtXVvMNEX4hgJfywAtXys9xHwKJ4lKi6X14Y6EjTVzY1Bc4QTy7AOz9N0b1g/8vzdkxe3CwlRFnAO2mcuhTYmGKBaIGi5lrj9n6eDpGBgtLpaTF9MRVB3z07jcFyBCSorl9VHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaZbZ040; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaZbZ040"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aea4cbeb94so567384e87.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782466714; x=1783071514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLAIROYePggFfJJH59UH4ireJPYPOsIoeVi6uJuUcDg=;
        b=KaZbZ040pxAKh8WZxDgx4yp9V4lNiyl+iVVJgEfWGPZFj/DjnEnMYvV2Y8bwgOpjxp
         DSpV4zHeZwAxjXayA7nA63Egupll8AkPjC/WHn328Muot8u1Mw4Bt1ymuslh3DPIyI14
         vcHiFnVCO3+hjU9a6i9wwWsE/IUjwy4IDSi0woWe3eGdbz0rX1JikbB30AYCb3AT+oNE
         SnhpvseloeIwY5UPnfYGUFbRrih9XCFoqivD/O4I+qeDpkK+H9We0D24W113PrQ2+XLF
         t1HJgGs1esDe/Pb6IHRBbscO899huux84H+GMEN87NhwJBTI7G25cpgQ6y1WBblMKNRE
         Tr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466714; x=1783071514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLAIROYePggFfJJH59UH4ireJPYPOsIoeVi6uJuUcDg=;
        b=cydK6D/yFThRtJ8wwrnWpZDMynI3Do4fCnyFu1GH4ciYGClpGmLgonAWwlg90KgWjW
         7qmOvcWZkdr2X4rXvl6THB29h78nRFSPg8PMiqwV2ZdsfW3iNy7XMndyzqYuf61mdL8O
         UVn/4eCGRtvH0iH0QCpmyhGvs00cXI/8tWVvatrk7JB9vvex270P+1FD+yfRyuFGTvpq
         8MXRb/WyhhSfo70nj9VBvDwZ7hSWtJ/b5wMuVOaGhxfx3lb1fk1WvICOXl95xihtk0rz
         lsRGEy1NYkrVZSWa0rkoEBdVCmb7l+TONxW8Csl88MUfPjCowZvS5ouTfNPYIlwfWVi3
         dYSA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2n/NElT7wlHjnE1mAEZPz7IX29weA7mxny8OQ50GNzSTMp0ETC1J1u7qtuhyooB0XH5qgvFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+ALUQ5NbNHdH5qXCFWHhYrts6BA5mcNcl5jLs+p4a89k7WC3
	ApCFXCY5J8oej6r86gEGXbk1zMNVIayk8WTW18i2wX8/wbjr57RasN1D
X-Gm-Gg: AfdE7ckMgRu/2hK37j3T9mK+dZL02DbardlO+R80x3Q6c/t/6UrGdWO+SPSNSXKzafM
	4ddG7bq0ss0Oy5bRGvmZZQnhko3WZyYhh8BctPxqrCJYmTge6u3FK0uyxAFBbic9hsSboZsWacC
	l18uOaXCMxQM4GBla22R+zuQj/dDSPqW9H0kGC40Q2IhSXWYw2ptIV3ppPs1MSaae9nBHTddLL5
	TwxSUbAcLQdolSb40o+RV7+RLUg4Qq2M4Qip2YXM/t7pOBZPT6f82g1KFV/rNXnBLW7dtnWgtG7
	u6b7JK/KiLHRHFGjRn/pic+KsfHa6ZSQUmK4pQP1ZxD3OrXwSu3FqJ3qrZwpNZPMZUTcNTuebbN
	/pqZyxfaWagztV9rPSa9dZaC6wBukW98iS73Tt0YekJDa5jqKLZ6JQn0Je310AsjGBKnj5lbPSG
	AkUad97BmHtVTakXEbnby/OnKPRa/d
X-Received: by 2002:ac2:51c7:0:b0:5ad:49da:67c9 with SMTP id 2adb3069b0e04-5aea1f48c2fmr1756704e87.18.1782466713996;
        Fri, 26 Jun 2026 02:38:33 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6954a5bfsm3270613e87.4.2026.06.26.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:38:33 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: gregkh@linuxfoundation.org
Cc: alexevgmart@gmail.com,
	bestswngs@gmail.com,
	coreteam@netfilter.org,
	davem@davemloft.net,
	fw@strlen.de,
	kaber@trash.net,
	kadlec@netfilter.org,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel,
	pablo@netfilter.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	xmei5@asu.edu,
	yoshfuji@linux-ipv6.org
Subject: Re: [PATCH v2] netfilter: nf_log: validate MAC header was set before dumping it
Date: Fri, 26 Jun 2026 12:38:20 +0300
Message-ID: <20260626093820.196664-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026062658-pregame-buggy-ccbc@gregkh>
References: <2026062658-pregame-buggy-ccbc@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> What kernel(s) is this for?

5.10

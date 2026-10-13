Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F393C07A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791867327; cv=none; b=hCZfRKSAXey7eZk0aWzvfj97AenmkpX1v+7lOTU19FNyc8hJcx8PdPtWUY1DS2jRV/bfQsgZFae/SdY2P2xIOe/UsBFLN3xCYSUFMEqOtU1BweIVtAN0UxJ7PQ4ql8lXHXwixGBXAuO1WgycVih3NR9tuXVfitZZQRAHUsQUmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791867327; c=relaxed/simple;
	bh=WQcAD1MMEpo3eZQ8woRePVMMduZ074A3ZIDLuK3z6ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGw9XUDSM+rt+gUGL37G2MYfnpegkci9vfpMtR+4kyT9m4EsWFxd8rkQjrJUMXCdlIpt9tqqPfnnbYRtNQwDB6yhHH92ogzUrB4t24UoXU1U8AjZeh7bXplbJ9Qlt+LlxfbvkJpASL15Y6v+ONhKNn85pQIXJZrZfGUPEkXoRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOyKQnMG; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOyKQnMG"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3980701eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791867325; x=1792472125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQcAD1MMEpo3eZQ8woRePVMMduZ074A3ZIDLuK3z6ek=;
        b=dOyKQnMGRKTOphotxiiAOgsHY1jXHPPOYD58hCyba9EvEvgDBx3KDZG5pCOpqKihe7
         9SCt06q2QJTsajl/dvkf8IoH4fp/cuGmTiIuGWV5x6/X4mBsSFKhWmjOGa7rg/bPpa+B
         ITpwgLAzIBnL1sm7MjQjFq0nc7RrR267RL0Pej2e+UNWPxCI9m9SWOuLF4NP4pHQI6T6
         q/zhCoU4BAaRdVLIVVq3FWaL++iBjMHbgP8FZauEQRIuZl5gvrONrDw/AYVElp2qisZz
         9IqgINeSEO5SgEVNkJhGDrhkirXfXxQrMJNGM2TvbKACguFi506WQrSmWK+oez4vnyaG
         HjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791867325; x=1792472125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WQcAD1MMEpo3eZQ8woRePVMMduZ074A3ZIDLuK3z6ek=;
        b=ZeySjQ+9Y5N1Q0ZT76Gbn1CTcY1vhNO+QW/phpNgX+gJeZPEQmcvlRDd7sckHgawJU
         7jiW10V/UsKYH5I/fOEo/qU2jarJG+CQK99m+5WocKgXcczEvuwAB06SeDnPIKX+jmg6
         AgKy5/rlSAlsEI+/cZv2u+GWknE8P9VfY/jumx7xUgbzTmOzZsR9uw4K4h06a/VP6Qow
         uidQe8taLTyyVbYcuowfYmKXK6yQbl/Qeoi2JrMMFkSrWtbkMx4W2AgjPHzaVtRwogDC
         jb6/NV9p9mIa+mItXwS354Kw0rOxwjVnew8QPzNvd2FYrF6irKQTOti7kMZu+5vNvMOJ
         y1Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxhdbdx+aM9q65Sg7dBCfGLbDw5PzHeVg9tf/DO+VdtNXxmoVZgPi0mrWkOC4+nI9x8JjE2L4Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2s451qdmnJ5GEH6DpMrx7/zU9aYAw2zlSRLX6akZpna45Wdxw
	x7sCJpTPFhB1GQJSIuQcqE6kTp+/GbpTe4LUl0rMy0B23aVLlE8h4oFl
X-Gm-Gg: AYBFou0umD+yiD2/48pMcDl7i50Aj7jWHYZYHg6WbEfo4RFKFpANirDK7faEaQohhj5
	W/OF4g1FaDOgcipqG7DGRN6MdursckM1pFGeKLeCx6tzhiAmKYtyYVYuKkStzDSOIq1dbQ6z3t6
	HMSjBZS5isaXs9wPpruBfieQgXppUag7mits8Y5H2GEVx9OeQovtKlcotrYWSl21ENQpkubx3ft
	D41a3vJxbOSk3XHOgiaUW5XR4pfFzSJRe52Wg3GnxQl3NIavGdCpBi1c9G1zF+fG/QcD9CVUApO
	wHfftRew4wUkIHlY2lFtYMhBdYp+4vqdYcykvVfVHXuXAburZV3/C1qV6eVz/DPAF3QXuK6vPxW
	uyKwwm/IB0vt9FOSOup3BLy36ZXunuKNzC1Gea1AkAOFB38aIh+Gg+WPCz3SP3ZzI0hhdLVIge1
	ziXbY1URE7tyEAy3bUqxY09mWeB+STwWofkdJOhWcLQKAC8YGzDtGPFPRUbP98pPwhAozKm02IW
	R/w9t0quJeS
X-Received: by 2002:a05:693c:88c8:20b0:358:f678:46b6 with SMTP id 5a478bee46e88-358f6786227mr11214375eec.22.1791867325040;
        Mon, 12 Oct 2026 21:55:25 -0700 (PDT)
Received: from online.mioffice.cn ([2408:8607:1b00:8:5e2a:b6c:f432:a6f3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm38832952eec.30.2026.10.12.21.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:55:24 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	Jose Abreu <joabreu@synopsys.com>,
	EricChan <chenchuangyu@xiaomi.com>,
	Simon Horman <horms@kernel.org>,
	zhangpengfei16@xiaomi.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: xgmac: do not treat TBU as a TX event
Date: Tue, 13 Oct 2026 12:55:10 +0800
Message-ID: <20261013045510.2746341-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013024747.2688984-1-zhangfeionline@gmail.com>
References: <20261013024747.2688984-1-zhangfeionline@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+Cc Jose Abreu, the author of the commit in Fixes:. I used an outdated
address for him in the original posting, sorry.

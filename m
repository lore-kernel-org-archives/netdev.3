Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1E3ACA7C
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122499; cv=none; b=t36wZOTwzTU07EQIuaxsuiIWhJgqMAHI3yC0xGR+B5KYq2aiBOw2GKAivytARmMvnfRCCSP/IA9Oxu4LcSlhLxgeLwnKP+bvXbdxBkR1Mo3fn+PzKy+V6nwctJeU0I7Gp9mdJQECeMyRtX8TlI2mAiHI92M8MxuHfS86TnErL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122499; c=relaxed/simple;
	bh=KE2VmvcgzRzsohaFalSlwnQNko9IVpTrrNAyx5LHuyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyJv4R9iVsu7cgp7ZZf0y155EI5lH2G7QgFQdOwMxY4YXoimrEt9pnV/vMVtO+P+3+3g7h4OcjExeKOT3/Mcku3aumutozylZoLdDIr0Q9aW8PGhe9zpC76Jq3Za/MjWVCFZpQ96HGQF6bsJlFMGsnNtgl0JGABPQomV8lP/5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=phmghlLS; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="phmghlLS"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48b0241a47eso370025f8f.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791122496; x=1791727296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+t3C+Ja2CFaTDIBFicfkFdbgjtRqzlYdCsfo/CBmKMg=;
        b=phmghlLSJkI3H3iSSBw3OChHW2O2WhqHWlFdENK3fr46De+zJsx17yB9RStrkX643W
         Wd4/6Z7ymdrXVFGcRkBBfKYv4YiZALeI/qJYuA6kyoimXo3QzeVm3QAYHpiFGK5waVp1
         Y4XjP6UWXnYETtVAYu9c98c/xgvsyQvEOv109ui2GruRvG/WDmB7mQSMyL6VdGTWyefg
         owat9LxruSd2ywuz3OmEWfUThuIo1oZ+6K/2tPcP9g27qmJWbeSwRZ4GzsWXB//eUMX7
         PFuUTFrKdJHn75VA15oEFnF1lMULSQd/WdNHzrXorSqopkoJsPjtP5PJ8jcgj+pED3xi
         aj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791122496; x=1791727296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+t3C+Ja2CFaTDIBFicfkFdbgjtRqzlYdCsfo/CBmKMg=;
        b=OAL3ujcGvVvzDu560olXNq+lF3thXEm+J7k7tmGZHXREe9ggRF5WvvNZj6ptqiH4xm
         wu4wW9gb0CsJDhlgBm/0tlcETbZzESvfMTSmf4vwJAsjijWy/tWde5tIVwNH7m6KwNm7
         ALbfXZk15D2jQ7s7sSyVae67DOl9aLTMU2Ud1CjNyaXJqZpwPVkrPtkXHgoHN0WSkGeS
         e6oHyglTlFoSV/Eg5f+PrSc87GP4SlgvNbzOUK3B8V8RlFaufxG1mbq7WqzU6+YxNjFi
         6y1yx04KWw4VbOsxw50QEttJd6rlvlyWrtu92tLRCKcosO1ZuXlH9gZG0/F//GpKYcV3
         gyTA==
X-Forwarded-Encrypted: i=1; AKwUvBx5fFrBVui4noaugNXx9kEkiVT8gJWelP4EWOro6wC8pftntZeavh6LAIbua6dCOqB6Jxx4pWw=@vger.kernel.org
X-Gm-Message-State: AFuF++lOBoY4g3dp9i4vrzOKEOBpSr9FqDhY/BfnaAeX6jT4l0tHQA1r
	lesTjm1PCbmzQkjsD3JQHtNZUogc19NoeFm4Nyq4KqcQiaqD9+NbreeL0hc7MHpUbE0=
X-Gm-Gg: AYBFou1pZzPKCtjV2z/Sbc8j0AgRTlMA534gA5+mvOahl31AzM45CBa3LQqGwkQXJrq
	Ixypm7F6RqQPV3nnHAV28bMbyDRJIvdd/ryzbRRq3fNLBWrwgdskKMxU3AER+A3enLYb/NQeX/l
	s1C4CAX7EXDWuXltlcdXOibwZSCYxqsA1x5r6s6ZfIY0c0GF//cGLUfDTp0DZRQz6W7ycpCQfSt
	ZKyzp5sSQsiOdz38y9VP6sxLqJOFVeRj0PQaldpBnKXNPtpqeeTum8N9/PKWcvO6DFxuawod3iy
	ayuxdOCNX6nTypKI4+RrhdOjsu1WQIqIntGkxaslyvZFE94sVFTBPUMdSKrBZlcuHoVmR7Ebhu+
	AVdF5AqngFTVKmS0G/2xs2lz9CD5MEulsTMx0t11f2O2V0fg0dSN954GH72nJ+MLke+2wQNn27f
	fNO71Sp38ZwuSvQUXenVLU8uwUB1ec9x+NIvJsPoEZKJqOVj0/5OEgK23orazgDB23g014BTIwe
	40k+gmgX/NYN+WxgSr2JsKGWBMEkPjd3BNDBiPa+vXv7UYBGIhY8oae9I8WiE1vKW+adgWiH56i
X-Received: by 2002:a05:600c:3e14:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-4a027585559mr141267525e9.23.1791122496260;
        Sun, 04 Oct 2026 07:01:36 -0700 (PDT)
Received: from localhost.localdomain ([197.51.72.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a039505568sm226480455e9.3.2026.10.04.07.01.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 07:01:35 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sashiko@kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] amt: mark relay data as a UDP tunnel packet before sending it
Date: Sun,  4 Oct 2026 17:01:23 +0300
Message-ID: <20261004140123.94341-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179106416186.434549.2202047416681649119@kernel.org>
References: <20261002212458.34247-1-omar@blockcast.net> <20261002212458.34247-2-omar@blockcast.net> <179106416186.434549.2202047416681649119@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 3, 2026, Sashiko wrote:
> Should this have a Fixes: tag?

No, on purpose. Eric asked for this to go to net-next, since the bug
needs a non-default setting:

  "Note that tx checksum offload is off by default on amt, so the bug
  would not trigger by default."
  "A better fix would be (for net-next) to call
  udp_tunnel_handle_offloads() in amt_send_multicast_data() like other
  UDP tunnels do"

https://lore.kernel.org/all/CAL4Wiiqw_7Mxa5W1EQgw2=KpJNNxG=cBLXsHvpio29GvD1UKZg@mail.gmail.com/

> This is a pre-existing issue, but it is closely related to this patch.

I have not reproduced it; so far this comes from reading the code. It
would need rx-gro-list on the relay's ingress device, and tx
checksumming plus tx-scatter-gather-fraglist on the amt device (all
three off by default), and a GRO aggregate that passes ipmr's DF/MTU
check. It predates this patch, and the cover letter already lists it as
not touched and untested. I will send a separate fix for it once I have
reproduced it.

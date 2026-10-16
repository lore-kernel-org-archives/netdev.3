Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BF41DDEC
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135032; cv=none; b=PKobHbSiVHixvRRyw5qKYqdbgv8FxaDrMAOQaQyjKNs0bm5pavwdmn88q3Jhv0eoTug/eLUbqy33I1GxTaDAkUj0Cwr+deaQc8xk9bf9QtC3E6aeWgjaVqYy1Hebc76ohrUHlOuDBw+lkYbLgkRqHi5WP7ZPgbmBOfi/Io5qGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135032; c=relaxed/simple;
	bh=WYIoHRWahmE2fvmt+avDjJLVf4iUC15MrcJZtroluhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JYxAbD8iaNVGwZt7u2Q/J/yMtTdGlDoWBKzUUVc1NdZmA+d9vZHDhZMNPu27ZI/jLS+JiYjsFYLP5BGhdAjRu15p8t9pMNUiQWANXEOxVnofpZNA203/MXGG1wOkDqWDX7mG2IP+Hr2t3eS1XplFm4osxWmhh7RCHd0wia9cI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljB4bnyv; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljB4bnyv"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30b6dad2382so14704264eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792135030; x=1792739830; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WYIoHRWahmE2fvmt+avDjJLVf4iUC15MrcJZtroluhw=;
        b=ljB4bnyvKLk/t8VWqupEePEo8p86nyEJndWQkJ+twE7aQsnLkR1ip0bPAF+i9J/Ewx
         Y+7ALoeK8MWK1FbCZfM5r1kJIwqu5Zx8tnJ84LZpUt2xxTeVjWlDKrMNzW47WBsWBAOi
         DUqddf0ExPC866enxMpjhX7vPULYdXzmLYn/Ztg80GQCvN9KReZqvbTeB3yaFHIwmAb5
         ftMCLH4y5ClGAhFXBuR1GndE+VIgCXFXDNoURkMC1q+9b02V6693dHpC+Z5DVW90pyeQ
         PGhZ7g5uM/VPhGsgJj7m/q/w/SuRYoWcIyKphiGqSeuQs44EgzLearY80ZP1l7TVGVsd
         tLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792135030; x=1792739830;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WYIoHRWahmE2fvmt+avDjJLVf4iUC15MrcJZtroluhw=;
        b=cyIlyQ4+9mohx+S/oJdyHctVZ0swfEJ/YPSrGc7gdq8bGAZnmDVkgSQ8cDCgEx1zk4
         buDZBXSzZKEXlbYtyjOfoFXOSs1iUXQ331297ouyvVAoAwN/4kimpfFiZxe3LtccqiMD
         yokEfOY6UqZ3N72g6P9Qn1QO1bIkLHNwytSuxWicfKszfviyzrLZyzlwS+fRKJ8NHXJV
         wdaStXwg06sM8cps5oP0mIGZQra/FO1qJepim++bbWbm1tcPHaOX9Kvr5YLQFQApICHA
         F6f83D+d9rTvZYdvjBSJzEqBC4HVr37vgWav327CC6TOv3kYp6SZFMeuLksuK7nmxzs8
         CJLA==
X-Forwarded-Encrypted: i=1; AKwUvBwW7OzbUOOSlP7wLf6KKvIncJUqJJLa+bRpX0amF+R4XdWKg83A9GGSYxzZnsfS4TjxVem8sXY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+2YDkr2U4SSJAVO4p2O93wy5j/q4HXKy+kQjNSMiyPbnsR+BF
	S95WcY03Mx0wnNA3XogNEjJdarYSiTyfs999d602Ve1LsY2+1D02lFQ5
X-Gm-Gg: AYBFou3cyc4F2arxObVr1p7+XpN3f3mNqzWyJpnOARvftZ0zDSUYCRuE4o6zme8c0u2
	CJBU3YdyfBFzAuEVBjtscVhHV63F4TG4I/Z2WD7NMOchR96P/U/gXxyctWRUuaDQl4lpobFOOAG
	uD3NRmvIUUVI2MRgywwBsue+vZ+mdiu1Q1cubd+EcptTw72Lpz4fjlTknhHFD4cQmI9SKYpaA1v
	ovSI6HNZ11MUYdh0e3ZlhO77nC3wtVgF4yklmUCGW4L4fzebqWCAzSl9oCXMwKo6wKiXz+v2mVe
	+gLI8vWw6HzZH4vLHY/QSIZDcGPLneJRBkD8sBEBnsVrByBHlV23588XATpdAEqXZNnMxk7tfEZ
	B1QWJTdV+cvOxdZgV6RLyj7hSDriGL5aHiU7PAAAYeWZpN0ZBMD9qAy6LG2ykgvYmXiShE7U5C1
	/rWxeFKTr1GMZZbrt3Rk7RI/CDQRmWSjNu7BfqyIai3JvrQkWYywwf4Ubqo2kCxYrGK5tc
X-Received: by 2002:a05:7301:9c91:b0:35f:8c5d:5928 with SMTP id 5a478bee46e88-35f8c5d5bc7mr4763847eec.30.1792135029915;
        Fri, 16 Oct 2026 00:17:09 -0700 (PDT)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm3973233eec.22.2026.10.16.00.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:17:09 -0700 (PDT)
From: chaosheng.qu.linux@gmail.com
To: netdev-bot+sinfo@kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] can: don't discard the platform_get_irq()
 error in probe
Date: Fri, 16 Oct 2026 15:16:59 +0800
Message-ID: <179213501981.212310.9988031427961239592@gmail.com>
In-Reply-To: <179213131512.408196.11368789495251891862@kernel.org>
References: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
 <179213131512.408196.11368789495251891862@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

The issue was identified during development while reviewing the probe error h=
andling in these CAN platform drivers. Manual inspection showed that negative=
 results from platform_get_irq() were being replaced with fixed error codes. =
For drivers matched via OF, this can discard -EPROBE_DEFER and prevent the dr=
iver core from retrying once the interrupt controller becomes available. I co=
mpared these paths with platform_get_irq() semantics and neighboring drivers.

This was not a production hit or a syzbot report, and it was not found by a s=
tatic-analysis scan. LLM assistance was used in preparing the patches, as dis=
closed by the Assisted-by tag. The controllers were unavailable for runtime t=
esting, so the series was build-tested only.

Thanks,
Chaosheng

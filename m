Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997843DAAC2
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670034; cv=none; b=iCANwoUKBu79ewdgsUX6vBC04+Rul7/JbVvXjfmhmbF4yjDNJGKtY5PZmVWbWRFZsDUB9tl3csrbUCzMdPnmEdMf6KVw42ARPXYK1jAHom8c9jlZGcgdnxDQTN+/0R55ofSjHWAwaBCIX8DM0UGSyJV3RpE+cdNakNSNaD7bj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670034; c=relaxed/simple;
	bh=Z2wh3hX4GTbMSEzBSVlaN0sCaPeudxONGvzONywFAB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI6vRbw7oy/KmzoOnHaSIHG+ovBPnexYKqGX10kDY2WqEnogo7+X3RaipEcxzby6SvhIdvpy/DzK5FNIy3s2Dyvpi6IC3ZYZlManA4SJCcqA5/ZgSlUvFpxZmPjjLkxk57eqKhjyJk3NX9s0hbKTeEI9zL1RbYeAvWwO0Fu6N28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=BHYwpIwU; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="BHYwpIwU"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so10865985e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789670031; x=1790274831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2wh3hX4GTbMSEzBSVlaN0sCaPeudxONGvzONywFAB0=;
        b=BHYwpIwU5XLCkTaVff96GO8IQrYo2UJY0v6FESNtLB+TLNwGAqQuOJmuNRX+ZUZ7ce
         UQUJdYD81N8+YVqXw7C/pTA+r/CLISa2ysPizRM3Cr6hItcrjN0TqiUlqKhj6nBUfWjq
         raaKOl02w7kGHTIX3Wb7hCnuDL5kbVCN/3EyhOm9w0jp1C5kLEiVbf4n57yIpPrKDLId
         2htod2ekRYJ8gx48YXUaFjE3f3td17JSdLVbN5zl4IgQFL8fOROCqDlW4Kqh4BMRW8OO
         ftZdYgnhpqCLmbXLjRb7MSB9zY3OSP7a4rUcU2Gf2emEmVHiIwOMz5p1KanU+DIuqavc
         ANrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789670031; x=1790274831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2wh3hX4GTbMSEzBSVlaN0sCaPeudxONGvzONywFAB0=;
        b=PhEWoGileVN2sL4tLZYZxhIG+vM968w3WZ7J51ZGHiqWvSpLa/kyV7fYH/Ri/Lj0TU
         pYHu+N45Jliati4gkC+h4pE5gmsZO+9RAvhcsOZkRTRcf/5ADc67SeDmodd0xcEl/4yc
         3QhD+ri+ky24DftdgLuYECYVJ0KIOXsSx1sz08a+6e3VzPpV9eo6PqjonLAx9NlPBeKW
         owq9Lt8CwTR1wMz7jofwBVjE+2c3qM9UZQ5+JAmYx13tFGC6EWLZlsBdwRxMYeZD2bts
         /ppSpRb6dNeF9ssBxjY1Vw6jf7+g9X367iJoBafwG9DaFkcsIKO05lAKQM27gU9QS5wO
         /8hA==
X-Forwarded-Encrypted: i=1; AKwUvBzUsdx9D/iLxE0sme8mA8SmvEZVMrwnZb4kWJ+9TZ1KR3onDNPzLxe2V1diY21sQuTxlMTYukA=@vger.kernel.org
X-Gm-Message-State: AFuF++n0Iw6gnXApj9rHmyZvUzQkTcGxEtfHNlj6JrjJdRpbk5lDmk33
	Iip5gVcpm9FxXKPCgHLkPC1S4hceO9Y2zva1nIZFKXPqPEEeoTqMq6LXU6oJ11P/X+A=
X-Gm-Gg: AYBFou3wNbo9iVL4ImTvxp65kM9e/C58yLNe8tbvy8eXXaoSK0T5Ov1xbnpUTKZMCLC
	ebb8ss6MVoxD5P/WxaWZXQOmOawnrmP27LZvbGB8Z3Qh8/bllw40+y/QNkXRhWazzKzN68Mnnrj
	nu3tkMTiuAUxSQPGK6v9A1TcaC1W2pN6RfA1Vd/cpWp+gDd4CVofxgfWo01rkTQtaEGQkCVIeml
	fU83tQAcw1+xK3c/gy2ampAercGPpcILmcwh3QpCIP4+4RKqED5jgjX8TjrHLRfiIYeEYGsRrSk
	3mbCRPTziN5mdMqK+jqpXbR/YyXbYa+tn16Z7tCYSHxuVE852k72cYJJpdwWJ1rYBDRn+g779rA
	qfHzi68TXo4otU3bMS+n/8CsLo7MRLRM9of9+eBX2A0FA8NIVp5sFS8gEleLl18cfWHmRqM99RE
	d5iVbhs2/01SarR/dVPpx4Itlnfl4C2GBC0pbe9hHg/wWB4Vhd9w==
X-Received: by 2002:a05:600c:8b8a:b0:49e:799a:8951 with SMTP id 5b1f17b1804b1-49eb72fc61emr120382075e9.11.1789670030653;
        Thu, 17 Sep 2026 11:33:50 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd225898sm102190195e9.9.2026.09.17.11.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:33:50 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: reject attach while the PHY driver is in transition
Date: Thu, 17 Sep 2026 21:33:45 +0300
Message-ID: <20260917183345.37604-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6e82dc04-a68d-4c54-a6f0-a13c04fa2eef@bootlin.com>
References: <20260914204200.2743251-1-f@lex.la> <6e82dc04-a68d-4c54-a6f0-a13c04fa2eef@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fine, v2 will target net-next.

Out of curiosity, since I will run into this again: is the line
"needs instrumentation to reproduce -> net-next" about the window
being unreachable in practice, or about nobody having reported it?
The crash itself came from a real board; the msleep() only made the
race deterministic instead of occasional.

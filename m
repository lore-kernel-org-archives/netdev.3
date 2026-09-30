Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F823ACF00
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807269; cv=none; b=hVwRDjUOQnxC09X1mACr3Q3u7zr2CJSlPtSLDs5fNBw/z4vhauF6oF0IT64XsTWFx8iRONPLiamNV36rjl9r9/fLYpIZ1V3XaJZojCndhIn9T4/i/E5fOJVNQ/4cNLb3qJEQy8VNVhKUwj3S8jQoZJXBvj6u806NkA9XBouCXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807269; c=relaxed/simple;
	bh=ZSwULQAHzGA0yfFQVkuurUtRXeq+EcSnpkm1sjqtUG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlwnHai73VbdEXAw5Z9bwUYHNGURvPvxCCRDyMOEG0sEr4N5CIT9x1ekllmgyvkr9fjRDT+Gj4wy6Lk04Mfj6cqUcXuBfPau3xqgZj7JFh/GQCCIMKd1vVT7OlqWCDXjc4evTm0YkuvyIhGIVy6eudIVR48m1xTP4VF4YDoefXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=kQDXVqFX; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="kQDXVqFX"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso15573825e9.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790807266; x=1791412066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZSwULQAHzGA0yfFQVkuurUtRXeq+EcSnpkm1sjqtUG8=;
        b=kQDXVqFXYzulDpIu4sviPqPJLzPmK9tuMlFlUdZ1shePGvXm1TsirEPuA//09X+btp
         BNUzDDH9jlKsgycYrnHkWcmMcZr8skXmQA0nq2C5mAQacyTA48YzvSbulvBQGjPR5iNp
         lUJQpPo6/8NUeV5+B8QV+i4DBZ9NsLN+jp6rw9VuDBLimH6hOlLHf75k1gUoyj8fk3IR
         +/7j8C3T1zkC7Ecyte7mibuunQR+FhUvDfpLZ9L70EiCHXUNUJi3UYB1PTUpUvbhzfzn
         tvk3oMP5X9EcPXn0RnRpp2ZEsrhN8BZM5K5O8FdfOId2XtQF8inyTIGQPlhkJjQVwo1W
         TCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807266; x=1791412066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZSwULQAHzGA0yfFQVkuurUtRXeq+EcSnpkm1sjqtUG8=;
        b=Ui9gcPHi5IHrcGAk0HZzdFBtrbii9HyE64fi1THrkIxR48B6/nGXq2t9E68XeyvmEE
         3MxnOMzg/x1IYLlDlK6qove2LBhbyyOgGTcEBCNrU6Rbbbg9x6Bu1P2pGv8ZKA00nU1l
         EVNg4v9+I3bWoTsonfCqbVwLumrnVYdN6aHAHhCzseq+VJ0TujqI9KoRMUh1B4gbvHuu
         ho/fa2iGuU1X4xabZoIj03gDzNYbNNpLphTuf6l3XbTjq1xyopn7EicJRyZ7nQ6a+Cks
         CfyJGlEvL6ze7dT2dX0qnSzjNbJFCst7Nvc75yTX79aA8ZWKd5uWCl1rC5TxN83/eGJ9
         sWSg==
X-Forwarded-Encrypted: i=1; AKwUvBzsx8V+JcOZ317lEK+rufnhYqSKBqFz1ChmH+UB1l1MbFhyumJ0Szfvq6GYayitsCM1bJSIyKw=@vger.kernel.org
X-Gm-Message-State: AFuF++ngklaRV4GNIUIFV9AVCIuk1aS0lO+KOFDf5pzsvkn/6H+5pIP+
	bTKulLc2U3J5NBEhGjk++hsozwXwgxnEyBAtTP9rOG5LwPVDvT38XxfuNqckyY9D11w=
X-Gm-Gg: AYBFou1a7B2nCfcPm/atf0N3K4rAIUtoCbxhgMiMCpOnevcHJdnAFme6mqi39tzUPue
	WImCyieSDXaTw+q5hGyO9faDBZ8G+KCSeTGNic6DiBxDyztNcdVjSWjPR3lbRtw1YWUwdgOXF3l
	GrdlVQGZs6PiNzbeRdzz+fmfxHzqjSNqADy+I9EmvWd/LF3U6uj9xdTQNp4diFHjBR81x4ykG2h
	4WtP3pJU8oPFlo6n0NBdgCskxoT4gkR7IBd7dA7qlp+q8814eUfJbnv1Q4TfQJb0xdo/DilwfpF
	1dl5GwxhAJAD16bvSxUQYvNu046yqJctfWAzWlzI/+BEG7oTZFE/IEzcLf9cJyzoahvjG7Fe4KE
	A6IwjJi2pfPHGuMDCv7aaY1P2hbAOLtuAYNsgEuJj2fAV2bhKU2kn5uL01cL+AANWtZl8TePfzz
	k4tAtqx1wPWTq5/xXklpDrV/095RsZeTRNut3hkGfgLF8czjAzJGfGv/0+73+xKTMouQ79Q/dCU
	9qJWXuUR4tFl7sB5Lye++bv8hrMVIk7y6cNI2+Kqm+75ljXFkNSWct5NEy1XpEKNXyK5JgETuzB
	ZPY=
X-Received: by 2002:a05:600c:1f86:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-4a01aff3978mr44945685e9.25.1790807265320;
        Wed, 30 Sep 2026 15:27:45 -0700 (PDT)
Received: from localhost.localdomain ([197.51.54.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01feb7198sm9238075e9.1.2026.09.30.15.27.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 15:27:44 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sinfo@kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] amt: pull the AMT header behind the transport header in amt_parse_type()
Date: Thu,  1 Oct 2026 01:27:28 +0300
Message-ID: <20260930222733.47563-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179061960357.31693.937915571809434718@kernel.org>
References: <20260928181557.85796-1-omar@blockcast.net> <179061960357.31693.937915571809434718@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by code inspection: an LLM-assisted review of drivers/net/amt.c
while I was working on an IPv6 outer transport for amt, whose ICMPv6
errors would go through amt_err_lookup() the same way.

It has not been triggered. I have no reproducer; it comes from reading
the code. It needs an ICMP error reaching a gateway's encapsulation
socket that quotes only the IP and UDP headers of a Request, so that
amt_parse_type() reads the AMT header past the data it pulled.

Testing: W=1 build with CONFIG_IPV6=y and =n, and
tools/testing/selftests/net/amt.sh passes with the patch applied, but
no test injects such an ICMP error, so nothing exercises the changed
path.

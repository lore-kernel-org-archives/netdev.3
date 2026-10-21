Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553596;
	b=rcrF6pKpQ+2FscRuBNMmL4j/YqnPpQ5GyxosPh0qeXz6gA9RptX+6mnXgulmFWibIX2n
	 7NukpHMKazQn52L8yfmK7Iz7K+TmaxNINYWQ9FLrxaIolmzex6zOc9ID/q3Jd4RjHzwIA
	 dTY/xd86P49/Jmvcsrk7v5yBVNaP28N++vxWoMNrZkpjmb5As9gkJglwvEHJTWEXwknZ9
	 FxAv+K6yiT8/ryrzpQbJlmdWYUzraTRXLsXQxpJqM0Cs8nLCYGm/JercDZ2UQ/K3RzOR6
	 AkTPCYPdOJPyIsNJpz5/3XFwO6PUwPao9BPmDAtE8tkfxjKUSnly1U6ASxPqCaHoGjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jrdPTTT8LeuGKw/UCJIAORDOHiF4eOET7WBKgWyq0CA=;
	b=zeClCqVMdVGrVjkEOKt0R9Ic1+u1FuKjGa3zoBqDmPMUzUQzcuaJK45VGHOhiAuQCmeH
	 qc3joIDnLyCmXtMJMU9xJ1uAwyWcf5/S5i6eTi7I/6SVFbdIjGs8MAUdrUEljyhSHue4W
	 1Rp2qnH/2pE4XXvzYp0Lykwm/Tk2Mq1e6FVXOqmk7pb/vEXqmRnALluM4jKJDaVi/Sj/Z
	 j4+f56FUajIH++h9fxgcVxsXDslVNaFdyLcUMslMhQTKbQBO6caiLT1Ow6RqW/PmfQ5D3
	 1xQeqooRCbQtLgGTJ3exRRKSzX2sAop+e+ru8GMwCJUUnzf9mvsvQwC6YVs2L0KhMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=X5XibFYs;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACBF606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ACBF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=X5XibFYs
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6dd059478dcso135774eaf.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792553595; x=1793158395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jrdPTTT8LeuGKw/UCJIAORDOHiF4eOET7WBKgWyq0CA=;
        b=X5XibFYsv5I92LrAxuIAIELYc8JWFexebLAbJJ7l0SbZdhwQyds90r9XxKbIeJT38y
         lUtjXHEJpFtgxndozNIty+KNblvj2GWDRpr/pyW3WmPZNz3mLXHMc4OTIuxjngA7D8Ne
         xNgeawx0Ro0KhLEL5tI7Wn5vSucJbfY/gR1Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553595; x=1793158395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jrdPTTT8LeuGKw/UCJIAORDOHiF4eOET7WBKgWyq0CA=;
        b=CFgUzlsYYJmbrfebuCb7PUq1byLN6Azb7vIvqPbxTLhUAfa+qV2927/iUJmxuHmvc+
         oohpOQ9uy1KDsCNpqZyI+j4KrNC/dcEz/+nig8MnFRjBcpBDOGZS52BRmR33D+teCv2k
         k69N6h52NDxARklPgCjBi6/HeorHwQIdbXFZ41v8hplrMmsRQxA3x/Ax51ylECi9ncDQ
         NtVTOig++rZseR2l58w98Ao36tHnrzOVSv+PFY7Xbf3jOiki0Z3JrwmeD+XeAjNZG5O3
         871uEDPb4xZYeYUhFi0cRxmED9TcI6FYL3i8sH3nUTfhS1M7pG+lF2r5eJVl6rsdC7Yy
         WPgA==
X-Forwarded-Encrypted: i=1; AKwUvBwfdEBLTHkvaiYmsocUQuQDTai9szNbXQt+QgmY5MGQogXBPNCVcOe2Qkf7Qq22i3MIGM3xII0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeU10QqCY9pLpJsCJiHQz8nSe/eaBwfmu3x1MemxgLJeuDk0Tk
	5PXJ9eE6aNr6La76VNRrrVrWv8V5BC80F9JaizDO52dxSX0jzCtPKcC7xieLoZBKiqQ=
X-Gm-Gg: AYBFou3XQzQ92VHYuKoFqH2XJqtodrIsV3jD0bqARyiO3F4DRUKUW4gAmzMfNxChlNp
	loOTHIC+DhDVxmosiafGoIiLCO0QlgQMBYzHycaKA2URalftfA+4S+DemdZih4nabX1M1IJFW1G
	Dk7jdSBPpYJJdTgEES0P1ED1/OIpjBVBOaMn9rCvK2Q1RN6LQ0BnAeMkAKfmenmOZzz8FerjSPx
	bQeec9svvcNQwGmFUl8++l6gbLzQUqxrOl4rXtGmhc3PcHBxkN1/LegO2rytX8RDyjjSWB8n6T7
	/V7zUaX8Py0qNX+qArBfkIAzUGa8S5yXgOrrCScf+etuVK5QtRq5OCVic3mjt0SO5tlCor6wjpj
	bsYyV2UOXfw8nmLJAeRZXG111JZkroy8j/t7Prl9oemsYyFb8gv1wKlPNuliJaB6xIZSl+Z93Z6
	y4zE7TNMF/MoL0Jv0j7xn+nH/OAnG8xOj/JXmGdfRvq7DWQNXGM/WV46hgqiSfIzWT099711fUF
	1yFI2BYNgnjsxdXvCfIXa+EREAHbVmVwaJTW9yxNOxRXxWKEa5Ia5mH3lz3ULQecLCMfqMd6yEA
	V2xnSV/fJi/i6enxuj/kckK+DQN9kd9lg2Vr1DInNsaL0K9dHJtzX2TMiEv3c4xU0QHCgN53Iuk
	bQ6erMw==
X-Received: by 2002:a05:6820:1f07:b0:6e0:edfa:9b48 with SMTP id 006d021491bc7-70941830650mr500639eaf.77.1792553595173;
        Tue, 20 Oct 2026 20:33:15 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbd2d2a76sm1333653a34.18.2026.10.20.20.33.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:33:14 -0700 (PDT)
From: nramaswamy@openai.com
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell.sw@gmail.com>
Cc: Neil Ramaswamy <nramaswamy@openai.com>,
	davem@davemloft.net,
	horms@kernel.org,
	jiayuan.chen@linux.dev,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	ycheng@google.com
Subject: Re: [PATCH net v3 3/3] selftests: net: packetdrill: test RTO fallback after partial undo
Date: Tue, 20 Oct 2026 20:32:19 -0700
Message-ID: <20261021033310.46029-2-nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012012601.27658-1-nramaswamy@openai.com>
References: <CAL4Wiip9RyA-2=p0SVwBcn-oe0864FqqF3QMTCX_7=+ErcJp6Q@mail.gmail.com> <20261009171447.291802-1-ncardwell.sw@gmail.com> <20261012012601.27658-1-nramaswamy@openai.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Neil Ramaswamy <nramaswamy@openai.com>

Hi Eric and Neal,

What would be the best next steps here? Happy to give you more time to
review if needed, but I can also 1) send another patch with Neal's
approach or 2) send a patch with my proposal to move lost segments that
meet RACK's criteria to the lost list to make the merge simpler.

I'm still unsure how best to handle the -ENOBUFS case I mentioned. If you
have a preferred approach, I can implement and test it.

Thanks.

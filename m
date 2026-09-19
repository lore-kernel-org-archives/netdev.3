Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0130C152
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795816; cv=none; b=Q+J3m8YJmC9CkoZn4tL2SVSQGx7/xVBs4LH4PmQTQ5T9O0QtS0qJ6asyUc78f6w0XP1VbZrHKF+JLs4L63i18nTF3xU6Snxop56cC80AT/fAVNBF5ElJlkHGthIYAyGvOooPf2OzpqVz46pwAf03hS42YgNeigMhaHhHeeRXoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795816; c=relaxed/simple;
	bh=7Bv/tRzHIIX1nxDFQ6yrnEW0jrJAUENMoZyb0TZoQYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9+pFL0ur3OxnA8xO8Tjziss8b2gVEw0XgI9EzeTLkJzyA3kJIZkYp5uXrEVt/66dXcZxh1uuMJ33ugKfEtcdQh9/LK7AuZkjsTSs8Xt561bMGlMTZ0bKK3SKao7A17BGmkNRjoFCt71j8H3QjGsAflKCZncsxHV5JnXkt6dBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojWO55EH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojWO55EH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso7935025e9.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789795813; x=1790400613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Bv/tRzHIIX1nxDFQ6yrnEW0jrJAUENMoZyb0TZoQYw=;
        b=ojWO55EHv5TMcFaUZ+O6ganieh0E1ZUWmRMERpDnhHlnt+symQlltJr943+sKv3cmZ
         Vl5+VuHe/GRmRyzd9ZZ/UcGSImAjFBdc3qNG9XvrdjT08r21Exn2pMq5oVNligNT/RHr
         RtygomwifXsj693OSri98WBORfdWwWxfTea57aeKYq7VSKT2wGGXSI/M/mgSUQrUcINm
         IjjQNzSr4dQfVM3+gn/X9Z22WdQzXyQA3zeWojQQp6iIyhipbPtImCnxKqRWrPrFe1xQ
         dxLQsORuehV615FDVfpGL/zOixHqPQYF+RBqpdS2rTMD7Zcrge0exXE3eS7rCUeYKkdq
         clMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789795813; x=1790400613;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Bv/tRzHIIX1nxDFQ6yrnEW0jrJAUENMoZyb0TZoQYw=;
        b=z0M5OxKAJyD/TJPX5qiGKPaibFEOeCX8e9nbtZ4Mn512AEw1BEBs06n2RM6Z63+ns4
         2Gb1sXQWRwG3VoFrug8WWX7LK6ujEFFMtL8CgSmx1pWsZZDGAfYNAokWp1/t4LIcKPfz
         ZfI/3jFVz9Nlaeh6pACsvhfkPTKfV8BdXh0jofFjjRu30523pwTiW4uGdMHEdX/iAClf
         /nN+QbDHUTrD4VlLj6AVFRHbBtAk9YqmoXg7OgQzTperOsjUhpfM5OTU0ATs/dsSIP7M
         SvBfpvf1bHcdyH1Qir6kLYeqA8Ptkaz27u8yuxQSnDpDuZhicKCxgmxqmFlgDsP3dJab
         wIrA==
X-Forwarded-Encrypted: i=1; AKwUvBwLbXBfAirdP7FC0FmFaTO9fDt5R/MbU9nmdJqtbmfUDYIih6+/L7zlpLlXfRcHyxTwJcjc1/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++miaSvrqq23f9XOKZgORszFphRdpNrLQNKfeyE/n7G0dsTDbk2V
	unwswM+lKOv1kGw++oy1PCWbYZ/dfXISWM0VVL60FM+mL5ys0+xn+JSjZg9/u8nA
X-Gm-Gg: AYBFou3eYE9q1NJdODRBCIszh5D7ASYlCMAtx51Sekj+CqfGdQ+HsnK1RxTDQWIPB6M
	dCxAFrxY7ppEQOuVomqYM7vJ1Ji8CCDTQuBi6B4rSnCh6HMf4tV/PsSif+iDfDIKUpNxCPj26tv
	kEG+1YkyCvA3AteWTVSeCi2ckSRHyfzNLN9RZftwliGyFCLCCC33RmxW19cA8KQdkCJfJt/Jr0u
	9jVRrhCUA1w7XHoJhr4Dw2tV1Ns+3/VMdIxCDUZqj0YPDuDEqC2xFW9utoGbv7mHk7E5oRqN21l
	rshSck5EcOb83KrYLCqJydsRveVKzOZd+DUpMb73ZtM4lupCsUBxvk9RlsuH1FQlYSpOdRId+Vn
	7Kuj/lNpImkzNgs7YEUb4H5W7H6Kga8qx/yssrMG7kU9huHscYNvuehDx9hR/9kjLGt62oB3lRf
	RCm7G8GQrG1tzHFhHGmadvnA+iOEyBHCMRU8FutjMC6mIk/FR397lBSiTFdiylni4JyZiBheaEO
	SCcfa1YJlPJ1yE58tZYcl7Ih10rz63ShkAXNdvQVS5qOwpmX1hbvhy+acSsPqc8FDZ4KqjVZLNh
	tf2lodSjurjASRbkiagq3LDXjYx4FIulTC4hbSiSSeZEG32HkdfptsemmSrN/Ej0nkUH3c+O/sA
	+FLvtAnWqjLOyQ0Q=
X-Received: by 2002:a05:600c:8b61:b0:49d:e0c:e55e with SMTP id 5b1f17b1804b1-49fc574a635mr67008715e9.23.1789795812998;
        Fri, 18 Sep 2026 22:30:12 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583250sm4045214f8f.22.2026.09.18.22.30.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 22:30:12 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] docs: kerneldoc.py: preserve headings in kernel-doc output
Date: Sat, 19 Sep 2026 07:30:10 +0200
Message-Id: <20260919053010.26104-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <335fec1cd5a3449687f8b1ee8cd46a0f3e455aa5.1786751700.git.kmehltretter@gmail.com>
References: <cover.1786751700.git.kmehltretter@gmail.com> <335fec1cd5a3449687f8b1ee8cd46a0f3e455aa5.1786751700.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 15 Aug 2026 03:32:29 +0200, I wrote:
> Use nested_parse_with_titles() to give kernel-doc output an independent
> title hierarchy.

Friendly ping on v2. It already has Acked-by and Tested-by tags.

Is anything else needed from my side before this can be picked up?

Thanks,
Karl

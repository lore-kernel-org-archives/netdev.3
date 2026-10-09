Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6213DCDA4
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524397; cv=none; b=AxxXpa3SA0QNf6+CiJRza4pFd+9rBpTPKqJmilxSzMlrg0XN0YlWoPq/gglBQpcz5dXsvblz72YrJ9WNclsvF2b/fCGHuOH1ADLK9CbjZk1tpLaRGjkJP6vE0oMLxrdUYMR0Hx3ZkmS/AU/vpcA0X47YIPNg+AVZlIMiN5zGvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524397; c=relaxed/simple;
	bh=UXUFl7FhiN5wibBmmXj/11HbDZmxBMXi9qkzZx1E71U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPdRirgkh1UNVJZy4ydafc8FDlySkBblnj8hQWvO8VHwfLtXtsXyLlj4DdBa/1YgFDG+FRPRzUP2kaiDlEWC0rbkWWH3gCe/9bTXIYOGuXfqDf55fk+2Cnz3ih7kXHr6eZlwFxeX8/u9NLkx+WgMNF6WXIXHqrf3EOcipmhflW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slLP4XN/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slLP4XN/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e4a341d177so35025485ad.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791524395; x=1792129195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXUFl7FhiN5wibBmmXj/11HbDZmxBMXi9qkzZx1E71U=;
        b=slLP4XN/fI4U9/ZpT1ul3lEH1ZDWIuxnb5ACFiYbF45KQCA+Aw3NfycGT3vmRlZ6YQ
         HpM3b6rOB898saaigJPofRzhbBlgOs4Z1PuJ5qrMSuxXpGSqsRoKZcbwOGfI5a68GHT7
         RQMlKrB2OmKPr9L8fNBoq2uPiBfKSd6HmJiWTjWnHjzxe58B6pACWEAFxSV365m+bKzR
         wFYuUYZNq6QwcuwPiM2S8HyAs6iaq/nlpNhK0ZKvu+DkkFXwhVAIB82gh4hOLSdvMuMe
         FxmAr9EcHK+zd/H7VY+8YCabhKk57zZ6TKxWcCpVblvpcjtHmy45GllYn60JVYsHzXYY
         IWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791524395; x=1792129195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UXUFl7FhiN5wibBmmXj/11HbDZmxBMXi9qkzZx1E71U=;
        b=FR2TiVdOjHsP8ILjU6R9UginHNzXaCvXd22giV/t6yipaLgZbpAHOReGtyXBwtbh14
         pPzgY1j8QPKn/AuCNM7A6q3W34It1VbK2gI8AMbtM07ZLNQSS3ZIiBHXnyVQ1cp3SZlJ
         3vEivGWxb4LcVTB0WODbyWxuA+Kl+CraGKzduEWHltE+zQUjgZ5LM8DWt490A1/0y5mx
         BGr/Xhnng72YHTwHbo02gNSrzP7LikZyDicGOZEcMBzb1j6nqkLFKHv5t2+aDCXiUwvm
         X6pWRDrxI9Li4iYL9IbxabK7AKvpm+eLd9I3N8ybLElBPTjWW5eGuqBy33Cv57TlHyeq
         78KQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3ZoUEk4Ib8FCy037sWLYhK6MkuN+9rNc7B4DL11qFraWaHrAyMJ53dPX9mda91aXUPXtSbu4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6uA4iJ7lACgx96FOKHvn/YncdrGVtHd4BUxxas1KhnhqvRsFi
	dBnbRrfZMZz+Uw/xWDIQV7MhsWlirohtugbHZiMjt2c74JoL7vZNzx7o
X-Gm-Gg: AYBFou2GMExNXZ4hnasCAfBemh2TksfZ1KYu7/eK2FMRMJm3VffxqoPy1YPjc31zSlT
	OJ6Cy3OfhWTSqLMDm7A52DEA9TkTBateQnmu4pRKvNq27nJC621LKOvPzHTrnqOySTphPyA5tEJ
	3QmXrRPJDrSXZ4Anif2xyOy8KqypUxcOPW6StAi6DdxBDSd7FIgZ6HvzNa7kQ9mDHkSTF5UREJl
	SI2r7Q7XBoHimqMZzCN2et1Y+993tSvOgZp+WcbwtLrw66zjJZgjPwziRwCWjzyafysg34WjvBA
	M9b/GhjyyJJF7CWNKVQlY/GGUY1RreneDFxqiAoxmUMI/GnEqLnw+iFe/Hwv/9qRgeK4bi6nnJA
	FlyDhIMBjNQnzjqM4J1sDdeGC5LOFnbgrKyv1G4ebCGD/AH5FWjmisukSCkx8iZiPZaPQuN6i/R
	zXAyV5xAVgcbHZhlFsXx813iGZrkXm7mKnFsi8inSE1Ud2NCDLwiVOcRovGuv/8EoOhBJb5sVEo
	2B/817/aXI=
X-Received: by 2002:a17:902:d2c8:b0:2e6:646:8ee5 with SMTP id d9443c01a7336-2e842cd3e90mr6908545ad.39.1791524395437;
        Thu, 08 Oct 2026 22:39:55 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e1643sm3620345ad.70.2026.10.08.22.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:39:54 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] ipv6: serialize address publication with device teardown
Date: Fri,  9 Oct 2026 14:39:37 +0900
Message-ID: <20261009053940.266350-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179122559913.434549.12720841717630168470@kernel.org>
References: <20261004183639.3773498-2-4ncienth@gmail.com> <179122559913.434549.12720841717630168470@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The finding is valid. Patch 3 in v3 passes the public ifaddr through
ifa6_config and initializes ifpub before hash and per-device publication, as
Ido suggested. The caller retains the reference on add errors and transfers
it on success. Thank you for the review.

pw-bot: cr

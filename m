Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01245379EE7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087889; cv=none; b=E0wDYW6Bznc4yOHIMCX8U4kguqf0KsC1XyN8p7NdNoA8i3QJrOp2CXAZEpGDeoDuD3/LIyGO0qYRuiiwsjMFtxGNjkw7LA7IGmqqzkthbp33POYhBt6/7z4FqowD2j4k47OoPic6kKs9zk/6TANRDL6lCwnzBDsxi9+JcLK4yoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087889; c=relaxed/simple;
	bh=HCuB+gFmzl0g/zR4cNGVTw4/bKbkM4diHu14JZvhNVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUwTngNjDZR+/Q7ayOR9rK8qhGy4nwISZHHnGaKjhkUunn2AVKRtbdHvm63QMKLlY/1kXdIx5CfocuStbqyUHpQ8L+ioZILe+8UuX8q9IscZwpIE2njKFrm7vmQb8RaIeNkQVeEiiymGqY801OWSt5Tayj9lcTFMRnJyGPAq0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpRU2gAB; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpRU2gAB"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso11429a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087887; x=1790692687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5WbKNwwi0AYMaZc+AxKq3GAWdEMgZbscVdbl5Zw1Yk=;
        b=BpRU2gABcXysqVKgWWLyFEnFt1g+FBXDuuOqumMIKCdArAtK2wLYru52uM2URbIhCt
         HAhxGaXNOqrdZv/R4Vvmth7+LGdhBcwgXOaGeqbsC9FInoqSydfqGizkzL0yv3x90nOu
         xBTu15DoigOtjC498pwO+Lgb+UyZ4Oq936YV4XbvRh3CYzwXxRqkxZbyw6Na8YRdKCn4
         lgdQTHfonjvFNWDRjUf/7H0Bj7qzV+IZcudE5eTtvQp0yyQuODaEJyP+RbuavF7yjcLT
         nQfOL/k1WyqNPrMzoGKS0KjmLAFVHc3ic2wPc8NP7wSN4Ga2jdQJORrWZpBNYp1343cT
         WexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087887; x=1790692687;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5WbKNwwi0AYMaZc+AxKq3GAWdEMgZbscVdbl5Zw1Yk=;
        b=Dgxd2TOBhUtKAOvjkTVVzR40e6AAF95GVobMO037ImcRhM//6V0mG/dKyQEl9mIvd2
         Q+hxoFrzSTe0UohBn/ibwWjCiYl7wjFviaaSqd/NSybGYp/A6ueKeSSfLm5ucpDsAXYo
         lpYx3j5+mYmdbxu8TBIe7x9f3NjudAA1Otl7trMWPW3FR2WiTpnoJ/fRxl7dgHhewHAT
         uywxDge+ZxZXFevfwLMJsWAsot7Dvm7Nx46ZmKapbwt+/Fafkl08kRAFVPd46iWe+nZ3
         r2iVoPaWLIXecBSAvq/NtoTOU9chf/b0rgmANVpMCfgcBsKeZjM8Em6oZhPV6uJXmIQB
         AGDA==
X-Forwarded-Encrypted: i=1; AKwUvBwZI+CQ1WE+hZBuKtN8TS3FHopLYjgV0xa6HF0bRNhFlVscLO0E7lu+L+WBC9Ayh3P9dXwzgTE=@vger.kernel.org
X-Gm-Message-State: AFuF++lfNkddZGVMGbuwFpFPx/DtkXVSDuhk9K8nMOM8CJONyuVV96nG
	BfhBNdAO0TyvJc8TBgv6iB+FDyp9sxiIIY13yKBUHX/kMs/g3cyJsLMU
X-Gm-Gg: AYBFou1VQbMFYN3t3mURLLHYkUYE5lM2omp0raR1U+ErElXNBBR91aGlyyU86U2x8rj
	lzWWau2QY8wQ0dXqM+j6Yl2JaEwdzm6+PhBG9TeaK6GU7xCldaMYg7ACx5jBJ/i9OehVAHYBDab
	7GJWANAGPSDrgo5Md4IOtso/PxxlSJejM49AbgLRH4wsdnPpYtxy6t3LvAAx39UbEe8UD6cLpG7
	S7Byha25ufnHLFLkpvBi/zGdMTIGoZFsbJlzhps++aayUDolQ7d2D/IJnLUnkD5JZMr2IOYWafh
	1+e2Wsn+LDWbHuh7/WHx35cdHud/3sr0AwjA0EToguAkusBgNGh6kJmwtVl56/DFhPDnmA1ExS9
	23hXD7DpC1YTffyktq680QHC3axYvqYoBMYbv30upcnZ4ACDLB8VyJgtHw6V41HCB4dFlNtC8QH
	uYr/ESJ/mUz+mOLcEBhHCqCvzo6UxiC6+fWkKSv2S8xCTq3I3EPC/Toeg9oHjn+qg=
X-Received: by 2002:a05:6a21:4903:b0:3dd:a006:7b38 with SMTP id adf61e73a8af0-3ddec802498mr1827982637.55.1790087887162;
        Tue, 22 Sep 2026 07:38:07 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a1d386sm1084658a12.10.2026.09.22.07.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:38:06 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ipv6: keep room for the mac header when growing the headroom
Date: Tue, 22 Sep 2026 23:37:54 +0900
Message-ID: <20260922233754.2241064-1-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <11c3ed15-9694-4b03-832f-6c49abd742d9@redhat.com>
References: <20260918-seg6-maclen-headroom-v2-1-4d370af55b2e@gmail.com> <11c3ed15-9694-4b03-832f-6c49abd742d9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 9/22/26 15:46, Paolo Abeni wrote:
> Since all the existing dst_dev_overhead() users are touched here, I
> suggest moving the max() computation inside dst_dev_overhead().

Thanks, that is what v3 does, posted before this mail:

  https://lore.kernel.org/r/20260922-seg6-maclen-headroom-v3-1-7b2f982ef79d@gmail.com

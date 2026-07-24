Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202AC3F3280
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905922; cv=none; b=ZTrBKGd7PAXm7GE9+JRKTx1sEouSqh2UKVhZgxiLOtlASp4vcPc0Qg1iXRQuTuP+9sCqdxyqvzOyT0WhKZT4DewrSz1ntIyJNrXBu9CCsK9LQCgxuVoxl9YWNRtru8VGaPamiEVdtez+gfp+6DStj1CCgpp754TJ0KpcWptbftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905922; c=relaxed/simple;
	bh=pSJ/mpu9THHCxyVaJXMtHO5kIH5BdHN/qJvYfu/IK/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rzy9mp4BD6cdn6VWjhGxriCuBlIXumVo5CZaEm85hJlAddWNeyzW6upD0+sQp+JcuMwOEL97GwC7bmQqTZ1eiUyrYcg0zh9m5SjnH6gKRYRKSyDBvqXQLOInsFJO9MkH0EanGzDRfkzHc/JIywYVu0W9d0bNNYskz2crSNSsJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=xDjVuS1k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="xDjVuS1k"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so3359675e9.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784905918; x=1785510718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pSJ/mpu9THHCxyVaJXMtHO5kIH5BdHN/qJvYfu/IK/k=;
        b=xDjVuS1klKAqe+1oMpP3HxJOwKBtHM44vRalT1fGYPj9l9+JNImXKtbdWffA7dLdKL
         a5xnOKDoPFZ+UaXd1f9sbJWutffFhKjDH1mt3CYw/Ec8Bk/K2zTpj8qy3Yiq/ZZKDrgO
         A4RmWyxZQk7hcNy5uu/fvs+AqiCoXJQ8oab+XGA+0GxSwDWRICxAbUT/71wZ6x249Va9
         8R+BBR7h4bkFzJPXqqoCZJzMGiZdQfhE333FPN+rhjSGPPeqKyglpS3TXLEkCIBUrENX
         0zodDXeFXxxWQV/hF45Wwrqah1qb6FYP/04OSiQYmvthOeKjReeHSYE9Yz9mk12uXnhg
         tkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905918; x=1785510718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pSJ/mpu9THHCxyVaJXMtHO5kIH5BdHN/qJvYfu/IK/k=;
        b=KVrMlZ4dPpCbNDz99zEcgTKLo8rGFpHyoEQ8MPPPwrb+Urtah9o02hnuZDGnWFe4JV
         rySzTguycTY7cNUcYWhsjRv3CwJyorleFSkPgonecXVrr3gUO5Vjqo5eIQstjFThIpQx
         eIeugETuG2HHVVXJRv8BtbwRwkw4a4lvS+G+MANg19iBowaErEp3Fq3PBwH0SmFtIjpT
         yhWSkZwOWyhnFXdt7RklTGbhSXZtLvnO0kuuebY8P+1u1DaJenkhSmY5PoYGOIN3LjzY
         0C4qMBbPYJuqu66MqWUmYt2q+GWYbvez//IEpXTD1Zn3FokgRmLKmrWcjoikeiEpgrHh
         WsFQ==
X-Forwarded-Encrypted: i=1; AHgh+RojB6fyDxfJEMbMNKPQmIbdLdTITVxkvCP9owDsSEJfel78BQVuupiCF5wVXsphBI6njA8U+5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyyn5p/SJWJpExXlyUP8X0HYO1djDT0VpUNal8fpUpFylh/zbQ
	61KFdshobDBo4DJKY5UZzW8evKrRbNIMUUWsJxjQgyPaesSqCJKfU5LfKadYg7/HeDP7
X-Gm-Gg: AR+sD107gQoFIaLRObn2xYbY5Q5k+7N39myjm0WmALIXMrjFUfgqxLreQ5VcGPNKjuc
	cZFj60ELe4HK3lfSX7AjD/QvW3GPFVH07sdGQTvkvjuHfuYdMF7DmzG9TRpwMNTMfPou1THpPXv
	rq9zcJ92C+MCQr1gwoPeUBReWrFPHXQ4GGRC0QdSLIsmLVc+KkXRLvRiZY4tgJq6xZHRdc8483m
	ly4mgqEm48PiwF7ytr9FLL+EbLdHHbiWUWD0IC01PZkitpyAbaSE+L9RwXhDzC10snlgbBY6rpG
	c2XKN5hv41ahyph+qMGUjAZ4ex/whASkyWI9GfcGwrgl+3DMp5A+ifBBTj2OPQ7iiekvk49y2vl
	F9Ys5S1MDKrFw3IWE+2qIiw6b2K0QyxlX10Fa9/wR1XM/Ekpv+enfqqBi6qkQAQYylDsoud3pGb
	N3YW43BR0IimDi/Jy0gLcVfJOGPGGHfGrjFiOnuo0utC/a+ny0disn+OnXY99AZbpmiEntPeUpi
	g0Q1wOzY2lrXEf2FhS9ysYAIA==
X-Received: by 2002:a05:600c:c492:b0:492:3754:15f2 with SMTP id 5b1f17b1804b1-49573ce95b2mr105427725e9.32.1784905918158;
        Fri, 24 Jul 2026 08:11:58 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4058c21sm525885e9.1.2026.07.24.08.11.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 08:11:57 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Mina Almasry <almasrymina@google.com>
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] netdev: require admin permission for the bind-tx netlink operation
Date: Fri, 24 Jul 2026 17:11:55 +0200
Message-ID: <20260724151155.74551-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724150156.72816-1-doruk@0sec.ai>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It's intentional that NET_ADMIN is needed for RX but not TX. Maybe add
> that to the documentation.

Thanks, that makes sense: the RX binding exposes other traffic on the
queue, while a TX binding only sends the caller's own memory. Sorry for
the noise. Please drop this patch.

-Doruk

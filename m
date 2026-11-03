Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709122;
	b=irspiZq0IMZePZ8KRGJGowsnt5+AMnl5FkhmUOXPjx9Hl+mNrjx3lWn29H0PLDax5uTl
	 vCXh8+tTlBEojN74iP0zZKVvc43BORsEQ0b6lTqw5OKCfLEmSLxZGFKs5md+q1xUDCrnx
	 FBvNIWZSp80BNzcvWSfqRuYEHvQmZBf/nfcSXYOJF44eERI5g+Ln4lLy2o0QgK/VmdcHa
	 vy+AFblOtv++N94G3hJgH9mPk+E9ep3Ng9WvkHIuwPUkykwwOBQAMoJTIDs0xFXiowOJe
	 fviGcKV35+1NmwV4s0cwvoCS6J3F/SleFJENi1PgVFpVA4JR8wlnmDujvOmyhhHC72Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=IIfayYr3RFxyM2EsZlquLXo5wwHb0/isaRrVtj+Bh6Q=;
	b=Bx+U5MsVrRoPgXwxdtUARW541/hN/aMafbjM3K06IVs8HIbYlIt5wENeh/2h1RjAoOyv
	 dG9D/zlqCittj644FYitoUUAy0/CP+NtVS/qCO5b014padGLvPzXpNnNeRb9Owv7yIOmK
	 Ezd4f7xJrP1KbdoDilQ6cToKDfs6DfJ03kw6LwUc1+pMvQzOWdVV3F/YvhB+t6siHiemv
	 H2ZOZs4A4UH/S39Ep4mtPyCVb9VWXw4mgjZidXj2qIzPohYxpqavsQ2yH1OxN0He50MhA
	 Q7u+x23X1lYXSQXvKg4bKtqlUYjyPkFFJ4mOtBUP75oE5OzfVrE8uFJkBJhPPlmNLOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=wW5Sb8Bh;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D8606A330
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 951D8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=wW5Sb8Bh
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bfbc67991cso2720812e87.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793709119; x=1794313919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IIfayYr3RFxyM2EsZlquLXo5wwHb0/isaRrVtj+Bh6Q=;
        b=wW5Sb8Bh1tOSyGxMONymW2Vgt9LtgwvewWE3HdVh0cNKhUCkJ/YCPaEPxV9Ihr422L
         HyjMb5JsoDLbqcJSqhfZO34LE8WMGK70+JC/vz0DFTgNW5faDqqJczrOPqhedMpvy/7f
         mvt6q07q+UtCxxElc7JUCoCImPQ7uE3q3emliaxs3+TkpL83NAhzBTaV+hpVrRvA5OB7
         2fxj1g+zKHunZsWpo/2qWrqrD+x9xwKugBRhCk+DsP/HsdZR1btPOzjItqnSuAAU/utq
         eS0r5SYLcARtF49KqRWddUtulh6agloHpu+759V5ENZdj4Sojbl4mOsew/qSbyiez4Ep
         1J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709119; x=1794313919;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIfayYr3RFxyM2EsZlquLXo5wwHb0/isaRrVtj+Bh6Q=;
        b=XvKzUP6nu6ZGr8D4MWszJuVFBBgyB2EJYyzY2mlaAD7X40S9qpuFNCR9vBjzNwiaU9
         14e9l/DErMrmz6viPlDCIS3S2Kj9v6tGbpsQZXkVFZCXhmFFrRX3wVGlIWzo1hfzJuha
         JnxBcEpNgRtfaF4ZXUbG9utaGF65oN94vnC8ZU7urbQSc33hCAuxhpBMcjvluFLNHh3p
         04sMgS2NDvcpQzeQbZJGC+kYZkoF3gCpkAofU8Q9pdYfnLOvWNFELU0Y8+MGhx5tEJnT
         OdCB8Q1gjqZfqjd/LXt2g3gWDY5a792GOYU+0anonOZy2nKLwRm9yxRrfHTaejE503cn
         8NJg==
X-Gm-Message-State: APuU4Z/t1ghv4wM+qAYaKYKHqG8b9YB7yN/8MB0ByrPjlm0QdJ+2erVA
	r+GICYf9QZk2NtLDds7eE6ah+t5LTLzzkkyLjpmJjrlCS+puzeoJm+29ODqDgraoc+0=
X-Gm-Gg: AYBFou3MOycDem8ZxwA4Dv4riVRkqP+/k2TpntrQGH2n9eGy5Jg9v+zQdYRYNn/z9kR
	KSDi1LQbM1zIenB/ngw1rVhw7luhW0EAp97BfPIeYr7nNLp3f/xEz2KKT3XbzNYEnrmwr1Y0amk
	B+itQ65RE2KeqxZUqrn0RZ/hCF+5ZcrdCOjgiYH1C6ESF7gmyqXEXEu8oaombwllOSoJvDWqzWd
	SBSGpwaxjaPOk0ydVpvQx4WEyBLox5i1sdW9DBtaYmiEVVDkAvoYk+/yyA+75wLYDRwtiKUQHqO
	AMRFX3203dHySJO9vcna8v12ZFBdhyKdXoethbhbKIwJT+a83hWk5zUFcJDtfmYgZc8afgLY/ef
	EjuAMWW5GC/VkuqOH/wMhcZXiXHzeaaWSyO7Qdj8o/73jlPZIwBR/udaiq122O9TcTe+KjMEcW0
	ZuBfUb6ahnBGKIstwNCQTg83+rD9WksSAxMDLEuefMYWqcva7OVqHvYDWzyWUHViyY7SIXVBvR2
	LiBwihDDZ1Jzgk1gnWL5Mo8O2idwtUkrYHPw17BSzUimczn2iaxlyqOPuo1yVPrwTXZQq4RaEPo
	rr5sGeT/fYAT18NUY5xZJNcGVRd63IyIlNiW
X-Received: by 2002:a05:6512:31c7:b0:5bf:cfcc:5440 with SMTP id 2adb3069b0e04-5bfd951d842mr4004970e87.8.1793709118568;
        Tue, 03 Nov 2026 04:31:58 -0800 (PST)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfea410206sm964002e87.10.2026.11.03.04.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:31:57 -0800 (PST)
Date: Tue, 3 Nov 2026 13:31:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 00/14] dpll: add a simulated DPLL device driver
Message-ID: <aunT5wlkgVJ9xyTb@FV6GYCPJ69>
References: <20261103093910.596225-1-poros@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103093910.596225-1-poros@redhat.com>

Tue, Nov 03, 2026 at 10:38:56AM +0100, poros@redhat.com wrote:
>The DPLL subsystem has no in-tree driver that can run without real
>hardware, so core changes and userspace tooling are hard to exercise in
>CI, and the pin-on-pin and reference sync paths see almost no coverage
>outside the vendors' labs. This series adds dpllsim, a simulated DPLL
>device driver, together with selftests that run against it.
>
>The driver is controlled through configfs, following gpio-sim. Writing a

Why not debugfs? Works good for netdevsim.

[..]

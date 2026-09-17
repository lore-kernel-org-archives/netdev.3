Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62E3B52F8
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634930; cv=none; b=FSMXucVR59BbeKZX2o8sjjBJZAku+hno1V+Rk2A/iDj0+lthL6FGKE0RlJ0k/kTkZVMiuGe3Au/uinx+BIgV1EXfeHZ01zOtFltaT0LV8ZdxhNg5eDqwEaoMDN/DJL+gd77nZeND/P8yR6Q2eEaOAdG2dK7hpvZ2DPE5iNFztvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634930; c=relaxed/simple;
	bh=dkg1IYm5SwvVJKM3slpCRiOP0OnA2rrvfylDB0blPfM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=cEwOg2sAMFkL5qgTygPNLvUxQt5RLvFf3LJlTZSb5cRRFPZbcRGrj6+I/cUUVcWnOTJGUL31IQoMzi6kR0o8xmNhzBcwATyb90dOyu4Khsq4PYucIATq2NIJ3l6OoFv0uR/LTyiVkDO/QxH/RPN/eAfS7yhSsLFltY3iWJU9amQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYgRtlOR; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYgRtlOR"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9a2b95b72so927776a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789634922; x=1790239722; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0vllss9Q3PywDs5cpoHaC4Co0g8le+yNhbk6iy+FRPs=;
        b=jYgRtlORziRfGYGsjW6FXVXTe7No6rI9Opp2jLGe/hmTlkfPKjLXs5G/gDcus52MSV
         L5wRtmUJOGse2HOz/MALqmg5p91xx2+vw8CV2WF00F6CZs5x0k9ebgBuquApcNL2lXMl
         OA1LCPWt1wwQhizm7gNmsl5ko/esFyYuf3NsfbL/gR3ImCydQSEcCE0gifWj4fxYhTq/
         fSOuPifOsvUOLqyHP5tbDik67BQF+bD/9P5wVxtL5ZGgXUUNlxF0yKjdOoidHFtyvjSN
         LOstIhhbn68PHpFk+Lr5cuByDiMp0cgJPESOUkMowWBnoREG05uqirUZVXz5GwBsswS8
         d50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789634922; x=1790239722;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0vllss9Q3PywDs5cpoHaC4Co0g8le+yNhbk6iy+FRPs=;
        b=OfHDdMW3N1KJMDc9t/A1a2SIvi+Zke+JSzb6J4lA+9srCS8LS+9ICLeDAQYdBge3CA
         eV7TP44ejq5qzOGCf2QdVI/QSnbod8AxSiZF8kQ/K8unW+duprGriIz9OdWMs+vnXBgL
         Lm28AfKVmsIH+0T3brwNYXz7/VV5viQLUJqibZIjqJmzHLKDFe9Omahba3PL2AaG7rtW
         F328nKKWivschzdlYZUebtl8Hq5NvkbdEfNlJmnCuBWcXhpqQHvfLvDJ6/S80OeUwt+1
         JPX6qfUjdOFvrrwv2BfpgBzHzRLQNnEswQJnjLwOWbnOGUWzwkODWt4IUCWc5zmDz1Km
         s1OQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+tK8dPJMLiOwAxzmFUnGqMSV1L/yMEbwxJ2gwBHOX6aFgyTPRm8avjRDAGjA9XIKeY2eb+cI=@vger.kernel.org
X-Gm-Message-State: AFuF++mt4uCN5nY8oKjT7HBlBDGMLc1QA3TiWLQKl59g/O3gxTXwBbQf
	Bao7dWVKey5Z5YimRyVleuNc1MvIoPQFmnz6JUsr8WXCdDcJm2XxtORp
X-Gm-Gg: AYBFou0Vff5xwERLQlWRv1r9Iq9bG5ya2BpJpVg2ax8kTzwX6c1LpOv0u2Eo+Rb5Mqh
	gsZ3HRTmSIZoh15IxFvnxDVZklGaeEMmYB5v+fCOAA3J7l+KEXV/ZJiO3OVzJ0vy7oLRcn+IiOs
	ePv/f3yOJ88hHLMszkybtYKSDI0W8zqOgMqkavmSs3clxmHX+0vtHi36DjnwF/aHkOlvXYfJaQY
	b05zSspibgAjo8dLcT/9uVNqNHB7ZxLAPOvg5jJFXxIM4mH1CVoPJQdoQ2cMZQ40fjG9zi3HOkX
	xywKGvMZ+upoXx+itQz1ql6k3inOhDE8GvB/zNqlHALU3SXnyhJurolniE2GMluaLcD41KwKjmn
	qPbr1u0Xly4s+HToe2qVriG8yv9FgjoknFyDTiiOR+1OclLuzDk7hQ4/mtuvd9KrAfDlVPdqPJi
	sRV6TQCURkcITR3Gw4YXpqSfQvHKKDJB5NSnCwllpYLBYbOEzE8ynPqiHGmwA+tLkUbTf09F0Qi
	OJE0kAle/p4sG7rKfg=
X-Received: by 2002:a17:907:c648:20b0:c29:f47d:3480 with SMTP id a640c23a62f3a-c29f47d3b02mr144827666b.11.1789634921642;
        Thu, 17 Sep 2026 01:48:41 -0700 (PDT)
Received: from imac ([150.228.9.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de45452asm258549866b.21.2026.09.17.01.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:48:41 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Taylor Bates <tmbates12@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Stanislav Fomichev <sdf@fomichev.me>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] netlink: specs: fix duplicate if/then keys
 in netlink-raw schema
In-Reply-To: <20260914-ynl-robustness-v2-1-c6125003b21e@gmail.com>
Date: Thu, 17 Sep 2026 09:35:07 +0100
Message-ID: <m2ecesp96s.fsf@gmail.com>
References: <20260914-ynl-robustness-v2-1-c6125003b21e@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Bates <tmbates12@gmail.com> writes:

> Currently netlink-raw.yaml contains two if keys and two then keys in a
> single mapping that enforces a "len" for "pad" members and a "len" or
> "struct" for binary members.
>
> During validation PyYAML resolves duplicate keys last-wins, so only the
> binary rule survives. Pad has not been validated since commit
> bf08f32c8ced ("tools/net/ynl: Add support for nested structs") added
> the second if/then pair in January 2024.
>
> None of the current specs violate this rule, but this validation should
> not be parser dependent and unspecified. Strict YAML validators such as
> Red Hat's VS Code YAML extension and Adrien Verge's yamllint will
> reject the netlink-raw.yaml schema:
>
> Command:
>   $ yamllint Documentation/netlink/netlink-raw.yaml
>
> Output:
>   185:13    error    duplication of key "if" in mapping  (key-duplicates)
>   189:13    error    duplication of key "then" in mapping  (key-duplicates)
>
> The following invalid netlink family spec will pass validation in the
> current ynl tooling:
>
>   # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>   ---
>   name: minimal-raw
>   doc: Minimal netlink-raw family for schema validation testing.
>   protocol: netlink-raw
>   protonum: 0
>
>   definitions:
>     -
>       name: test-struct
>       type: struct
>       members:
>         -
>           name: reserved
>           type: pad
>           # len intentionally omitted
>
>   attribute-sets: []
>
>   operations:
>     list: []
>
> Signed-off-by: Taylor Bates <tmbates12@gmail.com>

Good catch. We have a lint check on the specs but not the schemas. Maybe
need to add that.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

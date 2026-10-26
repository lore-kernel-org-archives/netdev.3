Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019427;
	b=lFiyURgmQpuebim8lABQxjLQyKDqOgXiS4zkgqIaHxqpAthfguHPBM7xVPoeU8D6sMu/
	 +LfE+A09dECvP+SboFvIdNc1iAdVeHpLKpku307uAYu97Pv/zkp6+GGY6ABaHPRQ1mK59
	 +vuXe6BzavdpEl9yetS29swss66seazmQY55z/jMLqb+glyEb5tn7/+19Cc1iiip78V/P
	 1WijefqD1/MIcJRBHUfnWxlSgI0LnONuEIAwfEnwd7+xD93WBC/tl4E6UFoe3begXeZIc
	 mbwCiJx8hlm2/yXDYC/6+KwsbnXVZB5pbnhUcl0qONSJV8XXHnZYrPyNKpaQSxhFFMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D2v0JRY5M4Fs7mPbrdRd3LMYAN2QFKSzquXFbvN/NKg=;
	b=DILkDcLoFMhGRFIKrflzxOD49AzIwiXCnKuTtUAY+5GGmw2gnIclXKH4HiuHQTXxXVPD
	 ZB2g5vElOY8xxxJmWslD7Prb5cjx17Sg0Xow/EmxGIv84koOmtRVHKD9ZnPyn/nLPC7qz
	 puWQnatG/V8v8VOGh0nXvTV11btwozZPNL84WjhjInK/qT62U5SadYlOap8yEEw1urLY0
	 Hh8Aa/76BIFkg35cz8YJ4Byj0+hbc6pLdn3joLRPWtT8gDLDvm3dVF0a87mzAWssUUdjj
	 f2K91s8QxpzKgFXfL5CKI6Ai6IYAS0PxIoeUwrlFr8+ahvexwsZ8nLj7qQjaxTl+trg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kSdmWuAC;
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D8606A334
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51D8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kSdmWuAC
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-675676afc3cso3352285d50.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793019425; x=1793624225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D2v0JRY5M4Fs7mPbrdRd3LMYAN2QFKSzquXFbvN/NKg=;
        b=kSdmWuACxN4qA9ISX1xWgBnx8QJT6BQGHqMeDqoeLsxf/MOTIPIFmoI6TEu02s7hXT
         gT1i5//L1Pu5tgmWyFCaAB0W15Fviwr2kc9aO4ZbClsqSzK64GNrQbQoC3OBWpVaG62V
         PguuvpigF9PDMnjQXzkQqEmbPPgysvxJZkHSADIgP3uVAEzhCUOeoS9UYectm+xrzA5y
         jysSfYKHwFxhrqaduXeZU3oKzc9Kzn87dL6c4qCcf38b5+677b20TmF4DbPMMNiLMhOl
         BlnLkkfrS/SnW/BvG2dhWtVTtL4ivxD4uFQZPWrU/ttnn/ayW9CJB2pWpoI6VKs1ifL4
         5aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019425; x=1793624225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D2v0JRY5M4Fs7mPbrdRd3LMYAN2QFKSzquXFbvN/NKg=;
        b=A7hQanozAPXh8p2FqwnNMXxEJHo94kIgbPfJjgaoayJT7qJG+L0RIjJs3dmBurQw9v
         LYtbV+uZhwndZ1GiSG3QB5BXSivC5yR7hp4jGECz1dLFpn8+z6NaYGlDhegrtwpqHnlC
         Cmg+r25o+sGSC8w0f9h4HjXeY9iM2kyV5Z0DZ7UFmtL6VinBRLVnF0LNhrScVMjX9gQm
         Nga8KAgWNyWUw32Ux3QPgRdSh5wuMiJlwbqhvWCbFwFDTfHRvDK9ffIJLzsOwXP6mZva
         zoqT1GdqK8tziKbshkHr1e6PhtZ559KnNjeuBVvHcBnn9I46KkBWt1Xce7RFYP3TYyul
         M/uA==
X-Gm-Message-State: AFq9FYKMeoXTlTaIVz58oumwMB1wB84KaR+Esb8RfmTUClJdCeCzR8tw
	Z7MCP1dYgJNa3sM8LUjOeFKl2ff9tKNiL7jzPqMS+3wG5cmZLgM09P8+0Ek1OlQOsg==
X-Gm-Gg: AYBFou1oG42+Gq5m5jNHOGLWjC2gn2PjqdAt1wflu3ARDlfOsb7PlYxSm73a67CTjK2
	hYvjd78zRrcpCnu9rU41ZVBd5BYkNNKP1Lh3w0twOMx/1r7o7CDQdr4VzSNy10O0NkM+wm92K50
	yOTcB787Rtz9rQJJoxjS2Y+JPzW+bgYaGHCa+P0bsuPSi9ZWfAUCSPGJJf90vg+IIgFkfgO1kTL
	4XtQLN7EOFgwQ9G3JP5brJJoG1cBdY4lmm9x0mNW2yk0PnJSsa3uZ8v3jE3+KNyKFmi6GqsRCyX
	VFFw8GtIbttzaWnN/YTZCIgKh7wW76mYAnxAFtegf5BbEoneRQE5b9A/ettXbfQCTclroiV5d2G
	y0qJ0DImVAV7lscWnc8Y+3csqDZMyBdK2ZCs2GZ75AjTjyw+pHJB3F6ZNTUOJgyPI7nYqzc+tm8
	ClMPHplGcTS+y6isQ2se3oCdtX0Tb+mxuzNBtDnEXrqmdw+OwqkEbeRHi45srOXY/Q48z9AECse
	ubmpoERn5jjdPxNlyMEZnRlh87yXsg6KwyQSBt5oPL7rACB2pzGW5xYqPmJS4rVLvajF3qJNwhb
	ng0=
X-Received: by 2002:a53:cec1:0:b0:679:b519:beac with SMTP id 956f58d0204a3-67a4544df2emr2738981d50.55.1793019425415;
        Mon, 26 Oct 2026 05:57:05 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a462a2e74sm3315307d50.18.2026.10.26.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:57:05 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: gnault@redhat.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jchapman@katalix.com,
	tparkin@katalix.com
Subject: Re: [PATCH net] l2tp: only return sessions of the given tunnel in l2tp_session_get()
Date: Mon, 26 Oct 2026 08:57:02 -0400
Message-ID: <20261026125702.3101778-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at8-2mFyrmPxfu29@debian>
References: <at8-2mFyrmPxfu29@debian>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Guillaume,

Thanks for looking at this.

I wasn't sure about the intended semantics. l2tp.rst says "L2TPv3
session ids are unique across all tunnels", but it also says Linux
allows the same ID in different tunnels, told apart by sk, and
l2tp_session_register() still allows that for UDP encap.

The patch only changes callers of l2tp_session_get() that pass a
tunnel_id, and the result differs from v6.8:

 - pppol2tp_connect() for session 5 in tunnel 2 fails with EEXIST if
   tunnel 1 (another UDP socket) already has a connected session 5.
 - "ip l2tp del session tunnel_id 4 session_id 7" deletes tunnel 3's
   session 7 when only tunnel 3 has it. On v6.8 it fails. l2tp.rst
   describes CONN_ID there as the parent tunnel of the session.

Am I misreading the documentation, is the documentation out of date, or
is this behaviour not intended?

Thanks,
Hengyu

Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC744A3FC
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047877; cv=none; b=TMsaqZ1osoatYuRDpA5qu0Z3W0igzuP9+Joh3UTeRH9VL1xpJqq2+Ul16vrCLQS4lZg8qC0DyLn/Ld4YVnbfwfilGilznlQ5n+DkgqjsiaoTHonjAyBhGnJaozqQcYgG0yrLi8No3dFdmt80HlBFVHHLrTpwKTXA1Lau59/sOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047877; c=relaxed/simple;
	bh=CRb+/GDGaTVniE3+kbPEe0gJUuOEfddvyPixUMU+uhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVuqOUFRPyfrjvbnqGh60NLTAUmtM+7gOhhuChDVfG4AUaU3C1wCRydM5jLyCafQE+Ik2sgJcWTz4e2LYd69Si4ybTNv2Q7wbkUWC+pw1Br1KS62e419M8xyQLavYUjoVSfrB2BdImM5K8EMjNOek38j8BfuKYJes+4BYSuPBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFUqsCaJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFUqsCaJ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc891373e0so57621945ad.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787047875; x=1787652675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CRb+/GDGaTVniE3+kbPEe0gJUuOEfddvyPixUMU+uhg=;
        b=LFUqsCaJmt1acpYO2dioNo5MuJ2S0Ch9AB8Vnel3mEaZD39vxqleybaI1TnZlXb78H
         texc2iaTaI0RhNfh16yXhw3bTKVFsDlQHhMs4aUXZ1JuNoUNqCgxZ7vPjpaMDd3+ecYP
         nRZpPc2l4eeezgep3Wsj2pb6ESzkSxwejNqP9EOxPv/78HRGJSWAn6dSwX5CsIcS6xoq
         asQpMEwNSTPDeRCSPfrqR64Bj9rLsoLkZjZhHXNVapCYXndMgJoitq5TVdICEVRkkUKh
         +UHIG2QBYEHXaMkRIFW7hJWnleOuNxl7fG4Oz41jO8mcY49I6PWTO0RnJM10VWv2AQL4
         LqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787047875; x=1787652675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CRb+/GDGaTVniE3+kbPEe0gJUuOEfddvyPixUMU+uhg=;
        b=PBlaIjkUKh7hx5qV1P9Wo36JBER50IoxRTj4YOugJOC2Lk6kE2tZ2mLyWGB1ywl095
         CxI8xnZBruYxBP2dAxaxFRi8R16h0uVjaPsBF4qDvz7UelKd6XUrBvseG0/Qt8unC1Lc
         76vYZxYZr1Iz6/2UrGQSn+Ol2hb5GIQZAKum8xU2xAlcsi0TeD/ddol/17Yy+JFWV/JZ
         0ryK8X/DzBCBirXQLyt/6vedgsH6elXHx7yVtOnGLBlDj+j2rwykuViSzZpjBRZ6KVce
         7dLyLuvAEer4eMTdGCavnlsW1EAaFs+1fIqV3xVPjZtfaJbBgPRp+QFrd0UGR5m9Qrbi
         NBug==
X-Gm-Message-State: AOJu0YxxaSsamo++RrIBPOwkJV0k9rgjvh6NcENo5eJC01icSnz0hF26
	srZnWMTdrriFEHEUgTEZVh8DyxJE9GxefeeGSDP3sQFQfvti3tMMuI4/
X-Gm-Gg: AR+sD111VAWUYictM2ZRpqxhnjhjos5ze2s8EGRT8hfHbPifQNGPMLC9r96Wwhp5k0O
	2JmB2tc6Pjo3tCJ73MIVdCqrhhNdUTDH1o+2BWOh9xbNPWX4gfmOVBJsXtqH1pp2z14N1UFltyn
	7Al6Prn8Vb2V9qaZv2pGjB8Rl8GuIMaaKoHnaiOBGX+kpKPSIHHPtKukItrFACjqA6vsLoXyYR/
	8GnZ0eCFoBJppx2N5Q4o3P7O0tRQo7VuY+9gZOtH7kspb5/KxA/sYAyPAkKeUXpmPTIwbhet9Bl
	+fDutA80aVZLGa/6WB1GBoDwkLDEgmKimD2Nql778gXoSCJIExip8XLw/OTh3+bOYpHn2+bn6Su
	NMS7GN+qr7CoIbtZVu01wVE415HaG/3lrHo0/Q/4kItWvt/2vFqpFqzCf/xXExI7xUU4C8gXmMB
	M9Y0phULtkVcjrXyjYPI1dXKuASJFJCdLAlwQ4ThT0d/r+OKmdLbqHFxTqvQNqFRcNuizwhGlbp
	yc=
X-Received: by 2002:a17:903:1965:b0:2c0:e5ee:f55e with SMTP id d9443c01a7336-2d3b0db9f3cmr358155475ad.7.1787047874848;
        Tue, 18 Aug 2026 03:11:14 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2d5c1e5506asm12784955ad.43.2026.08.18.03.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:11:13 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
Date: Tue, 18 Aug 2026 10:11:07 +0000
Message-ID: <20260818101107.460476-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817152350.573c4eff@pumpkin>
References: <20260817152350.573c4eff@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you Tung Quang Nguyen and David Laight for the suggestions.

> Should the TIPC_MAX_BEARER_NAME requirement be spelled out in the comment
> or in the prototype, so that the interface and the body agree?
> In the current tree there is no behavioural change: the only caller is
> __tipc_nl_add_monitor() in net/tipc/monitor.c, which declares
> char bearer_name[TIPC_MAX_BEARER_NAME], and the source is
> char name[TIPC_MAX_BEARER_NAME] in struct tipc_bearer, so the copy can
> neither truncate nor overflow.
> The strscpy() return value is also discarded, so a future caller passing a
> smaller buffer would get a silently truncated name plus a return of 0.
> Would passing a size_t len from the caller (sizeof(bearer_name)) and
> forwarding strscpy()'s -E2BIG through the existing int return be preferable
> to a hard-coded bound?

I will update the patch with the above fixes and send the new version after Aug 31st.

Regards,
Ajith P V


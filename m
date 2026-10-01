Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92A3ADB97
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865163; cv=none; b=soRO+R4qwBIEZWdFlN1jwtHRrHWFDn2mG+Bg+trUTp6h3sMZO4KdglpxefiBsLPaNvcGDur9m9ivXQzVdl/bpg6MgUa0Dh185BvVzEm/gQaTPABRkndQUd5pSyX1dQ0CxCyY+2SxMIb3iybN7dj5zQVmcCwy9/okP3nhhFzGId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865163; c=relaxed/simple;
	bh=wzzViGtuG6ont1dJ14oM1FNYXdtgFlMYQZlw7fnaS6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gadYOk0wiW16XBm/sNniPGjQHTAbdacLewU76djYva/537fZsq+sVJ7lTE+N4g+7zmH+jeDxd5ubNMeg0X3E8LgO38ImHXcUAbOhCVZ3CHpBIbYuGljhIccGm6/WNf27aGo8tpYe0xIZJdBDFhQTNaw6elmFEdNjlOdLflRsMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsZn1cOs; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsZn1cOs"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so3206595a91.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790865155; x=1791469955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzzViGtuG6ont1dJ14oM1FNYXdtgFlMYQZlw7fnaS6o=;
        b=QsZn1cOsGW9gJSBEr3AUiFhi6dDv+lG34xs3Mef8LiBafeYJX+skrBT1NBhIXQBHYU
         jj6xuMT2tnJjwDESvv86Uw/zRnqEpEafJoeH2K+xv1hper6uzTKGj1f4bL6FcCpfTGd0
         EvmA2hfwBKytksucyYSD16iM6S8wtFJL25V5FkbDM+tHGtKJRt/slN7TnmiqxYxjtEwe
         Aroktd7xX0WaeBpkrdLqQNtC1matuazrPpiMuSAnxk5rAWXCrHCszGKMOSI6IAY6ra5g
         vwnLdPqafMdKVpNxDJ8dtR6+BvmPgvh1Gx/E7/CEG7/YHPzbVreCoEpLY9HVmGM1uoZb
         z+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865155; x=1791469955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzzViGtuG6ont1dJ14oM1FNYXdtgFlMYQZlw7fnaS6o=;
        b=OswAaF5oPAYUDm6FW8W9LVx97DdjAQ6X+FtGRggIzvsyYNa4X81MePtU54Qh/qvPJE
         +3ARnMalcD+utI6L5FKQC1+dF6gtRcKxjBx/786+YviMv130YBQ67aqDtFBg41vk/+Dp
         P5nObHTJdH3M/Ox07prJYegkC2+WpKPu2zS1WEagjNQEVYhzYE02da4pAFWeiuAN+37r
         lPQKq+B3Lc8RbMwhfHwF4gXAQ6ZUMbBY8VyLFwJqqiQOQoMad1WxRnibPIulM4VH/gQ6
         joFUvJWRUXL7c1UGb6yAFJTyIKjqW96v+6Rw0260WovGYkXkQ9+8cjqNr8GXG+UpmGsM
         HmHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLXg4YeKA9R9ta9wFbfLtosdKolSJFpWuhIP/+9KjJC8Cds93YP/9EqSAQIbnqnxDQJaTYDJ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLre6P7gs91aaQdMRWzMUXaou4gusEk57c1wD7rX68J1f5ooXF6
	hdz1TW1dRhVSXh6UbaNbOG09Wpfps8/VBC4ECkbjYek6kVE+p2jK6fi7
X-Gm-Gg: AYBFou3P3hlz2SOV4fxxPP8bfYg1WA9LZVmrtuyRkBrcqOV6T/e/QybdSxQ0pSwxVMA
	cxCmzq3sOBlWxBw0EOs3U2NWgtzYp2mG7M810pQCNZb3nswofjLia+rtoMhi7OAfKmnO6xsTP6b
	OoQri304YcQwHUjP2JJbn41PEKbwHR9/wLovk/A5mkroPajH9rx1xCnOH+XCKD1RtU839q9Mp1D
	UX4UweO9zyvSZjvPg7nURQsZ6qFeDozj+7WfPF1zLZEaUYhdq4DJ0nQMkVcNEdNW2fAA6ox7t9G
	bXwPMT8YJ+0UexEA1LhW+Y5RhfnB+sgzafL57DJgGiryGfTJTzsrIz8doLwPDeGmCFsYFxIm64/
	bLyJxkgmP/YgXHwI28XMW6oC8/cTbnFXf+3s1ro/u6Q4rNG2kNoad+s0vMuO+8CSpRUXpukGO/3
	Zj19dblGGe/hprXiWrsGrQjG8+N4hJx5kGbso7e0QVKiBsjQsup0zVxZcQshAogX66X3P7tW7mf
	ZfAezTW0HU=
X-Received: by 2002:a17:90b:2b44:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3a4d1509d61mr3979683a91.18.1790865155377;
        Thu, 01 Oct 2026 07:32:35 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f478e750sm4964487a91.13.2026.10.01.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:32:34 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: account only unread bytes in read_skb()
Date: Thu,  1 Oct 2026 23:32:21 +0900
Message-ID: <20261001143221.3856511-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179085716831.31693.13222203434770065965@kernel.org>
References: <20261001121541.2983379-1-4ncienth@gmail.com> <179085716831.31693.13222203434770065965@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks. I found this during an LLM-assisted manual source audit of VSOCK
receive accounting while re-evaluating virtio_transport_read_skb() after
CVE-2024-50169. I then confirmed it on vulnerable and fixed kernels using a
connected CID_LOCAL stream and a real SK_SKB/SOCKMAP verdict path.

Thanks,
Daehyeon

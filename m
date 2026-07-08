Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4D438025
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529644; cv=none; b=OsglbrysdoLHa9MEP/WIZBk2IePDbhqky9ufQyBuQQ6FGia6G7kZ+tDHvEjAR95CjYOGCfodSzevBqhC36U4t/FEugdLKQAEPSMLOq5S2WKpbI51Ud2z1to8xMb2uGZ8UWg5CccmSO1I+A4WKQ2GQAZQSNI/boa3NtMbMyosUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529644; c=relaxed/simple;
	bh=xCYFMAjgPJDY/t9Mmqrv/XueFYFlFyqzJG0g30NW4Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkEqPiRg0X4/UEyfTsEhYzokMpuHtXqhUentDuC76yWf3tUIYIGI7pZtz1uWTOKnJoJjhwNjbjhzTikNaUhju8fOLgmWm3NvOACwJYTz6lv2QwPaaEzK+fWTsREJadPhz5rSVUfBdz9XysPHtBDVyOVeD2GaemdN+fuJ/4k00Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvr+HOy3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvr+HOy3"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf4496889so524055ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783529642; x=1784134442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCYFMAjgPJDY/t9Mmqrv/XueFYFlFyqzJG0g30NW4Ck=;
        b=pvr+HOy33mjsK7v89RXUXWxlpIQ5FhE0wnFMAHBM4gw0aEw1KKwpLl5Eij5Bw3Eh6b
         zYjHolr/4XtPoK69NUHWRDJCkg7+9N2Ed27zhz+w1ZQ/2KY6AKNzTRqQx5lccCYcXQUF
         37muZV/C5Cu9K/6RkBT0vj6Dz3Lqzeb/jZWB+w50/ec+Duzbvu4H1XmwG6iPELIcEJW4
         3RFYcZhdmlFEOWETaoNZaCLPXG4iRL/cKS4Yn+HqwnJA0CUX7dh2FsjlsmWOFZeWfrI3
         DegO/Xnna0z2GR3GTrbaFd6G0qN132PDoAypk7fFzVfob55btihvnuHiL0PzlTwiNmLI
         Jx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783529642; x=1784134442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xCYFMAjgPJDY/t9Mmqrv/XueFYFlFyqzJG0g30NW4Ck=;
        b=V5NMCgbqXjtdy5aoV+4Eb1kZ6IIjDi+VNRDzVZ8MOk7n7bXQVzg/JpOz4yeP8q/PWC
         tdIs6Qgr9b6DRehAk+dXqwGKTOfEXvYU00OcBvcIM2CbMoehZ1M1aBewEVigTFEXDsow
         Ioi7Csr4g2uyhmUSeZKiTAa8lMDl5f7zrcwQCaGO6DEadKACF0ssuig0f+i4PgXnw2L+
         LgrKB+JF01ZVXTkSZciFeG0Rle1gMQu/hubk0OMLxgN7jrqV6kCpMC7MLkwnARNEouQo
         vt3qsMdpIulqbZ+owpF5JyWe4Doq2zR8WxYrAk7oE+tlDSTzk1kOhRkwm2/+AzA479kl
         3sqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjkgNcVgKDSJDRUut5mgnVtQj/owE+dSe9F9e2afMQr7el/dsKeU1Wjug19kPfuxaYsHRV6PE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8eh0bVHhD2xRvCzEY6mTAyZipNF5U3h4C4UPWBrv9ZP0/Jqk
	ReL2xWxy24Wobn67qv8ZxaCax2ZVlxcjN8JnNdNAoVBGSy4lCpc1WaVX
X-Gm-Gg: AfdE7cmO+LDDvXjBO+4oh92ePhR7KWmqUPRv7m/SXGs22YjBzBptCkORs6bkS7+SLb8
	wmU1Vryc4UGec4GmM4rRGb8hqMTou9Vkn8mgmgyBOwiXLLuPs2ejfrHjwpslCeF5AhAxc5wLUTO
	eNOvFzCYuHAzaTDiLd6nEnIqE3Z1VKymf5XBnv2rZyCFuyQcOnqMohrS/7r9hvAYNAbBPBfp3dh
	Aah9nNQQqW2CKBPwGZZpaOdPz6KHIeuR9M/Z/MWIMdqLIo3NM1PdbkTXZ4CgMCnOOaZfF0BwMqI
	FB6/1nmIGI74FIgfimY887SlGmNUHdsAnFfcxxocQJ0V6PaJDFMdZhpRIg/DvjFl0fGzDJL5V8q
	gja6qJysSAUtUQn62twlxRBvrKuAmWFzaxh2H7IljqtWugrWhUcHN7xBldBQFy6Kk2++F2rmEfj
	sGUw61yzQFPwfV4BGGo2xMXvBF7+NFvA==
X-Received: by 2002:a17:903:1b66:b0:2cc:86d6:24cc with SMTP id d9443c01a7336-2cce9f79426mr39826815ad.4.1783529642147;
        Wed, 08 Jul 2026 09:54:02 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.149.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bcc0sm30747565ad.67.2026.07.08.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:54:01 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: vadim.fedorenko@linux.dev
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jmaloy@redhat.com,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net] tipc: fix u16 MTU truncation in media and bearer MTU validation
Date: Wed,  8 Jul 2026 12:53:57 -0400
Message-ID: <20260708165357.1080-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <04feb35c-ab30-4a12-ae19-a160b451c14a@linux.dev>
References: <04feb35c-ab30-4a12-ae19-a160b451c14a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the suggestion. I'll use NLA_POLICY_MAX(NLA_U32, U16_MAX)
in tipc_nl_prop_policy and drop the manual upper bound checks in v3.

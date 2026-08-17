Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3046EF91
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991434; cv=none; b=IvcgfCehk9aoekEJriWv1ZnilcnLXX1SkOsHwhol0fTL4DHR19hgEokRGl3MEU6VP7Gn1cc1osepIKRRSTsDeuVGO548OhBO3wDFlPd1fzbHtrEho4GyMQSs29D8F5sR7IUKhA4UySy4bwaK1s84U9YHlOSiQIfw69nxzVwhGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991434; c=relaxed/simple;
	bh=RLkO5g+cwM5yuPqd6sa8zX8GvOVqo03ifXavNqlJHbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd7sb3GAAY0H/pNPslJtMS1oyH/WBkT3kC0O/cpsmd0QlwIui6MRtG1GWk+JtgvmGz40qwBp/aj4hB9v0esbXcgaYn/R31IlqswyRKzZmjEv0MPJmR8T84B8dVVVkJSnLGCDe6HhrvDhyF/gRk4bBq/i63qI+AKywH/3MJYIUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw/82ZOF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw/82ZOF"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so4938222a91.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786991431; x=1787596231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RfCoCi3pe60ZQYB4hJJd7udpDKnnfNUrieRTF8HpgJo=;
        b=jw/82ZOFeNVYpxBcHZQIjuDaEvxP5OXzZOJXWSTXIg6oPQxoken97lIwa5ii7sLj/W
         BzT/+azVVxWK7vM5qivqG1dsZReAiLzaR9cKhpwEJrhAamRLvUjgSCyF8fhlguEmptrt
         6Z3/3RbEDkuzu34VTbhZZE3ECs8yRSsv4PH3yI0lvPt9KRqMvwbtr0ogyPtKNQWi/MIj
         W/u7b0x4pTdsl60W5iQos00Ez6LNu5azLd/oIY8PEzPgccpGBUBDEacgQQ1x39DFrqSv
         nVXdXKwWNR6hy+5oKqboNdIUcpwAtjFmPso6tnkpWSpu06gJzdHxvekmE1X8BbHh5PT4
         +HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786991431; x=1787596231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RfCoCi3pe60ZQYB4hJJd7udpDKnnfNUrieRTF8HpgJo=;
        b=rjl1PUFcE/FAXSbghEAvX9JUvEQASqsvgrDpBWyyEm48q5hg75bA78LXdv3jiVUiTe
         GMcC1vgrM5pAtwy6oYsXZfXh3AzsArCLN2wYD4iteaTwUlHXfXyeu3gqhEkpD2q9wDF5
         5M/7gzJc3mixd9TEh9TNLZ0IUD8t03sYRc8vtWnJVG4RoOZ5fGf6EcDtEQ8D4cMB2Odf
         2fco+sXzIYnj03Av+dPSzeDLr7sSpyHS18PJejNf6EpgcKvhRi7IgoBs6RMllYvnycy6
         x6hMGW8wJiqbGAXjdhg/vK7NMrWFtmLSip1uEsvoB/erVR5Qi+KOt0G9/0aCI8Z6/pJg
         Y/ag==
X-Forwarded-Encrypted: i=1; AHgh+RrO589/+97FyxJcvLRmZcx1zjRh/bdiLUCA4nwQRFY0dZ3Gt6uVuxj1ZkiEc8kMLcIOp6tpb0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YygTwOM+IgKq0ZQ+M4Xts6M8H8bHxKSKehJ77ZjGYxNTUv37dZi
	xgOXnuceEH8rJuiKkBLIOc7ba3MhCmhK01srJwZZIaLfpaqowe3hBzNA
X-Gm-Gg: AR+sD13voZm5nANTY7/uiI1KFepbyw5oSInxlsWiuo/nxX5kpDOM4lHCvJCJeonf0xH
	rUCmGxPOnsIafXCBSCo0IU65fRbAj707ncmrmaKpatPKp2XzgRDIUk7AXXAfH76SbJZE02kGpUE
	ZR/gNku5u7TtzCNmZzqqb+LgBCFeSnSdj8B4ZRT2delDMHJ0qL8pR2ivqNqq4aiaKrBg+0p+VI2
	ZkQ3sRDs97XuK0xL3p442M9TiV2f1bDDdyri6oOdDa3gmYUIuKg6uF7hysG4X8bgRMjQ6wiHVkt
	h7S77zBiYn7u3GPpS/fBwIdtGTs6XP/SvoKj1jsrx9t26azSReUK8gK5g1dBPMmOjxrUFcTjNr5
	6xDT73axFjMOilB2ilCqWneROJT9l/vlb/N+WVuafAmWUdl/rCC5+q9mvevvaO2qq9gfzAytvAz
	6hj1ahpu2z2QpYuFffE6WJjX6xBB/E5OPAd/hWmLX5rbxTrLzR1Unl6I6HqSYBQIeqbWzOaGDib
	9/pKR6d0iA=
X-Received: by 2002:a17:90b:184f:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-3955a5e32e9mr2467548a91.1.1786991430626;
        Mon, 17 Aug 2026 11:30:30 -0700 (PDT)
Received: from DESKTOP-L9Q523D.localdomain ([39.113.3.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d2e1a09sm3359096a91.7.2026.08.17.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 11:30:29 -0700 (PDT)
From: Jongmin Jang <payload.jang@gmail.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: Jongmin Jang <payload.jang@gmail.com>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org
Subject: Re: [PATCH net v2 1/3] openvswitch: only skb_tx_error() a packet we are about to drop
Date: Tue, 18 Aug 2026 03:30:08 +0900
Message-ID: <20260817183009.357-1-payload.jang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3766FAA3-D915-4ECD-B51D-DCF390F3C03C@doyensec.com>
References: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com> <3766FAA3-D915-4ECD-B51D-DCF390F3C03C@doyensec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Norbert,

I independently tested this patch as part of the v2 series using a
separate, non-destructive page-cache canary reproducer.

The test exercised a failed nonterminal OVS USERSPACE action followed by
forwarding:

  userspace(pid=1),2

Before the fix, the root-owned read-only page-cache canary changed. With
v2 applied, the canary remained unchanged. No kernel warning, oops, or
panic was observed.

Tested-by: Jongmin Jang <payload.jang@gmail.com>

Best regards,
Jongmin Jang

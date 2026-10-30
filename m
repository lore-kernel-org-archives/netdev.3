Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349627;
	b=qfR5TTe7RQLyePlhsgK/iyeRkMZFFwfVpOmXnMcuAIGi+vcLDy4Eg2pRUdt9y6cCINxl
	 fysCBo0RQr6FvEOexYU3CM+yLMvFJlxaXLyO+h4erkLkk5DjxY9AMiIAsYN731Hu+KVt0
	 6+b7PH/k9tEkwbk+F4AWEKHJCTISEjuO60oufcTJL79MrF2XSoBnLXr5OORPwwrkcCqth
	 5v3T/niJ/wGI6yBQrGjcYXWcoYLLb5HFn3Jzmr5VTpyLrXMLugVNrwptB6FLmlPhRhw0e
	 3IoGLk63BmINFNSR+nKOQWUrRa3+mwUDR8jQlSRRC1br52lV1bErMJc/2aMBTN+G7Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=p2lbErXysC5keIICd/9Oecm+satsW+gqAIlkh7mZJ8M=;
	b=sTzkSXvsQ2ds0PdsG86yXfPJkKo6rUDv4+TEV0FXKq+iM1MxRz740Q22W0JUfulymP90
	 qtcZqwPyp3d0gkADOejM/yvoWIBZ1G3r4O5KED2nBoKyj5P61HuSbueXclJiivq/4x70J
	 U5TC8C9w6y9PZXRMbfdaPvLoVqyOusEKKIYMntkvsj3JrRvqthK/nJMeOpP2lFmrwG3C0
	 RD6h8Z1kdhh8I6C3xFqJo9bzO0W5Sh5+b3teODlSBdNb6CBNcZ4qHtXZT/jn1tJDwznSQ
	 Wqe2zet5bBa2leAejUqrTBbZ9ScgTWJUkSNf8W81swJOKsRHkp21GXEmKFsaKDCIUBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwGefDb1;
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7941606A31F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7941606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwGefDb1
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cd664d00164so6833a12.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793349626; x=1793954426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2lbErXysC5keIICd/9Oecm+satsW+gqAIlkh7mZJ8M=;
        b=hwGefDb1SWctrOe6SQdKvltFiVhjCBvK4nzZjKCLo7KEWh0S1Zef9SO464ErUQOnLK
         8FjZ1sDDtHIsonQIgKxdTbLw4uIwlQi2nGAu4hwzz932I4/O5msW4V89rV0kqfPaLFRU
         ZOMZ4hAF3PZ+bdVnT6jOMAnlLN0O6O2bNyLkCE38yNOTsQb+5ERP3XhcxZTbgSh8SEzT
         /gGQsfwAVL7tr+QOnNY7VjxbAkKIfyvzEwF8oaJytuHFBdkInK5U+5Jg6sYYnc4Yqwjo
         jNeC6Qp9fJRlf3KL++vTrCllFwypFsOFxMglcQOeCJww6ajRJy0ioYfNOuXNSBojxPhi
         gQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349626; x=1793954426;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2lbErXysC5keIICd/9Oecm+satsW+gqAIlkh7mZJ8M=;
        b=nH8BUtIqZjKk5vzwJ2xAa/ovmDrT9WC8EMuEesla04yV+fPzDBoFSIsFYBUdfDHiaA
         mN76VpVAgsNF6DGtFrISF6M/GAHOG4ybTqT9/YAuLiLVeeiEpSNLNooB4VLLGSWraah0
         TpEJpYgP+WXp53T98tPKomJio6sAn6kSRkz5gmNtfQLSf1roH/a1AcfMkJvNLyo5eyuc
         Zt6vZllKrVWsLYKbBozuMQq0oULV+4TQo/Tn4Iu9w9VmEW7CQB7Je9e0ogR2Xxskfv9C
         F92WxPEoWFx3pzS9yCOSBn8HxHLIux2wc02vQDdbxZuovKyU+Y6FWINMAiPPlMPpx2ie
         087A==
X-Gm-Message-State: AFq9FYJGMI8oITWVMLm/Tk7rY3bS31FaA7ILz3jsXBcFF2tdBtEleHAm
	kPK2uHJP6UXBWjgJqbtup+5P4FpMsYBx6r8CI53xTOyfykF05P8kseP/
X-Gm-Gg: AYBFou3MqupmW9g0o12Ks5UrN3TZAz2GOzd9cvC8KcevkFg4pBrZ3y9Fv0WShwnmyfe
	E1OJH2a8tYPkNLw1pb1HRpFR3x0qZ3qsdCAlilQ1bB/0S0hzeTxukRMCb64z6lgwh7wYWl5QhlI
	ZZnZEcrAoDD1MiESGHVN2m4+qCRVru79XvBu6zggJTcj7gElETTMMBktGM+teeMRMocuhrcCb2P
	Gj3QOmHBlfiSWf6ORMQo0Y7pmM4Vu1JSQglWU0Vm4zn9Sb3mJSynkyaUh2zl9O8wFO3p7pd2J2T
	UPY49D231pm5dQkNxS9MeavVRLEGyWcRIBu0zbV8pVZNjunNdU1f/lVaHBD27zF4XpTlBTKShPa
	HKA7rGck4cCUEI/K8v7RRkFMlntSQoR4Lvr/8BRQNEalaF5ALerRwKdSsb8+sGk2k/YZwlGBRjo
	FKYT9arF5PWDYfj8AUYw1ApK/UgzOqB6N5j5oLpa8L6BB0gotbViytHXknRmNsr9ycTsyX/vgTf
	/BP4W65EwUSdwA1cxyFcI1AXMJJrc88vuYrtb2i7D60n9ymTMv5zUiuCQPQA5H5cjU/4FzNiHm0
	Sf9dMSKaa3hIhzxH93qTGkOwFzarVNYseYMzyPLcBi7XF/rAh6YUoiBeMxIIzc4=
X-Received: by 2002:a05:6a20:2586:b0:3e1:9071:acb2 with SMTP id adf61e73a8af0-3e928a0b0bbmr1315570637.33.1793349626005;
        Fri, 30 Oct 2026 01:40:26 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2600:2f3f:1d83:9185:c6a1:9ca1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef96e53sm486051b3a.20.2026.10.30.01.40.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 01:40:25 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 16:40:17 +0800
Message-Id: <20261030084017.16202-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com> <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason,

Thanks for the review. This was a timing race, not intentional: your v3
reply (the Reviewed-by plus the else-branch nit) arrived at 10:30, while
v4 was sent at 10:32 and had already been prepared without it. I should
have checked the thread before sending.

I'll send a v5 as a new thread with the unnecessary else removed, exactly
as you suggested, and your Reviewed-by carried on patch 1. Patch 2 is
unchanged.

Thanks,
Rongzheng

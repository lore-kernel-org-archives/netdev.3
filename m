Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205530;
	b=zy2CYhyKJlYEyN/x6WeXRlqFnItEOt3l3lXgjWGfRUlup5MT637d4QtNqZMJAvwQdL0a
	 CIewV9uuRi7FmdiwwZW2O3eNzGWbneCM/7tcaCvY6eS3FhzI+10QBD08QDyXXd/jutgqV
	 8aOl+iiznmCjLEiivRbnHvumVamHHCSrESRd8Ygl/RwFlZkPZ8BCkUW+Cdiu4R+Yy+PY9
	 dpSrjaHhVjyvvGLZFrG3UUrs9+0Lo8TQ1Zls1ds6OFUYgHjnPSmwgp6wRe65e9NpJbKl5
	 8MoetIjJ14ZlbRIiQ5B80rEKFyI4ASMI/8MU4xtNf6Do+m6VhcgCWBeMvCfs1wvacfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YYg+bgTYV9ji+xIuiu7GqnBDXQOUfklC31rXpMn4A4Y=;
	b=Q4iI2Ua02zMOAwV5XuuPlc3cMD1mq5vjU05V/b9V7WhID+jCByJg3PtqLyj6KYlHGV9O
	 /JJWv1sc/OhV/jauG1WSX9MJDiDnMcMwCorGRl0cKUqL9H4NG0kAKGWjjou5Tlv/MQRJ4
	 uDmZSDYG1hSDErWsF0K0OqJyp5mB3WIpS8NBEgjqXI+4WqbH+rG4TCEPOFt/HmuxCaqrt
	 uKaVaBClZNLj9ulEIAx3lZrOq436P31COPCTzHnRjaN17dF/S/s7SOCRpsRFp3TH0xuiV
	 ZK3hzuoIQaQdzWPpv1e1f0QUPjKM4HsIc6KsgPzyp4C9eM8HlNytHm5XPzXiecQVLVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPXilkf5;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAA606B2A0
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EDAA606B2A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPXilkf5
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2eafd4b09b8so169815ad.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793205530; x=1793810330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YYg+bgTYV9ji+xIuiu7GqnBDXQOUfklC31rXpMn4A4Y=;
        b=OPXilkf5W2mSrES/eYAou3I3925xBOmvAKuFXCfpSrnxPLnj4kUMLpI+jLbIXRhBp0
         Tt0n9dCUTuUw8+ZO0sS3kJucb4xltTp5nfTz+RJDWmJduzVdHYqQOd18bWatWyjnNovE
         YlZCPG3PGfuoMn/nqpAYtqGfP03M+3OSETEe8SNAH7VY91zPeU6BdgPCaw7u3EZmO7vY
         RUkAZYxo8g0xeRYpPdlRVmnVn5D7sjsWuZkGbk9BiCb0oSCZaraD8+H9mZKKzy9GcRFI
         A2ug5sAisBx6jr7IUqNsAwR0TnA6JRYhH+UizrU2Unehh9dbkTbDZdHmIia2jek02aWn
         t5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205530; x=1793810330;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YYg+bgTYV9ji+xIuiu7GqnBDXQOUfklC31rXpMn4A4Y=;
        b=PWIOJjJx0NsMB7lbTYO3N4SjLNQMk5vOFmJ7TXopSUlJFbaMoqs2kVJMIqgQR+Ej4z
         xYnKsDK6P9mpRBsuXFgYTLXAFaxJPDaqiwyYNn6V1pIhLFdXrps2bLv5DAat19uKLv2V
         gQ7VNTevZP3DGJ6/mCVcRrcYjIny9E9qpyD4xXbijPi+YZiiXNoffPLRLW6rtyir9AVR
         OZjtQ6N+CV2h8tH+DSjkkmn9bxKA+zFiOJo1gFuoecY/D38YZeRmQI7UEKIvdlIJwSDV
         2Cc38aj7oG+iFL7SBrhwK1y/py3NrijOYsEgxCQ64jEoxfhQJ/+yvfE3Xma9MWxAtq+9
         gYTg==
X-Forwarded-Encrypted: i=1; AKwUvBw+qMjKfq1W7MUa26/UxpRyaK4HVoNAi4DXX4C2u98bW0DrxvH7eg/tJAj6dJ/b2Mo5gsY0ASU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMnbKNturROhWmF21tonsFISvCLup6da6cv7NhZwDN56MsVXul
	yoI8Khbfozy7JiYfGYa9FhKWintnnhNi3TSp/Q/m+xXvbDDHB/fyk8AmxLQqSaxLmB80RA==
X-Gm-Gg: AYBFou3fNpIYhIYRtF+6WYg+xa8LA1IB424zIGhUgRkCcP7kvjdLrmebIX30GUEZyo5
	u9kxs5QFmcfYGhMB6dHdqvSFoy1Xnsz1m4HC9yzz+HQDYTNxTRrfqPl3vCXasUtm/RUAi45xpls
	Khj8Je2y+dYXUIIOdABNkxS7cdXn+zT0IlSbRXwsUAswB0XnHP1VuT5rp362MZ/lFJoB0uDgKp9
	xMIQqcRX/pVKYfantPJ8e7on8zIxx01dExQy5I4M6LgBofLoXlZcX+tTCu/pJCxZry5X0+5igln
	EqEWBe6+w7edIQdJQXsnRahE46KTbt/3aiHAJ6sRjNRy8g/j4MLHa1m2XfoUcVS7uUXHKmQTX4M
	ZE1i8SQDiYPAsy7SfgoXSbYZ09Xw4Ejrc16uwcdhSC64VXOBUgT91waL8VQSc+Hmr3UKs+A+IDU
	WHrBQs4EejANwbg01NZfQ/TaYjzxOYV+wQvZvvxf2vZTYAFCeoqsJ88kdzyTW7djo00IJsupiak
	P7GIUs7Ot196xGlmdrhPdlNAOtzFkCma3mDks4fqrXR+viqdNRrUm5gxwFeiZzNUUefVXR6QYs3
	HBPaKdC08qRGn2NvtQ6FxcXKhNJdFI/ZSL4Ky9246E1iHSG7T5zN
X-Received: by 2002:a05:6a21:496:b0:3e1:9071:acb2 with SMTP id adf61e73a8af0-3e913a7ca80mr44385637.33.1793205529784;
        Wed, 28 Oct 2026 09:38:49 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:1490:f0fa:6df7:f234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cc9b25a3sm4395321a12.2.2026.10.28.09.38.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 09:38:49 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Thu, 29 Oct 2026 00:38:39 +0800
Message-Id: <20261028163839.82573-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auH2iJ9oXEQRVG26@boxer>
References: <20261028025026.11401-1-testwrzwrz@gmail.com> <20261028025026.11401-3-testwrzwrz@gmail.com> <auH2iJ9oXEQRVG26@boxer>
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

Following up: I extended the selftest to run every descriptor count from
1 through MAX_SKB_FRAGS + 1, not just 1, 2, and the maximum. This also
covers uneven fragment splits. All cases pass.

Thanks,
Rongzheng

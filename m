Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026548;
	b=YjiDKRCM51Apq/VGTuvra538WyxUPz1lcN8qlDXPc9KpBZ3n8y8ZwQYgkSrue31oFeDG
	 +Z7rjCnD0AWt3fpQWn8jGK8xnkvF0QYXIZSDVNeKyjWsUQmNV5pZEcV8PiO9Y+mTXfjNJ
	 oXwp1EhAtWJsjbOVbF8nB+AKzrb66K54PhoycRf4LlAk6QnjNDt/JOWF30UinzvF/NJzT
	 2dmAQnVNWO7ydQP2rwGkHABCOi27N4Q1+Rls0kA6fRr+isLc6CqNN0NyiAlZoaE1jIu1R
	 se4CbPvUkd66YDk5REWnkMEkkji4SuVTO4ii2DZWyu+z4ojy1mHkkuWPT4nhhKmbYDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N3UVCZ01NtzZBTQTfy6B2Rj4m9gham0iwhTudNRqEe4=;
	b=HkTj7KX0COU3s6fFiEFNgwwH85nk5B/XHNnhxqJt7BBF92xzm+CKGeeoNQ8UZzLV016C
	 ydiVleichGj2WQkuMZIaSLJdxd0pc3URAw+OUAZSpDlDiVhds7mqbceCaIWr0UsDgP4iE
	 yAeMOVkZ2oxu5y1fOfzf6IS4QU6tyK8uQyqu777JklKREtf3Q97q76tQnIH62NaooyBV1
	 nCxLoPX9hjEhMXXUvNN5Yp7fsJsa3zKhEnExFFUUhneQK/ZSD56ajFc7DGOyerpf36OpS
	 SGN/ZKiuBiKnZyYeswTAn/QueEqpijrI+cPebZKf5P7OlybY4By7Uowz6lXc4wt77Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ya7N+tEq;
	arc=none smtp.remote-ip=74.125.228.8
Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66C606A324
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D66C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ya7N+tEq
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd3da0e82daso665575a12.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793026543; x=1793631343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N3UVCZ01NtzZBTQTfy6B2Rj4m9gham0iwhTudNRqEe4=;
        b=Ya7N+tEqw7L5wqauN62InhvMjZ07hzBv8z1qv4xYl2l7+7mOtjMxFicn89wJu8WQVz
         pVHjA1mp2HdRtfukIy/YsDoV3KYlr0G5uIegku1JE/42fMSxxJPmKtGDklYBwnkSwnI8
         TElChyK1/vUWAws789Aq0wc2r/GMyal2jK+81TKfc0m73RDr1V5P5Za1VVzQUNCedoqA
         478ec51dXrH/qGDIYhLjmf2T/uMmtN8c3aPqOKGIoiyNNn2Otxpq9Uo4VzNamliEKvoB
         Dg5S3jC5fM8ztd4zHkXjLifKH00SYCtNXc+pmNaBbQtEdgWdBOS4Mg1srpwqPYC9flbK
         aMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026543; x=1793631343;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N3UVCZ01NtzZBTQTfy6B2Rj4m9gham0iwhTudNRqEe4=;
        b=AJuVjXvxF0nvs0/oYRdCauE156jSMCnMusayo0R9WdIwqJXXqlNpy6HrVdEVvFrXDO
         SWW6YyI6egBuoqlFxAmY72aqgywOjvfkhMtXZGHmr7ZFTQG1Ur1z9SGZNACcn8g/C4MR
         8E9VP94665oWZSI2AwrsP0+85bF6w72rPDz0Qqg4kYagrrpp1GCH8SrO6knneuNT6C/s
         8ell/IjtkeezZwZufC1TdzFSKgkmUNvgu4Sy26tJU/27D1ZV+sj935mnlkrv7/4l0YP0
         aBIFmIMbiHTcTXI+DHpnUrvdRZsuqzNQbLsDw2sQr0dfCb5y1pu/5h1dJsb1j4tPkVe4
         lyeA==
X-Forwarded-Encrypted: i=1; AKwUvBxnMs7yDLnx5W0V4wBpAthiKblNP7dNDtFmm25zbTfa7KDetp2WkNYAwbDYpZkG13vkadZ3ZDM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtcLzRUKU1CraeSpY/pQCpYHoTVU4PN31EC91jlustPp40hvZE
	te6jWVfRimZXIo4qs4NpXlZtyqwLM6SVe/z70i9/rjCDFPn9q2ForcA7
X-Gm-Gg: AYBFou1NTm/Rd7oGxidoUR1w5a47i5HUwSdztqv6H7GdycLW8wX6kOgqW1ctZr23ckG
	QP/1uFCSRKL8XbBMIJh5GN8hC0FiWMZwmIcZzNY8M+QBN3spnrVy0x7ns9qonm9kydDcOLIS0Ue
	av5H6xP3KA9Q8GzAP+4CfSVjT4BSu1wQkkM0v5zTZo2ubIbOuxF36CsrwmhyyzaULWB8M3CNt9F
	b7m2LcOzb5orTij7wAMVLvoiBoxGF0EWKN/Kyhea2C8u2nd6QgBhSQ0SeDJF55BKEYoWr2xn3/a
	NLpNu5GCDJ4Vj2r3XGCeBmRedgYF7XgoLlzoWG+RAuOHWUIt5FB9zIOnlOzYoury4BT4muj2Unm
	9LDToejMtlauGtbYcesD9jT3Ogh9Iyh5+MsRJ2/nQ3lVZFvy3aA6LpD32JeyWSsTev7zJwHnzM6
	MLsLSdsFbx6kx+Ym3C2smCpzwF4Y1rdfQbdR17wBsxzcmxEezfTY1zLU3VT2q9A4Sn0VxYmPIKX
	PB3W+GAx0o5YOOwUMX5dZMT5CBvaEC/TYZTG45/18A6CCSUhquvNbP8HcU0w+T+tXzN+YDDx6D4
	d6gJ+RG00ucNKaUN
X-Received: by 2002:a05:6a00:3a23:b0:8a0:1dab:fd50 with SMTP id d2e1a72fcca58-8a367a2e5bamr5994625b3a.20.1793026542774;
        Mon, 26 Oct 2026 07:55:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2300:286:8580:7ae4:15b1:705])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b469507sm1361172b3a.31.2026.10.26.07.55.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 07:55:42 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Mon, 26 Oct 2026 22:55:30 +0800
Message-Id: <20261026145530.46896-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179293961591.3134.5478895656850588086@kernel.org>
References: <20261024141157.59301-3-testwrzwrz@gmail.com> <179293961591.3134.5478895656850588086@kernel.org>
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

Hi Sashiko,

Thanks for the review.

> Should RX_MAC and TX_MAC be copied here? In this file they are text
> strings meant for the ip link commands:

No. This is a regression I introduced in v2. RX_MAC and TX_MAC are the
text strings used for the ip link commands, so copying ETH_ALEN bytes
from them copies only the first six ASCII characters, "00:00:".

The root cause is that I reused the ASCII macros intended for the ip
link commands as packet bytes. The test only checks the UDP destination
port, so it still passed with the wrong Ethernet addresses. In v3 I will
restore the binary literals and add an Ethernet MAC check so this
regression is caught.

> Should the condition be retries-- > 0 instead?

This check is pre-existing and not introduced by this series. I will
send a separate patch for it rather than mixing it into this fix.

Thanks,
Rongzheng

pw-bot: cr

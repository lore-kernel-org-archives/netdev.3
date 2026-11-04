Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835358;
	b=Y05aDYUR7f7/K5cmxNnkSwAj40FA1YwuR8Jaoe5gXNjIJMM+qWcYjBYbmhf+6eDtk11p
	 SVKXVdgMFmLbt9kev8of1NdBA27hZ39xAMT/MFuBMpzHBVTqC6N1E/llscKRrVvuYtRc8
	 ImvTWI0qvAix3/CThlICDuOokLmRookC+Bp3v5GYvmhPxY9j+uJdSDHyoO5qbCB3k2Jiv
	 mY9Aoycnx6ze68x/W+JCarDnCClcfUxN2SwcWAfQkqCAfzlc1xiSI1Bx/9JzUvBEjbsVk
	 dl54dbM/BQyd9ILrCQOPA5Sfr0FhgQzAXQzFmyC0dYxQzj0LjCLYgwDEv0yLrskgKYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dmn1Q3/145xsrJD3bHMxFjskCeqjVe350pnKBSHlWz0=;
	b=vUE1Ho5GTBx/UNyI0n3OkWwwaVEWEjFOxxAzY194iRtp+dL0Kuh4YVQEKZ9jy4x5riQH
	 aQauNPqP1GjW7L4gDtgTELNd9C3Dah/ZYEL3+gx+q3Jo58bBCb0ktQPKx0c0jfjlWaPW3
	 aAjG1GCtDop8pl17CkTIilhjLTTKcZuasNjNnmLXT4KScd5taYANsmP0fP8cQ/xz4an2e
	 3aSNnTCIbJXj3WzkdiAVd+dDuUqL+JED+KIDfHeoHuIcxostD4//qc4sK2+FL2Kzi6w/q
	 WauvlJTRRKzTEttaXN4MChSY0NZ/8HgX4mveHkHrcq211QM5Ujg4v7OZrf2PaIvYXGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SJMJgTdc;
	arc=none smtp.remote-ip=74.125.230.193
Received: from mail-qk2-f1.google.com (mail-qk2-f1.google.com [74.125.230.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84662606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 23:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84662606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SJMJgTdc
Received: by mail-qk2-f1.google.com with SMTP id d75a77b69052e-5332a0f6dbbso8351641cf.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 15:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793835356; x=1794440156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmn1Q3/145xsrJD3bHMxFjskCeqjVe350pnKBSHlWz0=;
        b=SJMJgTdcGBlQsf4zsbrbO1j5AkB7ELH4/WVaj4Sdyja5e8Qsu41MqKvyxQgJjRsmvv
         WB2WEmuLJYf6rFz6iWK8B8a0Qq8ltXqfC3dLLnzSb/Vr1kzCqcVcDQZ3cIfBHOZ+5v5F
         BLE6BusncD13AnA+suHKkbOfoVPCAwy7EG8dZrxWIbo07psQ3pnSg+ksINDz1A9UUWrH
         6Dd8sem9Gf8LjO7S5z/9LOgyh3nnxfHBf53t/4egxxRnpdKvyogEIV7ou2TArLsJ0HCF
         m+eLHxQj4QlJJHgWrpJlhhc2fC9xqCmbyf3EoxeRtwyCaKY2DnrxE2PcuGUmjyMKs6Rf
         jPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793835356; x=1794440156;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmn1Q3/145xsrJD3bHMxFjskCeqjVe350pnKBSHlWz0=;
        b=NWNqnU/P31TxfZ2LPiNQLoB3pW5OhBu2Es6kcNFrW8E7cc0PfHe3SI8Au8TeIuRoS8
         UybuEffua30y4xbQaSWvVIwDxjEU0m59BAjzt1EUOhOgjt5iIrMVmvrZGo5ZbjbhVo1V
         zoHz8THoorUIb+9a7GXEaJra1xGj/Wi+uUejKsD8QU9AE0W9tPd8ac6/b3Qu/esjhcIj
         nmAqwfVGpAiGJ/g5U1jECOLJVrMdG0gIMQspl2P7TjSOYOqEF56XGYGKEGfhKn5zw3MK
         K5xDTqQWuAAkOtnN8nWZsNvlSEo/U/qnCE8ehYsOY3RVX1r62PXwBthBhmClMXBIHHqi
         aHzw==
X-Forwarded-Encrypted: i=1; AKwUvBzPyN/GAeXZydNJk85bBG/P16Nyydfto2Lj/fRsQC3WIg0g/VsheciIQFwU25VDUPpUy0PlcSg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cJwyXRL6bpBGxT6oVzpJy8toKFx6peAJ1ICWnmniB1wx0lLqh
	4xIASgzRadqU/vzhJHjfsJN5vMETv4LItctHgf720ggocKKJtVn4kCa0
X-Gm-Gg: AYBFou1oDarHaXmCYA4sDiy6JjUIh7IajeH93qFUYh0lfJIG1u+KLoAD4RJ/+c9tbuS
	rDrMSSoCEdn0fPXYtI8WLuQh4FEQ0on/1kyLUZJV/zCQaZDvMZsxEwrZjkzrSsNvqgmzAjE8Yum
	zP1syNNGrQswfjtaRgH3qj2wQg0hfgEZa1TMBr30q0eob7pbofo0FMHK9l9zvAyvgO5entjdbBG
	s2zf2eJLnoTyhnQdCBqQFdlsyHcwDS3EiAzcuPIElPjN5eqB5Vfi5aopSTHS/i/7NrfsdZX52N6
	1wNW0lF96bvhr5Xp/r7uBuVpkjRjQhLxjpNF6UlU3D6xioWBfkOeQ6xQZflAV9UyIlRZNjQnpGS
	YcQ0G7r1IZDetANahMm/JC22fU5ETFC/Ojg1FJM0X7GxJsozrzzjDbIEgLkXjntdZKfsaIfBP3m
	VFbRha/MTGJd1CmoITjognS4gFA+L3bH/b4/Skwuz4Jch8z/dQ/PPCN7m2Q8iz0Alt+cxsO/VzT
	PDFe5WhUq7l5NO/DTUy4eUjbS68wXGCtutqQRaId/ozHeTMqjZuSZEhLEJx+SzSUd6QSTcnr0+M
	dQB9ZY3Cw4XEKMgXZavh0Gtw1Jh9YX5fdQ==
X-Received: by 2002:a05:622a:1aa9:b0:536:766f:271d with SMTP id d75a77b69052e-542b781f632mr306774901cf.51.1793835356393;
        Wed, 04 Nov 2026 15:35:56 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a63462sm36858141cf.15.2026.11.04.15.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:35:56 -0800 (PST)
Message-ID: <2a1728c5-2856-41bb-9ffd-c80df4ffda6e@gmail.com>
Date: Wed, 4 Nov 2026 18:35:54 -0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/6] tls: send a KeyUpdate at the record limit
 and on request
To: sashiko-reviews@lists.linux.dev
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
 <20261103-keyupdate-rfc-v5-5-de1ab90a88d5@gmail.com>
 <sashiko-outbox-198141@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-198141@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/4/26 16:43, sashiko-bot@kernel.org wrote:
 > > +   ret = tls_encrypt_async_wait(ctx);
 > > +   if (!ret)
 > > +           ret = tls_keyupdate_rekey(sk, 1);
 >
 > [Severity: Medium]
 > As reported by Sashiko on v4 [1], can tls_tx_key_update() ignore fatal
 > transmission errors and rotate the TX key anyway when 
tls_tx_records() fails
 > with -EPIPE or -ECONNRESET?

Yes, but this is not specific to KeyUpdate. After shutdown(SHUT_WR),
send() on a kTLS socket with no KeyUpdate also returns the full
length. I tested this with TLS 1.3 AES-GCM. As I read the code, the
KeyUpdate record then stays queued and TCP does not send it, so the
peer never sees a record with the next key.

This corrects my note in the v2 changes, "The next call reports the
error". In the same test, the next send() also returned success.

 > [Severity: High]
 > As reported by Sashiko on v4 [2], how is the KeyUpdate state in struct
 > tls_context synchronized when sk_stream_wait_memory() drops lock_sock(sk)
 > during a send or TLS_TX_KEY_UPDATE?

No change, for the reasons in the v4 changes. I checked these points
by reading the code.

Points 1 and 2 need a TLS_TX or TLS_RX setsockopt() during a blocked
sendmsg(), which is an application error.

Point 3: tx_key_update_reply stays set after the update_requested
KeyUpdate, so the reply still goes out before the next Application
Data record.

Point 4: a record that was already being written can go out before
the reply. RFC 9846 section 4.7.3 allows this for records in flight.

Martin

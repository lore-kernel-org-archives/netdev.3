Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424024;
	b=X5ldU9NrakEbG26FkkQOfYj4r6rVUzApxeec9jzbh9wNOOSnsW/xAmjTZMoshG2YRWTr
	 vhem7dj30R7aj6aauQ/WYnaGIY33VITxojFDfoduXoYiOZDHG8CJd4SGH1QDc/msGfkWp
	 FjEDFr2UhR44+2YLpQWnRVRn5WGGSPsJ4hdaNFOrrcZsQqmpnVv9LO+zrRXMnIfa4ZUFE
	 LmfEJA+LqA/z0Qt7HUqFajl4u1YZn2t5RjTi8YVC5WNFsZuaFAoMRbgl6Hlkir7wgqjMz
	 7oianKdyPM3RblKuvjeyrW2owrEBT05SGv1RY21V1gV70nfPJfwdNZG+JImeMLt11Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:From:
	 To:Cc:Subject:In-Reply-To:References;
	bh=40VX55JE7I8lotG+m4tWob4wIq5xuHTD0e55HnuCuwU=;
	b=cJmoyc5rPVLkQoJJdJvyzCEeBG0fPHntJ0qOHtnWhNbIlT+/lxRwL9d12ccyoE/W48BP
	 wzZj4RddSg/bjPnFoaHLaQRjQVVMC46m80aIMRtDPjfc7QcKSNPDQME8pp2wtpWMAJPNm
	 0kOEVWwuc7ArH71YuqpZz/LtLSjGj/zDHj2ETdMSt9TpehYq0w+sY4cl+HbMhJJULWyFI
	 Ahxc+tT2rhxlJBzOiiTCeRfhhkTMxXGErxzGNoEXGKbr+wBmR5pnSEQEgOs6DG6GRWE71
	 WhQfv3P31sX518EhdOJeYF6w9++dHkElJZ59dQ/iIJXTos6S4ze1NRe6Tf2nr9Xhn2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MOHhUoaC;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72891607887C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72891607887C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MOHhUoaC
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-360bd1d1f9bso242822eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792424023; x=1793028823; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=40VX55JE7I8lotG+m4tWob4wIq5xuHTD0e55HnuCuwU=;
        b=MOHhUoaCewBDcQI7j97alFtBVMoYrtatfUH0aiOZ78clFxr65xZZB5ortlDk3JbdmC
         W5zWvxKhOuyH3G3kVkl3Tjux8i3MCzCJyeE1s6+8cJKbl1So2HT3+3pkw96zaMEpSox5
         jny7r0NfuTAxxznYCurcAD3cIfEzQE4zfnz81Jlde0acBq6aXt/0zj1ERmA1MskQXEDp
         QQYDPioLlikUR6WRWoFX2fJRY9OX66ZWYm3KrVPRoMGdGGPA3HKUE43pN7coONk6im+c
         VNahbk4fHoaddaEzh91dK+8SL6nQW2c1ex0CRB0xqs24Ub1lyjNML9O/nEJLjzPUktA7
         nycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792424023; x=1793028823;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40VX55JE7I8lotG+m4tWob4wIq5xuHTD0e55HnuCuwU=;
        b=pqRAnNk5i3xHHJDfrhN20d43o3mHQfwukK0rHYBm0tQS6xag4w8acCBwh5xUu9zWwi
         3RtHMb+b2F383yEKCi7CSmeP6PrwrvUPnlRUoBubw5r2wybJgRFiycPymL7WmOT/b0mN
         gFpcPgCXEaWmhcZkmvvD1uo1eYJ4LIVRqyAy0gFydMo/IGZr6KyVXgxiT72tAIL4E/eZ
         F6p4w2IGLk/u2C/9r4EXXrdTDX4lIJO6XOroiQIpRzdJlt+cPPHTiihSMp3m6AnnIUrl
         KD7LhjAzW9wmIxJcM0dWDrHnPg8FNwzPthyoe9i87EYQ0iNN45PkKjShg7nQVOno2YPc
         evdg==
X-Gm-Message-State: AFq9FYKsWHo6JF1/hRYQc56uCzSCWtfm9IXSF+MD+X73LM9yS5KdlYzh
	09H/DcIBr1iNENJRgWIVw/RASpnLTCrkQDheBPX7/9PRULPiFYKkbOWo
X-Gm-Gg: AYBFou1IQ7stOrKExUtnPz5DNEgk5hA8dWfTciXHJbbqtJJQN5nRHRgF9qozAUSSFEp
	lO532lFLmtZGwfItPZSuy8lelawmg4KaUotfeN/Ykjkx1ZycXGa4IWwEqsypWFcd2afQkAZL4iq
	wQlYQNyEMCuM7rjRVFghzwRaBrJt9aGkyhcCr5eRYg6EQa7z1At/7sioinlr4YAcL66JNMAXQLP
	RUlSr+YkTSq3VCDbKjoXRtfcl/L1/Fl+Uzl+ln0J4qFdnkWpfnC64J25L7bDhnfzi6INQjX0VBF
	/Bhe+Zy9kcsr5XgeI5vm2dJhx/zKSuKO6hrM9bX4vTLvZ8ASQJWqeaNy2KCHSRDmugGT1tHi3ps
	I68u2aSghpltmElyRFeuneqUwwdtiUne32d3xS4vHcZ3Yj1Vdt4lt7psNkdncTWse92VTanv7Gq
	J+dSWWDf66F485eT+9OdPN7ODWttW/mdC54+WxWw24K4KAUze6u6YRWmcABiMQTLoV20cNsab3x
	c0kN82iXtrn9ehzUuGFEI9LQ/4h9JpZrgAzk5ysRJsXmuTbA/Y=
X-Received: by 2002:a05:693c:65cc:b0:35e:9cb2:b88a with SMTP id 5a478bee46e88-361a136a601mr17263822eec.2.1792424023344;
        Mon, 19 Oct 2026 08:33:43 -0700 (PDT)
Received: from msg ([188.253.120.76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b684dsm33067697eec.10.2026.10.19.08.33.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 08:33:42 -0700 (PDT)
Message-ID: <1792424010.89978.05cf1ab60e@gmail.com>
Date: Mon, 19 Oct 2026 15:33:30 +0000
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
    Christian Hopps <chopps@labn.net>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@kernel.org>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    David Ahern <dsahern@kernel.org>,
    Ido Schimmel <idosch@nvidia.com>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] xfrm: hold the tunnel device reference across the input path
In-Reply-To: <20261018090638.55686-3-q.h.hack.winter@gmail.com>
References: <20261018090638.55686-3-q.h.hack.winter@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

The [High] finding is valid, thanks.

__input_process_payload() reaches the drop label from several inner-packet
validation failures, and the drop label sits after the loop that delivers
the packets queued on @sublist.  When the outer skb is reused in place for
the first inner packet it is already on @sublist and carries the cached
tunnel device reference, so jumping to the drop label skipped delivery and
left both the skb and its tunnel device reference behind; the same applies
to a packet queued by iptfs_reassem_cont().

v5 drops whatever is still queued on @sublist in the drop path through
xfrm_input_drop(), so the reference is released.  The normal path already
empties @sublist, so the added loop only runs on the early-error path.

A revert-based runtime check agrees: with an aggregated IPTFS payload whose
first inner packet is complete and whose second inner packet has an invalid
IPv4 header length, v5 completes RTM_DELLINK, while the same code without
the drain leaks the reference and unregister_netdevice() waits for vti0
(Usage count = 2).

v5 sent separately.

pw-bot: cr


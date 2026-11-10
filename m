Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344522;
	b=QkNOQdfOJR0XASctP5dTeFvnLMoZf+6Fh+N95ZdXry1SB+qPsfLYV3kX/6m5C/I2ncOl
	 /GU2G0qQQqtx+IehSAU9OtCZwpY26iqLjPUVsYuUUreZLeTQpV6tuPGC9yABEgI857FA1
	 zX4kDWUJ2S6X/0E5iWTMqMS4UtJET17cWDUM9YjrvkFG/llREMe3jThiPefZjbXTaRLTa
	 J52lTyc12FwSoOhEcAveXhICab4At1XYUiHwwlCZPGHrEnQADyYjKdomAkUfT0EfRGmYq
	 u/e8vMGh7Z1tfz8xvQrA+xbjTxicszJvXTvLNHXRYmZptg6iOc7HkddRYFmDAZHLRTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dy9zjtNbr6qe/+euwDS4ARapr6gYv28sKl4aRiD8Pk8=;
	b=jnzM6X4WSXFWusZyRg03h4BZ7pZqDy9LwCVyK+wVvVbUmFhW7+ZukaHieduTOVYtAm1D
	 9Wp0pR9dBnNc6FG+EdD9u5nLDmNqHWIjSv3Uv3/+CosPTEBxPIs+2Nap0iMFRokRoef48
	 78Ts6hUlfAZ6pSink9JkRrdI99ogzephksc14OlV2E8AvP/OP+pFBaWbDCLaKEPTY4Hev
	 IWS6imgthz3HFiXAh/Wjd0/o2d6khkrkVGWr5Au6ppSb9hkdmBdwTtDDmxxuCJNBptrmA
	 vMJYMMV+ed+Y+zf13dG/VUvbjwipsi0Hu5mIJI2MMFiXD8z4PtxjTIcpJqT0yBr8U0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=dxfashKj;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC1606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40FC1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=dxfashKj
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3887757eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344521; x=1794949321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dy9zjtNbr6qe/+euwDS4ARapr6gYv28sKl4aRiD8Pk8=;
        b=dxfashKje26Pt4+PcyN8DTxdB7ClpF3jwBf9sqFwKvYJA0U2XxemiEeMp9ff5RNliY
         wWsSvFbVMJ2VIqCUy60jSe5YxzVmRQLoBVzAae56KUU0EkW+SJlte7hcoeORtzUB1fRL
         CteMdiJ8dLSHOr3MAkLERXqEKNzNEp/97dRQyuMojSS+M6YpbgOiHi4npa8uQmH1SXL6
         tWecPnEcjIheSaEHVyuKWBKG1RguOEEc3705nYCRSSxHM4YkNTM2M6eb4B6vYQs6EvJ9
         EN04GiiZ3CyOA7OKvkp28HWFCg9fJxXAFQU9fgKzgbpe4qxqSZX587UPu6IyO+K+VJDU
         ghAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344521; x=1794949321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dy9zjtNbr6qe/+euwDS4ARapr6gYv28sKl4aRiD8Pk8=;
        b=aQiY67DO/iBtsEFILiNdhuCD41MLbtx4FwdoLVJwAeQJCPMZdech4bYcT+ZCd9p3NH
         K5O541e/8MPTV/yQbaOva48wCNc4qW6htePSopDKs2p7n02th0T4etTD4MLynqZGLjMT
         jutKoipXf+2adgr1oqDqWmXgqRXxHfdx3YTl71VBX4apfQxl7+UHni6GwFhPD7aXaYz7
         bBKR8SU+ZZAHDHaSTdyMDc2jwT5Jseo9/+tUgyVq9uXvIhsENerfcbkZffVWsX5TmpOk
         1HKTYmawA0c3damrRKYEibGfMqoVIOaXJz3OcQ9azNSbYnaX8+wgOQTeo+dkdxaiOSv1
         lUpg==
X-Forwarded-Encrypted: i=1; AL+hErHfsupjLBZT9xzygHA2/Tn5pluxbeZE6O5gI73xrhfFgMEsbLVoyPDSuT9fACIhhbMJ/V46F/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z92bBecI/QANt9fgAY2PSsj2IsRvnGsmWXKz6R2E5QILMTdgN4D
	6cRjWrxEX0F797QLUuZH20aF6LjKSAOr7upYJRmCbVB3vNyCCv6dK+EiE7MHVh/XfXo=
X-Gm-Gg: AYBFou1NarcW5+6x/Scr9TiZUsx5OeKg4b15e/j2AyrOwajIH9vM7bY0GAgI4EZv7x9
	a8EpPu98YdH/kRzaBGmQqW0HxjrpcYZKEyDL4UPl6u2IW/YcBKGbOE6wNgOY/PItClq+SsPn3eK
	UM+SLRmQnUjjdeFBoqwVzOE8RE2IKvVNdJLhXlq6W3dtIqdELtkim4xTnpo2wvVCNsr2otOXwNu
	6iiQ8FpymNGyLQHy3Z5a2yTwOzmnzJoUYDaH9kZ86IhAbgykBWrA9buH6TFeU2m/vREPTnqjgKc
	nX0hUPC3YpbfI67LFq4e6q88jnYJweG57PpAn+jQtTmrzIEuAJnAnMLTLEM+ETInT7Bnt83Vv8r
	j/Wv+0ODZrPlz9BM1x7rQM6qotTYv4e+LKNj3bJHorLugC3XlOdRx+r5fwjSnEzYEH1maUZSPJF
	tYk/D0wLrWg1DZHN+RgkGqUUNova42svVjPc10FRjKOhadABIaeANg9n9JSpjrwzthhZZzScupm
	6g6I1cKVjOcdKKJWSdKlG1QBrRnF0w7K4sF20ULRi0fPHzzAmyg70CmuuMkZ5RCpxSdUyJ0Tem8
	n5sAcdKqma5SwQ2fu4L7qGYUtgVLZrno/RPiignUyM2R4qalIu3GZ6hH+X4fOLmy7Xq/IKo=
X-Received: by 2002:a05:693c:414c:20b0:376:703c:8819 with SMTP id 5a478bee46e88-37687211c61mr720145eec.38.1794344521014;
        Tue, 10 Nov 2026 13:02:01 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512b6asm8770814eec.10.2026.11.10.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:02:00 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sashiko@kernel.org
Cc: ap420073@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v5 5/5] amt: harden relay authentication and teardown
Date: Tue, 10 Nov 2026 21:01:51 +0000
Message-ID: <20261110210158.103856-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179423576119.994134.11181391213411379311@kernel.org>
References: <20261105125010.1107546-6-omar@blockcast.net> <179423576119.994134.11181391213411379311@kernel.org>
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

On Mon, 09 Nov 2026 14:49:21 +0000, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] The patch makes several security-relevant behaviour changes
>   that the changelog does not state.
> - [Medium] AMT_MAX_TUNNELS_PER_SRC is fixed at 16, but the global table
>   size amt->max_tunnels can be set by the administrator.

v6 has superseded this posting; this patch is v6 6/6, "amt: create
relay tunnels only from authenticated Updates":
https://lore.kernel.org/netdev/20261107004935.2627329-7-omar@blockcast.net/

Both Medium findings are real, and v6 does not address them. The v7 I am
about to post does.

> Should the changelog describe a few more behaviour changes?

Yes. v7's changelog states all three:

- Key seeding: b9022b53adad seeded the secret after amt_socket_create(),
  when there was no receive path yet, and cbc21dc1cfe9 added amt_rcv()
  and the per-tunnel copy of the key without moving it. Since then a
  Request arriving during amt_dev_open() could get a tunnel whose MAC
  used an all-zero key (first open) or the previous key, for the
  tunnel's whole life. The existing Fixes: cbc21dc1cfe9 covers it.

- Expiry: a MAC is now accepted for 180 to 240 seconds after the Query
  that carried it (60 second rotation, four generations kept). RFC 7450
  5.2.3.5.4 has the gateway start a query timer it SHOULD compute from
  QQIC (125 seconds here), and 5.2.3.5.5 has it send a new Request when
  that fires; the in-tree gateway re-Requests every two seconds while
  its Requests are answered. A gateway that never re-Requests worked
  indefinitely before and now has its Updates dropped as Invalid MAC.
  So is the first Update after a new join from a gateway that, as
  5.2.3.5.4 also allows, runs a longer timer while it has no
  subscriptions: it is dropped until that gateway's next Request.

- Replay: any (nonce, MAC) pair minted for the address and port within
  that window is accepted, not only the latest Request's. The MAC never
  covered the encapsulated report, so this changes only how long a pair
  seen by an on-path observer stays usable; off-path senders still
  cannot produce one.

> Could the cap be derived from max_tunnels instead, for example
> min(16, max(1, max_tunnels / 8)), which needs no uAPI?

Yes, v7 does exactly that, at both the Request and the Update sites:

	static u32 amt_max_tunnels_per_src(const struct amt_dev *amt)
	{
		return clamp_t(u32, amt->max_tunnels / 8, 1,
			       AMT_MAX_TUNNELS_PER_SRC);
	}

That is 16 at the default 128 slots and 2 at 16. Below 16 slots it is
1, so there only one endpoint per address gets a tunnel. A configurable
limit stays net-next material.

> Is "teardown" accurate in the subject?

Fixed in v6: the subject is above, and the amt.h comment churn is gone.
The netif_running() recheck under amt->lock in
amt_tunnel_get_or_create() was still undocumented in v6; v7's changelog
explains it: dev_close() clears the running state before amt_dev_stop()
drains the list under amt->lock, so an Update still being received
cannot link a tunnel after the drain.

> Do these two comments hold on the renewal path?

Fixed in v6. The comments now describe what the code enforces ("no
tunnel state is created or changed", "No per-source state is read or
created"), which holds on the renewal path too.

> Does this need amt->lock?

No, but v7 keeps it. The full check is advisory, since
amt_tunnel_get_or_create() repeats it under the lock, and the lock is
held only for an O(1) snapshot, so a lockless read here would save a
lock round trip per Request. That is an optimization rather than a fix,
so I'm leaving it for net-next. v6 already reworded the comment so it
no longer claims more than that ("a Request holds amt->lock only for
this O(1) snapshot"), and v7 keeps it.

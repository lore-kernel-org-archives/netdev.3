Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648198;
	b=Czu+Z0j42vddhdpDgG+5rvBhceNPraWqiWDyZJ54oowpOroakau3HwhdjLq/mGXrMuMb
	 7SUDcXuojMGn5p+6VRT82kTJMr53nJCLUtAwRjLQA7ZcN+oa3bCS3iqaG0YVszZMPypIp
	 cNovHGR+Qo9wGsR5+Qf969VVfhszD6AWML0lw7S29e9Bo7p4eKA9gH32qMuuLS+ddbkKT
	 M/Ibf10cYvtfnfXF7DpCULtXkzT6w1Evk/PnrDdvQ+2tzPqAyZIlwMjOZIFK39iPDFW3t
	 SvbL+5IdjXs59zSPlybROToOtZBkC2JcPyK1ur94A+Ww3RPZv4276ibX4Epqu+Su1lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=z+7iqYy4OkIb8W2YjxUcaoM9qADwsgWhehmQGnSdoNY=;
	b=Z+qYlVnb8IZeEubdgZRMhIUc4CAWWK12NdKEjRZMi3Hn2YWRkyLsa32XxOe9vrYh47uQ
	 AkoYTBPbjahCYFI2H3rZ/W1Iib+cFPLwnpLQjbawBX50ZIMyD5kbPdTCWL79yogjMOEKB
	 7rF//seBHrqp4130s9D5fqH3bmQxe3WQYbi9Y0sQm9bkcfyhbn2Nv0YC157WaMaJRBPk4
	 tTB4taXMFV5vBGyCE5S28oO3lESnUrwUdCgQ649LAN/N8a4Ce6qGsFkU8WQ2EHFY3vVJs
	 /legEcfIfI0qzaR1wO2gboXxkL4QG5H31ptklyT6pAO31phkFf5PB9ds9GuogvC3EEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QbUB6MkF;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1E606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D1E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QbUB6MkF
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e96502e447so31266435ad.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648198; x=1794252998; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z+7iqYy4OkIb8W2YjxUcaoM9qADwsgWhehmQGnSdoNY=;
        b=QbUB6MkF8hjayv2sm1ZOGDz7bZrtbGpg4x14g6XZ6y4BaqeIUqcnU3uZRqQZAq+Z24
         RCrulzK1gnDaqLCrozH+lc9y6EcLvca8ij2erDoG1e3LVCToH3JTHnhbyBFPxxxA+O4F
         u5tRXHVH3EO8yFsc4m5MJl9KmfYXFIaVDV3bqIFQmy73dC85l1Wx2+dgxcXUByQtNA5b
         wVdcA36zRbicVQFsmWckbD1kRLHjEysCTWsOSWsyxnzZeWGQrHhz8nsMeR79hZTdodjC
         oc9IG2TtICIiRWNpGh7QZMqUfigvTJ4XBMX7NFnyMATd5qXfiuSlpCul/+gfVShlSar+
         D8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648198; x=1794252998;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+7iqYy4OkIb8W2YjxUcaoM9qADwsgWhehmQGnSdoNY=;
        b=gsmhtMHpabeLxTQErU6vWZcllEq/sAzIOyaVP0001GA6qq6BucODDgfLD4c8w1Nt2/
         kCy3T3CvXD3bypSbfaeBlAJ3C5Asd+10XWQrVjeVoCbirZuPK/vHUm2QmOWS4cLdeclQ
         +SIR30Vd5WtYKpX0MmyjtD7WMF47PTA4qsgZk6gSNEPHH2o9lh1zGR2qUdz+kILmlBeB
         etc/OigC9K9nq5vAsEEHETOe+xaiYl6cVcDNOzo6THMjwFD+ZwdSze+sThNgIcSDLE9T
         uRcqB1RGTtJ8uizmCrifpqIhGgno+a8NfYaNs0FmFqwmDeUpJK1H7vzBmH6W3JpYdmVJ
         JsQw==
X-Forwarded-Encrypted: i=1; AKwUvBxu1rTMDUbecjX3bwFMoBmVVgFRQLvm2pPlNld0ZylKFdbJA5YXnqaXzgfGzSIilcp9s8A4FQo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+us5JGd1Ay+NbxYPteh2dkDVR4hwn8AhPnSJCkfr7KVvjVsPiH
	+k+xX6sI8zD1wTz3Qv5j23ivyRzlReKrelWgGojT9GkC3EGP5NIAGkhC
X-Gm-Gg: AYBFou0ie4IuNxoBFscvJ1vtx65J1NIMs4ZmafAVmAp5emkNqBV6kcDKwWQXjZpTpVa
	hAPhMSQr9PVYQBmjjGJACy3Z3JZ9FltoJ7dh/j7i7RgKhGfJOwnafzEU0Baw0ifnznXb4HFJJZW
	ZTkd6kKupD3/lAkn4kCrlMGqt63S9szsDoWvPpETlT4EPidIlEOgxeYXhUUTbVXyrW5ydNuLCMd
	+GuU2UnOrUfR3sYpLyUmXkZ/nyHr1fs2VQrNWDIa77twAULUMhpiBJBQAQxkM0tI/hnxDCn1PKc
	9jqpxBL+qIW/PIEnDAUztS6Ewl3ZNBB7mASjhdqixSzvsVxnfnJ3iuBTKVlKBtMP1/IS0z1QUxd
	a+XEPWVezzL63n2uTnXIGd2V8Opyo7hVAYp3DEwD4J919Pv0sWOWvNDZu8DU2uhCzLa9/GrudLJ
	LYQ6NGN2SSCJrCIyu/4ezan2nF6ofh3DsiAX2jEt6eepOGn7271tUN0362/PkR+z4UGmCYP+lD5
	EvJBoy6qbVQqjNm0qvIXWIQnDFsfClrIL6ht/pbziA81NXtx3JZtJQ3HvnrRfRVWhQMcE/Z9ern
	WdWP9XSiObrGl61Gjk4aX8lXw5dpx2sVGWsua3jh0DJVqDBCzQIzm/PjMn73MTsDR+SH
X-Received: by 2002:a17:902:e5c1:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2eb36414ef0mr104248555ad.5.1793648197830;
        Mon, 02 Nov 2026 11:36:37 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392965fesm31536785ad.59.2026.11.02.11.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:36:36 -0800 (PST)
Date: Mon, 02 Nov 2026 12:36:01 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an egress redirect before each send
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
Message-ID: <tnw3t0.mxmnzrgt0n6o@gmail.com>
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
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:21, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Chris Mason <mason@kernel.org>
>
>tcp_sendmsg_locked() expects a caller that has the socket open. It uses
>sk->sk_socket and the wait queue sk->sk_wq. For an egress redirect of an
>sk_msg prog the sender calls it on the target without a reference to the
>target's file. Both pointers are NULL before accept() and after close().
>close() can occur while the sender sleeps. Then the kernel crashes.
>
>Fail the redirect when the target has no struct socket, or when the sender
>has to wait for the connection. The error is EINVAL. After close() it is
>EPIPE, as today. sk_stream_wait_connect() calls remove_wait_queue() without
>a test of SOCK_DEAD. sk_stream_wait_memory() has this test, but it can
>still use sk_wq after the sleep. This patch does not change that. The
>target can change while the sender sleeps there. Thus do both checks before
>each call of tcp_sendmsg_locked(). Clear MSG_FASTOPEN, so that the sender
>does not call the connect code of the target, which uses both pointers.
>
>Today the sender can send before accept() and waits in SYN_SENT. send()
>with MSG_FASTOPEN sends the data. Today it fails with EISCONN. When the
>redirect of a cork fails, send() returns success and the kernel drops the
>data, as today.
>
>The Fixes tags are for the two checks and for MSG_FASTOPEN, in this order.
>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
>Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
>Signed-off-by: Chris Mason <mason@kernel.org>
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---

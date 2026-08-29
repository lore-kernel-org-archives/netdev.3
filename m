Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE341D22A
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788036021; cv=none; b=u5FXWUvCWckJWtVovXT7HL8oVc7VRuWRSWYMJiNqzQAR6T09GGS+F35gwkbAMXw68cH3BywhQEfAGc5QNQ5lNmMBCs3Ud3paSHV5tmZfPDOjP8a3DvBhbXfgNXlpPSqY9A8a6M20RHhEt/rI1pe2yBnkzRMDQah3FiUCrvB23HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788036021; c=relaxed/simple;
	bh=YotKj/n7HEJkOQ0i0HvcaTeHbL0KjtVXMNArDGF4rGI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=DAwvtdzx1kps5WWwaSXE4QTuUgOwUBIVo0Re7OY+Us5pgc3wZp3ArZA9JpASstGhIR8gcfo3MnMQP0+Kl1MmsKiybfxQSOanuLkVZ3Pnl4Iwli87Al4jyaCXhvVrJVA9avZ2388UPkA4hSy/oA4BUYgVve8kjW9Ogv30KsA/P9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvZohbYC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvZohbYC"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92ea24a2dbfso217174285a.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788036016; x=1788640816; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wy61y1y/KGjTSjj8/a8SOjbmPUwv5fxA+GFfVHJzTfI=;
        b=PvZohbYCLeeNRUBnk5z0XYG3+3F0TrNJhLpA4HV8aIbLCs4JMp1lzpl/wdvulRAYEd
         tHFG3UiwZQ9q9Qaxt/B+pi/WyOd/Axw6tulJ7t1gEXTxWMlXHhcLMIDc7RGaV1LhI423
         BdpbQnj4/zcIVcPaieN89tTRkxtypjsRGWlUlXWHYsgWzD79IFJuAF9iiMHCyWT+jbjv
         Bxy6YVbKFTVT4Sk7aBEPCBE7krFxegcYvb5HjO38CVc+DJyGEjDogkxMQ1xnfPsE6dB2
         pjqg5yi1XxR4vjlRbeHeD7JhZsmYiScCa/8C2Y0HztQKAHWpfFP6qbiP1ZS8qM5VX4+0
         G2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788036016; x=1788640816;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wy61y1y/KGjTSjj8/a8SOjbmPUwv5fxA+GFfVHJzTfI=;
        b=FjBBKxPhYqbE9dc3/2N4jzUPo/3HW8nt21DqkP9KM6+MlEBUKM9SWDVioMn2UuVNGa
         MxgxNMQ2ICCUrC96EbHkIBQCbYQI6mIFDXe3+jbt0l7e234gXXKX2eb052DSKIIqaYPu
         z2HcwGkpJL+SRJK/EjtlXn3YDp5semwh1tn0LCntC2WEyVlaHkDukXW0j+UZAbOH8+EC
         hb9IhhFaM+FdeEiaPIOiT42Q/QV6azn/5T0oz+d3nDJ3Ovjoq+w2nuYyKsg9WAQ3AQH1
         r0spSGGZgBQMOcpgu0xcMXXbDLQKKKjtCpM9L0Qk6CB+RYUykPhGCU/M7FjJ0toCIl9P
         FI4g==
X-Forwarded-Encrypted: i=1; AHgh+RoTAs8G1v2qVoK8vuojUv5/L20ru3mSZ7lwcfzsXNGhwrKscOTeGe5P6PFgxghpI58yhUEvNHw=@vger.kernel.org
X-Gm-Message-State: AFuF++k9y+JOW5cuqLC/tdzJpAZyemQWjzBEgNuNMyrLej8uFrwPA7Az
	burrFM6wFhE8NHhwdgmdZtkW3EnRt3lDUMKjOKqV/s318+FNxu8JlboV
X-Gm-Gg: AR+sD12L9JscUXsg5r680rU2kntp9bwIRLWpOT0yvqZjFf799X5KMaVwzI7Gf0ecmbi
	qkPrbSX2npKB8M53+g9LfIGL4dqgzOC8HG/GQSY4J7oiEgTlOcgHQNU61TLSkQ2+QCifeoFNb27
	ONQIwVQ19WWR9JfwF+Qskkp4w8YiOCUlZYoCjcf54nrK+X6XiHs5hCqGCRRAl0uyw0VYUNfldsW
	ej7myNFWx2cqp28TspK/z1S2iuir3ztbFfHiup15p+rEYqEyXRpHEz46gTYqbzfypq6rY/MmmBN
	7+Rj7uIA7cJ6hjlrnMPPbkX9v/hMIIamWEthveuL1OGwcUC/CEbdnIpzdCRhyiM/EWgR/n/wRpU
	/azRnGiZtja4NnBz5d6/VZdLGaZaEc6i2iYDvvGH6Qf2yU7s5Jhzml89gn36FJZcyljUktVMOXf
	dYGditiSDDGSeuId0YygbEMcpJP6dkeBT49WuTl3IisdKyqc3GkfgsCpE6ugfPkkMoq9Z+7xrxU
	7h8
X-Received: by 2002:a05:620a:6d51:b0:938:fe7a:b829 with SMTP id af79cd13be357-93913901128mr1397559685a.23.1788036016024;
        Sat, 29 Aug 2026 13:40:16 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939170138eesm439012585a.3.2026.08.29.13.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2026 13:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Aug 2026 16:40:13 -0400
Message-Id: <DL1PV8WQ5ZC7.1128ZBRNUPNUS@gmail.com>
Subject: Re: [PATCH net] net: psp: do not inherit the Rx association on
 clone
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Norbert Szetei" <norbert@doyensec.com>, <netdev@vger.kernel.org>
Cc: "Eric Dumazet" <edumazet@google.com>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Willem de Bruijn"
 <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>
In-Reply-To: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>

On Sat Aug 29, 2026 at 12:56 PM EDT, Norbert Szetei wrote:
> sk->psp_assoc sits past sk_dontcopy_end, so sock_copy() copies it into
> every socket accepted from a listener without taking a reference, while
> inet_sock_destruct() puts for every inet socket. psp_twsk_init() does
> refcount_inc() for the timewait socket, so a child closing through
> TIME_WAIT cancels its own put and leaves the association with one
> reference and N timewait sockets holding the same pointer. Closing the
> listener frees it, and the timewait timers then put freed memory.
>
> Rejecting the association on a listening socket is not sufficient: a sock=
et
> can acquire one while established and then be turned back into a listener=
,
> because tcp_disconnect() leaves sk->psp_assoc in place.
>
>   BUG: KASAN: slab-use-after-free in psp_twsk_assoc_free+0x6f/0xf0
>   Write of size 4 at addr ffff888110f9255c by task swapper/7/0
>    psp_twsk_assoc_free+0x6f/0xf0
>    inet_twsk_put+0xda/0x1b0
>    call_timer_fn+0x53/0x2e0
>    __run_timers+0x764/0xa80
>   Freed by task 99:
>    kfree+0x1a7/0x500
>    process_one_work+0x7ec/0x1100
>
> An association carries a per-connection SPI and key, so a child must not
> inherit the parent's. Clear it on clone.
>
> Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>

Thanks. Nit: I think the commit message overemphasizes the timewait
paths being part of reaching the bug. I suppose that is because the
included trace went that route, but I think anything that happens after
the copying of the socket's psp_assoc without taking a refcount will
reach the same issue.

The fix looks appropriate to me. I also think disallowing rx-assoc might
be something that we ought to do.

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

> ---
> Reproducer available on request.
>

Sure. Let's see it. Here's one with packetdrill and netdevsim:

cat gtests/net/psp/repro/psp-listen-assoc-uaf.pkt=20
// Expected on an unfixed kernel:
//
//   BUG: KASAN: slab-use-after-free in psp_assoc_put.part.0+0x1b/0x60
//   Write of size 4 at addr ff11000112918a60 by task swapper/3/0
//    psp_assoc_put.part.0+0x1b/0x60
//    __sk_destruct+0x7b/0x630
//    rcu_core+0x508/0x1470
//   Allocated by task 258:
//    psp_assoc_create+0xb7/0x3f0
//    psp_nl_rx_assoc_doit+0x1cc/0xae0
//   Freed by task 77:
//    kfree+0x321/0x500
//    process_one_work+0x89f/0x18a0
//
//   refcount_t: underflow; use-after-free.

--psp_udp_port=3D1000

// Initialize a listening socket.
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

   +0 psp_rx_assoc(3, [7]) =3D 0

// Complete a handshake. The child cloned here silently shares the
// listener's psp_assoc pointer with no reference of its own.
  +.1 < S 0:0(0) win 50000 <mss 1000,nop,wscale 0>
   +0 > S. 0:0(0) ack 1 <mss MSS,nop,wscale 8>
  +.1 < . 1:1(0) ack 1 win 50000
   +0 accept(3, ..., ...) =3D 4

// Reset the child so close() destroys it right away rather than parking
// it in FIN_WAIT/TIME_WAIT.
  +.1 < R. 1:1(0) ack 1 win 0

// First put drops the only refcnt
   +0 close(4) =3D 0

  +.5 `sleep 0.5`

// Second put: psp_assoc_put() touches freed memory
   +0 close(3) =3D 0

// Keep the VM alive long enough for the splat to reach the console.
  +.5 `sleep 1`

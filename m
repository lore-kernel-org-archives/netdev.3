Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BE471D14
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449964; cv=pass; b=gN5UULPf0ovVJalI9r0KuEkz06Eyun1nIyf9H/GosrGd4Z2b+WQ+ZgkmEg7Nc8EcFH4ZA9L8NpBGmmeR1tH5eV9Gb3xnPpvOfVzod+3grqIwGbrKokz85+Y7gbjL0Cc9psijNbntdbrXA8JLzGmNtEDtzJD54/YP1ApLbBZPCL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449964; c=relaxed/simple;
	bh=V9OfYkA6zuMtTZgZbtwdJbEfYN0Dn3ju4WLaCHbFiZY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iHosiJLi7Gn43MeaCZUARsnStTawLiz0MSjmrSltyRrnNyzHmkOqLAgdoRzm2rN1GgFpiuVZfJ6tbTtF1PKmJNbFF9ePvU8SF2IOiVfIGXhskQi4Vmb9aK04KXG954IEo6gKwO9pf+IT6NXpbqKBKPce7YuMZNBnXy06Xv+fv6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish; spf=pass smtp.mailfrom=ink.fish; dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b=5lol8bQP; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ink.fish
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b="5lol8bQP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so4009675a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 01:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791449961; cv=none;
        d=google.com; s=arc-20260327;
        b=Vb3vhpHWndFqLJ1ll4yzul7kneEIpvELV44yqWtuT+SfXukwCx3m/wyR8BZg4vnNmS
         yrFM5L/TRifdypv938U118qOecMzlHoPoPPabwxtfOc5u/uEwm5Bucpumltf2zOHUyem
         aOWYTDZjaRUq5Mk+gQBo1S5vDBvXvOb+4opnhtVYb8Z395vtzdXd7KNRXHWSOgoSurBi
         lON1Fhv2M2NjljUxDWuhwfk+jURmQjAbDh6i+/Y6TAYC2I0duWDswIWcF1OxpaxmJ6/o
         +ydXVYVLQRgtWv6CuKqPSDL5RkQDVZBCcNvf2XBMKe/gj/XStZ1VBoDao2MTBRJ8BhKw
         76Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mBhOLP3WmIJPpWiW67BdHkRrddxAcXRk0zqgY0VxRvw=;
        fh=VK62o09BttqJZljQPaJlpMv61+2+/Ks9CpwKP9eK/IE=;
        b=dGfYrNdO4WQ3r03WfHr2hCP+5K35Rx7DM9K53D+qikeYZVR6Yx7Gm0FgLzNZkDcRmV
         bmOup+LzQHPHnbVi1nTBmph9EKeMo/6WETzjMz4PtUziVRkLBZpsVqHMqWEFmIsktN5p
         i0sVjFlwbN60EeVmC5UWZJ15ECbNueGp3tZUrFjTkL/X4qOamSWklUnH/fipTx6ukGf2
         ja3H+uRS7rIlldsX8l2S1q60nvQeKSlltEnhfac44IljNq9tBkHpfKE2jTuD7MFqFr4Y
         bltSsptL27fmX7cocdGRIBrNoxEGjoddMBPlG582rb7z7HH0XR8wTKxORtbnO/ePA65e
         teyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ink.fish; s=google; t=1791449961; x=1792054761; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mBhOLP3WmIJPpWiW67BdHkRrddxAcXRk0zqgY0VxRvw=;
        b=5lol8bQP/wbCj0DWGUeR6m/rYrN3jkpB8vSXsPrpqjp7m3icFhK8s4I42NMeb5vu0G
         gm/vpoGasc4Z8u5nwOSTBVwDtP2FZ6MIWM5XBYcMtEsvq9KC6OMOdEePLU7VP7/0I1pR
         xiMMau7wcTESg5BWSWPbu4K5RhYV44uzqYqdS7UJVBNkig6OZKEKUFQvwNQS+G9USfj2
         7PCTLNuElKMrnKewar/CuAt9JuMLeBQBcCJHZtTyiCMFyvziCBXdc19RI3CgjClK1Pzg
         uKB4+zjMYz5M24BzFCxHfSbOmDtOmes51ccybHfmCfPIXvfEBAwKbvYtdjaE4iZlRihI
         g4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791449961; x=1792054761;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mBhOLP3WmIJPpWiW67BdHkRrddxAcXRk0zqgY0VxRvw=;
        b=Pl0n3ID5kx9KD6/+HTNcGVOrDMwwoEM5d8Vcr1Gdre4U7rMZOpJktdfVRjhpYJlJKF
         LbZR5w1xOpAUfxH3IvnphDqQiVoGjjTBNbukJLrl7DCuE4gA6MfzXONj0410Nz3XSw7q
         nFftfSPsBHAY8YKOzGMOM0tgvA3GufiVfppPkJ8GjWkgQI8PEZZz7W5IH4A0CjmUHlWx
         h4O6BvDlXgIEj19Gl00OKgZc0dIszO7fIrUdjT5ziLXrI3B6Q3QHP7ep1pKtkcArqUNN
         OA92xpt9mtPtBBn3pipDVh0yenbBMgPnX2H+Q9noENbcGWgSSn1N4KVHx98ao0Ddph26
         AhqA==
X-Gm-Message-State: AFq9FYL5Pvu+qQd4bCm9XnfM0P+nTofYEoclq0AAhgHozz+rOllqpyT6
	NzYHhWr94JW+UfeeRupy7tHRLkDEyb72px1NgIUafoZrqiG8PtCgKTEI/g282mjvypaykhss9rX
	qhWgoqF+uGBRzttYemO5mxPCoZ+dWQXpllOofW2n8UQ==
X-Gm-Gg: AYBFou2JmirifPKzKmMiRKgI79D9YpD1lRxEwxvD78+5fQ4mR8rnrfj27vChsOxGgV7
	56kB/PuNEk96x7LSCrHDE3sERy51VYEl9Or9Zlez1bPdPPxWuowrH7/VnW8RggH8saqVJ4R3JQp
	gqt2mWmwidqk0SCrrR/wsRNcBWVkpG4ocioLJvW3j+AaHtV1qdhQ+ZtaN7/kVTNa/v6zZDiGhh5
	xKrzALdynuXK0yD53YQxGnaghQLbn+d09kNVLeT/CJXAP/RHMQOHxM/dOVta49jYadW/NvU49p1
	aNwvLjhh2W9uAd9vp11y50vSp54NjIs+DcfrRGkxr0Qucxjtuhb8ChpoFYyCZan/hitHZzrN3nY
	wZtG8y1fofwV02G5Fnb9xQAjazWVlZ8dOQUYnHUl/M+oy8wApXXK3Iguw+Wy3NwSst0vPa95sdc
	8=
X-Received: by 2002:a05:6402:90c:b0:6aa:665:830 with SMTP id
 4fb4d7f45d1cf-6aff39863c9mr4489257a12.15.1791449960726; Thu, 08 Oct 2026
 01:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Petar Sakic <petar.sakic@ink.fish>
Date: Thu, 8 Oct 2026 10:59:10 +0200
X-Gm-Features: AclHuK836IDATouq65jvcju88QK8M9m3jvnCMF6upJ-JVOeg7kgJFpniiqVMFf4
Message-ID: <CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com>
Subject: Bug report mptcp: passive TFO: data written by the server before the
 MPC third ACK is never sent
To: mptcp@lists.linux.dev
Cc: netdev@vger.kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi linux dev team,

There is bug I'd like to report:

Summary:
With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV (i.e. after
it has consumed the client's SYN data but before the client's
MP_CAPABLE third ACK arrives), that data stays in the msk write queue
and is never transmitted. The connection hangs until the client gives
up and closes. Plain TCP with TFO is not affected.

Reproduced on:
Server kernels 6.8, 6.12.111, 6.18.15 and 7.2.6 (Debian builds),
client 6.12. Source read at 7.3-rc6 (602042bf, 7 Oct 2026). Lab:
client, NAT hop and server in separate network namespaces, ~120 ms
RTT.

Steps:
1. Server: `net.ipv4.tcp_fastopen=3`, an MPTCP listener with
`TCP_FASTOPEN`, an application that reads the request and replies
immediately (we used a proxy whose upstream answers in < 1 ms).
2. Client: `net.ipv4.tcp_fastopen=3`, MPTCP socket with
`TCP_FASTOPEN_CONNECT`; prime the cookie with one connection.
3. Second connection: the request fits in the SYN. Server replies
before the client's third ACK arrives.

Expected: the reply is sent once the subflow is fully established.
Actual: server `ss -M` shows FIN-WAIT-1 with the reply bytes queued
and `bytes_sent` unchanged; the wire shows the reply leave only after
the client closes. If the server's reply comes later than one RTT
(slow upstream), everything works.

Analysis:
- `__mptcp_subflow_active()` / `__tcp_can_send()` skip a subflow that
is not yet established, so the server's early write is queued on the
msk.
- When the MPC third ACK arrives, `check_fully_established()`
(options.c) marks the subflow fully established but nothing pushes the
msk write queue. The third ACK carries no DSS, so no later event
triggers a push until the peer sends data, and the peer is waiting for
the reply.

Candidate fix: (tested only in the lab: 30/30 requests succeed with
TFO in use on a patched 6.12.111)
```diff
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1058,6 +1058,13 @@ set_fully_established:

  mptcp_data_lock((struct sock *)msk);
  __mptcp_subflow_fully_established(msk, subflow, mp_opt);
+ /* Passive TFO: the application may have written data while the
+ * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
+ * it then and nothing else spools the msk write queue when the
+ * MPC third ack (no DSS) arrives. Push it now.
+ */
+ if (subflow->is_mptfo)
+ __mptcp_check_push((struct sock *)msk, ssk);
  mptcp_data_unlock((struct sock *)msk);

 check_notify:
```

We are not kernel developers; the maintainers will know whether this
belongs here or in the fully-established path. Related but different:
e00b63056fb4 ("fastopen: only mark MPTFO subflows with SYN data", Aug
2026).

Impact we saw in production-like use
Shadowsocks-2022 proxies over MPTCP (xray) put the whole request in
the first write, so small requests ride the SYN; requests to targets
near the server hang. We have turned TFO off.

Thank you
Kind regards
-- 
Petar Sakic
ETO/AV-IT Engineer
Inkfish  |  www.ink.fish
Deeply curious
This e-mail is for the sole use of the intended recipient(s). It
contains information that may be confidential. If you believe that it
has been sent to you in error, please notify the sender immediately by
reply e-mail and destroy all copies of this message. Any disclosure,
copying, distribution, or use of this information by anyone other than
the intended recipient is prohibited.

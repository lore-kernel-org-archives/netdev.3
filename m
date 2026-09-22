Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4C15853B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035742; cv=pass; b=dBCy02fcIoNbbiUimbsOy6x1hAg7iWlgueW45QKX8HD5fVSYIdxr9wIelBFSgfm6Ga2T6Gq3zaYvSOWW0Mnm9kb5H4f2LjM/fSYbuxrSCWKdgP7yejdzi6UqrDxmEF6Ysjvn3l/0LJNraNcPPzwP4wdTVcuZlAze2uF3QBvaUjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035742; c=relaxed/simple;
	bh=wF3vujnRO1n69hpZtPqhXKokXwTBo6VHQ5JFTi+xvIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ2/OQDl2GZuNDUau68utQFPopJiJHKq+7FtHnV92YkdOVradnII0sEFQuQtUYIRoeqWk91tfxnoD/oZ58L2hXbZ0OQVNXlLYNZ+GYYu23l8PS2ieCK2oq1OE8SGbmHn98UODj6TT59hYJf1ra87M7J1MTpeh2q7jnGFSWa1qmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HoWGYWzl; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HoWGYWzl"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532d63f434fso11280741cf.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790035739; cv=none;
        d=google.com; s=arc-20260327;
        b=jQ4Skt9hCo1WZA/usoc3O2hfcEMaDTh3UYwRGLaek4Jk9r7HWr6Wa9frf42dDkRoGJ
         KNyO1eX5jJ/CmRY1i8uv4qhs5Hw27NCZGpGdqfjGdPu9i4XjqMVic9EAoS7TZQ8tIZvx
         DmLEvpx6f+m4kryS47k/xIZVduPLxKWuthYMqbA8gdZk9e3Q5VxrSBBLyxrtBxtcW2s8
         nveUKGV73N+V8nCX+7IlExyufm+S7GZVL4V67GQ0J+z82LqFsi7pg4UST6MAnA8HQDMb
         ybJbmkNpy2YMlocp3d/PcBREbNhc054Mwzwc5BFYMtFXM7qJeZPnqVyXoeMy0KC/qre2
         3VGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zkltWghb5cMkgMfvZ7QUnNR/9sY6aTvlx7R/Zv+9e4A=;
        fh=6zfc34g9dSC0U+f8Tklj1Fl9FF2409hSLYzYwy9S3Cg=;
        b=DlQp77hYTrKgOIKXDA28v2FvQxBE+3lUeqWo7rn5vRDDEaUp4IwBdyUz76YxBsif+O
         48O8pYKw/pDbBYreBeBLTpMLGO17vNTk6IZkuWR+bPMPQCGYNhMDcW4z5rFhkR1Ve0rT
         xbWPT/SkaoMv+kuqBtQsURM4yQNLsNstaTviVU8xIcdBlesvkBQzf7cTHsdZZep/5OfZ
         dOWNVEVPYOaanYKiWQ6a81t6Z38DoJpRo6F5WBy/RZeThkT1nQ513SoQIjarraNj+XqI
         paDXBY33zOuO2XlyQkTBK7K5kfnaME/MJHKqkLv+Kd+cBxXeZLsxP5o8zqNQW9zpzspb
         MsYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790035739; x=1790640539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zkltWghb5cMkgMfvZ7QUnNR/9sY6aTvlx7R/Zv+9e4A=;
        b=HoWGYWzljUH6w/ki8+8lraUzkVFFWDBiR+LrK0VQsOjlFKqXdO7eNgQVrJZlDbkvUm
         zZsWzUOAp7cxLkmu8zF/fwv3tKRxZb9barIBsg73LJucfEoQy1yUv/gHjwhBYPn2kyYW
         VdZZH+yKrVOSWelXTrB1Fr6z77cuiCXTv7jJ/GHJiuc7v8REaG9oYMCxzPbHJDZoqYnU
         LnhvfHkGx59zhEgVI1vTr+kC6MtxqDm94qMrf/5X5KcuzMtqN448ZnXIiojaRkqd+RAX
         imMs9LM3vp8jcDfxShG55Vw195/fkrav373HnDXUdJU8mfcFTbqz6IMLAXHxrlVbkYMa
         PZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790035739; x=1790640539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkltWghb5cMkgMfvZ7QUnNR/9sY6aTvlx7R/Zv+9e4A=;
        b=V9mZZJBCJ5z5hswxPEiQwEV+cCY6o4ulwt5tl6Kqg3so2KhNDrlet2Nmz71udRVjQR
         Qe9F6V015Ish5f6P5qewTCHfmxgEF1mPny+slgjSZW46xSrLyeHOkOLzP/Q/932zDy+4
         cViX1pdz+yFBHDkehEu5LB42lFWCN6vrsdLIJLnX9sNTNb5/DtwD7MoG17mUw5ne+cM6
         IKog6Iw/KsZEJ9rJvBS5IecxPo9t7IkWOgYncnBoGhv+M6OrywxJh20V4EI1XxBmL5X5
         9T8l1i4Gpjw+Arvf8vXkXbo/SqSBavPFOoofa8q1Di2SqeUf38RNuk2X3/v6Wd3fnQIn
         jH2g==
X-Gm-Message-State: AFuF++lBQE/PjMm3qnOQT7zgsFILES/aU6G4U5bIxTQeZUpYMBz/qLGf
	92HTmOhmx5q3Ld/nw1s2eBUHxUm6cLKt3bTGNQqe0EUx6RAwC0fzlAbJujEN4fTgoY0e8wxmRKt
	Y4zW6qAwUi3joEpGiyLOqiMY+QevzHqa98/NjE6gd
X-Gm-Gg: AYBFou3ZEZ6rSvT4Wd2t1ZEYq2Eb1B6NaikAARNWhWd8DgjtjFNcp0H0j1i0z+lNRMy
	X00rEVD5m0Xy4eKeUaCsX+9hL8+dnsdW7UFVM6bk6Z+tZFoTLn559JMFoFE+6e+Yuh3Gv8SwVro
	5ih3xopNSm60KOwugJC9fFt3QAUs5lmQLk1DOItB08J2Y79jwbpLc5XsCdSMRBhr4xT5n67lHQo
	ftwLcBq6Jp5gVGtPDaSoIjDdVKVM+FE4eCbWdhAgZxZ1XA3ZPvkDM5kk38OXcfMK2I4gPI/Hm2E
	IsWSEVhzzy42ZwsScyHboJkcKw9EsTVj9YR8mQXVa8wb+xq/G6kxOBssP9rTxachm2lRk1jDQ2+
	wa7lotj8oeUb7hJ2/xzwcJkrZs4llKF/ORpbQ4ZJ9aI662BL6UgMnlECdtCTD2tF1qqWGkesN0E
	eM06EV
X-Received: by 2002:a05:622a:1f8e:b0:530:dc5e:27c2 with SMTP id
 d75a77b69052e-532d8d5e8acmr32325951cf.27.1790035738992; Mon, 21 Sep 2026
 17:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921222609.50824-4-jeffjo@openai.com> <20260921222609.50824-6-jeffjo@openai.com>
In-Reply-To: <20260921222609.50824-6-jeffjo@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 02:08:47 +0200
X-Gm-Features: AcwNN1U-1SKZ5f3WClJb_Otr_H5noTqM0KEs9GkLlh_XKBzCb9vk9EeI4Fd9YSY
Message-ID: <CANn89iK00zXGA8sdpH9Y1CkFK3n=uKG9Bci3+=69fGV0UDQ80w@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: net: check timestamp echo after an old ACK
To: Jeff Jo <jeffjo@openai.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:26=E2=80=AFAM Jeff Jo <jeffjo@openai.com> wrote:
>
> Add a regression test for a gap-filling packet whose acknowledgment has
> become old. Linux first sends data to the peer. Deliver two peer data
> packets out of order: the later packet acknowledges Linux's data, while
> the delayed packet still carries the earlier acknowledgment. Require
> the final reply to echo the delayed packet's timestamp.
>
> Use a large jump in peer timestamps to represent the idle interval.
> The test checks the echo directly, without waiting for that interval
> and without packet loss or retransmission.
>
> Packetdrill does not currently compare the timestamp-echo field (TSecr),
> so the packet script alone can pass on a broken kernel. Add a shell
> wrapper to check all four outgoing timestamp echoes in packetdrill's
> output. Register the wrapper as the runnable test and keep the packet
> script as a supporting file.
>
> Run the test in a separate network namespace for each of IPv4, IPv6
> and IPv4-mapped IPv6.
>
> Assisted-by: LLM
> Signed-off-by: Jeff Jo <jeffjo@openai.com>

Thanks for your patches. But really we must not work around
packetdrill bugs like this.

pw-bot:cr

In the original 2013 packetdrill (commit 77954df72a78),
verify_outbound_live_tcp_options()
checked TS val against tolerance_usecs, then temporarily overwrote
actual_packet's TS val
with script_ts_val and called same_tcp_options(actual_packet,
script_packet) (memcmp),
which did verify TS ecr.

When commit 9a0ade62b7c8 ("net-test: packetdrill: merge Google
packetdrill changes
through April 2018") refactored option verification into a per-option
switch (actual_option->kind),
case TCPOPT_TIMESTAMP: checked actual_ts_val vs script_ts_val and
ended with break;
instead of checking actual_option->data.time_stamp.ecr (or rewriting
actual_ts_val to script_ts_val
and falling through to default:).

Fixing packetdrill in run_packet.c is just:

diff --git a/gtests/net/packetdrill/run_packet.c
b/gtests/net/packetdrill/run_packet.c
index 4aa235d35585..f5fdc8699970 100644
--- a/gtests/net/packetdrill/run_packet.c
+++ b/gtests/net/packetdrill/run_packet.c
@@ -1483,6 +1483,10 @@ static int verify_outbound_tcp_option(
                        asprintf(error, "bad outbound TCP timestamp
value, tolerance %ld", tolerance_usecs);
                        return STATUS_ERR;
                }
+               if (check_field("tcp_ts_ecr",
+                               packet_tcp_ts_ecr(script_packet),
+                               packet_tcp_ts_ecr(actual_packet), error))
+                       return STATUS_ERR;
                break;

        default:

Please work with Neal Cardwell to get packetdrill fixed, then ask
netdev maintainers to
upgrade packetdrill on their test servers.



Note: Even with existing packetdrill binaries in the wild that don't
check TS ecr,
tp->rx_opt.ts_recent is still directly testable in pure .pkt via PAWS
(tcp_paws_discard()),
the same way tcp_ts_recent_invalid_ack.pkt works:


// SPDX-License-Identifier: GPL-2.0
// An out-of-order segment advances SND.UNA. The gap filler still carries
// its original, older ACK; accepting its data must refresh TS.Recent.
--tcp_ts_tick_usecs=3D1000
`./defaults.sh`
0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
+0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
+0 bind(3, ..., ...) =3D 0
+0 listen(3, 1) =3D 0
0.100 < S 0:0(0) win 20000 <mss 1000,sackOK,TS val 900 ecr 0>
+0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 900>
0.200 < . 1:1(0) ack 1 win 20000 <nop,nop,TS val 1000 ecr 100>
+0 accept(3, ..., ...) =3D 4
0.300 write(4, ..., 17) =3D 17
+0 > P. 1:18(17) ack 1 <nop,nop,TS val 300 ecr 1000>
0.310 < P. 18:35(17) ack 18 win 20000 <nop,nop,TS val 301001 ecr 300>
+0 > . 18:18(0) ack 1 <nop,nop,TS val 310 ecr 1000,nop,nop,sack 18:35>
0.320 < P. 1:18(17) ack 1 win 20000 <nop,nop,TS val 301000 ecr 100>
+0 > . 18:18(0) ack 35 <nop,nop,TS val 320 ecr 301000>
// Verify TS.Recent was updated to 301000: a segment with TSval < 301000
// (but > old TS.Recent 1000) must be rejected by PAWS and trigger dupack 3=
5.
0.330 < P. 35:52(17) ack 18 win 20000 <nop,nop,TS val 300999 ecr 320>
+0 > . 18:18(0) ack 35 <nop,nop,TS val 330 ecr 301000>
+0 read(4, ..., 34) =3D 34

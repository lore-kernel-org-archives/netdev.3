Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962E3C1982
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945688; cv=none; b=dn1Se7SC+xQFMHQKR5MeTXGF9hjY4yzoK4frU0DGUK2kaAxNkt1PpjqR6rrc9LmMI74Z797BhSAZ66vqWyFOZ4OVWq7WiC7q32dJx6pXQRahfhD8vBFbqY1NtXI2jDA7UEVZqocJuVL6vaYUZc1/3guzWYSRCRWkM5kcTTi00Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945688; c=relaxed/simple;
	bh=i28nqnjE3Ex45/rzyt01knAs2L4DKyr5l1YvZcqtgng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=amtI/knqHVkGR7GNG+nWqent5PYmDMd5gQweXkjADnHsjZH6q3twkfQqAS5BYTT5e4XDtc4jnkbDvar3G7GCwCP3v+bYBAT1xN2mQ/OmIwMzbscLlRvtN/iVDbZWo8VmydjsPdCOuZY42ihA4uQNN//AYTXpVBW4s4PuFExZsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pE+n3ZUQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pE+n3ZUQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29f25e494c2so3164165ad.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 13:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768945684; x=1769550484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkdujCmDy/y/ym1vwY/RAZu/68Y7uCiFUVKsLditgxk=;
        b=pE+n3ZUQaTYqOFEYcfUhqIOGSGvqBmG8w6NqsdGyx0nLyxneZGD13Ca1qsJUTBR7WR
         0svaJmMclOiAvyaF/S1CWzLctWdeHjkc2DNGgMxFHO6PmF8DdOk/7DhAoU9zTiylLFDT
         OWC5OLp6E9zK9mnjbBu0tBI0/giKtFB/GSmSCq68n7NutwDYxW+nkgyFXd3QjrnmtJtN
         eq8AY5y+VPuXjSDOtj6NT0Nlw/1x43Yj4EJwwbw1Aepkcd/AsM/8g18kizYs8wm4azVL
         D/xfMGPhH+nfbGD5BHji2hhD0Lmc3fW6+x6O+zSZJjuDunc1l1Oqx/z/O6Ix0tofwaXy
         Ki1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768945684; x=1769550484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkdujCmDy/y/ym1vwY/RAZu/68Y7uCiFUVKsLditgxk=;
        b=D+qe1ESkv8KeyPhgCrPNn6nsHPgI627buqcDkSgKCEW2Fh6+Ft9c6W4oR34kRbcmoa
         AbQCGS39kkGiZWBNwF3LAGa6bcKAJLiWevWP+lW2IlVzvQQR3a+6m2mTahNTxMqjTTKn
         IID/9x2KbAsDOtWge9G/fXmRY6VMU6+251+8L5SbNeNq3b8sfeSp50BmleX1Lqx1DNVI
         G+m0dLlpGEMANzmTQxFgSbJ7yAiWDxKyW53/5Pq6H7lKdK7dMg6vBr6F8RKH0KRgtK3B
         QHtH/pk71vuoMciOUtBErXv3iR9YzDxiOIo3JONDOrLeFvMA9CbAofXcRTehCIN3RYav
         I+Cw==
X-Gm-Message-State: AOJu0Yw+c8MwWOoXH6H3tbSj4dhboBQC+y86fmn0/xYnmOmpOekfcBuH
	EKZKqqdmtHfqjGTCiugc7d/wkQA1wlVbTrE3BqPgWcYo7wKj5deiA0VBbHpuwJj5N1fCcD/IgwO
	uuZqnTw==
X-Received: from pllg4.prod.google.com ([2002:a17:902:7404:b0:2a0:98e6:379f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c08:b0:2a0:c92e:a378
 with SMTP id d9443c01a7336-2a71756b899mr142022805ad.7.1768945684209; Tue, 20
 Jan 2026 13:48:04 -0800 (PST)
Date: Tue, 20 Jan 2026 21:47:16 +0000
In-Reply-To: <CAFWXMN3WexdQEsjZRGumLuyA8phXmSte_j7JTAjL_v11ZxAmtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAFWXMN3WexdQEsjZRGumLuyA8phXmSte_j7JTAjL_v11ZxAmtg@mail.gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120214802.270100-1-kuniyu@google.com>
Subject: Re: [RFC] net: ipv4: optional early cleanup of half-closed TCP sockets
From: Kuniyuki Iwashima <kuniyu@google.com>
To: gopalmalaviya53@gmail.com
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Gopal Malaviya <gopalmalaviya53@gmail.com>
Date: Wed, 21 Jan 2026 02:03:39 +0530
> Hi,
> 
> Background:
> 
> I am looking into cases where TCP sockets that transition into
> half-closed states (CLOSE_WAIT or FIN_WAIT2 after receipt of FIN)
> remain available long enough to be reused by userland connection
> pools. In some HTTP client workloads, especially those involving
> frequent requests with large request bodies, reuse of such sockets
> can lead to follow-up failures such as timeouts or premature close
> events on subsequent operations.
> 
> This behavior is compliant with TCP semantics, but application-level
> connection pools may incorrectly assume that a socket is still usable
> as long as it has not been explicitly closed.
> 
> Problem:
> 
> When a remote peer closes its send side early, the local socket
> enters a half-closed state as described in RFC 793, RFC 1122, and
> RFC 9293. These states are correct and expected. However, sockets
> in CLOSE_WAIT or FIN_WAIT2 may persist long enough to be returned
> to userland pools, even though practical data exchange is no longer
> possible.
> 
> For workloads that rely heavily on persistent connection reuse,
> this can cause intermittent and difficult-to-diagnose failures.
> 
> Proposal:
> 
> Introduce an optional sysctl:
> 
>     net.ipv4.tcp_aggressive_halfclose = 0 (default)
> 
> When enabled:
> 
>   - Upon receiving FIN and transitioning into CLOSE_WAIT or FIN_WAIT2,
>     the socket is marked as a candidate for early teardown.
> 
>   - After a short configurable grace period (seconds or keepalive
>     probes), if the socket remains half-closed, the kernel performs
>     a normal teardown using existing mechanisms (e.g. tcp_done()).
> 
>   - Sockets handled in this mode would also avoid TIME_WAIT reuse,
>     ensuring they are not inadvertently returned to userland.
> 
> A secondary sysctl could control the grace interval, for example:
> 
>     net.ipv4.tcp_aggressive_halfclose_grace = <seconds>
> 
> Default TCP behavior remains unchanged unless explicitly enabled.
> 
> Rationale:
> 
> The intent is to provide an opt-in mechanism for environments where
> reuse of half-closed sockets interacts poorly with application-managed
> connection pools. The proposal does not modify semantics for established
> connections, connection setup, or orderly close initiated locally.
> 
> RFC 793, RFC 1122, and RFC 9293 define the TCP state machine and
> half-close behavior but allow implementations flexibility in resource
> management and socket lifetime. This proposal aims to use that
> flexibility in a narrowly-scoped and optional manner.
> 
> Implementation notes (initial thoughts):
> 
>   - Tag sockets on FIN reception when entering CLOSE_WAIT or FIN_WAIT2.
>   - Apply a short timer or probe-based grace period.
>   - On expiry, perform standard teardown.
>   - Avoid TIME_WAIT reuse for sockets marked for aggressive half-close.
>   - Keep all behavior gated behind sysctl(s).
> 
> Request for feedback:
> 
> Before preparing a full patch series, I would appreciate feedback on:
> 
>   - Whether the general idea is acceptable as an opt-in extension.
>   - Preferred naming and placement of the sysctl(s).
>   - Whether a grace period is preferred over immediate teardown.
>   - Any interactions with existing timers or state transitions
>     that should be considered.
>   - Any related prior discussions worth reviewing.

You can implement the logic in userspace,
e.g. with "ss --kill" :

1. Create CLOSE-WAIT and FIN-WAIT-2 sockets

  # python3
  >>> from socket import *
  >>> s = socket()
  >>> s.listen()
  >>> c = socket()
  >>> c.connect(s.getsockname())
  >>> s1, _ = s.accept()
  >>> c
  <socket.socket fd=6, family=2, type=1, proto=0, laddr=('127.0.0.1', 46490), raddr=('127.0.0.1', 58241)>
  >>> c.close()

  # ss -tan
  ...
  CLOSE-WAIT 1      0  127.0.0.1:58241      127.0.0.1:46490
  FIN-WAIT-2 0      0  127.0.0.1:46490      127.0.0.1:58241

2. Close them

  # ss --kill -t sport == 46490
  ...
  FIN-WAIT-2 0      0  127.0.0.1:46490      127.0.0.1:58241

  # ss --kill -t dport == 46490
  ...
  CLOSE-WAIT 1      0  127.0.0.1:58241      127.0.0.1:46490

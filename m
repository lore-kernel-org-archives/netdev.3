Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343356;
	b=hakh6XAOgc9uEkHOUlnKQBHXmmRPVpNcztiiYjGlcy5pIsVJUMXSvwYrft5nnr612jBS
	 UgeH8n4VJXiH3uPCb2YnrQQGgVvkz3Ah/rauBgT28Fyql4TsvM+1P1r5Hu13nAnUa6VpR
	 6IzlB9w9IPxbx1CGHpvVnkD/m13fW/ySWgxbdgxmOhxUYVY5KNoH56Ykr+3jOMCwV11cZ
	 5nn1aiLtXI4c+lgBkl5tAwwPWeLbMgSeEKzdTpyVhjgg2raDReUTnNQEN4gTXnOiBBwkt
	 Ft8xpdITm4hV5fSMXFtG63G/1pM1F/JTwMi/4THM0Y0lprEC/JDHL/bxdMEIRe1GgQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/Uiww4ezFXi6VNr6G5FkaTJlTRK1KjfoprXIwdlqKmQ=;
	b=Z7LbtKhzaYzy1d47kRX8HFMAQk/DYgZMFlCBsGXePPg1Wzu7E1LdF+N5bA4lrtDczx4/
	 iPGFxRGu6EA8hWEFpPcRR6iSkuj2kj+5Gvlc8xxKltHde8CLTKy318jUIs4ETOzy93KHe
	 GlMu3sEenQVme0vKJcaHUsFEBkFWFdvToB16uVuAoER3zt5QcaQDAJXM/ORGkcs/0TQ30
	 OWGvkG30L/IUfl5q1eCTCvARvZgqLOn69vWt2THnAyec18zDPIwoF8IY9uugwc+1PGLWU
	 vtiptWeqjw7ZCAP+O/6UEm3OqeqUahuZj2/wYbYxUjVbDvQJIgQhPQQ3zbGNdusOxTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PkYKGcSY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054A606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6054A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PkYKGcSY
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso1014718b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794343356; cv=none;
        d=google.com; s=arc-20260327;
        b=CKeOTK1MsJGdbMe1Jnp1GIOahR8ud/m/uwaWePsnPJvJOrDN20E3587OFLSv1W8Ydq
         AZtRLW/MJxrIVZqGJFLStdrr17LS6bnRV59VWTNKqqMmLk3zbgyM0bGnY8ZskDtiIBSG
         ZkhA8jxXD0L7RpAmz6mUofjitA/aOP4k706fT5As4syAhF1keFu4kKuLsvB81WqKii/y
         1wIt4TwOOyg2xLV9b7ZiQTcLjKQioB7N3QpLQyayKDdiRnaPEgWw0Z8jgf+2KBHSU2Sz
         x560WxNTnj3s4/krvzTLAdhTqwdUGr3JHAtJ6SE9YdbczWIvjVaXVkyceq0qrWBXL+BB
         oynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Uiww4ezFXi6VNr6G5FkaTJlTRK1KjfoprXIwdlqKmQ=;
        fh=dgB5UNzpVkYqkFHp1Rq0CpGzU5zEm5kjUkEuuJKIBQI=;
        b=IKB7hJr9q5MAvvZtfkUFXu9s4gDUUGNDdyEU6Slk2glVoi0SdNW6QVhQ94iw7Qymt2
         wFmnexZfzPf1c5w5jmA7f8pdjM6TAqHOTInhX6m1IIz9PC4rOuEMPV/jtgXG0QboDbtG
         cIW0re5HviQu/ZBd3ke34oaQJChyaFcTni/xSeUDCoujVWvMVm3QbMvmU75Ehtqik8+G
         aksrWZXPKOAol9mQ399D00B/AESNCphwBCnYolYXmqA1EwtwQeV4qwClE3E1/M7EO1of
         i465o7WNJYvp+QPvHdphLfBXWLhW3SR4I9uY/IvcfrKJ+PqQxAfgq57/+4oOxnE2RobA
         54Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794343356; x=1794948156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Uiww4ezFXi6VNr6G5FkaTJlTRK1KjfoprXIwdlqKmQ=;
        b=PkYKGcSYMDN/AxLAIZEBQZtApqxXY1YTHtR1/pzU2W0HHe9kuHLmiz9SMfl+9Azmy1
         AKBCGf4AvA7Zj5QGqvzGQRPEQAqVJhXBw7Fb7I99eMXQ6FqoFxKABqWHwmNK2wAYaTIk
         eAhgxsO3elDxymBFgFncDG/08ywScsh4rv7fOmnf0aLVdt8qtsIZTdfxm7UBjFDk/+KQ
         Pp0Ek3x1C1HFtm3IxInYYmXG9UF1iTrkn9WFpNAEjDvPicQ4PJ/gdMlu8HePQCnVr5rS
         BUhdKzjTOqO6E77NWZzyWNPDyY4yVdXVM5Lw0FDlEs4BYjhVWoIHdqQt7al1HzbZVD+M
         /2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794343356; x=1794948156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Uiww4ezFXi6VNr6G5FkaTJlTRK1KjfoprXIwdlqKmQ=;
        b=Jbg+WAMvG81aaCnONIY5bkEiK464mxP38au4M7+mDle7ffeIOw1c2exjb1LQAF+5ps
         3mDeiktWiuQ4TOt/TrNvKnYC0UfDaet/rVsqrttV+n4f9BEgBtUTi8znxiBZgm3YVC47
         qE8DzSURC9xPf0ABCf6TMVgNjrdRk0zJ19bjVCbiRIAy/hL4CvVknvPazjF6o1VEgRKp
         1USSAoc4m4LMYYaZq4xBPxbSxz5YuLQVZb1kKU26i6bTR1CHyfc1mEs6ekC5Fd7RcjG4
         x161ncbcYGt1G4oYR0IhxwuqQLOiFu0AqnrNbBjH3kAPKQdRrYBS+i4PnTEXq5pZDcF5
         mMPQ==
X-Gm-Message-State: APuU4Z8rpWX7PWlZCiYSzCkJUr3xRXDGcuuFQEfNt105LXYC35NhIcSi
	AQfxbYklNQ/6K1z8f/qrCZgVkCTYEctAB8ZUGqtyLkJrXx7mmd2GyA3+2RTH0MJXT2jVqBOCJeN
	SG8CopPem4dudVp+O+zuLkKhgh3rkR3w=
X-Gm-Gg: AYBFou31/xm6fUOuq1c8B9gTPdG8BlApGWjQFGiqII6Z5zGWCsKgclJDNb7HIL/giDj
	iH5pSmKdgEi+WXYYH+Emom/Q8QkMZVBnvPeClQG7TLPLKr/Yiw9t1kzWZYeR0uLyqYcZl+togVm
	kkwCfjHswLu2kQIWSaguTiTo51Z+FQvvJvPZTMtrw0d7h8iYJ1yYyxvQoezBKOwCQ0LmBPm+W1B
	Y+5dWQlEtw80xIgY4/RjpDRQOpDotptnwZ34ARrhsKwhqQZJcFuWG+GGSQ60wNbGK4pCdd5x3rg
	xp5fxa2cknoJZkhRlvwdjTX09InzdR6xJjOsiiLtdlVD/oL9ak/5rMywqY1SxZ/dyqAgiPvxSrX
	o0GSvUnAlANolzmgXvcyucGO5HJsAwQ35GRNjJxUj1Hfu5rpUPsO1C5w5n2j8c0odVqZK3jCs1r
	uCiFZLc9hHOWt0sVqE9/g8LDuoGFc9T7PZ42w=
X-Received: by 2002:a05:6a00:174b:b0:89f:e1e7:e7e8 with SMTP id
 d2e1a72fcca58-8bc1b6ff7e6mr297211b3a.18.1794343355486; Tue, 10 Nov 2026
 12:42:35 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105050225.49292-1-tim.budding@gmail.com>
In-Reply-To: <20261105050225.49292-1-tim.budding@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Nov 2026 15:42:23 -0500
X-Gm-Features: AclHuK8o0-xxEFoJvGfG6APBQwWLT1OmYN6Yn9riIkt6Sd9kIfeUFXq--mPOaSg
Message-ID: <CADvbK_fcFqT+rFN25sG69piR_HDy6gTnXyL9m=R-m9xumOOh3g@mail.gmail.com>
Subject: Re: [PATCH net v2 0/4] sctp: fix I-FORWARD-TSN handling with user
 message interleaving
To: Tim Budding <tim.budding@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 12:02=E2=80=AFAM Tim Budding <tim.budding@gmail.com>=
 wrote:
>
> With user message interleaving (RFC 8260), fragments of messages on
> different streams share the TSN space. When a PR-SCTP message is
> abandoned, the receiver still frees queued fragments by the
> I-FORWARD-TSN's New Cumulative TSN, which loses fragments of messages
> still being received on other streams:
>
>   TSN  stream  MID
>     0    0      0    B   64KB reliable message on stream 0
>   ...
>     5    0      0
>     6    1      0    BE  PR-SCTP message on stream 1, lost, abandoned
>     7    0      0
>   ...
>   I-FORWARD-TSN new_cum=3D6 skip=3D[sid=3D1 mid=3D0]
>
> The stream 0 fragments with TSNs 0-5 are freed with the abandoned
> message, are never retransmitted, and stream 0 stays blocked.
>
> Patch 3 frees fragments by the skip entries instead of by TSN, and no
> longer treats an I-FORWARD-TSN that reaches the highest TSN seen as a
> reset. Such an I-FORWARD-TSN is then handled by sctp_intl_skip() alone,
> which has two partial delivery bugs of its own: an unordered partial
> delivery is not aborted when its own message is skipped, and
> PARTIAL_DELIVERY_ABORTED reports the highest skipped MID rather than
> the one being delivered. Patches 1 and 2 fix these first, so the three
> fixes should be backported together and in order. Patch 4 adds a
> selftest.
>
> Patch 3 has a cost, as discussed on v1 [2]: an unordered fragment of an
> abandoned message that first arrives after the last I-FORWARD-TSN
> naming that message is no longer freed by a later, unrelated
> I-FORWARD-TSN. It keeps its rwnd and receive buffer charge until a
> later unordered skip on its stream, a reset, or teardown. Dropping such
> fragments on arrival needs new per-stream state and is left to a
> follow-up [3].
>
> Changes since v1 [1]:
>  - Fold "sctp: don't treat an I-FORWARD-TSN as an association reset"
>    into the purge patch, now patch 3, as Xin suggested [3].
>  - New patch 2, from Sashiko's review of v1 patch 3.
>  - Move the unordered partial delivery fix first.
>  - Selftest: add leading_edge_nopd, reset_pending_srv/cli and
>    pdapi/pdapi_uo; wait for conditions rather than fixed times,
>    including all data being acked before the queue check.
>
> Tested with the new selftest, sctp_vrf.sh and the lksctp-tools
> functional tests, also on a kernel with KASAN, lockdep and kmemleak.
> W=3D1 and sparse show no new warnings.
>
> Initial bug observed in use, root cause identified with AI-assisted code
> inspection. Related bugs found and fixes implemented with AI assistance.
> All reviewed and tested by me.
>
> [1] https://lore.kernel.org/all/20261024120627.837568-1-tim.budding@gmail=
.com/
> [2] https://lore.kernel.org/all/20261026052706.187296-1-tim.budding@gmail=
.com/
> [3] https://lore.kernel.org/all/CADvbK_du=3D-oT19kKBKYSjFKYscnQSH1mekRKMX=
gmLPMXTEH_=3Dw@mail.gmail.com/
>
> Tim Budding (4):
>   sctp: abort unordered partial delivery when its message is skipped
>   sctp: report the partially delivered MID in PARTIAL_DELIVERY_ABORTED
>   sctp: fix I-FORWARD-TSN handling of fragments on other streams
>   selftests: net: add SCTP I-FORWARD-TSN tests with message interleaving
>
>  net/sctp/stream.c                           |   2 +
>  net/sctp/stream_interleave.c                |  38 +-
>  tools/testing/selftests/net/.gitignore      |   1 +
>  tools/testing/selftests/net/Makefile        |   2 +
>  tools/testing/selftests/net/sctp_ifwdtsn.c  | 699 ++++++++++++++++++++
>  tools/testing/selftests/net/sctp_ifwdtsn.sh | 233 +++++++
>  6 files changed, 951 insertions(+), 24 deletions(-)
>  create mode 100644 tools/testing/selftests/net/sctp_ifwdtsn.c
>  create mode 100755 tools/testing/selftests/net/sctp_ifwdtsn.sh
>
>
> base-commit: 6baae996ecf6a3f57b08ea6f6786e29af9260f51
> --
> 2.34.1
>
Series,
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks for the fixes and test case. You may also want to look into the
pre-existing issue in:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105050225.49292-1-=
tim.budding%40gmail.com

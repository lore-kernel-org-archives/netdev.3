Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1F31F99E
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436826; cv=pass; b=uAc/scjYnHMLL/YvSvbj8IU4xHi3amc6Wq/FsDQOyAxt1eka0GlKaHZl7RQWvXKMkA48lYNBcWMuy+SYOogyKOvn72z1GmVJxMdXy7EPeGYYAMpZo9unMPlH1c2XPba/t2kgc9XwTwmbSoA1TWBU4H+bh8AdoB3ruHqFwGMJtNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436826; c=relaxed/simple;
	bh=DiRiLj5Gj9rm149wJ3vrTs71wgXkse3uxHpUzbdpQTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9lTaTGMvb90G0qrXO5aawiOCxwjiEM1qj/NGo9p/YkYAKDPsAPWMBxHC+tNgrJO0EDwz7CNHMYFJzYUaGqblx2k5fPb/O7Dcs9eyj0eqI96rohYN4atrAxDopR1J7LED0k4cD6snI4xfe0+t/rG68iuXWSSgwT0/Fc+URn/RbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qI7JAjZE; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qI7JAjZE"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8486672f03cso286003b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785436803; cv=none;
        d=google.com; s=arc-20260327;
        b=ansgKR5z80LDtczu5f0YpFJmqUKA+M5ydhTS/ndM9YYrLq62qDf/9BhhEbeo92fl28
         APYglcfMCOoChHOP7sopoTmaBkJTniYTh+bDzIWDpxnSOroTDTuCMUykAEIe05QaqhZQ
         hTdNVtL6HrpIfvvR9AFCyLdvU6/0r69bhqb7eICjfIPsm9kiXpkPGAvt6XPbDw4XH7tO
         QfDxzYc8EuxWhI+NXWHVUGh1vGdMqDhV8KU8eJlYHw0lVRqJUr/S4MFtyhEAn8jsxtG6
         qn68+1AGTf1JvqlcHC4Lunt8R7XYWlxCia7eqBL195kRQDTp9d/F02B1rZCbx57z4HZO
         g43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LKil3trjFzHGZpovCMjmw/LMxJHeiJVTn9D9hzvJcFo=;
        fh=YHBfOjs/ffAzbozHlHgsQO4UXGXM8Y864yk6b+I05JM=;
        b=Pr1enCaNwt5xAcBBierDlK/tR5HGfYUwjsNpi7dj/GEFkAklW7P+BxSoe5kQkgd7yy
         cxrOC0/D/nisfoDuqrVLw6yEOfxQwtztSgs7ib1/agafRjuCtU9g98ayzC4kw+vaL1Cp
         R3AXHvqVb4iTE0VkNh5KUjajsFWqEiIUczwUTVIZrUwHpJ/cqTp4COUTCTLLRskmxzzb
         Zc8cm7LDf+2GMEvbDuTfMMzKvjX7+B6VTD82+nNTwbBa0btliTxe/pwCCyYiIGhOlJKn
         R4/g/G17Ksa4Sg206RL7KVaf1+CNj1p5oSVfIQkaTRtNeTh/ITIbcd/FxRE0RjntA0FQ
         VaMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785436803; x=1786041603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LKil3trjFzHGZpovCMjmw/LMxJHeiJVTn9D9hzvJcFo=;
        b=qI7JAjZEicNGs/zmYoCrpf0KpEH40IkBU32bsdvwVrG0eL4HUpFDMvfHXYYSa52pYD
         zT/bthU29ON8Qws/qb7gmjrWkV7QAmYX/P5i5Ca3nNbTsYCGfHJzXGFwCUhqy+6/qt+r
         VG2HV4v+Y+Ae1QIoB8+upsIO/EE2zjDzOk8W4psCyqmFEeIEwl4ImSOO3sy7cxGk6Jt6
         2VeVBKSsRV5M2RJZVmSSv696RCGkMpnQpxZPLiYBCP0P+hI0azLt3hlXCJvZ6WNnpqX5
         xj/Wauv69Yp4Hb/viRWHDDdcAT2imS92lU8FSKW3ZSZO437ooj6WFaK/MiGc6p11BC8/
         N+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436803; x=1786041603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKil3trjFzHGZpovCMjmw/LMxJHeiJVTn9D9hzvJcFo=;
        b=UXe0fN+Y6Ijsv7QicX9kdDbTE8KIkwONfS7lczQirchEP1+mHuSfi1vIewWRpvIZlD
         LgzxToAsay1X2KSoctb0XP971j+NMDPy+G2z8QhfC+Hbsyo8DMeOijfAjx1nD2U5hqKm
         eUGM0Ro1thjN1c4PPqcQf5mg3b7bQzOkkrbMGcC/eQDByqFRNhiiehZtbN3uxrtZJHAA
         cppoJ53/yLEkMWlxzHcgTSsTso028BPaMBH481wnlalX1DqVjwUJnV91OEAlbILe8ZAg
         A2+G6cpHIht4Q/crCJqj1XME72wiX8uRJY/Bq9ziZxlSDm+Sy7gAkLtJ6SZXVSQv4fL+
         OvQA==
X-Gm-Message-State: AOJu0YyZrSGjO3rwYz/JVcktirBcWZtIaPtdC9i179ZePH766oFxMZxA
	MLIB6Pc/Y7TPqSiG6rwLH8E3UXpKv64klpPIudFU8yvb/RWM9TSJRvRRIEPaq2q2MY8zpboth1V
	6xuz631uQFfb1eDWOSAJBWLzqX+ZqrGEwyYVdo0dn
X-Gm-Gg: AR+sD13Zi+MBYifZ51IxxplyIyXiEKAg1s/WPxI4tLKHhP3StiXZ/G52J/BT8vUYEwO
	4iC8dxgHH02MD+XNEiUB2DPTbdsMiqt6CdcdNOZZz80m1f+wgSfQhp76cFCl//RuJ7z+gjMmq4m
	K2VZzA+uN+yKhE7wQuCJjWKo2HnXFWrB3qBWR3k6Yt2vMUalwZKEaJ7MvS4/NSS7sqWs+/K/700
	WxLUiIwxKEj0NU6Jl+317LGdnC1Xl2fKt/o2R4rDpZCtakrBV3bmVWIK48cJkzQ/jHWhLmmOuky
	gSkNsyErf6ExSys4ulBGQ3bZPgAPd3l8JQ953L1AzitLRgxMXRfMTn1ZDAGW9KdK0OuF0amGZPD
	wu9baJxllUc6W/c9i+eWUIOQxi0vKG3b/n4CUXehEwaYOuI2HMPFx6AlS6Q==
X-Received: by 2002:a05:6a20:728d:b0:3bf:6c08:fb85 with SMTP id
 adf61e73a8af0-3c90068cc0dmr3510655637.53.1785436802564; Thu, 30 Jul 2026
 11:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADqcGBmFyNEhE74Y=jn9cuT17nFw4wprEia7pVqoVkV2eQcgJw@mail.gmail.com>
In-Reply-To: <CADqcGBmFyNEhE74Y=jn9cuT17nFw4wprEia7pVqoVkV2eQcgJw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Jul 2026 20:39:48 +0200
X-Gm-Features: AUfX_myi2SVthox2AxxahnPjCxz_n1Bh2drgiwxh6tPPFJC-c4ze6AgyrOGfBfo
Message-ID: <CAAVpQUCsbweUHUuioh22KPbbZGeE8tDab6T_jPwrho-O1QM-GA@mail.gmail.com>
Subject: Re: [PATCH v1] af_unix: fix use-after-free in unix_stream_recv_urg()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:15=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> unix_stream_recv_urg() saves a bare pointer to the OOB skb and then
> drops sk_receive_queue.lock and unix_state_lock before accessing it
> at lines that call recv_actor() and update UNIXCB().consumed.
>
> After commit 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB
> skb.") removed the extra reference count, oob_skb is just a pointer
> into the receive queue with no additional refcount protection.
>
> A concurrent close() via unix_release_sock() does not acquire u->iolock
> and can race as follows:
>
>   1. recv_urg() saves oob_skb pointer under queue lock
>   2. recv_urg() drops queue lock and state lock
>   3. unix_release_sock() sets u->oob_skb =3D NULL (locklessly)
>   4. unix_release_sock() drains receive queue, kfree_skb() frees oob_skb
>   5. recv_urg() accesses freed oob_skb via recv_actor() -> UAF
>
> Additionally, unix_release_sock() cleared u->oob_skb with a plain store
> outside any lock, which is a data race against READ_ONCE(u->oob_skb) in
> manage_oob() and unix_stream_poll() which expect all writers to use
> WRITE_ONCE() under sk_receive_queue.lock.
>
> Fix the UAF by taking skb_get() on oob_skb while holding the queue lock
> in unix_stream_recv_urg(), ensuring the skb survives until consume_skb()
> drops the extra reference after use.
>
> Fix the data race by clearing u->oob_skb in unix_release_sock() under
> sk_receive_queue.lock using WRITE_ONCE(), consistent with all other
> writers.
>
> Fixes: 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB skb.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

The patch seems duplicated.

---
pw-bot: cr

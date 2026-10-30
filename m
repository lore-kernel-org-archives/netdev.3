Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793341057;
	b=fz+DowdL11Er0GE1QDXs4hzbBG/aO2eOVc82wh/Z+nuFPNEcnqWZtqqC+UubULXIGsfa
	 8JDDntVd5dIA4+PCCJZOiSWKGhmAJcZumZjMhfHWKyOq1eFTPYyVDuroRUzvsGCEfES5p
	 7293++W1L7ugHd/RaWAeuuNeSTtbaWqt+nZPewDdWQKC/5DPUAFFZCnHL8UahQCjU9PHu
	 OaXD+1/uAEAyPV78KyZgRzKZfcrB9VDDQwoFEB3JfG08D8OOBAz+lYlENX7vh5UGV4247
	 ezr9EzhE7eVoKdI6PsGHf2xh78yGvV8HOSB6WZ08KFuYLa62FGDTvK0Ik8E5dhhaWvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pZjUBS3kieBFv9QWkcVR3UoiF5JGMnsqA3e9Kn0z4Y0=;
	b=ncfdkePKNZXl/yFlBNQ2PpYj+WpGZKLoKEdoetrWvU7HYaTzN4g7yLiHKQJXHtrX1P7h
	 qW9nZbpeLELaVPcfRi2Iw1qnS8/1k04qoBuQro56L9MRwpR50HPnaVYhG4O8UIrLOdIFM
	 sSmS+oWL25APmetzSiaqmaCyCDaQq219+MqmDeG5OQYyV3S0aAi1x0tq3Tz9dps2tUA62
	 /IuwoD5NM7A1FXA7t3fnYZ2CEil45gzNIfHZZXTY5V+nowwbjtVTKnslW4ptNdYhgbRhP
	 YRWzwiNJ/1uLGtF5hhWuqnU8FIZahaFT9FK7+cuNRIwNJlOMfNJTQaepk8TPA+XKbJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TD46FCwJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536D606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E536D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TD46FCwJ
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso1226822e87.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793341055; cv=none;
        d=google.com; s=arc-20260327;
        b=QEwhUvfe7HtoCuU0EFrql1XS/i63EeAv4d/iSzDn9NkL8t0pIKOpwaqCAIVmhn6Lvy
         6Z02BPk3FcTrPMvuJmI2vM/Q3wJtK3gYlBZK/zxOpj3x09cFj3VptoqWTjhEtZFBGUd2
         qzCjZ9Jadw2aLlcBW3TsrmA58Y4iUrYXKahV0DQzJI851XljAsJXARH1QwOJ9ZAdevcJ
         pgQGheMJNxqlN0Hh3Ov9sS38vL6LwelmX7ujWHNSOXB8nXNNmKnNQhX1/YpH1MtkQL0M
         KGFXbAnfNNUVov/Lu5mytNWK8XN7LvqdQm2SDnCfh/tuF/vN8k0KAfr1VyT/JZLqLQzD
         +bcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pZjUBS3kieBFv9QWkcVR3UoiF5JGMnsqA3e9Kn0z4Y0=;
        fh=Ayf0OMmcbazVpNwH2oypl4sahE/tUoJd5vLCiPbeCR0=;
        b=oVlUyFEDzEYQzAjNouI8kD0aikzagPRXLQOlVQqHGGIMpwRqiUAV/52tEPLCe8BW/5
         EZwzRsd5xhz43EWDRymamK57M4zn63Dq4A/DaOQ5CfBTdBkAHbfJ50BpmDdqAyrxQmSL
         cJiDuWC7a0vjYq0yv+xYtDD2EKqU5UYSO8OMPxErHAKlAU4wDg5lRL1Khv5UslPESzh4
         B0csg1DExYgPd2qStv4fddeDq5uG02nQ+c0MuLRyHGR5oqZ85AiKg7qkZ9WMb//4Hhzk
         H2dv4WP8HC9Gsqe3BfWF1f3RQyGbrql89EXTqvFJe/WNY73xrBKITsKMpOPN624kOmGL
         ePKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793341055; x=1793945855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pZjUBS3kieBFv9QWkcVR3UoiF5JGMnsqA3e9Kn0z4Y0=;
        b=TD46FCwJ48PWQ++JTVjnTHURAxiVSCJVUehHuE5xZF26M7cKoXVZKRehFwYeITOdwz
         XW3ej+L9V4GZoykkibdU1/GXTkUX/HJ3T41e8rknb+HfFoTFrrFyPVWpMMx7xpl0zHkm
         bfiCInfyo8fKdXvKVetbn+SnYHHa+xLqivo4P90kOYmCWEqHQG6Ku4WDuCyUnQoyDiu4
         2Wm9Sj6u3m2gAnkNe7b4K9CVl6vnj4brEkrqg2Krrz9AuoaWsfQTRmM8e4S8XOtzNEvZ
         Z00krKv59jNC4kZIhX6kpdUIaIFsGcjMpkGjQZHmEnYsBbarWcqJkwSNY6wLPI+gf0E3
         DeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793341055; x=1793945855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZjUBS3kieBFv9QWkcVR3UoiF5JGMnsqA3e9Kn0z4Y0=;
        b=f03JAYmLUwCvNCS58Wrmoo92MdpFPvsn2Zr/cDc/MIt26swCzTqidwrXwvAunLwoHX
         3AdZlwoXZ8Uo/8/zUGxB1tjhMenqXPOeUY19Rp9fnDL7HFwAYS1i/Gsivz6WjvN0BPgn
         phm2w3MKr2cv6xswLU2F7hzdt07QEs9TjgEGsriv3yNZjxs9yxLrQ4XxkIU8PviYtXow
         YJdMI5QqUl0wr/nKV+r84ChxpON07lkp9n1VCjK8XLAQ1BDAkKUrpS/p6ECQLB5dcIaq
         YY8xzg0GgyXsThqISV/Wfwr9T26khynH43uBn+X028VM9V7RMUFxLLp1B4figUk6VkD4
         KXLw==
X-Forwarded-Encrypted: i=1; AKwUvBzh/UJc/5ffmXcthlXId+ujvPdDqmw2M7AB82rS8aTUMYyW8SdzttIDAwpap7KhqP1YSTnxaEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFkYBPtbV1NF+kXC0TGNmxWq6WV9Xeo3+ovugwTLizFST/07e6
	npY1CI/U4Q+mdZajWsxBVGi8Ry9MJe+Cm+GcDGDjNPAetAU2u1hGzyMo1UDO6jxTpGl4JL/Or8F
	CyLugfi3nRp+3B2wF1H1R4Mu5qAHLQrppou1Y
X-Gm-Gg: AYBFou0aEj7VLSF0Pv8TlVWzf3Zy5lE2TTYLyXvWLVv80Lv2IP0nq9W6npNwbX9kIbm
	0YvtjnN38oWFVpbgr56PaGAu9B4/UUh/NPrsMxpjrpEzhtJndB4gRiEy9JYuR9iqrErDXDxGQGy
	LVatep8K6o2jkxqTXPonEMkmz+LenAYFVgclvB7eq0dRn+Y0ZLZG+3/r+Vn1YSWYrCGoVONA6I4
	mtQKoKhaDQScoXcwAb1dy0n7mhlYoX+E7bmmvWnMzkavKY3za08R/f3pSFvYHvPVE1WhLPo7lkx
	1L8n4vrppZLC+sYwjq2pqYfolV62ecu3ajSnOa58cDtq24hCu+23IPSsvVGEw6CPKzKIq9VTr7P
	Jxa/B6Yn6vN1XXgFuV4t5N7h3goQQ9i35ZIsWjkoBOt9IOc+7HuiOoRrcGL2ahPvDTkDH4pu3+z
	sIc54bNGFI6i151L/9LTmexlI7hsW9/NP7zBJs0+YoJ3zHAZ2tfDY=
X-Received: by 2002:a05:6512:3d93:b0:5bf:ac46:c5d6 with SMTP id
 2adb3069b0e04-5bfd956d81cmr334864e87.12.1793341054873; Thu, 29 Oct 2026
 23:17:34 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029054200.97234-1-gyutae.opensource@navercorp.com> <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
In-Reply-To: <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 14:16:57 +0800
X-Gm-Features: AclHuK9fBg3EIjSbcv_z0WzBp7bKE-7jz6yFtnks3DmKKxBRExDPJTaJqejvlF0
Message-ID: <CAL+tcoAmq0WfSzo01xbAQ=g8OtE+GpJ5+RGs1G1SdNPdHx_eZg@mail.gmail.com>
Subject: Re: Backport request: Revert "softirq: Let ksoftirqd do its job" (d15121be7485)
To: Paolo Abeni <pabeni@redhat.com>
Cc: Gyutae Bae <gyutae.opensource@navercorp.com>, stable@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Minsu Jeon <minsu.jeon@navercorp.com>, Jonghyeon Kim <jong-hyeon.kim@navercorp.com>, 
	Siwan Kim <siwan.kim@navercorp.com>, Gyutae Bae <gyutae.bae@navercorp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Thu, Oct 29, 2026 at 4:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/29/26 06:42, Gyutae Bae wrote:
> > Please backport the following upstream commit to 6.1.y and 5.15.y:
> >
> >    d15121be7485655129101f3960ae6add40204463
> >    Revert "softirq: Let ksoftirqd do its job"
> >
> > On a production 5.15 PREEMPT_NONE node, long-running overlayfs
> > getdents64() calls prevented ksoftirqd from running.  RPS IPIs
> > continued to arrive, but NET_RX processing on that CPU stalled for
> > up to about 3 seconds.  Over 15 days, the node logged about 1,000
> > bonding ARP monitor failovers, with no link-state changes recorded
> > during that period.  The failovers stopped after the workload was
> > removed.
> >
> > On a 5.15.27 PREEMPT_NONE test node, we used a livepatch to make
> > ksoftirqd_running() always return false.  This removes the same
> > softirq deferral checks as the revert on this build.  Under the same
> > load, we measured three 10-minute windows: before patching, with the
> > livepatch active, and after removing it.  The number of HTTP requests
> > taking more than 200 ms was 17, 0 and 11, respectively.  TCPTimeouts
> > increased by 25, 1 and 21.
> >
> > We verified with patch --dry-run that the revert applies cleanly
> > to v6.1.190 and v5.15.223.  Both already contain the related RCU
> > fix 1dd1eff161bd.  6.6.y and later already contain the revert.
> >
> > The original commit was intended to prevent user-task starvation
> > under a softirq flood.  The revert's changelog points to threaded
> > NAPI as an alternative, but it is disabled by default.
> >
> > The revert was merged in v6.5 without a Cc: stable tag.
> > Syzbot has also reported bisections to this revert [1].
> > Paolo, Thomas, Eric: I would appreciate your thoughts on whether
> > this revert is suitable for 6.1.y and 5.15.y.
> >
> > [1] https://lore.kernel.org/all/000000000000a249880603717c15@google.com=
/
> IMHO such change should not land to stable lightly. It's a behavioural
> change with subtle side effects. The threaded napi feature is disabled

Technically speaking, yes, it's actually not a bug but an optimization.

> by default for the same reason. Also the revert has some soft functional
> dependencies in napi threaded cleanup and improvements landed into v6.4,
> i.e. 6bb218b5a6e3f3c5e2e76faf8fc976f3f6f72496, likely more.

Maybe I have a slightly different thought on this: since I really
received/noticed there are not a few reports showing the 'issue' in
the older kernels. It's not easy for some people or company to upgrade
the stable kernel. I'm wondering if it's still possible to land it
with more careful consideration in the patch if Gyutae volunteers to
do so? Please feel free to reject the proposal :)

Thanks,
Jason

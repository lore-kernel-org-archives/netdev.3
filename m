Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793228185;
	b=00Ngb9SoxhbpyYB4vS/UiflJyme5DEliCkVa7EDgDzomGjFw/h/BrX8cUVLkmDoF67ZO
	 smm/wa5v9pyTxV6IsJrxFPxoYoh76M+i/c9lxIWtQtW6utP5qTfVWjd7aVGgh1NoEb4ZT
	 734MVzC5dobygHULgAwAvChQQSkQ8UvuY7j2KAfRlp3dqWZ4n3Yx/oGhm/9SRFe6Ju7xw
	 YcP3WJcMnZLWyJLV7c+O59joi9OiYhGrEeJ8X3JgZJKcnQQwhNAS9G0Jp+9YXqiIbYoNR
	 yaMb+V0g5NnXlDHrZW61cFMG4iDgR/nV9I9Qva0wyuP57dvvyii82Df6W5eQaOXtLcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
	b=JvSCdcESv+EY7NuLddKdfIKe3FkqO9ZiS5yQk8lmaT13FU6bgMXA1QfKY3LkkYRSJjaz
	 oIteARbTtnAjhuMK5xvxCQL4TfvjRoAkYE3hCj2CovdbXvMkIS+twGCxKusSC08iJ7U4O
	 Uk5Agog7LGUlyNrsrlNTHsPUKfusvK93cFiS5x7ZoEZhrU2/gIDBAKr0LD7OjiyfML/Nr
	 kgY20ALDE1ubt+tOnncrfoG5tFcAkLqx0YAaXGllfv2rfjTa+SAjHaZvEPOyFGNDuuasF
	 ZlAW5BfSoi/nNTCA/xQWeFkyvEAuYU1hqcyTs6oMIcKFz0XtgiI8We+h87jyVxn2FBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bZOSlVJG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822C606A322
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0822C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bZOSlVJG
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so1634863e87.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793228183; cv=none;
        d=google.com; s=arc-20260327;
        b=q/ZJ9hRq8ySjGz4dgo1HRTvmh4KoEJ2WI7GE4pVVMsc1ulS2BB9tAK+bX8jfIBQDuW
         MTVsWkYfwXYp9bMZlaFtHi59O1WjFHCedgMGuD5QGxymkeq8q88Pl+h1mg/CJmm1GHmF
         lpYFG47wHCaaBmCCBrG1o/j/mpXxJcr2vOgcJXotKEechUDPkOnyk9LmW5dImZfFKNR/
         yePa7wmrp4NlQ/HrpjkHYGpqnf7bAMgH0os7OQ5ZAglaJ1IDSHaIpSfv4V+OF+vX4t/a
         74D8/y0OK3GDJYRaimazxmH01jTA/BueeyovQhkinuln6o+EOWV3Ry9HvD5zgHRRaiMI
         cGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
        fh=7OW6CBCC00Q/qGwNUnn8aJNM+za438VreD6uKSfDM4w=;
        b=IEsdM6h6mXc4NWyUh4mn88duW39fFPCxYoT0j6MIhZYdVc2XsyJMUiWuIpfRVhBZaF
         /eifM3iDN2xPt0gdfC4VLww/KmSuEXNlqlLGRcrHSY8k/WllCgoQmzGE74K+SeGhusz4
         BiypFyBDLgBfkKu8+S86TTMOb0jLNcaVh3r26FvEKlBJVdL3sVQwBNUcReb/2DYrr+1y
         QkakYagHDnrp3uBPdAERiZJRGkIAMQunzCGEJ3mZ+oQp7o8qTl4KQfF0AyYoZxRE1NHc
         y1lSTzTtoybNRddbJnr2CnPskfec/Qw/4M4h01TR2c8OYXecDH6ADzXIa5e6JlumW+JN
         CTbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793228183; x=1793832983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
        b=bZOSlVJGtHEYwYd8P/JXTJGc0heKbmZ4zF6gCQsfAWUdj+V8lveZo37a35kI44zsZG
         8r9p4GP3JXlJVRf/lRQCeD7DpNu+EpwjtNRy8B/mAQWg4VrhYeyQL+tDoFWr1hQ8Js/1
         WmBu61FcofxUa9iC2o9+OqMJhIY2ZxGCvswPzn8Prxv7xx3PhcvCqjngxpEz26C3Zh5+
         QCDR/cnpyszjYnYa+NJ3GR//R0d+Eo5+XTYFDLb2ivFHUdLHCDDXia/PshsMR6SOBMAE
         M4o+rVXHudqK4Y3GjiNjn4cOkyeetgJTVfYAYDZGmr6blu+DiQE+KChOyTySu65qfvrn
         wIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228183; x=1793832983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
        b=0kVL6sTFBYRXzp1nz3p/srObFxiu/RcAyDHs0h1fgJabbtH+/6o1eRN+op8T4mtoiN
         JTTXiZ0ogAFxw/+rjpOv25hw5uW+8QP8+G8Dtvpu120mEaNZTCxjo6kqQA60Pfhyjp6s
         IajD4jfRA/PT25/CR12SnU37qJ2kCgzuPzor1yb+hRIPQKkLI981rn6HBUfkVCkAz7zn
         2Bm0tD7ZdRodP+ejWTFsPLDkg4ha6TtyNNJkEIP8jO1/GXz4KJKyqWp5ZWgg/jIZMlt8
         j5sTIOKwltilKNAkuS6pqry3CBuaweW/1HD7LAZShmdJbElY+e816d4bcyoEEBX5x8UG
         60CA==
X-Forwarded-Encrypted: i=1; AKwUvBw9CCR1RvUNJLx6VObbbo8dVgxpjKWZ05/5pIWol/rns67+KbhN0+7Up+FaI1iaQFBb1ZIdOzU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHCSNhE2Emqq8h3IS/Pw72cFHNiQERNHAxcACavmEu39K7ynXF
	OHsZR7PPVEGQVYr07o7VEjnHOr/8SQZNehrRgkhB6RcY3PCySZ0GhXIeb2S3p+gDE6U6GxNvrI9
	PsIMEr8CIgXqEExhmQE2YN+mE36UsYyFweMskG5zF
X-Gm-Gg: AYBFou3PlxPsWZnD6OSl7kJUypuGH6RSnVzlfXefdeIw1CFi00AQazruNjhY4f+PAX/
	3LT0eKRd5mR6o+9EZSEQ0pZL/1iqnEMQIn1Zo3yhR0sT7D3WWfAGUDNhJgPnY2aMDzyfAI88IRL
	Vu+o6fk1vJIQ0cr5S//RL3vN1VNAYgpVwaHvrVLJZRhDQsTdmjF6YSI+Rm4lnV0DBWgQs6Z41Sp
	oUjiaosea5O9Jc1ukve8M25v3RPdGwY/S2yV6WvujTLa4yXrWzjlC4Vsj6su6oefxGLlH79byXw
	sqHEGwVopC7fikWdhr8J4g12szzu+C90XwkFMu2FRZcpcB3qr2ca99cSiV1I5RIwHYAPXKxiJ5J
	NkASEsFCCy34UbBLBZlHsVEyfsZNqrtIPSAR64g==
X-Received: by 2002:a05:6512:3e19:b0:5bf:c239:71ad with SMTP id
 2adb3069b0e04-5bfcad69127mr1282221e87.38.1793228183136; Wed, 28 Oct 2026
 15:56:23 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com>
In-Reply-To: <20261028221705.3915340-1-halg@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 28 Oct 2026 15:56:11 -0700
X-Gm-Features: AclHuK_P2NrO86m_OPGwNSCuxqmiVp7fbTt4tlVfFApQPbneLnvcqCjpUTpk6N8
Message-ID: <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 3:18=E2=80=AFPM Hallgrimur H. Gunnarsson
<halg@google.com> wrote:
>
> When an unprivileged process creates a new user namespace, it is granted
> a full set of capabilities (CAP_FULL_SET) scoped to that namespace.
> While these capabilities are isolated to the namespace, they allow
> unprivileged local users to reach deep kernel subsystems (most notably
> networking configuration and raw sockets via CAP_NET_ADMIN and
> CAP_NET_RAW) that historically assumed a trusted caller and have
> accounted for a large share of local privilege escalation
> vulnerabilities.
>
> Many workloads and sandboxes use unprivileged user namespaces strictly
> for basic UID/GID, mount, PID, or network isolation and never need
> high-risk capabilities like CAP_NET_ADMIN or CAP_NET_RAW. Likewise,
> system administrators often want a host-wide policy ceiling restricting
> which capabilities unprivileged user namespaces may acquire, without
> disabling unprivileged user namespaces altogether.
>
> Prior work by Jonathan Calmels [1] proposed addressing this via a sixth
> per-thread capability set (cap_userns) alongside a global sysctl mask.
> During that discussion [1, 2], feedback (e.g. from Casey Schaufler)
> suggested that rather than adding another per-thread capability set and
> prctl() interface, capability restrictions could be integrated directly
> into struct user_namespace and configured via clone3(). At the same
> time, as noted in [1], a clone3() flag alone is not sufficient for
> administrators who need to enforce a host-wide ceiling on unprivileged
> user namespaces without modifying every userspace callsite.
>
> This series combines both pieces of feedback: it embeds a capability
> bounding set (cap_bset) directly into struct user_namespace, reusing
> the existing task cap_bset, cap_permitted, and cap_effective sets on
> namespace entry, and provides both a system-wide sysctl ceiling for
> unprivileged user namespaces and a CLONE_NEWUSER_BSET flag for
> voluntary per-namespace restriction via clone3().

Why should the task's cap masks affect this?  *Maybe* cap_bset makes
sense, but I'm struggling a bit to see why cap_permitted and
cap_effective should matter.

Also, I think that Docker in non-userns mode restricts cap_bset, and
the purpose of that restriction is rather at odds with interpreting it
as a restriction on newly created user namespaces for purposes of
vulnerability mitigation.

>
> In addition, because restricting CAP_NET_ADMIN at user namespace
> creation time prevents userspace from bringing up the loopback
> interface in new network namespaces, the series first introduces
> an opt-in flag to automatically enable loopback on network namespace
> creation:
>
> 1. Opt-in loopback activation on netns creation (Patch 1)
>
>   New network namespaces start with the loopback interface (lo) DOWN by
>   default, requiring CAP_NET_ADMIN over the owning user namespace to
>   bring it up. To block external network access while preserving
>   localhost networking, sandboxes commonly create an isolated network
>   namespace with only the loopback interface enabled.
>

The whole unshare/clone flag situation is getting out of hand, IMO.
And this new thing makes logical sense but is really about reducing
exposure.

Perhaps we should instead have a small list associated with a userns
(extensible in the future) of things that the ns's admin (i.e. whoever
has CAP_SYS_ADMIN relative to the ns) may do.  That list could
include:

- Create loopback with sensible defaults for ipv4 and/or ipv6 (i see
no obvious reason to separate them)
- Create tun/tap interfaces in that ns (and attach them, etc)

And add a very simple new API to do these things.  Actually, the
tun/tap could just use the normal mechanism.

Thoughts?

--=20
Andy Lutomirski
AMA Capital Management, LLC

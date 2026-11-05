Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793897971;
	b=yQxcWzx4ovbS9MJUxG52l7+iY4y74WZ3+1VwPwtI6CFQlD8gC4f1Ap7pmG0YSlzKt7YR
	 hL50TyV7V6CAAOwLNoBLXU8JvSvOwbUPhaFJG3RZ7sFu0Tv8ZzWfA89R6kuXCsDGERkCX
	 7TB+6sZf9qNrMiqwmMhAWCPSnXCvwsem6gmuEAndr6CLVEAeQPZpMsyqkd/i9B24fww5N
	 ewB9VxvHoTEbCCPeR/pt/mZVBp2CXohIRY0Mez0QzmNg7qsAABneTnaQiDHAhW5mGkeiC
	 r9upQjJBZkJUo3Ui4e4Urwe0zuWFucnk0JkvQyA/0Enre0XRN9cQ9J7dGLJhkSHC0+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
	b=R49K90BJk0guFXdpK9opsq5V2b2I0gXtYEoMp6IYtG4Pj014jCApg/GpfLZUIWmX4O5r
	 3FstOOlKuPfzqUdaT7VuASc3f/uOEILlsfknktVlcnspKIMPdfiWXB0+aG9kruJgejX6u
	 zApnoUoeq+h+EB49xSWtlkE0rMM7C/5iFx2CiUdh5va57uoQl5aVO4ByHQsBuiPQpBZLU
	 94Z8gTFqnBZil24/jpVhYmSLwa2AFSU4eq46FKtE4+xH0EWsK1AKqRXHkd2/TUx0KQ+9k
	 gNs7g+A8y3KkOCTAqVzem4ujSs+h8XkGdFYgTd7u07ybzkMn9t9E6v6bWRrZmO0FwRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M4rBHBr6;
	arc=fail smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06C606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 16:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F06C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M4rBHBr6
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso2074849e87.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 08:59:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897969; cv=none;
        d=google.com; s=arc-20260327;
        b=sQSvJgslhIh0rjZPQf02GQmo6dOT3VpDWe5emyYGY/1AAwGYQf3nF3XGg5Z/KrPcnU
         g4ay9RJpltskXj6gaMDWFOPOMwDoDFnrn+RGky06xWQIpp23w+bMIXOJr9IzRFfmjBSY
         6Vsi/WzWuxAOt0mXpeJY00f4pawFfJDSIxWUKGCEIw7lXIKFWf6gWJXkni4wIaqhnEdQ
         42X2W+xlebqfW4HoGDuwa7NMhLlZnyFxQT5Ds4QwxZizzN68P0n9LBo76WX7wmSN+BBL
         HprAlH+Y5ZZ6pAHhbQVYUOaHh8XngAATriBRE+YX3kTJdIeNUw9+vij2ObnpYojyAzaG
         EFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
        fh=qPJ6JPq12dPphuM9ZziIGa4yc49u5ADOclOx1SYE3dU=;
        b=Rf5i/L8PduVIS+GzntKusOqrMhne5tg2yQ/1WXexpcLSF8ghPVnzVBvWbbdV8jEzKI
         U2AgbbIhs0TXEungXvqd743BeF7AFlwd9KuIpevDWnnJdsWZAZZWAD0bS20VgawHWomq
         vehZ+RRqFhgKP0CekiO3sqeMCbW2xCTFgHXpBVSFcNrylnraCe0FzpLJxORbohNBANbc
         75AzTPmC5KZ3RZnWVWDHsP2RwTTCrEgcadTTVzcdSZYE9LLwzy4mFO45EYtNMvjgUnMn
         4KNLiy9+3eQEOi57yfrpvdPvb+PyY620ZFAlv8lHQEGB+9DESHS6IGXkGCQSI8N5nrBe
         EZnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793897969; x=1794502769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
        b=M4rBHBr63W/SAVwNNbCQfErkFQNKWB1qkv3HtqteP54rOiV/HHnDMbtUKJCArIzFu4
         mYj0S1RcIb0q9pNYYwzfkrgcW/4hpcfT9cokBuN88bZN0gEMLrtAd9p4+/Q1wKWLERCs
         DrW00xbJ3OukwQpHPe/em0QG+3GlYH+g3IYsga7TvOEBXsyzoIivcIrFXjcPfBtQMsJx
         dhhKFMCZQePt2r/MCoc/hvcGaP1eaY7HE+KfNY0jNPytwrHw0Re5wyWLV4CIYYEeqBaz
         M8PdhqQP2K58xdjOL5tlAIrLEOG/UBLGLNET3to0NrS8A3suRDOPofJdLYHDtzflD6hB
         0Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897969; x=1794502769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
        b=Yyp48yFsjK9qr3HrB4L/0BhAkNjiPi83vD1HYsRthw/4ajn9CvBqNHQYGCl+EVW0ES
         rheel4ELe9BKzVuwOXUIEvez5JLXgwWH467IiE8yqfw3eL8gM5CbWSictclY2oEGQyb4
         LomldDs6uttxd87YmgbPFbDI9wDH+AnBJrp/+z7SZgf6HZ+oFXyzZP7RJS2avFQCYvw0
         UmVNAHVAETFglANAmkswafTmC7AU6vMWvbKq++LrF0QcajMmBW2jJX2PwSlifKMeVBOp
         Rssy8nruw6QO2oM9F5O0wZ3as94xd0N0czDX5ZfrO0cutFV5aFcHAUbE7rjdQw8vgty/
         kcTg==
X-Forwarded-Encrypted: i=1; AKwUvBzSdW/mft/n342EhlQAacZ8I7DMeXALhaad/0WiAIGOMJC6/CbZD0cmexwtBAYhWJgdUHtGBFs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ov9jKef9D6LPPFVN3kqLc6rjrIjF46X/kRqrcG0SDNVSJbNkn
	kzB2pxHo7T7f479lzLnSmzbMXvQqtao/iPMj/hZpmecJutP1DMEKoPAOhfnt6sfLc77UpkOI0V/
	MuhN480c9pwLEGK0qsignh+VVLrLMIJcZkHGu8bkQ
X-Gm-Gg: AYBFou2yM3bHViPll1JiB6ecYXh2Rg7seTz6elezm+8yVP25QSydUS1ktH3bmTUzaZD
	RDJ4vJTrFcqtnfk8oNugAhRVfhWUjfQ1P7BV9mJPLNs/68iMfzzVMOs2sUr/oMmEjKp2KVKeffQ
	Dy1pxDNDFfMI3xW0cd0RO3OMMgYqxUfdfOIE2QlIHyAu8FFGlpQJhzWCk0bASWcZm9tc3JqSfF7
	W+nGx+bbfwoOqtioeXdN9IK5/bkCrnDU0Or5EB1cnc77aQ5sKQLzUjsn8EHGfqZMKsV7OKY9LYn
	V9mOv4YCQLqQrWnRAwN72zEhpocW7Y4YxbfALWl9n058dAfxO4U+1KkWI7bMCa6dlyqoEBhp/qo
	7a0kyjJnvWoxevat3y025QktQVIRyTQNHkw==
X-Received: by 2002:a05:6512:3e1c:b0:5b8:f97f:7a22 with SMTP id
 2adb3069b0e04-5bfd957683fmr6945728e87.54.1793897969539; Thu, 05 Nov 2026
 08:59:29 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <aunVmg42/S2uUDWR@hallyn.com>
 <auyink594bxptAPN@google.com>
In-Reply-To: <auyink594bxptAPN@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 5 Nov 2026 08:59:17 -0800
X-Gm-Features: AclHuK99RUxjga4Yt7Cih1iKUoXn780fqABuH5tRHwVrGa5--KTUob_Z762ltig
Message-ID: <CALCETrWaFf-X-mD0moxqaqEDWOV+85geK2B2Rs3ArixKd=Ntfw@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
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

On Thu, Nov 5, 2026 at 7:48=E2=80=AFAM Hallgrimur H. Gunnarsson <halg@googl=
e.com> wrote:
>
> On Tue, Nov 03, 2026 at 06:37:46AM -0600, Serge E. Hallyn wrote:
> > Generally, if I, or some users I support, need to use unprivileged cont=
ainers
> > or user namespaces, then when an 0day comes along, I can hopefully trus=
t them
> > not to exploit it.  The biggest danger comes from the fact that, right =
now, if
> > they can use them, anyone can.  So if someone can trigger some other co=
de running
> > as user nginx or something, that can become a root vector.
> >
> > So what if we had a built-in feature or LSM which implemented a credent=
ial based
> > whitelist, entered at firstboot?  Something like
> >
> > ```
> > # Default deny
> > uid =3D=3D 1000  # approved
> > 1005 < uid < 1010  # approved
> > gid =3D=3D 1005
> > security_label =3D lxc_user_t  # Not sure how far we want to go with th=
is
> > tty # must have a session
> > ```
> >
> > Now, if you want to use user namespaces for generic sandboxes for all
> > users, e.g. to confine browser activity or nginx modules, then this mod=
el
> > may not fit.  Or rather, it might need a few tweaks.
>
> Thanks for taking a look and sharing the credential-based allowlist.
>
> The latter scenario (generic sandboxes for all users) is actually the
> primary use case that I'm targeting. I want to allow unprivileged users t=
o
> create user namespaces, e.g. for sandboxing, but without granting them
> security-sensitive network capabilities (CAP_NET_ADMIN/CAP_NET_RAW) when
> they are not strictly needed, given the historically high risk of local
> privilege escalation associated with them.
>
> The two approaches target complementary layers of the problem. A credenti=
al
> allowlist at creation time controls who can create a user namespace, whil=
e
> this patch series controls what capabilities are available inside that
> namespace (and its descendants) once it is created.
>
> Gating creation works well when there is a clear boundary between trusted
> and untrusted users. However, in a multi-tenant environment (like a large
> container fleet), we generally treat workloads as untrusted by default.
> Because we still want to allow these untrusted workloads to use unprivile=
ged
> user namespaces for sandboxing, it is essential to keep the attack surfac=
e
> small and follow the principle of least privilege whenever possible.
>
> More specifically, this patch series enables that model of safe sandboxin=
g
> across three key use cases:
>
> 1. Configurable capability stripping: Administrators can enable unprivile=
ged
>    user namespaces for all users to support sandboxing, but configure the
>    system to strip CAP_NET_ADMIN and CAP_NET_RAW by default in new user
>    namespaces created by unprivileged users. Basic sandboxing rarely need=
s
>    these (except to bring up loopback, which Patch 1 addresses via
>    CLONE_NEWNET_LOOPBACK).
>
>    The per-namespace bounding set can enforce this either globally via th=
e
>    sysctl, or explicitly via clone3() at the container manager level. Thi=
s
>    restriction is monotonic and persists down the namespace hierarchy.
>
> 2. Selectively granting CAP_NET_ADMIN: Some containerized workloads
>    legitimately need CAP_NET_ADMIN to configure advanced networking for
>    sub-containers. Because an unprivileged creator's child namespace is
>    bounded by:
>
>      parent_bset & (sysctl_ceiling | creator_effective)

Right after sending my last email, I had the following thought of a
variant of the model.  Permission to gain CAP_NET_ADMIN via creating a
userns is kind of like a capability itself, right?  We could get
pretty close to nice semantics if we allocated a capability bit for
this (CAP_USERNS_NET_ADMIN perhaps?) and, by default, giving it to all
users.  Unfortunately, the latter part is tricky because even sticking
it in the ambient set won't keep it from being dropped by setuid.

Perhaps we could have an extra capability mask that is for default-on
capabilities.

The intuition for this is that permission to gain capabilities in a
userns is a mess if it's a sysctl (as sysctls are global and there is
no clean way to say that a particular unprivileged task may
nonetheless create namespaces with CAP_NET_ADMIN) and it's a mess if
it's a securebit (still has the latter problem), but it's much tidier
if it's tied to a task.

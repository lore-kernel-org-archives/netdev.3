Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87613DD873
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365146; cv=none; b=s6G3I8ASWfuOCwe0xdiDF6OBfy120SwYhiYl6Eoi3XEFGv4sJHJ6hvgRFkGozrWAMEMDVCLeBMy1Oioc26ZI1/SWGmJZtH9iQMWyhxyGNtthxyrhnNIpJJOe/QW5hv6RkzmV3lMEW4lWWEoVs63k3emvmJZ1TD/NPY41Zor96sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365146; c=relaxed/simple;
	bh=FmRZBhpqLPyc1UGxxy4qJoUHxNedPgUqXqvk3ujJM1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7m5h5A9yJckOBvpceCPtiJoUOjZjaToHalznFWG+TgPsdv3/Ui3D15aBAXWg+O/UfbijZ5H+7CPVic+6LJVmcU2z9Lqw+JNsFTOZUhiPZ7IJtgn3Yg+po3l3tVjCK/ww4Y86AN/GYM+MThGm+vZP8AdECMMunKPurNE+jvnkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULInmk5k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULInmk5k"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2a4e013a44so176101666b.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792365143; x=1792969943; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppuPp4Of6QB0MqdJw5vbPQTFdSm51NtQw86VD0/q+5E=;
        b=ULInmk5krdrdVnz1hL9loM4bYhVW1ZU8F24+6ODujTZVcHPe4C4kTNd0LjiYGRrVz7
         b58lzsVriKgtk5oKzBAIUcpiMU2fG0/BPYK7CxTZdjATLSZhGV7V8dL8hmNXsSj0yf/2
         h0nG8H77/NQj5t+c7moqUZhqbW9RohqX9Guyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792365143; x=1792969943;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ppuPp4Of6QB0MqdJw5vbPQTFdSm51NtQw86VD0/q+5E=;
        b=m2kd2iZngNIvOefkZsm8IR6eC1hsNNSOy5v5TCr8lRuklDmgdmi39zV4Y0+p1JMNFA
         vIYtRTMpORl1ucygS5E6hSFT+w4WGY3CQKQ9DliLZbo78ZUu/axEHA5S7zpLee6NZVKx
         q5i5HyYic20rOvxHKdzCAA8UZN9ZawHZLWdkCIOQIPdE/dYIYRCaeUXMR94MSTbqlgYU
         OxdFIYY5dTFKl+/IMX8EKaxoLnB/3BGVS/Q4b3BMgs1REOt7Bgu1On39+CkshiBBDOcS
         TUVwtvq4Lteq+QOenV4oXZyk5VSXJDM1g56z8eSpEGkSrNSz3EYFsCxawGdApmqKc0kR
         bq0Q==
X-Forwarded-Encrypted: i=1; AKwUvBza+9Wu/3qIKwRB9dacHCOWVZHotGknuMMJ3GbTre+jm6K5E0XSu5fVYarEyo6C6D+gU7uU6rA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJW+tBQyOu8mGJDxOQC7szSTcc7mh+lmOEw62ZbZ4S15nS/2Myo
	M0kI3wR/E8uWnZlpy/yEfTYaVn6m5LE7O+16n67K2S6lu17rpOKVHcIUrewX5mdHEWPf6eh1ZQa
	imiuABwM=
X-Gm-Gg: AYBFou2rMpl5aHlod0KAAJxmqDe8GMTQLNMP9AuI8aLyxo07rtoy7vD6HOJWeKYD0sG
	xqKpuAQ0gmWNJgFgZ7N74Y/0swQiU8vJu7tyxezK0TWBjwtRypzH3gk84KXRJmMntqtU+qqKUor
	9xabda6I0iXuRqlXRJtyeSerWTYcVeNGQ9r/qXbNrDvxZZHQh8HsgaUzEvjQl18F/ckhxypszNh
	Hc+CwjpUSF0R0ceGhyixmI4Toyvnh+p+ND67odVRXuFgCLrcRJzASHmLfuZVyNiovL36ft8zxVo
	lqqLPEX26ioq5gpJFIR9ii1adDt73Wnm4FsNxhziUeVn67asx/pDie/FCn0syatGqe0lgU1orpq
	byznDvV+ypHi1Qwv4uYoIb689VoQdwWM3tnnFT8BKwQSqvWqg7zSLiaI7dO7heueLmOm2tBcQhW
	RZ3QmQ4JqI8bwr+OsH1YiPwz17GdBvyGnKL0OWeptwA/U/WWwnFSjTrJ30303f4OZrwHk5PlZTo
	h0eiiD3wsWOCpDLN7ihRsv7lqehqc8/UBccjQZ76B056iM=
X-Received: by 2002:a17:907:3f1f:b0:c29:6400:ef8e with SMTP id a640c23a62f3a-c41a0fc5732mr420299166b.42.1792365142770;
        Sun, 18 Oct 2026 16:12:22 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40914c3fd7sm298281466b.43.2026.10.18.16.12.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 16:12:22 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2a4e013a44so176100866b.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:12:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx2/gnYDAWU3yMbb6Y6ZMa4o+2UChgeqc6IWZpFYIGqZDLsLWjOIFhX74jDBaVYRN4n/bQD8gs=@vger.kernel.org
X-Received: by 2002:a17:907:9494:b0:c3f:7270:1093 with SMTP id
 a640c23a62f3a-c419f706c4cmr443663566b.26.1792365142168; Sun, 18 Oct 2026
 16:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <20261018204838.4080b238@pumpkin> <20261018175347-mutt-send-email-mst@kernel.org>
 <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>
In-Reply-To: <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 18 Oct 2026 13:12:05 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjZiwN8=PGEVm19QO2SiO29aA1E459+5mVQ0nmNoqOpjA@mail.gmail.com>
X-Gm-Features: AclHuK8ibgIQ7ZzCJT6T1XNCTCPJUVy2j1kAdMYMCDJTCT4gsOXcLC7aX43RNik
Message-ID: <CAHk-=wjZiwN8=PGEVm19QO2SiO29aA1E459+5mVQ0nmNoqOpjA@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Haoran Wang <haoranwangsec@gmail.com>, 
	jasowangio@gmail.com, KVM list <kvm@vger.kernel.org>, virtualization@lists.linux.dev, 
	Netdev <netdev@vger.kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Security Officers <security@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 12:06, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> That's a separate bug, and you really shouldn't use __get_user to work around it just because it doesn't check.
>
> You should use pagefault_disable() around the access. And if there is still a sleep_on() complaint, that should be fixed.

Ok, no longer driving around and checked: using pagefault_disable()
around the get_user() should indeed fix the warning, because
get_user() uses 'might_fault()', which doesn't complain if
pagefault_disabled() is set.

Admittedly the actual fault handler uses a different check: it uses
faulthandler_disabled(), which also checks for "in_atomic()", which is
why that __get_user() case just silently happened to work (badly).

But that check is historical - but actively wrong - the added
in_atomic() check in faulthandler_disabled() also checks for disabled
preemption, which is one of those "it's not reliable" things (because
the preemption count depends on whether preemption is enabled at
all!).

So no. There are exactly _zero_ valid reasons to use __get_user() and
friends. We really need to just get rid of that broken garbage. All it
does now is open up potential security holes and allow people to avoid
warnings for actively buggy code.

               Linus

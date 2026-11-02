Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642665;
	b=JeoSKdAV1RDj3EljKjpgGc3eRFkevgpYxu8VpcjOuXPY7RGO27ZI3GlzAlWezqgQAhjG
	 jcWEEPb+IoS2D45z4Kk2k1m/NmIraef3fAyicJiEK3gnr3PF59W9UyJJtvxFCW21AlcKy
	 lzOEVP44Ut0FVslqhYzeBVhF/B5j7gFOL06JcaDI5lpZYCO5rJr8KL0JR78jaNr8HbM89
	 zep1RrQuFS7f1bK7xIm8UlpWZOJm7Lp47SrGIef/+RAY5vzT03KLxCsuMJ1d79J5PAE0L
	 nJkMU1QoRKDxqEYjXiwkVTdqNmo6/LBjzEHmVQgNLDMnunelSJwWaQ82KEhEobBs1Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=kCpra/g7JJ6do61W2H072RM7qc7qretwrzEN93oU7bh8nD6K7qp6gxxTCue9Pc8VvTDW
	 rHxTBLt3uGQwZOVgKOujas8D85u0VLnMaZ4Ht+mEiUBlyQyh27Rq9YiBiKQhXo02C/euo
	 cRUOL50iHfDHj3vh3B/cKelTuP93KdSs2jog/U2yD5jp/wTVeO6jZ7saRnzpGpuQtXNf1
	 oRNNLOMv7Sa8VZot/ehG5eXys34tTpz5lKEhcsk9se0ayh0NgzagHlsjO6TadQYlkzez8
	 fYjnigzHcBP8Ka9R5+GdIhCNYfTbUSJRanLf7c7eIMYaHwHl4VfnjLM3MSwTjPniVFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=TMD+BLWo;
	arc=none smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6627606A333
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 18:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6627606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=TMD+BLWo
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4fea434bso3800679e87.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 10:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642663; x=1794247463; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=TMD+BLWoucOxHiYkyLFx+zsRE2v9uMEtvyaYIP6RACgIHRuYGM16enxZOMsfZqTU46
         ptJ3D76B1rPIxZXpg/lb/+n9pCwCyD+PXy+MUY7YR5g2giXPMUltIh4XKP8StUDi+iGJ
         YChX8bMr8MD85t+77erGe+1htd3linfVr4K2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642663; x=1794247463;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=aQjTruIhBe3eEf811JMt/3e6bMsw8we748yPIXu71VPqps4+YwVWx7sqrxL9bgPDYK
         Zg4o5MI11HwX25+q4Omp+VFPU9otWhfiwdD34CceAYkWhn9l2GP8g3vsW2y0HMZpTDJ1
         e49qBdT25WN6a1eT0t4vG/qESSBvT7W2OenKdhudk1PXqLvnsrxiny4g+/jxC3NhT+U1
         ZayoTqOd4ZA3my3MyGBJP+z2pQQ6L+WEE4rSUTfFLB98vzefLHWZtS5AEPZIW0ma9XpS
         XFzJmgf0RWEGNXIrFISLt2Xc5kRDkIbaGwyfnVoorNmqE6o8tVd8CkubWcd8UMpX90/2
         IzDA==
X-Forwarded-Encrypted: i=1; AKwUvBxPJjURt9EKgRkshFb2AL4osp+qhmR/p08fbgvLLu72neDDyuyMa6CWSi+h43HG6jAxScXJwjA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uc6jWdZOYmer/6yAX5jqr6krm8s//27oHCHD4EY8q5u0g65eW
	m7D6m4ialYaO6uUx7rqsLrGCK2SfTQNV2RPisav8JUiqlNcfZuCkKL+DGgsAj1ttDZ3gcg9fyb5
	hUYdU8wqgBA==
X-Gm-Gg: AYBFou302aUCX6I8xqL0X7AUXJgG5atvS5KwZ0tJJkLuanVXNZWiiE2TT+lUeZqpXOY
	6RdNTHZbXsiDX4i/TkxR9nNPI+2E7GzT1nnd488eZAGUkGXIybRy0KeN8Gq0BpSsbVq4/xd7VRN
	vMTTgd4WWoaE+ejuQU6kbU6lWwEBE54qoPzBiCX6SqGtoQ4u1RWnT3crlu1dNgoAfjzSYj9IXFp
	mLD8SK7pppKTg6FFyiUffoL6/5Eqzce/XA7VlXb/tSlBUI5lor7MNOZ6oL4UJV/0yPkhZam5BUw
	DXcoGCu1Y2sxtV/WiujYPdPJHGt5cVTserhFiU84h4UkCyVqu98RENUaYj1Y1ePf+CvHE3sYH6e
	rWtd3YsTQb3WcxwtW3o35v1iIiYq6iZwhga9B0Z/SA3RUP9hzQP4uENSPWbKSP+og+01gGNcohA
	Obxg8ueakn9AQfPp2RH3rap89vZ+Vna8ALfSLzn4IQOcUBX/2JK139v1hdkYJ3A9ghCRjTNpc9J
	U68msuKh93+pIQggvUqGKouuyGVtMCbgHksXH3TdgLKzsV1iBSgyGCNUcpbfCdFY691/ptsBIdR
	Q23ntmwJC757OsJ6wu8rjxE6eJ/1FOaCExWmYQs0Ao6+wF6EK8umB2nUzDduIVcJvXK5E5NtTnt
	+VHVmCg==
X-Received: by 2002:a05:6512:b91:b0:5bf:ae99:5251 with SMTP id 2adb3069b0e04-5bfd118c477mr4528967e87.5.1793642663040;
        Mon, 02 Nov 2026 10:04:23 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe0740516sm1792849e87.59.2026.11.02.10.04.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:04:22 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ac65e845a8so38008751fa.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 10:04:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxAEtkDIJ3F7rJcJk6uFNjTcB8QTzQ8MsuyAMxvSWKQHVR/HRY8bD9mxjfhHVzqkJyLUFtErNU=@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus

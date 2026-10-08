Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C53B0AF5
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 04:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434120; cv=pass; b=VncFccahyp7/5ti/FadWIIqP0tIcY9732aL0unQBMj/lAr7l6oFPYtOUupWB5ZTygL4tTgjF5oMZ+QyHLzLFzqQrHgFENpj//z3A4JqGduOUJXlMj7t9C8gShSAy2vrQV0JyF7xFCoKqsIgvulZndiMFcVQBEII49HwpzLU+qlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434120; c=relaxed/simple;
	bh=XoQi1i/y3vtnJIe6lxGxfp0W8iw9WFV9zz8v6wfy7fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSAPqNU/EmLucz/soDi/ZW/RRhMz54OqsyYVEoM0lK17SS0iHVG9w2KOBtBnr1Mvd3Wo4w2b9fI6P3NGbDxWuxNfFRw3KCZ090xocRsxnyoTJOlZKkrlJbH6p0FrLedXM9AMRaFaViW6neisVjrJvr/KyMy95Hnx6zEAcuhg/MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkYE6YqR; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkYE6YqR"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3516c82e96cso2007310eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 21:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791434118; cv=none;
        d=google.com; s=arc-20260327;
        b=gT6cfOIhWLOj5/8JGm69Kkrl++fPcrEv+aewIKDnswuLjE2Uky4GkdkjV2jJu6oGdC
         JDPty4oRvZOk8KAGu8hoHEM9a8G+0lkvmFMyoX5ieGU3lqLmMcZzFI6i5wBaP2MHvs00
         dbb5VqdOAVS5KjFqK1LAfnTF3YBmpVDWg8Ka7ZAQ2e1sUkUaEMsn7V71SFd+FGkky/5I
         bmLnB16QiQlFczEMD5bHE2yqR9b6kqcxYHt7IxOmVh0GjInWB/i1PSTDqihs+H3HV/VI
         cIaNcrlnV8srF0ab/1K5z85wx3MUX0gp6qQ2kaK0elLs31/4Yn4Nx7pZGRMPrzYcpNox
         pX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoQi1i/y3vtnJIe6lxGxfp0W8iw9WFV9zz8v6wfy7fQ=;
        fh=PsARwLu1REhh9cHFfszaw/GcdGKGSSdBhXv9WGDhXg0=;
        b=klmj6PXrjXcP771NUX8GBNoTC440qHdL/Wqnj5VrTH4VPsjiRt25/IOLq5YD3ypIKX
         yJMfyrtL/ycPyodILdCc1p0RdhJ9kXC2NnACfK7vGJ55lleQqBln975ShNTdMmfndHKR
         XWxUgUtMpcwu3v81gmjfnAtDxTFvggz4gEkcTcFndM8R6qpD9Ac7cM4ApmDTwGPGi3Ck
         GUzvfaSBh7oL12CAjhzGKFJLbT8K0wG8pngfzjkB4HR/4eGQVQIcVrCkfcZU1nhRFxOb
         l5QnaGG4jldx5j3rkG2BP9MXjICfLWLUQh/PLtOeVprSZHrNw3YZvDkNxZztqBDiWjjv
         LXwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791434118; x=1792038918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XoQi1i/y3vtnJIe6lxGxfp0W8iw9WFV9zz8v6wfy7fQ=;
        b=LkYE6YqRYssGblnpYrCEP9yKmKcb7pNVl8vUqB8SXhElFQpfDl7EMOJo0XuFV31rcS
         ReBwZ8+2rlwhcvx1Of4iXnbvqkDwRT0xszvMg/UjIynF+S0fXPTjhMp1hl8D4IGu7hXh
         gHx6Ki+5EKmJ4jiTNKyL39PFr1vNRo9bzUEE/LfpidYOVjCfv+l+VCO9rOIsxFRPzwaF
         oRSxqR4riHgylJ0VOxvbb4bZV9qkCZ3ofpyiEyJeX3OC4RT8USzZvksH015y71xpcddG
         62rWmoM6tUYguy/i3HPRG5lp6VbvtzpigvWiOcMV8AEqLPxd8k/utmXbSXJyPVsqPVfr
         4iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791434118; x=1792038918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoQi1i/y3vtnJIe6lxGxfp0W8iw9WFV9zz8v6wfy7fQ=;
        b=oURz+xkkF8hS2dibj3kvG6wP3lQufYJq9hhg3DQ6BmfNY3Zg4M1tLgO8pYBBy3kAvH
         J5vw0DLVaN/1am+uv/TRHv7pDQSDlzwCuBQ+Z6e3VFSdat+FShVgy/YrrSqy0QBXJB0T
         mvgWSJ/50/sESicvNeBpfHRGph4SXKSPtU/K9gSDY9kHo3BCbI89RRUdLr4wNwWVd2D3
         x1rwTRB9kaZrnFVlDjAGqeVSoCjGhaORHo11xDmaor6QdEjUEWJ2NoYJfGIFpUM9+ODo
         P55f+Umce865vYHjhQmJMvrpgCccn9yMefkrDFWglGz8NZ/LgL2i8Eegv+WS2Ask+xH9
         zAKA==
X-Forwarded-Encrypted: i=1; AKwUvBxQG5wHvGG8/QNRtIrZolvplMPiWqpmEOxJHJvqLiRMG5NjufVolnWLnObdrGW/LKv/cww+xqw=@vger.kernel.org
X-Gm-Message-State: AFuF++lz3HwAnwqpp4ueXf5DrCeY8wN6WFkgUMD2No8ex+yuOlzUmdZ5
	6gz2Y8sIyNNU+atj22I62CxKUOZuFA5yF/U7L4hGUc07t7MHomr2voqutTWqreBBFOYKEd1Nmz2
	pp8acGPmg5nJFVVWS76ipCIxUFsX0nBHehHByuBX+
X-Gm-Gg: AYBFou3VNCywS68jJenrO7ebkvFKVumMKKcnUxS7oLdWw2h9H58EBoaUjHlW5k6JTMx
	CJqJzcfArQWwrXf+bpRfOhKwzm59RoVSbicj1cX7LboUbz0b5bO5gD8K2ohwYLXlv8EFoVLfuh9
	9mHIEjBgKN0Sh+4IjJurvtQw0ooYn1FZjjPc4f2YXgo46Szzt5jhd3vHbGC4Lk9SFD+h10pUhxR
	GW7Km2XxaoDfAQpAXdyY9CcUIkGMP5+PLq+HM3I6738+Mj3rK5DTwgKXyQqSrX7QeZsRwyZUXqr
	0PLsgkhgVU4yREl0FRN/p4F5igH8zFmREeCQWzTN1kh+awi3hHbnPZIgMe2GNkldPD3/yAh5PUq
	mmYIvTP0bBCKsgFX+1eKVlv0GsRkbjWF44UDVXtHcKQpnAMVAFeXnV9Pz+ZFS2rZlDPZy20exDi
	l4+wP4wq0ovZf/DgYjVIAyu7C17ZZ7bt4jvHc=
X-Received: by 2002:a05:7022:f507:b0:143:5c63:23bb with SMTP id
 a92af1059eb24-16204a7e49amr4513231c88.11.1791434117336; Wed, 07 Oct 2026
 21:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com> <20261005-work-unix-passpidfd-v4-2-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-2-350183b6e02a@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 21:35:03 -0700
X-Gm-Features: AclHuK_YeTHnG90eRnjnXcfKby1j5D3PmWK-RpBbV20qfOkhK5av9kwUoFmdZto
Message-ID: <CAAVpQUAywU4_xzYUEHb6E3H+mARYE5kLAhQo=uBL76kG5DDraw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] af_unix: record the pid of the sending thread
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:09=E2=80=AFAM Andrew Halaney <andrew@amutable.com>=
 wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently only the struct pid of the thread-group leader is recorded.
> The identity of the actual thread that sent the message or is connected
> to a given socket cannot be retrieved.
>
> Add the plumbing to make it possible to retrieve a pidfd for the sender.
> Nothing uses the thread-specific struct pid yet. No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872874;
	b=Ffy9jDRZImbu/kTSHRZAa0BFccyByiUZr6xJG+UWui3J7Pzjz0AXAwk+MBn/bNOsf11S
	 q1IupCprk+2fph5L/WoNssNwB+MaovLDQ181IlmL9sRyCV1cVrEw/Ipz7moKU5QRJkZFP
	 7OqH5Dt3nNPB0+bZXXk2mOhmIV7QR3SIUfG2Anro58XEd5mqhXbektEjw3hYchGVa83mp
	 2PV2wfb6TgUSpFbTvsuBsKo1Jwd7YIA0kWjNn8kOPimqIaaTZ4YxDL94DQrIStxR5xZya
	 hWRZw9Ty4HTl2oaGSQptHWKBEqTq0RAmo3HoMpHuhQedo6AVnIlbBWNOGz8fnNHlI0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872874;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=SEH1dxr9jqdXS0wtYpH9v0AVidfxXkZUwHZA9HoE2dpWQzbKx6ad3K1FSLzvv00CnlJT
	 EFPo9FAa5F0ZHCvO0nQY62450Djv2wn5Ium3RCvbQBvoKUcPxqBfDLhku15grlYh72/xA
	 sQU5+cMtUTXAUE4jadN71hAllAAX6nKbLZ/JDtXR4imTedk4AaCzJgS4V/+BhIXihq7VD
	 pcphBFZD8EMDFyCrYUMsmMbgvTTktbESpxfE/FH5zcg8MJdDQ299Dm1F2ly11JVq6VyxW
	 6OcvB7W2nUlqyV9EfsxnXrnsbiT0S920q0P/cHM7uegcrEJhqTfen04LkUzjWDuWTPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD76606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD76606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93cc1ab5f6cso198331785a.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872873; x=1794477673;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=qUtNKVQS08GV7suKjZ7Woh76F781G9XANsqtY3MmUKjdu/LEHO8rd27GrPTgQjkohb
         AH3tFZsfi4wUqNwXH39h5VW2nkdfN2Mf/M7z7WGJPxvn/mxC9O/BlfNLtVJlZCvNQgu0
         xTqUbYrSxKf3oDIUtiYXiOoqgVYmG8Tt97K6ybmkmoO8M2oTFbepAQQ8D5x6PBEW1pEJ
         vDsTt0H/uyXrCxIWK6eDZ2C7NFRWB7KriCnah9xSg+Hk94Ayhx900vByYhan6HhH0IQL
         304EUOnIw4+VGsS7Bf/82DXsrJrrJwKMBS3eEvm0OfwROW4T6dhr46Fy9jeyqq3EnKJY
         LeVg==
X-Forwarded-Encrypted: i=1; AKwUvBxzI9Yh5APpYnZ27RHObzKZChnMCG4jRmTm+cethljdHJ9CQAxO4ScWtzaTNXuisgD3jmdWfss=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dTCx5K7IX+1eVCZDIi9oImM1/Nm3MjhXcPX8HFB6SVNCvoc1L
	14w0cdvbWsZVGAngG6NhlNgZG/QShsYQpiulR+4bMC6KZrKcoRQttQ2AMtoa+RCxoT0=
X-Gm-Gg: AYBFou1Okjq9VpKnDHPDy5635PWyiVXgISEzrHoi96t3X3hzW5DJpquW2198sQyg+ir
	vUsMmsiwpMaBlJCOpO3rQIQYLtf1XLyK/eTruAVSG7Cjww2yBoNqnVadyf5pAd+BtrQpIoz0ld2
	GqCzkJiJrLRBCVtmxGwW+Q61VwMQg+WcJ8V2pANzUh2GHbM24DgjOV7yyVaVXp3aNUJvdZv9u4F
	Zm+Xk7IibrfSEeO0nLHPHcZltnJJVlPRWcbGkbKNAYOUQbqYC1ku+NW0gUALtzEGc4LBCdeIQpm
	LUeIGQXOGFHEUuwypcJsiGJ71fLpr/p9W9rYftyojkXJmCnfsobDHkuudt4DOXyodRvofYL+vna
	qNw4THu+wsVCuzWsE6ZZtdD/+w5L8PminMtOtKLnXFgrTw+nKSxDP/Q8vEtRYvy6FDTbGKhREpt
	YewRIxfjyeAbYY+TYK2fviSKWU2IjZJwSvJr+w8VEMvQTwxfIyiZaHk+cXwoqbEstheqtWqgC5l
	jQThp+s682sj/iv/6pJAnlxnFL6T8DiGisFaakb+JhtbBBiiGEN+N0Qto41Vi3lsbPc2/hkWk6n
	HyPqbtXPJtB48rYJ/pJyYN9zu+fp8wbEeDkeRzTCFHVUPia+ca3TRExWlQVMtdc3wA==
X-Received: by 2002:a05:620a:17a3:b0:943:b01a:78f8 with SMTP id af79cd13be357-944214dc9bcmr3019783685a.5.1793872872926;
        Thu, 05 Nov 2026 02:01:12 -0800 (PST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488f183sm426525485a.39.2026.11.05.02.01.12
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:01:12 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c6ce60697so22213896d6.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:01:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxcfhXB2MbMSuOJ3YAfSswNzFnUpazOY9CjvKyg2C+2usbGOOwGiC6MK9HWONn3ktAkfc64y5Q=@vger.kernel.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872353;
	b=ghI1w3elaLWAsTM0R4Zugxe8iQVeL3LALBVOZHXNBOft/yP3EdOo6TQrQn3/dGut2/CN
	 LePqJMxNXTB9/5GHfBY0YSZ7Kwab1B/lJLrjmcXjV8+U1C/LuR79+7bghhw/wjozNvN/Z
	 QRd1zLma1iDo8H+pfoBn4a3xWEO7IeedaaBG8TjQufsEBXIZZR2CfJYAm+0chVAXGBWyU
	 K40R9Y96BVlprlwBcXyfwmEeNAPhAq06BwhfKbmbxfTRK9BM6LnoDNKGVXLIdTkkQL5pM
	 YAyx6s0HEq5XBajyC407jzo77rYI8gp7JoAh+P70YZNm1gH1C0qkPuhTTlsw74hvmUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872353;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=owBUqwwLMJzcp+I8ZIao7BVVgMlR4cbCeQUJJcT/sn+RFu5YFkEtWurxkuElwbesasQx
	 xPYqAlJO/K/yHcqUf5XwIi+WuY86x8w12DLdMfSa/hyD4a/772MKBqWkq0f2GmaJw1Vjr
	 3GyTJbu+SH68b7RM0DY7pyi4pD23mH/YRuCrh58VL4elEgPcs4pERRTHUQpwRElcTyZDf
	 Qc91tPsrPVGSublvqhFOzUQPjJfO3pp30gLZ3o79uErgaRr5b3/8ftOypvEXZoPEbU9ro
	 kB0l1jXsCQ9st7dTl4tHYcVfqDXBHEVftgvoHuB9rS/mBpjQeXL2azBrd4VfWA2aDMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3C606A33B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C3C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5365f9a04c5so23471171cf.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872352; x=1794477152;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=ihNGhXybHCOysPjz+kDYTPDD4hZdmzYP2QQz6vO+sWmfsR0ADovkITJ/+NhkbS/esp
         i8pSe3MIR7zRrcYG3+ApgdkE62zBoFMY6SMzoe3BdFWjC2rrPtI4qbDRL93XPPhkcsEf
         +p68mh91RZ8Jz8LWtXEc1RfIFoR06gtTsBb3BI6MIl2gnEr5RslKxJIYaNEaI3yZZLbf
         EJynAJoPj/igP16t5fkEzg0LEIE0ITBsXGBIW8ZYb71Kp26TpcqdCDqTelAa6ETYUDhF
         XoeJS87ai/wR9fPMoPFUlBnbYJKPKX2iwQV1wucoEP+XjWZFE8IwES650dhR6PFfml4N
         Agog==
X-Forwarded-Encrypted: i=1; AKwUvBypQqf3HRmFJkYXdtmn6EX+RoS9a2+kj9cM1b2V3ogytgLGiNE/i5+NNHE0ccMmD9qCKN6WVjM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1smI8a5JwnfYM0aYuNkjINHbo4MedJ74FRt9cgYS16oBEDQdl
	R7dd0rqIan8IC9AhZqtybhL5n761HAm2VUM/hYsiXR/y9qRQUJ4ph25IS4LWY9jnLWs=
X-Gm-Gg: AYBFou3V1wJH793uWBek48LW/DOAqAuCHfKM3xhStpN2Hmy5W1hOw2pqqVp2Lo+uUhK
	5T8bpyj6ERwXtIjUSC2bHA+9FRlgafQuEGsmAotd0Z3bA8q94NM7/hlJR5o+YWqp0Tqh/pxb88S
	HD2iJ/aRjNtiWj86rdEoPcmzEQ/w9AjkieeMao5jrONbzryZRNwrn00W9V4RKd5K7NErbb4HUHa
	uVuPi/3AMB1Jlzq77cmMQShEVSAtSowBEo1VKg2eVYjb06EsX5xNAQwnyoe1WEx9DozBBTvBfob
	RoLO1S23SbOKIpYaA9nmQgisDAzQv0ihDbHMUou8qCGnwN9CQg/Lj30B7WoOj6HnxqSLQE7Hlv/
	zqechGiCsDCJogx+eyFBIJ+iOP6HtDqpjKBmnKXSDpWLMSf0tDM/hcH2kQARu+O5LMh2P3FWXA4
	NcfXQixYLDcnQ8Lvp667ZBTJ6HQpJHlNf70rTUf8wIs+iGlUwWIk7qGdjw8PB5Jgi14c9PcRUps
	4ct8uxvEoFBU9N6yHjlCxjJijOZP6hrkwqddhCLX8wVXSQOLbK/2E9mzzlHk+ANLHuh0JS9bHAX
	N9XKWq+GrwprB/Nj+qfNyGtGAgwo4Exym4RfrlFkcC0E4S0VLV/8hH5P1wqa3Hld+RJYGw==
X-Received: by 2002:a05:622a:1f9b:b0:535:a5f8:a5c8 with SMTP id d75a77b69052e-542b83f24e7mr301657511cf.72.1793872352616;
        Thu, 05 Nov 2026 01:52:32 -0800 (PST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e017824sm43598386d6.29.2026.11.05.01.52.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:52:32 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53653e30353so21939511cf.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:52:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByZBGTYpF+P3X11Sc/zcBfKNLNgHBGhLRrEQUu8Toyria5ugOrBiK4zny8Ff/a+bBPUsnzWoOs=@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
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

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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

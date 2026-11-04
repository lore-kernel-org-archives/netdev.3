Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823129;
	b=j+wT17e+HmTrWZqTVc8Lngp6Gs0PJhgpMFDawsiaU1qgn92GvEbau7R+C/KcGBX7sKIb
	 CUiaFq6tQiGdDRSxazotcNI44l9DlnXnNlRZJmHKXFUXmHUbWSr5AQS3y975ug6KG9+rS
	 W01BGHt26QxG5PLdtld7unDtLIYrWMDzbREiYH95XnhpjcjP+V7aJwcYm7j+iY+ZAtpaP
	 n1w6jMabRUi726om7vW7E+Se0pvrS/oi6sfXPEG7sNEV2nKdwFADlPUv2E1sl40Ij5ntG
	 fJ28h+uHaSiGEjpP5EZW5Tbr3rhIzPxg0seHFq4n/OR9Ey22DyDk52ZsNxU5qiUU8aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=lsmsU7d3IxLaSIgcwlPmvcBce5vBEQMNMua+U0LlsKHDoO21eQL8bZxIazt/jN39AgCE
	 b/+Klqi4UBpBRiCRKWnql9X0RPN+CqW7TkLTl9RIoWABU2fpgQYXzpU/aq9aZtLchT60u
	 fVPw3NnBv4tEy18iyWYHcWh5nUP2GtpbecorgjHHS3EWkU9OkQ6Tk8KxkFg82URkxhCQU
	 e7UnDRsqcW84Ldon2PvxjLfqLzyr+NDNohQLdHi9Q61zC2h1YA8xtOK2AUGREel9Va/d6
	 Du+cHiWteTW/X7UUTiONtVPWhns2oevmC56JM6azL/M4NNzhzgTM1reWmpiuTcamONw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=NPUqUwWt;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D8607F2B1
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B69D8607F2B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=NPUqUwWt
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c423b145922so163096266b.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823127; x=1794427927; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=NPUqUwWtQ2Z72uHfCLGbi7GKVZo0QucCgpHKZaYN6bYH2QbbViU/Fzjgvc3V03/Mu2
         8bVBKIT1tugp1QEEGKKn4HUC+FzdNJfDTr6nw8rHoFa0VSK4yNGNq9Av4w/0nO0INCOv
         4L3VGRZ4AYO3ufB19rZoa9Tg1pqkcMJHd/IFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823127; x=1794427927;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=FXoB84oZxPiRzQ4lcfJeu4VkfnV8ckNl1lVnt+oYqVxOXfyHROa8Sa0LHNhhoeTuVm
         iom4C0FJPanQcW1R4JMKlxxn9gfMbWXK5upMh70YgcYAc7h9gUfs7Z59e1Bv+lwfTSPb
         rpVWgf7Jy9p5l1C0OwTIW6SCaWDIGK4zECdl3jLQXdZbN23Tsn/Q/1FdjghJp1sdOBBi
         4D2Sc+dDZyQTZ1ns9CD9OzBa47lofO0TNLmVKDBd7BmGPBPNCpSmil2r2WiV1covBtHe
         iZWu8cWK2YqH+XsL/tMbsBG5rGyPie5Wws10g90tSHqc/OT9xtAqNcpUWwhp9Vbw/9uJ
         mXhg==
X-Forwarded-Encrypted: i=1; AKwUvBwPBzlBjhyGNzUHl4mEDlQr2B0B9KgWuic//i1BxlkB/51iGCsVaicUkvnD8lpTH9ntjvxlO/8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kwQdrMlDGQ94Fb5pXH/d4Jtex5zwJw1mGUlbC+wNc8oggGtIU
	wrRjxf6ANXLbOPUxAmQ+0spt/yVB2Pf0Q/MUfd3y19T4rEcNC4YW/zYREPUrC1ZXXga/6aFE2+d
	NzGGuufQeyQ==
X-Gm-Gg: AYBFou3md529fnJOBjU/T/6S05nq0qdIlth2thbsOuwtbcMiblaFYR0Qt2xpBvnpZ7+
	UqkR6mKAff0Q5izUbaZejaq35BfPxRC3yW7kF81dBhI4IvvYiq1airYggFrG15y6BAWmPgZ40w8
	x7A49uIr1rGYmBxbeYL7fhZYiW2PrbgOJsOp/nifS7hYAJeabsGDzgieztjxaClEVc5xJuOiw4X
	2llzvPYnt7S6KHWSldcHvIiPjAP4nixZdc8xg4YGrdShkantrm9hPm8zPwWtMhIO41GPF1n4e5i
	ot20oIq22OmvTYYjwf2139gpsDrofyDOIFHnzEQpBmbIDv38AthByaQCGYOs172ya2P7L2Mq6t/
	dPYl8SK2BjSBuNznlmvBWq6RHYCQgrinwDh8QB1X1KOhqoq2yrnZJUgCW6xWw1Tkk6fvksB+oIk
	eytguuxh7m56k8CKJkykgsXtTLwVpshfCiwcbz1f1oeTXSfiQpliLZMrnfmkhHLiYOelikq8Gop
	rl9k58WPeWIRi0gJOwnmvy7NFLudOFIhDtVnaSYtA6JIMAHaiKjeuF2jSkR/wpqqpC/DWibFTyZ
	r8MNMMEQxa/JmaLWd+F1jRCZzPJL0nodGBlL/3eCWh3v3i+czB/ubzwQMV0wTMYRDnUXL64rPpD
	XH3deaZTy7UZ4BKwUOb40nHQ=
X-Received: by 2002:a17:907:7290:b0:c3f:7270:10ab with SMTP id a640c23a62f3a-c4ca7a54f7dmr1536409966b.14.1793823127149;
        Wed, 04 Nov 2026 12:12:07 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e48b3b7sm103551566b.66.2026.11.04.12.12.06
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:12:07 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4550d8ab15so176919666b.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:12:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxfrfggVAx+VVc4uAA6Ijf938GsWL9W5T61nN6LgKtvw4XrNgUll3VGbxFkGFj382sV8o/1COw=@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus

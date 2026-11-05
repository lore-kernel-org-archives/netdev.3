Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873269;
	b=uEWL9LK+3uW7L/l7S6Zb1i3Cgbvo2/qIwI7mI089iHlLqnUr8SQpA87gLOcIsSS1sMQC
	 4mNUexrvlPr3/gpQ0dpgt/MlcIPO4OUe/ipAaGxUdrxTbGjS+F6RncW37t9BCgSC0VU9u
	 1TJgGpvxKKfHNDhsMVF4bAr9eybh5M8s2VXz/S6Op0+uEWbCOebEE41bO40lPWkYNVUB1
	 j6jIHOZv3KAgMmWstSlMR0vkSRz75RALyoCNc8+kqeukOMD4Tk0VUuNHFM+7DikmHy9DK
	 RS/isgRe7syBgnsx7olw+1Eau9cB4Qb+8a009L6uTXaD77UCltOFQ/J2+lNyOhFOHvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873269;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
	b=FhPzxfg/dTL5dW7SnFBGrLSChJ6f4Lmjf9M4pH6uecM/lTX6fgdbnf+G2qdK3t1XqC7q
	 1oX2K2Nfz8h/FCLQcp+R88dSzvIwz8NU2VDhTGDz5ieFsYcb5kjCfdj2YJjdynCGH+j5J
	 joqCiCphDIoVY+QZoiU7yBoQgD7R5U5snsEUQQ1a1CbG4QiZzAdjg98ERa6G3iBegt9pn
	 GY8bQkBYQg3q2PELucOtwEz1YT94zoCBkEAAYQlzGmIfvAMH0ya7Vx9agEY6i12l+9+T3
	 wUj4Y9KiPbuEnHzJorFMaNjBpLzKW3CvWqucKwdkBXdrxEk+YFFmA2ks5Q74aEThbDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1658606D807
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1658606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso563661e0c.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873268; x=1794478068;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
        b=w13zuTuCAZWQk7WxbJZvSFbk+z7ZHHpumWDoWnKWtK1La2DIgrzOl92/X4/jPtSnIL
         qez5M26l1WIswPEA51jGLIjleO18Jdw9WYOL9acFgQNkTt7xr/VbCPbMKKibSM15mYnk
         RHpuaDyfUQtY22T6xSfd/Mh62dN606tD2nWqx4Jq0CQ1VET17h/8QjMD7vEtnme2ANSd
         VQyA/vNicVYyn9ZYH5jMPvObsgU5tJm7qG9BcZTrJ9vXlgynJz9tfrKUUwwRsp679+hf
         7Cxd7SOLBv7fUsOADij3NsK3FJKentMIh1QKmECswelxEfvnpRNi1RnYavwFgC2ngLZo
         AYvg==
X-Forwarded-Encrypted: i=1; AKwUvBzi75+Wvf7b0Z0ot2GGZ8rjMsBesxX4/WF+Lo08PaeXbSyKOX2+NiU4m2mx00+9gYUQBOn/naM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hRl//Q/uOSCRNVz0saJb4vog6RzD5ntnL7c/1wIaGECkL8yFo
	qSFQzioErYDiaJNhv+l1RaeZec9es2Q9xvH5gD2jos/3CTexkcfWM0l8FXNlip0p5DA=
X-Gm-Gg: AYBFou1PfrGQI+jqjAqz79OhA80iVnBZEQ/zNfHqseJAPMav+C/RGlO9GeLK1Z4l/RD
	d3qm1sVNJ9j4n3mSztPeeEqwu3HXGzSBPSwMPcXetbQ2OjtMeJhCFqnPNA3nTQEWp6YSHM7+VEK
	RIor+361nq5bRt+xoG/zcSO1wNlhT8ym1eWjzeHtaON30NfLQyjs9bUiMN4C8ZdrN0nrREpQQJo
	TJTH3q12eEh0j/WbVVQRCrtmMBtEGBLT6fTi1ppDsGtn67bDQS/fXOKwdm7Tth4JvO+79ouOshD
	zKgEBIb9OTcQScfkGUDUfX1DID6CoEjbbXq8qIdYkbse+vWdVPhcyYCUu3oaUXu/dYE7leSLk4e
	lNQG6aqVlRKx88pKbpquFV3VCjrusK1Wr1JPAY8l2JTt3xSvLp621YQeIZ8I5IHMZRKlzVo9X37
	TK0/GWiO/HnI6FBEKFn8J/zUJ4DR1/+9cRJd1xdkTLYmFCnBjram9XYuF5JQwtLghhsQF+LhSc0
	rzOHZpW/9UK7ZauenzHeg72z4PSTo1NicA1BZ0Sh+Gh09VpIbD9g+Eyk0vZKAWlnh2asMpjfzq/
	AOytn0jNYL9N1MLx/xnrW4ZppRgz0SCyOO2Tai3wNwmbPrkuBfqmYpO+qEmXRs+grc4=
X-Received: by 2002:a05:6122:1d8b:b0:5ea:bda1:76a0 with SMTP id 71dfb90a1353d-5ec68718048mr8625959e0c.7.1793873267580;
        Thu, 05 Nov 2026 02:07:47 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca889381asm3919176e0c.0.2026.11.05.02.07.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:07:45 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so591134137.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:07:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzHej9hXkLJzX+yNHqUEdCuJJB/jc0U8gLLTSKkn3NDzpMr80GxD0rCCsPzxHXevLgFyG9BNL8=@vger.kernel.org
X-Received: by 2002:a05:6102:374c:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d07227a940mr8060714137.5.1793873263361; Thu, 05 Nov 2026
 02:07:43 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:07:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
X-Gm-Features: AclHuK9naqg5CZQ7lhJVrMhg9TNH44f-SpA5WbUGCGBsAlcoOw2midTd7doJSmk
Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
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

Hi Christian,

On Wed, 4 Nov 2026 at 20:32, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_write() pins the entry and calls ->proc_write() which copies
> from userspace itself. A page fault in that copy can take as long as
> the writer wants, just like the copy to userspace of a read, and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for writes as well. An entry that implements
> ->proc_write_buf() gets a NUL-terminated kernel copy of what was
> written. procfs makes that copy before it pins the entry. The copy is
> capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
> proc_simple_write() if the entry doesn't care. Larger writes fail with
> -EINVAL. The proc_ops go away with the entry, so procfs remembers the
> limit in the entry when it is registered, like the size of the seq_file
> state, instead of pinning the entry just to look up a number.
>
> Entries that take binary data in pieces, like the PCI config space,
> ALSA's data entries or a firmware image, can ask for
> PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
> ->proc_write_size bytes and the write comes up short.
>
> ->proc_write_buf() gets the position like ->proc_write() so entries
> that write at an offset keep working.
>
> Note that procfs copies in the whole write before the entry looks at any
> of it. So a write that is too large or whose buffer can't be read fails
> before the entry's own checks run, permission checks included, even
> where the entry only ever looked at the first few bytes.
>
> An entry that implements ->proc_write_buf() and still has a
> ->proc_write() fails to register.
>
> No users yet.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -67,6 +74,16 @@ struct proc_ops {
>         const struct seq_operations *proc_seq_ops;
>         int     (*proc_show)(struct seq_file *, void *);
>         unsigned int proc_state_size;
> +       /*
> +        * procfs copies what is written into a kernel buffer and calls
> +        * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
> +        * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
> +        * writes fail with -EINVAL unless the entry asks for
> +        * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
> +        * for ->write().
> +        */
> +       ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);

"const char *"?

Seems like you have to drop several const attributes during the
conversion from "const char __user *buf" to "char *buf".

While at it, I think it would be good to use this conversion as an
opportunity to replace "char *" by "void *", which will probably let
you drop several casts from users.

> +       unsigned int proc_write_size;
>  } __randomize_layout;
>
>  /* definitions for hide_pid field */
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

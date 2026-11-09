Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260763;
	b=Ric3ep8mT6D8zvGMJRxkWtS139X7j4XA34EFHE5pQ1oIERl4+nkODoX5ZFMuWjoqQpnX
	 wP4+3oiihFZI5xwTXxLJnFVp6htDKk21MqhnamBmoR/PfYFPCxZX5RtOVprxoQ1O8DSs8
	 ILZooQu+05SiWlrLupZ+KxdRihvL1gYkR6oRhEp8+AUO1E6xeLT4AuQ7FmHJTf2yRzTf7
	 7enU4riXohr0CIIs+R3cqWQY8NRwWYva0ReqA1x6TFGz7XLY7cFEKt27fM1hAcmqODBfF
	 UbOAwJQzFQez+++Ahe+v9laNyX9/nBtNZ8FLPllSVBvTG/dt48VhqtfypGKYZNVPmBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
	b=zKaMwyO/KaY4otqASsehAS9DyAGLWSIIrsatfsFXNzxU4twp7UuJkTSFgye98dsjS9fT
	 qfVbw33r905XhIRmoa/A5rPOvB7sY5l9fhRq9DSlvJmkOIQvRLv9Vsmcnbwu2IPo32Zzh
	 6AeCPZzgoLK1QVkzJptACQkXtB7mUdS3jFpUO3LQa+sWo6Hhb52flbnzXLeq81adoF49J
	 FW/bCml3z44OkZCUctsSH4Gm7qyG+OaYlxk3/twzfUCLv4FvyKY/xGxp3CGNjkpo2CNOA
	 xIGcTh2Yb06I0r3q+eQUbnTrlJ9BshwIGsjOXTRRGV1TU5yyim5qYprDv9IGtodygnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687F60A2604
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C687F60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-490a0e72588so737601f8f.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794260761; x=1794865561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=LaZ0qPv5+whTFQHjIA7oYo021SUS2QeXnWN8ii9Y4im7Ue68o46nz2xh/hHMwIUfQ/
         ICad5fyoXePYl6/8nNVhZk6UxBKiDwJbHcHq6QklDSJskt7Ox2MaUqpcgklbAASOb1WD
         7U13gt1MK2zXHTSuMFiAfjmE40I4QhfpTIR2Mc6nMOBQW6Dg/mqe6U/h69Hyf/QnrKae
         CyKIviPRPYc2tnG0IM8qOylYYY2PKnrUJzf833wY0ZcFYDbyZdAS7ekVESO+FaUUNtdA
         WzN6sPDUCv7pE3hPSGmxzNcqgZM1jmpktE+mpPCXGo9ukB9qCsiBySNit7DIM51G+Ivt
         K68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260761; x=1794865561;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=hB/uupYoDbqld5ZE8dcV+8DRkKd6XmHLH+i3ipMBW3P2guNGz/7UKzlXx5uI5nKNVv
         NustqWMGjfvUIuqAM+W15bS7qcc1ZZRZeEpHhLA4qzpxLrngN34Zi0TrVUS5e5haWYCP
         jBuF4padWbmCW8/b8fekx9JghMN+wzAWgFiLQu3g+Mbh3PcCo8CtEBE8sNulQ8EoY6FK
         d8aCPoCpS/HpfJdTtnj/zW+g4n3AenyYPuvTNtqPplWblPa7/1htWOokBqEOqj15KA8k
         Dj/7n5FM+NP0ZqtzemH5tmGAREaLvQxA0Lir1f+cC/mWm6xPZ/2Ur3yMOK8+LpE9CXdg
         rrMA==
X-Forwarded-Encrypted: i=1; AL+hErEnSctq/BZFeIXi9DpxQ0ty+xCDxlQCq8+Q6x0w37d0yzI8+J7n0vEYsG0VuLThtdIqD1hRSqA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wAwW9G2Fycvu3YDZgzLpt0OAfSdOzLBTiByTI/UpZu8mdILC6
	yWOw0LnnImhBQfqhpe2VU3I2Twa2OoGAcq0js7NJ1Vcy5uAJo2Oz+AmD
X-Gm-Gg: AYBFou2YSbP/k7UT+kuJXyggr/8+N4aJyGS4AzCmGkGA3L+J7bb6ylg9JLFPWU+b7rd
	YILoryYjOl2y43hz17bF3DRMtVxaTzHYY6dsDc/4enBAQl3rjspzFwUbhlnQcjMTzj3C4gy7RNT
	Rm+KpKcyFyOSRDQhEsEFzo7mChBFXQGp7KgJQG3mWagkMw/0CQj1JAOUUyrabIMo38eNCygTjxs
	swTixnNEKncLA0uZxgZLr8deEp+bQ3H5idDiuA7Kq1U1+SmLPO94nWilrYwa8ErRdbQlSpudJSe
	GjSdX5riPOR9Ytfy7tEWqGimHUJQQrRZcrkX8+XZf2Wr+TeMhktmX15YYb5yEArUnCuU4MxVBs4
	+958lVfZpGqq3yqTKe6ynHa2ga6TQcXubinb/lQU69coDwE20BjiULFB2CfBOmB1HsuuZCUS2RD
	RHx/261mJKk/ThcBN+DEBeuy9OumrnCBXL1sClJKPBQmar1/n19FRuMbOAzI2pi29GTnlwslafS
	8N2F28otrcsOwY0vRiCluPaHibTu1z4srTRzJ6QY2ZiNpRgKEkjSY/CyAzveq96ZQwo7JIWkHd8
	gHfRkvTF6kPWn1QElSj0/pLm/G+PsIAQ+0lhcoiZiOQypa+GtftBySsknpujjQlnOQ==
X-Received: by 2002:a05:6000:288d:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-4982b28aa42mr1487213f8f.3.1794260760763;
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm1213644f8f.10.2026.11.09.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Date: Mon, 9 Nov 2026 21:45:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christian Brauner <brauner@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
	<20261108185953.28054fb3@pumpkin>
	<alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 05:05:57 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Sun, 8 Nov 2026, David Laight wrote:
> 
> > > > While at it, I think it would be good to use this conversion as an
> > > > opportunity to replace "char *" by "void *", which will probably let
> > > > you drop several casts from users.    
> > > 
> > > So I tried that too. The thing is it drops exactly one u8 * cast in
> > > ntfs3's label write.   
> > 
> > Since char is now unsigned that one isn't even needed...  
> 
>  Please excuse me missing the context, but what circumstances does your 
> claim refer to?

Just that the cast would have to be:
	u8 *foo = (u8 *)bar;
where 'bar' is 'char *', and I don't think you need a cast there when
char is unsigned.

David
 
> 
>   Maciej
> 


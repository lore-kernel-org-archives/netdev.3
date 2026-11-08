Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=u4/1ydH0yE1f/aRdVR4OuS2ZMIwLmCSKzmNHK8+YFGrB2xDUKpDkpprZ3o8Dj60ZDWev
	 YcVKs2A760aEOtgsJgD/CjAKeji+UAg5h1ds25bE0JHvCinKE8pSBTNzetDcYGQKZlsyT
	 NZhrwi4Ueqb56UlLCAzrOKuXODes+jMvDIJL/JP7NVWisIlp+FIRoMjQo6072OFNxNK5y
	 rgGN8lFvn7GvMCDTUhZ7xU1hYq0XQwhLrmwA4Ab/87TyMQNqa9wv7NhzMBW6sFieExmxq
	 s8uk7f4BXFrNLpfHwlApQ6JwWu6CqnRq1CMBi+PXHWOoRc9/nFCe7skBF/tuMZSSzXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=fA2xnd9IteP5hJ6tpWJD/dv8CbTANi+OC8zRUsgqQ1jcFwxIyG5fvFD+qKX9OLoJRgwk
	 KSopx7FzcH6/BaPOx4Je2DdRrRx6InFJyv91trVbR6VNMFtjkRj5Be18TxheL/HSX38d1
	 KHIxb065batBjE7B6pG1cWKj/PTehi2ggqhZwV6G+Jd03x7SeZZ0GYN3AWX7SuRKT7uS7
	 v8axc+gJ9Nk55ee07SW5wXs88+3vi0pkpzAoA/j3SIYFecsVMZtA3gxcLLBdgCR4XCKBi
	 qsfn5KlCWZb0JKuQOYfNCe2LnHDBteg/rDgKCuj6t66I0wc+4MA4Wr7Bk4d0bGGZcBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0C606A321
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28A0C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso1791495e9.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=0qIlVNO+YhCGA5WbBVGVYvZHIK4B3Nz9HJztckvBXTr8SThvvY99i9kq9lpaoLatmH
         UB8/NWv7jbM4U6rZfMTBiB+1g3Yf5CDXAjjYiMw8irp2XHfdKTzXtpi8MfDQyLTmhjpG
         R+US2Dp2GIK9gsH9tGbIND6BAa0ve4tgffEIf5A43Vymqe5GQt4rGuUCyw8FtwmYbFp7
         E2JZfP882WJdEZcfLE5ok1It9vcV27ZTqrfCdD76AC5GXS9RdBviG+bhGmgCDNvvgHIv
         Lqx/AJdCZ5YTPS94fj8wsdVzmNiEx7rV2Euec/7s+zR7ZN1ZK0qYXiazW2FnBE511fBX
         1khg==
X-Forwarded-Encrypted: i=1; AL+hErFj1jNFShRdGUqRVSochIE7MOEhwSC8nhup73A7mU+1qaij3LdWN0qdKzuLrezC7Htuwutf5Mk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+Sq8Wh01fRw2T27D9J+CVIB0yKJHWzOfJVHqO0ELzwUKAIoOm
	xPqC7rSGF3KdcTtN/2pEdz4Wzjtv2xdH9L3njqCBlAVT3wg99ec+0mRk
X-Gm-Gg: AYBFou2xLY4F+hbXRopiQ3L/hgW/KlASHUi6Ah7Fw71Cxh4d6gWoSM8G6+nJ2HhXU7c
	zCoVjoFlsXamV7OwM0heKYig9rDfGs8Hlv1p6ZHH7cK9UzV8URzFPnBkyS4TSpOBCVjt1DT14Q1
	VJsgc2aB/aiYKd6o2WiiEV2v4Kq79BzfZehGx/cXnzLwIOyC3v1bUn7nDz04d1Mnt9Je07kPemH
	JBqbpWuC9H+Bq5zSzeLK8CbQIgAgyph+o1Ikp0jikTOTVdkhdj7OSay96sji7UfJCr+KG5tEurS
	V9+V00161aIK6LnYqQC1WdF3nK3IRv4awX/J4iEd3HX52MdIKLSsFm/UQ2+eTyORHSSrvUmTB4Q
	MXIjLNAraOl+H52+USzrq5nrU1XOP77jepQtatauwuusHAU2FgHVjp6ebsdnbMXouP/gMQorSoE
	MdQnQp8dHDLKhE6ZeN8slyzhJ4MLxMEmg6Rp5UskZJ27rm1l0JQH0sYJ0uBKNVUwolj1RI2aUkx
	nP2wxZw8zzT4E8gb+BKohjTmFIS9DA4N0FUX4O+W7UfxhzcMTdyraETzGFZoCzmNlSJ/2p0CuHA
	MUvUadZLR5BiORZWB/IGK0klisx4lqzj6kTSuT2qN/dFEl5SAoqGMvwWsQvpE81F
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
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
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
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

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David

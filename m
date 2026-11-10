Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273662;
	b=hlHTgMbNWDSEEX305uCBSCnIXSpIeyTVCcPEOBty3Q/tOiFjkJYo519miULjJn4r/8A6
	 BumvM44V/Yn4cdqGzHL5tGArhPq3/wI00ch1fWZEdfWdCg2U8dLr4HDSNtyJNc1IYvMqH
	 ktBBzR9fRYU17Dih+y4Z0vGTchJDC7Z48M53FBhVOq8oY/dSduriBfDpeQyNVO4Ahb6wN
	 Qep61hOb6kciUElvo+GYDJ4hmh61Q8bLRlI4sZljAKVhvYfWqkSLdyIL3tpgqtCvUT65H
	 eD+15eetUNOaFFndJhJarivm5Ps6BQwn7EU/tJkGqxWEw6nttyK98SxurPSm/lEscqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=cpT5S05md2/afB3b4Ba2AaZiMtQo8ssOKoypRYJXUR8z6nB6klYaQtOclmrqCBzE3jEm
	 pWF6J9UbQ9SAiCM+3HEhDO8/LWmMAIVPB1KSkXOJU6qkADL8nAz9aBh5chmBin275MbV1
	 TNTZtnf7hzGUOIrnLlpi9QzlPbOo2NtBJMNC7KAa3swklRVtiYrJyoWycvF97727hbTP5
	 ASjKT5xkVhsJCwNiDorDWI+4WPugGFjguiCCBP+9HtR38A0aGwcUfGzcmyUma6e140/w4
	 1uPsjq2b1HKuDNQUaiGJUj5rcsXVwR8Ws4QcoYvXvkABhGPKO10ehgqAOy3pta7fG2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Yw236UNw;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57A60A2610
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA57A60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Yw236UNw
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c450ab1483cso245798066b.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 17:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273660; x=1794878460; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=Yw236UNwI06ULJrdQZifIsZwbPRTFB9NdzZIxVlEMfjG3N63DQ3wJf+lEtkhfF+d0Z
         22+mnpr0bKEU65hSInYwBDB1F8LXtw+c7GBjn0WjFxxbjIpIiS5h7r7rhpBSJ+rTqdyn
         FIsQYWOIUfx96H4ljTbLdyu6t6ClgzhBaWkZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273660; x=1794878460;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=SLa3yhHISdxLDL4kJzUQkpcBL6j1XosU2wWeTqdHaT7VYOZ3hm2Mw8yQn7Ob80jG9N
         sce0ld4xSmVTWhbjwyBOSh+lPVh5vljpkEhhlFf3bVuELkiYxtm8rJu91h+pU0GhWxui
         xhZ8DqHZuLkVAhXx55BBxMqz7k+Bhh8G9rY1VRwLEyxkeIztqcFUX7/bC0jUEnCclC3j
         u8BTaH9nlH1K0fMugCD6dTpgfoVq85B6p6eQxXRcffJetDWzlEz+NscPCzS9d9tINvIY
         nkhxuomhx5Z2izYk96HkfN4idA3K9RP7tqBru22VZbCFMeTa2WTjAXl9kz2OZKlBK++e
         K3sg==
X-Forwarded-Encrypted: i=1; AL+hErF7EGxsfPNNfygwqfuRuTxWvWZdkSMOj1z8Y3JBFMxxkZBjioBtnuTI5m3KEiCQSVJDN7n0Coc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8SZiWBj+wvbHX8nwY4XmfM/dMz98vcZSs15z12z4sCK1FnN0o
	DgzsHE6yJhc4beJyiNbEUbCojgUsZzftLkXgUvQPy8T9sdzjBBAiVO1hW65cbup6cCsRAb2BE8z
	J0EleWZtD4w==
X-Gm-Gg: AYBFou1TA7MDdsYsXi6wPwz0Qdgr4Cv2qIrKUKKLc8XuanCwZIQVo/kp390quyfnAoS
	NzToow1PLHvEaKbAj23yN4vdjbBetOfJKSBSSGOnAGtMMDMwIlbCUOOb6HOclJqueqM5jMnxS2t
	nGotJzLh0KcVW47qaKYumFDi+vm3icyfe/0Ta9r+2LFzvHfrSiiwGA/OBqFFH1qeMo72hLV8YNp
	RHmz5zZHo4WXGfMUfDHrghcdAj2PPWnqgV+CV/RCM2odbgSM1y7+fjgyoAP2hk5xbB4elt+acBh
	g9t/2KVxNlWRDxk7RG8kJ770AGf+kIF7Nnnuf3JpSaSy30+jkrrpoxEr1UJCAcugW+I0mL5nhjI
	eJnUk41jo2z32MQUmPrg3NQU/+0oqSsZimXUwsNAUPuuWDJkpG9IG0w6kC8TiGhMh5r4BAXEQDI
	AxEnHftcJO7FUp5wfbfZ05iBMAoHSttmgss1CVRHoTycy3gtpzmMoFI7Cn44BFqmjv6qf5NnESD
	mc0I74Abb8+pW/N5ibkB+HM4m3fxY9S8nV8fa7ccR3La0wOlUYd1bPUtB/kqb3rFEQc0AxAFrJe
	u9CQzTsXTT47UK0s3WWJyh2Qpld4sMKGFFK+P59eFGEzZQLRZeyJaMnlWdmcSxf52F4sfczCTSL
	o5A==
X-Received: by 2002:a17:907:8690:b0:c4d:31c5:cda with SMTP id a640c23a62f3a-c504963ee86mr78286266b.21.1794273660066;
        Mon, 09 Nov 2026 17:21:00 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a64998dsm40867166b.63.2026.11.09.17.20.59
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:20:59 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4cdc606b47so217215266b.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 17:20:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHGsmQlYj07nnVeashwMaQxX+M0CxVnxj6SEb7/atvyOu3WuX3q4looCWJujcAs/brOH8vvbH0=@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus

Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56C2376BEC
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675395; cv=none; b=bwOczUX8vun5oUHq1xXKtbaDPr3gBHNhEKEJvdjA8W9PbqimYxUbuNXz8+KHPW/VPEiDuCTZzMoXYg4lHKGXKirbrGFJe+n/ONU3feoK+wRdMhMBJpaRGexGvddDCaBpIatY32cY2kjax0dZ0P+39W/h7qiSXd9hjkcXnvfcrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675395; c=relaxed/simple;
	bh=3Jk2TzG5gR2RH4+LwM3XSlFeV25EIj3RoPOfWA1O8Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDnVW0BpEHFw/e2TH8/wdxtnKIuUlTT/DR7uEAjztJ0NbfwfigFN26hQXqt6iw5v4K8WWaFNQjxWvA0qQpWi+SjX8zFhtbf/hop7br7LFjREc/vJN+La9D/GYCJ0LgW801nfk6dXzAPvxyg08bq/AdksixhTXZqCoQhD4zQAVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Db4VlMey; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Db4VlMey"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bef47b1ac01so334831166b.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780675392; x=1781280192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y6UQFMgxs4xPTWbEaYQXP4WreuO3V04h3DiBWisQT8s=;
        b=Db4VlMey7aOrXifHlB0bd3gFxZGcgccsE1dp/1r0znjB2M9Vpl5GmXTvUkTZwtgNIj
         4+CPKJLrTN+zEGsJEgPDjX9lRyIEvq7sqyDk0dwfvxsi158HH4YthBarO40aW2/baXrA
         hPRjncUvFeV2ihESB6RGuWVDJghPSZj5G5DaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675392; x=1781280192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6UQFMgxs4xPTWbEaYQXP4WreuO3V04h3DiBWisQT8s=;
        b=qmhD7Uv4DNy4b7iPGz6epbSHngg0wIyAt6G3i5GYOT+WdmePTfnpwNpNbT6bmklnZv
         N7HSqDg0L/pAkzdL+Xtjzqh8sT6BcVkj6RGI2RRinGW91lG/ajjzQy+SBU2jqkqd9ZTp
         wl7XqYfAzimgjsv3VcP+7vh2nXde2Caml+3nWWFL9O0LOOZclj8KosegMPp2apcDWVas
         8CmW6KvQHGXvDI5OrVqchOXzIuWiSliHg2RS5qmFUYtmKrdVjzqlXX8cXuAgkQ/OMH35
         WqyM4LeQ9IrqcwlTkzn9pE7527wF2uBvoG9qwIeoe4YAH3NgbuWvrvaPU9qOuEVToJ74
         eS2w==
X-Forwarded-Encrypted: i=1; AFNElJ87PElJBDrqODq2mxXE/kBeaEMUNlAoaPOUdVuTjEUNz9OMlviGJT/jK/W4SK+hdSjW54XMKHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbjFj4NF0GBJAuLdnAJpKBpM13rIDIvx/qXANNZDqAml1Cjn6x
	r2of6ofDKvfQnxgw1+58MjEVenrGdsQJKsxYwYf9wxxs1HjRpnvStHwcIptnVxYSDBjlBi+MENE
	75GiUPPn3rw==
X-Gm-Gg: Acq92OETWkDmXTx/Pnz286zopfFFOu1Sk7po+B/SMJb9UksA7ym/nYB0Dd5HZwdvnvE
	vVIlxwIlQfRhjZxZTxJ+xc/jKC5sLxbbLemrwPmRoppkJsndAjYYxb26AmTE1Epn4Z6/HMr2wg5
	t5xShzcA3qTI+f6FdwUiDFkNblMm592EsdXHpllVI9snJ6AjDOj1KJDoq+SHE3/294UKQiSiPux
	l+GDd5MQYPKMZF4AzFI06j/NNUXz5fht3P4mX/dCBuxE6jujoW+Euz0HrRj2HUwK9lY95LnERqD
	sP3Xa02lDPVSz6Bxtd9rGdjLOepCNijVlLuuYLHlZK7kV0uajQXJNDb8bfjCsvBexQBkreLU0pL
	agDzV/8/PY2cSnbOTT5i0dTNJGHeQxK1hJpYblzUQC8g3YagZCI5ye+1yQ+zEF7Dc+JvSMjKJF2
	1PfHN6CFxUy4+ZaxS2gdjV7RruXMMZshmrEPSPZgfDF9V0HuM1oYEFk+uMPXZydGnnYBn4SxEy4
	cSDZCLqRno=
X-Received: by 2002:a17:906:846a:b0:bed:19af:f8a7 with SMTP id a640c23a62f3a-bf36fd9c54fmr145946766b.9.1780675391792;
        Fri, 05 Jun 2026 09:03:11 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf052097992sm502073366b.26.2026.06.05.09.03.10
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 09:03:11 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bdb3fd39045so267022466b.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 09:03:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9n9OmvNf35DdeN6uGvM4zDr3zBskulfW4Si8TIAeHR1IrPy9yCohr79LmX0Zrq0Ws4XS4jnWs=@vger.kernel.org
X-Received: by 2002:a17:907:9686:b0:bee:323d:1239 with SMTP id
 a640c23a62f3a-bf372e1e4fdmr260752266b.38.1780675389972; Fri, 05 Jun 2026
 09:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260531010107.1953702-3-safinaskar@gmail.com> <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
In-Reply-To: <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 09:02:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
X-Gm-Features: AVVi8CdZ5f-_r2ry70kDuq_xsye2rLgypwsymONxqFNfT92KlgrDUIUXs4-jBmo
Message-ID: <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Mark Brown <broonie@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Aiswharya.TCV@arm.com, ltp@lists.linux.it, 
	Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 04:02, Mark Brown <broonie@kernel.org> wrote:
>
> FWIW this is triggering a failure in the LTP vmsplice01 test case (which
> sends with a vmsplice() and then tries to read that with a splice()) in
> -next:
>
> | tst_tmpdir.c:316: TINFO: Using /tmp/LTP_vmsp3vEmQ as tmpdir (tmpfs filesystem)
> | L4471tst_test.c:2047: TINFO: LTP version: 20260130
> | L4472tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc6-next-20260604 #1 SMP @1780589917 armv7l
> | L4473tst_kconfig.c:71: TINFO: Couldn't locate kernel config!
> | L4474tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s

I htink this is the same thing that Christian already noted (he said
"reported by David", but I don't know which David ;), where the
vmsplice() writev() emulation was done as a blocking write, even
though vmsplice only blocked at the beginning (ie waiting only for
_initial_ space to write, not then blocking afterwards).

                 Linus

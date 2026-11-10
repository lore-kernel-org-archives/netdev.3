Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794331058;
	b=DCj5QFnSQ1qrvvOuLQy68zKJBJrQvycrptpKgCeHIUaPSqimALCsJMuFPSKxb/Hv5d/C
	 kSdoBuoPTyGjWIG9h5G9fvb+3GLbt6su3BfvdrP0Z1aU99PFKpXmkzYRoj1NOPvYW9oh/
	 iUOzTVGSEyl54gJ0kpMO88SNAn5zDgrCQBaqIs0r5f8Ze8KQnSKFrMQKTRhhkqOUKcPY8
	 qgxzRa/keVCDyCeSj5JIRY0FFQu+qwVA4i/kNbUNzOYwFN/NRw79I/MrVrJionws9ot06
	 8f8vQenOuFjZcXkyj58h0FDE6qwxd+7N+fCUKckFWX5HjMDII59aSUy+F1WzL5hYKXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=skPANznjPtDn5QOojVCJqck1MgtHRW3A9WW6+mK5vTY=;
	b=oiMSWTFDqfBgRj8YdMJS8JZSzNjBEKthTd7wTJIagJkxnZuukl2M0RzfC1yPoQjTkSwz
	 kZK7M8Zf9owau/t8FfjVkOX3lhd8fGi7FXpw5g0YDjHqwCt1kuw2swtuBNNK9PlXgjTE5
	 kMX6cAUocY5ep8JPM8UmPhJiXbLNdIYC9j4u0Ef1huHBurmJg2EGWPkd3nVcRiyLe0fQy
	 uwjJtAJD6t3eT90XYVdAaUvG244bKVYv0qtSCMvwgIlH5k/OGiFPKteChU/yze8gu5ZTD
	 v43axBFHxZq51xQZAJVgmxLVcA3eRIov1mCVYpBBApBNFDIYIe7yE3FOoUbFuFy0pCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7pNqlcK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58306606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58306606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7pNqlcK
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4f14642adb4so1270224b6e.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:17:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794331057; cv=none;
        d=google.com; s=arc-20260327;
        b=FYZcDZNBcNqBYeH0Yts8hCbATLdRDtGxd1AESM2zZjmucUpVMIgthmJ4dlP2Ij3UZQ
         cz5BzebElrpKSwisFL9RoyXnIHCg6aeCSjxC+5u5GMwzLMmNAKRmdpq6kWdYDtk18vfl
         mVZs53cztKv+fFb2BYRBtiu1mye8XicPvC8lKHd6mFTaQ6PYb+Xvoajytp1sbB94z4CD
         jd4lz2RFAzQdOe2coF1NY9jiyGNbXimPdR4l5YaOZdVO/igHgIpVJyX0rcnFBpzhByl6
         3fZ8jHo/lL+mJ7UFvsn+m+7AjOEGa3wTsXIXt9jNphE9IlMqzrKLnx8oAnNkN2zNbpcw
         r0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=skPANznjPtDn5QOojVCJqck1MgtHRW3A9WW6+mK5vTY=;
        fh=aEywA8PnyC6Pj6SoHd5LSdUtbdoLP8wv4rTD00nv8OA=;
        b=iEumh9SQAEH27l7BOxn6H+jpWWMCvZ08DUDJ49JwSjosEJbQOk+/ymHQmIKHEM+t5d
         W67YL/F+YqfkXHPLq1FKnyOjUbZyZ+nTi03rMnlZJmigrJt32DQvOf5Am2WDyyJ6Ngzr
         qE1cd/8P9XM7qTnLYJKNW5npdXyMMhEt9fzvn3T4xQY3Tq1qCSmeukh3TC/3m0bCWys4
         V52AJbl1kEYUd64Ujupk12jQHb0GY6zeHWA5NsPa61YQg4bbCB/eLZactMDjsxkcy8pV
         DFNYLCqihQd9l4ySBrtl2hye813MLnzHEZ++dG2kReQ7Lp0Gpv4DgbGjkm8VjFFk15Vw
         lCuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794331057; x=1794935857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=skPANznjPtDn5QOojVCJqck1MgtHRW3A9WW6+mK5vTY=;
        b=r7pNqlcKIdxME3fk1XxU8EbALJRZdEoV9A6oZvUCTg41kr1rjCF7OfgB2DiEsmw8cL
         FNsvYlAF+5fv/gZxh/pAUznVxLYZ6Kfw8hqhi8TWBekXu90e756jM5FRfR6WjHNLk3Gv
         X8AAPPCL/ZxyRnT0/8FNyf5MnpUHEB6j8ZQu9mXzWeFqKt0VyZh2+Hke1ukeMEGkHgSu
         SZU0G8htJbbiWBvJN0DqSsshzjsCv3yWhB14ula8RdcjAV8h1EMI1Jlo4QuuBUFTtD09
         n+P4HeYZDundwVJaW+JAIDuyyX+sYRJr3Oimw489irjV+pWohqs4ktH9+3Vk4B9UwvSv
         aQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331057; x=1794935857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skPANznjPtDn5QOojVCJqck1MgtHRW3A9WW6+mK5vTY=;
        b=dE3YhIDP1JTgRA48iGuSWJ+lqz2boluDw6shrw/0n+8NSUAKrzap7GehHVhVPyDk6h
         RYyI23J44G1T3p1Z23IJWCdzdn6zc5ch3VVYWd8aH/RKNTVPEbY8FnermEd9ZwF58Gg9
         AvXoJco2MfPms8bXvwPyK3Esk7N+6O1tiiDSe1kqd167NnI7r87NyXAzQyPrkKjgt7mR
         +M9xtXqNrY3d453vYbgu6gVXDUGhB+VSp0EpSgPB7MMw+6Ew9pKjYbtoKoCWT4/0L628
         WKHz0rdOZTtbQ74IufxZ3CjIypcpJNzwk12zyWmZUuTm0O9BJWbxtZemWzJqJdT8tWRV
         ITAQ==
X-Forwarded-Encrypted: i=1; AL+hErGII81/lk1ZVUEGgqDbuSbMXF5t7vu1ATONjV4m1WtwUy5eC9auFZkgbsuiY2YP/Y1hcvNYpFQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DDCesaIaXnUnsIEFs+bB+QRYpQfDgRfZpXqbGVq7mh0WgIegL
	VodyNd9KHIjOEZa1eKxseWv3WLHf/gF7XfjAQEFdzYSp1DW/p2v1SbZBmxwz6bz2iQXxAm3eRKi
	BpDpUNA602nazojhdqYvVQUMO6V1toWfkKOYJ/sU=
X-Gm-Gg: AYBFou22bycr64RNIYTcdmivr0tznpGPaR7wuxLdTnYmAZIBqfh9Cz0ZvNkc3vAtuAz
	+oCKGvbGOESK17kZelEWNjGgpu65He92FdhCfs3JmsANGQPY8vC3QiIRfDWQgEFsxOhFhHj/9yO
	ePUD0Bo3QYcLFL4vIthLbYHMrt3qmzaOxnr36+vSlpjC66hKViiq5Fz1zSnvo7GJ27VPjC3Nmji
	6gDW3IiegLqWRrrArpJyGe8uQhFnfNNk3WmSyCKQw6Olhgnfffi5jLuGxlKzQHcnivCRElKgX4l
	jvpdrRz7GnQu2TjMFTDEmdZlAOc9gqmwMyyi2sh3PX3SkAC0mdbArfn7pYE2Fa/erKR42wvHWs1
	FLJw+frE2dce5XcPP7ODVzfj1YNM+qlYh34oWyKyI5VVvrVdo2XiA65qwfE1hkqlVtdYwAtm0jV
	OuqMNwsR3JXMICtQ==
X-Received: by 2002:a05:6808:3308:b0:4d6:9133:23fb with SMTP id
 5614622812f47-5683ca7938cmr2559632b6e.49.1794331057255; Tue, 10 Nov 2026
 09:17:37 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107132040.1066996-2-mmyangfl@gmail.com> <179414774671.994134.1756882573318817305@kernel.org>
 <84b7c0d7-c167-43ab-9384-869c0bb40ea5@lunn.ch>
In-Reply-To: <84b7c0d7-c167-43ab-9384-869c0bb40ea5@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 11 Nov 2026 01:17:00 +0800
X-Gm-Features: AclHuK_bFk1zwMxZ9cWyZioiWUDcgfOkH6aV-uAJmktOrVSJXdkDEZNkQyyDFew
Message-ID: <CAAXyoMMHbXoBQexDyuVQ1rEzXvrX=fNPy_VfJbsmg9QrdjSMaw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net: dsa: motorcomm: Fix stats64 error
 counter mapping
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:21=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > [Severity: Medium]
> > With the tx_fifo_errors mapping removed, TX undersize events are no
> > longer counted in any rtnl_link_stats64 field, and that includes
> > tx_errors. Is this intended?
> >
> > The tx_errors kernel-doc in include/uapi/linux/if_link.h says:
> >
> >  * @tx_errors: Total number of transmit problems.
> >  *   This counter must include events counter by @tx_aborted_errors,
> >  *   @tx_carrier_errors, @tx_fifo_errors, @tx_heartbeat_errors,
> >  *   @tx_window_errors and other errors not otherwise counted.
> >
> > A runt frame may not be a FIFO underrun. Could tx_undersize_errors stil=
l
> > be added to tx_errors as an error not otherwise counted?
>
> It should not be possible to send runt frame, i expect either the
> hardware, or the driver to pad them to 64 bytes. So i don't think what
> the LLM is saying is valid.
>
> However, it would be good to get this counter reported somewhere.
>
>          Andrew

Probably, but it should be counted into tx_errors nevertheless IMO.
I've sent v2 covering this.

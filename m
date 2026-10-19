Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64554EFFB9
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412523; cv=none; b=Ib+k6dMHEzOPs4ixbc9VZqnblxf+8LyjYCzoi/6fEcWWhDonGBJRFkh6fEDQkrzI6/QE2Neyh080jXRJdpw60mtofADS8uSZoHAoYsfl4ewIrz795/fXqmA6h6/0LV3HYOq9QjtRLMsPjb6JaJLU7/jttly6u8H0UPhDTYa5kIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412523; c=relaxed/simple;
	bh=sIALCuzmK5MrLm1WN32r3MHvew38w9LvE/9jWk8EGbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQCapBEjTayHZr3HKM3CRC6bu6n0Tnr7lhCB6ra2AhfF1kI2KjQNy7cji6bLEOqNFUGTqsCVWqLuWEz3CF+w3y1qB+lMC8Ysm4M9bs/w2Wm6rH6zDV86b15MpKP8MZjKKXe1YQ28Bv6rC7vIaDxHrbvK0m+tZoqvw4Tl68qi3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmMZhS7h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hn2UTZuq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmMZhS7h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hn2UTZuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792412519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvmVJ/YjUjexXZFkRD2KfE4ivd3D2olHrXzSUsWnuRc=;
	b=JmMZhS7hZmJBYb1DykQwGhZV7Sf8AZg1sXTM5QOUcaXmdk/kIjX7KJ1GhZepPBNI0DJtlY
	qJOuRv31DdzRY4g66WRe6nO9nErWPWOzHOiM200rFCO4Jd7GCnyppbh5MJYWywdPx0wQL0
	wuZvIngm7JEWOqjWAvkXhZtIGcj1zPY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-4z1wRQeuNpurPbs81Cpfww-1; Mon, 19 Oct 2026 12:21:58 +0000
X-MC-Unique: 4z1wRQeuNpurPbs81Cpfww-1
X-Mimecast-MFC-AGG-ID: 4z1wRQeuNpurPbs81Cpfww_1792412517
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a027f2e364so15031635e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792412517; x=1793017317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HvmVJ/YjUjexXZFkRD2KfE4ivd3D2olHrXzSUsWnuRc=;
        b=Hn2UTZuqWEZkLdA2pIQ01wivh+pndnJt8zrb9dilGsk4xCcjNxYQJqeZN+3A0aYbKt
         2XYsGslsm6vlqPtHIXNN73mcHdqzHiH1hqfDSGzMIo/4LhGYUSI5FRU/Gkca053996cx
         JIDfTb2qm9IS4lrF33QdLjeNiY3tQvEg0E+URHicm2tGcStigJSwU5p0nnmfwjo6v1Vr
         50M3P06aECYEmcCNJGma7otg6u/lcvvdlMNpNU2lw32dYOL2LW2Zxip+FMzQ177S3HB7
         FV7jA0Tpu18aPcv811z/b1Pv8QS1GOu7CBJRTduID8xyEJ5jFrfdPWZGjV9oXutBbTYF
         PmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792412517; x=1793017317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvmVJ/YjUjexXZFkRD2KfE4ivd3D2olHrXzSUsWnuRc=;
        b=p8JRecMCO187LwKpJiDjH7bXnB8z0VcZBgro4+kVmwEXDqIdg9yteze34YIiSXTzXw
         OqzuyDPhr9mgfsAQAXJ7MdMPcf6gw7f9ZVQeGSt35rfOANtTqoaGFkyPd34HQis+tKii
         8R2QBBJ1O+IIoho/ENBNZLKuVa4JsQ64qr1cAIl4sJnUKB5Y9xDlPovGConViaY/Tu1u
         lJstuu6jmScjA4Rt2YwP3/Q+ndAVDSh3P0PvfCtWUbuEP9NkYCN2hGeV8iC7SzJxF+Ei
         NhF1htSWq+9r3+jUzZxgJwvXWEYAddQ0pZIBsnuqyqzctYgzrFp0R0Offf3HNrHX5TTM
         eUIw==
X-Forwarded-Encrypted: i=1; AKwUvBxTbXIMKDwhTAZhe8l9WOB3vFTzkMNkx4Q5NDFvyBlfK5PfegAp17d6auamZQyZKgxyOtTj5Nc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJAJV2LCjttZdgigLfZSq/3OWU6B5W4miv5VKAWnC2Fj//y3pI
	jULa8KKBE7x4I0zuo0SsHIICnN8L7c8yr55wCSKsuTsqDJA2J2TQy6MwTjv3SIJTOZI4TFzk5Kh
	p/Sx2shfuXGgH32gqG4AGYMbx+o8wj7tSfkpR12RPMSRL11R5ruEfshN/cg==
X-Gm-Gg: AYBFou2hn/oxnKzw3Q7VZ9cDxfwIUZJAM9M22R2aQK+YKB1p1ExABsg547JFdLi0WcT
	8yAT+hXN1Wsnjm9OeFdi93iYsJSQzLspIvx1NfHb7SzFTmqhgE1GWU6h5ncfg88NEmhJVaZiqFl
	NuhPxjLDjncAmKRgC9CeMSm0xnvmqz/aErYb0tLAEWGoKtMNxWZ1Pgd65NmrNdqj7Z6DyFQ3k+n
	L0md5yOiXWHazcxC9BDNoRGE1Ua9ISL6PEIwXInq/7jATM5UURLpwytUOIbKiikVnVafVt+rd+O
	SzeWwlrQQRoO1HLAzVrHPQVLGAMpeZuonJvmr0Oa55OjIBLnvZHg1U34CV9MTGlu9ZKv6A==
X-Received: by 2002:a05:600c:4e03:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-4a1d75ffbdamr177431595e9.19.1792412517101;
        Mon, 19 Oct 2026 05:21:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4e03:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-4a1d75ffbdamr177430755e9.19.1792412516569;
        Mon, 19 Oct 2026 05:21:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8a81587sm524058155e9.1.2026.10.19.05.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:21:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:21:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: netdev-bot+sinfo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v3 0/8] more virtio-net csum hardening
Message-ID: <20261019081218-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <179241175916.3290.3107334544259481724@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179241175916.3290.3107334544259481724@kernel.org>

On Mon, Oct 19, 2026 at 12:09:19PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

To answer the question, the virtio header is checked at input by
Eric's patch. I'm not aware of a way to bypass that, but given
the amount of pain and work this is causing, it seems prudent
to validate at several levels.

Patch 4 is a bugfix - i reproduced it easily but it is not normally
encountered in the field - the combination is non practical.

-- 
MST


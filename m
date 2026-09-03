Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4174C77B5
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447912; cv=pass; b=bqKCNgVOWleeCo31wC4FW/+bbAxBlbOnAGqLNOBmC3HDr7jjerAR39Oq8EUF2slBivzBErAq1aT8dL/lC3qH+2q6uXYM7o32AG3ivjHjdH55IiwanKOsaPhpbUTMoiqQePleujMQRk1GRBeGwirmA1iHBjgOSYPSpZH1Nx54pVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447912; c=relaxed/simple;
	bh=4q4IXvGFS1je+kmtMxtVxp6SUGEMuEGHLWMMjl8iKrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2cRuLvhtf24wqkkP/oZN6ZON4TiPT32qM94YjQYh8sEVEW2oPAB7jpwP36CsIxW/zpdfuix0pC9+v3wn4ctNP7gow0vjiBuuN39iSKzUE1VoM+wlv+oGaNdxRfriLAr1sIQpfKbBQuUAbTvOGf48a7k/uyW7dAwDf0a+b39VME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/Vhesde; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/Vhesde"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a6142b49aeso383113a12.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788447910; cv=none;
        d=google.com; s=arc-20260327;
        b=Ka0ir6V6ur//7/5OKSLebbGpG+Els5LJ6GhzxcOs7AML6nOZXIhOTQpsBrnSxZ6GIb
         +IH6d2JLCwjYhJqkBQTGSfx/t7/If2/TbviRWJdrQ2E/eFQ1jDkR4PoWo00klqvADo3S
         WQ4FtQWJIFx4/nLccFQEcqpmBIzMtGXMQr15QVejz7EDuTcHTq+aUcs9BrUMwfY0Z3XE
         XQjmsELOhDKB+vAGVRy8hDHH5IrXIm0uuldljt33O+cLSe4Ug/jAI79Nz6JxHBCt5yDe
         aGvv/K/YeFkZvx7TbVOmGECpG/RmRuGxT/xsX9Twr4Ol2QhsMa931fEFt12ZHybKs8pA
         51JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i5SLiJDT8dYeZ0O4WC0uETnJaFZZU8+dsHXxBxn1pFs=;
        fh=FxQqlmTVEKLjlM73dyZUmP4F97YyOcgGjdj5ZUj/+S4=;
        b=K5osFvKifjeQ5CBGWgw/yNrF6ZQSF3EcgCVPr0KpPDHBcRSpOGWVzbRllhUuRReQeK
         cdNmQJdSz0PkrW0n3fJrjWh3F1WHGUf71/4l0PETVZmWOzS3F2QppPJaVZRvar7MahbR
         VfFTUt0GiDJglE/oOIySZGBT0AB3KmR7H4i6KyCtNxv36PHDUH+v5fheAw9BiolaM50k
         redpdRVJtRPCNIkWflmK1IXZCdIZaqmYa6k/CpJCp2z6jMz71VZ1I64HZALJrjljO/ry
         CecPbMxrrYje7R8EK7og/sIxzA3Zf4y6rOZ1KWwAnAauoVeLGhxpwQQRyo1DetGpfJh3
         LHsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788447910; x=1789052710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i5SLiJDT8dYeZ0O4WC0uETnJaFZZU8+dsHXxBxn1pFs=;
        b=E/VhesdeSioi8675VwkSfw1TnHAos/DXfOUQs/20uPH0jCYyXSruAStZ6Y7CSf9Lzs
         wRxkj6z4wUmzN0YbA3TnXhIbwC5XXJI7+VeWIDzX6Egjm6ZBTnXCnrg1D48tbRawW5eE
         vH6DiFLJ2c8RWHyT9iDoMCeUHl7A9vv0sdTLVLPMqe02EPm1eAA5MsXj3souOPfOeRSl
         jTNlbCh4QOE3vw/J6v7NULsfkhu6cF8MyyGMNKEcea969v/vpS3pur9HB75Kzmp99A0V
         0Wk46dSzL9DkMnqxjKmv7cne6Wr/yJ5P2mJ/1EQD50PP3jRgP+2zDoMsh5afiqH3FN6b
         Laww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788447910; x=1789052710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5SLiJDT8dYeZ0O4WC0uETnJaFZZU8+dsHXxBxn1pFs=;
        b=dA8yRc0++U1csb5RcQiSkC7/HVWIIQZRe3xqhNQUPTVDNlPdPQw5OTy96hk5ulBhh2
         WiQJtVPIOMUmPWmUsGSabOXLZd2dluy9tQ5R/9k6Qv1xL4VLBpbfJjxWdEfmgpx/D50o
         O8oLGpTA4dw1UCLKLe2l7GQGK0TaTxMCve9Q2hmLu3obPWpdIs4M7B5ksqU+uimiLFwD
         CnZKpXNqF3sZOD/s+dlM3RZENwNHPIOnWB5snETWrxDmuHFVx/SfTDWALwmA8AXbw5dQ
         Oy/pUeFRZnOwSsD7fBB4PZIOQChOJFoYzb4sG9zGJnL+3Fz34M3SLcfHQHT9/E985/Cv
         8cyg==
X-Forwarded-Encrypted: i=1; AKwUvByEEIAz+ZZoHa7Y/C1MAc5bLRGAqgns/rJ4npPf9YlwIcXDm6+nNvSNbB8qxVHkSLXm1/B3ABg=@vger.kernel.org
X-Gm-Message-State: AFuF++kII7UfFbufgsxaVK2Sk+M+RowPhV3wAbK1khoXjRcfuAi70PCq
	XnVPqkOwxcks0lRNLqCiqT+lNAwSeBPiMtlZn16CW9ASmkobODHh4PBJMJrmfKa2ouXquSr6/cA
	apk9lbUbjHcvq2C3/gM/kEp4G7qBCgLfaTEUtw0cV8wMk
X-Gm-Gg: AYBFou3TOhLx0IJ3SS77fA/XjFpxyed3t1s0Tp2MsYVHXFzHi0UtsuLz1uUT8YcgxO5
	NoC7M4mBboXHEBKrZ6MYF7Joiicb3ew48Ut0Wi+Jm87Uy/5PsZP7egjdv2jy5tMSXoK7I7219TT
	IkFIjzmSyKsjSISQktrKbnAxsP7LMasV6mMqo7K8tz6Kxw3LP42qcaUjUQPqujXhqfz4q5iRg5G
	wpuDVE9r5HP/h/5LzrJ75tp9KwLiHp6ZTlU77GbcC27Hyv1Vuo+a2X3x5H1YMSUZkflKXBPgkMm
	HzXn+Jw9a0HUB7Oh2m9OfpBvaDT4ng+6W65znCHg8GaVKz56kzhqWBnUhLTkHz0tmpFnjYZz9T8
	=
X-Received: by 2002:a05:6402:210c:b0:6a3:eb13:e74c with SMTP id
 4fb4d7f45d1cf-6a682566928mr4744518a12.1.1788447909273; Thu, 03 Sep 2026
 08:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824150220.216067-1-nicoyip.dev@gmail.com> <20260903090735.GJ396647@horms.kernel.org>
In-Reply-To: <20260903090735.GJ396647@horms.kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 3 Sep 2026 23:04:57 +0800
X-Gm-Features: AcwNN1Wrp-obIQ2bxnzyzJpQtKbgTJ_hGKNFFoDg3LkB4NYMTxWvuZeQuT3hGx4
Message-ID: <CAAo+4rXkcmzOZL8nU4re6Pyp+FSXumjvVUM91vnrKDqMYt==2w@mail.gmail.com>
Subject: Re: [PATCH net] rxrpc: Take write lock when publishing the initial
 RxGK key
To: Simon Horman <horms@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:07=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Aug 24, 2026 at 11:02:20PM +0800, Chengfeng Ye wrote:
> > rxgk_rekey() updates the transport-key ring under security_use_lock,
> > and rxgk_get_key() takes a reference under the corresponding read
> > lock.  The initial publication in rxgk_init_connection_security()
> > writes conn->rxgk.enctype and conn->rxgk.keys[] without the write
> > lock.
> >
> > On a client connection, a second sendmsg can observe
> > RXRPC_CONN_CLIENT through a lockless load of conn->state, skip
> > rxrpc_init_client_conn_security(), and call rxgk_get_key() without
> > ever acquiring security_lock.  Because the initializer never took
> > the write lock, the reader's read lock provides neither exclusion
> > nor a matching acquire-release pair.
> >
> > Concurrent RxGK key consumers were observed in a two-sender
> > workload.  KCSAN reported:
> >
> >   BUG: KCSAN: data-race in rxgk_get_key / rxgk_secure_packet
> >
> >   write to 0xffff8aef4023c318 of 8 bytes by task 1968 on cpu 0:
> >    rxgk_secure_packet+0x46c/0x820
> >    rxrpc_send_data+0x562/0x1a20
> >    rxrpc_do_sendmsg+0x976/0xa80
> >    rxrpc_sendmsg+0x20f/0x2a0
> >
> >   read to 0xffff8aef4023c318 of 8 bytes by task 1969 on cpu 1:
> >    rxgk_get_key+0x209/0x5e0
> >    rxgk_alloc_txbuf+0xa4/0x2a0
> >    rxrpc_send_data+0x8e2/0x1a20
> >    rxrpc_do_sendmsg+0x976/0xa80
> >    rxrpc_sendmsg+0x20f/0x2a0
> >
> >   value changed: 0x7fffffffffffffff -> 0x7fffffffffffffee
> >
> > That report is on the key context's byte counter rather than the
> > initial publication, but it shows that lookup and secured transmit
> > already overlap on the same connection.
> >
> > Take security_use_lock for writing while publishing the initial
> > enctype and transport key, matching the locking used when rekeying.
> >
>
> I think a Fixes tag is needed here, citing the patch where
> this problem first manifested.
>
> You can simply post it in response to this email.
> But if you do re-post for some other reason note that
> there should not be a blank line between the Fixes and
> Signed-off-by tags (or between any other tags).
>
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
>
> ...

Thanks for the review.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security
class (GSSAPI)")

Best regards,
Chengfeng

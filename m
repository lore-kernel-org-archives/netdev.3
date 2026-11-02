Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793651482;
	b=Ti4AWRnx23EH22L/fvmmZfVYTg3MjCaH8SH/NmqEGIMbL+FVApwyt+iFaaNrkQxAbpvk
	 h3tMZWCPr/kPpZXifW88HSmuPFROmvUXxh0Muzg9wgtqh82Ng/lSZvMY8QOdvD/gpSMTQ
	 ku7QakbMyinIeZJO27WGw+tuGUa+Of0FppAHQquaCq56CtIEDTAiqewrQJkiwQ3Ec3ZfI
	 EcKw5PFy9y2I1hDY0SV4iTIWqp646JR8sfj/cJ6PBWFlDfK4yVfZuXpZ/U0RerfGyRtpH
	 R7t6duTQLJTladYeqA8LKXTRQAbEEjpVW10DnQJg0isGpqCRcHnUNJ++9nKu8E5jDsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5RwrqFV+JAK3ySp9u6e0Zx2PkbN0JduCY8deT2c09So=;
	b=DEynlF8fM8Xn3isxjAT7wtE3sziGYRJ+6EjDL8AZLIY/oDGZDQpg+qXKY31HBVERAkK+
	 yo0K6J+OheQ6YuCV/R8Krq+j/1pk26TsEB6MCtIJJbp+r+EqaDMbjXaL9eAsTs+lqEOJl
	 cGAFASjjrlhmIogO3u1aBwEj1/hXsyMzBlr+MW0gyb7IBZodxXigTX379LfyXA6+SoMoL
	 FhNTXH8DzXhw44YBos/ukCeCYv9wWNoU8+McAUx+AlFbKifa26K9h4aFosv4rVO5MChB3
	 OJOVGE7OTM4VIWyVmDdbBAwTXgzBGzMIxrcrno7n45EV5awpn605tVZ89/cvVKz/TjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RHJlzlK9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E2606A32E
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 20:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 759E2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RHJlzlK9
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2110a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 12:31:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793651481; cv=none;
        d=google.com; s=arc-20260327;
        b=LoRVB7RksTrFkecwpMNYEoTYJ4ohtyvBiHqQDYQAeXIbMR26yMAqsVMfmvhXkP9m90
         g4V8yhga7Zm5VWcTbFPOK+QOyKQc6uKcBJoKAFLfKozxKkSqiSylOsZ6NBRAcjJiscSG
         V2xDK0MA8Ktzi+NPtd8LsKeXx60uLPVPreYuRR+XnI549OdYnjK5LW5wICafGGOM2XAx
         IVHn7J4U+TxPflWyeY8eoBuKyzg+5OPPA1zAgLhVQGD+co/sPKmLOkaVFZxBHkpuyLdY
         FgXTrtLQru9ySeZlssOiqq6TSPhJS6rb5JZtBVpop18M/A0jacWouPQigwEGQHr9o394
         rOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5RwrqFV+JAK3ySp9u6e0Zx2PkbN0JduCY8deT2c09So=;
        fh=rHhMJW1n6ei3x1OHTNkC63ikr42QCKERzDHZXYfMy74=;
        b=XmB+Qe+nmVGb39H86oE4mqIRzKE2ZgwNGJXUzFpoNAcRJA5iNug85TTQtWUlCnBqG1
         oMrvbJHfPSx3BdjcxzeM16GXGsjE15Svq/IUPUsJ7z5JJPc4xrbwM2ASMacw8jQJE1Tb
         5GThC8335MvZW/5/qKbu02/oUcxuTlWmO9SdsIxDRe6vOea5phc9vdDJzeKprcIx3FYD
         v5VCWrVbDwRhwqBJ2icXj0PkgCdXW068DO0l7Fht7Bwvtue94vAxCl6ci7Rdx8yIl37a
         o0bQgkhdgCCZ3W+pzdShcDECPadgyAtjFv+n3I0Ud7mc2hVN+45ezqNJppfbKt7ePY0/
         zFsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793651481; x=1794256281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5RwrqFV+JAK3ySp9u6e0Zx2PkbN0JduCY8deT2c09So=;
        b=RHJlzlK97bzgvXNW3xL3lDaxN4w+2qFJE1LvMY2LQLzINz9zP/BXIKEYZFP8bTVh+A
         EuulrRQH2guD6Utn/XukATUgp1NTEYUsdzmamqkRjQqZiDi9K2SIsNujmk46Qm5y6JZf
         uIFSGrR990BOymBXHS1Tszzj4O86/1RwSR8bRNWPN2MZgA6SHuPNrcuPBptrZ5rhkepq
         lFcQtooLnqodgchqyzmjsOI+7faMvfesXvFaJ8Al5opVkj1T7uoos8Pe2du1wsPrZi1t
         w5DMRvVWUzkOF2Pn1RzYh0i2fUWXYvngpVGHQ4W8qiTOWH71A2iNPDwDZ+DiK4LqnDDM
         h3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793651481; x=1794256281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RwrqFV+JAK3ySp9u6e0Zx2PkbN0JduCY8deT2c09So=;
        b=b5xoi9Uz4K8UFE+54U4JlL4h8dNfxhvVByhae5vMmrondT77JE5iT3wS6GSC4skCOR
         EkjxC3fN4WjiwMYWdxhq9R5fx7xl+XSU99LTQwNwZhg0q2/SptHgaZ3hYo4wo3gsoRfB
         okeWBZ9aZTXKLE6GzOS0re/h4esS3E4R3TmJwNtB1Z+so6m1dJpQbkaCTJI1lG+6jZrM
         tMOQ/Oc2W5IFf4mwd2/z3v9FA4KN0vpIacMs0q5tEZ5iP4KPPzzJrIVmlpqjJts90McB
         MrVNX/uznj/yxX8poBhCdssnMc9PPlnJqyZxB6lIR8tI6BIGRCNCrJzsXruwbfiIXxB2
         yaTg==
X-Gm-Message-State: APuU4Z+uNbxQSY6qJJHdA1lk/GlK+iRRJkNOKJAR8Mx62m2jMWiUOBF9
	6cio1B2uFurf1Wdutd/UZ8aZeWy8OI6waEdU7C4z1ySi+oE6rSYCl8vCBsVe/QFS/ylxVqB6jAR
	/fzvdPjEXO7Enhf1/pI5VrCFdzascz6PUPy+tLnOG
X-Gm-Gg: AYBFou3WSc6iT1jI7sE1JN622FEM9dIR/jirNZTQcnBErnTSuVHISMz5Y8VAFgdo9Ot
	re74UBMMtpQLu/x2vnBLhqnROhO7IPTtEUwmqTnHx8rN5kVzZX3dE7XjAkCTA3EghU9Xyc2+m6M
	8ZqqY2HqYHezpkKOu9JkZpWLUAueaSHl7lci+I5kQkPAcN1uPpRTfszPK62FTp6/0doZIC5RuJg
	ZpqFC0a44wahc7kqgFNplqi4mc+0/XQuaFPRqf8V8pFrL0J9qZIbF+RErNLa4oCA/OIh4hK3eAq
	ULNEp6CHLi+ALS2KUOkT/zssNi4BULyPCQjAUzOYrw8GbE1h/tkS0vTfCcQ6MJUtgUkVVyyCP4b
	My0g/rD2RsMI9sYybFji1xFbjPyVsI8LaHPKoviZpX9WpSDD7eZ232yCKh+FRmAOvS1I=
X-Received: by 2002:a05:6402:20cc:10b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b4b42b3ef0mr308863a12.15.1793651480477; Mon, 02 Nov 2026
 12:31:20 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102191438.1059771-1-sdf@fomichev.me> <20261102191438.1059771-5-sdf@fomichev.me>
In-Reply-To: <20261102191438.1059771-5-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 12:31:08 -0800
X-Gm-Features: AclHuK9XRqRq9bYvRVLxJXUkdgt5z_NPqmaDip-9Zrh7UQsi494jQFBIdl60e9Q
Message-ID: <CAHS8izP6BmNJLUdKR0DpqieOVXreR7ycKWmVbtbBtP-kHy7HOg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] net: devmem: add a per-device netmem TX frag
 size limit
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	edumazet@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, daniel@iogearbox.net, razor@blackwall.org, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:14=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> Devmem TX frags are bounded only by the net_iov size, which is about
> to grow up to 2MB, more than some devices can describe in a single TX
> descriptor.
>
> Add netmem_tx_max_frag_size, U32_MAX by default, and cap devmem TX
> frags to the limit of the device the binding is attached to.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Abstractly LGTM but I'm not sure why this is TX-specific. Didn't we
add non-PAGE_SIZE rx net-iovs? This should have been a problem then.
Either you know what you're doing (maybe document in the commit
message) or we need some more alignment on RX and TX.

TBH I was dissapointed when LLMs started reporting that
binding->vdev/dev are treated very differently for RX and TX and I
have to write a cleanup that consolidates this:

https://github.com/mina/linux/compare/devmem-teardown-v4...devmem-lease-bin=
d-map-dev

I think maybe my reviews and yours maybe should be more mindful about
keeping these memory things consolidated and as much as possible not
RX/TX specific.

--=20
Thanks,
Mina

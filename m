Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2E22B594
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295901; cv=pass; b=W3xgcUqgC7yi3vaJhrJEJ0J7SopK6f0PiFvALs032jn8GXmo/Lydrv/5hT5sP6oZdgCz5nbR9ZlIyxzOX+kz11bNL8KS0hUY0hYgqXrm+pUkK8y3/S06Nyc1PIan7GJUriHbRb3TwakqTAmupR3Fir5lgg/tzjk+Vummgj7X+Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295901; c=relaxed/simple;
	bh=8INSsvIsr0EcFor0KjhMqLit17i8jgQhYiGlfRY+r1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D37plH9KVihgm0YnWJjktZStI+8ieXaoyCj7PhG4/krk0fpC5j7K8ALuFfKqVB2E5RX2g6ZUROqrINaRtJ8HkFmdA9G8jb/L9yqvTMeiOtVRbQMzJogY4GmCPz3MfzhPpmDiLVXs8FcQ7iRFwZ7JkHlgdWIwdpq+4JXE9//bAFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZkFzDLJ; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZkFzDLJ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66807ba2f0fso544709d50.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 20:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785295898; cv=none;
        d=google.com; s=arc-20260327;
        b=ev9kJ41JDDG+YvOXjvdrKdp10jTmEi+2jWrCza3K9TUF6LATONov8eDEf19W9VN3qc
         xNM5EuDqOoeCJfR+nnXYHTcTp89RASaX5PXrGUCEyOeVKIVcYeofaPL7dE0zEfbh+1Fp
         Qm1XSvHqtAIow95MResGZRo6doJmFCCdbFdNvRy8XM0xf9cl7NlG0Kyr1k18vx3aywXH
         fN00WZV85YUlSEaa9Pnh5TIsJ/+pq1fxSZLfUx9TRARUZmQJsoDyOIcsPsvTUZb3Z4Xe
         QfHjumbyY7ekIp1lyxatowIWEERhFwAeWqG6nEqg4gc+VgMoXoDM82KEe96UGclQRJkc
         tajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pe0CzKtFSobq234+zo2ouN0uSG2sSCPEWeoFaE53a50=;
        fh=oXfyWvA7cr2GK4senP4JwY8dZOlmtzN+MrACkMYEyBc=;
        b=GsrGuNGS3S5GLlZU5AY4RhEM0Ob67h38ne7p8RPhCCsBvB+DFTQn1F8csjuNNwz+9l
         2AAWFt7TvS9GpodnKq/xvcv2T58T2DNCue8cVjk8eENXHUnTu3ddHMCAjVgd1wcnYALe
         DV5dicylr9eul+ziNq9dXdqCNwVvNvpHKaSGCBHvWDgkFeDFAXY+2nyxs6vYxnKyqKl0
         pgsVPkLWHnb9WmwJTWi06FaYmzxWLnpzViA5aZ1ZFBNjXKrymqKwHEBPIYXKECX85o7M
         2lEh/Q1nhNrOZ0GngRcClgj/7qpISfgr2GZP6VqGiVeJIYa4a0SqKc8tHvH9Yy+yYNcT
         r8kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785295898; x=1785900698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pe0CzKtFSobq234+zo2ouN0uSG2sSCPEWeoFaE53a50=;
        b=LZkFzDLJYcHyEVQjUK2tiKOjy7g93DUrCPtLUfOlKgu79bnoTMVwilsZVc8hrngfNM
         ADOlYWZA3nrXD1n+8NY/xS0vkN0Qp63wg23bsn0nvHU0qtDh5avpk6hxEjlc5s3FDXMz
         oKBYX/GiJW104aKxw32AK6W6TJco/J+A4eBos1lRYZhbJJqP22ZgscRYXYz62TSrzucY
         ckTDgmyNQ0OFbuYwbGUSsxBxfy3t8vyWZdvECPQ+ET322LT2n7E+kvdIJ5X6+lwAdhRw
         33VItxbVf1TDbxYqV2P6aplA6tZKMCL0umNJjy9Wi25WpbMsaGxr1xYh+N3cvSfnmpdW
         vBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785295898; x=1785900698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pe0CzKtFSobq234+zo2ouN0uSG2sSCPEWeoFaE53a50=;
        b=NqvSo/jaxSByT605LHY/QmiCSZnvnAiZ6YGAVoYkKX4lqjcLNneugUlxiEcAqhfUSG
         krIjPFEcEOVfBJczk3hMHN5LdZmjKf3i9U/Dwwr+TQ/+JtnFTyg0qOn05btCMC+om6+o
         kjL9ii8UoS7gKNV1HaR9b77+nTmRlxAHq+m7V0OuSSPpzYFJoQGeklhmdpBLtOkTawlC
         3NIfQRDikoGOu4xsrCkC18F1hJJB8GQaGDsGIG5153eCVaO1JtZdSD+ap8xatpqi4Udc
         SwkKKSAk0iCnwA4LANidg8i7Owidt9iSMnpRPK8eTgzCrlJ1oUSId/B/xKKsjFdXIJOE
         awaw==
X-Gm-Message-State: AOJu0YyD+Rqj6pGF7Ur9HGcmgcV1Pvt40ZrC+LPKoVzOSydq/yNnDNh8
	T3JmMk/EtQjPxCL6qJ9iVKy1KLzc3tX1GS3GhmBU/65nFfXG3HB2vgYQHFkDUCtW9VebS+L5sGv
	iQ88BB0hKbbEybYkuOAavW1wYDNa4amHeccZtz9VzjA==
X-Gm-Gg: AR+sD1107pH+NKOhw0PY91NJh6tKJh5QVBqSoGKixNTiVgTegHgDDs1M0/WWvQaq/dP
	NqsaeA5+a65IkDw3cH3XQVoSMz/itHr/+Ba+n/Mj3nw8pYWbw/Q5FX0Yy5WfS1BrhI0ic2jd8WP
	8IzKBOjfCGpJA89Ce9saMsmldnmahbf5a9GG4uqAWbMd3KLMtcJ0kU5ZGLo0X2SpY9SZMMYy7EH
	j25xgCioBC+EQ6qNfYjQgbEz+tLG4qDo8nzGQkAQ75xlOWjiIFyR+d0QGoTYd1KUL0t3HBevh+C
	i1ZgrqmQ7t2yOncV/80/sVzYuWpk9vBIux06gVzDkszn4IdtW8ApNCDZ5GfvgOWJy01XmNz+i9u
	hvopPUZOEbvu4g+V3vQI=
X-Received: by 2002:a05:690e:4295:20b0:667:b57b:8697 with SMTP id
 956f58d0204a3-669057f5bc3mr1697637d50.61.1785295898162; Tue, 28 Jul 2026
 20:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-3-sun.jian.kdev@gmail.com> <amcIoG59kgi4CJbo@lore-desk>
In-Reply-To: <amcIoG59kgi4CJbo@lore-desk>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 29 Jul 2026 11:31:28 +0800
X-Gm-Features: AUfX_mzCCj-Rhe2GnR_T5jwxAsRWw1WjvNw_V50aUcanGkk---NpUHWw-SrR344
Message-ID: <CABFUUZG+g_g_7N9D477vJW2c141-WhWL2JG8oc-y3OoF9QePdA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] veth: fix skb length accounting after XDP frag adjustment
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	maciej.fijalkowski@intel.com, matt@readmodwrite.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:28=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> On Jul 26, Sun Jian wrote:
> > veth exposes non-linear skb fragments through an xdp_buff. If an XDP
> > program adjusts the fragment area, veth_xdp_rcv_skb() copies
> > xdp_frags_size back to skb->data_len but leaves skb->len containing the
> > old fragment contribution.
> >
> > After a fragment shrink, this makes skb_headlen() larger than the actua=
l
> > linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> > copied 1024 bytes past the actual linear tail to userspace, starting at
> > struct skb_shared_info. The copied bytes included the affected skb's
> > nr_frags, xdp_frags_size and a kernel pointer from
> > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> > amount and truncated at the end.
> >
> > Subtract the old data_len before replacing it and add the new data_len
> > afterwards, keeping skb->len and skb->data_len synchronized.
> >
> > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened b=
y
> > 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> > corrupted payloads. After the fix, all 10 runs matched the expected
> > payload exactly.
> >
> > Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept =
non-linear skb")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel=
.org
> > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  drivers/net/veth.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 00e34afd858e..a956498a073b 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -871,12 +871,14 @@ static struct sk_buff *veth_xdp_rcv_skb(struct ve=
th_rq *rq,
> >               __skb_put(skb, off); /* positive on grow, negative on shr=
ink */
> >
> >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +      * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
> >        */
> > +     skb->len -=3D skb->data_len;
> >       if (xdp_buff_has_frags(xdp))
> >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> >       else
> >               skb->data_len =3D 0;
> > +     skb->len +=3D skb->data_len;
>
> nit: same here, you can this one just in the if () branch.
>
> Regards,
> Lorenzo
>
> >
> >       skb->protocol =3D eth_type_trans(skb, rq->dev);
> >
> > --
> > 2.43.0
> >
Hi Lorenzo,

Thanks. I will address this in v2.

Thanks,
Sun Jian

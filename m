Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792778611;
	b=K48ov92mJYoc077dJbY+AipbP05h+Uza5bmufDZ7rBPFMIPfNAxcHWVJgltdQvcm/xXJ
	 JvMeQjPsV3Lsn00AjIuE1pf0cExCRAJ537oSt4pZteOCigAeraUdqW27r5Z7J8qtpN38M
	 NM7JDsfoU0POav+kbXf3fkwGN0WhUUikoMdaY5ma3iTujDXZEmvLDXHVqBzutUMJLKhRg
	 ViGn0qVKyC+nyhvZ0uWR7G0sNh3pmM3tqIPtQsR1TCgu2GKNCosUJOFqPKBtdkfj6MC7g
	 6x3m7UCQiaXK5nh6yZ0plOuCUgAxtxaBDS9SSMoaPkfKhfE0DkteXxVLeMRitu7/nGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QtYaJnNe8xkPBPNyUxj5jlp0lFkEB43F9v5MzV6TxeY=;
	b=UZPV1idpeOXKlGjK9qPziizYLhu9o1+G0sQshlWEonYvgfyHT1jGTCT/onQ2ucm7HLzm
	 mStkyyeIDBpke2SlF0xSmEK5FcrgHl2/jHLTQwN3yf0wmcluOCF3PSc1OAVf12L+sb7RA
	 +EahZE9WIM8jcXLnoNM3yCrMEAt1BT9bvKDwEXrkLuTBShMOG4fnQS54DQav/KxBN5U1o
	 oiOXvDWqRusa0VugYWDMLdVH8ycF7Hebg7vvZEe7mCFB4gAqT8jOJC4iK8UcWzJLa5ESh
	 W+XZwPvMFF++bEV4fziQ/3U6cP4SIlJTbmkfiZqGffjBc2c9ku1hylnctgfXSee8Q4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=G9L6Pghl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6D606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C6D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=G9L6Pghl
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso457865b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792778610; cv=none;
        d=google.com; s=arc-20260327;
        b=Ac8XIAtcymEXqR189q20GFHGLpcf6tpmidefWVTB8I5FCm5TYiB5Rk9Lm754r9qwVn
         EsVU07h/5QvBVRF2zllV8BdJU5AvDW61XN2gO7ULtrnQEHdCwN4qzNSei6U+Ic2ecQox
         naeAcSbJklLcEUIgQMZvG46B5dUNSFrQqbDO6VwvXl1YsObUfCPKF/pIaOUHvyyPXebK
         povmTsmiFGrFENiEs7+pRW51El4BNkgZn0Edi5q6JHIpyicxg96ip1Uf4OzMsMfvrLsq
         V5a2r+mcegTFdW+4uZCiFFWRxGpxWu+RbiTQ3b9Tc0CPFmEk5OR656YkWcYzmGUpWWrv
         t0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QtYaJnNe8xkPBPNyUxj5jlp0lFkEB43F9v5MzV6TxeY=;
        fh=OA7RTjWtf0ekFJVRLS7svWvrNYIaG0/9kTRmAanWNS4=;
        b=gYLuFh4yTDtDGW7ErWx0xwt3BykyjDFJC577+MrpCpbfMVzW4rnXKcSPy3kKeM4Q7Z
         DtIsePHWEU6I0wDbNg19/AS2bqF70/EqxiOMAbEUeLjn2q9yDfTYP6xi5yutrhdnN/JD
         G5nvUSiJd+OGP8C04YjdjpCw2NCm3oZ8w3X/f9TTDXhUeoXCn1252evzbHa4O4zwpqBZ
         qUREze+4yuMic37AA/aiZCB7OgRGEIc/SoPPQuAJxG7HTRYSKqySAobqTPhdfWfY/ENX
         2yTo6mZDT5IAz+FfUAld92Gse0aCztc1ucuXruSSok3LR7uguutzP3W1HTDhp+yx4g+F
         GcDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792778610; x=1793383410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QtYaJnNe8xkPBPNyUxj5jlp0lFkEB43F9v5MzV6TxeY=;
        b=G9L6PghliHUJNINa+jhehfq3UiRowAVvbQ9GlO0GNXlsRciHnAZaRDh37F1kUqiDhJ
         axOQ5iGD+cmkz7txURKXDoYE+M95zrR6CrBE5gANXs8KYrFec4BmVX09ClNoaTgmuDxv
         OxcoUnyCOLdII91ST1jgaf9pXEbKlzeXJOgIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778610; x=1793383410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtYaJnNe8xkPBPNyUxj5jlp0lFkEB43F9v5MzV6TxeY=;
        b=niaBrasjJEgiWiFZ6CvyX9NJL24LONBZXrvvCtinkgnsxDVDIpQh2Yb1xypfX1kbHt
         SEf3h5kDcDHqWldWFdt8PSxjz9dsE4YUCqrITfB3oKXRMkJo3yWTyFKLsBTycyzx8pEn
         y5wKmDG5Mg9VyR9orskI/nQX+nD6ttjs+6MLfdxzV6sPTwIupPgAXO0v6w20Qx3Baa8Z
         G25iEl1EmLZcy6MBHgZvsWZu9smBkZs0BwYFMQFJtwIytT9QdwbVQ9qoSiDgaNrWlEet
         SVedQxxBEpPBJ0W0rN1DeDahDGqQCPr+11Kg49kNc2PlQ3W+rR02+z7vkHyICev58Z3N
         fuUQ==
X-Forwarded-Encrypted: i=1; AKwUvBztsxj2Ax3yVnh/lnVQRVyyVkqyA8E/CXKzY4iCyk/6jJmumxBx2fIptqmnbQ+e0o9/Rt24qHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYSBDOT9ReMwTuL71CMFKRz43IaVgqO1W5FOKC9O8Cu7XeeBVk
	Ym/DVMPiUBSdLvOOkFoa/N0e+NDTfH9l3HRLiaGqTsBlithqmw4P78t7mAi2Q6ssN06o+nwN57C
	tZ9YbJxHHpUcga2qk/+1ZJ3By8k2UKvpWVANgrIGf
X-Gm-Gg: AYBFou3gIdoXUBzRxrOQiNYPwL+2YtacCO+BtdMC8hz9bItsbkw6cRlQNHxBug5cewv
	yFd6xqlclFHgXwsJBUm3F1NMNk3paYN/q43CpjhWqipoJx+k4blKPINEs9BxyeBXknPru1j/Cdz
	YFmD3UzIH6uhBxhw8GpDj5yjUngwZUTDufEGKKaMQ+Va2GnydBMLYg9UQEZsfBZ5f5m/h0HouUI
	B09tSmVWm+j6aAcCNeTWlXEiRzaJi41Cp1BxajSTeQf13yJpeXtb0ymTewoVDVIMXTK3IwSUwRF
	GlRtncel62QGz0iy/ZeOHHAVt+7ZgaVl5WLIf0k/+NO6OijS9iYCNMjpoYdUdriktgSZr8d2sxA
	3/EdsHZywLHBU57tXMkIs37O7sZmgq4BV6NjEPJO9nVmrvjrrtcrqly6PZH9MBxeg0nnnMB7vbw
	j5U8iL65nAxY/9qyg=
X-Received: by 2002:a05:6a21:6b87:b0:3e2:799:f2dc with SMTP id
 adf61e73a8af0-3e3766e1161mr2230711637.40.1792778610518; Fri, 23 Oct 2026
 11:03:30 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021155450.66934-1-phx0fer@gmail.com> <CAM0EoM=XC7V630n8P7_UhECTFDuJcP8XqeYnU+jUG68a78YteA@mail.gmail.com>
In-Reply-To: <CAM0EoM=XC7V630n8P7_UhECTFDuJcP8XqeYnU+jUG68a78YteA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 14:03:19 -0400
X-Gm-Features: AclHuK8rCUXyiRobPy7djtua1zoM8eZkl552yg6LsQqdmkpna6KRX0N-ecNhXzg
Message-ID: <CAM0EoMk4AK_REXaq1FuGWQEzbxvYgZ+b-sjfv7Ws0uuptG4ryA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: re-cap skb->queue_mapping before indexing dev->_tx[]
To: Dudu Lu <phx0fer@gmail.com>
Cc: jiri@resnulli.us, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Oct 21, 2026 at 11:54=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrot=
e:
> >
> > qdisc_restart() computes txq =3D skb_get_tx_queue(dev, skb), which inde=
xes
> > dev->_tx[] with skb->queue_mapping and no bound.  A tc BPF program
> > attached to a transmit qdisc can store an arbitrary __sk_buff.queue_map=
ping
> > after the tx queue was picked; that store is not re-capped on this path
> > (the existing cap in netdev_tx_queue_mapping() only covers the
> > skip_txqueue path), so an out-of-range mapping indexes past dev->_tx[]:
> >
> >   BUG: KASAN: slab-out-of-bounds in sch_direct_xmit+0x744/0x89c
> >   Read of size 8 at addr ffff00000e0802d0 by task A-254-2_S4/100
> >    sch_direct_xmit+0x744/0x89c
> >    __qdisc_run+0x34c/0x1d04
> >    __dev_queue_xmit+0x1aec/0x306c
> >   Allocated by task 1: alloc_netdev_mqs+0x758/0xfa0
> >
> > The same stale value is then handed to dev_hard_start_xmit(), which
> > reports the same fault.  Re-cap the mapping with netdev_cap_txqueue()
> > before it is used to pick the tx queue.
> >
> > Fixes: 10c51b56232d ("net: add skb_get_tx_queue() helper")
> > Assisted-by: LLM
> > Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> > ---
>
> I did not look closely at the rest of your posting, I suspect there
> are similar issues in some of them:
> please please since you are using AI ask it to check if there is
> already a submission for what you are trying to fix on the list.
> See:
> https://lore.kernel.org/netdev/QDISC-MD1X.v4.r0.20261021042722-1@mojatatu=
.com/
>
> I got my report from sashiko after submitting a fix for a related
> area; hopefully your guy is not just scanning the mailing list...
>

I should have added, for that reason:

NACKed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Sorry, I am overloaded enough dont have time to look at the rest.

cheers,
jamal
> cheers,
> jamal
>
> > Tested base
> > -----------
> > Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
> > Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
> > is unchanged between the two, so the bug is still present there.
> > Checked against linux-next next-20261021 (commit 9a482184d910): the
> > affected code is unchanged there as well, so the bug is still present i=
n
> > linux-next too.
> >
> > Reproducer status
> > -----------------
> > A reproducer was written and executed on an arm64 QEMU guest (KASAN,
> > CONFIG_NET_SCH_PRIO=3Dy, cls_bpf); it fires at the claimed sink, and st=
ill fires on
> > a kernel built with ea4d4b5dddb5 applied.  The reproducer source is not=
 posted
> > here per Documentation/process/security-bugs.rst; it is available on re=
quest.
> >
> > Triggering conditions
> > ---------------------
> > CAP_NET_ADMIN (attach the classifier and qdisc).  The residual is the
> > store made by a tc BPF program attached to a transmit qdisc, which ea4d=
4b5dddb5
> > explicitly scopes out.
> >
> > Notes
> > -----
> > Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
> > (commit 93f51579e7df) and a full arm64 kernel (defconfig) was built wit=
h
> > it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 error=
s,
> > 0 warnings.
> >
> >  net/sched/sch_generic.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 6f6a6f0d5eb0..c326d12942e5 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -432,6 +432,13 @@ static inline bool qdisc_restart(struct Qdisc *q, =
int *packets, int budget)
> >                 root_lock =3D qdisc_lock(q);
> >
> >         dev =3D qdisc_dev(q);
> > +       /* A tc BPF program attached to a transmit qdisc can store an
> > +        * arbitrary skb->queue_mapping after the tx queue was picked, =
so
> > +        * the value reaching here is not necessarily one the device ca=
n
> > +        * serve.  Re-cap it before it indexes dev->_tx[].
> > +        */
> > +       skb_set_queue_mapping(skb,
> > +                             netdev_cap_txqueue(dev, skb_get_queue_map=
ping(skb)));
> >         txq =3D skb_get_tx_queue(dev, skb);
> >
> >         return sch_direct_xmit(skb, q, dev, txq, root_lock, validate);

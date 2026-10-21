Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587789;
	b=MBJfi7bIW+2e38XiNscRGD+ECh6EdfcGLzYzskDUxAiw38k2FskENHcxTgi0lpPgyDxP
	 QymFZaby/NiS/lGQKlBsf0z3Gf1NNoBd32o1OauLt7F9Tko4CcaGSUyHCPw4mPL9GTMVi
	 0flcTaPF7Sw6f46vLLelAoLz8Yeg2dAF47qC7b4vtrMf+XNPBFPpM0hq2bO5PqpsRIZVl
	 ssYpAVENC6cf+u/yXpA+DE9H0EWCtj2s5Z7BP7akj3yxmE87C7oT+J07a/I00QJxnZ4On
	 IKYwHmbwWWCkkRm01gDJJiq0mgFJJGTYaWFCq6OMVqHTh6ssXnaEiNxKBlosa5HGzQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/lEhM+NhQX69KLd8GwWBz22OjDpzEesWZeFnWyadf5E=;
	b=OV2g8++5LMK3v0u0uLIO5EXTkJj4Y9et+U7Ho5PFM7PUufkvqVMRp3/T4HQ6vIX+9e8g
	 w2odQ9hao2wXHn0mo2EJl6O6Jhy+KeBzjV9YEAJdfgvnRBT2b0l1dE85tZt95bP4EwHiR
	 Ij+2cVsqVA9bH6CimrEmYBfVW/TxumCrsGgPGTfjnxOXtJIryb237zFuXxr/sl2oXqk/L
	 /dglTDZA4Rkqt7VqJjZE1PbtPuBdx+6wCSYd/jdtTVAflzD+B3TLjsfUU9/+n1BG9Fpai
	 TU2yRU9znJ6/wfomsiGymNKqShhiLXh//ndG/La0EKf+8tA7mi3nMgZHTwSo4vz63EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="CKjX/Ila";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB3606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36FB3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CKjX/Ila
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso3731915e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587787; x=1793192587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/lEhM+NhQX69KLd8GwWBz22OjDpzEesWZeFnWyadf5E=;
        b=CKjX/IlaIcQnxhfqjN30ZP66qs+vSc72gjUWvDELStdJuDDg7EK7PJ/t5TbP/nHo+u
         RCimgxUtgbpJ5MrXuGrC/e+l4osDPEELlLvBdKpEVyzIHZLyRG5vMWqA3R3pp4UoKz2V
         PL1eesAMKZml9Sm1HMGm0N3MppD9p4UcGLOaQQG22tLIjJiLw9y0MSGgPKxzUPzDEVZs
         qaN8nNDyzI32yx02KB8czJoaZQFruZu8eaDnU9giym0EdokP6EZTLAhtAsjvcvNm5OE9
         WcCcQPgtoaKA2dsKaKeWH4tvqcQLbrw2IKjos9sov9QH7RDDNyLVhG3KOaT+Sb132K3j
         GNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587787; x=1793192587;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lEhM+NhQX69KLd8GwWBz22OjDpzEesWZeFnWyadf5E=;
        b=MeOJw7XUPXzC3k98lyDDSciw6SxGgFys+zNL+EExwmqJQgCU2UXSxWFxyKDpUQuH8U
         fEO7erWHJAKas1w6kvqJjoouteVEft0j1Yu3ER98Q2/mSQrdte19LC1pLHgaOsRgaf4f
         ux+lNU/IejbY+eJhNjInQyCDfPtMW4SMBA/XoEy+Qo6QoHjt8RJTHsZHdcay9JhgvmiO
         KRCiLXkMjbHhcKqDtsEKdEtqMQPWNTGvZwcc93FNurSX4ZRJy0C+IlMvHVpOHW1Cqyfv
         2YRXBbErtct33yWS2onzR5T547cm9PjxObqriD/amDwsBmQ9s5QDBEDenHZIJyRghsNB
         PhCw==
X-Forwarded-Encrypted: i=1; AKwUvBzeK4m6RAWNuh6Xu+Buwhqvlx0xtYWJKvwQCH5VRujjVJyO7Cu0SJiV+tv5UbGffuJ98IxQLNw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPRyKEUVVxlXRGrivZKjFkK70uQJrTjeWsrbk7Z2c6LMuFMCIx
	f1mta0w9JtvwkrgWcfUVfslf7cpnSGAQG0BhgbUQGeRX4AnDMEPyE5kA
X-Gm-Gg: AYBFou1xpHT7OoCBMSYHxYkMTBETWsDTVFIzma3g/UMEJyCtS289xvxFH7H8MqzdoI/
	0JWqX5udJudOXj4yaju1N6mEMySn2Jg7mo+9HLa/59h915d+7/MddgCNZJFbtlXCtClcTZYydwZ
	kiwsE8HUBF0eDxiI+h6cuLnkoDl/3wGvYEa/epNVE1uY4xi0qswGEVanf4dWY0ioUWdBV0/k8H/
	pvuCf1Ruxc94yjyGa5xjJMVSJE1PWMCjQTGVkHb5Gmy5BNIXGM87Xbn/uD2ToSc8cJ71gkzUUbt
	jl3Ode6N59jZK/g1z5vomuKkabEagDDwtxg3TypouzCU2PtqXonltB4r6akP0HeOkkgl4UFVler
	aTfrmucSg1/Nvxu/BS0XN2xEbx48hMP7vUGECDNnBEfB92TC68RPibtYSrSwqr3nrPn8Lrr2/cP
	y2CBlHaNZne6aJqCMZjmJmggamutZcWbsHN2W1Hk/wdgbafg9To8Q26JUkSWzXbboXUB5R+bJTd
	xymUTpw/7XdTY9JvehvSSF4SMRaTvM8Lh+WzLW1GnitZzEDrcybNr7Sx/YxBhavdL7bMVEjdDL2
	flexSZ4GxxYYhltYYhS6pOERgH6MnbL9CNqb9Q==
X-Received: by 2002:a05:600d:864b:20b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4a201e10debmr12370745e9.28.1792587785886;
        Wed, 21 Oct 2026 06:03:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835e22sm6124852f8f.44.2026.10.21.06.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:03:05 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:03:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?QW5kcsOp?= Brait <andrebrait@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 g.goller@proxmox.com
Subject: Re: [PATCH iwl-net v2] e1000e: work around TSO erratum that
 corrupts data and hangs Tx
Message-ID: <20261021140303.5533fb2d@pumpkin>
In-Reply-To: <CALhGy9n9EMvV2JN8s4kpKb3Wsc3rjRVfibpNvVdAw_rHT=dYeQ@mail.gmail.com>
References: <20261020230211.75665-1-andrebrait@gmail.com>
	<20261021095756.0f5770e6@pumpkin>
	<CALhGy9n9EMvV2JN8s4kpKb3Wsc3rjRVfibpNvVdAw_rHT=dYeQ@mail.gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Oct 2026 12:49:16 +0200
Andr=C3=A9 Brait <andrebrait@gmail.com> wrote:

> On Wed, Oct 21, 2026 at 10:57=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
>=20
> > > Apply it to all e1000e parts: limit the first data descriptor of a TSO
> > > packet to 3 * (max_read_request - 4) bytes (372 on the I219, where
> > > pcie_get_readrq() returns 128). The rest of the linear part goes into
> > > the next descriptor, which e1000_xmit_frame() already reserves; =20
> >
> > Aren't you using an additional descriptor over and above those the code
> > might already use?
> > So either it was reserving one too many, or you need to reserve another=
 one. =20
>=20
> You're right that the split can use one more descriptor than before.
> The count already covers it, though: the bare count++ in
> e1000_xmit_frame() is never used by e1000_tx_map().

You could just comment that that count++ is in case the linear part
has the extra fragment.
(Indeed the other count++ could be unconditional as well, you aren't
going to notice if a transmit fails to fit by one descriptor.)

> It comes from e1000,
> where that descriptor pays for the 4-byte TSO sentinel ("premature desc
> write-backs in TSO mode"); e1000e dropped the sentinel but kept the
> count++.

Put that in the commit message.

> With this patch the linear part takes
> 1 + DIV_ROUND_UP(len - 372, tx_fifo_limit) descriptors instead of
> DIV_ROUND_UP(len, tx_fifo_limit), at most one more, so it uses exactly
> that spare.
>=20
> If we want the count to say so, I see two ways:
>=20
> a) Count the split explicitly and keep the spare:
>=20
> if ((mss) || (skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> count++;
> count++;
> + /* the headers go in a first buffer of at most tx_hdr_buf_max */
> + if (mss && len > adapter->tx_hdr_buf_max)
> + count++;
> count +=3D DIV_ROUND_UP(len, adapter->tx_fifo_limit);
>=20
>    The split pays for its own descriptor and the old spare stays a
>    spare.
>=20
> b) Replace the spare with the explicit count:
>=20
> if ((mss) || (skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> count++;
> - count++;
> + if (mss && len > adapter->tx_hdr_buf_max)
> + count++;
> count +=3D DIV_ROUND_UP(len, adapter->tx_fifo_limit);

c) Adjust the DIV_ROUND_UP() for the linear part.
   I think:
    DIV_ROUND_UP(len + adapter->tx_fifo_limit - 372, adapter->tx_fifo_limit)
   is right.

Although I wonder if you really want to be doing all those divides?
I'm guessing that tx_fifo_limit is usually 24k (and the actual buffer large=
r).
So the result is almost always 1.
(Indeed, does TSO and checksum insertion work if the packets are longer
than the real buffer?)

>=20
>    The count becomes exact, and one lower for every other packet.
>=20
> Neither fixes a bug I have seen: the reservation already covers the
> split, and in about 3.5 hours of test traffic on the patched driver the
> ring reached its stop threshold over 300,000 times without a stall. b
> also changes the reservation for every other packet, which I haven't
> tested. So I'd keep the patch as it is, the smallest change that fixes
> the bug, and leave the descriptor accounting for a separate cleanup.

It'll only matter if you are transmitting packets that need more descriptors
than the post-transmit check.
Otherwise that check disables transmit first and you don't bounce off the
'just enough space' check.

>=20
> If you'd rather have the dependency explicit, I'm happy to fold a) into
> a v3; it only reserves one more descriptor for those TSO packets.
>=20
> > I'm not actually sure all the logic there is actually needed.
> > The code calculates the number of descriptors the packet is expected to=
 need
> > and gets the packet requeued if there aren't enough, but there is also =
the
> > 'post transmit' check that stops the transmit if there isn't enough room
> > for a full length packet.
> > If the latter is valid you don't need the former.
> > Although a sanity check that the ring isn't being wrapped might not do =
any
> > harm. =20
>=20
> The post-transmit check reserves (MAX_SKB_FRAGS + 1) *
> DIV_ROUND_UP(PAGE_SIZE, tx_fifo_limit) + 4, which assumes no buffer is
> larger than a page.

That limit is constant (for the device) - so could be pre-calculated.

It has to be said that I've always thought that check should be for a
'reasonable packet' whereas the docs sort of imply it should be for the
largest packet and the driver should never really return 'I couldn't do it'.

David

> The linear part and high-order frags can be, so the
> per-packet count is still needed.
>=20
> Andre


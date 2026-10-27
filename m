Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793105781;
	b=c0LzYMAfzAWb4GRVARsdQsgaDnsYQkftb4riGHkqNJGnXtnulu5R44W+XFDQxHPyKet7
	 ccx2RGMPdnWJ/WuFIdBn88fHW+uq5CHo20N4hfPQTQxj0eaAwsH3OWCqA8OFvrsPt62v3
	 4Zr5CU52tlnm61IZvHMYlwrqwtptkq7GM4fikPpS3GAOuNk7uerRB2qA2Mt/14VVZ3jvs
	 FI3rTyerqo3JY6I/hsTDSylmzOZTcnSnMEUVO5JyCIQA4XYcFzToX5WOYX98YAwlSg1SA
	 iAxEN/+VjR4cH1rG3YijrDy/C7q8aA30mRJ0zI40G+dDe/MRNNrzT6Q0J1bizZMn/zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
	b=fYmSHDNzI56BzL6aLSWBs8Rcn2N+O244zXwu9WGOf/VDqPb/PMTCzxK5Tr5+uPIihSbE
	 cMlaU6CSZXZ3rCgR7jbLwiNMFKNllG/3HSPCDl1HmPSbGi/GgcgYfibkZcr7aAYhZKvOe
	 sKWJjdRZjqxOyj6FpBtC1IpeWz4hrUv3NxDSeJjeTrQpSZLntDmcQLWg/1jBgABoIabRs
	 bAqaeDWA1wKLLzNOWbDGjXfNFroLLWcaYOqThsu4ZRGy2QXACNVRSV9x8H/Cbf3FSrcPI
	 RI1+D7FmbN28Yl7uRMyGAAt1NpgsvUcqnVVOtCXIh4r8KpMJROEiQFei3apFYAzc46Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QxuZ4R0D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A5606A320
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D5A5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QxuZ4R0D
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a058f74a54so1598111b3a.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793105780; cv=none;
        d=google.com; s=arc-20260327;
        b=nLV4lCKGhsDbLESzWRBY9GQw6O1ulHV7f09vo09HZVh+4YbYojYwQco5RPDcBSbHfN
         C5i1b6F4JwRhhZsXGmpHDU0h3NSTsyBIhCCCPJRNI+HXQUTuhhQrUBVSbZH2b7qswhOH
         PUrBMJjwjNUV5gvu/sBUiHA5wSaNnXOq7Yos95BtSJ7C7lT4bpH+rWSayAIxiz7dW2sk
         L5jz/tiZlqF64ysAn/WK+z+ahpBWYafceJ9VldG7deY6rC1xTVGhDra+OTvH1Io1Vu9F
         QY+wSRACuRwnSmjR4HN1W/1JZp0avEO0Aj3au+jLXHk9luxFMZz7s/OE0K4uPLK3vwg0
         E0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
        fh=MLh/QwNNoX+lFzOdSpOBK/IqQpVW8zLfNe/OQyghw6M=;
        b=MRqWmfsd91fLVnKpCWkXlzllZfcYqh9d5na8sZUDEbUc+NzLaUQ4w8oOJTCNAd3oBZ
         /QwR+YruPEMwNHaMuME3LN34ERiicJDxjyTeQKSxXbD7Sg+qdML669tgO6sHNo/nLsqF
         sti58I1Cj7sZ02nSMIix9giXwKaC0GrsIj1b6tBLy/pPsM3KOtyFOBfDTisoqJokkZ8U
         Xo9iMntI7A2L4z6sY7npUcd26HbfqoWqg6YQKGw6WJTN2vPusCrK3hVOK+iuN97xgynp
         I+SVGfIiqhqakP+CEAaBCW9x3ZVrxw7c0Z8XTs7jMGCLKieeSBU683jOyUU3RxG0aB2w
         xyZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105780; x=1793710580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
        b=QxuZ4R0D4EjkmiBfbxhlHhs33Tg13ERJqAacpJNBNRAqhJUfpsPsj48T840uHJCS2K
         28kEtugLkvMgxrzClEKhK8bnFA40L0385lof/0AIjYbfX0vEqB7OFJH9yVgiVF9fkljU
         VX/hIoQr99WFV2X03NAckbBo//k9KFTehoNsocBFueU36rAcQYy0nG3ZeRkEFkZac3GC
         ooCH8tRzMOJ6xqAbOMog4Xr2msWgcEuPcKeOQ3Ur3HiuvTP2jVxyMGiu2LCIduBV5cyU
         UyT6lcNKspHw9SgHAWev5L3zlNv9mnIxbj9P8fIqZP/sDFR3YPTcrTzDx2548YRzNkvK
         FbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105780; x=1793710580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
        b=JIKwBt7tIIQUHr+P41N9zp6v/Ah78Gl+Lti57hmwdId3WdzNJoCHPRc+G/TkFXEh1u
         VvYi9tU2D04nfySW62ml2ra6oALKnETXJu0CIgD26a34EVYV6z2nyKDemjgIbl48zQ/p
         oZjOrcBTYovP6nUgopYA6gXxfy4xuXF4749mmvrZOej4LhCVFnl1nnhjNoDTgnhm/P6Q
         aNUCsWxOEK+6omWt6K80ZKT72tmQw+t5HL0NbHNdtX4TqhVedmv/z5pSPPj1AdBdmsZr
         ipul8zqIhott1Zho+6xQpO+5ZeaU5wEPtR4+k9QmiV24FOaXiYc+NSRmm36mko1wqXMj
         xzAA==
X-Forwarded-Encrypted: i=1; AKwUvBxFJOoAsck9z1/4rEoXm8/QVqVfR/iLsgPA7H6UmKIfeqRiYk+xN6rfpieK1un0FvnzGVfDOJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZjN7G++bNDU7RJCXqROCuHMv2iBpyBm+vu9qqzJK4t7cW1wp6
	Tv8kBbEsx8z4JcXS4UlcGDfPn+m3Svoygh4kTK/6JW1s3dnviQqKwc+VGwth7ILN4Cg/38aMWDu
	bXyVoJol2+tnwtH86K6rw1kzV2poNDa8=
X-Gm-Gg: AYBFou1hdc3IuPXI9nNyTLwnT61fcrj6sMj0cg31z9B9WdYa689JFYCSwycbo/AH9m+
	IQvWqN2pe8VVSH+7WTk9ZatRCSBhaZLZElHiUeXEoLIIUZKssNhZlSgaqEXqzcRMiaFx0yE/nYu
	kjaeQ5XRlGcfUmPsXpRgPp/ZAbW7U/jt+rJUukGPb6UJxSvQasgj2OTFnNzfhXiQC+r3Bh4raac
	6TctEoTEjva0uIH/ii3ILmFR/wms8dX0e1dBYrEaUUtmwHajz//7AdOc0811LaErWqgs9Jk8Bo4
	tJkb08B/xZacXK6cC2LzAZqpqQU0gvBUp4hHE4cHdDr0uxAL61BFYBcER97np+K+sV4iCQMt63q
	WpcvOx6h4hqcurnmomH0T49HGy5hY0XneL7JpmTM=
X-Received: by 2002:a05:6a00:c586:10b0:899:74d0:8a72 with SMTP id
 d2e1a72fcca58-8a5ee5e7dfdmr797297b3a.59.1793105779946; Tue, 27 Oct 2026
 05:56:19 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
 <20261027121442.907414-3-magnus.karlsson@intel.com> <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
In-Reply-To: <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 27 Oct 2026 14:56:07 +0200
X-Gm-Features: AclHuK-qdlbwRBbu8GAMevQCutYCTJJj0bkkgl1I5CnGCwuZZue1FqLEunkqSgo
Message-ID: <CAJ8uoz2J5EbN++dts69BVJoAW8+T3bEtgHC-t3EtVtURQH-QWg@mail.gmail.com>
Subject: Re: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
To: Eric Dumazet <edumazet@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, intel-wired-lan@lists.osuosl.org, 
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org, 
	maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 at 14:43, Eric Dumazet <edumazet@kernel.org> wrote:
>
> Le mar. 27 oct. 2026 =C3=A0 13:15, Magnus Karlsson
> <magnus.karlsson@intel.com> a =C3=A9crit :
> >
> > That USO works for 64-bit systems is just pure luck. Currently, the
> > computation of the UDP segmentation header is performed using sizeof()
> > a pointer instead of the sizeof() the UDP header that the pointer
> > points to. Since the UDP header happens to be 8 bytes long and a
> > pointer is 8 bytes long on a 64-bit system, this works on all those
> > systems. But no such luck for anyone using a 32-bit system as 8 bytes
> > !=3D 4 bytes. So fix this by using sizeof() the UDP header that the
> > pointer points to instead.
> >
> > This was found by an LLM while implementing something else that used US=
O.
> >
> > Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")
>
> Missing prefix? This was really:
>
> Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")

You are correct on both accounts/patches. Do not know why I missed this, so=
rry.

Do you want a v2 with this added?

> Other than this,
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/=
ethernet/intel/iavf/iavf_txrx.c
> > index 8982cf75466f..2c290d7788d2 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > @@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first,=
 u8 *hdr_len,
> >                 csum_replace_by_diff(&l4.udp->check,
> >                                      (__force __wsum)htonl(paylen));
> >                 /* compute length of UDP segmentation header */
> > -               *hdr_len =3D (u8)sizeof(l4.udp) + l4_offset;
> > +               *hdr_len =3D sizeof(*l4.udp) + l4_offset;
> >         } else {
> >                 csum_replace_by_diff(&l4.tcp->check,
> >                                      (__force __wsum)htonl(paylen));
> > --
> > 2.38.1
> >

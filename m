Received: from mail-vs2-f13.google.com (mail-vs2-f13.google.com [74.125.227.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F44ABBD2
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685619; cv=pass; b=O4CB5xe7SvHGUKyTfUsynMNfX4OFCgq3G9+EsEZi4uuE3UfkLJpnLDXug+pV+EdmS6EHbN4XhfAS0gtJmqSOCayqa05Q04F7KmAYUqpu0/NgyQFAGWOzOjhcgsfi6OcEkkaZ9zIgjXlHJueULMHKntfrCsh784ByN7s+aSiuKZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685619; c=relaxed/simple;
	bh=I3jIoE5k7R45csE/rQEFSnTnQvHF2eaUeFAYNoD9q0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arQjBLoFcaO7ToP8dvLjKdvdXV7DdchJKi6kxMIHQEyWwTfUXTU/fKF1e4k8UCDH8JEr36hQKGqzzQccL3yuDnCRPj39YZNKTDlLUvGkOCHoxDFtuwVpGl2r+PLXd6f4U6NgyCmTfUKX0vS6eMgkYMN5j7OTfgzslDAnxVNYCoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=UfjihD8n; arc=pass smtp.client-ip=74.125.227.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="UfjihD8n"
Received: by mail-vs2-f13.google.com with SMTP id ada2fe7eead31-795a0ab5227so73412137.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789685615; cv=none;
        d=google.com; s=arc-20260327;
        b=fvQMRlz/mmDDGkyuI/Oy6AF17U5IQxRe3BwMzZ5Ml0p6EXXkLPRjoWrmMhL0A05owA
         Ik7c0jROAsvTYDSoy9KvHYkvFU02EMzDjDGI0Gp+8hUPqm90VEgYHwHAw6ClZiqb3p2S
         MSyCICbPP+oKECAD/CH9LSUbkrFpDTsLj3JQbSDlxV3K1T8nKUmFmBNIfykszDRuOkUl
         1rjUdVXImyjW75Ln+vDhu0D8mqDZthMxO8oajC400Nd1t7e2WMXnbYFJ5Ir0udg1mLFr
         gMR0/IepwQlIUEWCc7Qwp+a0M5J96QSJKYUOmS/dtMN6/27xoSOEsZSL6RELszT/E3Ax
         o1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tPffiBlWT84SH98WVACjyKb1UTvgV1ZfF2HGJcS8uKc=;
        fh=KDPEyLFrx0IaPdgkSonKsexwzLCh01ZOslfJI1v3q8w=;
        b=b3hqC28+3Y8RznSy118LdWnYpgxOEvoZu6X1Vxo1BK+VtizVEa+fNZnARVXANZGuqs
         jedGW+jqM0kH+q0pck0H0Eo9ojOmW4Hsl1Hw24rAqOUEd3GUKuiWRrb6RaYfbQrzzpy+
         yjsLPwUJXbeL4+lxV5fa085+A+525E4QvCm9dg3730CDHxYAq+QhKdWQg/mVr4x1F7mw
         louux1WLauXFqO51WF9UWkkjYQEAVU8aROlcTn1b/UXwqRD2O5Ka9cQTiNQgpmW33Oqa
         9WRLfezFcVrjcgODZjuXh2r2XFVcuCSYYrZH595bQf7tLhLhJ91loRz+XKejUyAO09Z1
         p1Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789685615; x=1790290415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tPffiBlWT84SH98WVACjyKb1UTvgV1ZfF2HGJcS8uKc=;
        b=UfjihD8nwjg+bCE51AFpmS+Ny37Tvv0vul4bYqA1DSlLong485eu4IlZFttVhNpxbj
         3WKaLD28TbKEJKrXYO8jssFqIkWgQmQ2+2rkrpFFTrllWMu3JQuxPSWQswoYte2B7WQj
         QhHuwWUDj5AMHzeN39ELiOimwx86gweILhw73wOnObfdK6U9UbN3UOMqxKJKeSkAFEyu
         d33zMT2quohgsVCb62Zco2Lqm5Eg9Gj+NmrLxO5/1wTLoV3o3NBT9dBk7syrL161Tik0
         DVE1rMH51jvhKyFO+8ZkuOKs/rv1f5sNy/ewTn+Vs7plPviFgNdvNjKGsPorqQRFmyTt
         Wx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685615; x=1790290415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tPffiBlWT84SH98WVACjyKb1UTvgV1ZfF2HGJcS8uKc=;
        b=qpfrhBZXXkbP/WV7KES/ZLZUoLVvuJsb5Mxzxf5QBu7RTHYx/iHY3BZfbxtUbhWWWj
         QJ3HS+xJEGf4Chc3wNl5SonhMLo7QNTjavYxFq1WLwQrQJG3IjhfnrmancBeMT17o++F
         twtSUzljejapi82dSnOEr/ZTM9V+9qtn03V62oaZUnHmX6FKUrNQQXY1pZCOMqlw+kh8
         MaNej+ndwv9BJoWN9+CXGPfCzjnW1IluPuFwoZSsBIqsBadnaoZRoTJ1Yu3MsOQyrJLZ
         zTc7dxqokeMoMQkVbO+BOjB3V8O75E0FqMpZXw67rvecWEoxii0PHyb92DetUyEbwHr+
         RajA==
X-Gm-Message-State: AFuF++lJjo4zMYEMHM8afTzjYKD/gbtxEVlSnYf3TY1REC0WyF2a7Gad
	er4o0kOc85Cn50SSalLPlvoYZvg/JsRBs7TZbUren4YAt1YHAcK/sWsXGOzmh3yyzPG0xctNFJe
	DCYhh0aSsSGHYRYnZYBME6+PgQn194Tm40jqDnugcEg==
X-Gm-Gg: AYBFou1fFxF9G5cFamHxLJL8p996uWPClxAbXGuqDUYdDG/p2ipEy8CnAl3WM09fPhq
	6m6w3GsNLfk/uZOtZZaIzEIOOaAkbP01sbFtHtGF0iDmQOJVSB/8Pl2kPttGEG4zrIVJ89O9J0T
	pL2YN8jNP66h37iD05omJMMMDOGr54G1/G3+1w+4FABGmPdraX1Mtt4oe8KIqbjmse74AKsHCev
	tRVLselFNwJ/nO6oTBtqINo9Uh6Bv7nt+ZZ88aYgr9nAYegs7qkT30RfZzhS26KGjprQOUR2Bgq
	FR49QTR5hVxi/dsqBY2mYOx4wPf1MNDKbj92SrvwBYkobEXCPlh56aqx3SO1ZzoCjYllrICR+fm
	3UCycEkIoqnkoJogg/mte1el/bqLm171Y4wL9wfcjsZHHRhUlKSIt57xqr/NdumHCiOZvQv3kjb
	rBqCaOulwo3+GhxwuqCdw1mL9U/4Q9AAFrIuL00YPo
X-Received: by 2002:a05:6102:510f:b0:7a2:28cc:fb87 with SMTP id
 ada2fe7eead31-7a55d48f493mr264319137.27.1789685614945; Thu, 17 Sep 2026
 15:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807183853.2288959-9-rjethwani@purestorage.com> <20260817221145.3666490-1-kuba@kernel.org>
In-Reply-To: <20260817221145.3666490-1-kuba@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 17 Sep 2026 15:53:24 -0700
X-Gm-Features: AcwNN1UANbPsbhamyF9TY6848_NCeB7Seojb9zzkItofoRUShV9fm3VYw95gEtg
Message-ID: <CAKaoeS08jZ=6KdS1Ha62aZDfU4muDxvez8pwAdDoKDeEYFh15w@mail.gmail.com>
Subject: Re: [PATCH v16 08/10] tls: device: add RX KeyUpdate support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> tls: device: add RX KeyUpdate support
>
> This adds RX KeyUpdate handling for TLS device offload by retaining the o=
ld
> AEAD/IV/rec_seq on tls_offload_context_rx and classifying records against=
 a
> TCP sequence boundary, with the new key's tls_dev_add deferred until the =
old
> key is drained. It also adds a new tls_dev_rx_rekey_fixup driver callback
> (implemented for mlx5e) and three RX rekey statistics.
>
> A few questions on the new paths below.
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/=
drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> > index 337201f12895..71c9d3ca947d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> > @@ -86,10 +86,20 @@ static int mlx5e_ktls_resync(struct net_device *net=
dev,
> >       return 0;
> >  }
> >
> > +static void mlx5e_ktls_rx_rekey_fixup(struct sk_buff *skb)
> > +{
> > +     struct sk_buff *frag_iter;
> > +
> > +     skb->decrypted =3D 1;
> > +     skb_walk_frags(skb, frag_iter)
> > +             frag_iter->decrypted =3D 1;
> > +}
> > +
>
> [Severity: High]
> Should this be restricted to the fragments the device actually transforme=
d?
>
> tls_device_decrypted() invokes the callback for any pre-boundary record t=
hat
> is neither fully encrypted nor fully decrypted, that is, for genuinely mi=
xed
> records:
>
>         if (!is_decrypted && ctx->rekey.rekey_fixup)
>                 ctx->rekey.rekey_fixup(skb);
>
>         return tls_device_reencrypt_old_key(sk, ctx, sw_ctx, tls_ctx);
>
> and tls_device_reencrypt() decides per fragment whether to write the
> transformed buffer back:
>
>         if (skb_iter->decrypted) {
>                 err =3D skb_store_bits(skb_iter, frag_pos, buf, copy);
>
> In mlx5e_ktls_handle_rx_skb() a cleared skb->decrypted is ambiguous: it i=
s
> left clear for CQE_TLS_OFFLOAD_ERROR (payload transformed, auth failed) a=
nd
> also for CQE_TLS_OFFLOAD_RESYNC and non-offloaded packets (payload
> untouched).
>
> Since the new tls_device_rx_del_key() destroys the NIC RX context mid-str=
eam
> at KeyUpdate parse time, a record can straddle that point with leading
> fragments transformed by the device and trailing fragments still carrying
> wire ciphertext.
>
> Does setting decrypted =3D 1 on the head skb and every fragment then make
> tls_device_reencrypt() overwrite untouched ciphertext, so the following S=
W
> AEAD decrypt of that record fails and tls_rx_one_record() aborts the
> connection with -EBADMSG?

I'll address this by adding skb->decrypt_failed flag and removing
rekey_fixup so that the write-back is restricted to the fragments the
device actually transformed:
  - CQE_TLS_OFFLOAD_ERROR sets a dedicated skb->decrypt_failed flag,
so a device-transformed frag is distinguishable from untouched wire
ciphertext.
  - tls_device_reencrypt() guards each write-back per fragment with if
(skb_iter->decrypted || skb_iter->decrypt_failed), so a trailing frag
straddling the boundary that's still wire ciphertext (both bits clear)
is left untouched.
So the buffer no longer overwrites untouched ciphertext, and the SW
AEAD decrypt of a straddling record doesn't hit -EBADMSG.

> >  static const struct tlsdev_ops mlx5e_ktls_ops =3D {
> >       .tls_dev_add =3D mlx5e_ktls_add,
> >       .tls_dev_del =3D mlx5e_ktls_del,
> >       .tls_dev_resync =3D mlx5e_ktls_resync,
> > +     .tls_dev_rx_rekey_fixup =3D mlx5e_ktls_rx_rekey_fixup,
> >  };
> >
> >  bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
> > diff --git a/include/net/tls.h b/include/net/tls.h
> > index 7c2cf51dc887..de4e25b034d6 100644
> > --- a/include/net/tls.h
> > +++ b/include/net/tls.h
> > @@ -211,10 +211,11 @@ enum tls_context_flags {
> >        * to be atomic.
> >        */
> >       TLS_TX_SYNC_SCHED =3D 1,
> > -     /* tls_dev_del was called for the RX side, device state was relea=
sed,
> > -      * but tls_ctx->netdev might still be kept, because TX-side drive=
r
> > -      * resources might not be released yet. Used to prevent the secon=
d
> > -      * tls_dev_del call in tls_device_down if it happens simultaneous=
ly.
> > +     /* tls_dev_del was called for the RX side: the NIC currently hold=
s no
> > +      * RX offload context. Set whenever that context is released (soc=
ket
> > +      * teardown, tls_device_down, or during a rekey before re-add) an=
d
> > +      * cleared when tls_dev_add re-establishes it. Readers use it to =
avoid
> > +      * a double tls_dev_del and to suppress resync while the NIC has =
no key.
> >        */
> >       TLS_RX_DEV_CLOSED =3D 2,
>
> [Severity: Low]
> The reworded comment says the bit is set whenever the RX context is relea=
sed,
> including socket teardown, but tls_device_offload_cleanup_rx() still sets=
 it
> only in the tx_conf =3D=3D TLS_HW branch:
>
>         if (tls_ctx->tx_conf !=3D TLS_HW) {
>                 dev_put(netdev);
>                 rcu_assign_pointer(tls_ctx->netdev, NULL);
>         } else {
>                 set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
>         }
>
> On the common tx_conf !=3D TLS_HW teardown the RX context is released wit=
h the
> flag left clear. Should the comment or the code be adjusted so readers of=
 the
> flag get the documented invariant?

I'll modify the comment.

> >       /* Flag for TX HW context deleted during failed rekey.
> > @@ -321,6 +322,7 @@ struct tlsdev_ops {
> >       int (*tls_dev_resync)(struct net_device *netdev,
> >                             struct sock *sk, u32 seq, u8 *rcd_sn,
> >                             enum tls_offload_ctx_dir direction);
> > +     void (*tls_dev_rx_rekey_fixup)(struct sk_buff *skb);
> >  };
>
> [Severity: Low]
> This isn't a bug, but a new member of a driver-facing ops table is added =
with
> no kernel-doc describing when the core calls it or what the driver must
> guarantee, and mlx5e is the only implementer.
>
> No other driver is reachable here today (nfp_net_tls_add() returns
> -EOPNOTSUPP unless crypto_info->version =3D=3D TLS_1_2_VERSION, and rekey=
 is only
> permitted for TLS 1.3, while chcr_ktls, cxgb4 and funeth are TX-only), so
> could a short comment be added describing the expected semantics for futu=
re
> RX-offload drivers?

I'll remove rekey_fixup.

> >
> >  enum tls_offload_sync_type {
>
> [ ... ]
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index 85c74d0816b7..c34268cd9531 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
>
> [ ... ]
>
> > @@ -186,6 +196,82 @@ static void tls_device_commit_start_marker(struct =
sock *sk,
> >       tcp_write_collapse_fence(sk);
> >  }
> >
> > +static int tls_device_dev_add_rx(struct sock *sk, struct tls_context *=
tls_ctx,
> > +                              struct net_device *netdev,
> > +                              struct tls_crypto_info *crypto_info,
> > +                              u32 cur_seq, bool is_rekey)
> > +{
> > +     const struct tls_cipher_desc *cipher_desc;
> > +     char *rec_seq;
> > +     int rc;
> > +
> > +     cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
> > +     DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable)=
;
> > +
> > +     rc =3D netdev->tlsdev_ops->tls_dev_add(netdev, sk,
> > +                                          TLS_OFFLOAD_CTX_DIR_RX,
> > +                                          crypto_info, cur_seq);
> > +     rec_seq =3D crypto_info_rec_seq(crypto_info, cipher_desc);
> > +     trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
> > +                                  cur_seq, rec_seq, rc);
> > +     if (!rc) {
> > +             clear_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
> > +             clear_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
> > +             if (is_rekey)
> > +                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYO=
K);
> > +     } else if (is_rekey) {
> > +             set_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
> > +             set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK)=
;
> > +     }
> > +     return rc;
> > +}
> > +
> > +static void tls_device_deferred_dev_add_rx(struct sock *sk,
> > +                                        struct tls_context *tls_ctx,
> > +                                        struct tls_offload_context_rx =
*ctx)
> > +{
> > +     struct net_device *netdev;
> > +
> > +     ctx->dev_add_pending =3D 0;
> > +
> > +     down_read(&device_offload_lock);
> > +     netdev =3D rcu_dereference_protected(tls_ctx->netdev,
> > +                                        lockdep_is_held(&device_offloa=
d_lock));
> > +     if (netdev)
> > +             tls_device_dev_add_rx(sk, tls_ctx, netdev,
> > +                                   &tls_ctx->crypto_recv.info,
> > +                                   tcp_sk(sk)->copied_seq, true);
>
> [Severity: High]
> Is the record number handed to the device here still valid?
>
> crypto_recv.info holds the rec_seq userspace supplied at setsockopt time,
> which is 0 for a TLS 1.3 KeyUpdate, and tls_sw_ctx_finalize() copies it i=
n
> once. The live counter is tls_ctx->rx.rec_seq, advanced per record by
> tls_rx_one_record():
>
>         tls_advance_record_sn(sk, prot, &tls_ctx->rx);
>
> This deferred add only runs once the first post-boundary record is
> classified, so at least one record has already been drained with the new =
key,
> while cur_seq is the current tcp_sk(sk)->copied_seq.
>
> On the driver side fill_static_params() does:
>
>         initial_rn  =3D MLX5_ADDR_OF(tls_static_params, ctx, initial_reco=
rd_number);
>         memcpy(initial_rn,  rec_seq, rec_seq_sz);
>
> and fill_progress_params() sets next_record_tcp_sn =3D start_offload_tcp_=
sn, so
> the (TCP seq, record number) pair programmed into the NIC looks inconsist=
ent
> by the number of records already consumed. Should tls_ctx->rx.rec_seq be
> passed instead? In copy_mode copied_seq is also already past the end of t=
he
> record just classified, which would add a further one-record skew.

The record number is fine as-is; the bug is the TCP seq. This runs from
tls_device_decrypted() (step 1 of tls_rx_one_record), before the rx.rec_seq
advance at step 3 (tls_sw.c:1598), and it's the first post-boundary record =
R0.
So crypto_recv.info.rec_seq =3D=3D rx.rec_seq =3D=3D R0 here, swapping to r=
x.rec_seq
changes nothing.

The real issue is cur_seq =3D copied_seq, whose meaning is mode-dependent (=
cf.
rec_start_seq):

- non-copy_mode: copied_seq =3D start of R0 =E2=86=92 (start of R0, R0)  ok
- copy_mode:     copied_seq =3D end of R0   =E2=86=92 (start of R1, R0)  of=
f by one

Since initial_record_number and next_record_tcp_sn are a pair, copy_mode ta=
gs
R1's TCP seq with R0's record number.

I'll pass rec_start_seq (mode-independent, =3D=3D old_nic_boundary here) as
cur_seq; rec_seq stays crypto_recv.info.rec_seq.

> > +     else
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK)=
;
> > +     up_read(&device_offload_lock);
> > +     TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
> > +}
> > +
> > +void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx)
> > +{
> > +     struct net_device *netdev;
> > +
> > +     if (ctx->rx_conf !=3D TLS_HW)
> > +             return;
> > +     if (test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
> > +             return;
> > +
> > +     down_read(&device_offload_lock);
> > +     netdev =3D rcu_dereference_protected(ctx->netdev,
> > +                                        lockdep_is_held(&device_offloa=
d_lock));
> > +     if (!netdev) {
> > +             up_read(&device_offload_lock);
> > +             return;
> > +     }
> > +
> > +     set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
> > +     synchronize_net();
> > +     netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> > +                                     TLS_OFFLOAD_CTX_DIR_RX);
> > +     up_read(&device_offload_lock);
> > +}
>
> [Severity: Medium]
> This now runs from the per-record receive path:
>
> tls_rx_one_record() -> tls_check_pending_rekey() -> tls_device_rx_del_key=
()
>
> with lock_sock(sk) and the TLS RX reader lock held. Here we do
> synchronize_net() and then ->tls_dev_del(), and mlx5e_ktls_del_rx() does =
a
> second synchronize_net(), cancel_work_sync() and, when the cancel fails,
> wait_for_completion(&priv_rx->add_ctx) waiting on NAPI.
>
> Is holding the socket lock across two RCU grace periods plus an unbounded
> wait acceptable in the receive path? A peer only has to send a handshake
> record whose first byte is TLS_HANDSHAKE_KEYUPDATE, and the cost applies =
per
> offloaded connection while softirq receive can only append to the
> size-limited sk_backlog.
>
> Related: device_offload_lock is now taken for read from the RX data path =
both
> here and in tls_device_deferred_dev_add_rx() (which calls ->tls_dev_add()=
),
> while tls_device_down() holds the same rwsem for write across a per-socke=
t
> teardown loop that itself does synchronize_net() and tls_dev_del() per
> socket. Was that contention considered?

Good point on the cost, but in practice the RX path is paused across a
KeyUpdate.
When a KeyUpdate record is decoded, tls_check_pending_rekey() calls
tls_device_rx_del_key() and then sets key_update_pending. All three
record consumers, tls_sw_recvmsg, tls_sw_splice_read, tls_read_sock,
gate tls_rx_one_record() behind tls_rx_rec_wait(), which returns
-EKEYEXPIRED as soon as that flag is set, and tls_sw_poll masks
EPOLLIN. RX stays frozen until userspace installs the new key via
setsockopt, which clears the flag in tls_finish_key_update().
So the del runs exactly once per rekey, and the next KeyUpdate can't
be reached until userspace has acted on the current one. A KeyUpdate
flood can't force a synchronize_net()/tls_dev_del() per record, the
extra records just sit in strp/sk_backlog.
On device_offload_lock: the RX rekey paths take it for read, so
sockets don't contend with each other. Only tls_device_down() takes it
for write, and only on NETDEV_DOWN, a teardown event, not a
steady-state path.

> [Severity: Low]
> Documentation/networking/tls-offload.rst still states that tls_dev_del is
> called "When the offloaded connection is destroyed" and that "The third T=
LS
> device callback is tls_dev_resync".
>
> After this patch tls_dev_del runs on a live connection (from
> tls_check_pending_rekey() and from tls_set_device_offload_rx() before
> re-add), tls_dev_add is called again for the same socket and direction, a=
nd
> there is now a fourth callback. Should that document be updated in the sa=
me
> series so driver authors don't free per-socket state on tls_dev_del?

I'll update the callback-reference section in the documentation.

> > +
> >  static void destroy_record(struct tls_record_info *record)
> >  {
> >       int i;
>
> [ ... ]
>
> > @@ -1093,13 +1181,56 @@ tls_device_reencrypt(struct sock *sk, struct tl=
s_context *tls_ctx)
> >       return err;
> >  }
> >
> > +/*
> > + * Temporarily swap in the old key, run
> > + * tls_device_reencrypt(), then restore the current key.
> > + */
> > +static int tls_device_reencrypt_old_key(struct sock *sk,
> > +                                     struct tls_offload_context_rx *ct=
x,
> > +                                     struct tls_sw_context_rx *sw_ctx,
> > +                                     struct tls_context *tls_ctx)
> > +{
> > +     struct crypto_aead *saved_aead =3D sw_ctx->aead_recv;
> > +     char saved_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
> > +     char saved_rec_seq[TLS_MAX_REC_SEQ_SIZE];
> > +     int ret;
> > +
> > +     memcpy(saved_iv, tls_ctx->rx.iv, sizeof(saved_iv));
> > +     memcpy(saved_rec_seq, tls_ctx->rx.rec_seq, sizeof(saved_rec_seq))=
;
>
> [Severity: Low]
> saved_iv holds the salt plus implicit IV and saved_rec_seq the record
> sequence, and both are left resident on the kernel stack when the functio=
n
> returns through either exit.
>
> The rest of net/tls scrubs equivalent material with memzero_explicit()
> (tls_ctx_free(), tls_sw_ctx_finalize(), tls_device_free_ctx()). Should th=
ese
> two buffers be zeroized before returning?

These buffers hold only the salt/IV and record sequence, no key bytes
(the aead is swapped by pointer). The rec_seq isn't secret, and the IV
bytes remain live in tls_ctx->rx.iv for the rest of the connection
anyway, so zeroizing the transient stack copy doesn't reduce exposure.
The memzero_explicit() sites you cite are all teardown paths scrubbing
the actual key; this is a mid-connection save/restore, so the
situations aren't equivalent.

> > +
> > +     sw_ctx->aead_recv =3D ctx->rekey.old_aead_recv;
> > +     memcpy(tls_ctx->rx.iv, ctx->rekey.old_iv, sizeof(ctx->rekey.old_i=
v));
> > +     memcpy(tls_ctx->rx.rec_seq, ctx->rekey.old_rec_seq,
> > +            sizeof(ctx->rekey.old_rec_seq));
> > +
> > +     ret =3D tls_device_reencrypt(sk, tls_ctx);
> > +
> > +     memcpy(ctx->rekey.old_rec_seq, tls_ctx->rx.rec_seq,
> > +            sizeof(ctx->rekey.old_rec_seq));
> > +
> > +     sw_ctx->aead_recv =3D saved_aead;
> > +     memcpy(tls_ctx->rx.iv, saved_iv, sizeof(saved_iv));
> > +     memcpy(tls_ctx->rx.rec_seq, saved_rec_seq, sizeof(saved_rec_seq))=
;
> > +
> > +     if (ret)
> > +             return ret;
> > +
> > +     tls_bigint_increment(ctx->rekey.old_rec_seq,
> > +                          tls_ctx->prot_info.rec_seq_size);
> > +     ctx->resync_nh_reset =3D 1;
> > +
> > +     return 0;
> > +}
> > +
>
> [ ... ]
>
> > @@ -1109,10 +1240,50 @@ int tls_device_decrypted(struct sock *sk, struc=
t tls_context *tls_ctx)
> >               is_encrypted =3D 0;
> >       }
> >
> > -     trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full=
_len,
> > +     rec_start_seq =3D sw_ctx->strp.copy_mode
> > +             ? copied_seq - rxm->full_len
> > +             : copied_seq;
> > +
> > +     trace_tls_device_decrypted(sk, rec_start_seq,
> >                                  tls_ctx->rx.rec_seq, rxm->full_len,
> >                                  is_encrypted, is_decrypted);
> >
> > +     if (unlikely(ctx->rekey.old_aead_recv)) {
> > +             bool before_nic_boundary =3D
> > +                     before(rec_start_seq, ctx->rekey.old_nic_boundary=
);
> > +
> > +             if (before_nic_boundary) {
>
> [ ... ]
>
> > +                     if (is_encrypted) {
> > +                             tls_bigint_increment(ctx->rekey.old_rec_s=
eq,
> > +                                                  tls_ctx->prot_info.r=
ec_seq_size);
> > +                             return 0;
> > +                     }
> > +
> > +                     /* rekey_fixup sets decrypted flags in case the N=
IC clears
> > +                      * decrypted flags on auth failure
> > +                      */
> > +                     if (!is_decrypted && ctx->rekey.rekey_fixup)
> > +                             ctx->rekey.rekey_fixup(skb);
> > +
> > +                     return tls_device_reencrypt_old_key(sk, ctx,
> > +                                                         sw_ctx, tls_c=
tx);
> > +             }
> > +
> > +             crypto_free_aead(ctx->rekey.old_aead_recv);
> > +             ctx->rekey.old_aead_recv =3D NULL;
> > +
> > +             if (ctx->dev_add_pending)
> > +                     tls_device_deferred_dev_add_rx(sk, tls_ctx, ctx);
> > +     }
> > +
> >       if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags))) {
> >               if (likely(is_encrypted || is_decrypted))
> >                       return is_decrypted;
>
> [ ... ]
>
> > @@ -1643,13 +1814,31 @@ int tls_set_device_offload(struct sock *sk,
> >       return rc;
> >  }
> >
> > -int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx=
)
> > +int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx=
,
> > +                           struct tls_crypto_info *new_crypto_info)
> >  {
> > -     struct tls12_crypto_info_aes_gcm_128 *info;
> > +     struct tls_crypto_info *crypto_info, *src_crypto_info;
> > +     const struct tls_cipher_desc *cipher_desc;
> > +     u32 copied_seq =3D tcp_sk(sk)->copied_seq;
> >       struct tls_offload_context_rx *context;
> >       struct net_device *netdev;
> > +     bool was_dev_add_pending;
> > +     bool moved_aead_recv =3D false;
> >       int rc =3D 0;
> >
> > +     /* Rekey is only supported for connections that are already
> > +      * using HW offload. For SW offload connections, the caller
> > +      * should fall back to tls_set_sw_offload() for rekey.
> > +      */
> > +     if (new_crypto_info && ctx->rx_conf !=3D TLS_HW)
> > +             return -EINVAL;
> > +
> > +     crypto_info =3D &ctx->crypto_recv.info;
> > +     src_crypto_info =3D new_crypto_info ?: crypto_info;
> > +     cipher_desc =3D get_cipher_desc(src_crypto_info->cipher_type);
> > +     if (!cipher_desc || !cipher_desc->offloadable)
> > +             return -EINVAL;
> > +
> >       netdev =3D get_netdev_for_sock(sk);
> >       if (!netdev) {
> >               pr_err_ratelimited("%s: netdev not found\n", __func__);
> > @@ -1675,29 +1864,88 @@ int tls_set_device_offload_rx(struct sock *sk, =
struct tls_context *ctx)
> >               goto release_lock;
> >       }
> >
> > -     context =3D kzalloc_obj(*context);
> > -     if (!context) {
> > -             rc =3D -ENOMEM;
> > -             goto release_lock;
> > +     if (!new_crypto_info) {
> > +             context =3D kzalloc_obj(*context);
> > +             if (!context) {
> > +                     rc =3D -ENOMEM;
> > +                     goto release_lock;
> > +             }
> > +             ctx->priv_ctx_rx =3D context;
> > +     } else {
> > +             context =3D tls_offload_ctx_rx(ctx);
> >       }
> > +     was_dev_add_pending =3D context->dev_add_pending;
> >       context->resync_nh_reset =3D 1;
> >
> > -     ctx->priv_ctx_rx =3D context;
> > -     rc =3D tls_sw_ctx_init(sk, 0, NULL);
> > +     if (new_crypto_info) {
> > +             struct tls_sw_context_rx *sw_ctx =3D tls_sw_ctx_rx(ctx);
> > +
> > +             if (!test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
> > +                     set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
> > +                     synchronize_net();
> > +                     netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> > +                                                     TLS_OFFLOAD_CTX_D=
IR_RX);
> > +             }
>
> [Severity: Medium]
> netdev here comes from get_netdev_for_sock(sk), which resolves
> __sk_dst_get(sk) -> netdev_sk_get_lowest_dev(), not from
> rcu_dereference_protected(ctx->netdev).
>
> For an already-offloaded socket those can differ after a route change or =
a
> bond/team failover, and tls_device_attach() is deliberately skipped on th=
e
> rekey path, so ctx->netdev is never updated and no reference is taken for=
 the
> device that ends up holding the HW context.
>
> Can this call tls_dev_del() on a device that never held this socket's
> context? mlx5e_ktls_del_rx() does priv =3D netdev_priv(netdev) and then
> mlx5_ktls_destroy_key(priv->tls->dek_pool, priv_rx->dek) using the priv_r=
x
> that a different device stored in ctx->driver_state.
>
> And if the following tls_device_dev_add_rx() then succeeds on that other
> device, is the context ever released? tls_device_offload_cleanup_rx() doe=
s
> "if (!netdev) goto out;" on ctx->netdev and tls_device_down() matches
> contexts by ctx->netdev.
>
> Both tls_device_rx_del_key() and tls_device_deferred_dev_add_rx() use
> rcu_dereference_protected(ctx->netdev) - should this path use the same
> source?

I'll resolve the device from ctx->netdev under device_offload_lock on
the rekey path.

> > +
> > +             if (context->rekey.old_aead_recv &&
> > +                 before(copied_seq, context->rekey.old_nic_boundary)) =
{
>
> [ ... ]
>
> > +                     context->dev_add_pending =3D 1;
> > +             } else {
> > +                     u32 rcv_nxt;
> > +
> > +                     if (context->rekey.old_aead_recv) {
> > +                             crypto_free_aead(context->rekey.old_aead_=
recv);
> > +                             context->rekey.old_aead_recv =3D NULL;
> > +                     }
> > +
> > +                     /* flush the backlog so rcv_nxt is accurate */
> > +                     __sk_flush_backlog(sk);
> > +                     rcv_nxt =3D tcp_sk(sk)->rcv_nxt;
> > +
> > +                     if (before(copied_seq, rcv_nxt)) {
>
> [Severity: Medium]
> This else branch frees rekey.old_aead_recv and sets it to NULL, and only =
sets
> dev_add_pending inside "if (before(copied_seq, rcv_nxt))".
>
> If a previous rekey already left dev_add_pending =3D=3D 1 and there is no=
 queued
> data now, doesn't the function continue with dev_add_pending =3D=3D 1 and
> old_aead_recv =3D=3D NULL? "if (!context->dev_add_pending)" below then sk=
ips
> tls_device_dev_add_rx(), and the deferred completion is only reachable fr=
om
> inside the old-key block of tls_device_decrypted():
>
>         if (unlikely(ctx->rekey.old_aead_recv)) {
>                 ...
>                 if (ctx->dev_add_pending)
>                         tls_device_deferred_dev_add_rx(sk, tls_ctx, ctx);
>         }
>
> Is the NIC RX key then never re-installed for the rest of the socket's
> lifetime, with TLS_RX_DEV_CLOSED left set, TLSRXREKEYOK counted anyway an=
d
> TLSRXREKEYINPROGRESS elevated until close? Should this branch also clear
> dev_add_pending?
>
> The sequence looks reachable from peer timing alone: the first rekey with
> queued data sets old_nic_boundary =3D rcv_nxt and dev_add_pending =3D 1, =
the
> record straddling the boundary is classified by its start so it takes the
> reencrypt path without running the deferred add, and if that record carri=
es
> the next KeyUpdate the second rekey lands in this else branch.

I'll fix this issue.

> > +                             context->rekey.old_aead_recv =3D sw_ctx->=
aead_recv;
> > +                             sw_ctx->aead_recv =3D NULL;
> > +                             moved_aead_recv =3D true;
> > +                             memcpy(context->rekey.old_iv, ctx->rx.iv,
> > +                                    sizeof(context->rekey.old_iv));
> > +                             memcpy(context->rekey.old_rec_seq, ctx->r=
x.rec_seq,
> > +                                    sizeof(context->rekey.old_rec_seq)=
);
> > +                             context->rekey.old_nic_boundary =3D rcv_n=
xt;
> > +                             context->rekey.rekey_fixup =3D
> > +                                     netdev->tlsdev_ops->tls_dev_rx_re=
key_fixup;
>
> [Severity: High]
> This caches a driver function pointer, whose text lifetime is tied to the
> driver module, into state that outlives the netdev reference.
> tls_device_down() drops that reference without clearing it:
>
>                 rcu_assign_pointer(ctx->netdev, NULL);
>                 set_bit(TLS_RX_DEV_DEGRADED, &ctx->flags);
>                 synchronize_net();
>                 ...
>                 dev_put(netdev);
>
> rx_conf stays TLS_HW, so tls_device_decrypted() keeps running for records
> already queued and calls ctx->rekey.rekey_fixup(skb) inside the
> "if (unlikely(ctx->rekey.old_aead_recv))" block, which is before the
> TLS_RX_DEV_DEGRADED bail-out.
>
> If the driver module is unloaded while an RX rekey drain is still pending
> (rmmod -> unregister_netdevice -> NETDEV_DOWN -> tls_device_down()), does
> this indirect call land in freed module text? Should the pointer be clear=
ed
> when the netdev goes away, or fetched from ctx->netdev at call time inste=
ad?

I'll remove rekey_fixup.

> > +                             context->dev_add_pending =3D 1;
> > +                     }
> > +             }
> > +     }
> > +
> > +     rc =3D tls_sw_ctx_init(sk, 0, new_crypto_info);
> >       if (rc)
> >               goto release_ctx;
>
> [Severity: Medium]
> On the rekey path tls_dev_del(RX) has already run above, but this is the =
step
> that can still fail: when the old AEAD was moved into rekey.old_aead_recv=
,
> sw_ctx->aead_recv is NULL, so tls_sw_ctx_init() calls crypto_alloc_aead()=
,
> which can fail with -ENOMEM (setauthsize/setkey can fail too).
>
> The release_ctx path restores dev_add_pending and the old AEAD but perfor=
ms
> no hardware rollback, while mlx5e_ktls_del_rx() has already destroyed the
> steering rule, the TIR and the DEK:
>
>         if (priv_rx->rule.rule)
>                 mlx5e_accel_fs_del_sk(priv_rx->rule.rule);
>         mlx5e_tir_destroy(&priv_rx->tir);
>         mlx5_ktls_destroy_key(priv->tls->dek_pool, priv_rx->dek);
>
> Does the socket then lose RX offload permanently while setsockopt returns=
 an
> error implying nothing changed? TLS_RX_DEV_CLOSED stays set, so later
> tls_device_rx_del_key(), tls_device_offload_cleanup_rx() and
> tls_device_down() all short-circuit and nothing calls tls_dev_add() again=
,
> and no TLSRXREKEYFALLBACK is accounted. Would doing the teardown after th=
e
> last failable software step, or re-adding on this error path, work better=
?

You're right that tls_sw_ctx_init() can fail here after
tls_dev_del(RX) has run, and that release_ctx does no HW rollback. But
this is intentional, not a leak, the socket cannot survive a failed RX
rekey, so there is nothing to roll back to.

By the time RX rekey runs, the peer's TX has already switched keys
(KeyUpdate is directional, TX/RX are separate setsockopt calls). If RX
fails, the new key is installed nowhere, the failure path restores
only the old SW key, so no further records can be decrypted and the
app must close the socket. Re-adding HW or reordering the teardown
would only buy honest "nothing changed" semantics for a connection
that is already dead.

The half-torn state is reclaimed cleanly on close by
tls_device_offload_cleanup_rx().

No leak, no double-free. Accounting is also failure-safe: every rekey
gauge update (TLSCURRRXREKEY, and the retired_pending block) runs only
after a successful tls_sw_ctx_init(), past the release_ctx goto, so a
failing init needs no counter undo. There's no TLSRXREKEYFALLBACK
because this is a hard failure, not a silent fallback to SW.

> >
> > -     rc =3D netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CT=
X_DIR_RX,
> > -                                          &ctx->crypto_recv.info,
> > -                                          tcp_sk(sk)->copied_seq);
> > -     info =3D (void *)&ctx->crypto_recv.info;
> > -     trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
> > -                                  tcp_sk(sk)->copied_seq, info->rec_se=
q, rc);
> > -     if (rc)
> > -             goto free_sw_resources;
> > +     if (!context->dev_add_pending) {
> > +             rc =3D tls_device_dev_add_rx(sk, ctx, netdev, src_crypto_=
info,
> > +                                        copied_seq, !!new_crypto_info)=
;
> > +             if (!new_crypto_info) {
> > +                     if (rc)
> > +                             goto free_sw_resources;
> > +                     tls_device_attach(ctx, sk, netdev);
> > +             }
> > +     } else if (!was_dev_add_pending) {
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRES=
S);
> > +     } else {
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
> > +     }
> > +
> > +     tls_sw_ctx_finalize(sk, 0, new_crypto_info);
> >
> > -     tls_device_attach(ctx, sk, netdev);
> > -     tls_sw_ctx_finalize(sk, 0, NULL);
> >       up_read(&device_offload_lock);
> >
> >       dev_put(netdev);
> > @@ -1709,7 +1957,18 @@ int tls_set_device_offload_rx(struct sock *sk, s=
truct tls_context *ctx)
> >       tls_sw_free_resources_rx(sk);
> >       down_read(&device_offload_lock);
> >  release_ctx:
> > -     ctx->priv_ctx_rx =3D NULL;
> > +     if (!new_crypto_info) {
> > +             ctx->priv_ctx_rx =3D NULL;
> > +     } else {
> > +             context->dev_add_pending =3D was_dev_add_pending;
> > +             if (moved_aead_recv) {
> > +                     struct tls_sw_context_rx *sw_ctx =3D tls_sw_ctx_r=
x(ctx);
> > +
> > +                     crypto_free_aead(sw_ctx->aead_recv);
> > +                     sw_ctx->aead_recv =3D context->rekey.old_aead_rec=
v;
> > +                     context->rekey.old_aead_recv =3D NULL;
> > +             }
> > +     }
> >  release_lock:
> >       up_read(&device_offload_lock);
> >  release_netdev:
>
> [ ... ]
>
> > diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
> > index adca8561c7da..ae2322481c71 100644
> > --- a/net/tls/tls_proc.c
> > +++ b/net/tls/tls_proc.c
> > @@ -28,8 +28,11 @@ static const struct snmp_mib tls_mib_list[] =3D {
> >       SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
> >       SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED)=
,
> >       SNMP_MIB_ITEM("TlsTxRekeyFallback", LINUX_MIB_TLSTXREKEYFALLBACK)=
,
> > +     SNMP_MIB_ITEM("TlsRxRekeyFallback", LINUX_MIB_TLSRXREKEYFALLBACK)=
,
> >       SNMP_MIB_ITEM("TlsTxRekeyInProgress", LINUX_MIB_TLSTXREKEYINPROGR=
ESS),
> > +     SNMP_MIB_ITEM("TlsRxRekeyInProgress", LINUX_MIB_TLSRXREKEYINPROGR=
ESS),
> >       SNMP_MIB_ITEM("TlsTxRekeyAborted", LINUX_MIB_TLSTXREKEYABORTED),
> > +     SNMP_MIB_ITEM("TlsRxRekeyAborted", LINUX_MIB_TLSRXREKEYABORTED),
> >  };
>
> [Severity: Low]
> These three names become visible in /proc/net/tls_stat, but the "Statisti=
cs"
> section of Documentation/networking/tls.rst, which enumerates every field=
 of
> that file, still ends at TlsRxRekeyReceived. Could the new counters be
> documented there, including when TlsRxRekeyAborted and TlsRxRekeyFallback
> increment? The TX-side siblings added earlier in this series are missing =
from
> that list as well.

I'll fix this.

> >
> >  static int tls_statistics_seq_show(struct seq_file *seq, void *v)
>
> [ ... ]
>
> Cross-instance finding from sashiko-gemini (af143e51c70a6781742cb38aa4415=
3feb2fdbfb052af92dccb83139af70282d4):
> [Severity: High]
> Single-packet records bypass XOR-undo logic during KeyUpdate.

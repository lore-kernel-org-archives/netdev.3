Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F538B14F
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785549412; cv=pass; b=UOv9+/S72wTOneNzPrgqtklM/sMbBTIT6bTOQkXKpxlJ+Yp2OxDG+LLd8o84GZCk5aQ7fLPHx1wkbnTO550I7yEqFNAJRV4l7Lr98HK4P3Ucjo4iWUVqCpAoJb9WtC5RsoHIaSZTr7P24HecaAhListSq0PMqzljnhF/2ArGg1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785549412; c=relaxed/simple;
	bh=Cuy+ATXD/7LsKqNwVBhmSbzluquUF9Jy5UJIsCf5RmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INidRSkEGHG/ayTAzIDLlpiWZ5xUhx/Mj/PdecpVceVZ1H/UuZYyTs6KUGkO8UVt54zbVVuMExO9FK/tXTzXVLT/FszU4Fqm3Z7mhQJrWECmVGTgMh8+A0dzb8k/+nvQSv9XWHDmg6nX78GaRT9qxKk/2gFxadYcSkn1VQ3jOak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxog0e9K; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxog0e9K"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84864086bfeso1803839b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 18:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785549410; cv=none;
        d=google.com; s=arc-20260327;
        b=R+tqD/NEso5uFc/qskQkAioHG02NphrqjpTRoDgyO1UjZghfsgU2zArmgK7a2yW1ni
         G+JdMJs6NY4eW3lBWRZoREFcEDuBTJx03DNNUulwmkBgBZ06fQoC2w13N/bjU0Kr7/f8
         F3Gkm5pUx9JoLKo6ss/nokqY0lL83fR9GAiIMyfluzKmb7JKhUgTN/z+O/QjvMhSpQJB
         0pK09PepNVlVNyAKazHSDyvxdTh8ltP07jtwAKiBWDxYsSNvjKSnKuOHGlcvQZc/zZph
         0jEArsnPtJiZ39pKHrE7qpznxGf1hkChIICUzThnY2/lPPGSe7pgXXocAev6TomByQGI
         TUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XDk1j5u96BEbQkY+NvqlgkFtQLDQ28w5D6GMuTe7Mko=;
        fh=oLJUBoLeaCOIW1r707ZKh7+DNyVjyd8Nzfhd3TPyZMo=;
        b=BuHWYHf/bNr3cfkOYZEIXQwZ/1GzbBh6ZFKxxOOh0fp1xG+nRC2lhRiMNzJORORIwa
         59lebwgfEaaljgsX+YP+wVMVWdasKMZajUiDtx7tsbD+2uoFf9EuoE4QDF+zwqrvyXII
         2GeYEuLiJXAzVE2po67FBOKigU5Vvd26PZIpif+DneCUvsI6yPrLxpF6hYop6prpBW8T
         hwDPewhlCD+6F99YP51ZX1sGUHQ3tQh3qLbAhqRDfy0sHGVVWy5/hzABarX3ROOu8nTK
         dmmIt116uN1doKrEBbK2VkrmpBoCXaixCFNDrET0doFowa9Kyg6TEtvZvSMTUjbU2V/Q
         cS1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785549410; x=1786154210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDk1j5u96BEbQkY+NvqlgkFtQLDQ28w5D6GMuTe7Mko=;
        b=Kxog0e9KWHPKTo8vXsisr1iIfqCjxzdlPPgYOqLMhBqNkS/hCo7o0LzP1CEZpWvRYn
         jvnToSC7TUayhvGtMqNmF8p8LbANIpJZ5qaVC2yoZx70njJ8MkQnNLmwsbsCFx0CMgsu
         FqHqQXlpHucjUMLkiB0GHU611Df0zG/TMrY3KRfbGTxlXUWmA2mKy/IbYJMDzXMnc57F
         znne7URXuML+9rO4U1IsoNrgJgLYCjF+jUFZsyklvR5iGbMmin/ZdJ3ItN/C3pRcB5dT
         NSuxrhY3PhHlqyZm8x0XNl7zCZj2WnMSlYirUl9lx3zx8HY5kLfxxZrQ8SRvKiHKtjyu
         NIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785549410; x=1786154210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDk1j5u96BEbQkY+NvqlgkFtQLDQ28w5D6GMuTe7Mko=;
        b=LjPpza/78BJrzOiPFVpsgs9QpfEzcZVBPu9jbUw8I/dI02CmqPp7gQwZrzJgETU0Oy
         bTePu6CYVUYQneS3n5MzGHOPvArOQM9tTKohOSmWeV5RftaxK7UpJDAYIpZt+hOnDmcE
         BJSp9c4ObdVdPd25VzxTsiEVXeMwAZXNNKemTpNsiXSFpPIN0LA4lumhKOKWRXOz14P8
         jPVF9oUTl+lfQXjn80oVz0KFXGE6EpizvoUJskx8S03tz+iVCsZPc8QPpE0boQ+Bifj4
         d5YSBPZDAamJQ/UxDJfB55Et2F3TyjZeALoJBGEwaxgTashgXaA0jA694p/Vb4WlFDpd
         Jyfg==
X-Gm-Message-State: AOJu0Yx9byv0lh88B5bcSJnkgjKKvGjOVX+QW28m1UfU57ycPINl3tFT
	buc1musH4KUzFSj/lnE/JXHAW+TwVGHIQa6r/dSCseso8S/DrcAw7dbwJrcxIiKY/5GOGt6JGy9
	dbjxIuRrR1WXrnXbQ913GC9xAXInkn1M=
X-Gm-Gg: AR+sD10mFHw4FEnztKA8jhHOY/4g6t2XK3oKtfG47U+KzrxxQYoxn1oPs8b1BRo0gH7
	gerrIBICNHYUiy/Q5scAiRNJsKFRcPkcGpH4a9OqyZtJ96zvrVw5Sj+vfltEgMQ3/DK1ZvUHDQQ
	1QAJuKemGAyOit4m04Yfx1nSXi1XTWoiGwzFmUou6omUDMMfU8O1b13Jsm3YC4vpQV0oU0wpGim
	kF5osC0VcrCVDinC5Tdw4c876H1KeUAjQbNunvPCukjIGIJfLoLvsn6k4V0471kOGynLdcnPFSW
	wcR0VyiEQxYkCRg86oKKezQrKizuZNpxU5VUUqr2eIYce3sUN69Fw4fyQszyshIbTNCd3i9Mi9e
	s5eiczs49QtLU63sCuU610tBI6ait1UMFzTgtpSDm8+ULHEbzE6+LiJA=
X-Received: by 2002:a05:6a00:9296:b0:848:2c6c:dfe3 with SMTP id
 d2e1a72fcca58-84ee47e6a57mr1561877b3a.17.1785549410080; Fri, 31 Jul 2026
 18:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730090537.27629-1-juny24602@gmail.com>
In-Reply-To: <20260730090537.27629-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 31 Jul 2026 21:56:38 -0400
X-Gm-Features: AUfX_mz8_lhPM3hKRVtFzdmE3NAwfT-wPZABXbnOKXlRfkDZPzedSphHheHJx8g
Message-ID: <CADvbK_cucNJp9pDs94o4BDAH4hi-Jtpk_k5i-thSW4XhVZQgFQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: re-point retained control chunks on association migration
To: Jun Yang <juny24602@gmail.com>
Cc: netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>, stable@kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:05=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrot=
e:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_control_set_owner_w() records the owning socket in a control chunk's
> skb->sk as a bare pointer.  sctp_sock_migrate() re-owns the association's
> DATA chunks via sctp_for_each_tx_datachunk(), but that walk keys off
> chunk->msg and so skips control chunks: any control chunk the association
> still holds (for example the saved stream-reset request
> asoc->strreset_chunk, the ASCONF request/ack lists, or
> asoc->addip_last_asconf) keeps pointing at the old socket after the
> association is moved to the new one.
>
> Once the old socket is freed, a later retransmit reaches
> sctp_packet_transmit() -> skb_set_owner_w(head, chunk->skb->sk) and
> operates on the freed socket -- refcount_add() on its sk_wmem_alloc,
> then sk->sk_write_space() from sock_wfree() -- a use-after-free of
> struct sock.
>
> Re-point every control chunk the association still holds at the new
> socket right after sctp_assoc_migrate(), as is already done for DATA
> chunks.  Control chunks carry no socket wmem charge and their skb
> destructor does not use skb->sk, so a bare owner update is sufficient.
>
> Fixes: d04adf1b3551 ("sctp: reset owner sk for data chunks on out queues =
when migrating a sock")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
>  net/sctp/socket.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index c7b9e325ec1c..9a6da4e0d741 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -9522,6 +9522,30 @@ static void sctp_skb_set_owner_r_frag(struct sk_bu=
ff *skb, struct sock *sk)
>         sctp_skb_set_owner_r(skb, sk);
>  }
>
> +/* Control chunks record their owning socket in skb->sk as a bare pointe=
r and
> + * are not reached by sctp_for_each_tx_datachunk(); re-point the ones th=
e
> + * association still holds so migration does not leave them on the old s=
ocket.
> + */
> +static void sctp_ctrl_set_owner_w(struct sctp_chunk *chunk, struct sock =
*sk)
> +{
> +       if (chunk && chunk->skb)
> +               chunk->skb->sk =3D sk;
> +}
> +
> +static void sctp_for_each_tx_ctrlchunk(struct sctp_association *assoc, s=
truct sock *sk)
> +{
> +       struct sctp_chunk *chunk;
> +
> +       list_for_each_entry(chunk, &assoc->outqueue.control_chunk_list, l=
ist)
> +               sctp_ctrl_set_owner_w(chunk, sk);
> +       list_for_each_entry(chunk, &assoc->asconf_ack_list, transmitted_l=
ist)
> +               sctp_ctrl_set_owner_w(chunk, sk);
> +       list_for_each_entry(chunk, &assoc->addip_chunk_list, list)
> +               sctp_ctrl_set_owner_w(chunk, sk);
> +       sctp_ctrl_set_owner_w(assoc->strreset_chunk, sk);
> +       sctp_ctrl_set_owner_w(assoc->addip_last_asconf, sk);
> +}
> +
>  /* Populate the fields of the newsk from the oldsk and migrate the assoc
>   * and its messages to the newsk.
>   */
> @@ -9633,6 +9657,7 @@ static int sctp_sock_migrate(struct sock *oldsk, st=
ruct sock *newsk,
>         sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
>         sctp_assoc_migrate(assoc, newsk);
>         sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
> +       sctp_for_each_tx_ctrlchunk(assoc, newsk);
>
>         /* If the association on the newsk is already closed before accep=
t()
>          * is called, set RCV_SHUTDOWN flag.
> --
> 2.55.0
>

Can you rename sctp_for_each_tx_datachunk() to sctp_for_each_tx_chunk() and
move the control chunk traversal there?

        list_for_each_entry(chunk, &q->control_chunk_list, list)
                cb(chunk);

        list_for_each_entry(chunk, &asoc->asconf_ack_list, transmitted_list=
)
                cb(chunk);

        list_for_each_entry(chunk, &asoc->addip_chunk_list, list)
                cb(chunk);

        if (asoc->strreset_chunk)
                cb(asoc->strreset_chunk);

        if (asoc->addip_last_asconf)
                cb(asoc->addip_last_asconf);

The in-progress patch:

https://lore.kernel.org/netdev/20260731120558.558957-1-david.lee@trailofbit=
s.com/

will use sctp_set_owner_w_migrate() as the callback for
sctp_for_each_tx_datachunk(). Based on that, you can simply handle control
chunks (msg is NULL) in sctp_set_owner_w_migrate():

        if (chunk->msg)
                sctp_set_owner_w(chunk);
        else
                sctp_control_set_owner_w(chunk);

This avoids introducing additional helpers such as
sctp_for_each_tx_ctrlchunk() and sctp_ctrl_set_owner_w().

Thanks.

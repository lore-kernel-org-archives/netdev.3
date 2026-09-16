Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337494D7D22
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579948; cv=pass; b=HkDRMcSIVVFaCiOOqQ9kE8yW4NouwBxeQxuq5ZsEa4Hz1Hi7YYI0kyVM4wPZkM9VKYpxF6ZwjqZlDz9d9/96OGMrWudWUp7xAH3g5XENO6NLZZZEHgoVAsfrUKTlbQO+PuLkSSAHXAQvNCdPkv4XUvFyn9tmz70r8Vvi4tQARGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579948; c=relaxed/simple;
	bh=NUBEn2ewfapMUSRyiZ8+UFVtbPRYiNtKkPu80m0YBks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODHXxtW+cAk09FMB4Dw1j0OQ9uJmSzsL+FNaTEz5x3fKHo31zwANvsTmkpDi21rz5tiIFtL5MnDgJuoFbRoDLQAreVbep8XsSE6tKJhNeKnLsSYCO6d9rewGi/5RIU70gPAPWQlsvsaFN1uiehCUn5JLOVZmDHK+DiIpOJ9dsUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AajnptG9; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AajnptG9"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-5309a20a55bso9593811cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789579927; cv=none;
        d=google.com; s=arc-20260327;
        b=KpQY7eE0wOJpwAL7XwCVJbuws9UG36rn214hFeTa8Vl5WCusjkD6E0C6w0bjYcFBk/
         Rtb61QhWvX4FQ3moNAy9M+PCqtM2HxLEIHatmqFEfA68/v5m+iTm92Q//IJVHh6yHl+G
         US6nIoRPJ+zbqXsguNdSgNBPu4030/VwaBaT4mmJOqm2OYeV6Yt8R4dxfd9WK8+a5GpC
         y4hE+OR1ZgJr7G9SLJgZcjrXCGAemGFYjUYCIjaCgCHSGTyryytybT5RG/8wsKQGOtqZ
         T7aGOfcHVzWtSL96o8bkMuVISOyo2fInozopOmJqaHm0WTnAl6zzfjdVC3gDPPZgC+Kt
         GhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NUBEn2ewfapMUSRyiZ8+UFVtbPRYiNtKkPu80m0YBks=;
        fh=oZz5lmj7cApYr7DJxXRFmyznJI5ve6xBU9AA1ylJ1YY=;
        b=cVZC1765N4zOS1uxJgILBdn2tHeLnGy4baLxAHwKy8UjviU2I7NOfTj9/momNezEWk
         5nWcq6ATtE8oDtbSpCUJ4agt31Imjs9l23L2cZb+FTFtN8PLhaovjrM1ci4pvLodJkym
         G0V77YVmpCE4SlNNVxKwvKHVZbsPFNpO5013YbyQtUK1FrYR9NvrGlDjkFnYncBEjZ3W
         mYsTBw6x2toRFk4R5GAM95fJEmazX7GxH6AO8Fwx6UY+1qp+sMX2uctFLRnQdDDnXKLo
         Aw7icX8fRLeLoJTdMoiHF8lKsZIiMoMpy7/a1eGIaBhjq+d5iY8oUyaNzuc9S9eF3isD
         j2rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789579927; x=1790184727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUBEn2ewfapMUSRyiZ8+UFVtbPRYiNtKkPu80m0YBks=;
        b=AajnptG9XOpPfosDWXfaysJlijrJF30K0sDo3mN3E1WXEBNmyFgsNWFNy28x5Byprh
         KjGXVQQcO4z9Te1pSwgyDCFC7mq9th/lzWpaLXgqfnHuHC+Ims7Qo4Vk+PfDwIpLyXUz
         DGK2F1gwT0MazSDxF/dZZ165Wk+ahxyf3OIDoJ0esCsDV5tv9OaDcecU6hG2v/SahHos
         XqNbhFv5Z4ar9sQ3PcAH2gxq6gPif8n4e8m9PE8hZ22oe2M6xqr9kQFQGswCaKiXQGrB
         VWAjDTYEXpqaPT0eG+SAQkY9uItkS6VHXixxNXqj9OZ/U7CzQAascOA4eDEB9eN8eLDY
         dyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789579927; x=1790184727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUBEn2ewfapMUSRyiZ8+UFVtbPRYiNtKkPu80m0YBks=;
        b=yZJ5eRnlNLcpeSVBBmW/Wi9Kqd7r+Atj4hsfQoYTocYcPKVYFMkxd6S5zKOReCvtkv
         subiKY0t0K4l5IVsvODuBGuWj4bdsRnO3Rj0DwyvpB7fX9vA4SnLAIz9vbei0Uh39rue
         wanwAl8j/L9MBph7DEiAkPiu0AinhR5YtqbwNJZWn6W7QoLBUvUvoa+Oa56PoD4YYZpc
         OANpqkLcTLjwCpwlbSzTGYMYoS9dZv62rE32AFqDqThWy6xS7uF4Mjidh3a8+Rh9kbKO
         YOHMYr5GQb2z07gytMrAgZhVs8cVFbM8nyiTJbACFu+mb1iXpEhNsq9zqHG4c+HP057/
         imkw==
X-Gm-Message-State: AFuF++n6wrsoxPDh7GqCtfUDDSx8hN/NZA1UA69S8J8NcLI8W/DWRWqj
	Pcvn9beXGgZeda+zjlml+9C+lDK+QIOSUhPAk/8LJ7hsChsoKaY9vIKz1uLjJEeehdlxPKKdip8
	JdiOsvTNiyBhc4SNLSChEcUBXi4CrzxLgkG+5K08l
X-Gm-Gg: AYBFou3g0xphR+JLLFZ8rXyHC9vrggZvWkiXx3SbVhxjYGvBkjTZC6IlNKyvgU7gB44
	ZU8ERgso2Ifmy8AdE2Yu8dsN/808RM9kE4nOX/3m6xqbAcnINZqZGaT4eRQzpUkrU1MQH6H0GvH
	CHrSh9TxA/Wa2h5hZvRJa0R44HIrDa1mJkFdy7+8yGxFbJFfU9YnoIkpp0jZ/b4cyLURzVimkQ2
	MnEsklRa6YKC5If7ASkQUse9kRV6wTyEOS7Rm/PcXAeByVqhitLT7nmnqaF7Vihf5lt5XAq4cRH
	X1+dbV7BWgmmS6z0ngvQQ1NmDuU3EjoiN5ziDxLCEJ2YWRWT27bj0ziUhzz+FUXRlQostFTT0z3
	Va29Q2PqhX8LWHQ0TVL2o5MiOCnr4pvxiQmOgXjJeN1WHNHl2leOdYZV79NgDw6M1pWfCtcHQN2
	IrAcusPBYJHk7aUZ/601SVKg==
X-Received: by 2002:ac8:5d90:0:b0:530:ff53:d7ef with SMTP id
 d75a77b69052e-5327ee76cdfmr68253051cf.27.1789579925988; Wed, 16 Sep 2026
 10:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915214450.2882680-1-dw@davidwei.uk> <CANn89iLkkiXvjWzH=_iGNV-_n8aAUSiCVuwy1VPYb6BKZO-rew@mail.gmail.com>
 <5eaa3be7-1615-4f8b-81e1-449db0e986ef@davidwei.uk>
In-Reply-To: <5eaa3be7-1615-4f8b-81e1-449db0e986ef@davidwei.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Sep 2026 10:31:54 -0700
X-Gm-Features: AcwNN1X_7mHU5YXIZ5pn0quMLcwtlGeyDzo-Bzf9i6kUGl6vnHFc7i1Qe3zsNPU
Message-ID: <CANn89i+f47sHVMtxF5dJwc-RKZbpquJkH=9x09cUCsWMW5XOug@mail.gmail.com>
Subject: Re: [PATCH net] tcp: initialize skb tx timestamp key before cloning
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 10:23=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> On 2026-09-15 15:21, Eric Dumazet wrote:
> > On Tue, Sep 15, 2026 at 2:44=E2=80=AFPM David Wei <dw@davidwei.uk> wrot=
e:
> >>
> >> tcp_tx_timestamp() can select skbs from the rtx queue when all the
> >> copied data has been sent in tcp_sendmsg_locked(). These skbs may be
> >> already cloned, sharing the same shinfo, and handed off into the lower
> >> tx layers.
> >>
> >> tcp_tx_timestamp() sets tx_flags before setting skb tskey, racing with
> >> any reader of both. It is possible to observe a valid tx_flag, but an
> >> uninitialized tskey, which produces a large underflow after subtractin=
g
> >> the socket tskey.
> >>
> >> Initialize skb tskey just before cloning while its shinfo is still
> >> private. In tcp_tx_timestamp(), if it selects a cloned skb from the rt=
x
> >> queue from the current tcp_sendmsg_locked() call (i.e. tx_flags and
> >> txstamp_ack are 0) and the pre-init skb tskey matches, then tx_flags c=
an
> >> be set safely.
> >>
> >> If the skb is not shared, coming from the write queue, then both tskey
> >> and tx_flags are set, as before.
> >>
> >> Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx que=
ue")
> >> Assisted-by: LLM
> >> Signed-off-by: David Wei <dw@davidwei.uk>
> >
> > pw-bot: cr
> >
> > Sorry, this patch significantly hurts TCP performance and has many bugs=
.
> >
> > I am sure your LLM can find a cheaper solution if you ask it to try har=
der.
>
> This wasn't a yolo patch straight from an LLM, I tried quite hard to
> reason with the bug and possible solutions. Maybe that's the problem -
> the LLM is actually smarter than me :)
>
> >
> > Some hints if needed:
> >
> > First idea:
> >
> > 1) In tcp_tx_timestamp():
> >
> > Keep shinfo / tcb accesses inside if (unlikely(tsflags)) so normal
> > traffic pays zero cost.
> > When falling back to skb =3D skb_rb_last(&sk->tcp_rtx_queue):
> > Verify TCP_SKB_CB(skb)->end_seq =3D=3D tp->write_seq and
> > !tcp_has_tx_tstamp(skb). If either fails, do not touch skb.
> > Always write shinfo->tskey before sock_tx_timestamp(sk, sockc,
> > &shinfo->tx_flags) (and do the same in
> > bpf_sock_ops_enable_tx_tstamp()).
> > If pre-initializing shinfo->tskey in __tcp_transmit_skb() before
> > skb_clone(oskb, gfp_mask) (which already dirties shinfo->dataref in
> > the same cache line), guard it with !tcp_has_tx_tstamp(oskb) and use
> > TCP_SKB_CB(oskb)->end_seq - 1 (or seq + len - 1), without the bogus if
> > (shinfo->tskey !=3D tskey) check in tcp_tx_timestamp().
> >
> > 2) In tcp_sendmsg_locked() (to preserve TX_SCHED / TX_SOFTWARE /
> > TX_HARDWARE on non-blocking partial sends):
> >
> > Before calling tcp_push_one() / __tcp_push_pending_frames() at the end
> > of the loop (when skb->len >=3D size_goal), check if
> > (!sk_stream_memory_free(sk)) goto wait_for_space;.
> > At wait_for_space:, only call tcp_push() if timeo !=3D 0 (since when
> > !timeo, sk_stream_wait_memory() immediately returns -EAGAIN and out:
> > will run tcp_tx_timestamp() before tcp_push()).
> >
> > Second idea:
> >
> > We can solve this cleanly and minimally by:
> >
> > Reordering the writes in tcp_tx_timestamp() (and
> > bpf_sock_ops_enable_tx_tstamp()) so shinfo->tskey is written first via
> > WRITE_ONCE(), followed by publishing shinfo->tx_flags via
> > smp_store_release() in __sock_tx_timestamp().
>
> I did think about this solution. I still don't fully grasp the memory
> model and how READ/WRITE_ONCE and acquire-release works, so I wasn't
> entirely sure if it was sufficient.
>
> There could be situations where the skb is pushed early, and the lower
> layers copy the shinfo e.g. GSO and COW. I don't have experience with
> this code, so I find it hard to evaluate plausible paths that LLMs
> suggest.
>
> That's why I opted for the pre-set tskey before clone approach in this
> RFC. I didn't think this would affect perf that badly, but yeah it is a
> really hot function.
>
> I believe I can make the GSO path work with acquire-release. For COW, do
> you think it is actually relevant?

I am traveling today back to France, I will answer to your email in
~24 hours or so.

Thanks.

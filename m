Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C1550DA1
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082806; cv=pass; b=ZE0TilfgiL/eK3zjkbBtxWhKymz9CUeb6CqzStXUCvFmU5058wa8p02gw8ra8dk5kZbekWIrZlv+xjYdcqZzA+mh+AplLDxXmpW2nTxV8rlIU/8YKm5B+uYuutDwkH0N1nQFP70m/cgwQrIqz+TMEcV/xnFNnQAw+Lhs+HtR/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082806; c=relaxed/simple;
	bh=inGt7PUIBCSA5jlLsHiRgO+zeea4owkWaXIEd1vTJRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qB0p/J6Wo34LrEMyb6Bq4qE0PKAAnPnBoMI9T+i8r16NYvExdLytU1y4178nyBYWsQkorxzbWqmc7q+JNWYQqy7SqsXHWVGny9A7UG7rB5m1PxP5yfOX/8F0Kn4FcIbZ5uxsq41xshTFdZtztPYIcKPBF75N0lNHWKu1RtSXla4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCkAa68p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCaFalCC; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCkAa68p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCaFalCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790082801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9I33pkuDN4IfZkeNMg1Yvv3ErOrI5+WYWqPcorUJCE=;
	b=cCkAa68pfb3wWshn9ZmcYr0s67DUv7Nef+///8N/Yz5XTMBJwbbilSZ+IpN1RunYIwPRJ2
	SQXw4HBLx9tk4Dr893d8XXEok65qAF1sEsrFm/8KKBR5nd+yivJOfIAsyiUJ7SAuaPjBjk
	4BKIPlrFe5dO3/F2NkCViaeRnZ17QOU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-1QdLzwIKM6uDADeNX2poCw-1; Tue, 22 Sep 2026 09:13:20 -0400
X-MC-Unique: 1QdLzwIKM6uDADeNX2poCw-1
X-Mimecast-MFC-AGG-ID: 1QdLzwIKM6uDADeNX2poCw_1790082799
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a49dccdb24so18349801fa.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790082798; cv=none;
        d=google.com; s=arc-20260327;
        b=mzq7ucS2KfyKQScOa+RN2s5c9uKCLMC4ceWc0GRHZiPW9S8vPGWtyDXwI1ReXCsdS9
         u2xKrgd/feFCiNWMdrrPk6hKlrQpK7mEPGjdCHPqIsR8xlsbjY72oZIqk3P82dOBqKCI
         o29YxGSsncPOvx0QjunxFe9gxP+Wa29QjRssWTFJrVU2PE0C2GJisRtUekJjLt7/MbTb
         XmIw++c1BgoCq5cgfE/PLYuXPTBHEIVrzRSP1BiE3JQxC5AXIInA4YxfJU+c+Pfq5Yth
         tNPofRfkQEDAXVGUS3V35TjqOWbjD15lI8/LkiNTgXcGKs0MWe8MxFrLphloaOW3f1Uo
         LCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r9I33pkuDN4IfZkeNMg1Yvv3ErOrI5+WYWqPcorUJCE=;
        fh=255FujiQMCPdnIIlX6hOjF4ml7/Oq1VEaVOx5cF0N2M=;
        b=l+44MYdDKSfZn5rM6kFGHJ72kZUHaWNm1D+ohku4KEXOvWgrv8dpvcjayss5PTSd8X
         y9s2ctFQmTJU9dikwJvxJd1rL1KFElUz1ZfeG0eYAlgj0H2RarCscmwFSj1VnufbW+Eo
         1rYHcIV6h4E1Utrkpl5ieWwzjkn9Pct9Ioqnbtimm4MaFzXXfWQTlgz1s7Qt6B9h86Uk
         HTg1Jya5fEKHAlAAm5XeY+DIAC7w+VdJ0+8DybZmyV5Ikp0BxqnbckZ4MYsCIw2X+q+n
         Cb7hIQTSJndmjI8IVFyAUzfNh1lnu1c5BwYTq6hFxd0drfbncY5+0Kgta81CHyVwfAZR
         B6FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790082798; x=1790687598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r9I33pkuDN4IfZkeNMg1Yvv3ErOrI5+WYWqPcorUJCE=;
        b=gCaFalCC6D+kKmSVp4Ec7tQUA29hXN3qQi2UVbi97fOrLvf251rMOwvTMWsex48dTl
         /vrHNjLifiNwqPh9gprW+D6UFIjn4J3UvNsb/T5iycHHovnIad/0c9JikI9QuJPUgaCS
         rIkm+six2JGKBuGGe2RzIqwfaLSImSHQ7owFbJN9Rqh3l9YjH38LV3Oxgd2zePX06Nbe
         i1gfwNe7mLYfeoXtqaZWeOB+Zcm1TMElKti0iCbbSw/vjzL/TolR9xbmawqys1pZDZYS
         8iwJ2BEDzjmHuCivcYug+jleZK/4HNxn7RHIFiC4ViswjHrG1OljWxHjNZJUFFBJG2YC
         4H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082798; x=1790687598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r9I33pkuDN4IfZkeNMg1Yvv3ErOrI5+WYWqPcorUJCE=;
        b=OwZYC+RDd6RcKFbJ4h4BbMv8ZPATbsYdP4W43TXqnjzyQoGsqPXuKKusq4TknaMllE
         QvI6PnLySqGMpk8mP9FocIONtgFaChSobHSJzuhJFEeGMn5Q1AtxoQjLhoxrNLd5/70g
         OHicqbNXynYduMj6qN5DCsrZBhBVxxKZSgoLB3mDxgTCCfoZjxRFYapguuPiMzHnKAbE
         zUNDS4muDbTCzRBIB4vHMVzt8Z1VFepJqYzZspqkyXOQTSgz0tr9+s1jCUhhaKfRmdRM
         AxjaQEhNza4DwyXOAYmQeeK4hLJZZz5q/4RTxsVcA1qxt9r2KOwbUCjGzlCURT45zBO4
         nf9w==
X-Forwarded-Encrypted: i=1; AKwUvBwqQczrgbwIpsPpkDSgwCZWHAJIhGI/4SMDS10VF370asEp9Gx6KDdLd05/g/Ixw7c0LMl2oG0=@vger.kernel.org
X-Gm-Message-State: AFuF++l8jP50TV6oDTH9N0IedFRqXSW3vhJEntMO9xwm8oICw2VC1MDj
	VPl6mz+NECeowV/+r5AMyhXdLv4E6xdBh/hK1RNq9SRgy0D+6K46fR20jnnhav9ZXbqOWRHQ7Sa
	di6aUT7345draMeJWxboYEX+i9cPPDTjNZEfMC7tJ7hcKisayKn3I0g57rRc8FC1ljpYIH+7BYq
	mUvkTVN3SOhlhFObr8/KpWKUnvyfg6s/gBrWa5v8bijoc=
X-Gm-Gg: AYBFou0DTgkmuYxX6rbQx8qO0Ir7MxxquDL3Qv5aO5roikz5C10qrLRWJuc1GSAm7c5
	HzlvErGj8R6AM3eiAHrm4xFPwdHu0XK0OoSlgOmjMpOGtJ5BIbE4iHydWoVswMBdTC1+uGAsqJJ
	hiIEr4/L/y1hrYkwEfX8cEZlW8bLfIVtLKwOEYFx7IPkTnaHPHNVifmrIc
X-Received: by 2002:a05:651c:1544:b0:3a3:74b7:fc03 with SMTP id 38308e7fff4ca-3a5fbf8a256mr32602521fa.15.1790082798412;
        Tue, 22 Sep 2026 06:13:18 -0700 (PDT)
X-Received: by 2002:a05:651c:1544:b0:3a3:74b7:fc03 with SMTP id
 38308e7fff4ca-3a5fbf8a256mr32602451fa.15.1790082798009; Tue, 22 Sep 2026
 06:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-2-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-2-edumazet@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 22 Sep 2026 09:13:06 -0400
X-Gm-Features: AcwNN1XoYqAwm8srY56UmfIOpo6hB-1PvtnqRUeFXnGwYarvIsoKH-_lnD-tgYs
Message-ID: <CAK-6q+isdiPsQFr0JbRvAHDf32kcYwad4t4Q-C24+WnHvCVTRA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	stable@vger.kernel.org, David Teigland <teigland@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 22, 2026 at 8:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> lowcomms.c tests and clears SOCKWQ_ASYNC_NOSPACE in con->sock->flags,
> but this bit has not been stored there for ten years.
>
> Commit 9cd3e072b0be ("net: rename SOCK_ASYNC_NOSPACE and
> SOCK_ASYNC_WAITDATA") mechanically renamed the two dlm users, then
> commit ceb5d58b2170 ("net: fix sock_wake_async() rcu protection") moved
> the bit from socket->flags to the RCU protected socket_wq->flags, where
> it is reachable only through sk_set_bit() and sk_clear_bit(), and is
> only maintained for sockets having SOCK_FASYNC set.  dlm uses kernel
> sockets, which never have SOCK_FASYNC set, and never sets the bit
> itself, so the test in send_to_sock() has been false ever since.
>
> The consequence is that when sock_sendmsg() returns -EAGAIN because the
> socket send buffer is full, dlm no longer sets CF_APP_LIMITED, does not
> increment sk_write_pending, and does not return DLM_IO_END to wait for
> lowcomms_write_space().  It returns DLM_IO_RESCHED instead, and
> process_send_sockets() immediately requeues the send work.  A connection
> to a peer that is slow to drain thus keeps cycling through
> sock_sendmsg() and -EAGAIN, burning CPU, instead of sleeping until TCP
> reports that space is available again.
>
> Test SOCK_NOSPACE instead.  This is the bit that lives in socket->flags,
> that TCP sets whenever sendmsg() returns -EAGAIN for lack of send buffer
> space (tcp_sendmsg_locked() and sk_stream_wait_memory()), and that
> lowcomms_write_space() already clears.  This restores the semantics dlm
> had before the bit moved.
>
> Also remove the clear_bit() of SOCKWQ_ASYNC_NOSPACE from
> lowcomms_write_space(), for the same reason.
>
> SCTP connections are deliberately left as they are.  SCTP does not set
> SOCK_NOSPACE, and it never calls sk->sk_write_space(): sctp_wfree() ends
> up in sctp_wake_up_waiters(), which calls sctp_write_space() directly.
> lowcomms_write_space() is thus never invoked for an SCTP connection, and
> the test added here stays false, so send_to_sock() keeps returning
> DLM_IO_RESCHED as it does today.  This is the only safe behavior, as
> returning DLM_IO_END would wait for a callback that never comes.
>
> Fixes: ceb5d58b2170 ("net: fix sock_wake_async() rcu protection")
> Cc: stable@vger.kernel.org
> Cc: Alexander Aring <aahringo@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>


Acked-by: Alexander Aring <aahringo@redhat.com>

thanks for looking into that!

- Alex


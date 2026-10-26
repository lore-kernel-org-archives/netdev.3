Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792977329;
	b=fAkQ3hP4H/kKyFT4DOnezQAf7PEReJNiuCmuE0GJQW1xLKAYymoBqVS002bOnrDfKjLJ
	 UNatr+HuB+rqsP0K4ztP/zK0FQM8PaKfISxsfQAvzuV6e/I/8pkqKtweYdG6wFyHNawNF
	 vmDf4TljReeVHFKsejQA6r31CaPdys3m7YAH++hx0zwQN+u03RpImh+qWjuVEnVvmf3td
	 1jDYIt93CFo/8Xzx2u87/F883mf9WYw24bBUlbDtwlDEZ+VjZ11/YCE+YhP4TvZeIBXbm
	 fIsGQjWDrwmdefaW2G6GqUJt6/ErK5OMU+NWX57laPpykBHfYV1xb8t0vGmYzHrdi5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792977329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kcIt4AlDwKcuyi2teHhI3jaIBhx2e8Mks+B/iXDVZME=;
	b=dUGBpkgg2pyv0aWQGOLNlTfzR4tkAN+nwFA6XDeyJaGsOOzb4b0kG64LVVA5DIphl8RZ
	 5CN4fheyENJIcZ+3/lAdi82EswF0hGbBYTr2ro/rbPUt5sOD4TUjhnWplzYoQ8o4Eah6H
	 x2YTAyCvqTMtFmSHHJG8lhcRNXopcP2J2wG0huqFXzhUM6TBYCxC6gqfki8bNRbGa3CnY
	 AI9kyDyq5i5VWDjvnXFShGcqnUiMMltCcpWu4ie+fcnkvwxsMIliCnzFwY2zZUyifUW7y
	 dRbvTV5mQtXNJJ/xY04xZdXeAzIudLQqFuyYTSNpIPjFcRfuT0m4o0m2V/ZzhDEmrGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BfKsuv+T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE5606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FAE5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BfKsuv+T
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-533797e72e8so16716061cf.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 18:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792977328; cv=none;
        d=google.com; s=arc-20260327;
        b=boUipK1DD4dpnllQUd/3KzEJ7QIU5Ge031pCiNCkrK5iQkuGuFmzN54SiKaUbCQQnk
         SUZIQs0Kzo34bxWk2w+hIPX9XB+Jx69HCepXr2vmQCUYVYGU4DNAltP29oEr45pqWSen
         KQMnrBLr5bE8tGJ/iYQXC478reqY/p9hs3LxK1WyMoj/Bx8UTD7T8cFcNvnCFV9NDXJ1
         YdaPqPGql6PUZq9jYU3H+OO846+oKvbYzS8Y+XL4VAe4d56kERXYg4jGypKKCUTEYCEw
         CYcNMvMCRC5uKhxDvz48oyo6rYmgG0lVkGB73t3/RDHaGo0VvX8vbMua1H/YGxITA9Kp
         PSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kcIt4AlDwKcuyi2teHhI3jaIBhx2e8Mks+B/iXDVZME=;
        fh=+UAbHTunqaLqIeM3kvAJjkbgyZZLuA1Howp0CA1MfOs=;
        b=qMH3cNS+lcW4F2EYCUCXl12mMMlcNBapEjbNn5nvjikEKQTSnuAMP1HojCGdBLBb97
         wQj93GM5X7EYbBcyPRCxuIMFjiZEl9PXlcxFqiXRbtk+uNRVFdIfwJKFatCABxsQ4TGQ
         1MpmIgyQLwF3oXvvs0BsIkgyiAyHjbGZh2jcThmemYXfL5RF/a65ERWBOW5VGFK3Y2Ab
         6F0xUJ+3wRmn00oSZg5Ll/IimuEJRV8CZIqstgpSX9aUi1iEcQcycYy8G4YuEUkcIF0x
         PBq9GMRYmnpofopJYpJOvf2AAAsA3AjuhIwIVRWk73Xb1o4kWidg0jVYkcuuxECypiLf
         BIQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792977328; x=1793582128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kcIt4AlDwKcuyi2teHhI3jaIBhx2e8Mks+B/iXDVZME=;
        b=BfKsuv+TH5yW60OVPKqz4MZzmZXeIUfeI052jiXuzPygcs71qCUTcTjI0qhRLbk86s
         2Fcrqq/G3zOxcgF7cXkYjS6gOvvgf0VLqjLj9K4yNkFkS+5SDRUu13q2sG9i8SGqXFof
         J9hlhc2Igie4SairlkUIL3uXHc31gETqu7s9zaQ6BeSJYUnmTDBccEOPZiRHRVK5HFLf
         ADc9OUAdetNRiEH0rntOKlHPQ/ZC2w5UsfEgUnBbIMOdVXqBUF3COOJEEdlpEjo+dprC
         AcQL+jqrXBJv2IDOGK4ghFbvtF/YKkwSwjcJk53ccqLW+2PFM/TfHk9CFVWdKYtEdVmL
         1HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792977328; x=1793582128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcIt4AlDwKcuyi2teHhI3jaIBhx2e8Mks+B/iXDVZME=;
        b=Tna/v/qfvymrCYCsn07ry7jOWE11L1ylgvyF0+UVSCQ+0wh+1Xvq+3xU0zlh/CwBho
         cSc/G5TBTmZUZitQK6lQkQw7FvkzMafZURKmCTGpsReP7LJW0PZ2ApDM469qT3wRRCKX
         zKZhI3bjcseMX2WQ1dRdR8OMQjkKO3jnhA47AWxQSWPKnIEl+nARYtnCAb63gWq6HrhH
         mlFOYiXyGN2+4LLHO8de9N3FJZVosZOzkkeoUeMtHQIXxCmkYNniDYJNbbSj8h8EIDhO
         HGVNgkSWx16EXngQHXcVF197+kisupn4xizVfgE3Iil49jM5nISNoivHj39ZUg4oX/5d
         QfzA==
X-Forwarded-Encrypted: i=1; AKwUvBz2FbDbhSe42S/HPns9tRiDW+SfFf3LLOcTx7K00kBHYBlt8GfqFq0nvJ3nKOcibtPm/913InQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnQYgdhyHx2bHNDgB/MPInGo/7mGbAjZylys2rPB1uk2EI5yB0
	1VmvxpNfIFPLUNMtiDQmoapyvmBYy5NhFy+O8nZB4xPoRCgWJ55wuW7ja2OCcVFPEyl0vF4xaOB
	rtA49nhfWxNoSpakk3OmU8S/b6wdrRlg=
X-Gm-Gg: AYBFou2LiRwO7tvs+qvtvW386IwbfdonGNa0aNHOS9IUHLr8aXvKnZVyx6Q6XIZ65rB
	ScZx4SvD1/TQ8cDqDOM01dIiCghCewamCbkIyp6pzPMenDDj3F+HYzENirnMKHeT36Pb4vg7QVe
	Q8vts5oMxottHBKh+TmpvatVFh+RCkWiC9R7GkzDDu6BaEevG8yFD/7fOP994Roz8bkCTm72X1m
	xGm8QtO4lDiD0VrwAp6mlNBpRJCC+x6nqBGoySNmcypjPMTGISs3I+HsPsnEaf2o1SsD1H8y4N1
	ixCDosQsX8gzGMjHBxpqAEA0ywOkmed+GfBUqF5ojL9ReWdCbmohifoSo0WxU6dItyhgJ5vI8zE
	wLpQvOLvZm+1fQy239FYAtvNeXMDE6SBgJLWW1IWi/xbC0fsCTCD09FFXuAL24gT9yXrPE5zzaJ
	dSU2R3JsdXHX35XDKuIrYezWtHirnvol1XKqRfgyBsVWkyPxwn7yaA86NRrrhG0jPFP/rdKqMt0
	jMtYAg6qlYMsCLuX7XAMF/k+bkYz2o5JhdPAFldtPikCjsjjE7jZIm/0fnyPbiq13bUfSvOPpVX
	m0nBZZJogb8=
X-Received: by 2002:a05:622a:8842:b0:535:ed1:cdb0 with SMTP id
 d75a77b69052e-5383b38f236mr81537211cf.4.1792977327813; Sun, 25 Oct 2026
 18:15:27 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021155715.30094-1-jain.sm@gmail.com> <20261021155715.30094-2-jain.sm@gmail.com>
 <20261021135110.785bb935@kernel.org>
In-Reply-To: <20261021135110.785bb935@kernel.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Mon, 26 Oct 2026 06:45:15 +0530
X-Gm-Features: AclHuK9v5p6YHrm7XmZkFrhbkAZsWSlrZYFgeH9innXsC4CRHCe412MlSRwf478
Message-ID: <CA+FWx==2+3kc493w2bqxO+UuJfMP4CbC+Fa57r37x=HBiaqnsA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] tcp: keep the route window metric when
 SO_RCVBUF is set before connect
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [Medium] tcp: unordered lockless reads of window_clamp in tcp_req_window_=
clamp()

Right, nothing orders the two loads against the two stores in
setsockopt(TCP_WINDOW_CLAMP) or tcp_disconnect(). The case that matters
is the one where window_clamp reads 0: the request then gets no clamp at
all. Any other stale value is a clamp the listener had just before, the
same as a SYN that arrives just before the setsockopt(). And a
setsockopt() between the SYN-ACK and the cookie ACK changes the clamp
whatever the ordering.

So in v5 tcp_req_window_clamp() falls back to the user's clamp when
window_clamp reads 0, without barriers:

u32 user_clamp =3D READ_ONCE(tp->window_clamp_user);

if (!user_clamp)
return dst_metric(dst, RTAX_WINDOW);
return READ_ONCE(tp->window_clamp) ? : user_clamp;

I kept window_clamp rather than the stored user value, because a listener's
window_clamp can legitimately differ from it: SO_RCVBUF lowers it, and
SO_RCVLOWAT raises it so that the window can hold rcvlowat bytes. Capping
that at the user's clamp could leave a reader waiting for data the window
does not let in. The plain store in tcp_disconnect() becomes WRITE_ONCE(),
and the changelog no longer says that READ_ONCE()/WRITE_ONCE() make this
path safe.

> [Low] The changelog says: "Without an RTAX_WINDOW metric and without
> TCP_WINDOW_CLAMP nothing changes".

Correct for MPTCP subflows. mptcp_set_rcvlowat() writes the subflow's
window_clamp without setting window_clamp_user, so tcp_connect_init() now
replaces it with the route metric, as for plain TCP, where
tcp_set_rcvlowat() only raises a clamp that is already non-zero. v5 says
this in the changelog and Cc's the MPTCP maintainers.

> Pre-existing issues:
> - [Medium] The patch adds tp->window_clamp_user and comments that
>   window_clamp "never goes above a clamp the user set with...

Agreed, the comment and the changelog claim more than the patch does.
Only tcp_set_rcvbuf() is capped. tcp_measure_rcv_mss(), tcp_rcvbuf_grow()
and SO_RCVLOWAT still set window_clamp without looking at the user's
clamp, as before this patch. v5 rewords both to cover only the SO_RCVBUF
path. Whether autotuning should respect TCP_WINDOW_CLAMP is a separate
question that this patch doesn't change. I can look at it as a follow-up
once window_clamp_user is in.

v5 will go out when net-next reopens, without the Fixes: tag as Jakub
asked.

pw-bot: cr

On Thu, Oct 22, 2026 at 2:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 21 Oct 2026 21:27:14 +0530 Shashank Mohan Jain wrote:
> > The problem was found by code inspection, assisted by an LLM (Claude
> > Code, Claude Opus 5.5), while reviewing the commit above. It was
> > confirmed with a reproducer in a qemu guest (two netns joined by a veth
> > pair, "ip route ... window 4096", tcpdump of the SYN and SYN-ACK, and
> > TCP_INFO of both ends, including a SYN cookie case), and with the
> > packetdrill tests added by the next patch, which fail without this
> > patch and pass with it.
>
> Sounds like a genuine net-next material. Please drop the Fixes tag
> completely, and repost after net-next reopens
>
> If someone disagrees please speak up.
>
>
> ## Form letter - net-next-closed
>
> The merge window for Linux v7.4 has begun, and the net-next
> tree is now closed for new drivers, features, code refactoring
> and optimizations. We are currently accepting bug fixes only.
>
> Please repost when net-next reopens. There is some uncertainty
> about how long this merge window will last, so please check
> https://netdev.bots.linux.dev/net-next.html
> before reposting. net-next _may_ reopen on Nov 2nd.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#=
development-cycle
> --
> pw-bot: defer

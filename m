Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792615477;
	b=yTiV5XoKMIbW+E/uBwmhXM/z0CyFK/ov8pHeEGk7uJJ8ePYZZXvB8a2IxHhXE3EpglKQ
	 3nlU11aY67Qc11gzaAEvy3mKEto/DdRYR6Z6Pp6oFa85mq8VYOU7nf+9KAHGhTE/oedDT
	 W7IOYwWJ7791ZWnvFjWR3+r7zavRa8AkQDV+n8L83joxQQhzikdhDeE6c4fqCc3Dn9vw+
	 IjSTBWtBlfuLTWeXWhSphpOMa24O/ISEdko5cs582P2VnQpeCnRLRYLIRIURJ/ODAp4LM
	 O2NfrzRetwLPIFkNOKCQn9VzDOqax9+LT0uobGSEeT6AWMJrEcqJzn/6z+ptwsI+PSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ptFg/AwFxTH5f4L+o+63VUa962mRQD30O48qGbT4Brc=;
	b=g3mA0yu1YLmgmvUZYwREA6mNlEGr2xSDONn35ajdE8l3v9Lk/eZGQWxBvvmz/hA+sXrO
	 A2WOgUT6aXVkEmbTf5qJCPoDrTHun7PLmFoPHwIXplrJNTthVN5pzYr0PirwggHrwBdOv
	 I5vyCtDETwZNNyZVQR5sQBnDAl+EJ5UjaFmybF5/byV+4yxCHBmTMgyOjtAkXESv30c5A
	 J8KzoDErzPsFnJhqHEAH9otC8GdrP07WFwW5uk1UHpJV36bkTP6NSjDqAqRsCzidvol0Q
	 1qJZ5iQSYde+lv16X3KYoxqrd5iO+dSd7B2lD7oz9UGPOU/J/jZJTcCkR2tnJflRRWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jbLWr4TJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4E606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF4E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jbLWr4TJ
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67921b515a7so1123960d50.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615476; cv=none;
        d=google.com; s=arc-20260327;
        b=mDWL0nZdkn4eItYVV2VU6spqZT5H8/hgJzV2OQJ8Zu28fQZQize37IY8ZHwyBwz8Vq
         yXa+K/d4KGSqpNY9yHbxxdUrDGj5Wck2T7G3oY3genBRTpcA4+X5EOOn8yE91TQB/dLc
         RbuxLtdzvXaaIHU3Yju08y5X25UgpHWykP0/UlRJoa0wwh5fx2LSrOc/TejiE+8xu28b
         12r2W2U2IjNivUIlx4ZwRDxIpNUY5Hk2WFeZ3ZHuDDClilGgtRZNbPesm4mQKxvRYlG7
         lx9jAoHe9NRl72DVqEupENC6STp2z47R6scb6rTxefoKR0Tig1vnylQN4xEfRafBGEFr
         SWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ptFg/AwFxTH5f4L+o+63VUa962mRQD30O48qGbT4Brc=;
        fh=I94r6SN/+9n+53MDbG1a3oA09SuXdPBkVULaK1hSl/Y=;
        b=AqrD9Hhhv0npBmddd3T6XETaPOBRuSy3eQRcewUno800Ss5Hum8yNUlMMmjrf/hWFG
         Eg6kiZtM+rGSKy0no+PmAR7KBZhvn8Py9khXmix7KKp3LP0S7wGgChkwDgKuj8gGLVc1
         Ekwu3wwuwc6xvi5kpjhQuFQ8LXdIxRy/5ST/Dh5NluLqF3PowJverIl8u/Ok1KmSntim
         Lwq8CNJtQ73VXqiCZcd7uSGN/upAxHdpb+WxIjV+SY4mFg07fSiLoRRSUiWEK10NjytD
         x1HFfMQI7Ll20hiYg28yYGZyO+u0pO4OBHz87pLfWqx7nWR8/yHyEGMRkoFw+OUgWVvR
         IsXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792615476; x=1793220276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ptFg/AwFxTH5f4L+o+63VUa962mRQD30O48qGbT4Brc=;
        b=jbLWr4TJVuNMXdyXLBgaZpbib4opRvjX3jKGFSgRfBk+Cu0YRHMfBxjM7c744i5S6Y
         naQNBLFymsMWaY3SW1uVPLHm2/mPRdStegE9E2OwThyTE9LxQgoC4+duq9QBs0UFF2BW
         CEn1rOznnxbqTHWUw/olW7UQCyf4crkM0d1lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615476; x=1793220276;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptFg/AwFxTH5f4L+o+63VUa962mRQD30O48qGbT4Brc=;
        b=fPH15EviQpooPvw+5aHZr9Jrn7zmp1+8OvQmLaw8HeAo1ol/ipWxMuwWrAUhM6pBo/
         e1MpBU+rP8gCFDExVHqtvW3n/lRs4rJ2nBKrMa+9pxN2G1v0VERs8LG96fLj/CNHhnjG
         aw+jiiVUNcrGOT4nDrCznLysZrt79+H8zG8JumqLl+aSuBVSEVF/IKrmTV17pZX+Emxh
         GMjk0Q/Od0lW8nbNpoOk+BZxmGS6qaAoGGfVIwjcRpBMShbhyQWTLMnf4BFWyjkJEhDc
         DnDT5yrzwEf0GVJw0CblYA3V5naiPq7oQQyDzV8iHxj854+eL8uPbxUTWWmbrdK/gb3I
         XjmA==
X-Forwarded-Encrypted: i=1; AKwUvBzrkvoiVeTSgO+t/ct18ec6niJx/k37Mqi2Esz9w8CEG3yxEX8NJEGhZdAGavm6F9BqJk/Cpfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrCYLDyeRIoeQyEOXLNA3eZaIbgY7oy/9TnMUcPDPzbEOciw5i
	j416CwSFRed8qUDTfmC3BJTt0SMDbT8oyTtTNagYGYZiA/U9zJP59knRuxDhB480mb8OnowC5o8
	RN3njMNF64mwo+GrSnzU9CIkZ34Va6zJeEd+1MIBv
X-Gm-Gg: AYBFou1ZLQCoO+S1zviypey/zyQxJUuAwhlbFxz4y8Wjq4FnvrCN0O0EVo07sQOY9hs
	XWfAcNISi3dxy9cHvkIJFJAU5EzYk+fNfYUdOKwdQSiYiRd/8lkihS7AO+NrFSphDqzVjwR+689
	ZIksEUKes0kRN6cjkquvHNkuB9EqXR+ddOHucmCyYQ+RvSKkdqgMJWN48kuDuUKhO4z0d49RPYZ
	cijJi4j5vIro1Zh6bO3fhlmWAuX+THypo1QVB0J6P2RjwmcedfhPHHD5eRls6ZXFLhTiCrPkKeO
	1faWO/G8NYd+e1J7JROLN2+LsXf81yZvTn3il4cYW32dF/SOpesfc9puYzM946ucuDFE7LbaIA1
	SZkBnNWwer8hiDLfdM6WqdT3qMhbVjARbOv8yzovMFurmI0VCkbrNUXOXUzCZA9yuuNVz+e4Q
X-Received: by 2002:a05:690e:458a:20b0:679:bb35:96ae with SMTP id
 956f58d0204a3-67a0e57febdmr1116875d50.74.1792615476200; Wed, 21 Oct 2026
 13:44:36 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-7SHE.v1.r0.20261016101330-1@mojatatu.com> <e0f4776a-0457-4069-9f79-3c97de2a54d0@redhat.com>
In-Reply-To: <e0f4776a-0457-4069-9f79-3c97de2a54d0@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 21 Oct 2026 17:44:24 -0300
X-Gm-Features: AclHuK_iJwtn4T9BOcwwmqz_vgKPGYOJxCDP35uTHuQAq1jQv2i6iwQyVeKUy3c
Message-ID: <CA+NMeC8wOuvc9RNCsro1vYqkEhJLKZhL6PW1jLBpPDqps-LC2Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: em_text: pad the text pattern in the
 ematch dump
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org, horms@kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:42=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 10/16/26 17:01, Victor Nogueira wrote:
> > This is a follow-up to commit 9c572a83037a ("net/sched: fix potential
> > stack infoleak in em_text_dump()"), which zero-initialised the dump-sid=
e
> > struct.  Sashiko separately pointed at the unaligned pattern tail on th=
e
> > same dump path.
> >
> > em_text_dump() appends the text pattern with nla_append(), which is a b=
are
> > skb_put_data() and does not pad the attribute to a 4-byte boundary.  Wh=
en
> > pattern_len is not a multiple of four the skb tail is left unaligned.
> >
> > tcf_em_tree_dump() records the raw span as the ematch entry's nla_len a=
nd
> > then writes the next ematch's nlattr header at that unaligned tail.
> > Userspace walks the list with RTA_NEXT()/NLA_NEXT(), which rounds each
> > attribute length up to four bytes, so it looks for the next entry at an
> > aligned offset the kernel did not write.  The ematch list is therefore
> > misparsed as soon as a text ematch has a pattern length that is not a
> > multiple of four.
> >
> > Append the pattern with nla_put_nohdr(), which reserves NLA_ALIGN(attrl=
en)
> > bytes and zero-fills the padding, so the following ematch stays aligned=
.
> > The emitted ematch entry then carries the padding in its nla_len, which=
 is
> > what NLA_NEXT() already assumes.  em_text_change() only checks that len
> > covers the struct and the pattern, so a dump replayed as a request is s=
till
> > accepted.  This also removes the last variable-length nla_append() call=
er
> > (sch_gred's is a fixed-size, already aligned struct).
> >
> > Conditions to recreate the bug:
> > - CAP_NET_ADMIN on the target netns (namespace-local via unshare -Urn i=
s
> >    enough)
> > - add a basic filter with two text ematches whose pattern_len is not a
> >    multiple of 4 (e.g. 1 and 2), then dump it with RTM_GETTFILTER
> > - the first ematch entry comes back with an unaligned nla_len and the n=
ext
> >    entry's nlattr header is written at that raw offset, while RTA_NEXT(=
)
> >    reads an aligned offset three bytes later
> >
> > Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260918133953.12494-1-bernard.l=
adenthin%40gmail.com
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> >   net/sched/em_text.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> > index 4132f8c3c5fc..fbf78d61f109 100644
> > --- a/net/sched/em_text.c
> > +++ b/net/sched/em_text.c
> > @@ -125,8 +125,8 @@ static int em_text_dump(struct sk_buff *skb, struct=
 tcf_ematch *m)
> >
> >       if (nla_put_nohdr(skb, sizeof(conf), &conf) < 0)
> >               goto nla_put_failure;
> > -     if (nla_append(skb, conf.pattern_len,
> > -                    textsearch_get_pattern(tm->config)) < 0)
> > +     if (nla_put_nohdr(skb, conf.pattern_len,
> > +                       textsearch_get_pattern(tm->config)) < 0)
> >               goto nla_put_failure;
> >       return 0;
> Sashiko suspects this can introduce another issue:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-7SHE.v1.r0.2026=
1016101330-1@mojatatu.com
>
> (the 2nd concern)
>
> I think it should be addressed in the same patch.

Ok, also think it merits a respin.
Will do once net-next reopens.

cheers,
Victor

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794434598;
	b=oDPVPN5Jq4dvB5KtVBXUpBExNRRxL3YGdn290sOtFbjjhFrYBm5GiG3k/J7fnG6fqbNU
	 KiM/oTR+pSRQRKO6WDbx6xM49x55yIuOX2/BMdkb4bha1VRLXB+MhtmM99/zponzMobyO
	 12MIokLLiwE6ccWnmW8Rnr197Ke3j0PSPm3cOq9oh/k1pKJ2zojFVFe5qIltXHx+pAkRa
	 D6gwnF9DWSsv1rBkHj7tvQaF2u6UEdvZg6TZSt33aqiVE4ldM8nnQFc5DzQHxdi9LFGiX
	 K/B7uc6Zz6x3qEtRH0hMQM2zICB2//y/d/Zuckc9jURhqk30EiY5CWoHzfkGdRNPzrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Mul4fa6Ln0hB4RFr7GPev/ectXNF1bK3kmmDXWQ6hQs=;
	b=aAlKStuVF0oQI1lUfHzT7R8Ka5f+9NPESfLoMdXwHQwAbGMWCAKtZBst2IQ/c6W0gPzw
	 JCSQfMju4a2TpBjYKWEFZbE0SaMn7KH9Yy/yDsMfmyAxc/5vLNzgdhSxgfdspCZI4u7N5
	 6QkcaOE0lwvkI6T7vOdOtMM0rXX6IJWpYcGA9LT8bnMr9VCM/ilCwYYDZjMVP/hC7cI/P
	 SY3lCLjUOMawIcQIWMdU9SVO5Q409xR0kTu1EoWZh3ygFf2Bzf3eUVO7n1O7QL/hmqLZK
	 RcbdcB7+gJGvCUOH/DmNeINHeVm+TDbERumQST/Mq/JqNL1WLUoHjrbYClwx2MwJISw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="f/VzwH8r";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A99606A897
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1A99606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f/VzwH8r
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso1250a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:03:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794434596; cv=none;
        d=google.com; s=arc-20260327;
        b=Dw71PfqJHsGKhqXoEc4uRBir6Zq8QNKEAKzuQgW3mYGl0I3wTm6pOZWQt/rzgkR+4d
         Jp6478P0zxSeszafJsAgTvPMsrmFvbi/D00Ot+gRJXBZTP80dHnxqTLEyCLl1m7B/rBT
         MQwecj2U0gxDKDFPtKW3BFY18F1KaFJwzNL5ee20KDzfUiyvP6UiocUyeni01JAE/oV0
         q9JUnqgwOQvxXSudCbnCoUr/YKwrY9wvniQ/vWYgulnQcIDVd62xHqYeImuDonFP8Zeh
         V4zF8svbOHHO9kJyvWg5jlDiUvMgiTe2xIW+EXDp5wcQLsxEvVqG0NcDl5zWSlM7mtru
         6iQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mul4fa6Ln0hB4RFr7GPev/ectXNF1bK3kmmDXWQ6hQs=;
        fh=SFTcYCsCDlFlEGPRG+wa19FnQvWvjkx3i4Vm99u/2tQ=;
        b=M2M5TTTX26Mde+ooVwDxJM+eOQFvj9UWckDqMVy7TGzaCnUHscrqsNKW9wXYTkaXpC
         MbyDEaEii1RY/EyavTP0fwzmk5aBT+LnJbt1KKjJG3AEHXzB9Q0woF06ulZL6OkbRVK2
         HLUi5qG28+ZHOH7vSPDHxWZhEpYNJo3K3k7V6uLyLgcsqGIat2rE3iqWLKMvMsi+08cR
         nlO1HZ9h6esvdpkwl28YNDOlYScbHCOOz7E7h87HHnFFRVJiUe+UnBhKl1XCZy+I4G3f
         VtesFbCh5HKgL74+u5UDZ2lSXQSB7AJmsdm1slMaI/TRGDaaNlXTWaE6XQdkpvGKIaBF
         +wxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794434596; x=1795039396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mul4fa6Ln0hB4RFr7GPev/ectXNF1bK3kmmDXWQ6hQs=;
        b=f/VzwH8r+rOT4OVHePl1yP77vum2XzLCVem9F6zhtDKY95k2C+p84Y/B9cBUwfJo0H
         DX1bpY9AdLJUx4p5B2SYKJchkD7WduR6DHVLk8BLeHG4rHn9JWrBtbvYtENmXMFVXu2p
         oQ3V3g5w19Ypc+hv3ttO4Kqo0lKBqNnSC4nIZy59ZpLWLmEoxf+IwVm7HP8/hcaBoFU3
         GTaT3MW2J+DTcaXOv8YlOCQ29lIHkwn8rQ9xTzs5AZ0l4eFCxSYtb1dXeMHp2l77B4lZ
         AjEiCru+VIsq8nAT3AxhvhIfHnMWdwavvxva6foOrwOSl5DQzxzTx9o24tPUPL5h1RdU
         uBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434596; x=1795039396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mul4fa6Ln0hB4RFr7GPev/ectXNF1bK3kmmDXWQ6hQs=;
        b=LGIFQ1ipcskzQ9lZYFrXa03FUxYkxa+J+x7nZc0DyDjV9VBcgUjFyC2P3Y0SXxMtIN
         lGPp3FgZ1sAqnB1pYn3sxWMJsV8vZTlQeKgi8Eop4RDzX9D1OQZbEHRBQxjm6+esTybS
         flqETYz44A5de3yftD9SL+S5uoJU3OD8ObgqVEEQk/tFWEmsDv27ttbDcnryce3fafQM
         terwDIBT3kEVXpWUx/R5480va1lZsKwcPDNuH7lu2QhYPoHEMT3Yi/jM2j+tiiDCISTc
         qvuN/JQi68vUghmFI+OSNvIb5euTZsDeSb5QwRL/ka2mygFjQnFZ9Fe1jnbxRnRhEP+a
         eBwg==
X-Gm-Message-State: APuU4Z+sLUGeK1rd2R5Zt9h/OGL7MRXvbpjZh4Tcxg0mRCIH0I2cR+Ew
	T4xiyNHNb9CProO7w9dJRZ6/X9OUUFtU93Sr3XSAIk5dIHuaWSMuMCB2tdEykowdwDu6dkwRKek
	gNI8gyv9dxGOBArZ0vU/fCt2jcinHjHtyt1g6hDuP
X-Gm-Gg: AYBFou3XY4kktHYbzKVyl/O8XHctqYFX53rTQqegQQIu7m6ZyIUxcMqSfqXPifkQz6o
	mpvTxcLmkU5kHTYWavQnuYAEmAVhR5vw+dgd8qr/4xzUDNHS1g6UAnFxT94sy89KG6mx2Ff1CJs
	o7mkRJt6Uc4P2HTY5UfdsGCjmzaJU+ONToBS3sTwTJdgJNqZdDxmLn3CHQwuqdkkhuQy4qejCvs
	CpfdV0FF8MjnU7+xXkMFSCYfPhDNEiuq6ngoetRH+C8lHbOH+7HzXDKRmPOA0oWiC8sBpejg7DL
	nm6KukKq8SiFQ1MbFdlF4ojV9wrneZQgEpd1TY+LgRdgpYTweiALlWU9lsjZaEv/WIfSUEI94Vs
	t/2vnEhb8J1i2JRaR2ZM4Uds3GGWm1w0MEbLv9fN6nJiES11iW9DqdCIjjPExRlLy7Ww=
X-Received: by 2002:a05:6402:c520:10b0:6b7:91d9:b087 with SMTP id
 4fb4d7f45d1cf-6b7a2a88237mr5290a12.15.1794434595704; Wed, 11 Nov 2026
 14:03:15 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108013838.1454450-1-almasrymina@google.com>
 <20261108013838.1454450-3-almasrymina@google.com> <avIRJ3vdIj6Jr9zJ@devvm16445.scu0.facebook.com>
 <CAHS8izOxvUxCND3R18_HfZhB=2RS4_RNfAmx7S=Ex6b5z_CQuA@mail.gmail.com>
 <CAHS8izNodRM1Bx+FT7okpdeDfCeyJVP5QoyxhSMJWXpGuwyL4A@mail.gmail.com> <avTkuRVZcOuYlu9T@devvm16445.scu0.facebook.com>
In-Reply-To: <avTkuRVZcOuYlu9T@devvm16445.scu0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Nov 2026 14:03:04 -0800
X-Gm-Features: AclHuK8z31nDU3h0IDvtHI4N0WvsgMD2xFT1mD0hWH2bfCjrrHB2M3Hvc2x4WQk
Message-ID: <CAHS8izO+yUW47rhCnaKfMS1iLHEpx44_NkB_uUoMDms0ZmJMGw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net: prevent mixing frags from different
 memory providers or bindings
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, linux-kernel@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:01=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 11/11, Mina Almasry wrote:
> > On Tue, Nov 10, 2026 at 7:54=E2=80=AFPM Mina Almasry <almasrymina@googl=
e.com> wrote:
> > >
> > > On Mon, Nov 9, 2026 at 10:33=E2=80=AFAM Stanislav Fomichev <sdf.kerne=
l@gmail.com> wrote:
> > > > > --- a/net/ipv4/tcp_output.c
> > > > > +++ b/net/ipv4/tcp_output.c
> > > > > @@ -2692,8 +2692,9 @@ static int tcp_clone_payload(struct sock *s=
k, struct sk_buff *to,
> > > > >                                    probe_size - len);
> > > > >                       len +=3D todo;
> > > > >                       skb_shinfo(to)->flags |=3D skb_shinfo(skb)-=
>flags & SKBFL_SHARED_FRAG;
> > > > > +                     to->unreadable |=3D skb->unreadable;
> > > > >                       if (lastfrag &&
> > > > > -                         skb_frag_page(fragfrom) =3D=3D skb_frag=
_page(lastfrag) &&
> > > > > +                         skb_frag_netmem(fragfrom) =3D=3D skb_fr=
ag_netmem(lastfrag) &&
> > > > >                           skb_frag_off(fragfrom) =3D=3D skb_frag_=
off(lastfrag) +
> > > > >                                                     skb_frag_size=
(lastfrag)) {
> > > > >                               skb_frag_size_add(lastfrag, todo);
> > > >
> > > > From [0]:
> > > >
> > > > Maybe easier to not merge niovs here? Add '&& !skb_frag_is_net_iov'=
 to
> > > > that 'if (lastfrag' check? (or your new skb_has_net_iovs)
> > > >
> > > > Looks like it is tcp_mtu_probe path, not sure we care about merging=
 there?
> > >
> > > I'm guessing this is not an issue with pages because they're
> > > PAGE_SIZE? But, seems maybe a bit lazy to just hammer all possible
> > > net-iov coalescing? Is there a slightly cleaner and more generic chec=
k
> > > ( && skb_frag_size < PAGE_SIZE or something) so that we don't add
> > > net-iov tech debt? Technically this will be an issue for hugepages in
> > > the tx path or large folios or something.
> > >
> > > Also I think it belongs in your patch series maybe. That's the one
> > > adding the large niovs :P
> > >
> >
> > Actually, this comment made me realize: is the optimization that you
> > did with net-iovs here (that's showing so much better cpu) also
> > already implemented for pages? If not, is it possible? I don't see in
> > theory why the userpsace can't pass in a contingious 2MB page to
> > sendmsg() and the stack could keep it intact in 1 frag up to what the
> > driver tx supports, no? Is it worth it making your feature generic and
> > apply to pages too?
>
> Based on [0] I'm thinking that I'll drop all per-frag enforcement
> and will not add any special handing to tcp_mtu_probes. Looks like
> the drivers are expected to handle large frags (if they advertise
> large tso) or have a [1]-like segmentation fallback signal to the stack..
>
> And yes, regular msg_zerocopy path already merges pages so this is
> not niov specific.
>
> 0: https://lore.kernel.org/netdev/20261105222058.944293-1-sdf@fomichev.me=
/T/#m169832053b43604b0c5df7f7b1d04e9d4f390cbc
> 1: https://lore.kernel.org/netdev/20261105222058.944293-1-sdf@fomichev.me=
/T/#mb6e882ab1aecd6c15552773653301cc235b987d8

Thank you sir, I think I'll carry out another iteration with the other
comments addressed. Thank you for the review! Lets try to avoid these
net-iov checks when it's not something actually net-iov specific like
a kmap or something.

--=20
Thanks,
Mina

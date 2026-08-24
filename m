Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39632386C21
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598861; cv=none; b=CBorwPhwGdfsO0pmx98WvNHRlnOPqRuD2hIj71dA2DyCqoL7jO+f/ZlLspIsvpTfP6t9MmwadMlqbgXHr77d4LfFBvGuHUwXX0ZYElNLo7DrqvYCMJiNqubvpKOt9X7xNq+PH2IiI+TQqg/F+ZIWa7FvrdtSxRQOmuHDBGWwe5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598861; c=relaxed/simple;
	bh=Mulkdee5bkClRxh8Zt2BR14PzG6qLRAohxmd+dt/PmY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ODjaTo7cAgmyrfGnrN+o/IveG/a7HBbuSB+MVL1zS6/AT+UjDaQe8TkGa8tPFvSei/g4UCfK33fBrF547O13ruq+Xw1Pmu+70e/TKJ8FX0A4fsvLw9mem3Otqy9ZA3cQ0xroIukVuEvIbJLXEf3CNPQdNRsMwH+1p8YOph4rnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idKRJpJD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idKRJpJD"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80c5cb9a888so42575037b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787598859; x=1788203659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EY28LEF5hNU4O/7Z8bSRN2w17lHi5xeca4NWdtVGjQk=;
        b=idKRJpJDT0GT4jR0Kg68ajMkEXrivfJF3d/ymLfb0PLiZTCYuQiF82+E3Pox1XjkVb
         9X9ETC6cvXCaaljBk0eKGTCjWXwV+aJr/6byhYZ4pbBhVDTdF5BFe1/AdtJovSUr+nmV
         FgfzM2xAco5pts5GpHRqig6coVZ75QR8SRi0LDg6ZPzj3TJyrEY6U94XCCKz2NNTSh6b
         gN5N8+f7zcQ/NGTMI7WXyw6gtdGbeiDbg+chxOQPbrBDblpfhvnI+u1jo+5TLPyJhKIk
         n7csjqiaUMKOuKZG6xx5DlPeQMZRDSnLaqsFLzO+Kb7e9Wr1Rtqvpth1363+dOddVa3R
         XLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787598859; x=1788203659;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EY28LEF5hNU4O/7Z8bSRN2w17lHi5xeca4NWdtVGjQk=;
        b=BBR+L3wkoRQn5NeG1H9gtlHfEaYtGK+JcyN83cD7gQf5oT9YDrSlxNj6G68gbvC+hd
         wIBKoCpHn0xxf1X+Va9mHZIjHAZxtBE/FfN0VUBbhM94GMceB+dcHmesxPOd2Qt/UXer
         ZSbqan8/4p3zghFiWDxpmUOoSFVJpkWNUg4GlZhfiSEqOVRUSDXVqobTdxqkbxXFIt64
         ycfmgRhmYiwfW2Q04f5SUMX6csd48hMA9jdW5UtV9Yi+KFP5tmh1ruTy+KJK20YoP3KG
         fWn9MaVvRP8g733t7MbJEcw4r4NrkYCFXojvp8FAMlGTlEzVEG1N4TRYO0fT86dne2Cu
         4Fqw==
X-Forwarded-Encrypted: i=1; AHgh+RpyAzoDkUehPyIfLSYWyzkCbdADiox1TxJXFkxh1lVLdX6lcUTbq1Z0JNB6e5U/c/QyMPLH7/M=@vger.kernel.org
X-Gm-Message-State: AFuF++kPlNnRDdhUf55MXHcYkFQsMGmCqIPjy0h1Y/r/Tdn8lFGojDfm
	8s5OGgZOcyLzDAVVt8ky79FwXqv6oGarSPt/1YHdz1oA8xL5YnrzyMNU
X-Gm-Gg: AR+sD12eeF2pO7z6/iUOEpxpT8ouSkZky+dVVlND7l5cUDmC4FXa7Ajc1dWFeMrOkk8
	ZpC7liW0/iyarwVgzfaA9ool3FT2RSQAWIGIOV1qTiygIzLAddXhByZZkxzjHo3JrMrnm1cHrNh
	F4gF9VaRW8ELMfI3ucWcSA1JnvLufrfv39FrSj3THLsO59MYkCqGJgTj2vzIX7D6HIWcCx0K2Ai
	v7kcCN3NYM862VI/jpJbzPbWZEafgs1jDl01n9hD+vkfQAHpYrZnMr4XkpqH+yRgZtsmaT7L+fF
	ZYcyzb1++0WsayrxwuDrw6PMJHTJL9BAOHjwMWK3X1kuG28lE0AtVcdxp9wO5eUGS/GOTW7qQlI
	g/GEgichSnuKaOPA25sCcxqW/MkEhmPrzBAFWqRFs7HK4vcoVZmeRu3yLE7gK20R5yhWSmK9UYW
	XjSC/Lu1GBkZWwn98ltHx/fwJj3n9eTMaZnb4me8zm04Lpue5sYOSKI7QT9VVwyjfeQQB5lwa5s
	jzGth/7ibguO7yjFZZ5lali3zCTaeNy8FprtbCcQA==
X-Received: by 2002:a05:690c:e1c4:10b0:820:1281:8deb with SMTP id 00721157ae682-849f08113c4mr95407857b3.8.1787598859052;
        Mon, 24 Aug 2026 12:14:19 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-851e1419e0bsm16499657b3.26.2026.08.24.12.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 12:14:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:14:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Norbert Szetei <norbert@doyensec.com>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Kuan-Ting Chen <h3xrabbit@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org, 
 dev@openvswitch.org, 
 Jongmin Jang <payload.jang@gmail.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.9d29fd4385c5@gmail.com>
In-Reply-To: <c96b6c6f-1155-45d2-a117-489f1c48c8ef@ovn.org>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
 <34c64d08-0484-4f3b-b61a-ed68115d01a4@ovn.org>
 <20260821170950.3e278b1f@kernel.org>
 <86c61c39-901e-489e-aec9-fafe639276e7@ovn.org>
 <willemdebruijn.kernel.125b8a9cdc49a@gmail.com>
 <c96b6c6f-1155-45d2-a117-489f1c48c8ef@ovn.org>
Subject: Re: [PATCH net v3 0/3] net: don't strip zerocopy frag markers from a
 forwarded skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ilya Maximets wrote:
> On 8/22/26 10:55 PM, Willem de Bruijn wrote:
> > Ilya Maximets wrote:
> >> On 8/22/26 2:09 AM, Jakub Kicinski wrote:
> >>> On Fri, 21 Aug 2026 23:45:41 +0200 Ilya Maximets wrote:
> >>>> Unfortunately, this needs a rebase now that a conflicting change
> >>>> for skb_zerocopy() was merged:
> >>>
> >>> Ugh, I was supposed to merge this first, wasn't I? Sorry.
> >>
> >> Not a huge deal, I guess, the conflict is mechanical and the patches
> >> are simple.  I can take care of manual backports once we get the
> >> 'failed to apply' emails.  Just a bit of busy work.
> >>
> >>> I was hoping for Willem to TAL since skb_tx_error() is a tx ZC
> >>> thing, now I realized that he wasn't CCed :S (please do so on v4)
> >>
> >> FWIW, I CCed a few people on v1 to have a conversation about a proper
> >> fix, but that wasn't fruitful.  So, if I were Norbert, I wouldn't
> >> include them for the new versions either as doing so always feels like
> >> me being annoying. :)
> > 
> > Having a look now.
> 
> Thanks!
> 
> >  
> >> For now, the plan is to get v4 of these targeted fixes into net and
> >> stable and then remove skb_tx_error() entirely once net-next is open,
> >> as it seems to have lost all of its prior meaning.
> > 
> > The original use case in tun_net_xmit introduced in commit
> > 149d36f7187c ("tun: report orphan frags errors to zero copy callback")
> > still exists. Not sure you can remove the function entirely.
> 
> The skb_tx_error() prescribes to call kfree_skb() right after it and
> all the callers more or less do that (with the fixes applied).
> 
> skb_tx_error() does two things:
> 
> 1. skb_zcopy_downgrade_managed() that takes extra references on frags.
> 2. Calls skb_zcopy_clear(skb, true);
> 
> The kfree_skb() called right after does:
> 
>  __kfree_skb
>    skb_release_all
>      skb_release_data
>        if (skb_zcopy)
>          bool skip_unref = shinfo->flags & SKBFL_MANAGED_FRAG_REFS;
>          skb_zcopy_clear(skb, true);
>          if (skip_unref)
>            <skip unreferencing the frags, which is the same as taking
>             the extra reference>
> 
> So, unless I'm missing something, the kfree_skb() already does everything
> that skb_tx_error() does.

Good point. I agree.

> The fact that skb_tx_error() calls skb_zcopy_clear() with 'true' though
> feels weird.  I would understand the need for the function, if it was
> actually signalling the error and not success.  But you switched false
> to true in commit 1f8b977ab32d ("sock: enable MSG_ZEROCOPY") nine years
> ago and it seems like nobody complained so far...

I don't immediately recall the rationale. Probably not intentional
and I should have left the original call-sites, notably tun_net_xmit,
as is.

With MSG_ZEROCOPY, goal is to only set zerocopy_success to false if
a transmission could not be fully completed in zerocopy mode. Falling
back to copying deep in the stack is usually more expensive than doing
it from the start. And if the sendmsg otherwise succeeds, the caller
receives no other signal that MSG_ZEROCOPY is counterproductive.
skb_copy_ubufs will indeed call skb_zcopy_clear(.., false).

General transmit failures are signaled through the normal error path.
IMHO this includes allocation failure with GFP_ATOMIC.

That said, while I don't fully agree with these skb_tx_error()'s with
!zerocopy_success in the skb_orphan_frags() error paths, they did
precede my code. If we want to preserve them we would need to keep
skb_tx_error, with an extra zerocopy_success argument.


Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D92F8E91
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707970; cv=pass; b=eghGBGB37aUFnVpDHutAZKjngZjKnr/3+KK2S9GGQCuFozTY6jAixMd77tvgzCgsur1luhcGG/XzvMpbdCmK92XdRylP/1TsjNGxGW8IsU+M3P4SK+PEhpH7JCdS8arrpVAZriREnftYH4CymIACDBBViyFWND+agyNIRCiv/Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707970; c=relaxed/simple;
	bh=/Cp2A5Mzbqc8PsSDqLRTy4Axs/Bppu4NdGuANgWvMQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgzLeAfxGvdy7JYjb6pcp/x01teyABZYMPSMSUnB9y3cVoc6yfzf9EeDFRIwIkCGrkzQdj0LD5ykMZ3EDnrjPN/BXEu3fcJXzAHRzBs/xma7BbrbyT2rPOFwhijnwdJ9Ief9WxjKDl0C0M5fQkIovVDCGtzo5R4T+s4ms3L7YcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA+rGtot; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA+rGtot"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d9004a1ac0so1973385ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789707968; cv=none;
        d=google.com; s=arc-20260327;
        b=KnK4LrsQAdf6sIHvdRNtnCNyscerxTnR09uwmod0bsKlRurJ/fQu9K+Vi5qlaTnv/O
         75Cu6F854AtjQqDSYVRmZgxjJAlbVmvP88e85gMicT1BRWlWBPX8+xYsEgu4r8s005mk
         Zb/X6aWcGB6sI9dwONRHaOgAHqBnLNoED9Kjpx7rSKmt00p859A65xqZKQvP+fGxs28r
         e8hrq5a7sIJzCyd4f3ttvBFaXWyHB1Lj6y17NOjROH/F6qM6CcpFvfb16WkGoEqnxL5g
         lXRxoCtdnCqe6RJy/NPimS3jXx696w52xQbB4NBoocxLtmtMm/+FXuIBRg7zFJVVYA3I
         BAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Cp2A5Mzbqc8PsSDqLRTy4Axs/Bppu4NdGuANgWvMQs=;
        fh=k+YYNAa9M1YDFQ7NaVWcKXJKDKevIx9Xc1NTyot+sao=;
        b=oeOo5PnMVbQQ79tYP52E3ej1nCfQbv+QATOjU1mLxB1fpfKqpZWmrTJMErghHi3j7X
         VLsWCHGpQ908SvB5e2zw5ghvbAtNxqOqE8lDJ1hH9MUzNzOVs7khbuole7YjKYiyAROF
         VI1AuTpw3dcd7RSF3aD4XXGKN58T1zXOIpYsgV31djtUrQZNU0iv3gQzszSmgZobf33f
         Un8jbBwh+fZiglHeJJo8qGVfgGhZTM8xVqZ2W6xRL51Ise7kPOrAT1M29Ty8D521AxEZ
         nr7L3bh+Vb1DYcQ/9tamfkrTNbeBjXfIEsuj7g/5vwcUatwc9/gJvsnvojYzujgKsO4i
         BtPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789707968; x=1790312768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Cp2A5Mzbqc8PsSDqLRTy4Axs/Bppu4NdGuANgWvMQs=;
        b=iA+rGtotl8d9GcVlStAxuC7Fltg6SYUFpialEJOOub+AfL3XplM6/99T+RFoWPpTnV
         UkYIzZ7tdhGR4nNPKf/0ty4aJISsOZq3/QzVN8tqgh0JnyioTgPOR5pljqMy0jwWeb0Y
         2+1+FymD7jPKa1Oh5xPhNDVATwnph6U5tBQQY35yNsclAEACK2KakUN+2nIAYeEp2jon
         2O19VE0Z2MNI/uNtS5xC7i8es2Ftkm1Xk4g62V2pO9FM5ubsE61b7TotFNGeRJExVo8c
         1pXYRj7BbPH8v67e//uxidfAH8vqjpmM+hqUqCdSaK/E7H55+xrI5d9t+riTyXH36xC9
         +c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789707968; x=1790312768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Cp2A5Mzbqc8PsSDqLRTy4Axs/Bppu4NdGuANgWvMQs=;
        b=whgKgxxtvkXqyxUnmnGoUewuiFXF1MIHWvNdxx1NYiwVUsmbv4E0bkoGMYiwXSo6jM
         IWtWqRaqY6FvqyobXXlbXllVuf5KAMrFNsPFHTmYHj/ERznktoZdiUIg346G97Wsmkml
         sWVngOZFfRvmjLid7Djdbxaah9y6bq90uIyAvFAsWMkTkstQqVTeU81NNAhlpueF+CsM
         pPrFd1PH9U1IqqbXcR3i/BRiqxVIBlVFKdYzuWvfMBjGgGL5DZGzh7iYW9YCElafybB9
         hi+KZaWPdChRftDfVZhQ9jcS2Spp0c6+dme4dTU2wLsULhQh6cfcHvXvh+DoVa1fFSUT
         UyeA==
X-Gm-Message-State: AFuF++ljYnoWnL50thSrusfGZxIFPPVB9GGhp9mx22dILnAByoUNXape
	AS7Ob9x8fUkj28IzvU+uz63xhQOWU8KrBqGRNDruc+IPGThmlwlQB7jlT5r0T4/aBxe/Ts1CMjb
	mJy7jVImYYht7khZef8D9CTs2Xwr/bZk=
X-Gm-Gg: AYBFou12pv+sxaBMOFEjaPjO+kVHT98ceMLemE+vN7YsE3UjL9ZuMRhxAo8vcliXTUq
	2lCtwhI+X5Ua7/0xdYzYc+EA+cRQwsxsahavEAaAbrlzICtbL6NgVClIwE8MfAQ3slHVOa6fhkg
	/ArnAs+dLAIJyY041NykzY4nqiEkyHWyuYtpnBBElFprXiM3L14fzRSpw+NL5QNcnsiED4RAewb
	FHrX6fHv9HWK4Xi0C5qKp8noyfgVpfD50VV+Ncjpelpqs+UQYsnZK7q9lEaTw9MzLALBwOvPl6r
	hL+dMkpS5IJlHR3AvnIYFk1liW3JjDOIBd6Y+fMyZULxxcbdXg/WRJG6Se4pB4XV+8pBVjYB1oQ
	CyGMqrUj5OAITW1FlwNTQaqXYROp7hxj16iA1pMU1KaUpSlf10OjDmilu8MfjaWKd7xpYNw==
X-Received: by 2002:a17:90a:e7c9:b0:39d:f615:725e with SMTP id
 98e67ed59e1d1-39e54bc3a8emr3012402a91.13.1789707967915; Thu, 17 Sep 2026
 22:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917172050.2191062-1-dw@davidwei.uk> <CAL+tcoBpFM6MvZGPDJAH1j6aX8UaRcJLhtGbS_kRX_bQ=J5oMA@mail.gmail.com>
 <7986f36c-e95a-4083-9bdf-67c59e951b95@davidwei.uk>
In-Reply-To: <7986f36c-e95a-4083-9bdf-67c59e951b95@davidwei.uk>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 18 Sep 2026 13:05:25 +0800
X-Gm-Features: AcwNN1Wc6Z0D8hhG9hmwYuJW6QWRMRc5zx0l_MSfw-B2WCrY5Mn3LRM1nstDtxw
Message-ID: <CAL+tcoC--Hn3sL+YBKWdpJPSnJscc3qZHqfA26WRu6qUEQxOnw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: prevent stale tx timestamp keys on rtx fallback
To: David Wei <dw@davidwei.uk>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hangbin Liu <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 12:35=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2026-09-17 18:59, Jason Xing wrote:
> > On Fri, Sep 18, 2026 at 1:20=E2=80=AFAM David Wei <dw@davidwei.uk> wrot=
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
> >> Reorder the writes in tcp_tx_timestamp() and
> >> bpf_sock_ops_enable_tx_tstamp() to write the tskey first, followed by
> >> publishing tx_flags via store-release.
> >>
> >> Readers perform a symmetric load-acquire on the tx_flags, followed by =
a
> >> relaxed read of tskey.
> >>
> >> Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx que=
ue")
> >> Assisted-by: LLM
> >> Signed-off-by: David Wei <dw@davidwei.uk>
> >
> > Thanks for the work.
> >
> > Yesterday I remarked on your V1 at
> > https://lore.kernel.org/all/CAL+tcoDMR87sxJftp7T0JX-+NUz8VkXU67M3oNZy8T=
k88sDPOA@mail.gmail.com/
> >
> > I'm still doubtful if we really need to introduce this much code churn
> > just to fix the problem of this best-effort behavior. Even if the
> > patch is fixed thoroughly, it's still a best-effort attempt since
> > there are a few report points where it misses generating timestamps.
> > It has nothing to do with the patch itself, but rather the design of
> > net timestamping.
>
> Hi Jason, I saw your response yesterday but it seemed like you were
> discussing with Eric and not me. I had this code ready anyway before you

+ Willem

Oh, well, my true intention is to discuss this with all of you :)

> responded, so I sent it should Eric decide to keep 838eb9687691 and
> review this approach.
>
> If you decide to revert 838eb9687691, that is fine too and I can abandon
> this patch. The main thing for me is to prevent userspace from seeing
> underflows, but missing timestamps are okay.

I see. I'm still struggling, to be honest...

Thanks,
Jason

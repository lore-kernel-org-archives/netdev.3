Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE46326D55
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790226; cv=pass; b=EWrgHftV8nWLRxfsEeoN9QkNE/NtrEUYSu+lfX5vzbv1eMUUJ6x3cV72ZW77b3OmTwFJsRd+cQ0SQ6C3ZrBsSsrbBE8hydJUzpVGIKValGxE7CtGbw2SZ87MtxtWPgQkcDfL3EyiYrFuJwSlCI1cipNm5BXIfQNHBru102b45LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790226; c=relaxed/simple;
	bh=xJu5VGdLzP42uikYQY7fM9KVpNLhqm3NscDmCqhDH3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNaruUbBvHf7Q1xm8agKvS8zNuowAyVZyrObB83855VKK9pht9KBK9C4Fu3L3nYNok+vX9lDZNqme7UkQZFYchgbrit4i2I4f/oPlUJXfmzptXkk10RFte0Yez+HKCnBHZvnSkudlaA4AIaCBuy78c0hCbFkMBiywHbJ1wJNUMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qopIGjih; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qopIGjih"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so2089601a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 13:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785790224; cv=none;
        d=google.com; s=arc-20260327;
        b=Oq0wROTbV/t5ACSkbZcJ+wzFtO/S+S1tEyelAYXB65beKF9PJt9pD2KD18tr9W5rQU
         9Js3lRz/xBVHI7swRfGpixa/KZse996ZezCh7lT82j4lTLbctUrOT+bxKw0hlBTESvWu
         T+E/z1Q1leEx+RTmfwRXTi92uY9HTsnQAfJI88LCMb2csuEKescGMDaQwiAfqQ8Gb8Rm
         3FxtpMLMirgylKngWp0jWMkeyY7jR1TECK9o8eRUyXPKEKBFcv5Qkr9MrbI7v7m9+Kgo
         t/Z3a+018GO8bRW/Ng4ynP53xgDQVB69wQmZN4Cd8HAadvs7A6M+zS9aaxEe6OTkeBCv
         nz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ynW/hxupNz8Ms5L60j+nAftLSaxOAW4SmD2EzPIGGmU=;
        fh=DauWqXD4/roovq2RazTKY6S0bovZGQQOSKfcUZHz6gw=;
        b=GryxZHWcKpsUx7pXmvzvKnf440BVdpeRnRuvWwModDkKY4OZ0kpKSiJl5X9pOphh63
         KBdICdYO62KsUuuM8TsrcC9f19zdWR4jGg65lVPKpRgxXmnRi2f9o3RRphwb8vXL4Yjv
         6Fs4awLjJL7l27k8aBfEg7KBT9IdDnx6xcQX7iZIx6tsfuZA7fm2b4H0u5AqAT6znjcr
         pGp2irMyqtCLYnEQfWtlNveo+/7Oa24XwFMrvIIfV/g6nrXpbzITpSH1GkFO56nJhaJh
         3xJuPA44yuDwav9Y1222bZzJag1rqaKeJGAuVT/vWJbtE5bUStf0lwH2VUm2MyW0c/rc
         D3gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785790224; x=1786395024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ynW/hxupNz8Ms5L60j+nAftLSaxOAW4SmD2EzPIGGmU=;
        b=qopIGjihgOpthqDbmJH1oJilSx9Q/dWXS03VRCdfafQBChVwFW2qmtiI4PXdvUu01u
         xUjgqhBccazzNrGTFy4sEU4XJMtPbKehpEojCt8IzE19Q13UsUpgsKr/ajOgEtzULnyl
         n0qaQpyyL8XwY7tG8LBUPyq0gFVowzWAHaemAn/8rrddv36T3EBUZk7kpbSSHSxBMg2b
         5SlHI0cAYz8mddLvY+MDacsDSBx3+idYbFgawP8dMAzgKQP6NyPpyhVem/NjqcBT2xGy
         0qhxlVC3jwdSnTGA1oyf7XOD9xTVexGRPqQu14LWrDVOEdnRNw8R9WgGNFik208cG9Ha
         sooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790224; x=1786395024;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ynW/hxupNz8Ms5L60j+nAftLSaxOAW4SmD2EzPIGGmU=;
        b=quR4qPIBI39PHVkHHcE7KHXA79L68u+9o5cTM26vUEsp61y6RZK9mEwoumwFCVbeb/
         mcOnUYtvYZs3syEuJdN8LckcE1MEw3tL4RMtltF9gnT52yHJd3A6y8gUjoKppUUwUg/o
         IAPxJswW4L3TyQ1svJKDU0Pg/GrlV6SgOxdMYQgef4yhWVAadlyE/OORIjyc5VUe+1YY
         5muldA5NsW9G688hVlPEPHKQqS5bTrgTTi8F40PQK8y5MbZzxQ7S3FicvVKLunjhPQTK
         iq735KMoKVOcxq/bFnuXozsYExk0Z6fe3T6NuftK/XpBx4tqEx3x1L1tngE0nr8aBGEc
         Y25A==
X-Forwarded-Encrypted: i=1; AHgh+Rq9oLLyfi/k563HTWGAfbWOHxo+RBAabSMmY1jxDMIXvu6+BQq1GI0g4IJe26PAM/u5sPbVkLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypOtFCEbcxm2ClmEZg1Mpz2pjxMXZ9Pn043mA5LnOgRzpZAV7R
	fQ4t4eEZKFfh3zNstuZ6fpAVXVRLkpE8Hf8K8Arj557cbCZERSnPYEAdc2IiVaQIVIB3VWbMqzO
	yFaaorazVs7wtg//9HEo38eUw6NlP2PVWBGXG5+Fz
X-Gm-Gg: AR+sD11ilDleMnQcfsW1cGHeQJITpVHUw1SCZ6vAGt0LGsoSCj6/guptzp12TequvN/
	GLS18Rf04Zj+YDE2/Pd+813TRwARG7evS6WoToYQEd7INacGe1x9H0kxxr3DHxRtYUpojGLVH+P
	kmFzxmSCDyLS8dPyU19TNIjNzBThdatA37Yr+fY19zdr0lv3a8st803nUyutbH0fcrKpFCyDicG
	DfW21nmHbeApsyQTbSe9x9fIJx2n6PhaMlmRb+rfpsHrldKFYHdgPp2erwHFseUZBwyFHA+yBiJ
	AeSPyvtbjeJsJWSqhcqFXss3ShTblSFbjVr4c+qdw9ejJ11OzSrlFzlpGEJMmVYkzGXLvHsfxv0
	mqP1uvNtkhHFqlYE6VfbIBhtjJM+q6mQrA0e5GADvOXtUcb8904NPKkhrdxnHdRRpvU33LPtzE+
	tw43a6qLTuJISn
X-Received: by 2002:a17:90a:d004:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-38fbc422ab5mr11012109a91.11.1785790223617; Mon, 03 Aug 2026
 13:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725030806.28135-1-zcgao@amazon.com> <20260731174644.02410e2d@kernel.org>
 <74f99014-d09e-46ca-9c02-d10570f62fe1@redhat.com>
In-Reply-To: <74f99014-d09e-46ca-9c02-d10570f62fe1@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 3 Aug 2026 13:50:10 -0700
X-Gm-Features: AUfX_mwOTqKgKYA2F4jDgAk8KZeyAZD_4VxK7jKt2WS7aH6CHC_W0ps-dn-lweE
Message-ID: <CAAVpQUDGvmTNMYfqfU8MUcJzLfHRwFbJ7HtRbRVYsudL+gQ=EA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not change rcv_ssthresh in tcp_measure_rcv_mss()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Nathan Gao <zcgao@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 1:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 8/1/26 2:46 AM, Jakub Kicinski wrote:
> > On Fri, 24 Jul 2026 20:08:06 -0700 Nathan Gao wrote:
> >> Commit f5da7c45188e ("tcp: adjust rcvq_space after updating scaling
> >> ratio") replaced the direct window_clamp update in tcp_measure_rcv_mss=
()
> >> with a call to tcp_set_window_clamp(), a helper that implements the
> >> TCP_WINDOW_CLAMP setsockopt. As a side effect, the helper also shrinks
> >> rcv_ssthresh via __tcp_adjust_rcv_ssthresh().
> >>
> >> As a result, each scaling_ratio decrease detected by
> >> tcp_measure_rcv_mss() also cuts rcv_ssthresh. Elsewhere in TCP,
> >> rcv_ssthresh is usually cut under memory pressure and grows via
> >> tcp_grow_window().
> >>
> >> Flows whose segment sizes vary keep scaling_ratio oscillating, which
> >> leads to an unstable rcv_ssthresh: a dip of rcv_ssthresh only recovers
> >> via tcp_grow_window(), keeping the advertised window at a relatively
> >> low level even after the ratio itself has recovered, and can even stal=
l
> >> the sender.
> >>
> >> Observed on a customer's proxy gateway after upgrading from kernel 6.1
> >> to 6.12: in the worst case, rcv_ssthresh was cut in half by a
> >> scaling_ratio dip. P99 latency jumped from <10ms on 6.1 to ~100ms on
> >> 6.12, and almost returned to the 6.1 level with this patch applied.
> >>
> >> Restore the plain WRITE_ONCE() update of window_clamp, as introduced
> >> in commit a2cbb1603943 ("tcp: Update window clamping condition"), and
> >> keep the rcvq_space.space adjustment. Now rcv_ssthresh is decoupled fr=
om
> >> scaling_ratio changes in tcp_measure_rcv_mss().
> >>
> >> Fixes: f5da7c45188e ("tcp: adjust rcvq_space after updating scaling ra=
tio")
> >> Signed-off-by: Nathan Gao <zcgao@amazon.com>
> >
> > Not sure, I mean regression is a regression, but also the previous
> > behavior seems to have just been lucky rather than correct in principle=
?
> >
> > Looks like Eric and Neal are AFK, Kuniyuki, Paolo, any opinion on this
> > patch?
> A quick grep confirm that except for f5da7c45188e, only the control path
> calls tcp_set_window_clamp(), which IMHO supports this patch rationale.
> My understanding is also that this patch should not re-introduce the
> issue addressed by the blamed commit.

+1, and

>
> It would be great to have a pktdrill tests for at least one of the 2

+1.  I also told Nathan offlist that it would be nicer to write a
packetdrill test.


> relevant scenarios (the one described here and the one relevant for
> f5da7c45188e). My totally uneducated impression is that writing a packet
> drill for the case described here should be slightly less difficult than
> the other option, as there is no MTU dependency.
>
> TL;DR: I *think* this patch make sense, pktdrill would be helpful but
> not a blocker.
>
> /P
>
